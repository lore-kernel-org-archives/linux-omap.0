From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Sat, 1 Aug 2015 12:18:44 +0200
Message-ID: <201508011218.45076@pali>
References: <201507251228.27128@pali> <55B38C59.8060001@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4949645.MDzzsSJ7S8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B38C59.8060001@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

--nextPart4949645.MDzzsSJ7S8
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 25 July 2015 15:17:13 Lars-Peter Clausen wrote:
> On 07/25/2015 12:28 PM, Pali Roh=C3=A1r wrote:
> > Hello,
> >=20
> > sometimes after rebooting Nokia N900 initializing alsa audio fails.
> > Here output from dmesg log when it happen:
> >=20
> > [    6.925140] tpa6130a2 2-0060: Write failed
> > [    6.929534] tpa6130a2 2-0060: Failed to initialize chip
> > [    6.935272] tpa6130a2: probe of 2-0060 failed with error -121
> > [    7.624237] rx51-audio n900-audio: Failed to add TPA6130A2
> > controls [    7.635101] rx51-audio n900-audio: ASoC: failed to
> > init TLV320AIC34: -19 [    7.645874] rx51-audio n900-audio: ASoC:
> > failed to instantiate card -19 [    7.665740] rx51-audio
> > n900-audio: snd_soc_register_card failed (-19) [    8.063049] ALSA
> > device list:
> > [    8.070343]   No soundcards found.
> >=20
> > Any idea what to do?
>=20
> Looks like the chip is not responding. Try to add a small delay after
> powerup to give the device to be fully ready, something like the
> following:
>=20
> --- a/sound/soc/codecs/tpa6130a2.c
> +++ b/sound/soc/codecs/tpa6130a2.c
> @@ -152,6 +152,8 @@ static int tpa6130a2_power(u8 power)
>   		if (data->power_gpio >=3D 0)
>   			gpio_set_value(data->power_gpio, 1);
>=20
> +		msleep(5);
> +
>   		data->power_state =3D 1;
>   		ret =3D tpa6130a2_initialize();
>   		if (ret < 0) {


Hello, your patch did not helped. Problem is still there...

Now I found another problem:
[   28.102233] omap_i2c 48072000.i2c: controller timed out

Anyway, if you are interested here is full dmesg log:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 4.2.0-rc2+ (pali@Pali-Latitude) (gcc version 4=
=2E6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #368=20
PREEMPT Sat Aug 1 12:07:46 CEST 2015
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c=
5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing in=
struction cache
[    0.000000] Machine model: Nokia N900
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c069a40c, node_mem_map cf=
cf9000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65280 pages, LIFO batch:15
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64768
[    0.000000] Kernel command line: rootdelay root=3D/dev/ram0 log_buf_len=
=3D20M
[    0.000000] log_buf_len: 33554432 bytes
[    0.000000] early log buf free: 64332(98%)
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 203424K/261120K available (4443K kernel code, 308K r=
wdata, 1720K rodata, 264K init, 266K bss,=20
57696K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc060d0c8   (6165 kB)
[    0.000000]       .init : 0xc060e000 - 0xc0650000   ( 264 kB)
[    0.000000]       .data : 0xc0650000 - 0xc069d3dc   ( 309 kB)
[    0.000000]        .bss : 0xc069d3dc - 0xc06dfc4c   ( 267 kB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 inte=
rrupts
[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xfff=
fffff, max_idle_ns: 58327039986419 ns
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 65535999984741ns
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000305] Console: colour dummy device 80x30
[    0.001586] console [tty0] enabled
[    0.001647] Calibrating delay loop... 496.43 BogoMIPS (lpj=3D2482176)
[    0.048828] pid_max: default: 32768 minimum: 301
[    0.048980] Security Framework initialized
[    0.049102] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.049163] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 by=
tes)
[    0.050354] Initializing cgroup subsys blkio
[    0.050445] Initializing cgroup subsys freezer
[    0.050567] CPU: Testing write buffer coherency: ok
[    0.051239] Setting up static identity map for 0x80008200 - 0x80008258
[    0.054779] devtmpfs: initialized
[    0.101928] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant c rev 1
[    0.123107] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.123840] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    0.173553] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 19112604462750000 ns
[    0.174530] pinctrl core: initialized pinctrl subsystem
[    0.176361] NET: Registered protocol family 16
[    0.177978] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.208465] cpuidle: using governor ladder
[    0.238403] cpuidle: using governor menu
[    0.239074] Reprogramming SDRC clock to 332000000 Hz
[    0.245819] OMAP GPIO hardware version 2.5
[    0.252288] irq: no irq domain found for /ocp/l4@48000000/scm@2000/pinmu=
x@30 !
[    0.252990] irq: no irq domain found for /ocp/l4@48000000/scm@2000/pinmu=
x@30 !
[    0.267974] omap-gpmc 6e000000.gpmc: could not find pctldev for node=20
/ocp/l4@48000000/scm@2000/pinmux@30/pinmux_gpmc_pins, deferring probe
[    0.272857] RX-51: Enabling ARM errata 430973 workaround
[    0.274658] RX-51: Registring OMAP3 HWRNG device
[    0.278564] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.280212] Reserving DMA channels 0 and 1 for HS ROM code
[    0.280273] OMAP DMA hardware revision 4.0
[    0.330078] omap-dma-engine 48056000.dma-controller: OMAP DMA engine dri=
ver
[    0.335510] omap-iommu 480bd400.mmu: 480bd400.mmu registered
[    0.336303] usbcore: registered new interface driver usbfs
[    0.336486] usbcore: registered new interface driver hub
[    0.336730] usbcore: registered new device driver usb
[    0.337860] omap_i2c 48070000.i2c: could not find pctldev for node=20
/ocp/l4@48000000/scm@2000/pinmux@30/pinmux_i2c1_pins, deferring probe
[    0.338012] omap_i2c 48072000.i2c: could not find pctldev for node=20
/ocp/l4@48000000/scm@2000/pinmux@30/pinmux_i2c2_pins, deferring probe
[    0.338226] omap_i2c 48060000.i2c: could not find pctldev for node=20
/ocp/l4@48000000/scm@2000/pinmux@30/pinmux_i2c3_pins, deferring probe
[    0.339782] omap-mailbox 48094000.mailbox: omap mailbox rev 0x40
[    0.340423] Advanced Linux Sound Architecture Driver Initialized.
[    0.341979] clocksource: Switched to clocksource 32k_counter
[    0.383239] NET: Registered protocol family 2
[    0.384521] TCP established hash table entries: 2048 (order: 1, 8192 byt=
es)
[    0.384643] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.384735] TCP: Hash tables configured (established 2048 bind 2048)
[    0.384948] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.385009] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.385314] NET: Registered protocol family 1
[    0.385864] Trying to unpack rootfs image as initramfs...
[    0.386383] rootfs image is not initramfs (junk in compressed archive); =
looks like an initrd
[    0.518432] Freeing initrd memory: 15240K (ce900000 - cf7e2000)
[    0.519073] hw perfevents: Failed to parse /pmu/interrupt-affinity[0]
[    0.519226] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 co=
unters available
[    0.523986] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.541168] VFS: Disk quotas dquot_6.6.0
[    0.541687] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.544769] io scheduler noop registered
[    0.545288] io scheduler cfq registered (default)
[    0.546813] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size=
 568
