From: Ram <vshrirama@gmail.com>
Subject: Re: Subject: [PATCH 3/3] [ARM] OMAP: Adding Support for 2K nand
	page support on omap2430
Date: Sun, 29 Jul 2007 20:48:22 +0530
Message-ID: <8bf247760707290818v5706b378t9d60b6ae51a03624@mail.gmail.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6AF@ntxsjombx02.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <809D758398CC1F49AA8E493528AD4A27014DF6AF@ntxsjombx02.micron.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi shahrom,

Thanks for the patches. Tested the patches on a custom built OMAP2430
with Micron Nand Flash MT29F1GXXABB - A 16 bit nand flash.

I am getting CRC issues during read. I have tested this on 2 different boar=
ds.
But i get the same kind of messages.

I am using a OMAP2430 POP with micron nand flash.

What is the part-number of the micron nand chip youre using?.

Is youre nand device an external nand chip or a OMAP2430 POP?

Does this really matter?

Please do advice.


Regards,
sriram

Memory policy: ECC disabled, Data cache writeback
OMAP24302
SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0x100000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists.  Total pages: 16256
Kernel command line: console=3DttyS0,115200n8 root=3D/dev/mtdblock4
rootfstype=3Djffs2 noinitrd
Clocking rate (Crystal/DPLL/MPU): 12.0/532/266 MHz
clock.c: Enable for dpll_ck without enable code
GPMC revision 3.0
IRQ: Found an INTC at 0xd80fe000 (revision 3.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP243x GPIO hardware version 2.4
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB 0MB =3D 64MB total
Memory: 62640KB available (1892K code, 232K data, 100K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NAND: Found NAND on CS 0
OMAP DMA hardware revision 4.0
Initializing OMAP McBSP system
omapdsp: could not acquire dsp_fck handle.
USB: No board-specific platform config found
i2c_omap i2c_omap.2: bus 2 rev3.7 at 2600 kHz
i2c_omap i2c_omap.1: bus 1 rev3.7 at 400 kHz
TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1]
TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]
TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1]
TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1]
<6>TWL4030: Driver registration complete.
NetWinder Floating Point Emulator V0.97 (double precision)
Time: gp timer clocksource has been installed.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) =C2(c) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel sdp2430
omapfb: DISPC version 3.0 initialized
Console: switching to colour frame buffer device 30x40
omapfb: Framebuffer initialized. Total vram 155648 planes 1
omapfb: Pixclock 4000 kHz hfreq 14.0 kHz vfreq 42.5 Hz
omap_rng omap_rng: OMAP Random Number Generator ver. 50
OMAP Watchdog Timer Rev 0x22: initial timeout 60 sec
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x4806e000 (irq =3D 74) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: module loaded
i2c /dev entries driver
TWL4030 GPIO Demux: IRQ Range 376 to 386, Initialization Success
omap2-nand driver initializing
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xb1 (Micron NAND 128MiB
1,8V 16-bit)
Creating 5 MTD partitions on "omap2-nand":
0x00000000-0x00080000 : "X-Loader"
0x00080000-0x00100000 : "U-Boot"
0x00100000-0x00140000 : "U-Boot Environment"
0x00140000-0x00540000 : "Kernel"
0x00540000-0x08000000 : "File System"
input: omap_twl4030keypad as /class/input/input0
Power Management for OMAP2 initializing
PRCM revision 1.0
mtd->read(0x1f9c8 bytes from 0xbc0638) returned ECC error
mtd->read(0x12d2c bytes from 0xbcd2d4) returned ECC error
Empty flash at 0x00bcd2d0 ends at 0x00bcd800
mtd->read(0x2a4 bytes from 0xbd655c) returned ECC error
mtd->read(0x7bc bytes from 0xbcd844) returned ECC error
VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 100K
Please press Enter to activate this console. mtd->read(0x24c bytes
from 0xbd5db4) returned ECC error
mtd->read(0xf3 bytes from 0xbdf800) returned ECC error
JFFS2 notice: (196) check_node_data: wrong data CRC in data node at
0x00bdf800: read 0xd6de9ecd, calculated 0x7694332c.
mtd->read(0x517 bytes from 0xbd6000) returned ECC error


Processing /etc/profile... Done

[root@OMAP2430_ALPHA /]#mtd->read(0x464 bytes from 0xbd5b9c) returned ECC e=
rror
mtd->read(0x60 bytes from 0xbd4fa0) returned ECC error
mtd->read(0xf4 bytes from 0xbd3f0c) returned ECC error
mtd->read(0x2c8 bytes from 0xbd3538) returned ECC error
mtd->read(0x4fc bytes from 0xbd2304) returned ECC error
mtd->read(0x6a8 bytes from 0xbd1958) returned ECC error
mtd->read(0x7c bytes from 0xbd0f84) returned ECC error
mtd->read(0x17c bytes from 0xbd0684) returned ECC error
mtd->read(0x374 bytes from 0xbcfc8c) returned ECC error
mtd->read(0x5c4 bytes from 0xbcf23c) returned ECC error
mtd->read(0x7e0 bytes from 0xbce820) returned ECC error
mtd->read(0x7d4 bytes from 0xbce02c) returned ECC error
mtd->read(0x790 bytes from 0xbcd870) returned ECC error
mtd->read(0x800 bytes from 0xbcd800) returned ECC error
mtd->read(0x810 bytes from 0xbdeff0) returned ECC error
mtd->read(0x260 bytes from 0xbde5a0) returned ECC error
mtd->read(0x1c8 bytes from 0xbdde38) returned ECC error
mtd->read(0x128 bytes from 0xbdd6d8) returned ECC error
mtd->read(0x324 bytes from 0xbdccdc) returned ECC error
mtd->read(0x54c bytes from 0xbdbab4) returned ECC error
mtd->read(0xfc bytes from 0xbda704) returned ECC error
mtd->read(0x280 bytes from 0xbd9d80) returned ECC error
mtd->read(0x644 bytes from 0xbd89bc) returned ECC error
mtd->read(0x30 bytes from 0xbd7fd0) returned ECC error
mtd->read(0x800 bytes from 0xbd8000) returned ECC error
mtd->read(0x298 bytes from 0xbd7568) returned ECC error
mtd->read(0x2d0 bytes from 0xbd6d30) returned ECC error
mtd->read(0x278 bytes from 0xbd6588) returned ECC error
