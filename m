From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Wed, 7 Jan 2015 08:40:06 -0800
Message-ID: <20150107164005.GD4081@atomide.com>
References: <20150105230228.GO4081@atomide.com>
 <20150106080025.GA6752@amd>
 <20150106165903.GF4025@atomide.com>
 <20150107095703.GA15925@amd>
 <54AD5447.2070601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56684 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbbAGQny (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 11:43:54 -0500
Content-Disposition: inline
In-Reply-To: <54AD5447.2070601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>

* Nishanth Menon <nm@ti.com> [150107 07:47]:
> On 01/07/2015 03:57 AM, Pavel Machek wrote:
> > On Tue 2015-01-06 08:59:03, Tony Lindgren wrote:
> >> * Pavel Machek <pavel@ucw.cz> [150106 00:03]:
> >>> On Mon 2015-01-05 15:02:29, Tony Lindgren wrote:
> >>>> Revert "ARM: dts: Disable smc91x on n900 until bootloader
> >>>> dependency is removed". We've now fixed the issues that
> >>>> caused problems with uninitialized hardware depending on
> >>>> the bootloader version. Mostly things got fixed with
> >>>> the following commits:
> >>>>
> >>>> 9a894953a97b ("ARM: dts: Fix bootloader version dependencies by =
muxing n900 smc91x pins")
> >>>> 7d2911c43815 ("net: smc91x: Fix gpios for device tree based boot=
ing")
> >>>>
> >>>> Note that this only affects the early development boards
> >>>> with Ethernet that we still have in a few automated boot
> >>>> test systems.
> >>>>
> >>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >>>
> >>> Normally, the early development boards should have separate dts f=
ile
> >>> (then include common parts), no?
> >>
> >> In this case it won't matter. The GPMC hardware is there, the prob=
e
> >> just fails if no smsc91x is found.
> >> =20
> >>> Could you at least add a note to the dts file what is it? Because=
 I
> >>> always thought it is a bug.
> >>
> >> Sure, updated patch below. Can somebody please test boot it on
> >> a production n900 too to make sure it no longer causes issues?
> >=20
> > Actually... how do you manage your n900 to boot? Does it also boot
> > from 0xffff?
> >=20
> > I believe I'm hitting dtb size limit (again), and 3.19-rc3 does not=
 boot
> > unless I somehow make dtb smaller... like the patch below.
> >=20
> > ---
> >=20
> > make dtb smaller so that it boots.
>=20
> I am using chained boot (NOLO->u-boot->kernel (zImage +dtb
> concatenated) on a real n900
>=20
> I have the same issue as well. using omap2plus_defconfig.
> I was able to bisect next tags as follows: next-20141128 worked,
> next-20141201 stopped booting and the change was new dts addition,
> removing the dts addition helped next-20141201 boot as well.
>=20
> Current state:
>=20
> https://github.com/nmenon/kernel-test-logs/blob/next-20150107/omap2pl=
us_defconfig/n900.txt#L447
>=20
> https://github.com/nmenon/kernel-test-logs/blob/v3.19-rc3/omap2plus_d=
efconfig/n900.txt#L448
>=20
>=20
> I had complained originally here:
> http://marc.info/?t=3D141946203100001&r=3D1&w=3D2 Apologies on not fo=
llowing
> up on the thread, got distracted.

Hmm strange a plain omap2plus_defconfig kernel boots just fine here.
Also boots fine with appended DTB and 0xFFFF using something like:

$ cat arch/arm/boot/zImage arch/arm/boot/dts/omap3-n900.dtb > /tmp/zIma=
ge
$ 0xFFFF -m /tmp/zImage -l -b

My boot log is appended in case that provides any clues. Note that
I'm only loading it with -l and not flashing it though.

Regards,

Tony

=2E..
[   1.943] getting value of option 'R&D flags set'
[   1.948] SETUP: WR VND DEVICE    req 42 value 0000 index 0000 length =
001b
[   1.956] Image 'kernel' won't fit to the partition, still loading it =
(4814592 bytes, while maximum is 2097152 bytes)
[   1.967] Receiving kernel (length 4814592)
[   2.298] Image successfully received
[   2.302] SETUP: WR VND DEVICE    req 82 value 0000 index 0000 length =
0000
[   2.309] SETUP: WR STD INTERFACE SET_INTERFACE      value 0000 index =
0002 length 0000
[   2.363] Boot requested (normal mode)
[   2.367] Serial console enabled
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.19.0-rc1 (tmlind@sampyla) (gcc version 4=
=2E9.2 ( 4.9.2-10) ) #1148 SMP Wed Jan 7 08:27:45 PST 2015
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D=
10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasin=
g instruction cache
[    0.000000] Machine model: Nokia N900
[    0.000000] cma: Reserved 16 MiB at 0x8e800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] PERCPU: Embedded 11 pages/cpu @cfc36000 s14912 r8192 d21=
952 u45056
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 64704
[    0.000000] Kernel command line: root=3D/dev/mmcblk0p2 rootwait cons=
ole=3DttyO2,115200
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072=
 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
[    0.000000] Memory: 223700K/261120K available (6215K kernel code, 67=
4K rwdata, 2360K rodata, 428K init, 8221K bss, 21036K reserved, 16384K =
cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0868204   (8577 kB)
[    0.000000]       .init : 0xc0869000 - 0xc08d4000   ( 428 kB)
[    0.000000]       .data : 0xc08d4000 - 0xc097ca28   ( 675 kB)
[    0.000000]        .bss : 0xc097ca28 - 0xc1184140   (8222 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1=
=2E
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu=
_ids=3D1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 =
interrupts
[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=
 every 65536000000000ns
[    0.000061] OMAP clocksource: 32k_counter at 32768 Hz
[    0.001647] Console: colour dummy device 80x30
[    0.001739] Lock dependency validator: Copyright (c) 2006 Red Hat, I=
nc., Ingo Molnar
[    0.001739] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001770] ... MAX_LOCK_DEPTH:          48
[    0.001800] ... MAX_LOCKDEP_KEYS:        8191
[    0.001800] ... CLASSHASH_SIZE:          4096
[    0.001831] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001831] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001861] ... CHAINHASH_SIZE:          32768
[    0.001861]  memory used by lock dependency info: 5167 kB
[    0.001892]  per task-struct memory footprint: 1152 bytes
[    0.001922] Calibrating delay loop... 496.43 BogoMIPS (lpj=3D2482176=
)
[    0.106933] pid_max: default: 32768 minimum: 301
[    0.107604] Security Framework initialized
[    0.107940] Mount-cache hash table entries: 1024 (order: 0, 4096 byt=
es)
[    0.107971] Mountpoint-cache hash table entries: 1024 (order: 0, 409=
6 bytes)
[    0.113647] Initializing cgroup subsys memory
[    0.113800] Initializing cgroup subsys devices
[    0.113952] Initializing cgroup subsys freezer
[    0.114105] Initializing cgroup subsys blkio
[    0.114257] Initializing cgroup subsys perf_event
[    0.114410] CPU: Testing write buffer coherency: ok
[    0.116790] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.117126] Setting up static identity map for 0x805e7ee0 - 0x805e7f=
50
[    0.123565] Brought up 1 CPUs
[    0.123596] CPU: All CPU(s) started in SVC mode.
[    0.129669] devtmpfs: initialized
[    0.133514] VFP support v0.3: implementor 41 architecture 3 part 30 =
variant c rev 1
[    0.251525] omap_hwmod: mcbsp2_sidetone using broken dt data from mc=
bsp
[    0.254882] omap_hwmod: mcbsp3_sidetone using broken dt data from mc=
bsp
[    0.343383] omap_hwmod: mcbsp2: cannot be enabled for reset (3)
[    0.368804] pinctrl core: initialized pinctrl subsystem
[    0.520080] NET: Registered protocol family 16
[    0.534118] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.538330] cpuidle: using governor ladder
[    0.538391] cpuidle: using governor menu
[    0.541290] Reprogramming SDRC clock to 332000000 Hz
[    0.561035] OMAP GPIO hardware version 2.5
[    0.581329] irq: no irq domain found for /ocp/pinmux@48002030 !
[    0.582611] irq: no irq domain found for /ocp/pinmux@48002030 !
[    0.617950] omap-gpmc 6e000000.gpmc: could not find pctldev for node=
 /ocp/pinmux@48002030/pinmux_gpmc_pins, deferring probe
[    0.618041] platform 6e000000.gpmc: Driver omap-gpmc requests probe =
deferral
[    0.631927] No ATAGs?
[    0.631988] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.637176] Reserving DMA channels 0 and 1 for HS ROM code
[    0.637237] OMAP DMA hardware revision 4.0
[    0.761474] omap-dma-engine 48056000.dma-controller: OMAP DMA engine=
 driver
