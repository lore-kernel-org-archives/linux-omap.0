From: =?ISO-8859-1?Q?Fr=E9d=E9ric_BEGOU?= <fbegou@sios.fr>
Subject: Re: linux omap on sdp broken?
Date: Tue, 22 Sep 2009 11:57:37 +0200
Message-ID: <4AB89F91.3030601@sios.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2e.orange.fr ([80.12.242.112]:33785 "EHLO smtp2e.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755548AbZIVJ5U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Sep 2009 05:57:20 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2e11.orange.fr (SMTP Server) with ESMTP id 3CFCA8000107
	for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2009 11:57:22 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2e11.orange.fr (SMTP Server) with ESMTP id 30B03800010B
	for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2009 11:57:22 +0200 (CEST)
Received: from [192.168.48.102] (LPuteaux-151-43-16-109.w217-128.abo.wanadoo.fr [217.128.255.109])
	by mwinf2e11.orange.fr (SMTP Server) with ESMTP id C25B98000109
	for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2009 11:57:21 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

It's working on my beagleboard with rev 52a962f from tmlind master tree.
I have integrated some patches, but would be happy to share my config if 
it helps.


U-Boot 2009.01 (Apr 29 2009 - 13:23:12)

OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
OMAP3 Beagle board + LPDDR/NAND
DRAM:  256 MB
NAND:  256 MiB
In:    serial
Out:   serial
Err:   serial
Board revision C
Serial #67fe00030000000004013f790600700b
Hit any key to stop autoboot:  0
OMAP3 beagleboard.org # setenv bootargs console=ttyS2,115200n8 noinitrd 
root=/dev/mmcblk0p2 rootfstype=ext3 rw rootdelay=1 nohz=off 
video=omapfb:vram:2M,vram:4M
OMAP3 beagleboard.org # saveenv
Saving Environment to NAND...
Erasing Nand...
Erasing at 0x260000 -- 100% complete.
Writing to Nand... done
OMAP3 beagleboard.org # boot
reading noyau.bin

1961336 bytes read
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-2.6.31-omap1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1961272 Bytes =  1.9 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing 
Linux...........................................................................................................................
Linux version 2.6.31-omap1 (build@build) (gcc version 4.3.2 (Sourcery 
G++ Lite 2008q3-72) ) #1 Mon Sep 21 18:44:30 CEST 2009
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
OMAP3430 ES3.0
SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS2,115200n8 noinitrd root=/dev/mmcblk0p2 
rootfstype=ext3 rw rootdelay=1 nohz=off video=omapfb:vram:2M,vram:4M
PID hash table entries: 1024 (order: 10, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 255744KB available (3396K code, 304K data, 120K init, 0K highmem)
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
OMAP clockevent source: GPTIMER12 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 490.52 BogoMIPS (lpj=1916928)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
NET: Registered protocol family 16
Found NAND on CS0
Registering NAND on CS0
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VMMC1: 1850 <--> 3150 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
regulator: VPLL2: 1800 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0
musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
msgmni has been set to 499
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel omap3beagle
coherent allocation too big (requested 0x200000 mask 0xffffffff)
omapfb omapfb: unable to allocate FB DMA memory
omapfb omapfb: controller initialization failed (-12)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
i2c /dev entries driver
omap2-nand driver initializing
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB 
1,8V 16-bit)
cmdlinepart partition parsing not available
Creating 6 MTD partitions on "omap2-nand":
0x000000000000-0x000000080000 : "X-Loader"
0x000000080000-0x000000260000 : "U-Boot"
0x000000260000-0x000000280000 : "U-Boot Env"
0x000000280000-0x000000680000 : "Kernel"
0x000000680000-0x000008380000 : "File System"
0x000008380000-0x000010000000 : "Applications"
usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
Registered led device: beagleboard::usr0
Registered led device: beagleboard::usr1
Registered led device: beagleboard::pmu_stat
Advanced Linux Sound Architecture Driver Version 1.0.20.
No device for DAI twl4030
No device for DAI twl4030 Voice
No device for DAI omap-mcbsp-dai-0
No device for DAI omap-mcbsp-dai-1
No device for DAI omap-mcbsp-dai-2
No device for DAI omap-mcbsp-dai-3
No device for DAI omap-mcbsp-dai-4
OMAP3 Beagle SoC init
TWL4030 Audio Codec init
asoc: twl4030 <-> omap-mcbsp-dai-0 mapping ok
ALSA device list:
  #0: omap3beagle (twl4030)
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Waiting 1sec before mounting root device...
mmc0: new high speed SD card at address b368
mmcblk0: mmc0:b368 SMI   1.85 GiB
 mmcblk0: p1 p2
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT3 FS on mmcblk0p2, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with writeback data mode.
VFS: Mounted root (ext3 filesystem) on device 179:2.
Freeing init memory: 120K
INIT: version 2.86 booting


Regards,

Fred.


