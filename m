From: "Sideleau, Scott R" <srs@WPI.EDU>
Subject: RE: Can't Boot - OSK Frame Buffer Support in Kernel 2.6.18-omap1
Date: Sat, 7 Oct 2006 11:01:47 -0400
Message-ID: <CC7B089C59ED6841BAE28F1EA69A8543873738@EXCHDB.admin.wpi.edu>
References: <45274A7A.4000707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <45274A7A.4000707@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello,

Thanks again for any help/advice offered thus far.

Jonathan McDowell [noodles@earth.li] wrote...
> OOI do you have CONFIG_DEBUG_MUTEXES set?

I don't see that option in my .config at all, so it is not enabled.

Dirk Behme [dirk.behme@googlemail.com] wrote...
> For easier debugging, I propose to first use uncompressed=20
> image (the manuals seem to use compressed one):

I re-built an uncompressed binary, at your recommendation.  After =
copying
this to the OSK, I was able to successfully boot to a point.  It was =
pointed
out to me that I would need to mount the rootfs to get it to boot any
further.

My uncompressed kernel image was 2.2-MB (2278208 bytes).  It was written =
to
flash at memory location 0x00040000 on the OSK.  That means the kernel =
ends
(after some hex arithmetic) at 0x0022c340.  It seems to make sense to =
me,
then, that I could drop the rootfs at 0x0022c341 since it is supposed to
start at 0x00240000 anyway.

I wrapped up a JFFS2 rootfs weighing in at 5.2-MB (5242880 bytes) and =
dropped
it in memory location 0x0022c341 on the OSK.  The OSK boots a little bit
further this time, but is giving some more errors I don't really =
understand.
Output is as follows:

=3D=3D=3D=3D=3D
U-Boot 1.1.4 (Aug 29 2006 - 17:05:48)

CPU:   OMAP162123 at 96.0 MHz (DPLL1=3D96.0 MHz)
Board: OSK5912
DRAM:  32 MB
Flash: 32 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
## Booting image at 00040000 ...
   Image Name:   Linux Kernel Image
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2278144 Bytes =3D  2.2 MB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Linux version 2.6.18-omap1 (bigd0g@porkchop) (gcc version 4.1.1) #1 =
PREEMPT
Sat Oct 7 13:08:54 IST 2006
CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=3D00053177
Machine: TI-OSK
Memory policy: ECC disabled, Data cache writeback
OMAP162123 revision 2 handled as 16xx id: e4059089bfcb0c11
SRAM: Mapped pa 0x20000000 to va 0xd0000000 size: 0x100000
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Built 1 zonelists.  Total pages: 8192
Kernel command line: console=3DttyS0,115200 noinitrd rw ip=3Don =
rootfstype=3Djffs2
root=3D/dev/mtdblock3
Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x2000
Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
Total of 128 interrupts in 4 interrupt banks
OMAP GPIO hardware version 1.0
MUX: initialized M7_1610_GPIO62
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB =3D 32MB total
Memory: 30092KB available (1816K code, 394K data, 104K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
MUX: initialized P20_1610_GPIO4
OMAP DMA hardware version 1
DMA capabilities: 000c0000:00000000:01ff:003f:007f
Initializing OMAP McBSP system
omap_dsp_init() done
USB: hmc 16, usb0 2 wires
i2c_omap i2c_omap.1: bus 0 rev2.2 at 100 kHz
tps65010: version 2 May 2005
No IRQF_TRIGGER set_type function for IRQ 353 (MPUIO)
tps65010: battery charging
NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 1024 bind 512)
TCP reno registered
Power Management for TI OMAP.
MUX: initialized T20_1610_LOW_PWR
Unbalanced enable for IRQ 10
BUG: warning at kernel/irq/manage.c:118/enable_irq()
NetWinder Floating Point Emulator V0.97 (double precision)
OMAP OCPI interconnect driver loaded
dsp dsp: OMAP DSP driver initialization
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
omapfb: configured for panel osk
omapfb: LCDC initialized
omapfb omapfb: Pixel clock divider value is obsolete.
Try to set pixel_clock to 8000 and pcd to 0 in =
drivers/video/omap/lcd_osk.c
and submit a patch.
MUX: initialized PWL
Console: switching to colour frame buffer device 30x40
omapfb: Framebuffer initialized. Total vram 155648 planes 1
omapfb: Pixclock 8000 kHz hfreq 20.1 kHz vfreq 63.3 Hz
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
disabled
serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq =3D 46) is a ST16654
RAMDISK driver initialized: 1 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
i2c /dev entries driver
Clock enabled to MCBSP1 & 3
TLV320AIC23 I2C version 1.8 (10-Feb-2006)
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank

omapflash.0: Found 1 x16 devices at 0x1000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00020000 : "bootloader"
0x00020000-0x00040000 : "params"
0x00040000-0x00240000 : "kernel"
0x00240000-0x02000000 : "filesystem"
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
IP-Config: No network devices available.
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000023c: =
0x8214
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000244: =
0x86ac
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000248: =
0x8ad8
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000024c: =
0x86c0
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000250: =
0x8c84
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000254: =
0x0002
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000258: =
0x0400
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000025c: =
0x8514
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000264: =
0x8bb0
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000268: =
0x8574
instead
Further such events for this erase block will not be printed
Empty flash at 0x0000059c ends at 0x000005a0
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020000: =
0x0a73
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020004: =
0x5f66
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020008: =
0x665f
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0002000c: =
0x540a
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020010: =
0xd1e6
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020014: =
0xc766
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020018: =
0xaa54
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0002001c: =
0xd666
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020020: =
0x0b73
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020024: =
0xad64
instead
Further such events for this erase block will not be printed
Cowardly refusing to erase blocks on filesystem with no valid JFFS2 =
nodes
empty_blocks 236, bad_blocks 0, c->nr_blocks 238
VFS: No root yet, retrying to mount root on mtdblock3 =
(unknown-block(31,3))
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000023c: =
0x8214
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000244: =
0x86ac
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000248: =
0x8ad8
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000024c: =
0x86c0
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000250: =
0x8c84
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000254: =
0x0002
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000258: =
0x0400
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000025c: =
0x8514
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000264: =
0x8bb0
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000268: =
0x8574
instead
Further such events for this erase block will not be printed
Empty flash at 0x0000059c ends at 0x000005a0
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020000: =
0x0a73
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020004: =
0x5f66
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020008: =
0x665f
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0002000c: =
0x540a
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020010: =
0xd1e6
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020014: =
0xc766
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020018: =
0xaa54
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0002001c: =
0xd666
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020020: =
0x0b73
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020024: =
0xad64
instead
Further such events for this erase block will not be printed
Cowardly refusing to erase blocks on filesystem with no valid JFFS2 =
nodes
empty_blocks 236, bad_blocks 0, c->nr_blocks 238
VFS: No root yet, retrying to mount root on mtdblock3 =
(unknown-block(31,3))
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000023c: =
0x8214
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000244: =
0x86ac
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000248: =
0x8ad8
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000024c: =
0x86c0
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000250: =
0x8c84
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000254: =
0x0002
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000258: =
0x0400
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000025c: =
0x8514
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000264: =
0x8bb0
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000268: =
0x8574
instead
Further such events for this erase block will not be printed
Empty flash at 0x0000059c ends at 0x000005a0
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020000: =
0x0a73
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020004: =
0x5f66
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020008: =
0x665f
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0002000c: =
0x540a
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020010: =
0xd1e6
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020014: =
0xc766
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020018: =
0xaa54
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0002001c: =
0xd666
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020020: =
0x0b73
instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020024: =
0xad64
instead
Further such events for this erase block will not be printed
Cowardly refusing to erase blocks on filesystem with no valid JFFS2 =
nodes
empty_blocks 236, bad_blocks 0, c->nr_blocks 238
VFS: No root yet, retrying to mount root on mtdblock3 =
(unknown-block(31,3))
=3D=3D=3D=3D=3D

Any ideas?  Thanks, in advance.
______________________________________________
Scott R. Sideleau
ECE '07, Worcester Polytechnic Institute
@ MQP Ireland A'06, University of Limerick
+353 61-307310 / srs@wpi.edu
=20
