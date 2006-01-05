From: Ola Helm <ola.hel@gmail.com>
Subject: 2420 H4 and kernel startup RAM error
Date: Thu, 5 Jan 2006 12:12:02 +0200
Message-ID: <3d3153f60601050212x24ad061bhbc77d5a08e686af9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I have followed the instructions of documents
UBoot for the OMAP 16xx GSM/GPRS Software Development Platfrom
H2Setup.txt

while loading kernel to board and booting it up.

I have tried both to erase 0x4000000 0x417FFFF and load with file size
0x1222e0, source address 0x80000000 and destination address 0x4040000 i.e

cp.b 0x80000000 0x4040000 1222e0

and also not to do this but just directly boot the kernel. Copying and eras=
e
goes well but in both cases the problem is that in bootup kernel reports
that it does not find proper RAM. It's bit weird since it does seem to
handle and see RAM properly in previous steps.

Are the addresses in setup correct or could this be about some switches? Or
is there some other process for 2420?

(Booting printout)

## Booting image at 80000000 ...

   Image Name:   Linux-2.6.9-omap1

   Image Type:   ARM Linux Kernel Image (uncompressed)

   Data Size:    1188516 Bytes =3D  1.1 MB

   Load Address: 80008000

   Entry Point:  80008000

   Verifying Checksum ... OK

OK

Starting kernel ...

Uncompressing
Linux......................................................................=
...........
done, booting the kernel.

Linux version 2.6.9-omap1 (stevej@omap-linux2) (gcc version 3.4.0 20040409
(CodeSourcery ARM Q1A 2004)) #1 Wed Aug 17 20:06:20 CDT 2005

CPU: TI OMAP2420 (ARM1136JF-S) [4107b362] revision 2 (ARMv6TEJ)

CPU: D VIPT write-back cache

CPU: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets

CPU: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets

Machine: OMAP24xx H4

Memory policy: ECC disabled, Data cache writeback

TI H4 SDP Base Board with OMAP2420 Menelaus Daughter Board

Built 1 zonelists

Kernel command line: root=3D/dev/ram0 rw mem=3D32M console=3DttyS0,115200n8
initrd=3D0x80600000,8M ramdisk_size=3D8192

PID hash table entries: 256 (order: 8, 4096 bytes)

Console: colour dummy device 80x30

Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)

Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)

Memory: 32MB =3D 32MB total

Memory: 21632KB available (1952K code, 530K data, 104K init)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

checking if image is initramfs...it isn't (ungzip failed); looks like an
initrd

Freeing initrd memory: 8192K

NET: Registered protocol family 16

USB: hmc 0, usb0 3 wires (dev), Mini-AB on usb0

usbcore: registered new driver usbfs

usbcore: registered new driver hub

NET: Registered protocol family 23

Checking V6 block cache operations:

           Prefetch data range: supported

   Clean+Invalidate data range: supported

              Clean data range: supported

         Invalidate data range: supported

        Invalidate instr range: supported

 --> Using harvard block cache invalidate

 --> Using block cache clean

 --> Using block cache clean+invalidate (cache aliasing)

OMAP DMA4 hardware Initialized (max lch=3D32)

OMAP virtual buses initialized

OMAP GPIO hardware version 1.8

Power Management for TI OMAP.

NetWinder Floating Point Emulator V0.97 (double precision)

devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)

devfs: boot_options: 0x1

JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.

omap24xxfb: timeout waiting for display controller reset

Console: switching to colour frame buffer device 30x40

omap24xxfb: fb0 frame buffer device

omap24xxfb: OMAP24xx display controller hardware rev 2.0

omap24xxfb: display mode 240x320x16 hsync 16kHz vsync 48Hz

omap_wdt: TI OMAP Watchdog Timer: timer margin 10000 sec

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled

wait_for_clock: wait count is i =3D 0 for dev 22

ttyS0 at MMIO 0xd806a000 (irq =3D 72) is a OMAP UART

wait_for_clock: wait count is i =3D 0 for dev 21

ttyS1 at MMIO 0xd806c000 (irq =3D 73) is a OMAP UART

wait_for_clock: wait count is i =3D 0 for dev 21

wait_for_clock: wait count is i =3D 0 for dev 44

ttyS2 at MMIO 0xd806e000 (irq =3D 74) is a OMAP UART

wait_for_clock: wait count is i =3D 0 for dev 44

OMAP serial: activated 3 ports

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

loop: loaded (max 8 devices)

smc91x.c: v1.0, mar 07 2003 by Nicolas Pitre <nico@cam.org>

eth0: SMC91C94 (rev 9) at 0xc2854300 IRQ 188 [nowait]

eth0: Ethernet addr: 00:50:c2:42:b1:ab

i2c /dev entries driver

i2c-omap24xx-1: I2C bus controller at 0x48070000, irq 56, registered as
i2c-0

i2c-omap24xx-2: I2C bus controller at 0x48072000, irq 57, registered as
i2c-1

ADAPTER ID IS 0

ADAPTER ID IS 1

isp1301_omap 0-002d: chiprev 2.00, driver 24 August 2004

 OMAP Timer32K is initialized

Linux video capture interface: v1.00

Registering OMAP device 'omap24xxcam0'. Parent at l3

OV9640 sensor chip version 0x49 detected

Sensor is OV9640

omap24xxcam: registered device video0 [v4l2]

Initializing OMAP McBSP system for OMAP 242X

SPI Module init

Using anticipatory io scheduler

OMAP NOR FLASH: MTD Self-Contained Driver ver. 1.0 size=3D0x67108864lx

OMAP NOR FLASH: Intel 28F256L18T found at 0xc2880000

Creating 4 MTD partitions on "OMAP NOR FLASH":

0x00000000-0x00020000 : "bootloader"

0x00020000-0x00040000 : "params"

0x00040000-0x00240000 : "kernel"

0x00240000-0x04000000 : "file system"

ohci ohci: at 0xd805e000, irq 78

ohci ohci: new USB bus registered, assigned bus number 1

hub 1-0:1.0: USB hub found

hub 1-0:1.0: 3 ports detected

usbcore: registered new driver usbtest

udc: OMAP UDC driver, version: 4 October 2004 (iso) (dma)

udc: OMAP UDC rev 6.1, Mini-AB

udc: hmc mode 0, transceiver isp1301_omap

udc: fifo mode 3, 392 bytes not used

zero gadget: Gadget Zero, version: St Patrick's Day 2004

zero gadget: using omap_udc, OUT ep2out-bulk IN ep1in-bulk

otg: b_idle, SWITCH to gadget, ctrl 178021

isp1301_omap 0-002d: ready for dual-role USB ...

mice: PS/2 mouse device common for all mice

ts: Compaq touchscreen protocol output

OMAP24xx Keypad Driver

Registering OMAP device 'omap-mmc2'. Parent at l4

enable_irq(225) unbalanced from c016d300

OMAP242X TSC2101 Audio support initialized

NET: Registered protocol family 2

IP: routing cache hash table of 512 buckets, 4Kbytes

TCP: Hash tables configured (established 2048 bind 4096)

NET: Registered protocol family 1

NET: Registered protocol family 17

VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2

udc: USB reset done, gadget zero

udc: USB reset done, gadget zero

udc: USB reset done, gadget zero

mmcblk0: mmc0:0001 D0601  125440KiB

 /dev/mmc/blk0: unknown partition table

RAMDISK: Couldn't find valid RAM disk image starting at 0.
 Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)

/O