[    0.547302] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size =
92
[    0.548004] pinctrl-single 480025d8.pinmux: 18 pins at pa fa0025d8 size =
36
[    0.550445] 48050000.dss supply vdda_video not found, using dummy regula=
tor
[    0.550781] OMAP DSS rev 2.0
[    0.551452] omapdss_dss 48050000.dss: bound 48050400.dispc (ops dispc_co=
mponent_ops)
[    0.551910] omapdss_dss 48050000.dss: bound 48050c00.encoder (ops venc_c=
omponent_ops)
[    0.553375] omapfb omapfb: no displays
[    0.553588] omapfb omapfb: failed to setup omapfb
[    0.554199] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.557464] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq =3D 89, base_=
baud =3D 3000000) is a OMAP UART1
[    0.558685] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq =3D 90, base_=
baud =3D 3000000) is a OMAP UART2
[    0.560394] omap3_rom_rng: initializing
[    0.586517] brd: module loaded
[    0.596771] loop: module loaded
[    0.598266] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    0.611114] acx565akm spi1.2: omapfb: acx565akm rev ad LCD detected
[    0.615112] HS USB OTG: no transceiver configured
[    0.615203] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with=
 status -517
[    0.616577] i2c /dev entries driver
[    0.618164] omap_hsmmc 4809c000.mmc: unable to get vmmc regulator -517
[    0.643157] omap_hsmmc 480b4000.mmc: unable to get vmmc regulator -517
[    0.675903] rx51-audio n900-audio: could not get speaker enable gpio
[    0.676788] Initializing XFRM netlink socket
[    0.676940] NET: Registered protocol family 17
[    0.677062] NET: Registered protocol family 15
[    0.677185] NET: Registered protocol family 35
[    0.677429] Key type dns_resolver registered
[    0.677734] omap2_set_init_voltage: unable to find boot up OPP for vdd_m=
pu_iva
[    0.677825] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    0.677886] omap2_set_init_voltage: unable to find boot up OPP for vdd_c=
ore
[    0.677947] omap2_set_init_voltage: unable to set vdd_core
[    0.682861] ThumbEE CPU extension supported.
[    0.682952] SmartReflex Class3 initialized
[    0.689971] registered taskstats version 1
[    0.692565] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.692657] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    0.693359] omap2-onenand omap2-onenand: initializing on CS0, phys base =
0x01000000, virtual base d0940000, freq 66 MHz
[    0.693450] OneNAND Manufacturer: Samsung (0xec)
[    0.693481] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    0.693542] OneNAND version =3D 0x0121
[    0.693572] Chip support all block unlock
[    0.693572] Chip has 2 plane
[    0.695281] Scanning device for bad blocks
[    0.795776] 6 ofpart partitions found on MTD device omap2-onenand
[    0.795837] Creating 6 MTD partitions on "omap2-onenand":
[    0.795898] 0x000000000000-0x000000020000 : "bootloader"
[    0.796783] 0x000000020000-0x000000080000 : "config"
[    0.797637] 0x000000080000-0x0000000c0000 : "log"
[    0.798370] 0x0000000c0000-0x0000002c0000 : "kernel"
[    0.799133] 0x0000002c0000-0x0000004c0000 : "initfs"
[    0.799896] 0x0000004c0000-0x000010000000 : "rootfs"
[    1.102752] twl 1-0048: PIH (irq 23) chaining IRQs 340..348
[    1.102966] twl 1-0048: power (irq 345) chaining IRQs 348..355
[    1.662963] twl4030_gpio twl4030-gpio: gpio (irq 340) chaining IRQs 356.=
=2E373
[    1.922668] twl4030_usb 48070000.i2c:twl@48:twl4030-usb: Initialized TWL=
4030 USB module
[    1.925415] input: twl4030_pwrbutton as=20
/devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@4=
8:pwrbutton/input/input0
[    1.927185] input: TWL4030 Keypad as=20
/devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@4=
8:keypad/input/input1
[    5.942382] omap_i2c 48070000.i2c: bus 1 rev3.3 at 2200 kHz
[    5.962585] tpa6130a2 2-0060: Write failed
[    5.962707] tpa6130a2 2-0060: Failed to initialize chip
[    5.962860] tpa6130a2: probe of 2-0060 failed with error -121
[    5.963439] omap_i2c 48072000.i2c: bus 2 rev3.3 at 100 kHz
[    5.965820] omap_i2c 48060000.i2c: bus 3 rev3.3 at 400 kHz
[    5.992004] Console: switching to colour frame buffer device 100x30
[    6.072662] omapfb omapfb: using display 'lcd' mode 800x480
[    6.273071] musb-hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk combin=
e, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
[    6.273101] musb-hdrc: MHDRC RTL version 1.400=20
[    6.273132] musb-hdrc: setup fifo_mode 4
[    6.273162] musb-hdrc: 28/31 max ep, 16384/16384 memory
[    6.574035] rx51-audio n900-audio: Failed to add TPA6130A2 controls
[    6.580657] rx51-audio n900-audio: ASoC: failed to init TLV320AIC34: -19
[    6.587554] rx51-audio n900-audio: ASoC: failed to instantiate card -19
[    6.594146] gpiod_unexport: invalid GPIO
[    6.600555] rx51-audio n900-audio: snd_soc_register_card failed (-19)
[    6.623199] hctosys: unable to open rtc device (rtc0)
[    6.629699] sr_init: No PMIC hook to init smartreflex
[    6.637237] using random self ethernet address
[    6.643829] using random host ethernet address
[    6.650268] Number of LUNs=3D8
[    6.657165] smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver=
 initialized
