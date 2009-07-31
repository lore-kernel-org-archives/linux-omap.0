From: pramod gurav <pramodforum@gmail.com>
Subject: USB charging over TPS65950 BCI
Date: Fri, 31 Jul 2009 19:19:38 +0530
Message-ID: <f502236f0907310649t148117f6l8a5a06cb651dca6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:38676 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbZGaNti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 09:49:38 -0400
Received: by wf-out-1314.google.com with SMTP id 26so594793wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 31 Jul 2009 06:49:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,
I was trying to get the USB battery charging working over TPS65950 BCI
on the OMAP3430 custom board. I am working with linux-omap-2.6
v2.6.28-omap1 tag. I enabled the TWL4030 MADC and TWL4030 BCI drivers.
I passed interrupt details to these drivers from platform_device
structure from my board file. I could get the AC charging working. The
AC and USB detection worked. However the USB charging is not
happening.
I read through the TPS TRM and took the dumps of the registers from
BCI and some from TWL USB module and BOOT_BCI whenever I plug in the
USB charger between host and the board. The register settings seem to
be fine. But the battery is not charging. I am using BQ27000 chip for
battery monitoring and I can see the battery voltage is decreasing.

=46ollowing are the register dumps of TWL with and without USB plugged =
in:

These are the register contents when USB charger is plugged in:
BCIMDEN         =3D 0x11
REG_BOOT_BCI    =3D 0x37
REG_POWER_CTRL  =3D 0x20
REG_BCIMFSTS4   =3D 0xf4
REG_BCIMFSTS1   =3D 0x13
REG_BCIIREF1    =3D 0x68
REG_BCIIREF2    =3D 0x3
REG_BCIMFEN4    =3D 0x6f
REG_BCIMFSTS2   =3D 0x0
REG_BCIMSTATEC  =3D 0x12
REG_STS_HW_CONDITIONS=3D 0x90


These are the register contents when USB charger is plugged out:
BCIMDEN         =3D 0x0
REG_BOOT_BCI    =3D 0x35
REG_POWER_CTRL  =3D 0x20
REG_BCIMFSTS4   =3D 0xf0
REG_BCIMFSTS1   =3D 0xaa
REG_BCIIREF1    =3D 0x68
REG_BCIIREF2    =3D 0x3
REG_BCIMFEN4    =3D 0x68
REG_BCIMFSTS2   =3D 0x0
REG_BCIMSTATEC  =3D0x0
REG_STS_HW_CONDITIONS=3D 0x10

Is there anything more I need to support to get BCI USB charging
working? Need I follow any USB Communication protocol between Host and
the board.
I have pasted the kernel boot logs for reference at the end.
Can any one please guide me to some pointers?

--=20
Best Regards
Pramod


Starting kernel ...

Uncompressing Linux....................................................=
=2E....................................................................=
=2E.........
done, boo.
Linux version 2.6.28-omap1-(gpramod@gpramod.mistral.in) (gcc version
4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)) #25 Fri Jul 31
15:48:37 I9
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3430 Main Board
Memory policy: ECC disabled, Data cache writeback
OMAP3430 Unknown revision

SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Reserving 4194304 bytes SDRAM for VRAM
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65=
024
Kernel command line: console=3DttyS2,115200n8 root=3D/dev/mmcblk0p2
rootfstype=3Dext3 rootdelay=3D3 android.ril=3Dpts/0 init=3D/init
Unknown boot option `android.ril=3Dpts/0': ignoring
Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
Reprogramming SDRC
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
PID hash table entries: 1024 (order: 10, 4096 bytes)
OMAP clockevent source: GPTIMER12 at 32768 Hz
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB =3D 256MB total
Memory: 250880KB available (3580K code, 755K data, 300K init)
Calibrating delay loop... 494.72 BogoMIPS (lpj=3D1933312)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 312 bytes
NET: Registered protocol family 16
=46ound NAND on CS0
Registering NAND on CS0
OMAP DMA hardware revision 4.0
USB: No board-specific platform config found
OMAP DSS rev 2.0
OMAP DISPC rev 3.0
OMAP VENC rev 2
i2c_omap i2c_omap.1: bus 1 rev3.12 at 400 kHz
Skipping twl4030 internal clock init and using bootloader value
(unknown osc rate)
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
SCSI subsystem initialized
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
NetWinder Floating Point Emulator V0.97 (double precision)
ashmem: initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red Hat, Inc.
msgmni has been set to 490
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Allocating static major number 255 to omap3custum_bl driver
Serial: 8250/16550 driver4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
logger: created 64K log 'log_main'
logger: created 256K log 'log_events'
logger: created 64K log 'log_radio'
Created /proc/audio
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
PPPoL2TP kernel driver, V1.0
i2c /dev entries driver
input: triton2-pwrbutton as /devices/virtual/input/input0
triton2 power button driver initialized
3-Axis AK8973 Compass Driver : version : 0.0
Client [AK8973_Compass] registered with bus id (3) with slave address 0=
x1c
input: ak8973 as /devices/virtual/input/input1
Installing 'vibrator' driver
3-Axis lis302dl Accelerometer : version : 0.0
Client [lis302dl] registered with bus id (3) with slave address 0x1d
Driver 'sd' needs updating - please use bus_type methods
omap2-nand driver initializing
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB
1,8V 16-bit)
cmdlinepart partition parsing not available
Creating 10 MTD partitions on "omap2-nand":
0x00000000-0x00020000 : "X-Loader(1)"
0x00020000-0x00040000 : "X-Loader(2)"
0x00040000-0x00060000 : "X-Loader(3)"
0x00060000-0x00080000 : "X-Loader(4)"
0x00080000-0x00100000 : "U-Boot"
0x00100000-0x00120000 : "U-Boot Environment"
0x00120000-0x00320000 : "Kernel(1)"
0x00320000-0x00520000 : "Kernel(2)"
0x00520000-0x06920000 : "File System(1)"
0x06920000-0x10000000 : "File System(2)"
android adb driver
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
mice: PS/2 mouse device common for all mice
input: omap_twl4030keypad as
/devices/platform/i2c_omap.1/i2c-adapter/i2c-1/1-004a/twl4030_keypad/in=
put/input2
Register Mapped Interface Data Layer Driver
    Allocation Stats Enabled
RMI TouchPad Driver
input: RMI Touchpad as /devices/virtual/input/input3
Registering app driver rmi_touchpad
Registered app driver rmi_touchpad (cf9bb960)
i2c-adapter i2c-1: Invalid probe address 0x00
detect(): Detect: 00000020, 00000000
rmi: Registering phys driver rmi_i2c
rmi: RMI Protocol: 0.1
rmi: Manufacturer: 1 (Synaptics)

rmi: Physical Interface Version: 0.1
rmi: Properties:
rmi:    Can doze
rmi: Product Versions: 1.2.0.1
rmi: Product ID: TM1172
rmi: Functions:
rmi:    2-D Sensor
rmi:         SFPL: 1, Sources: 3, EDR: 7
rmi:         Function Version: 0.1
rmi: rmi_touchpad bound to rmi_i2c
Config function
  Number of extra positions: 0
  Has 2D Scroll: 0
  Has Scroller: 0
  Has gestures: 1
  Has Multifing: 1
  Has Palm Det: 1
  Sensor Max X: 3975, MAX_X=3D3975
  Sensor Max Y: 5952, MAX_Y=3D5952
  Sensor Resolution: 77
  Interrupt Driven
Registered phys driver rmi_i2c
i2c-adapter i2c-2: Invalid probe address 0x00
i2c-adapter i2c-3: Invalid probe address 0x00
twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
twl4030_rtc twl4030_rtc: Power up reset detected.
twl4030_rtc twl4030_rtc: Enabling TWL4030-RTC.
Driver for 1-wire Dallas network protocol.
omap_hdq omap_hdq.0: OMAP HDQ Hardware Rev 0.5. Driver in Interrupt mod=
e
w1_master_driver w1_bus_master1: Family 1 for 01.000000000000.3d is
not registered.
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
mmci-omap-hs mmci-omap-hs.1: Failed to get debounce clock
Advanced Linux Sound Architecture Driver Version 1.0.18rc3.
ASoC version 0.13.2
omap3custum SoC init
TWL4030 Audio Codec init
asoc: twl4030 <-> omap-mcbsp-dai-(link_id) mapping ok
ALSA device list:
  #0: OMAP3430 (twl4030)
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
ThumbEE CPU extension supported.
Power Management for TI OMAP3.
clock: dpll5_ck failed transition to 'locked'
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
Console: switching to colour frame buffer device 40x30
mmc0: new SD card at address e624
mmcblk0: mmc0:e624 SU02G 1.89 GiB
 mmcblk0:<6>twl4030_rtc twl4030_rtc: setting system clock to
2000-01-01 00:00:02 UTC (946684802)
Waiting 3sec before mounting root device...
 p1 p2
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recomme=
nded
EXT3 FS on mmcblk0p2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
=46reeing init memory: 300K
=46ailed to execute /init.  Attempting defaults...

****************************************************
Starting System Init for OMAP3430 1.0
****************************************************

Mounting Filesystem...
Starting inetd...
Starting syslogd...

Please press Enter to activate this console.

Processing /etc/profile... Done

--
Best Regards
Pramod
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
