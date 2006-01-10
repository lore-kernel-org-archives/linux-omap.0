From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: 2420 H4 and kernel startup RAM error
Date: Tue, 10 Jan 2006 10:05:51 -0600
Message-ID: <520AB2AD990DC04082102F77CA1726380236AE15@dlee03.ent.ti.com>
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
To: Ola Helm <ola.hel@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

There seems to be two issues here.=20
1. booting a kernel from flash
2. Using a jffs2 partition

MTD Toolchain:
The latest MTD tree in infradead uses something called as EBH (Erase
Block Header). This, till I last saw it(a month or so back), was
incompatible with JFFS2 cleanmarkers. U could check the infradead site
to pick up the last known JFFS2 support (I think July or so last year).
Just ensure that you have the kernel's mtd matching with the mtd utils
you are using.

Ref: http://www.linux-mtd.infradead.org/source.html=20

Here is what I used to do:
1. booting from flash
make uImage
from uboot:
tftp 0x80000000 xyz.uImg
This shows how many bytes have been downloaded. Check if this is less
than 0x00200000. If the downloaded image is greater than this, the
partition size defn in kernel nor mapping need modification. (I am
assuming the Nor flash base address to be still 0x04000000 on H4).
protect off 0x04040000 0x0423ffff
erase 0x04040000 0x0423ffff
cp.b 0x80000000 0x04040000 0x00200000

run printenv and ensure that the bootargs is proper.

Now try 'bootm 0x04040000'
The kernel should bootup. If this does not then this could be a problem
with the git code base we have.

2. jffs2 file system in flash
a) Using a filesystem in a tar ball.
Once you boot, using say NFS, run the following:
./flash_eraseall -j /dev/mtd/3
mount -t jffs2 /dev/mtdblock/3 /mnt
cd /mnt
tar -xvzf ../FileSystem.tgz
cd
umount /mnt

b) using mkfs
(from Komal's mail)
mkfs.jffs2 -v --eraseblock=3D128KiB -l --root=3D$(ROOTFSDIR) -o
$(IMAGEDIR)/rd-jffs2.bin
Once you boot, using say NFS, run the following:
./flash_eraseall /dev/mtd/3
(there is no need for a -j as the mkfs would have created the clean
markers where required).
cat rd-jffs2.bin>/dev/mtd/3
mount -t jffs2 /dev/mtdblock/3 /mnt
ls /mnt
umount /mnt

(NOTE: The umount might take a short while while the GC thread finishes
off its work).
(reboot)
For uboot prompt:
setenv bootargs mem=3D32M console=3DttyS0,115200n8 noinitrd
root=3D/dev/mtdblock3 rootfstype=3Djffs2 devfs=3Dmount

bootm..

Regards,
Nishanth Menon
