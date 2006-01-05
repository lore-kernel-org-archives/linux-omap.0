From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: 2420 H4 and kernel startup RAM error
Date: Thu, 5 Jan 2006 09:29:13 -0600
Message-ID: <520AB2AD990DC04082102F77CA172638022A2039@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Kipisz, Steven" <s-kipisz2@ti.com>, Ola Helm <ola.hel@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



>=20
> rd-jffs2 is not a ramdisk.  It is a flash file system that you write
to
> flash.  I have not looked lately, but a ramdisk would be named
something
> like rd-ext2.
Here is a quick hack way to check it - assuming you have a system with
an standard linux utility called hexdump...
hexdump filename|less=20
if u see=20
0000000 1985
This image is most probably a jffs2 image (the 1985 is a signature for
flash filesystem).

To check if it is a ramdisk,
mkdir x
mount -o loop filename x
ls x
umount x
if these commands work, it is most probably a ramdisk. Note u might need
to have root permissions/at least sudo permissions on some linux boxes
for this to work..


The boot args differ b/w using a ramdisk and using a jffs2 filesystem.
E.g.
Jffs2: setenv bootargs mem=3D32M console=3DttyS0,115200n8 noinitrd
root=3D/dev/mtdblock3 rootfstype=3Djffs2 devfs=3Dmount

Ramdisk: setenv bootargs root=3D/dev/ram0 rw mem=3D32M
console=3DttyS0,115200n8 initrd=3D0x80600000,8M ramdisk_size=3D8192

> then? And what would be the procedure of loading the images? I.e. in
> case of
> tftp it seems to be that you give addresses while loading the image
and
loadb is the command instead of tftp ( remember to use Kermit file
protocol to download the image)

> can load images one after another. But how about in case serial
loading,
> should I copy kernel image first to some address, then load RAM-image
> and
> copy it then to some address (0x80600000 perhaps?).
>=20
Quick way
loadb 0xXYZ
Where XYZ is the address e.g. 0x80600000

Regards,
Nishanth Menon