[    0.769653] SCSI subsystem initialized
[    0.772430] usbcore: registered new interface driver usbfs
[    0.772796] usbcore: registered new interface driver hub
[    0.773040] usbcore: registered new device driver usb
[    0.774902] omap_i2c 48070000.i2c: could not find pctldev for node /=
ocp/pinmux@48002030/pinmux_i2c1_pins, deferring probe
[    0.774963] platform 48070000.i2c: Driver omap_i2c requests probe de=
ferral
[    0.775146] omap_i2c 48072000.i2c: could not find pctldev for node /=
ocp/pinmux@48002030/pinmux_i2c2_pins, deferring probe
[    0.775207] platform 48072000.i2c: Driver omap_i2c requests probe de=
ferral
[    0.775360] omap_i2c 48060000.i2c: could not find pctldev for node /=
ocp/pinmux@48002030/pinmux_i2c3_pins, deferring probe
[    0.775390] platform 48060000.i2c: Driver omap_i2c requests probe de=
ferral
[    0.783599] Switched to clocksource 32k_counter
[    1.078643] NET: Registered protocol family 2
[    1.081787] TCP established hash table entries: 2048 (order: 1, 8192=
 bytes)
[    1.082061] TCP bind hash table entries: 2048 (order: 4, 73728 bytes=
)
[    1.083251] TCP: Hash tables configured (established 2048 bind 2048)
[    1.083831] TCP: reno registered
[    1.083892] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    1.084228] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    1.086212] NET: Registered protocol family 1
[    1.088867] RPC: Registered named UNIX socket transport module.
[    1.088928] RPC: Registered udp transport module.
[    1.088928] RPC: Registered tcp transport module.
[    1.088958] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    1.091400] hw perfevents: enabled with armv7_cortex_a8 PMU driver, =
5 counters available
[    1.101806] futex hash table entries: 256 (order: 2, 16384 bytes)
[    1.102233] audit: initializing netlink subsys (disabled)
[    1.102661] audit: type=3D2000 audit(1.080:1): initialized
[    1.110931] VFS: Disk quotas dquot_6.5.2
[    1.111236] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096=
 bytes)
