From: "Kanagesh R" <kanagesh@india.com>
Subject: Re: Writeable Replacement for /dev
Date: Wed, 17 May 2006 11:36:36 +0800
Message-ID: <20060517033637.070E5CA0A6@ws5-11.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Lucas Hartmann <lucas.hartmann@gmail.com>, Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

>=20
> Hello.
>=20
> I've been using kernel 2.6.12 with the /dev pseudo filesystem activated.
> When i try to move to newer kernels, the /dev is no longer supported. This
> causes the system to hang as the kernel tries to "open an initial console=
".
>=20
> How do I set a writable tmpfs filesystem on the /dev? Is there any other
> better way of doing this?
>=20
> Using u-boot, loading kernel over tftp and root filesystem is on NFS.
>=20
> Thanks.
> -- Lucas Vinicius Hartmann
> (83) 9967-4628
>=20

Hello,

I had the same problem too, but on checking the kernel source I found that =
the support for devfs is available but just that means to turn it on using =
the menu (make menuconfig) is removed.  You need to add some lines into fs/=
Kconfig and that does the trick for you.=20=20

Check the following patch, I added this to fs/Kconfig which enabled me to t=
urn on support for devfs and compile the kernel.=20

Hope this helps!

Warm regards,
Kanagesh

diff -urN -X /home/kanagesh/work/kernel/src/dontdiff /home/kanagesh/work/ke=
rnel/src/linux-2.6.13-omap1/fs/Kconfig ./fs/Kconfig
--- /home/kanagesh/work/kernel/src/linux-2.6.13-omap1/fs/Kconfig	2005-08-29=
 05:11:01.000000000 +0530
+++ ./fs/Kconfig	2005-09-21 10:31:58.000000000 +0530
@@ -783,6 +783,56 @@
=20
 	Designers of embedded systems may wish to say N here to conserve space.
=20
+config DEVFS_FS
+	bool "/dev file system support (OBSOLETE)"
+	depends on EXPERIMENTAL
+	help
+	  This is support for devfs, a virtual file system (like /proc) which
+	  provides the file system interface to device drivers, normally found
+	  in /dev. Devfs does not depend on major and minor number
+	  allocations. Device drivers register entries in /dev which then
+	  appear automatically, which means that the system administrator does
+	  not have to create character and block special device files in the
+	  /dev directory using the mknod command (or MAKEDEV script) anymore.
+
+	  This is work in progress. If you want to use this, you *must* read
+	  the material in <file:Documentation/filesystems/devfs/>, especially
+	  the file README there.
+
+	  Note that devfs no longer manages /dev/pts!  If you are using UNIX98
+	  ptys, you will also need to mount the /dev/pts filesystem (devpts).
+
+	  Note that devfs has been obsoleted by udev,
+	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
+	  It has been stripped down to a bare minimum and is only provided for
+	  legacy installations that use its naming scheme which is
+	  unfortunately different from the names normal Linux installations
+	  use.
+
+	  If unsure, say N.
+
+config DEVFS_MOUNT
+	bool "Automatically mount at boot"
+	depends on DEVFS_FS
+	help
+	  This option appears if you have CONFIG_DEVFS_FS enabled. Setting
+	  this to 'Y' will make the kernel automatically mount devfs onto /dev
+	  when the system is booted, before the init thread is started.
+	  You can override this with the "devfs=3Dnomount" boot option.
+
+	  If unsure, say N.
+
+config DEVFS_DEBUG
+	bool "Debug devfs"
+	depends on DEVFS_FS
+	help
+	  If you say Y here, then the /dev file system code will generate
+	  debugging messages. See the file
+	  <file:Documentation/filesystems/devfs/boot-options> for more
+	  details.
+
+	  If unsure, say N.
+
 config DEVPTS_FS_XATTR
 	bool "/dev/pts Extended Attributes"
 	depends on UNIX98_PTYS




--=20
India.com free e-mail - www.india.com.=20
Check out our value-added Premium features, such as an extra 20MB for mail =
storage, POP3, e-mail forwarding, and ads-free mailboxes!
