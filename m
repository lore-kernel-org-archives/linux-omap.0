From: <sathish.madhava@wipro.com>
Subject: How to implement JFFS2 filesystem on NAND
Date: Mon, 7 May 2007 16:18:59 +0530
Message-ID: <42E999AD7A0E4647BF159F467EE4FBCB017B50DF@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

=20

I want to implement JFFS2 file system on NAND on OMAP2430SDP board and
have some problems in getting it right.

=20

I have done the following.

1. Used X-Loader 1.40 and UBoot 1.1.3 on NAND. (There is no problem for
me to boot X-loader and UBOOT)

Did as suggested at http://linux.omap.com/pub/xloader/2430sdp/

=20

2. Used mkfs.jffs2 utility to create jffs2.img

=20

3. tftp'ed jffs2.img to 0x80100000 and then used "nand write.jffs2" to
write the img at 0x002b0000 in NAND

=20

4. gave the boot arguments as below

=20

setenv bootargs console=3DttyS0,115200n8 root=3D/dev/mtdblock12
rootfstype=3Djffs2

=20

5. Compiled 2.6 Kernel and tftp'ed to 0x80100000 and then gave "bootm"

=20

But when the kernel Boots UP it gives me the below debug message and
then stops

=20

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++

VFS: Mounted root (jffs2 filesystem).

Freeing init memory: 124K

Warning: unable to open an initial console.

/sbin/init exit code: -2

/etc/init exit code: -2

/bin/init exit code: -2

/bin/sh exit code: -2

Kernel panic - not syncing: No init found.  Try passing init=3D option =
to
kernel.

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++

=20

When I give the boot arguments as below:

setenv bootargs console=3DttyS0,115200n8 noinitrd root=3D/dev/nfs rw
nfsroot=3Dxx.xxx.x.xx:/rootfs nolock

=20

the kernel comes up fine.

=20

Can somebody suggest me some tips.

=20

Thanks=20

-Sathish

=20

=20

=20
