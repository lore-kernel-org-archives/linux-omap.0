From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: State of LDP3430 platform
Date: Mon, 6 Dec 2010 12:55:26 +0000
Message-ID: <20101206125526.GC31777@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48696 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab0LFMzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 07:55:35 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

As previously requested.

The following is the behaviour of the latest mainline kernel on the LDP3430
platform.

------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1185 _omap_hwmod_enable+0x34/0x114()
omap_hwmod: wd_timer2: enabled state can only be entered from initialized, idle, or disabled state
Modules linked in:
---[ end trace 1b75b31a2719ed1c ]---
wd_timer2: Could not enable clocks for omap2_disable_wdt
...
Waiting 2sec before mounting root device...
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SD card at address 0002
mmcblk0: mmc0:0002 00000 971 MiB
 mmcblk0: p1 p2
EXT3-fs: barriers not enabled
mmcblk0: retrying using single block read
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): warning: mounting fs with errors, running e2fsck is recommended
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): recovery complete
EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
Freeing init memory: 144K
mmcblk0: retrying using single block read
INIT: version 2.86 booting
mmcblk0: retrying using single block read
modprobe: FATAL: Could not load /lib/modules/2.6.37-rc4+/modules.dep: No such file or directory

Error opening /dev/fb0: No such device
.udev/ already exists on the static /dev!
Starting the hotplug events dispatcher udevd
udevd (429): /proc/429/oom_adj is deprecated, please use /proc/429/oom_score_adj instead.
mmcblk0: retrying using single block read
mmcblk0: retrying using single block read
Synthesizing the initial hotplug events
<spontaneous reboot>

My guess is it's the watchdog which hwmod apparantly can't deal with.
Note also LDP framebuffer doesn't appear to work in this configuration:

CONFIG_OMAP2_VRAM=y
CONFIG_OMAP2_VRFB=y
CONFIG_OMAP2_DSS=y
CONFIG_OMAP2_VRAM_SIZE=2
CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS=y
CONFIG_OMAP2_DSS_DPI=y
# CONFIG_OMAP2_DSS_RFBI is not set
CONFIG_OMAP2_DSS_VENC=y
# CONFIG_OMAP2_DSS_SDI is not set
# CONFIG_OMAP2_DSS_DSI is not set
# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
CONFIG_FB_OMAP2=y
CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
CONFIG_FB_OMAP2_NUM_FBS=3

#
# OMAP2/3 Display Device Drivers
#
CONFIG_PANEL_GENERIC=y
CONFIG_PANEL_SHARP_LS037V7DW01=m

With the FB_OMAP driver, it looks like the screen isn't being correctly
driven - the openhand logo appears in outline with green splodges in
places (but unfortunately, because of the reboot, it doesn't stay there
for long enough to get a photo of it.)


Full boot messages below (with FB_OMAP2):

Texas Instruments X-Loader 1.41mmc
Starting OS Bootloader from NAND ...


U-Boot 1.1.4 (May 19 2008 - 14:27:52)

