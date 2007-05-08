From: <sathish.madhava@wipro.com>
Subject: FW: How to implement JFFS2 filesystem on NAND
Date: Tue, 8 May 2007 17:15:19 +0530
Message-ID: <42E999AD7A0E4647BF159F467EE4FBCB017B50F5@BLR-SGM-MSG01.wipro.com>
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
List-Id: linux-omap@vger.kernel.org

Hi,
I changed my rootfs.

But now I am getting the error message as below.

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00088024:
0xcf4e instead
Further such events for this erase block will not be printed
VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 124K
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
And it stops here.

I have included console in my /dev.

How to go about it now.

-sathish


-----Original Message-----
From: Woodruff, Richard [mailto:r-woodruff2@ti.com]=20
Sent: Monday, May 07, 2007 5:31 PM
To: Sathish kumar tekal Sethu madhava rao (WT01 - MCE-Mobile Devices);
linux-omap-open-source@linux.omap.com
Cc: linux-mtd@lists.infradead.org
Subject: RE: How to implement JFFS2 filesystem on NAND

>=20
> VFS: Mounted root (jffs2 filesystem).
>=20
> Freeing init memory: 124K
>=20
> Warning: unable to open an initial console.
>=20
> /sbin/init exit code: -2
>=20
> /etc/init exit code: -2
>=20
> /bin/init exit code: -2
>=20
> /bin/sh exit code: -2
>=20
> Kernel panic - not syncing: No init found.  Try passing init=3D option
to
> kernel.

Looks like your file system has no device nodes in /dev.

For older kernels devfs would allow this to work.  On newer ones you
need all your nodes, or a properly configured udev, and some hotplug
support.

Regards,
Richard W.


The information contained in this electronic message and any attachments
to this message are intended for the exclusive use of the addressee(s)
and may contain proprietary, confidential or privileged information. If
you are not the intended recipient, you should not disseminate,
distribute or copy this e-mail. Please notify the sender immediately and
destroy all copies of this message and any attachments.=20

WARNING: Computer viruses can be transmitted via email. The recipient
should check this email and any attachments for the presence of viruses.
The company accepts no liability for any damage caused by any virus
transmitted by this email.
=20
www.wipro.com

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