[    6.664276] Mass Storage Function, version: 2009/09/11
[    6.671386] LUN: removable file: (no medium)
[    6.678833] smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver=
 initialized
[    6.692260] Number of LUNs=3D2
[    6.699798] LUN: removable file: (no medium)
[    6.719238] VCSI: disabling
[    6.726684] LUN: removable file: (no medium)
[    6.733795] Number of LUNs=3D2
[    6.741546] g_nokia gadget: USB CDC Phonet function
[    6.748138] g_nokia gadget: using musb-hdrc, OUT ep1out, IN ep1in
[    6.755035] ALSA device list:
[    6.761291]   No soundcards found.
[    6.768676] usb0: HOST MAC 52:35:2b:7b:77:0e
[    6.775085] usb0: MAC 32:e8:ee:88:a4:58
[    6.782043] RAMDISK: cramfs filesystem found at block 0
[    6.788543] RAMDISK: Loading 15240KiB [1 disk] into ram disk... /
[    6.792358] g_nokia gadget: USB CDC Phonet function
[    6.804992] -
[    6.822235] g_nokia gadget: using musb-hdrc, OUT ep1out, IN ep1in
[    6.834808] \
[    6.852539] g_nokia gadget: N900 (PC-Suite Mode)
[    6.865417] /
[    6.872253] g_nokia gadget: g_nokia ready
[    6.885009] done.
[    7.333801] VFS: Mounted root (cramfs filesystem) readonly on device 1:0.
[    7.340911] Freeing unused kernel memory: 264K (c060e000 - c0650000)
[    7.621368] g_nokia gadget: high-speed config #1: Bus Powered
[    7.681365] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 s=
ec
[   13.258148] omap-sham 480c3000.sham: hw accel on OMAP rev 0.9
[   13.333465] input: TSC2005 touchscreen as=20
/devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/in=
put2
[   15.720733] input: twl4030:vibrator as=20
/devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@4=
8:audio/input/input3
[   23.654785] media: Linux media interface: v0.10
[   25.393402] tsl2563 2-0029: model 7, rev. 0
[   25.772796] Linux video capture interface: v2.00
[   28.102233] omap_i2c 48072000.i2c: controller timed out
[   29.463653] lp5523x 2-0032: lp5523 Programmable led chip found
[   30.734191] omap_i2c 48072000.i2c: controller timed out waiting for star=
t condition to finish
[   32.142333] i2c i2c-2: SCL is stuck low, exit recovery
[   33.162322] i2c i2c-2: SCL is stuck low, exit recovery
[   34.462249] i2c i2c-2: SCL is stuck low, exit recovery
[   35.482299] i2c i2c-2: SCL is stuck low, exit recovery
[   36.862762] omap_ssi 48058000.ssi-controller: ssi controller 0 initializ=
ed (1 ports)!
[   37.113800] smc91x: not found (-19).
[   37.132263] i2c i2c-2: SCL is stuck low, exit recovery
[   38.962341] i2c i2c-2: SCL is stuck low, exit recovery
[   39.122406] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[   39.233428] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 480700=
00.i2c:twl@48 as rtc0
[   39.972198] i2c i2c-2: SCL is stuck low, exit recovery
[   40.992309] i2c i2c-2: SCL is stuck low, exit recovery
[   42.050415] i2c i2c-2: SCL is stuck low, exit recovery
[   43.062316] i2c i2c-2: SCL is stuck low, exit recovery
[   44.072235] i2c i2c-2: SCL is stuck low, exit recovery
[   44.072265] si4713 2-0063: Error while sending command 0x01
[   45.092224] i2c i2c-2: SCL is stuck low, exit recovery
[   45.092254] si4713 2-0063: Error while sending command 0x10
[   45.092285] si4713 2-0063: Failed to probe device information.
[   45.092620] si4713: probe of 2-0063 failed with error -16
[   45.094757] bq27x00-battery 2-0055: support ver. 1.2.0 enabled
[   45.364929] Bluetooth: Core ver 2.20
[   45.365356] NET: Registered protocol family 31
[   45.365356] Bluetooth: HCI device and connection manager initialized
[   45.365386] Bluetooth: HCI socket layer initialized
[   45.365417] Bluetooth: L2CAP socket layer initialized
[   45.365478] Bluetooth: SCO socket layer initialized
[   46.102386] i2c i2c-2: SCL is stuck low, exit recovery
[   47.122344] i2c i2c-2: SCL is stuck low, exit recovery
[   48.212310] i2c i2c-2: SCL is stuck low, exit recovery
[   48.342651] lis3lv02d: 8 bits sensor found
[   48.473175] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3=
lv02d/input/input4
[   49.402313] i2c i2c-2: SCL is stuck low, exit recovery
[   50.422302] i2c i2c-2: SCL is stuck low, exit recovery
[   51.442291] i2c i2c-2: SCL is stuck low, exit recovery
[   52.462219] i2c i2c-2: SCL is stuck low, exit recovery
[   53.668853] i2c i2c-2: SCL is stuck low, exit recovery
[   54.682312] i2c i2c-2: SCL is stuck low, exit recovery
[   54.882263] random: nonblocking pool is initialized
[   55.692291] i2c i2c-2: SCL is stuck low, exit recovery
[   56.220550] isp1704_charger isp1704: init gpio 67
[   56.342437] isp1704_charger isp1704: registered with product id isp1707
[   56.702209] i2c i2c-2: SCL is stuck low, exit recovery
[   57.674682] g_nokia gadget: high-speed config #1: Bus Powered
[   57.823730] i2c i2c-2: SCL is stuck low, exit recovery
[   59.412292] i2c i2c-2: SCL is stuck low, exit recovery
[   59.412322] bq2415x-charger 2-006b: failed to set default values: -16
[   89.415588] cfg80211: Calling CRDA to update world regulatory domain
[   93.862243] cfg80211: Calling CRDA to update world regulatory domain
[   97.128662] cfg80211: Calling CRDA to update world regulatory domain
[  100.392242] cfg80211: Calling CRDA to update world regulatory domain
[  104.742370] cfg80211: Calling CRDA to update world regulatory domain
[  105.832824] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[  105.873840] wl1251: loaded
[  107.223327] wl1251: initialized
[  108.932312] cfg80211: Calling CRDA to update world regulatory domain
[  113.012298] cfg80211: Calling CRDA to update world regulatory domain
[  117.022308] cfg80211: Calling CRDA to update world regulatory domain
[  120.962310] cfg80211: Calling CRDA to update world regulatory domain
[  124.192291] cfg80211: Calling CRDA to update world regulatory domain
[  127.362243] cfg80211: Calling CRDA to update world regulatory domain
[  131.712249] cfg80211: Exceeded CRDA call max attempts. Not calling CRDA


=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4949645.MDzzsSJ7S8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW8nQUACgkQi/DJPQPkQ1IHXwCbBbErdazX6mTitklXbJJhvTWv
tIMAn06B82ZPGcH6BQwhZHKK4UcKlddG
=XQON
-----END PGP SIGNATURE-----

--nextPart4949645.MDzzsSJ7S8--
