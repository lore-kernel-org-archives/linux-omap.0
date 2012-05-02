From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: Problems with 3.4-rc5
Date: Wed, 02 May 2012 13:46:38 +0100
Message-ID: <WC20120502124638.320406@terrafix.co.uk>
References: <WC20120502115251.8503FF@terrafix.co.uk> <4FA12775.1090206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:38029 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753797Ab2EBMqy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 08:46:54 -0400
In-Reply-To: <4FA12775.1090206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org



-----Original Message-----
From: Archit Taneja <a0393947@ti.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: <linux-omap@vger.kernel.org>
Date: Wed, 2 May 2012 17:54:21 +0530
Subject: Re: Problems with 3.4-rc5

> Hi,
> 
> On Wednesday 02 May 2012 05:22 PM, Joe Woodward wrote:
> > I've just given 3.4-rc5 a quick run-through on my GUMSTIX Overo
> (AM3703), and have noticed a couple of issues...
> >
> > Firstly, it fails to build "drivers/mfd/omap-usb-host.c" if you have:
> >
> > CONFIG_USB_EHCI_HCD=m
> > CONFIG_USB_EHCI_ROOT_HUB_TT=y
> > CONFIG_USB_EHCI_TT_NEWSCHED=y
> > CONFIG_USB_EHCI_HCD_OMAP=y
> >
> > drivers/mfd/omap-usb-host.c: In function 'omap_usbhs_init':
> > drivers/mfd/omap-usb-host.c:524:3: error: implicit declaration of
> function 'cpu_is_omap3430'
> > drivers/mfd/omap-usb-host.c:524:3: error: implicit declaration of
> function 'omap_rev'
> > drivers/mfd/omap-usb-host.c:524:43: error: 'OMAP3430_REV_ES2_1'
> undeclared (first use in this function)
> > drivers/mfd/omap-usb-host.c:524:43: note: each undeclared identifier
> is reported only once for each function it appears in
> >
> > I'm assuming this has been spotted and I've missed the fix (just a
> missing include?).
> >
> > Secondly, I get the following when booted:
> > ...
> > [    4.701232] devtmpfs: mounted
> > [    4.704772] Freeing init memory: 168K
> > [    4.827301] omapdss DISPC error: FIFO UNDERFLOW on gfx, disabling
> the overlay
> > ...
> >
> 
> Could you add some dss debug prints? You can add "omapdss.debug=1
> debug" 
> in the bootargs to get that.
> 
> There was a feature called fifo merge added in 3.4, this might lead to 
> underflow, we had tested this using a DVI monitor on beagle but didn't 
> see any underflows.
> 
> Are you trying this out on 3.4 for the first time? What was the last 
> kernel revision on which you tested this and didn't see any issues?


See below for a more complete trace with debug enabled.

I have been using 3.3.0, which doesn't give me any DSS underflow problems at all.

And yes, this is the first time I've tried anything 3.4-based.

For reference, I'm running from a RAM-based file system which is the same as I use on 3.3.0.

