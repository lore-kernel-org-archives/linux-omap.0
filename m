From: Omap 850 <omap850@yahoo.de>
Subject: HTC WIZARD - mmc driver problem
Date: Fri, 18 Aug 2006 10:43:54 +0200 (CEST)
Message-ID: <20060818084354.63359.qmail@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1265026488-1155890634=:61468"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

--0-1265026488-1155890634=:61468
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by bear.ext.ti.com id k7I8i81s007080


hello together,

i use the patches from nico and unaiur.

i have complied a kernel in mmc-debug mod
please see attach:  dmesg_debug_mode.txt=20

can sombody help to fix this problem ?

please see: http://linwizard.sourceforge.net/wiki/index.php/Working_toget=
her

http://sourceforge.net/projects/linwizard
http://linwizard.sourceforge.net/

thanks for help

omap850

 	=09
---------------------------------
Jetzt Mails schnell in einem Vorschaufenster =FCberfliegen. Dies und viel=
 mehr bietet das  neue Yahoo! Mail .
--0-1265026488-1155890634=:61468
Content-Type: text/plain; name="dmesg_debug_mode.txt"
Content-Description: 3756145648-dmesg_debug_mode.txt
Content-Disposition: inline; filename="dmesg_debug_mode.txt"


Linux version 2.6.16.27-omap1 (root@localhost) (gcc version 3.4.1) #3 PREEMPT Thu Aug 17 16:46:03 CEST 2006
CPU: ARM926EJ-Sid(wb) [41069263] revision 3 (ARMv5TEJ)
Machine: HTC Wizard
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 24576
  DMA zone: 24576 pages, LIFO batch:7
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Unknown OMAP cpu type: 0x00
OMAP0000 revision 1 handled as 00xx id: 0000000000000000
SRAM: Mapped pa 0x20000000 to va 0xd0000000 size: 0x32000
htc_wizard_map_io done.
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Built 1 zonelists
Kernel command line: root=/dev/ram0 init=/linuxrc
htc_wizard_init_irq.
Clocks: ARM_SYSST: 0x1040 DPLL_CTL: 0x2793 ARM_CKCTL: 0x6506
Clocking rate (xtal/DPLL1/MPU): 13.0/195.0/195.0 MHz
Total of 96 interrupts in 3 interrupt banks
OMAP730 GPIO hardware
PID hash table entries: 512 (order: 9, 8192 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 96MB = 96MB total
Memory: 94720KB available (1620K code, 350K data, 88K init)
Calibrating delay loop... 89.70 BogoMIPS (lpj=448512)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 428K
NET: Registered protocol family 16
Tornado init.
OMAP730 Watchdog seems to be activated, disabling it for now.
trying to enable USB.
unable to reset USB_EN GPIO after 20 tries.
I will try to continue anyway: USB may not be available.
USB_EN to 0 after 19 tries.
MMC host reset done: remaining tries: 100
OMAP DMA hardware version 1
DMA capabilities: 000c0000:00000000:01ff:003f:007f
Initializing OMAP McBSP system
mcbsp: could not acquire dsp_ck handle.
omapdsp: unsupported omap architecture.
USB: hmc 4, usb0 2 wires (dev)
NetWinder Floating Point Emulator V0.97 (double precision)
io scheduler noop registered
io scheduler deadline registered (default)
HTC Tornado Backlight driver.
VSFB Frame buffer driver for HTC OMAP Based Phones.
vsfb: framebuffer at 0x20001020, mapped to 0xc6800020, size 150k
Console: switching to colour frame buffer device 40x29
TI OMAP Watchdog Timer for OMAP730
HTC Tornado Vibrator driver.
HTC Tornado led driver.
RAMDISK driver initialized: 1 RAM disks of 4096K size 1024 blocksize
udc: OMAP UDC driver, version: 4 October 2004 (iso)
udc: OMAP UDC rev 3.6
udc: hmc mode 4, integrated transceiver
udc: fifo mode 3, 648 bytes not used
usb0: Ethernet Gadget, version: May Day 2005
usb0: using omap_udc, OUT ep2out-bulk IN ep1in-bulk STATUS ep3in-int
usb0: MAC aa:a0:f5:a5:2e:8f
usb0: HOST MAC 4e:2d:a6:46:26:9f
mice: PS/2 mouse device common for all mice
OMAP Keypad Driver
omap_kp_probe.
input: omap-keypad as /class/input/input0
MMC1: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0.00
NET: Registered protocol family 2
MMC1: set_ios: clock 400000Hz busmode 1 powermode 1 Vdd 0.21
MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21
MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21
MMC1: CMD0, argument 0x00000000
        MMC IRQ 0080 (CMD 0): CTO
MMC1: Command timeout, CMD0
MMC1: Response 00000000
MMC1: End request, err 1
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21
MMC1: CMD55, argument 0x00000000, CRC
        MMC IRQ 0080 (CMD 55): CTO
MMC1: Response 00000000
MMC1: End request, err 1
MMC1: CMD55, argument 0x00000000, CRC
        MMC IRQ 0080 (CMD 55): CTO
MMC1: Response 00000000
MMC1: End request, err 1
MMC1: CMD55, argument 0x00000000, CRC
        MMC IRQ 0080 (CMD 55): CTO
        MMC IRQ 0080 (CMD 55): CTO
MMC1: Response 00000000
MMC1: End request, err 1
MMC1: CMD55, argument 0x00000000, CRC
        MMC IRQ 0080 (CMD 55): CTO
        MMC IRQ 0080 (CMD 55): CTO
MMC1: Response 00000000
MMC1: End request, err 1
MMC1: CMD1, argument 0x00000000
        MMC IRQ 0080 (CMD 1): CTO
        MMC IRQ 0080 (CMD 1): CTO
MMC1: Response 00000000
MMC1: End request, err 1
MMC1: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0.00
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 88K
udc: USB reset done, gadget ether
udc: USB reset done, gadget ether
udc: USB reset done, gadget ether
udc: USB reset done, gadget ether
udc: USB reset done, gadget ether
udc: USB reset done, gadget ether
usb0: full speed config #1: 100 mA, Ethernet Gadget, using CDC Ethernet

--0-1265026488-1155890634=:61468
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--0-1265026488-1155890634=:61468--
