From: CF Adad <cfadad@rocketmail.com>
Subject: Please help!  AM35xx mm/slab.c BUG
Date: Mon, 4 Jun 2012 23:37:35 -0700 (PDT)
Message-ID: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm12.bullet.mail.ne1.yahoo.com ([98.138.90.75]:29876 "HELO
	nm12.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751575Ab2FEGnJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jun 2012 02:43:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,

I'm **really** hoping someone out there can help us with this.

My team has been working with the AM3517 for several months now, and we=
 seem to be plagued every so often by what we have termed the "slab bug=
".=A0 In short, it looks something like the pasted bootlog below.=A0 Th=
is has been an *incredibly* hard bug to figure out.=A0 We have a couple=
 of different AM3517-based platforms at our disposal, but the one we se=
e the issue on almost exclusively is a custom, prototype baseboard desi=
gned around the TechNexion TAM3157.=A0 Over the last several months, we=
 have tried several versions of the Linux off the linux-omap tree, with=
 loads of different configurations, and even different bootloader versi=
ons and combinations.=A0 We've spent most of our time with a linux-omap=
 snapshot that was a 3.2-rc6, and more recently a 3.4-rc6 from late a w=
eek or two back.=A0 (Tomorrow I anticipate pulling the latest 3.5 now t=
hat I see it's out.)=A0 In all cases, since we switched to 3.0+, we've =
seen these errors.

They are *very* inconsistent in when they occur, but they happen often =
enough to be very frustrating.=A0 Consequently, our team has had an inc=
redibly difficult time tracking what's causing them.=A0 They seem to oc=
cur at random, perhaps on average once every handful of days.=A0 We've =
messed with everything we can think of from tweaking kernel options (li=
ke enabling/disabling preemption), to disabling various drivers and use=
rspace components, to reviewing every single line in any of our board f=
iles.=A0 We have tried different versions and combinations of the OS an=
d both bootloaders (x-loader & u-boot), and even went so far as to do a=
 full analysis of the RAM timings in the EMIF4.=A0 Unfortunately, nothi=
ng so far has worked.=A0 The error occurs when operating off both the S=
D/MMC and the NAND devices, with or without the Ethernets (LAN9221 & EM=
AC) up and/or running, with or without PREEMPT, under heavy load and so=
metimes just idling, ...=A0 There is simply nothing
 consistent about it.=A0 After probably 2 weeks without seeing one, I s=
aw 3 today.

Though the error's occurence is inconistent, the error itself is.=A0 It=
 always throws an internal OOPs at the following section of code in mm/=
slab.c:
---
/*
* The slab was either on partial or free list so
* there must be at least one object available for
* allocation.
*/
BUG_ON(slabp->inuse >=3D cachep->num);
---
(It appears this was patched in eons ago: https://lkml.org/lkml/2007/2/=
19/20.=A0=A0So it's nothing new.)



Under our Linux 3.2-rc6, the error is listed as line "3109".=A0=A0Under=
 our Linux 3.4-rc6, it is line "3175".=A0=A0I'm FAR from a Linux MM exp=
ert, and we've do NO customization there.=A0 So, I'm hoping someone on =
here will see something they recognize, or at least be able to help us =
get more debugging in there to try to get more information.

Amazingly, Google has been little help on this one.=A0 It seems we're t=
he only folks in the world having this issue.=A0 Can anyone *please* he=
lp us sort out what's happening here?=A0 Or even just suggest where to =
start looking?

Below is a very recent snapshot of our full boot + the crash, this time=
 on poweroff though it can happen any time.=A0 We have probably close t=
o 15 of these crashes on file if anyone could use more information.=A0 =
I just chose not to spam them all on here.

(*NOTE: These bootloaders & kernel sources are highly customized now.=A0=
 So, you may notice that the processor detects as an AM3505 instead of =
a 3517 because we've removed features unnecessary to our project, such =
as the SGX, from our software.=A0 That being said, these errors have oc=
curred on the very base builds before any customization.=A0 Please look=
 around that unless you see something really unexplainable.=A0 Given ta=
ht we've seen these errors before any of the customizations, we do not =
believe they are the culprit.=A0 Similarly, those "ECC ERRORS" you see =
relate to us having to use Micron's on-die ECC for our 4-bit NAND.=A0 W=
e've not gotten the bootloaders and Linux to play nicely with it yet wi=
thout using the on-die support.=A0 The "ERRORS" are simply referencing =
the first block, which is managed with a 1-bit ECC instead of the 4-bit=
=2E=A0 So, other non-x-loader processes see that section as an error wh=
en reading it.)


Thanks in advance for your help!


Texas Instruments X-Loader 1.51-dirty (May 29 2012 - 14:05:44)
Enable Micron on-die ECC engine
Detected board: TEST_TAM3517+
Starting X-loader on MMC=20
Reading boot sector
448240 Bytes Read from MMC
Starting 'u-boot.bin' from MMC...
Starting OS Bootloader...


U-Boot 2012.04.01-00083-g0834508-dirty (Jun 04 2012 - 18:35:28)

AM35XX-GP ES2.0, CPU-OPP2, L3-165MHz, Max CPU Clock 600 Mhz
TEST_TAM3517+ Board + LPDDR/NAND
I2C:=A0=A0 ready
DRAM:=A0 256 MiB
NAND:=A0 NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc (Micron NAND=
 512MiB 1,8V 16-bit)
512 MiB
MMC:=A0=A0 OMAP SD/MMC: 0
Scanning device for bad blocks
ERROR: ON-DIE ECC READ FAILURE
ERROR: ON-DIE ECC READ FAILURE
ERROR: ON-DIE ECC READ FAILURE
ERROR: ON-DIE ECC READ FAILURE
ERROR: ON-DIE ECC READ FAILURE
ERROR: ON-DIE ECC READ FAILURE
ERROR: ON-DIE ECC READ FAILURE
ERROR: ON-DIE ECC READ FAILURE
*** Warning - bad CRC, using default environment

In:=A0=A0=A0 serial
Out:=A0=A0 serial
Err:=A0=A0 serial
Die ID #00000000000averybignumber00000000000
Enabling Micron ECC ... OK
Micron On-Die ECC selected
Net:=A0=A0 DaVinci-EMAC, smc911x-0
Hit any key to stop autoboot:=A0 0

reading uImage

2615512 bytes read
Booting from mmc ...
## Booting kernel from Legacy Image at 82000000 ...
=A0=A0 Image Name:=A0=A0 Linux-3.4.0-rc6
=A0=A0 Image Type:=A0=A0 ARM Linux Kernel Image (uncompressed)
=A0=A0 Data Size:=A0=A0=A0 2615448 Bytes =3D 2.5 MiB
=A0=A0 Load Address: 80008000
=A0=A0 Entry Point:=A0 80008000
=A0=A0 Verifying Checksum ... OK
=A0=A0 Loading Kernel Image ... OK
OK

Starting kernel ...

[=A0=A0=A0 0.000000] Booting Linux on physical CPU 0
[=A0=A0=A0 0.000000] Linux version 3.4.0-rc6 (user@userbox) (gcc versio=
n 4.7.1 20120421 (prerelease) (GCC) ) #8 Mon Jun 4 19:37:56 EDT 2012
[=A0=A0=A0 0.000000] CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7)=
, cr=3D10c5387d
[=A0=A0=A0 0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nona=
liasing instruction cache
[=A0=A0=A0 0.000000] Machine: Technexion TAM3517
[=A0=A0=A0 0.000000] Memory policy: ECC disabled, Data cache writeback
[=A0=A0=A0 0.000000] AM3505 ES1.1 (l2cache neon isp )
[=A0=A0=A0 0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
[=A0=A0=A0 0.000000] Built 1 zonelists in Zone order, mobility grouping=
 on.=A0 Total pages: 64768
[=A0=A0=A0 0.000000] Kernel command line: console=3DttyO2,115200n8 mem=3D=
256M mpurate=3D600 root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 rootwait =
nohlt0
[=A0=A0=A0 0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes=
)
[=A0=A0=A0 0.000000] Dentry cache hash table entries: 32768 (order: 5, =
131072 bytes)
[=A0=A0=A0 0.000000] Inode-cache hash table entries: 16384 (order: 4, 6=
5536 bytes)
[=A0=A0=A0 0.000000] Memory: 255MB =3D 255MB total
[=A0=A0=A0 0.000000] Memory: 253160k/253160k available, 8984k reserved,=
 0K highmem
[=A0=A0=A0 0.000000] Virtual kernel memory layout:
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 vector=A0 : 0xffff0000 - 0xffff1000=A0=
=A0 (=A0=A0 4 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 fixmap=A0 : 0xfff00000 - 0xfffe0000=A0=
=A0 ( 896 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 vmalloc : 0xd0800000 - 0xff000000=A0=A0=
 ( 744 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 lowmem=A0 : 0xc0000000 - 0xd0000000=A0=
=A0 ( 256 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 pkmap=A0=A0 : 0xbfe00000 - 0xc0000000=A0=
=A0 (=A0=A0 2 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 modules : 0xbf000000 - 0xbfe00000=A0=A0=
 (=A0 14 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .text : 0xc0008000 - 0xc04af000=A0=
=A0 (4764 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .init : 0xc04af000 - 0xc04eb000=A0=
=A0 ( 240 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .data : 0xc04ec000 - 0xc05330a8=A0=
=A0 ( 285 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0=A0 .bss : 0xc05330e8 - 0xc058734=
c=A0=A0 ( 337 kB)
[=A0=A0=A0 0.000000] NR_IRQS:460
[=A0=A0=A0 0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) wi=
th 96 interrupts
[=A0=A0=A0 0.000000] Total of 96 interrupts on 1 active controller
[=A0=A0=A0 0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[=A0=A0=A0 0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,=
 wraps every 131071999ms
[=A0=A0=A0 0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[=A0=A0=A0 0.000000] Console: colour dummy device 80x30
[=A0=A0=A0 0.000274] Calibrating delay loop... 597.64 BogoMIPS (lpj=3D2=
334720)
[=A0=A0=A0 0.039093] pid_max: default: 32768 minimum: 301
[=A0=A0=A0 0.039306] Mount-cache hash table entries: 512
[=A0=A0=A0 0.040161] CPU: Testing write buffer coherency: ok
[=A0=A0=A0 0.040252] ftrace: allocating 13705 entries in 41 pages
[=A0=A0=A0 0.099639] Setting up static identity map for 0x80380d18 - 0x=
80380d70
[=A0=A0=A0 0.100982] devtmpfs: initialized
[=A0=A0=A0 0.106201] dummy:=20
[=A0=A0=A0 0.106689] NET: Registered protocol family 16
[=A0=A0=A0 0.107238] GPMC revision 5.0
[=A0=A0=A0 0.107299] gpmc: irq-20 could not claim: err -22
[=A0=A0=A0 0.110870] gpiochip_add: registered GPIOs 0 to 31 on device: =
gpio
[=A0=A0=A0 0.110931] OMAP GPIO hardware version 2.5
[=A0=A0=A0 0.111358] gpiochip_add: registered GPIOs 32 to 63 on device:=
 gpio
[=A0=A0=A0 0.111785] gpiochip_add: registered GPIOs 64 to 95 on device:=
 gpio
[=A0=A0=A0 0.112213] gpiochip_add: registered GPIOs 96 to 127 on device=
: gpio
[=A0=A0=A0 0.112609] gpiochip_add: registered GPIOs 128 to 159 on devic=
e: gpio
[=A0=A0=A0 0.113006] gpiochip_add: registered GPIOs 160 to 191 on devic=
e: gpio
[=A0=A0=A0 0.114715] omap_mux_init: Add partition: #1: core, flags: 0
[=A0=A0=A0 0.234985] TEST control/display GPIOs initialized
[=A0=A0=A0 0.240295]=A0 omap-mcbsp.2: alias fck already exists
[=A0=A0=A0 0.240692]=A0 omap-mcbsp.3: alias fck already exists
[=A0=A0=A0 0.242004] Switched to new clocking rate (Crystal/Core/MPU): =
26.0/332/600 MHz
[=A0=A0=A0 0.242279] OMAP DMA hardware revision 4.0
[=A0=A0=A0 0.255645] bio: create slab <bio-0> at 0
[=A0=A0=A0 0.256591] fixed-dummy:=20
[=A0=A0=A0 0.258636] SCSI subsystem initialized
[=A0=A0=A0 0.273529] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 400 kHz
[=A0=A0=A0 0.289123] omap_i2c omap_i2c.2: bus 2 rev1.3.12 at 400 kHz
[=A0=A0=A0 0.289581] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
[=A0=A0=A0 0.292022] Advanced Linux Sound Architecture Driver Version 1=
=2E0.25.
[=A0=A0=A0 0.293334] Switching to clocksource 32k_counter
[=A0=A0=A0 0.333160] NET: Registered protocol family 2
[=A0=A0=A0 0.333526] IP route cache hash table entries: 2048 (order: 1,=
 8192 bytes)
[=A0=A0=A0 0.334197] TCP established hash table entries: 8192 (order: 4=
, 65536 bytes)
[=A0=A0=A0 0.334381] TCP bind hash table entries: 8192 (order: 3, 32768=
 bytes)
[=A0=A0=A0 0.334503] TCP: Hash tables configured (established 8192 bind=
 8192)
[=A0=A0=A0 0.334533] TCP: reno registered
[=A0=A0=A0 0.334533] UDP hash table entries: 256 (order: 0, 4096 bytes)
[=A0=A0=A0 0.334594] UDP-Lite hash table entries: 256 (order: 0, 4096 b=
ytes)
[=A0=A0=A0 0.334869] NET: Registered protocol family 1
[=A0=A0=A0 0.339691] jffs2: version 2.2. (NAND) (SUMMARY)=A0 =A9 2001-2=
006 Red Hat, Inc.
[=A0=A0=A0 0.340728] msgmni has been set to 494
[=A0=A0=A0 0.341979] io scheduler noop registered
[=A0=A0=A0 0.342071] io scheduler cfq registered (default)
[=A0=A0=A0 0.342529] Serial: 8250/16550 driver, 4 ports, IRQ sharing en=
abled
[=A0=A0=A0 0.345031] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72)=
 is a OMAP UART0
[=A0=A0=A0 0.345672] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73)=
 is a OMAP UART1
[=A0=A0=A0 0.346252] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74)=
 is a OMAP UART2
[=A0=A0=A0 0.830505] console [ttyO2] enabled
[=A0=A0=A0 0.834869] omap_uart.3: ttyO3 at MMIO 0x4809e000 (irq =3D 84)=
 is a OMAP UART3
[=A0=A0=A0 0.843170] at24 1-0050: 256 byte 24c02 EEPROM, writable, 1 by=
tes/write
[=A0=A0=A0 0.852142] GPIO NAND driver, =A9 2004 Simtec Electronics
[=A0=A0=A0 0.858673] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc =
(Micron NAND 512MiB 1,8V 16-bit)
[=A0=A0=A0 0.867858] NAND_ECC_NONE selected by board driver. This is no=
t recommended!
[=A0=A0=A0 0.875549] Creating 7 MTD partitions on "omap2-nand.0":
[=A0=A0=A0 0.881195] 0x000000000000-0x000000080000 : "X-Loader"
[=A0=A0=A0 0.886657] WARNING :: READ Operation ECC Error: 0xe1 delay 27=
 usec
[=A0=A0=A0 0.893371] WARNING :: READ Operation ECC Error: 0xe1 delay 28=
 usec
[=A0=A0=A0 0.900054] WARNING :: READ Operation ECC Error: 0xe1 delay 28=
 usec
[=A0=A0=A0 0.906768] WARNING :: READ Operation ECC Error: 0xe1 delay 28=
 usec
[=A0=A0=A0 0.913482] WARNING :: READ Operation ECC Error: 0xe1 delay 28=
 usec
[=A0=A0=A0 0.920196] WARNING :: READ Operation ECC Error: 0xe1 delay 28=
 usec
[=A0=A0=A0 0.926879] WARNING :: READ Operation ECC Error: 0xe1 delay 28=
 usec
[=A0=A0=A0 0.933563] WARNING :: READ Operation ECC Error: 0xe1 delay 28=
 usec
[=A0=A0=A0 0.942169] 0x000000080000-0x000000240000 : "U-Boot"
[=A0=A0=A0 0.951812] 0x000000240000-0x000000280000 : "U-Boot Env"
[=A0=A0=A0 0.959503] 0x000000280000-0x000000780000 : "Kernel"
[=A0=A0=A0 0.973937] 0x000000780000-0x00000cf80000 : "Root Filesystem (=
read-only)"
[=A0=A0=A0 1.279815] 0x00000cf80000-0x00001fb80000 : "Root Filesystem (=
writeable overlay)"
[=A0=A0=A0 1.734985] 0x00001fb80000-0x000020000000 : "DATA"
[=A0=A0=A0 1.749572] smsc911x: Driver version 2008-10-21
[=A0=A0=A0 1.756835] smsc911x-mdio: probed
[=A0=A0=A0 1.760406] smsc911x smsc911x.0: eth0: attached PHY driver [Ge=
neric PHY] (mii_bus:phy_addr=3Dsmsc911x-0:01, irq=3D-1)
[=A0=A0=A0 1.802093] smsc911x smsc911x.0: eth0: MAC Address: xx:xx:xx:x=
x:xx:xx
[=A0=A0=A0 1.856048] davinci_mdio davinci_mdio.0: davinci mdio revision=
 1.5
[=A0=A0=A0 1.862548] davinci_mdio davinci_mdio.0: detected phy mask fff=
ffffe
[=A0=A0=A0 1.869781] davinci_mdio.0: probed
[=A0=A0=A0 1.873382] davinci_mdio davinci_mdio.0: phy[0]: device davinc=
i_mdio-0:00, driver unknown
[=A0=A0=A0 1.882263] i2c /dev entries driver
[=A0=A0=A0 1.888000] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial ti=
meout 60 sec
[=A0=A0=A0 1.904510] soc-audio soc-audio: ASoC machine TEST should use =
snd_soc_register_card()
[=A0=A0=A0 1.914825] asoc: TEST-codec-dai <-> omap-mcbsp.2 mapping ok
[=A0=A0=A0 1.922912] asoc: TEST-codec-dai <-> omap-mcbsp.3 mapping ok
[=A0=A0=A0 1.930725] asoc: TEST-codec-dai <-> omap-mcbsp.4 mapping ok
[=A0=A0=A0 1.940155] TEST SoC init
[=A0=A0=A0 1.944519] TCP: cubic registered
[=A0=A0=A0 1.948028] Initializing XFRM netlink socket
[=A0=A0=A0 1.953613] NET: Registered protocol family 17
[=A0=A0=A0 1.960388] NET: Registered protocol family 15
[=A0=A0=A0 1.965179] VFP support v0.3: implementor 41 architecture 3 pa=
rt 30 variant c rev 1
[=A0=A0=A0 1.973266] ThumbEE CPU extension supported.
[=A0=A0=A0 1.977813] Registering SWP/SWPB emulation handler
[=A0=A0=A0 1.984588] voltdm_scale: No voltage scale API registered for =
vdd_mpu_iva
[=A0=A0=A0 1.991851] voltdm_scale: No voltage scale API registered for =
vdd_core
[=A0=A0=A0 1.998809] PM: no software I/O chain control; some wakeups ma=
y be lost
[=A0=A0=A0 2.014526] clock: disabling unused clocks to save power
[=A0=A0=A0 2.024963] ALSA device list:
[=A0=A0=A0 2.028167]=A0=A0 #0: TEST
[=A0=A0=A0 2.031402] Waiting for root device /dev/mmcblk0p2...
[=A0=A0=A0 2.053710] mmc0: host does not support reading read-only swit=
ch. assuming write-enable.
[=A0=A0=A0 2.063995] mmc0: new high speed SDHC card at address 0001
[=A0=A0=A0 2.070587] mmcblk0: mmc0:0001 00000 7.41 GiB=20
[=A0=A0=A0 2.077636]=A0 mmcblk0: p1 p2 p3
[=A0=A0=A0 2.149963] kjournald starting.=A0 Commit interval 5 seconds
[=A0=A0=A0 2.155822] EXT3-fs (mmcblk0p2): warning: maximal mount count =
reached, running e2fsck is recommended
[=A0=A0=A0 2.171234] EXT3-fs (mmcblk0p2): using internal journal
[=A0=A0=A0 2.176757] EXT3-fs (mmcblk0p2): mounted filesystem with order=
ed data mode
[=A0=A0=A0 2.184051] VFS: Mounted root (ext3 filesystem) on device 179:=
2.
[=A0=A0=A0 2.192565] devtmpfs: mounted
[=A0=A0=A0 2.196289] Freeing init memory: 240K

Welcome to The =C5ngstr=F6m Distribution!

Starting udev Coldplug all Devices...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=20
Starting Media Directory...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Starting Remount API VFS...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Starting Runtime Directory...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Starting Lock Directory...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Started Huge Pages File System=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 [=A0 OK=A0 ]
Starting File System Check on Root Device...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=20
Starting Debug File System...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Started Security File System=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [=A0 OK=A0 ]
Started Load Kernel Modules=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 [=A0 OK=A0 ]
Started FUSE Control File System=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 [=A0 OK=A0 ]
Started Configuration File System=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 [=A0 OK=A0 ]
Starting Apply Kernel Variables...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=20
Starting udev Kernel Device Manager...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=20
Starting Journal Service...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Started Journal Service=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
[=A0=A0=A0 3.141510] udevd[505]: starting version 181
Starting POSIX Message Queue File System...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=20
Started Set Up Additional Binary Formats=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Started udev Kernel Device Manager=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
=A0 OK=A0 ]
Started Media Directory=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Started Remount API VFS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Started Runtime Directory=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Started Lock Directory=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Started File System Check on Root Device=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Started Debug File System=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Started Apply Kernel Variables=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 [=A0 OK=A0 ]
Started POSIX Message Queue File System=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0=
 ]
Starting Remount Root FS...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Started udev Coldplug all Devices=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 [=A0 OK=A0 ]
Started Remount Root FS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Started Machine ID first boot configure=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0=
 ]
Starting /tmp...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Started Opkg first boot configure=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 [=A0 OK=A0 ]
Started /tmp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Starting Recreate Volatile Files and Directories...=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Starting Load Random Seed...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Started Load Random Seed=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Started Recreate Volatile Files and Directories=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Starting Timestamping service...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Started Timestamping service=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [=A0 OK=A0 ]
Started SSH Key Generation=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Starting Permit User Sessions...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Starting Login Service...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Starting Avahi mDNS/DNS-SD Stack...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=20
Starting LSB: ifplugd daemon...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Starting D-Bus System Message Bus...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=20
Started Permit User Sessions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [=A0 OK=A0 ]
Starting Getty on tty1...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Started Getty on tty1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
Starting Serial Getty on ttyO2...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=20
Started Serial Getty on ttyO2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [=A0 OK=A0 ]
Started D-Bus System Message Bus=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 [=A0 OK=A0 ]
[=A0=A0=A0 8.707733] smsc911x smsc911x.0: eth0: SMSC911x/921x identifie=
d at 0xd086c000, IRQ: 161
Started Avahi mDNS/DNS-SD Stack=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 [=A0 OK=A0 ]
Started Login Service=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]

=2E---O---.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
|=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 .-.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 o o=A0=A0=A0=A0=A0=A0=A0=20
|=A0=A0 |=A0=A0 |-----.-----.-----.| |=A0=A0 .----..-----.-----.
|=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0 | __=A0 |=A0 ---'| '--.|=A0 .-'|=A0=A0=
=A0=A0 |=A0=A0=A0=A0 |
|=A0=A0 |=A0=A0 |=A0 |=A0 |=A0=A0=A0=A0 |---=A0 ||=A0 --'|=A0 |=A0 |=A0=
 '=A0 | | | |
'---'---'--'--'--.=A0 |-----''----''--'=A0 '-----'-'-'-'
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -'=A0 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '---'

The Angstrom Distribution TEST-tam3517 ttyO2

Angstrom v2012.05-core - Kernel 3.4.0-rc6

TEST-tam3517 login: Started LSB: ifplugd daemon=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]
ifplugd[864]: Starting Network Interface Plugging Daemon: eth0.

=2E---O---.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
|=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 .-.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 o o=A0=A0=A0=A0=A0=A0=A0=20
|=A0=A0 |=A0=A0 |-----.-----.-----.| |=A0=A0 .----..-----.-----.
|=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0 | __=A0 |=A0 ---'| '--.|=A0 .-'|=A0=A0=
=A0=A0 |=A0=A0=A0=A0 |
|=A0=A0 |=A0=A0 |=A0 |=A0 |=A0=A0=A0=A0 |---=A0 ||=A0 --'|=A0 |=A0 |=A0=
 '=A0 | | | |
'---'---'--'--'--.=A0 |-----''----''--'=A0 '-----'-'-'-'
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -'=A0 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '---'

The Angstrom Distribution TEST-tam3517 ttyO2

Angstrom v2012.05-core - Kernel 3.4.0-rc6

TEST-tam3517 login: root
Last login: Thu Jan=A0 1 03:51:39 UTC 1970 on ttyO2
root@sc_hd1u-tam3517:~# poweroff
Stopping Timestamping service...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Stopping Getty on ttStopping Login Service...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Stopping Avahi mDNS/DNS-SD Stack...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=20
Stopping D-Bus System Message Bus...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=20
Stopping LSB: ifplugd daemon...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
[=A0 188.316284] ------------[ cut here ]------------
[=A0 188.321197] kernel BUG at mm/slab.c:3175!
[=A0 188.325408] Internal error: Oops - BUG: 0 [#1] ARM
[=A0 188.330444] Modules linked in:
[=A0 188.333648] CPU: 0=A0=A0=A0 Not tainted=A0 (3.4.0-rc6 #8)
[=A0 188.338623] PC is at cache_alloc_refill+0x13c/0x534
[=A0 188.343749] LR is at kmem_cache_alloc+0x10c/0x11c
[=A0 188.348693] pc : [<c037cefc>]=A0=A0=A0 lr : [<c00c3e84>]=A0=A0=A0 =
psr: 60000093
[=A0 188.348724] sp : cee53e48=A0 ip : 0000002d=A0 fp : cee53e8c
[=A0 188.360778] r10: 0000002c=A0 r9 : cf80dec0=A0 r8 : 00000020
[=A0 188.366271] r7 : 00100100=A0 r6 : cf802bc0=A0 r5 : 00200200=A0 r4 =
: cf80c200
[=A0 188.373107] r3 : cfbc4000=A0 r2 : 00000012=A0 r1 : 0000002c=A0 r0 =
: 0000002c
[=A0 188.379974] Flags: nZCv=A0 IRQs off=A0 FIQs on=A0 Mode SVC_32=A0 I=
SA ARM=A0 Segment user
[=A0 188.387573] Control: 10c5387d=A0 Table: 8ee60019=A0 DAC: 00000015
[=A0 188.393615] Process systemd-cgroups (pid: 932, stack limit =3D 0xc=
ee522f0)
[=A0 188.400665] Stack: (0xcee53e48 to 0xcee54000)
[=A0 188.405242] 3e40:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 cf802bd0 000000d0 000000d0 00000000 000000d0 cf802bc8
[=A0 188.413848] 3e60: cee53ebc 000000d0 60000013 b6f78000 000000d0 c00=
b89f8 08100071 cf80dec0
[=A0 188.422424] 3e80: cee53ebc cee53e90 c00c3e84 c037cdcc 00000017 cec=
b37b0 0000001b cec70968
[=A0 188.431030] 3ea0: b6f78000 c0533f10 cecc8200 00000000 cee53eec cee=
53ec0 c00b89f8 c00c3d84
[=A0 188.439636] 3ec0: cecb37b0 00000200 0000001b 00000000 cee53f7c cfb=
89820 b6f78000 00000014
[=A0 188.448242] 3ee0: cee53f04 cee53ef0 c00ba4f8 c00b89cc 00000000 cec=
70968 cee53f6c cee53f08
[=A0 188.456848] 3f00: c00bb15c c00ba4d8 08100071 cfb89820 cfbb8cc0 000=
00014 00000000 cecc8200
[=A0 188.465423] 3f20: 00000001 08100073 cecc8200 60000013 cecc8234 000=
00001 b6f77000 00000000
[=A0 188.474029] 3f40: c0380ccc b6f78000 00000001 b6f78000 cee52000 000=
00001 cee52000 00000000
[=A0 188.482635] 3f60: cee53fa4 cee53f70 c00bb2bc c00bae24 08100071 c00=
50348 00000022 cec70968
[=A0 188.491241] 3f80: ffffffff b6fddb98 00000000 b6f5e930 0000007d c00=
0e9c4 00000000 cee53fa8
[=A0 188.499847] 3fa0: c000e780 c00bb194 b6fddb98 00000000 b6f77000 000=
01000 00000001 fffff000
[=A0 188.508453] 3fc0: b6fddb98 00000000 b6f5e930 0000007d b6f5eb80 b6f=
5bce0 b6f5b000 becb3afc
[=A0 188.517028] 3fe0: 00019d60 becb3a40 b6fc4fb8 b6fcff4c 80000010 b6f=
77000 00000000 00000000
[=A0 188.525634] Backtrace:=20
[=A0 188.528228] [<c037cdc0>] (cache_alloc_refill+0x0/0x534) from [<c00=
c3e84>] (kmem_cache_alloc+0x10c/0x11c)
[=A0 188.538208] [<c00c3d78>] (kmem_cache_alloc+0x0/0x11c) from [<c00b8=
9f8>] (__split_vma+0x38/0x1bc)
[=A0 188.547454] [<c00b89c0>] (__split_vma+0x0/0x1bc) from [<c00ba4f8>]=
 (split_vma+0x2c/0x3c)
[=A0 188.555969] [<c00ba4cc>] (split_vma+0x0/0x3c) from [<c00bb15c>] (m=
protect_fixup+0x344/0x370)
[=A0 188.564819]=A0 r4:cec70968 r3:00000000
[=A0 188.568603] [<c00bae18>] (mprotect_fixup+0x0/0x370) from [<c00bb2b=
c>] (sys_mprotect+0x134/0x1c4)
[=A0 188.577850] [<c00bb188>] (sys_mprotect+0x0/0x1c4) from [<c000e780>=
] (ret_fast_syscall+0x0/0x30)
[=A0 188.587005]=A0 r8:c000e9c4 r7:0000007d r6:b6f5e930 r5:00000000 r4:=
b6fddb98
[=A0 188.594055] Code: e5930010 e5991018 e1500001 3a00000e (e7f001f2)=20
[=A0 188.600616] ---[ end trace af8909ba8c2e9ac6 ]---
[=A0 188.606811] ------------[ cut here ]------------
[=A0 188.611663] kernel BUG at mm/slab.c:3175!
[=A0 188.615875] Internal error: Oops - BUG: 0 [#2] ARM
[=A0 188.620910] Modules linked in:
[=A0 188.624145] CPU: 0=A0=A0=A0 Tainted: G=A0=A0=A0=A0=A0 D=A0=A0=A0=A0=
=A0=A0 (3.4.0-rc6 #8)
[=A0 188.630096] PC is at cache_alloc_refill+0x13c/0x534
[=A0 188.635223] LR is at kmem_cache_alloc+0x10c/0x11c
[=A0 188.640167] pc : [<c037cefc>]=A0=A0=A0 lr : [<c00c3e84>]=A0=A0=A0 =
psr: 60000093
[=A0 188.640167] sp : cf82de30=A0 ip : 000000d0=A0 fp : cf82de74
[=A0 188.652252] r10: 00100100=A0 r9 : cf80dec0=A0 r8 : c002d144
[=A0 188.657745] r7 : 00100100=A0 r6 : cf802bc0=A0 r5 : 00200200=A0 r4 =
: cf80c200
[=A0 188.664581] r3 : cfbc4000=A0 r2 : 0000003c=A0 r1 : 0000002c=A0 r0 =
: 0000002c
[=A0 188.671447] Flags: nZCv=A0 IRQs off=A0 FIQs on=A0 Mode SVC_32=A0 I=
SA ARM=A0 Segment user
[=A0 188.679046] Control: 10c5387d=A0 Table: 8fb94019=A0 DAC: 00000015
[=A0 188.685089] Process systemd (pid: 1, stack limit =3D 0xcf82c2f0)
[=A0 188.691192] Stack: (0xcf82de30 to 0xcf82e000)
[=A0 188.695800] de20:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cf802bd0 0000=
00d0 000000d0 00000000
[=A0 188.704376] de40: 000000d0 cf802bc8 cf82dea4 000000d0 60000013 cec=
376c0 000000d0 c002d144
[=A0 188.712982] de60: cfbc4814 cf80dec0 cf82dea4 cf82de78 c00c3e84 c03=
7cdcc cf5281e4 cfbc4808
[=A0 188.721588] de80: cfbc4808 cfb8c288 cec376c0 00000000 cfbc4828 cfb=
c4824 cf82deec cf82dea8
[=A0 188.730194] dea0: c002d144 c00c3d84 ced35c00 cf5281c0 cec376f4 cfb=
8de34 cfb8de00 cfbc4808
[=A0 188.738800] dec0: cf8269b8 01200011 cf82c000 cec54b80 00000000 c05=
33f00 cfa1e298 cfa1e100
[=A0 188.747375] dee0: cf82df44 cf82def0 c002db08 c002d008 00000600 000=
00002 00000000 cfa1e1e8
[=A0 188.755981] df00: 00000000 cf82dfb0 bebdf6d8 00000000 c00d0f58 fff=
ffff4 00000000 01200011
[=A0 188.764587] df20: 00000000 bebdf6d8 00000000 cf82dfb0 cf82c000 000=
00000 cf82df8c cf82df48
[=A0 188.773193] df40: c002e248 c002d450 b6fc4068 00000000 00000000 000=
c33f8 000001ed 00000027
[=A0 188.781799] df60: cf82df94 cf82df70 b6fc4068 bebdf6d8 00000001 000=
00078 c000e9c4 00000000
[=A0 188.790374] df80: cf82dfa4 cf82df90 c0011aa0 c002e134 00000000 b6f=
c4068 00000000 cf82dfa8
[=A0 188.798980] dfa0: c000e780 c0011a70 b6fc4068 cf82dfb0 01200011 000=
00000 00000000 00000000
[=A0 188.807586] dfc0: b6fc4068 bebdf6d8 00000001 00000078 b6ee7000 b6f=
c4000 000c3168 bebdf71c
[=A0 188.816192] dfe0: b6fc44c0 bebdf6d8 00000001 b6e52f88 60000010 012=
00011 1b631f25 06fb7edf
[=A0 188.824768] Backtrace:=20
[=A0 188.827362] [<c037cdc0>] (cache_alloc_refill+0x0/0x534) from [<c00=
c3e84>] (kmem_cache_alloc+0x10c/0x11c)
[=A0 188.837341] [<c00c3d78>] (kmem_cache_alloc+0x0/0x11c) from [<c002d=
144>] (dup_mm+0x148/0x3f8)
[=A0 188.846221] [<c002cffc>] (dup_mm+0x0/0x3f8) from [<c002db08>] (cop=
y_process.part.52+0x6c4/0xca8)
[=A0 188.855468] [<c002d444>] (copy_process.part.52+0x0/0xca8) from [<c=
002e248>] (do_fork+0x120/0x318)
[=A0 188.864807] [<c002e128>] (do_fork+0x0/0x318) from [<c0011aa0>] (sy=
s_clone+0x3c/0x44)
[=A0 188.872955] [<c0011a64>] (sys_clone+0x0/0x44) from [<c000e780>] (r=
et_fast_syscall+0x0/0x30)
[=A0 188.881744] Code: e5930010 e5991018 e1500001 3a00000e (e7f001f2)=20
[=A0 188.888244] ---[ end trace af8909ba8c2e9ac7 ]---
[=A0 188.925689] ------------[ cut here ]------------
[=A0 188.930603] kernel BUG at mm/slab.c:3175!
[=A0 188.934814] Internal error: Oops - BUG: 0 [#3] ARM
[=A0 188.939849] Modules linked in:
[=A0 188.943084] CPU: 0=A0=A0=A0 Tainted: G=A0=A0=A0=A0=A0 D=A0=A0=A0=A0=
=A0=A0 (3.4.0-rc6 #8)
[=A0 188.949066] PC is at cache_alloc_refill+0x13c/0x534
[=A0 188.954193] LR is at kmem_cache_alloc+0x10c/0x11c
[=A0 188.959167] pc : [<c037cefc>]=A0=A0=A0 lr : [<c00c3e84>]=A0=A0=A0 =
psr: 60000093
[=A0 188.959167] sp : cedc9e30=A0 ip : 000000d0=A0 fp : cedc9e74
[=A0 188.971221] r10: 00100100=A0 r9 : cf80dec0=A0 r8 : c002d144
[=A0 188.976715] r7 : 00100100=A0 r6 : cf802bc0=A0 r5 : 00200200=A0 r4 =
: cf80c200
[=A0 188.983581] r3 : cfbc4000=A0 r2 : 0000003c=A0 r1 : 0000002c=A0 r0 =
: 0000002c
[=A0 188.990478] Flags: nZCv=A0 IRQs off=A0 FIQs on=A0 Mode SVC_32=A0 I=
SA ARM=A0 Segment user
[=A0 188.998077] Control: 10c5387d=A0 Table: 8ed40019=A0 DAC: 00000015
[=A0 189.004119] Process load-timestamp. (pid: 936, stack limit =3D 0xc=
edc82f0)
[=A0 189.011169] Stack: (0xcedc9e30 to 0xcedca000)
[=A0 189.015747] 9e20:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cf802bd0 0000=
00d0 000000d0 00000000
[=A0 189.024353] 9e40: 000000d0 cf802bc8 cedc9ea4 000000d0 60000013 ced=
3e3c0 000000d0 c002d144
[=A0 189.032958] 9e60: ced629cc cf80dec0 cedc9ea4 cedc9e78 c00c3e84 c03=
7cdcc 00000001 ced629e0
[=A0 189.041564] 9e80: ced629c0 cfb9b808 ced3e3c0 00000001 ced629e0 ced=
629dc cedc9eec cedc9ea8
[=A0 189.050170] 9ea0: c002d144 c00c3d84 cecc10f0 cf528f40 ced3e3f4 ced=
3e574 ced3e540 ced629c0
[=A0 189.058807] 9ec0: cf826a78 01200011 cedc8000 cfb65040 00000000 c05=
33f00 ced4a218 ced4a080
[=A0 189.067413] 9ee0: cedc9f44 cedc9ef0 c002db08 c002d008 cedc9fac c00=
3cc34 cedc9f1c ced4a168
[=A0 189.076019] 9f00: 00000000 cedc9fb0 be89d2f0 00000000 cedc9f3c fff=
ffff4 c003db70 01200011
[=A0 189.084625] 9f20: 00000000 be89d2f0 00000000 cedc9fb0 cedc8000 000=
00000 cedc9f8c cedc9f48
[=A0 189.093231] 9f40: c002e248 c002d450 b6fe8398 00000000 00000000 be8=
9d31c 00000000 be89d31c
[=A0 189.101837] 9f60: 00000008 00000000 b6fe8398 00000000 000003a8 000=
00078 c000e9c4 00000000
[=A0 189.110443] 9f80: cedc9fa4 cedc9f90 c0011aa0 c002e134 00000000 b6f=
e8398 00000000 cedc9fa8
[=A0 189.119049] 9fa0: c000e780 c0011a70 b6fe8398 cedc9fb0 01200011 000=
00000 00000000 00000000
[=A0 189.127655] 9fc0: b6fe8398 00000000 000003a8 00000078 b6f95000 b6f=
e8330 000e2088 be89d314
[=A0 189.136291] 9fe0: b6fe87f0 be89d2f0 000003a8 b6f00f88 60000010 012=
00011 00000000 00000000
[=A0 189.144866] Backtrace:=20
[=A0 189.147460] [<c037cdc0>] (cache_alloc_refill+0x0/0x534) from [<c00=
c3e84>] (kmem_cache_alloc+0x10c/0x11c)
[=A0 189.157470] [<c00c3d78>] (kmem_cache_alloc+0x0/0x11c) from [<c002d=
144>] (dup_mm+0x148/0x3f8)
[=A0 189.166351] [<c002cffc>] (dup_mm+0x0/0x3f8) from [<c002db08>] (cop=
y_process.part.52+0x6c4/0xca8)
[=A0 189.175598] [<c002d444>] (copy_process.part.52+0x0/0xca8) from [<c=
002e248>] (do_fork+0x120/0x318)
[=A0 189.184967] [<c002e128>] (do_fork+0x0/0x318) from [<c0011aa0>] (sy=
s_clone+0x3c/0x44)
[=A0 189.193115] [<c0011a64>] (sys_clone+0x0/0x44) from [<c000e780>] (r=
et_fast_syscall+0x0/0x30)
[=A0 189.201904] Code: e5930010 e5991018 e1500001 3a00000e (e7f001f2)=20
[=A0 189.208404] ---[ end trace af8909ba8c2e9ac8 ]---
[=A0 189.217132] ------------[ cut here ]------------
[=A0 189.222015] kernel BUG at mm/slab.c:3175!
[=A0 189.226226] Internal error: Oops - BUG: 0 [#4] ARM
[=A0 189.231262] Modules linked in:
[=A0 189.234466] CPU: 0=A0=A0=A0 Tainted: G=A0=A0=A0=A0=A0 D=A0=A0=A0=A0=
=A0=A0 (3.4.0-rc6 #8)
[=A0 189.240447] PC is at cache_alloc_refill+0x13c/0x534
[=A0 189.245574] LR is at kmem_cache_alloc+0x10c/0x11c
[=A0 189.250518] pc : [<c037cefc>]=A0=A0=A0 lr : [<c00c3e84>]=A0=A0=A0 =
psr: 60000093
[=A0 189.250549] sp : cee41e98=A0 ip : 000000d0=A0 fp : cee41edc
[=A0 189.262603] r10: 00100100=A0 r9 : cf80dec0=A0 r8 : c00ccd30
[=A0 189.268096] r7 : 00100100=A0 r6 : cf802bc0=A0 r5 : 00200200=A0 r4 =
: cf80c200
[=A0 189.274932] r3 : cfbc4000=A0 r2 : 0000003c=A0 r1 : 0000002c=A0 r0 =
: 0000002c
[=A0 189.281799] Flags: nZCv=A0 IRQs off=A0 FIQs on=A0 Mode SVC_32=A0 I=
SA ARM=A0 Segment user
[=A0 189.289398] Control: 10c5387d=A0 Table: 8ed68019=A0 DAC: 00000015
[=A0 189.295440] Process load-timestamp. (pid: 937, stack limit =3D 0xc=
ee402f0)
[=A0 189.302490] Stack: (0xcee41e98 to 0xcee42000)
[=A0 189.307067] 1e80:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cf802bd0 000000d0
[=A0 189.315673] 1ea0: 000000d0 00000000 000080d0 cf802bc8 000e0a08 000=
080d0 60000013 ced3e840
[=A0 189.324249] 1ec0: 000080d0 c00ccd30 ced3e840 cf80dec0 cee41f0c cee=
41ee0 c00c3e84 c037cdcc
[=A0 189.332855] 1ee0: ced3e840 cec42b80 cec6c9c0 cec42b80 ced3e840 cee=
40000 000e0a08 c0533f10
[=A0 189.341461] 1f00: cee41f44 cee41f10 c00ccd30 c00c3d84 cee41f44 cee=
41f20 c00cbfb0 cec6c9c0
[=A0 189.350067] 1f20: cee40000 cee13000 000e2c48 000e0a08 cec42b80 cee=
41fb0 cee41f84 cee41f48
[=A0 189.358673] 1f40: c00cd120 c00cccdc c00d0f58 00000001 00000000 cec=
102a8 000e0a08 cee13000
[=A0 189.367248] 1f60: cee41fb0 000e0a08 000e2c48 c000e9c4 cee40000 000=
00000 cee41fa4 cee41f88
[=A0 189.375854] 1f80: c0011b28 c00ccfc4 000e21e8 000e2c48 000e0a08 000=
0000b 00000000 cee41fa8
[=A0 189.384460] 1fa0: c000e780 c0011af0 000e21e8 000e2c48 000e21e8 000=
e2c48 000e0a08 000d3afc
[=A0 189.393066] 1fc0: 000e21e8 000e2c48 000e0a08 0000000b 00000000 000=
d9248 00000000 000d6e10
[=A0 189.401672] 1fe0: b6f0126c be89d3cc 00033240 b6f01278 60000010 000=
e21e8 00000000 00000000
[=A0 189.410247] Backtrace:=20
[=A0 189.412841] [<c037cdc0>] (cache_alloc_refill+0x0/0x534) from [<c00=
c3e84>] (kmem_cache_alloc+0x10c/0x11c)
[=A0 189.422821] [<c00c3d78>] (kmem_cache_alloc+0x0/0x11c) from [<c00cc=
d30>] (bprm_mm_init+0x60/0x198)
[=A0 189.432159] [<c00cccd0>] (bprm_mm_init+0x0/0x198) from [<c00cd120>=
] (do_execve+0x168/0x330)
[=A0 189.440948] [<c00ccfb8>] (do_execve+0x0/0x330) from [<c0011b28>] (=
sys_execve+0x44/0x64)
[=A0 189.449371] [<c0011ae4>] (sys_execve+0x0/0x64) from [<c000e780>] (=
ret_fast_syscall+0x0/0x30)
[=A0 189.458221]=A0 r7:0000000b r6:000e0a08 r5:000e2c48 r4:000e21e8
[=A0 189.464202] Code: e5930010 e5991018 e1500001 3a00000e (e7f001f2)=20
[=A0 189.470703] ---[ end trace af8909ba8c2e9ac9 ]---

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