[    1.115966] NFS: Registering the id_resolver key type
[    1.116638] Key type id_resolver registered
[    1.116668] Key type id_legacy registered
[    1.117004] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed Hat, Inc.
[    1.125732] io scheduler noop registered
[    1.125793] io scheduler deadline registered
[    1.125976] io scheduler cfq registered (default)
[    1.131042] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 =
size 568
[    1.132049] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 s=
ize 92
[    1.133605] pinctrl-single 480025d8.pinmux: 18 pins at pa fa0025d8 s=
ize 36
[    1.144012] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.158020] omap_uart 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq=
 =3D 223, base_baud =3D 3000000) is a OMAP UART1
[    1.162597] omap_uart 49020000.serial: ttyO2 at MMIO 0x49020000 (irq=
 =3D 224, base_baud =3D 3000000) is a OMAP UART2
[    1.953918] console [ttyO2] enabled
[    2.005004] brd: module loaded
[    2.034637] loop: module loaded
[    2.045440] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    2.079437] usbcore: registered new interface driver asix
[    2.085571] usbcore: registered new interface driver ax88179_178a
[    2.092285] usbcore: registered new interface driver cdc_ether
[    2.098907] usbcore: registered new interface driver smsc95xx
[    2.105285] usbcore: registered new interface driver net1080
[    2.111541] usbcore: registered new interface driver cdc_subset
[    2.118103] usbcore: registered new interface driver zaurus
[    2.124481] usbcore: registered new interface driver cdc_ncm
[    2.132568] usbcore: registered new interface driver cdc_wdm
[    2.139099] usbcore: registered new interface driver usb-storage
[    2.145874] usbcore: registered new interface driver usbtest
[    2.156066] mousedev: PS/2 mouse device common for all mice
[    2.166717] i2c /dev entries driver
[    2.170562] Driver for 1-wire Dallas network protocol.
[    2.181427] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    2.190826] Driver 'mmcblk' needs updating - please use bus_type met=
hods
[    2.201782] omap_hsmmc 4809c000.mmc: unable to get vmmc regulator -5=
17
[    2.209716] platform 4809c000.mmc: Driver omap_hsmmc requests probe =
deferral
[    2.218811] omap_hsmmc 480b4000.mmc: unable to get vmmc regulator -5=
17
[    2.226135] platform 480b4000.mmc: Driver omap_hsmmc requests probe =
deferral
[    2.236785] ledtrig-cpu: registered to indicate activity on CPUs
[    2.244781] usbcore: registered new interface driver usbhid
[    2.250701] usbhid: USB HID core driver
[    2.257781] oprofile: using arm/armv7
[    2.262847] TCP: cubic registered
[    2.266571] Initializing XFRM netlink socket
[    2.271331] NET: Registered protocol family 17
[    2.276245] NET: Registered protocol family 15
[    2.281585] Key type dns_resolver registered
[    2.286590] omap2_set_init_voltage: unable to find boot up OPP for v=
dd_mpu_iva
[    2.294311] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    2.300445] omap2_set_init_voltage: unable to find boot up OPP for v=
dd_core
[    2.307861] omap2_set_init_voltage: unable to set vdd_core
[    2.316528] platform cpufreq-dt.0: Driver cpufreq-dt requests probe =
deferral
[    2.332305] ThumbEE CPU extension supported.
[    2.337036] Registering SWP/SWPB emulation handler
[    2.342132] SmartReflex Class3 initialized
[    2.356750] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    2.365081] omap2-onenand omap2-onenand: initializing on CS0, phys b=
ase 0x04000000, virtual base d08c0000, freq 83 MHz
[    2.376556] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    2.381561] OneNAND version =3D 0x0031
[    2.387603] Scanning device for bad blocks
[    2.520599] 6 ofpart partitions found on MTD device omap2-onenand
[    2.527099] Creating 6 MTD partitions on "omap2-onenand":
[    2.532867] 0x000000000000-0x000000020000 : "bootloader"
[    2.549591] 0x000000020000-0x000000080000 : "config"
[    2.561737] 0x000000080000-0x0000000c0000 : "log"
[    2.573150] 0x0000000c0000-0x0000002c0000 : "kernel"
[    2.585357] 0x0000002c0000-0x0000004c0000 : "initfs"
[    2.597259] 0x0000004c0000-0x000010000000 : "rootfs"
[    2.630493] smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxn=
ic.net>
[    2.642761] smc91x 2000300.ethernet eth0: SMC91C94 (rev 9) at d08063=
00 IRQ 81
[    2.650451]=20
[    2.652038] smc91x 2000300.ethernet eth0: Ethernet addr: xx:xx:xx:xx=
:xx:xx
[    2.686737] twl 0-0048: PIH (irq 295) chaining IRQs 296..304
[    2.693664] twl 0-0048: power (irq 301) chaining IRQs 304..311
[    2.705352] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[    2.720214] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 48=
070000.i2c:twl@48 as rtc0
[    2.816497] twl4030_gpio twl4030-gpio: gpio (irq 296) chaining IRQs =
312..329
[    2.838165] input: twl4030_pwrbutton as /devices/platform/68000000.o=
cp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@48:pwrbutton/input/input0
[    2.858551] input: TWL4030 Keypad as /devices/platform/68000000.ocp/=
48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@48:keypad/input/input1
[    2.956573] omap_i2c 48070000.i2c: bus 0 rev3.3 at 2200 kHz
[    2.981903] omap_i2c 48072000.i2c: bus 1 rev3.3 at 100 kHz
[    2.991973] omap_i2c 48060000.i2c: bus 2 rev3.3 at 400 kHz
[    3.115447] input: gpio_keys as /devices/platform/gpio_keys/input/in=
put2
[    3.128417] twl_rtc 48070000.i2c:twl@48:rtc: setting system clock to=
 2000-01-01 00:04:44 UTC (946685084)
