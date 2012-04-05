From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Thu, 5 Apr 2012 04:07:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1876802551-1333620462=:10302"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49209 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab2DEKHn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 06:07:43 -0400
In-Reply-To: <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1876802551-1333620462=:10302
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Apr 2012, Paul Walmsley wrote:

> I just rebased this series on top of v3.4-rc1 and built each patch in it=
=20
> successfully, so it sounds like there's some bisection-specific build=20
> problem?

Okay, a quick update.  Just tried with a different .config, and can
reproduce the following build problem with patch 2 of the IO wakeup
series, in code that is later removed by patch 6:

arch/arm/mach-omap2/pm34xx.c: In function 'omap_sram_idle':
arch/arm/mach-omap2/pm34xx.c:281:4: error: implicit declaration of function=
 'omap3_reconfigure_io_chain'

That's my mistake and I will correct it here and send a new pull request,=
=20
once we figure out what's going on with your boot hang.

> As far as the crashes go, I don't think I have an OMAP3EVM, but I'll take=
=20
> a look here on the OMAP35xx boards that I do have.

I just booted the 'io_chain_devel_3.5' branch from=20
git://git.pwsan.com/linux-2.6 on a 35xx ES3.0 BeagleBoard with no=20
problems.  Could you please try booting this branch on your OMAP3EVM?


- Paul

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc1-00006-g297624c (paul@dusk) (gcc vers=
ion 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #404 SMP T2
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c=
53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing in=
struction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0e53000 s11456 r8192 d13120 u=
32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64768
[    0.000000] Kernel command line: console=3DttyO2,115200n8 root=3D/dev/mm=
cblk0p2 rw rootfstype=3Dext3 mem=3D256M rootwait earlyprintk
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes=
)
[    0.000000] Memory: 255MB =3D 255MB total
[    0.000000] Memory: 246220k/246220k available, 15924k reserved, 0K highm=
em
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0619ee8   (6216 kB)
[    0.000000]       .init : 0xc061a000 - 0xc0667cc0   ( 312 kB)
[    0.000000]       .data : 0xc0668000 - 0xc06f9c98   ( 584 kB)
[    0.000000]        .bss : 0xc06f9cbc - 0xc0c4df60   (5457 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 inte=
rrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001129] Calibrating delay loop... 471.61 BogoMIPS (lpj=3D1843200)
[    0.081909] pid_max: default: 32768 minimum: 301
[    0.082916] Security Framework initialized
[    0.083282] Mount-cache hash table entries: 512
[    0.089874] CPU: Testing write buffer coherency: ok
[    0.091033] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.091186] Setting up static identity map for 0x80472300 - 0x80472370
[    0.093597] Brought up 1 CPUs
[    0.093627] SMP: Total of 1 processors activated (471.61 BogoMIPS).
[    0.110290] omap_hwmod: usbtll_fck: missing clockdomain for usbtll_fck.
[    0.120819] dummy:=20
[    0.123565] NET: Registered protocol family 16
[    0.125244] GPMC revision 5.0
[    0.139343] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.140014] OMAP GPIO hardware version 2.5
[    0.141448] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.143920] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.145812] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.147735] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.150115] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.159545] omap_mux_init: Add partition: #1: core, flags: 0
[    0.162933] OMAP3 Beagle Rev: C1/C2/C3
[    0.181488] Reprogramming SDRC clock to 332000000 Hz
[    0.182769] Found NAND on CS0
[    0.182800] Registering NAND on CS0
[    0.184143] Unable to get DVI reset GPIO
[    0.184783] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.205902]  omap-mcbsp.2: alias fck already exists
[    0.206970]  omap-mcbsp.3: alias fck already exists
[    0.213409] OMAP DMA hardware revision 4.0
[    0.306060] bio: create slab <bio-0> at 0
[    0.317718] SCSI subsystem initialized
[    0.320770] omap2_mcspi omap2_mcspi.1: master is unqueued, this is depre=
cated
[    0.322631] omap2_mcspi omap2_mcspi.2: master is unqueued, this is depre=
cated
[    0.324310] omap2_mcspi omap2_mcspi.3: master is unqueued, this is depre=
cated
[    0.325958] omap2_mcspi omap2_mcspi.4: master is unqueued, this is depre=
cated
[    0.331054] usbcore: registered new interface driver usbfs
[    0.332489] usbcore: registered new interface driver hub
[    0.333648] usbcore: registered new device driver usb
[    0.350738] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2600 kHz
[    0.363159] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.363983] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.367584] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs 336.=
=2E353
[    0.369506] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
[    0.379791] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.383148] VDAC: 1800 mV normal standby
[    0.386169] VDVI: 1800 mV normal standby
[    0.389831] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.402526] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 100 kHz
[    0.415069] Switching to clocksource 32k_counter
[    0.573272] NET: Registered protocol family 2
[    0.574493] IP route cache hash table entries: 2048 (order: 1, 8192 byte=
s)
[    0.577209] TCP established hash table entries: 8192 (order: 4, 65536 by=
tes)
[    0.577758] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.583679] TCP: Hash tables configured (established 8192 bind 8192)
[    0.583801] TCP: reno registered
[    0.583831] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    0.584259] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    0.585540] NET: Registered protocol family 1
[    0.587860] RPC: Registered named UNIX socket transport module.
[    0.587890] RPC: Registered udp transport module.
[    0.587921] RPC: Registered tcp transport module.
[    0.587951] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.589294] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.789123] VFS: Disk quotas dquot_6.5.2
[    0.789581] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.791992] NFS: Registering the id_resolver key type
[    0.794372] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat,=
 Inc.
