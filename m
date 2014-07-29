From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Tue, 29 Jul 2014 07:53:13 -0700
Message-ID: <20140729145312.GT29045@atomide.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com>
 <20140707080238.GF28884@atomide.com>
 <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com>
 <20140729064243.GF29045@atomide.com>
 <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
 <20140729084930.GH29045@atomide.com>
 <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
 <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41925 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751151AbaG2Oyj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 10:54:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Paul Walmsley <paul@pwsan.com> [140729 06:00]:
> On Tue, 29 Jul 2014, Paul Walmsley wrote:
> 
> > I will add code to read back the values from the sysfs files, just to make 
> > sure they are being set.
> 
> Confirmed that they are.

Hmm maybe different u-boot version then? I'm using
2014.04-00001-g5f09f5b.
 
> Are you using NFS root on 37xxevm or MMC root?

Using nfsroot and omap2plus_defconfig. My dmesg attached
in case it provides some clues. I don't have console=ttyO
here, but I've verified that it works with that too.

Regards,

Tony

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.16.0-rc7 (tmlind@muffinssi) (gcc version 4.7.2 (Debian 4.7.2-5) ) #291 SMP Tue Jul 29 07:37:49 PDT 2014
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: TI OMAP37XX EVM (TMDSEVM3730)
[    0.000000] cma: CMA: reserved 16 MiB at 8e800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c08c0c00, node_mem_map cfcf1000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65280 pages, LIFO batch:15
[    0.000000]   HighMem zone: 1048574 pages exceeds freesize 0
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] PERCPU: Embedded 9 pages/cpu @cfc7d000 s14336 r8192 d14336 u36864
[    0.000000] pcpu-alloc: s14336 r8192 d14336 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: root=/dev/nfs ip=dhcp debug earlyprintk omapfb.vram=0:2M,1:5M omapfb.rotate=0 init=/root/init
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 224728K/261120K available (5659K kernel code, 681K rwdata, 2200K rodata, 402K init, 8209K bss, 36392K reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc07b51dc   (7861 kB)
[    0.000000]       .init : 0xc07b6000 - 0xc081a800   ( 402 kB)
[    0.000000]       .data : 0xc081c000 - 0xc08c6570   ( 682 kB)
[    0.000000]        .bss : 0xc08c6570 - 0xc10caa60   (8210 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65536000000000ns
[    0.000030] OMAP clocksource: 32k_counter at 32768 Hz
[    0.001159] Console: colour dummy device 80x30
[    0.004669] console [tty0] enabled
[    0.004699] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.004760] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.004791] ... MAX_LOCK_DEPTH:          48
[    0.004791] ... MAX_LOCKDEP_KEYS:        8191
[    0.004821] ... CLASSHASH_SIZE:          4096
[    0.004852] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.004882] ... MAX_LOCKDEP_CHAINS:      65536
[    0.004913] ... CHAINHASH_SIZE:          32768
[    0.004943]  memory used by lock dependency info: 5167 kB
[    0.004974]  per task-struct memory footprint: 1152 bytes
[    0.005065] Calibrating delay loop... 594.73 BogoMIPS (lpj=2973696)
[    0.097656] pid_max: default: 32768 minimum: 301
[    0.098236] Security Framework initialized
[    0.098449] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.098510] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.101837] CPU: Testing write buffer coherency: ok
[    0.103424] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.103576] Setting up static identity map for 0x8055d2c0 - 0x8055d330
[    0.108398] Brought up 1 CPUs
[    0.108459] SMP: Total of 1 processors activated.
[    0.108489] CPU: All CPU(s) started in SVC mode.
[    0.112365] devtmpfs: initialized
[    0.123168] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    0.205596] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.208068] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    0.302490] omap_hwmod: mcbsp2: cannot be enabled for reset (3)
[    0.320434] pinctrl core: initialized pinctrl subsystem
[    0.324096] regulator-dummy: no parameters
[    0.420104] NET: Registered protocol family 16
[    0.429107] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.432617] cpuidle: using governor ladder
[    0.432678] cpuidle: using governor menu
[    0.441406] Reprogramming SDRC clock to 400000000 Hz
[    0.454162] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.455535] OMAP GPIO hardware version 2.5
[    0.457519] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.460296] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.463012] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.465698] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.468414] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.469879] irq: no irq domain found for /ocp/pinmux@48002030 !
[    0.470733] irq: no irq domain found for /ocp/pinmux@48002030 !
[    0.471557] irq: no irq domain found for /ocp/pinmux@48002030 !
[    0.494659] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.496246] gpmc_probe_nand_child: ti,elm-id property not found
[    0.496459] gpmc_cs_program_settings: invalid width 0!
[    0.498962] platform 48058000.ssi-controller: Cannot lookup hwmod 'ssi'
[    0.507354] No ATAGs?
[    0.507415] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.511108] OMAP DMA hardware revision 5.0
[    0.551330] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM dummy slot
[    0.551483] edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
[    0.605987] omap-dma-engine 48056000.dma-controller: OMAP DMA engine driver
[    0.607360] of_get_named_gpiod_flags: can't parse gpios property of node '/regulator-vddvario[0]'
[    0.608215] vddvario: no parameters
[    0.608886] of_get_named_gpiod_flags: can't parse gpios property of node '/regulator-vdd33a[0]'
[    0.609466] vdd33a: no parameters
[    0.610137] reg-fixed-voltage wl12xx_vmmc: could not find pctldev for node /ocp/pinmux@48002030/pinmux_wl12xx_gpio, deferring probe
[    0.610229] platform wl12xx_vmmc: Driver reg-fixed-voltage requests probe deferral
[    0.610504] of_get_named_gpiod_flags exited with status 0
[    0.611389] lcd_3v3: 3300 mV 
[    0.617828] SCSI subsystem initialized
[    0.619049] usbcore: registered new interface driver usbfs
[    0.619354] usbcore: registered new interface driver hub
[    0.619964] usbcore: registered new device driver usb
[    0.773498] omap_i2c 48070000.i2c: bus 0 rev4.4 at 2600 kHz
[    0.775390] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
[    0.780242] omap_i2c 48060000.i2c: bus 2 rev4.4 at 400 kHz
[    0.787780] Switched to clocksource 32k_counter
[    1.009338] NET: Registered protocol family 2
[    1.011840] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    1.012115] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    1.013275] TCP: Hash tables configured (established 2048 bind 2048)
[    1.013488] TCP: reno registered
[    1.013549] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    1.013885] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    1.015533] NET: Registered protocol family 1
[    1.018127] RPC: Registered named UNIX socket transport module.
[    1.018188] RPC: Registered udp transport module.
[    1.018218] RPC: Registered tcp transport module.
[    1.018249] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.020080] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    1.028137] futex hash table entries: 256 (order: 2, 16384 bytes)
[    1.034179] VFS: Disk quotas dquot_6.5.2
[    1.034423] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.038482] NFS: Registering the id_resolver key type
[    1.039031] Key type id_resolver registered
[    1.039062] Key type id_legacy registered
[    1.039276] jffs2: version 2.2. (NAND) (SUMMARY)  \xffffffc2\xffffffa9\xffffffa9 2001-2006 Red Hat, Inc.
[    1.039947] msgmni has been set to 470
[    1.046936] io scheduler noop registered
[    1.047119] io scheduler deadline registered
[    1.047271] io scheduler cfq registered (default)
[    1.051239] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
[    1.052062] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
[    1.053161] pinctrl-single 480025a0.pinmux: 46 pins at pa fa0025a0 size 92
[    1.056640] pbias_mmc_omap2430: 1800 <--> 3000 mV at 3000 mV 
[    1.059082] abb_mpu_iva: 1012 <--> 1375 mV 
[    1.060546] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.070648] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/serial@4806a000[0]'
[    1.071319] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq = 88, base_baud = 3000000) is a OMAP UART0
[    1.075195] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/serial@4806c000[0]'
[    1.075653] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a OMAP UART1
[    1.079376] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/serial@49020000[0]'
[    1.079833] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a OMAP UART2
[    1.081939] omap_uart 49042000.serial: no wakeirq for uart0
[    1.082031] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/serial@49042000[0]'
[    1.082427] 49042000.serial: ttyO3 at MMIO 0x49042000 (irq = 96, base_baud = 3000000) is a OMAP UART3
[    1.120300] brd: module loaded
[    1.142852] loop: module loaded
[    1.163208] twl 0-0048: PIH (irq 23) chaining IRQs 341..349
[    1.163818] twl 0-0048: power (irq 346) chaining IRQs 349..356
[    1.171874] VAUX1: at 3000 mV 
[    1.176086] VAUX2_4030: at 1800 mV 
[    1.180084] VAUX3: at 2800 mV 
[    1.184020] VAUX4: at 2800 mV 
[    1.188049] VDD1: 600 <--> 1450 mV at 1200 mV 
[    1.191833] VDAC: 1800 mV 
[    1.198486] VIO: at 1800 mV 
[    1.203399] VINTANA1: 1500 mV 
[    1.208038] VINTANA2: at 2750 mV 
[    1.211364] VINTDIG: 1500 mV 
[    1.214691] VMMC1: 1850 <--> 3150 mV at 3000 mV 
[    1.218872] VMMC2: 1850 <--> 3150 mV at 2600 mV 
[    1.222015] VUSB1V5: 1500 mV 
[    1.224121] VUSB1V8: 1800 mV 
[    1.226165] VUSB3V1: 3100 mV 
[    1.234100] VPLL1: at 1800 mV 
[    1.240905] VPLL2: 1800 mV 
[    1.244842] VSIM: 1800 <--> 3000 mV at 1800 mV 
[    1.248443] twl4030_gpio twl4030-gpio: gpio (irq 341) chaining IRQs 357..374
[    1.249481] gpiochip_find_base: found new base at 492
[    1.250457] gpiochip_add: registered GPIOs 492 to 511 on device: twl4030
[    1.351745] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.383422] libphy: smsc911x-mdio: probed
[    1.457794] smsc911x 2c000000.ethernet eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=2c000000.etherne:01, irq=-1)
[    1.458160] smsc911x 2c000000.ethernet eth0: MAC Address: 00:12:34:56:78:90
[    1.460418] usbcore: registered new interface driver asix
[    1.460693] usbcore: registered new interface driver ax88179_178a
[    1.460906] usbcore: registered new interface driver cdc_ether
[    1.461212] usbcore: registered new interface driver smsc95xx
[    1.461425] usbcore: registered new interface driver net1080
[    1.461639] usbcore: registered new interface driver cdc_subset
[    1.461883] usbcore: registered new interface driver zaurus
[    1.462219] usbcore: registered new interface driver cdc_ncm
[    1.463928] usbcore: registered new interface driver cdc_wdm
[    1.464294] usbcore: registered new interface driver usb-storage
[    1.464599] usbcore: registered new interface driver usbtest
[    1.468109] mousedev: PS/2 mouse device common for all mice
[    1.469604] twl4030_keypad 48070000.i2c:twl@48:keypad: OF: linux,keymap property not defined in /ocp/i2c@48070000/twl@48/keypad
[    1.469665] twl4030_keypad 48070000.i2c:twl@48:keypad: Failed to build keymap
[    1.469818] twl4030_keypad: probe of 48070000.i2c:twl@48:keypad failed with error -2
[    1.471496] of_get_named_gpiod_flags exited with status 0
[    1.548706] ads7846 spi1.0: touchscreen, irq 287
[    1.551727] input: ADS7846 Touchscreen as /devices/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input1
[    1.559204] input: twl4030_pwrbutton as /devices/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@48:pwrbutton/input/input2
[    1.562530] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detected.
[    1.563171] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[    1.570068] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 48070000.i2c:twl@48 as rtc0
[    1.571868] i2c /dev entries driver
[    1.575744] Driver for 1-wire Dallas network protocol.
[    1.580627] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    1.585296] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@4809c000[0]'
[    1.585357] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@4809c000[0]'
[    1.637634] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@480b4000[0]'
[    1.637725] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@480b4000[0]'
[    1.638488] omap_hsmmc 480b4000.mmc: unable to get vmmc regulator -517
[    1.639190] platform 480b4000.mmc: Driver omap_hsmmc requests probe deferral
[    1.640533] of_get_named_gpiod_flags exited with status 0
[    1.640624] of_get_named_gpiod_flags exited with status 0
[    1.648895] ledtrig-cpu: registered to indicate activity on CPUs
[    1.650207] usbcore: registered new interface driver usbhid
[    1.650268] usbhid: USB HID core driver
[    1.652954] oprofile: using arm/armv7
[    1.653808] TCP: cubic registered
[    1.653869] Initializing XFRM netlink socket
[    1.654052] NET: Registered protocol family 17
[    1.654174] NET: Registered protocol family 15
[    1.654693] Key type dns_resolver registered
[    1.655090] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
[    1.655151] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    1.655212] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
[    1.655242] omap2_set_init_voltage: unable to set vdd_core
[    1.660217] ThumbEE CPU extension supported.
[    1.660339] Registering SWP/SWPB emulation handler
[    1.660369] SmartReflex Class3 initialized
[    1.670257] of_get_named_gpiod_flags exited with status 0
[    1.671325] vwl1271: 1800 mV 
[    1.671600] vwl1271: supplied by VMMC2
[    1.673278] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@480b4000[0]'
[    1.673339] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@480b4000[0]'
[    1.802642] twl_rtc 48070000.i2c:twl@48:rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
[    1.802734] sr_init: No PMIC hook to init smartreflex
[    1.803344] smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initialized
[    1.804321] smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initialized
[    1.981872] smsc911x 2c000000.ethernet eth0: SMSC911x/921x identified at 0xd087c000, IRQ: 288
[    4.477233] Sending DHCP requests ., OK
[    4.497253] IP-Config: Got DHCP answer from 192.168.111.1, my address is 192.168.111.253
[    4.497711] IP-Config: Complete:
[    4.497772]      device=eth0, hwaddr=00:50:c2:7e:99:47, ipaddr=192.168.111.253, mask=255.255.255.0, gw=192.168.111.1
[    4.497833]      host=omap3evm, domain=muru.com, nis-domain=(none)
[    4.497863]      bootserver=192.168.111.8, rootserver=192.168.111.8, rootpath=/srv/nfs3/armhf,v3
[    4.497894]      nameserver0=192.168.1.254
[    4.498321] vwl1271: disabling
[    4.499664] VUSB3V1: disabling
[    4.532409] VFS: Mounted root (nfs filesystem) readonly on device 0:13.
[    4.534545] devtmpfs: mounted
[    4.535583] Freeing unused kernel memory: 400K (c07b6000 - c081a000)
[    6.771423] random: sshd urandom read with 46 bits of entropy available