Cheers,
Joe

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc5 (joe@joe-VirtualBox) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #4 SMP Wed May 2 12:43:38 BST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Gumstix Overo
[    0.000000] Reserving 8388608 bytes SDRAM for VRAM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 128768
[    0.000000] free_area_init_node: node 0, pgdat c06f4740, node_mem_map c7000000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 127744 pages, LIFO batch:31
[    0.000000] OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c7408000 s11520 r8192 d13056 u32768
[    0.000000] pcpu-alloc: s11520 r8192 d13056 u32768 alloc=8*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 127744
[    0.000000] Kernel command line: console=ttyO2,115200 omapfb.rotate=0 omapdss.debug=1 debug root=/dev/ram0 rw ramdisk_size=98304 
initrd=0x81000000,96M rootfstype=squashfs
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 503MB = 503MB total
[    0.000000] Memory: 399616k/399616k available, 124672k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0614f30   (6196 kB)
[    0.000000]       .init : 0xc0615000 - 0xc0662d00   ( 312 kB)
[    0.000000]       .data : 0xc0664000 - 0xc06f63d8   ( 585 kB)
[    0.000000]        .bss : 0xc06f63fc - 0xc0c4c020   (5464 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.000854] Calibrating delay loop... 597.64 BogoMIPS (lpj=2334720)
[    0.085968] pid_max: default: 32768 minimum: 301
[    0.086669] Security Framework initialized
[    0.086944] Mount-cache hash table entries: 512
[    0.091857] CPU: Testing write buffer coherency: ok
[    0.092712] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.092773] Setting up static identity map for 0x80469f88 - 0x80469ff8
[    0.094421] Brought up 1 CPUs
[    0.094451] SMP: Total of 1 processors activated (597.64 BogoMIPS).
[    0.097656] devtmpfs: initialized
[    0.107910] ttyO2 used as console in debug mode uart2 clocks will not be gated
[    0.117309] dummy:
[    0.119415] NET: Registered protocol family 16
[    0.120605] GPMC revision 5.0
[    0.129852] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.130371] OMAP GPIO hardware version 2.5
[    0.131469] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.133270] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.134704] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.136108] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.137481] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.144836] omap_mux_init: Add partition: #1: core, flags: 0
[    0.159606] Reprogramming SDRC clock to 400000000 Hz
[    0.159637] dpll3_m2_clk rate change failed: -22
[    0.159637] NAND: Unable to find configuration in GPMC
[    0.159637]
[    0.174530] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.189086]  omap-mcbsp.2: alias fck already exists
[    0.189849]  omap-mcbsp.3: alias fck already exists
[    0.194091] OMAP DMA hardware revision 5.0
[    0.261291] bio: create slab <bio-0> at 0
[    0.264801] fixed-dummy:
[    0.266174] vads7846: 3300 mV
[    0.271728] SCSI subsystem initialized
[    0.273986] omap2_mcspi omap2_mcspi.1: master is unqueued, this is deprecated
[    0.276733] omap2_mcspi omap2_mcspi.2: master is unqueued, this is deprecated
[    0.277862] omap2_mcspi omap2_mcspi.3: master is unqueued, this is deprecated
[    0.278961] omap2_mcspi omap2_mcspi.4: master is unqueued, this is deprecated
[    0.282440] usbcore: registered new interface driver usbfs
[    0.283477] usbcore: registered new interface driver hub
[    0.284118] usbcore: registered new device driver usb
[    0.297576] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.307006] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.307647] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.310028] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs 336..353
[    0.311431] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
[    0.317047] VMMC1: 1850 <--> 3150 mV at 3150 mV normal standby
[    0.319335] VDAC: 1800 mV normal standby
[    0.321685] VDVI: 1800 mV normal standby
[    0.336181] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 400 kHz
[    0.344543] Switching to clocksource 32k_counter
[    0.467407] NET: Registered protocol family 2
[    0.468292] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.470916] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.471618] TCP bind hash table entries: 16384 (order: 7, 589824 bytes)
[    0.480651] TCP: Hash tables configured (established 16384 bind 16384)
[    0.480743] TCP: reno registered
[    0.480804] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.481109] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.482086] NET: Registered protocol family 1
[    0.483520] RPC: Registered named UNIX socket transport module.
[    0.483551] RPC: Registered udp transport module.
[    0.483581] RPC: Registered tcp transport module.
[    0.483581] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.484374] Trying to unpack rootfs image as initramfs...
[    0.485504] rootfs image is not initramfs (junk in compressed archive); looks like an initrd
[    1.099151] Freeing initrd memory: 98304K
[    1.099334] NetWinder Floating Point Emulator V0.97 (double precision)
[    1.263275] VFS: Disk quotas dquot_6.5.2
[    1.263610] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.265106] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.265289] NFS: Registering the id_resolver key type
[    1.267211] msgmni has been set to 972
[    1.270568] io scheduler noop registered
[    1.270599] io scheduler deadline registered
[    1.270812] io scheduler cfq registered (default)
[    1.275726] omapdss DSS: dss_runtime_get
[    1.275787] omapdss DSS: dss_restore_context
[    1.275817] OMAP DSS rev 2.0
[    1.275817] omapdss DSS: dss_runtime_put
[    1.275878] omapdss DSS: dss_save_context
[    1.275909] omapdss DSS: context saved
[    1.276794] omapdss DISPC: dispc_runtime_get
[    1.276855] omapdss DSS: dss_runtime_get
[    1.276885] omapdss DSS: dss_restore_context
[    1.276885] omapdss DSS: context restored
[    1.276916] omapdss DISPC: dispc_restore_context
[    1.277099] omapdss DISPC: dispc_runtime_put
[    1.277130] omapdss DISPC: dispc_save_context
[    1.277191] omapdss DISPC: context saved, ctx_loss_count 0
[    1.277221] omapdss DSS: dss_runtime_put
[    1.277252] omapdss DSS: dss_save_context
[    1.277252] omapdss DSS: context saved
[    1.278137] omapdss RFBI: rfbi_runtime_get
[    1.278198] omapdss DSS: dss_runtime_get
[    1.278228] omapdss DSS: dss_restore_context
[    1.278228] omapdss DSS: context restored
[    1.278259] omapdss DISPC: dispc_runtime_get
[    1.278289] omapdss DSS: dss_runtime_get
[    1.278289] omapdss DISPC: dispc_restore_context
[    1.298217] omapdss RFBI: rfbi_runtime_put
[    1.298278] omapdss DISPC: dispc_runtime_put
[    1.298309] omapdss DISPC: dispc_save_context
[    1.298370] omapdss DISPC: context saved, ctx_loss_count 0
[    1.298370] omapdss DSS: dss_runtime_put
[    1.298431] omapdss DSS: dss_runtime_put
[    1.298461] omapdss DSS: dss_save_context
[    1.298461] omapdss DSS: context saved
[    1.299285] omapdss VENC: venc_runtime_get
[    1.299316] omapdss DSS: dss_runtime_get
[    1.299377] omapdss DSS: dss_restore_context
[    1.299377] omapdss DSS: context restored
[    1.299407] omapdss DISPC: dispc_runtime_get
[    1.299438] omapdss DSS: dss_runtime_get
[    1.299438] omapdss DISPC: dispc_restore_context
[    1.299468] omapdss VENC: venc_runtime_put
[    1.299530] omapdss CORE: bus_match. dev display0/generic_dpi_panel, drv venc
[    1.300079] omapdss DISPC: dispc_runtime_put
[    1.300079] omapdss DISPC: dispc_save_context
[    1.300140] omapdss DISPC: context saved, ctx_loss_count 0
[    1.300170] omapdss DSS: dss_runtime_put
[    1.300201] omapdss DSS: dss_runtime_put
[    1.300231] omapdss DSS: dss_save_context
[    1.300231] omapdss DSS: context saved
[    1.301147] omapdss DSI: dsi_runtime_get
[    1.301208] omapdss DSS: dss_runtime_get
[    1.301239] omapdss DSS: dss_restore_context
[    1.301239] omapdss DSS: context restored
[    1.301269] omapdss DISPC: dispc_runtime_get
[    1.301300] omapdss DSS: dss_runtime_get
[    1.301300] omapdss DISPC: dispc_restore_context
[    1.301330] omapdss DSI: dsi_runtime_put
[    1.301391] omapdss DISPC: dispc_runtime_put
[    1.301422] omapdss DISPC: dispc_save_context
[    1.301452] omapdss DISPC: context saved, ctx_loss_count 0
[    1.301483] omapdss DSS: dss_runtime_put
[    1.301513] omapdss DSS: dss_runtime_put
[    1.301544] omapdss DSS: dss_save_context
[    1.301544] omapdss DSS: context saved
[    1.302825] omapdss CORE: bus_match. dev display0/generic_dpi_panel, drv generic_dpi_panel
[    1.302917] omapdss CORE: driver_probe: dev display0/generic_dpi_panel, drv generic_dpi_panel
[    1.302917] omapdss DPI: init_display
[    1.303833] omapdss DISPC: dispc_runtime_get
[    1.303894] omapdss DSS: dss_runtime_get
[    1.303924] omapdss DSS: dss_restore_context
[    1.303955] omapdss DSS: context restored
[    1.303955] omapdss DISPC: dispc_restore_context
[    1.304077] omapdss DISPC: dispc_runtime_put
[    1.304107] omapdss DISPC: dispc_save_context
[    1.304168] omapdss DISPC: context saved, ctx_loss_count 0
[    1.304199] omapdss DSS: dss_runtime_put
[    1.304199] omapdss DSS: dss_save_context
[    1.304229] omapdss DSS: context saved
[    1.304290] omapdss CORE: probe done for device display0
[    1.305816] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.313018] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
[    1.315521] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
[    1.317077] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP UART2
[    2.428833] console [ttyO2] enabled
[    2.434326] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq = 80) is a OMAP UART3
[    2.478302] brd: module loaded
[    2.502929] loop: module loaded
[    2.514190] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.522094] OneNAND driver initializing
[    2.532806] smsc911x: Driver version 2008-10-21
[    2.539978] smsc911x: Driver version 2008-10-21
[    2.547790] usbcore: registered new interface driver asix
[    2.554199] usbcore: registered new interface driver cdc_ether
[    2.561004] usbcore: registered new interface driver net1080
[    2.567596] usbcore: registered new interface driver cdc_subset
[    2.574432] usbcore: registered new interface driver zaurus
[    2.580963] usbcore: registered new interface driver cdc_ncm
[    2.589324] usbcore: registered new interface driver cdc_wdm
[    2.595428] Initializing USB Mass Storage driver...
[    2.601165] usbcore: registered new interface driver usb-storage
[    2.607635] USB Mass Storage support registered.
[    2.613677] usbcore: registered new interface driver libusual
[    2.620452] usbcore: registered new interface driver usbtest
[    2.628662] mousedev: PS/2 mouse device common for all mice
[    2.639648] ads7846 spi1.0: touchscreen, irq 210
[    2.647399] input: ADS7846 Touchscreen as /devices/platform/omap2_mcspi.1/spi_master/spi1/spi1.0/input/input0
[    2.663818] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input1
[    2.676635] twl_rtc twl_rtc: Power up reset detected.
[    2.682312] twl_rtc twl_rtc: Enabling TWL-RTC
[    2.691192] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    2.699127] i2c /dev entries driver
[    2.706207] Driver for 1-wire Dallas network protocol.
[    2.715270] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    2.723785] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.730621] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.963989] usbcore: registered new interface driver usbhid
[    2.969879] usbhid: USB HID core driver
[    2.974090] oprofile: hardware counters not available
[    2.979461] oprofile: using timer interrupt.
[    2.984863] TCP: cubic registered
[    2.988464] Initializing XFRM netlink socket
[    2.993103] NET: Registered protocol family 17
[    2.997955] NET: Registered protocol family 15
[    3.003479] Registering the dns_resolver key type
[    3.008728] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    3.017059] ThumbEE CPU extension supported.
[    3.065826] clock: disabling unused clocks to save power
[    3.085449] omapdss APPLY: omap_dss_mgr_apply(lcd)
[    3.089996] Console: switching to colour frame buffer device 100x30
[    3.108276] omapdss APPLY: omap_dss_mgr_apply(lcd)
[    3.113586] omapdss APPLY: omap_dss_mgr_apply(lcd)
[    3.118713] omapdss APPLY: omap_dss_mgr_apply(tv)
[    3.123962] omapdss DSS: dss_runtime_get
[    3.128295] omapdss DSS: dss_restore_context
[    3.132812] omapdss DSS: context restored
[    3.137084] omapdss DISPC: dispc_runtime_get
[    3.141601] omapdss DSS: dss_runtime_get
[    3.145812] omapdss DISPC: dispc_restore_context
[    3.150726] omapdss DISPC: onoff 0 rf 0 ieo 0 ipc 0 ihs 1 ivs 1 acbi 0 acb 0
[    3.158264] omapdss DSS: dpll4_m4 = 864000000
[    3.162872] omapdss DSS: fck = 36000000 (24)
[    3.167419] omapdss DISPC: lck = 36000000 (1)
[    3.172027] omapdss DISPC: pck = 36000000 (1)
[    3.176666] omapdss DISPC: channel 0 xres 800 yres 480
[    3.182128] omapdss DISPC: pck 36000
[    3.185913] omapdss DISPC: hsw 10 hfp 164 hbp 89 vsw 10 vfp 10 vbp 23
[    3.192749] omapdss DISPC: hsync 33866Hz, vsync 64Hz
[    3.200042] omapdss DISPC: FIFO merge enabled
[    3.204620] omapdss APPLY: dss_mgr_write_regs(0)
[    3.209503] omapdss APPLY: dss_ovl_write_regs(0)
[    3.214385] omapdss DISPC: dispc_ovl_setup 0, pa 9f800000, pa_uv 0, sw 800, 0,0, 800x480 -> 800x480, cmode 40, rot 0, mir 0, ilace 0 chan 0 repl 1
[    3.228240] omapdss DISPC: calc_rot(0): scrw 800, 800x480
[    3.233917] omapdss DISPC: offset0 0, offset1 0, row_inc 1, pix_inc 1
[    3.240722] omapdss DISPC: 0,0 800x480 -> 800x480
[    3.245697] omapdss APPLY: dss_ovl_write_regs_extra(0)
[    3.251098] omapdss DISPC: dispc_enable_plane 0, 1
[    3.256164] omapdss DISPC: fifo(0) threshold (bytes), old 960/1023, new 896/3008
[    3.263977] omapdss APPLY: dss_ovl_write_regs(1)
[    3.268829] omapdss APPLY: dss_ovl_write_regs_extra(1)
[    3.274261] omapdss DISPC: dispc_enable_plane 1, 0
[    3.279296] omapdss DISPC: fifo(1) threshold (bytes), old 960/1023, new 0/0
[    3.286651] omapdss APPLY: dss_ovl_write_regs(2)
[    3.291503] omapdss APPLY: dss_ovl_write_regs_extra(2)
[    3.296936] omapdss DISPC: dispc_enable_plane 2, 0
[    3.302001] omapdss DISPC: fifo(2) threshold (bytes), old 960/1023, new 0/0
[    3.317657] VDAC: incomplete constraints, leaving on
[    3.325897] input: gpio-keys as /devices/platform/gpio-keys/input/input2
[    3.340087] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:10 UTC (946684810)
[    3.352264] RAMDISK: squashfs filesystem found at block 0
[    3.358154] RAMDISK: Loading 49972KiB [1 disk] into ram disk... \
[    3.450561] mmc0: host does not support reading read-only switch. assuming write-enable.
[    3.459838] |
[    3.470581] mmc0: new high speed SDHC card at address 0001
[    3.478485] \
[    3.487304] mmcblk0: mmc0:0001 00000 29.2 GiB
[    3.493865] -
[    3.516296]  mmcblk0: p1
[    3.521087] /
[    3.610717] mmc1: new SDIO card at address 0001
[    3.616546] done.
[    5.950683] VFS: Mounted root (squashfs filesystem) readonly on device 1:0.
[    5.960449] devtmpfs: mounted
[    5.964263] Freeing init memory: 308K
[    6.123443] DISPC IRQ: 0x100e2: GFX_FIFO_UNDERFLOW
[    6.129302] omapdss DISPC: dispc_runtime_get
[    6.133819] omapdss DISPC error: FIFO UNDERFLOW on gfx, disabling the overlay
[    6.141662] omapdss DISPC: dispc_enable_plane 0, 0
[    6.146759] omapdss DISPC: GO LCD
[    6.200408] omapdss DISPC: dispc_runtime_put
Starting logging: OK
Populating  using udev: done
[    6.435211] udevd[575]: starting version 175


> 
> Thanks,
> Archit
> 
> > Which means that the display doesn't work.
> >
> > I am currently running 3.3, which works just fine and doesn't give an
> underflow.
> >
> > So was wondering what changes have been made that may affect this?
> There were problems in the 3.2-era due to runtime-
> > PM causing a similar issue, has anything changed around here again?
> >
> > (as a side not: the panel I use is a custom 800x480 added to
> panel-generic-dpi.c, with board-overo.c updated to use it).
> >
> > Cheers,
> > Joe Woodward
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