[    0.795989] msgmni has been set to 480
[    0.801025] io scheduler noop registered
[    0.801055] io scheduler deadline registered
[    0.801391] io scheduler cfq registered (default)
[    0.804809] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.814666] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP=
 UART0
[    0.817138] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OMAP=
 UART1
[    0.819030] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OMAP=
 UART2
[    1.513580] console [ttyO2] enabled
[    1.565673] brd: module loaded
[    1.596466] loop: module loaded
[    1.610229] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    1.618103] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NA=
ND 256MiB 1,8V 16-bit)
[    1.628662] Creating 5 MTD partitions on "omap2-nand.0":
[    1.634735] 0x000000000000-0x000000080000 : "X-Loader"
[    1.649414] 0x000000080000-0x000000260000 : "U-Boot"
[    1.662841] 0x000000260000-0x000000280000 : "U-Boot Env"
[    1.674957] 0x000000280000-0x000000680000 : "Kernel"
[    1.689697] 0x000000680000-0x000010000000 : "File System"
[    1.912414] OneNAND driver initializing
[    1.927124] usbcore: registered new interface driver asix
[    1.933990] usbcore: registered new interface driver cdc_ether
[    1.941162] usbcore: registered new interface driver net1080
[    1.948059] usbcore: registered new interface driver cdc_subset
[    1.955261] usbcore: registered new interface driver zaurus
[    1.961975] usbcore: registered new interface driver cdc_ncm
[    1.971313] usbcore: registered new interface driver cdc_wdm
[    1.977325] Initializing USB Mass Storage driver...
[    1.983459] usbcore: registered new interface driver usb-storage
[    1.990539] USB Mass Storage support registered.
[    1.997406] usbcore: registered new interface driver libusual
[    2.004547] usbcore: registered new interface driver usbtest
[    2.012969] mousedev: PS/2 mouse device common for all mice
[    2.027038] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1/i2c=
-1/1-0049/twl4030_pwrbutton/input/input0
[    2.041839] twl_rtc twl_rtc: Power up reset detected.
[    2.047393] twl_rtc twl_rtc: Enabling TWL-RTC
[    2.057220] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    2.065704] i2c /dev entries driver
[    2.073730] Driver for 1-wire Dallas network protocol.
[    2.083709] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 s=
ec
[    2.092620] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.099578] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.341522] usbcore: registered new interface driver usbhid
[    2.347595] usbhid: USB HID core driver
[    2.351654] oprofile: hardware counters not available
[    2.357086] oprofile: using timer interrupt.
[    2.362823] TCP: cubic registered
[    2.366333] Initializing XFRM netlink socket
[    2.371185] NET: Registered protocol family 17
[    2.376007] NET: Registered protocol family 15
[    2.381225] Registering the dns_resolver key type
[    2.386566] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant c rev 1
[    2.394897] ThumbEE CPU extension supported.
[    2.413299] PM: no software I/O chain control; some wakeups may be lost
[    2.465332] clock: disabling unused clocks to save power
[    2.477233] VDVI: incomplete constraints, leaving on
[    2.482910] VDAC: incomplete constraints, leaving on
[    2.491607] input: gpio-keys as /devices/platform/gpio-keys/input/input1
[    2.503631] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00=
 UTC (946684800)
[    2.517578] Waiting for root device /dev/mmcblk0p2...
[    2.662017] mmc0: new SD card at address 8001
[    2.670501] mmcblk0: mmc0:8001 SD02G 1.89 GiB=20
[    2.683380]  mmcblk0: p1 p2
[    3.949035] kjournald starting.  Commit interval 5 seconds
[    3.955596] EXT3-fs (mmcblk0p2): warning: maximal mount count reached, r=
unning e2fsck is recommended
[    4.150268] EXT3-fs (mmcblk0p2): using internal journal
[    4.160461] EXT3-fs (mmcblk0p2): recovery complete
[    4.165649] EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mo=
de
[    4.173645] VFS: Mounted root (ext3 filesystem) on device 179:2.
[    4.181121] Freeing init memory: 308K

--155748971-1876802551-1333620462=:10302--
