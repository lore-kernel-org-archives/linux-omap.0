From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Thu, 29 Jun 2017 21:50:13 +0300
Message-ID: <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Jun 15, 2017 at 09:51:06AM +0300, Tomi Valkeinen wrote:
> On 15/06/17 01:11, Aaro Koskinen wrote:
> > When booting v4.12-rc5 on Nokia N900, omapdrm fails to probe and there
> > is no display.
> 
> Are you sure it doesn't probe? It fails the omapdss_stack_is_ready()
> check?

It appears the reason was that I didn't have
CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled.

I think that's wrong. I don't own an analog TV, so why should I enable
such option to get device's built-in display working?

> If that's the case then this is easier to debug.

Sure it's always easy... when users do all the testing and debugging.

Is it just me or do other OMAP users fail to see omapdrm changes being
posted to linux-omap for testing or review purposes?

And now I face another issue. When I boot v4.12-rc7 with
CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled and your "misc fixes"
patches on N900, I get the error flood again, and the device is unusable:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.12.0-rc7-omap3-los_f343c+-00003-g51d3478 (aaro@amd-fx-6350) (gcc version 6.3.0 (GCC) ) #1 Thu Jun 29 21:40:29 EEST 2017
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] OF: fdt: Machine model: Nokia N900
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64770
[    0.000000] Kernel command line: console=ttyO2,115200 console=tty
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 242780K/261120K available (6144K kernel code, 210K rwdata, 1656K rodata, 6144K init, 1142K bss, 18340K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0000000 - 0xff800000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xcff00000   ( 255 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0700000   (7136 kB)
[    0.000000]       .init : 0xc0900000 - 0xc0f00000   (6144 kB)
[    0.000000]       .data : 0xc0f00000 - 0xc0f34be0   ( 211 kB)
[    0.000000]        .bss : 0xc0f34be0 - 0xc1052560   (1143 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65535999984741ns
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000488] Console: colour dummy device 80x30
[    0.001281] console [tty0] enabled
[    0.001342] Calibrating delay loop... 496.43 BogoMIPS (lpj=2482176)
[    0.048370] pid_max: default: 32768 minimum: 301
[    0.048553] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.048583] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.049468] CPU: Testing write buffer coherency: ok
[    0.050354] Setting up static identity map for 0x80100000 - 0x80100060
[    0.053131] devtmpfs: initialized
[    0.087066] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
[    0.087707] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.087799] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.087982] pinctrl core: initialized pinctrl subsystem
[    0.089599] NET: Registered protocol family 16
[    0.091156] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.113800] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.114562] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    0.162780] Reprogramming SDRC clock to 332000000 Hz
[    0.177429] OMAP GPIO hardware version 2.5
[    0.200073] irq: no irq domain found for /ocp@68000000/l4@48000000/scm@2000/pinmux@30 !
[    0.215637] omap-gpmc 6e000000.gpmc: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_gpmc_pins, deferring probe
[    0.219879] RX-51: Enabling ARM errata 430973 workaround
[    0.221710] RX-51: Registering OMAP3 HWRNG device
[    0.225158] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.226104] Reserving DMA channels 0 and 1 for HS ROM code
[    0.226165] OMAP DMA hardware revision 4.0
[    0.276947] omap-dma-engine 48056000.dma-controller: OMAP DMA engine driver
[    0.283386] SCSI subsystem initialized
[    0.283721] usbcore: registered new interface driver usbfs
[    0.283874] usbcore: registered new interface driver hub
[    0.284027] usbcore: registered new device driver usb
[    0.284759] omap_i2c 48070000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c1_pins, deferring probe
[    0.284912] omap_i2c 48072000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c2_pins, deferring probe
[    0.285034] omap_i2c 48060000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c3_pins, deferring probe
[    0.304382] clocksource: Switched to clocksource 32k_counter
[    0.333190] NET: Registered protocol family 2
[    0.334106] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    0.334197] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.334259] TCP: Hash tables configured (established 2048 bind 2048)
[    0.334564] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.334625] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.334869] NET: Registered protocol family 1
[    0.405853] hw perfevents: no interrupt-affinity property for /pmu@54000000, guessing.
[    0.406127] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
[    0.489379] workingset: timestamp_bits=30 max_order=16 bucket_order=0
[    0.928222] jitterentropy: Initialization failed with host not compliant with requirements: 2
[    0.928497] NET: Registered protocol family 38
[    0.928558] io scheduler noop registered
[    0.928680] io scheduler cfq registered (default)
[    0.930206] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
[    0.930725] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
[    0.931396] pinctrl-single 480025d8.pinmux: 18 pins at pa fa0025d8 size 36
[    0.982940] omap_uart 4806c000.serial: no wakeirq for uart1
[    0.983245] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a OMAP UART1
[    1.009704] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a OMAP UART2
[    1.636505] console [ttyO2] enabled
[    1.641998] omap3_rom_rng: initializing
[    1.654144] omapdss_dss 48050000.dss: 48050000.dss supply vdda_video not found, using dummy regulator
[    1.664184] DSS: OMAP DSS rev 2.0
[    1.668121] omapdss_dss 48050000.dss: bound 48050400.dispc (ops dispc_component_ops)
[    1.676635] omapdss_dss 48050000.dss: bound 48050c00.encoder (ops venc_component_ops)
[    1.687103] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.894958] acx565akm spi1.2: omapfb: acx565akm rev ab LCD detected
[    1.943206] tun: Universal TUN/TAP device driver, 1.6
[    1.966522] tsc2005 spi1.0: error acquiring vio regulator: -517
[    2.037017] i2c /dev entries driver
[    2.079772] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    2.088989] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    2.097229] usbcore: registered new interface driver usbhid
[    2.103149] usbhid: USB HID core driver
[    2.107727] nf_conntrack version 0.5.0 (4096 buckets, 16384 max)
[    2.115081] ip_tables: (C) 2000-2006 Netfilter Core Team
[    2.120819] NET: Registered protocol family 17
[    2.125732] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
[    2.133331] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    2.139434] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
[    2.146789] omap2_set_init_voltage: unable to set vdd_core
[    2.155975] ThumbEE CPU extension supported.
[    2.307647] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    2.313110] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    2.373291] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x01000000, virtual base d0100000, freq 66 MHz
[    2.384704] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    2.389739] OneNAND version = 0x0121
[    2.418426] Scanning device for bad blocks
[    2.484130] OneNAND eraseblock 1229 is an initial bad block
[    2.538177] 6 ofpart partitions found on MTD device omap2-onenand
[    2.544708] Creating 6 MTD partitions on "omap2-onenand":
[    2.550415] 0x000000000000-0x000000020000 : "bootloader"
[    2.566009] 0x000000020000-0x000000080000 : "config"
[    2.605865] 0x000000080000-0x0000000c0000 : "log"
[    2.644592] random: fast init done
[    2.656005] 0x0000000c0000-0x0000002c0000 : "kernel"
[    2.703338] 0x0000002c0000-0x0000004c0000 : "initfs"
[    2.763580] 0x0000004c0000-0x000010000000 : "rootfs"
[    2.842620] smc91x: not found (-19).
[    2.930877] twl 1-0048: PIH (irq 23) chaining IRQs 337..345
[    2.936950] twl 1-0048: power (irq 342) chaining IRQs 345..352
[    2.954010] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detected.
[    2.968811] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[    2.978881] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 48070000.i2c:twl@48 as rtc0
[    3.204956] V28_A: Bringing 2600000uV into 2800000-2800000uV
[    3.336395] twl4030_gpio twl4030-gpio: gpio (irq 337) chaining IRQs 353..370
[    3.465759] twl4030_usb 48070000.i2c:twl@48:twl4030-usb: Initialized TWL4030 USB module
[    3.492767] input: twl4030_pwrbutton as /devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:pwrbutton/input/input1
[    3.522918] input: TWL4030 Keypad as /devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:keypad/input/input2
[    3.637786] omap_i2c 48070000.i2c: bus 1 rev3.3 at 2200 kHz
[    3.646850] omap_i2c 48072000.i2c: bus 2 rev3.3 at 100 kHz
[    3.737762] omap_i2c 48060000.i2c: bus 3 rev3.3 at 400 kHz
[    3.777496] input: TSC2005 touchscreen as /devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input3
[    3.798278] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    3.938995] omapdrm omapdrm.0: DMM not available, disable DMM support
[    3.946380] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.953338] [drm] No driver support for vblank timestamp query.
[    4.084808] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004422
[    4.084869] [drm:omap_irq_handler] *ERROR* FIFO underflow on vid1 (0x00000400)
[    4.084930] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004400
[    4.084930] [drm:omap_irq_handler] *ERROR* FIFO underflow on vid1 (0x00000400)
[    4.084960] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004400
[    4.084991] [drm:omap_irq_handler] *ERROR* FIFO underflow on vid1 (0x00000400)
[    4.084991] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004400
[    4.085021] [drm:omap_irq_handler] *ERROR* FIFO underflow on vid1 (0x00000400)
[    4.085021] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004400
[    4.085052] [drm:omap_irq_handler] *ERROR* FIFO underflow on vid1 (0x00000400)
[    4.085083] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004400
[    4.085083] [drm:omap_irq_handler] *ERROR* FIFO underflow on vid1 (0x00000400)
[    4.085113] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004400
[    4.085113] [drm:omap_irq_handler] *ERROR* FIFO underflow on vid1 (0x00000400)
[    4.085144] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004400
[    4.085144] [drm:omap_irq_handler] *ERROR* FIFO underflow on vid1 (0x00000400)
[    4.085174] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004400
[    4.085205] [drm:omap_irq_handler] *ERROR* FIFO underflow on vid1 (0x00000400)
[    4.085205] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004400
[    4.085235] [drm:omap_irq_handler] *ERROR* FIFO underflow on vid1 (0x00000400)
[    4.140228] random: crng init done
[    4.551147] Console: switching to colour frame buffer device 100x30
[    5.092590] mmc1: switch to bus width 8 failed
[    5.127563] mmc1: switch to bus width 4 failed
[    5.127593] mmc1: new high speed MMC card at address 0001
[    5.232543] mmcblk1: mmc1:0001 MMC32G 29.8 GiB 
[    5.267395] mmcblk1boot0: mmc1:0001 MMC32G partition 1 512 KiB
[    5.275085] mmcblk1boot1: mmc1:0001 MMC32G partition 2 512 KiB
[    5.494567]  mmcblk1: p1 p2 p3
[    7.207427] omapdrm omapdrm.0: fb0: omapdrm frame buffer device
[    7.697082] [drm] Initialized omapdrm 1.0.0 20110917 for omapdrm.0 on minor 0
[    8.675689] input: gpio_keys as /devices/platform/gpio_keys/input/input4
[    9.094512] omap_crtc_error_irq: 1159290 callbacks suppressed
[    9.105255] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[    9.116394] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[    9.127319] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[    9.138122] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[    9.148773] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[    9.159271] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[    9.169616] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[    9.179809] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[    9.189849] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[    9.199707] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   11.262145] twl_rtc 48070000.i2c:twl@48:rtc: setting system clock to 2000-01-01 00:00:08 UTC (946684808)
[   13.132354] VCSI: disabling
[   14.104492] omap_crtc_error_irq: 1212603 callbacks suppressed
[   14.113983] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   14.123992] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   14.133880] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   14.143646] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   14.153320] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   14.162933] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   14.172424] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   14.181793] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   14.190917] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   14.199890] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   14.617919] Freeing unused kernel memory: 6144K
[   19.114532] omap_crtc_error_irq: 1220048 callbacks suppressed
[   19.123077] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   19.132141] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   19.141204] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   19.150299] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   19.159332] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   19.168426] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   19.177490] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   19.186553] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   19.195648] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   19.204406] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   24.124511] omap_crtc_error_irq: 1225947 callbacks suppressed
[   24.132751] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   24.141418] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   24.149932] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   24.158386] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   24.166839] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   24.175323] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   24.183807] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   24.192291] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   24.200775] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   24.209259] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   29.134521] omap_crtc_error_irq: 1239701 callbacks suppressed
[   29.142791] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   29.151519] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   29.160034] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   29.168365] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   29.176696] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   29.184997] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   29.193328] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   29.201690] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   29.209991] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   29.218322] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   34.144531] omap_crtc_error_irq: 1240010 callbacks suppressed
[   34.152648] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   34.161346] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   34.169860] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   34.178192] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   34.186523] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   34.194854] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   34.203186] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   34.211547] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   34.219879] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   34.228210] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   34.786773] wl1251: loaded
[   34.821716] wl1251: initialized
[   39.103668] NET: Registered protocol family 35
[   39.154510] omap_crtc_error_irq: 1231519 callbacks suppressed
[   39.162475] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   39.171081] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   39.179718] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   39.188354] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   39.196960] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   39.205566] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   39.214172] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   39.222778] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   39.231414] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   39.240051] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   39.837554] omap_ssi 48058000.ssi-controller: ssi controller 0 initialized (1 ports)!
[   41.270874] omap_ssi_port 4805a000.ssi-port: ssi port 0 successfully initialized
[   42.004852] SSI protocol aka McSAAB added
[   42.791320] CMT speech driver added
[   44.164520] omap_crtc_error_irq: 1220696 callbacks suppressed
[   44.173309] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   44.182647] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   44.191986] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   44.201293] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   44.210601] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   44.219909] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   44.229034] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   44.238159] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   44.247192] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   44.256042] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   47.632446] nokia-modem n900-modem: Registered Nokia HSI modem
[   49.174530] omap_crtc_error_irq: 1224608 callbacks suppressed
[   49.183227] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   49.192474] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   49.201690] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   49.210906] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   49.220092] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   49.229278] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   49.238525] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   49.247711] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   49.256713] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   49.265472] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   51.372772] HSI/SSI char device loaded
[   54.184509] omap_crtc_error_irq: 1227885 callbacks suppressed
[   54.192779] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   54.201599] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   54.210388] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   54.219207] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   54.227996] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   54.236755] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   54.245544] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   54.254302] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   54.263092] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   54.271728] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   56.633117] using random self ethernet address
[   56.640441] using random host ethernet address
[   56.703063] usb0: HOST MAC 66:f4:0b:c0:7d:1e
[   56.720489] usb0: MAC de:14:e1:76:c6:8c
[   56.738037] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[   56.748657] g_ether gadget: g_ether ready
[   57.364685] g_ether gadget: high-speed config #1: CDC Ethernet (ECM)
[   59.194519] omap_crtc_error_irq: 1186423 callbacks suppressed
[   59.203399] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   59.212799] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   59.222167] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   59.231353] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   59.240386] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   59.249267] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   59.257995] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   59.266723] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   59.275451] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   59.284149] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   64.204406] omap_crtc_error_irq: 542337 callbacks suppressed
[   64.213043] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   64.222686] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   64.232330] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   64.241821] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   64.251281] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   64.260650] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   64.269958] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   64.279052] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   64.288055] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   64.296936] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   69.214355] omap_crtc_error_irq: 119557 callbacks suppressed
[   69.222198] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   69.230804] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   69.239440] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   69.248077] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   69.256683] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   69.265350] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   69.273986] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   69.282592] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   69.291229] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   69.299865] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   74.224456] omap_crtc_error_irq: 131095 callbacks suppressed
[   74.232269] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   74.240966] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   74.249481] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   74.257995] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   74.266510] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   74.275054] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   74.283416] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   74.291931] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   74.300476] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   74.309020] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   79.234466] omap_crtc_error_irq: 148380 callbacks suppressed
[   79.242279] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   79.250976] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   79.259521] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   79.268066] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   79.276611] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   79.285186] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   79.293579] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   79.302124] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   79.310668] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   79.319213] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   84.244445] omap_crtc_error_irq: 129987 callbacks suppressed
[   84.252258] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   84.261016] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   84.269561] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   84.278106] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   84.286651] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   84.295227] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   84.303619] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   84.312164] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   84.320709] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   84.329254] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   89.254425] omap_crtc_error_irq: 141836 callbacks suppressed
[   89.262237] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   89.270965] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   89.279510] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   89.288055] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   89.296600] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   89.305175] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   89.313568] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   89.322113] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022
[   89.330657] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004000
[   89.339202] [drm:omap_crtc_error_irq] *ERROR* lcd: errors: 00004022

A.
