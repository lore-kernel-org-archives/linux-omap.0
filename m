From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
	MDK (Re: LDP support)
Date: Thu, 7 May 2009 17:19:36 +0100
Message-ID: <20090507161936.GA26106@n2100.arm.linux.org.uk>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090505195231.GB8004@n2100.arm.linux.org.uk> <20090506040015.GM5593@atomide.com> <20090506224917.GS5593@atomide.com> <4A02F7CF.1050803@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50408 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbZEGQTv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 12:19:51 -0400
Content-Disposition: inline
In-Reply-To: <4A02F7CF.1050803@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Thu, May 07, 2009 at 11:01:35PM +0800, stanley.miao wrote:
> Hi, Tony,
>
> Now the kernel can't boot on LDP. The attached file is the boot log.

No boot log found.

My master branch, based upon 2.6.29-rc3 boots fine on the LDP.

Uncompressing Linux.............................................................
............................................ done, booting the kernel.
Linux version 2.6.29-rc3 (rmk@dyn-67.arm.linux.org.uk) (gcc version 4.3.2 (GCC)) #125 Mon Feb 2 22:22:54 GMT 2009
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP LDP board
Memory policy: ECC disabled, Data cache writeback
OMAP3430 ES2.1
SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS2,115200n8 noinitrd mem=128M root=/dev/mmcblk0p2 rw ip=none rootdelay=2 video=omap24xxfb:rotation=270
Clocking rate (Crystal/DPLL/ARM core): 26.0/266/500 MHz
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 126292KB available (2964K code, 372K data, 120K init)
Calibrating delay loop... 498.87 BogoMIPS (lpj=1945600)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 296 bytes
NET: Registered protocol family 16
OMAP DMA hardware revision 4.0
USB: No board-specific platform config found
bio: create slab <bio-0> at 0
SCSI subsystem initialized
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 246
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel ldp
omapfb: DISPC version 3.0 initialized
omapfb: Framebuffer initialized. Total vram 614400 planes 1
omapfb: Pixclock 32000 kHz hfreq 60.3 kHz vfreq 93.7 Hz
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
smsc911x: Driver version 2008-10-21.
smsc911x-mdio: probed
eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=ffffffff:01, irq=-1)
net eth0: MAC Address: 00:08:ee:02:24:b2
Driver 'sd' needs updating - please use bus_type methods
twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
twl4030_rtc twl4030_rtc: Power up reset detected.
twl4030_rtc twl4030_rtc: Enabling TWL4030-RTC.
i2c /dev entries driver
Driver for 1-wire Dallas network protocol.
OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
Advanced Linux Sound Architecture Driver Version 1.0.18a.
No device for DAI AD73311
No device for DAI AK4535
No device for DAI CS4270
No device for DAI PCM3008 HiFi
No device for DAI SSM2602
No device for DAI tlv320aic23
No device for DAI tlv320aic3x
No device for DAI twl4030
No device for DAI UDA134X
No device for DAI UDA1380
No device for DAI UDA1380
No device for DAI UDA1380
No device for DAI WM8510 HiFi
No device for DAI WM8580 PAIFRX
No device for DAI WM8580 PAIFTX
No device for DAI WM8728
No device for DAI WM8731
No device for DAI WM8750
No device for DAI WM8971
No device for DAI WM8990 ADC/DAC Primary
ALSA device list:
  No soundcards found.
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
Waiting 2sec before mounting root device...
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SD card at address 0002
mmcblk0: mmc0:0002 00000 971 MiB 
 mmcblk0: p1 p2
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
EXT3 FS on mmcblk0p2, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) on device 179:2.
Freeing init memory: 120K
INIT: version 2.86 booting
.udev/ already exists on the static /dev!
Starting the hotplug events dispatcher udevd
Synthesizing the initial hotplug events
...