[    3.138549] sr_init: No PMIC hook to init smartreflex
[    3.144500] smartreflex smartreflex.0: omap_sr_probe: SmartReflex dr=
iver initialized
[    3.153991] smartreflex smartreflex.1: omap_sr_probe: SmartReflex dr=
iver initialized
[    3.263702] VUSB3V1: disabling
[    3.269073] VUSB1V8: disabling
[    3.275421] VUSB1V5: disabling
[    3.280303] VCSI: disabling
[    3.289428] Waiting for root device /dev/mmcblk0p2...
[    3.432678] mmc1: switch to bus width 2 failed
[    3.438171] mmc1: switch to bus width 1 failed
[    3.442993] mmc1: new high speed MMC card at address 0001
[    3.453186] mmcblk0: mmc1:0001 MMC32G 29.8 GiB=20
[    3.459167] mmcblk0boot0: mmc1:0001 MMC32G partition 1 512 KiB
[    3.466308] mmcblk0boot1: mmc1:0001 MMC32G partition 2 512 KiB
[    3.481109]  mmcblk0: p1 p2 p3 p4
[    3.525909] EXT3-fs (mmcblk0p2): recovery required on readonly files=
ystem
[    3.533142] EXT3-fs (mmcblk0p2): write access will be enabled during=
 recovery
[    9.212371] kjournald starting.  Commit interval 5 seconds
[    9.239501] EXT3-fs (mmcblk0p2): recovery complete
[    9.245086] EXT3-fs (mmcblk0p2): mounted filesystem with ordered dat=
a mode
[    9.253295] VFS: Mounted root (ext3 filesystem) readonly on device 1=
79:2.
[    9.278625] devtmpfs: mounted
[    9.289184] Freeing unused kernel memory: 428K (c0869000 - c08d4000)
INIT: version 2.86 booting
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
