From: Ola Helm <ola.hel@gmail.com>
Subject: Re: 2420 H4 and kernel startup RAM error
Date: Tue, 10 Jan 2006 16:05:15 +0200
Message-ID: <3d3153f60601100605p36bc331y971958e446e1d476@mail.gmail.com>
References: <520AB2AD990DC04082102F77CA172638022A2039@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA172638022A2039@dlee03.ent.ti.com>
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
To: "Menon, Nishanth" <x0nishan@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I got the RAMdisk setup working as adviced. Thanks to all for help.

Then I tried the JFFS but again faced problems. I continue it here though
the heading is not quite correct anymore..


> The boot args differ b/w using a ramdisk and using a jffs2 filesystem.
> E.g.
> Jffs2: setenv bootargs mem=3D32M console=3DttyS0,115200n8 noinitrd
> root=3D/dev/mtdblock3 rootfstype=3Djffs2 devfs=3Dmount



I changed the args, loaded kernel and copied it to 0x04040000 (bank 1:2-11)
and loaded jffs binary and copied it to 0x04180000. Then booted from
0x04040000 but did not work. Tried also to just copy the kernel etc. but
ended up with dead end. I Think I'm copying the kernel and jfss-file to
wrong place but I don't know the right place either. So to put shortly: nee=
d
knowledge about correct addresses to erase & copy kernel and jffs for
permanent usage.

Following contains extracts from printout after kernel booting. Please do
ask if you consider needing the whole printout

-------------------------------

Kernel command line: mem=3D32M console=3DttyS0,115200n8 noinitrd
root=3D/dev/mtdblock3 rw rootfstype=3Djffs2 devfs=3Dmount

-------------------------
Creating 4 MTD partitions on "OMAP NOR FLASH":

0x00000000-0x00020000 : "bootloader"

0x00020000-0x00040000 : "params"

0x00040000-0x00240000 : "kernel"

0x00240000-0x04000000 : "file system"
-----------

 /dev/mmc/blk0: unknown partition table

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
0x0098 instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000004:
0x0099 instead


-----------------------


Empty flash at 0x000088b0 ends at 0x000088b4

Empty flash at 0x000088b8 ends at 0x000088bc

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01dc0000:
0xfffe instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01dc0004:
0x0004 instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01dc0008:
0x0008 instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01dc000c:
0x000c instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01dc0010:
0x0010 instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01dc0014:
0x0014 instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01dc0018:
0x0018 instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01dc001c:
0x001c instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01dc0020:
0x0020 instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01dc0024:
0x0024 instead

Further such events for this erase block will not be printed

Old JFFS2 bitmask found at 0x01dc1984

You cannot use older JFFS2 filesystems with newer kernels

Old JFFS2 bitmask found at 0x01dd1984

You cannot use older JFFS2 filesystems with newer kernels

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01de0004:
0x0004 instead

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01de0008:
0x0008 instead

---------------------------------