OMAP3430-GP rev 2, CPU-OPP2 L3-133MHz
OMAP3430LAB 0.1 Version + mDDR (Boot NAND)
DRAM:  128 MB
NAND:256 MiB
In:    serial
Out:   serial
Err:   serial
Battery levels: main 3863 mV, backup 2394 mV
LAN9x18 (0x92110000) detected.
Read mac address: 00:08:EE:02:24:B2
start Auto negotiation... (take ~2sec)
Auto negotiation complete, 100BaseTX, full duplex
Hit any key to stop autoboot:  0
OMAP34XX LAB # setenv bootargs 'console=ttyO2,115200n8 noinitrd vmalloc=1G mem=128M root=/dev/mmcblk0p2 rw ip=none rootdelay=2 video=omap24xxfb:rotation=270'
OMAP34XX LAB # dhcp; bootm
LAN9x18 (0x92110000) detected.
Read mac address: 00:08:EE:02:24:B2
start Auto negotiation... (take ~2sec)
Auto negotiation complete, 100BaseTX, full duplex
BOOTP broadcast 1
DHCP client bound to address 192.168.0.251
TFTP from server 192.168.0.4; our IP address is 192.168.0.251
Filename '/var/boot/kernels/arm-0008ee0224b2'.
Load address: 0x80000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #########################################
done
Bytes transferred = 1872004 (1c9084 hex)
## Booting image at 80000000 ...
   Image Name:   Linux-2.6.37-rc4+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1871940 Bytes =  1.8 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.37-rc4+ (rmk@rmk-PC) (gcc version 4.3.5 (GCC) ) #53 Mon Dec 6 12:32:53 GMT 2010
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP LDP board
vmalloc area is too big, limiting to 864MB
Reserving 2097152 bytes SDRAM for VRAM
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32000
Kernel command line: console=ttyO2,115200n8 noinitrd vmalloc=1G mem=128M root=/dev/mmcblk0p2 rw ip=none rootdelay=2 video=omap24xxfb:rotation=270
PID hash table entries: 128 (order: -3, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 126MB = 126MB total
Memory: 124416k/124416k available, 6656k reserved, 96256K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc2800000 - 0xf8000000   ( 856 MB)
    lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .init : 0xc0008000 - 0xc002c000   ( 144 kB)
      .text : 0xc002c000 - 0xc0329098   (3061 kB)
      .data : 0xc032a000 - 0xc03551c0   ( 173 kB)
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/266/500 MHz
Reprogramming SDRC clock to 266000000 Hz
dpll3_m2_clk rate change failed: -22
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 499.92 BogoMIPS (lpj=1949696)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
regulator: dummy:
NET: Registered protocol family 16
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1185 _omap_hwmod_enable+0x34/0x114()
omap_hwmod: wd_timer2: enabled state can only be entered from initialized, idle, or disabled state
Modules linked in:
---[ end trace 1b75b31a2719ed1c ]---
wd_timer2: Could not enable clocks for omap2_disable_wdt
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
SCSI subsystem initialized
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VMMC1: 1850 <--> 3150 mV at 3150 mV normal standby
i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
Advanced Linux Sound Architecture Driver Version 1.0.23.
Switching to clocksource 32k_counter
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 55
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
omap-hsuart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
omap-hsuart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
omap-hsuart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP UART2
console [ttyO2] enabled
brd: module loaded
loop: module loaded
smsc911x: Driver version 2008-10-21.
smsc911x-mdio: probed
eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=ffffffff:01, irq=-1)
net eth0: MAC Address: 00:08:ee:02:24:b2
ads7846 spi1.0: unable to get regulator: -19
twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
i2c /dev entries driver
Driver for 1-wire Dallas network protocol.
ALSA device list:
  No soundcards found.
TCP cubic registered
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
omapfb omapfb: no displays
omapfb omapfb: failed to setup omapfb
omapfb: probe of omapfb failed with error -22
twl_rtc twl_rtc: setting system clock to 2000-01-01 00:11:25 UTC (946685485)
Waiting 2sec before mounting root device...
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SD card at address 0002
mmcblk0: mmc0:0002 00000 971 MiB
 mmcblk0: p1 p2
EXT3-fs: barriers not enabled
mmcblk0: retrying using single block read
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): warning: mounting fs with errors, running e2fsck is recommended
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): recovery complete
EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
Freeing init memory: 144K
mmcblk0: retrying using single block read
INIT: version 2.86 booting
mmcblk0: retrying using single block read
modprobe: FATAL: Could not load /lib/modules/2.6.37-rc4+/modules.dep: No such file or directory

Error opening /dev/fb0: No such device
.udev/ already exists on the static /dev!
Starting the hotplug events dispatcher udevd
udevd (429): /proc/429/oom_adj is deprecated, please use /proc/429/oom_score_adj instead.
mmcblk0: retrying using single block read
mmcblk0: retrying using single block read
Synthesizing the initial hotplug events

Texas Instruments X-Loader 1.41mmc
Starting OS Bootloader from NAND ...

