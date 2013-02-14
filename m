From: Kevin Hilman <khilman@linaro.org>
Subject: OMAP EHCI having clock problems?
Date: Thu, 14 Feb 2013 14:50:52 -0800
Message-ID: <87halea4s3.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:43976 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759426Ab3BNWu4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 17:50:56 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so347654pbc.38
        for <linux-omap@vger.kernel.org>; Thu, 14 Feb 2013 14:50:55 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Felipe, Roger,

Using Tony's current master branch, and enabling EHCI support, I see 
the clock framework spitting loudly about the EHCI driver (full boot log
below.)   The same thing happens on v3.8-rc7.

Any idea what's going on?  Am I missing a set of fixes that's already
been posted?

On a related note, is anyone planning to fix the runtime PM problems in
this driver?  It's still disabled by default in omap2plus_defconfig
because the driver keeps CORE from hitting retention, even when no
devices are attached.

Kevin


[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc7-lo-ehci-12285-g3403fe6 (khilman@paris) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #1 SMP Thu Feb 14 14:36:07 PST 2013
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: OMAP4 Panda board
[    0.000000] cma: CMA: reserved 16 MiB at ae800000
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] On node 0 totalpages: 261888
[    0.000000] free_area_init_node: node 0, pgdat c07d4100, node_mem_map c0d32000
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 193040 pages, LIFO batch:31
[    0.000000]   HighMem zone: 528 pages used for memmap
[    0.000000]   HighMem zone: 66800 pages, LIFO batch:15
[    0.000000] OMAP4430 ES2.1
[    0.000000] PERCPU: Embedded 9 pages/cpu @c1545000 s12992 r8192 d15680 u36864
[    0.000000] pcpu-alloc: s12992 r8192 d15680 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259840
[    0.000000] Kernel command line: console=ttyO2,115200n8 rcu_nocbs=1 full_nohz=1 earlyprintk vram=16M ip=dhcp nfsroot=192.168.1.2:/opt/kjh/rootfs/debian/armel,rsize=4096,wsize=4096
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Memory: 1023MB = 1023MB total
[    0.000000] Memory: 1008492k/1008492k available, 40084k reserved, 269312K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06e9e60   (7048 kB)
[    0.000000]       .init : 0xc06ea000 - 0xc073f2c0   ( 341 kB)
[    0.000000]       .data : 0xc0740000 - 0xc07d6c78   ( 604 kB)
[    0.000000]        .bss : 0xc07d6c78 - 0xc0d31b34   (5484 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
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
[    0.000976] Calibrating delay loop... 1587.60 BogoMIPS (lpj=7938048)
[    0.079772] pid_max: default: 32768 minimum: 301
[    0.080352] Security Framework initialized
[    0.080566] Mount-cache hash table entries: 512
[    0.084197] CPU: Testing write buffer coherency: ok
[    0.085723] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.086120] Setting up static identity map for 0x804ea0c0 - 0x804ea130
[    0.086242] L310 cache controller enabled
[    0.086242] l2x0: 16 ways, CACHE_ID 0x000000c0, AUX_CTRL 0x7e470000, Cache size: 1048576 B
[    0.089813] CPU1: Booted secondary processor
[    0.126037] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.126403] Brought up 2 CPUs
[    0.126434] SMP: Total of 2 processors activated (3181.77 BogoMIPS).
[    0.128570] devtmpfs: initialized
[    0.194671] pinctrl core: initialized pinctrl subsystem
[    0.198242] regulator-dummy: no parameters
[    0.201110] NET: Registered protocol family 16
[    0.207580] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.208618] omap-gpmc omap-gpmc: GPMC revision 6.0
[    0.215118] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.215393] OMAP GPIO hardware version 0.1
[    0.216583] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.217895] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.219177] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.220428] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.221740] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.225677] omap_mux_init: Add partition: #1: core, flags: 3
[    0.227386] omap_mux_init: Add partition: #2: wkup, flags: 3
[    0.227539] error setting wl12xx data: -38
[    0.227661] _omap_mux_get_by_name: Could not find signal fref_clk0_out.sys_drm_msecure
[    0.227752] _omap_mux_get_by_name: Could not find signal sys_nirq
[    0.227752] _omap_mux_get_by_name: Could not find signal sys_nirq
[    0.231414] _omap_mux_get_by_name: Could not find signal uart1_rx.uart1_rx
[    0.231445] _omap_mux_get_by_name: Could not find signal uart1_rx.uart1_rx
[    0.295471] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.295501] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.305480] OMAP DMA hardware revision 0.0
[    0.306152] Serial: AMBA PL011 UART driver
[    0.308898] ARM PMU: not yet supported on OMAP4430 due to missing CTI driver
[    0.341796] bio: create slab <bio-0> at 0
[    0.389862] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.390747] vwl1271: 1800 mV 
[    0.394683] SCSI subsystem initialized
[    0.395935] usbcore: registered new interface driver usbfs
[    0.396270] usbcore: registered new interface driver hub
[    0.396697] usbcore: registered new device driver usb
[    0.401428] Skipping twl internal clock init and using bootloader value (unknown osc rate)
[    0.403350] twl 1-0048: PIH (irq 39) chaining IRQs 418..438
[    0.404998] VUSB: 3300 mV normal standby
[    0.406158] vdd_mpu: 500 <--> 1500 mV normal 
[    0.407257] vdd_iva: 500 <--> 1500 mV normal 
[    0.408325] vdd_core: 500 <--> 1500 mV normal 
[    0.409759] V1V8: 1800 mV normal standby
[    0.410736] V2V1: 2100 mV normal standby
[    0.411987] VMMC: 1200 <--> 3000 mV at 3000 mV normal standby
[    0.413391] VPP: 1800 <--> 2500 mV at 1900 mV normal standby
[    0.414947] VCXIO: 1800 mV normal standby
[    0.415008] VCXIO: supplied by V2V1
[    0.417358] VDAC: 1800 mV normal standby
[    0.417419] VDAC: supplied by V2V1
[    0.419189] VAUX2_6030: 1200 <--> 2800 mV at 1800 mV normal standby
[    0.420654] VAUX3_6030: 1000 <--> 3000 mV at 1200 mV normal standby
[    0.422271] VANA: 2100 mV normal standby
[    0.422973] omap_i2c omap_i2c.1: bus 1 rev0.10 at 400 kHz
[    0.423797] omap_i2c omap_i2c.2: bus 2 rev0.10 at 400 kHz
[    0.424896] omap_i2c omap_i2c.3: bus 3 rev0.10 at 100 kHz
[    0.425567] omap_i2c omap_i2c.4: bus 4 rev0.10 at 400 kHz
[    0.430999] Switching to clocksource 32k_counter
[    0.508880] NET: Registered protocol family 2
[    0.510406] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.510711] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.513061] TCP: Hash tables configured (established 8192 bind 8192)
[    0.513305] TCP: reno registered
[    0.513336] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.513671] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.514556] NET: Registered protocol family 1
[    0.515502] RPC: Registered named UNIX socket transport module.
[    0.515502] RPC: Registered udp transport module.
[    0.515533] RPC: Registered tcp transport module.
[    0.515533] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.515747] usbhs_omap usbhs_omap: ehci_logic_fck failed:-2
[    0.516021] ------------[ cut here ]------------
[    0.516082] WARNING: at /work/kernel/omap/dev/drivers/clk/clk.c:522 __clk_enable+0x8c/0x9c()
[    0.516082] Modules linked in:
[    0.516143] [<c00145a8>] (unwind_backtrace+0x0/0xf0) from [<c003bd6c>] (warn_slowpath_common+0x4c/0x64)
[    0.516143] [<c003bd6c>] (warn_slowpath_common+0x4c/0x64) from [<c003bda0>] (warn_slowpath_null+0x1c/0x24)
[    0.516174] [<c003bda0>] (warn_slowpath_null+0x1c/0x24) from [<c0412758>] (__clk_enable+0x8c/0x9c)
[    0.516174] [<c0412758>] (__clk_enable+0x8c/0x9c) from [<c0412788>] (clk_enable+0x20/0x3c)
[    0.516204] [<c0412788>] (clk_enable+0x20/0x3c) from [<c03317fc>] (usbhs_runtime_resume+0x60/0xa4)
[    0.516235] [<c03317fc>] (usbhs_runtime_resume+0x60/0xa4) from [<c031b408>] (pm_generic_runtime_resume+0x2c/0x40)
[    0.516265] [<c031b408>] (pm_generic_runtime_resume+0x2c/0x40) from [<c031f07c>] (__rpm_callback+0x34/0x70)
[    0.516296] [<c031f07c>] (__rpm_callback+0x34/0x70) from [<c0320040>] (rpm_resume+0x3bc/0x648)
[    0.516326] [<c0320040>] (rpm_resume+0x3bc/0x648) from [<c0320548>] (__pm_runtime_resume+0x48/0x60)
[    0.516326] [<c0320548>] (__pm_runtime_resume+0x48/0x60) from [<c0331bf0>] (usbhs_omap_probe+0x200/0x840)
[    0.516357] [<c0331bf0>] (usbhs_omap_probe+0x200/0x840) from [<c0317d24>] (platform_drv_probe+0x18/0x1c)
[    0.516387] [<c0317d24>] (platform_drv_probe+0x18/0x1c) from [<c0316ae4>] (driver_probe_device+0x78/0x210)
[    0.516387] [<c0316ae4>] (driver_probe_device+0x78/0x210) from [<c0316d10>] (__driver_attach+0x94/0x98)
[    0.516418] [<c0316d10>] (__driver_attach+0x94/0x98) from [<c03153e4>] (bus_for_each_dev+0x50/0x7c)
[    0.516448] [<c03153e4>] (bus_for_each_dev+0x50/0x7c) from [<c0316310>] (bus_add_driver+0x178/0x240)
[    0.516448] [<c0316310>] (bus_add_driver+0x178/0x240) from [<c03171dc>] (driver_register+0x78/0x144)
[    0.516479] [<c03171dc>] (driver_register+0x78/0x144) from [<c0317f14>] (platform_driver_probe+0x18/0x9c)
[    0.516479] [<c0317f14>] (platform_driver_probe+0x18/0x9c) from [<c00086e4>] (do_one_initcall+0x34/0x178)
[    0.516510] [<c00086e4>] (do_one_initcall+0x34/0x178) from [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc)
[    0.516571] [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc) from [<c04d7a78>] (kernel_init+0x8/0xe4)
[    0.516571] [<c04d7a78>] (kernel_init+0x8/0xe4) from [<c000dd10>] (ret_from_fork+0x14/0x24)
[    0.516693] ---[ end trace e713e7725948e018 ]---
[    0.516693] ------------[ cut here ]------------
[    0.516723] WARNING: at /work/kernel/omap/dev/drivers/clk/clk.c:522 __clk_enable+0x8c/0x9c()
[    0.516723] Modules linked in:
[    0.516754] [<c00145a8>] (unwind_backtrace+0x0/0xf0) from [<c003bd6c>] (warn_slowpath_common+0x4c/0x64)
[    0.516754] [<c003bd6c>] (warn_slowpath_common+0x4c/0x64) from [<c003bda0>] (warn_slowpath_null+0x1c/0x24)
[    0.516784] [<c003bda0>] (warn_slowpath_null+0x1c/0x24) from [<c0412758>] (__clk_enable+0x8c/0x9c)
[    0.516784] [<c0412758>] (__clk_enable+0x8c/0x9c) from [<c0412788>] (clk_enable+0x20/0x3c)
[    0.516815] [<c0412788>] (clk_enable+0x20/0x3c) from [<c0331804>] (usbhs_runtime_resume+0x68/0xa4)
[    0.516845] [<c0331804>] (usbhs_runtime_resume+0x68/0xa4) from [<c031b408>] (pm_generic_runtime_resume+0x2c/0x40)
[    0.516845] [<c031b408>] (pm_generic_runtime_resume+0x2c/0x40) from [<c031f07c>] (__rpm_callback+0x34/0x70)
[    0.516876] [<c031f07c>] (__rpm_callback+0x34/0x70) from [<c0320040>] (rpm_resume+0x3bc/0x648)
[    0.516876] [<c0320040>] (rpm_resume+0x3bc/0x648) from [<c0320548>] (__pm_runtime_resume+0x48/0x60)
[    0.516906] [<c0320548>] (__pm_runtime_resume+0x48/0x60) from [<c0331bf0>] (usbhs_omap_probe+0x200/0x840)
[    0.516937] [<c0331bf0>] (usbhs_omap_probe+0x200/0x840) from [<c0317d24>] (platform_drv_probe+0x18/0x1c)
[    0.516937] [<c0317d24>] (platform_drv_probe+0x18/0x1c) from [<c0316ae4>] (driver_probe_device+0x78/0x210)
[    0.516967] [<c0316ae4>] (driver_probe_device+0x78/0x210) from [<c0316d10>] (__driver_attach+0x94/0x98)
[    0.516967] [<c0316d10>] (__driver_attach+0x94/0x98) from [<c03153e4>] (bus_for_each_dev+0x50/0x7c)
[    0.516998] [<c03153e4>] (bus_for_each_dev+0x50/0x7c) from [<c0316310>] (bus_add_driver+0x178/0x240)
[    0.516998] [<c0316310>] (bus_add_driver+0x178/0x240) from [<c03171dc>] (driver_register+0x78/0x144)
[    0.517028] [<c03171dc>] (driver_register+0x78/0x144) from [<c0317f14>] (platform_driver_probe+0x18/0x9c)
[    0.517028] [<c0317f14>] (platform_driver_probe+0x18/0x9c) from [<c00086e4>] (do_one_initcall+0x34/0x178)
[    0.517059] [<c00086e4>] (do_one_initcall+0x34/0x178) from [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc)
[    0.517089] [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc) from [<c04d7a78>] (kernel_init+0x8/0xe4)
[    0.517089] [<c04d7a78>] (kernel_init+0x8/0xe4) from [<c000dd10>] (ret_from_fork+0x14/0x24)
[    0.517120] ---[ end trace e713e7725948e019 ]---
[    0.517120] ------------[ cut here ]------------
[    0.517150] WARNING: at /work/kernel/omap/dev/drivers/clk/clk.c:481 clk_disable+0x20/0x34()
[    0.517150] Modules linked in:
[    0.517181] [<c00145a8>] (unwind_backtrace+0x0/0xf0) from [<c003bd6c>] (warn_slowpath_common+0x4c/0x64)
[    0.517181] [<c003bd6c>] (warn_slowpath_common+0x4c/0x64) from [<c003bda0>] (warn_slowpath_null+0x1c/0x24)
[    0.517211] [<c003bda0>] (warn_slowpath_null+0x1c/0x24) from [<c04126b8>] (clk_disable+0x20/0x34)
[    0.517242] [<c04126b8>] (clk_disable+0x20/0x34) from [<c0331884>] (usbhs_runtime_suspend+0x44/0xa4)
[    0.517242] [<c0331884>] (usbhs_runtime_suspend+0x44/0xa4) from [<c031b3c8>] (pm_generic_runtime_suspend+0x2c/0x40)
[    0.517272] [<c031b3c8>] (pm_generic_runtime_suspend+0x2c/0x40) from [<c00257b8>] (_od_runtime_suspend+0xc/0x24)
[    0.517303] [<c00257b8>] (_od_runtime_suspend+0xc/0x24) from [<c031f07c>] (__rpm_callback+0x34/0x70)
[    0.517303] [<c031f07c>] (__rpm_callback+0x34/0x70) from [<c031f3f8>] (rpm_suspend+0xec/0x5cc)
[    0.517333] [<c031f3f8>] (rpm_suspend+0xec/0x5cc) from [<c03207e4>] (__pm_runtime_suspend+0x5c/0x74)
[    0.517333] [<c03207e4>] (__pm_runtime_suspend+0x5c/0x74) from [<c031b8e0>] (pm_generic_runtime_idle+0x44/0x4c)
[    0.517364] [<c031b8e0>] (pm_generic_runtime_idle+0x44/0x4c) from [<c031f07c>] (__rpm_callback+0x34/0x70)
[    0.517364] [<c031f07c>] (__rpm_callback+0x34/0x70) from [<c031fa4c>] (rpm_idle+0x100/0x250)
[    0.517395] [<c031fa4c>] (rpm_idle+0x100/0x250) from [<c031fc6c>] (__pm_runtime_idle+0x5c/0x74)
[    0.517395] [<c031fc6c>] (__pm_runtime_idle+0x5c/0x74) from [<c0331c4c>] (usbhs_omap_probe+0x25c/0x840)
[    0.517425] [<c0331c4c>] (usbhs_omap_probe+0x25c/0x840) from [<c0317d24>] (platform_drv_probe+0x18/0x1c)
[    0.517456] [<c0317d24>] (platform_drv_probe+0x18/0x1c) from [<c0316ae4>] (driver_probe_device+0x78/0x210)
[    0.517456] [<c0316ae4>] (driver_probe_device+0x78/0x210) from [<c0316d10>] (__driver_attach+0x94/0x98)
[    0.517486] [<c0316d10>] (__driver_attach+0x94/0x98) from [<c03153e4>] (bus_for_each_dev+0x50/0x7c)
[    0.517486] [<c03153e4>] (bus_for_each_dev+0x50/0x7c) from [<c0316310>] (bus_add_driver+0x178/0x240)
[    0.517517] [<c0316310>] (bus_add_driver+0x178/0x240) from [<c03171dc>] (driver_register+0x78/0x144)
[    0.517517] [<c03171dc>] (driver_register+0x78/0x144) from [<c0317f14>] (platform_driver_probe+0x18/0x9c)
[    0.517547] [<c0317f14>] (platform_driver_probe+0x18/0x9c) from [<c00086e4>] (do_one_initcall+0x34/0x178)
[    0.517578] [<c00086e4>] (do_one_initcall+0x34/0x178) from [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc)
[    0.517578] [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc) from [<c04d7a78>] (kernel_init+0x8/0xe4)
[    0.517608] [<c04d7a78>] (kernel_init+0x8/0xe4) from [<c000dd10>] (ret_from_fork+0x14/0x24)
[    0.517608] ---[ end trace e713e7725948e01a ]---
[    0.517608] ------------[ cut here ]------------
[    0.517639] WARNING: at /work/kernel/omap/dev/drivers/clk/clk.c:481 clk_disable+0x20/0x34()
[    0.517639] Modules linked in:
[    0.517669] [<c00145a8>] (unwind_backtrace+0x0/0xf0) from [<c003bd6c>] (warn_slowpath_common+0x4c/0x64)
[    0.517669] [<c003bd6c>] (warn_slowpath_common+0x4c/0x64) from [<c003bda0>] (warn_slowpath_null+0x1c/0x24)
[    0.517700] [<c003bda0>] (warn_slowpath_null+0x1c/0x24) from [<c04126b8>] (clk_disable+0x20/0x34)
[    0.517730] [<c04126b8>] (clk_disable+0x20/0x34) from [<c033188c>] (usbhs_runtime_suspend+0x4c/0xa4)
[    0.517730] [<c033188c>] (usbhs_runtime_suspend+0x4c/0xa4) from [<c031b3c8>] (pm_generic_runtime_suspend+0x2c/0x40)
[    0.517761] [<c031b3c8>] (pm_generic_runtime_suspend+0x2c/0x40) from [<c00257b8>] (_od_runtime_suspend+0xc/0x24)
[    0.517761] [<c00257b8>] (_od_runtime_suspend+0xc/0x24) from [<c031f07c>] (__rpm_callback+0x34/0x70)
[    0.517791] [<c031f07c>] (__rpm_callback+0x34/0x70) from [<c031f3f8>] (rpm_suspend+0xec/0x5cc)
[    0.517791] [<c031f3f8>] (rpm_suspend+0xec/0x5cc) from [<c03207e4>] (__pm_runtime_suspend+0x5c/0x74)
[    0.517822] [<c03207e4>] (__pm_runtime_suspend+0x5c/0x74) from [<c031b8e0>] (pm_generic_runtime_idle+0x44/0x4c)
[    0.517852] [<c031b8e0>] (pm_generic_runtime_idle+0x44/0x4c) from [<c031f07c>] (__rpm_callback+0x34/0x70)
[    0.517852] [<c031f07c>] (__rpm_callback+0x34/0x70) from [<c031fa4c>] (rpm_idle+0x100/0x250)
[    0.517883] [<c031fa4c>] (rpm_idle+0x100/0x250) from [<c031fc6c>] (__pm_runtime_idle+0x5c/0x74)
[    0.517883] [<c031fc6c>] (__pm_runtime_idle+0x5c/0x74) from [<c0331c4c>] (usbhs_omap_probe+0x25c/0x840)
[    0.517913] [<c0331c4c>] (usbhs_omap_probe+0x25c/0x840) from [<c0317d24>] (platform_drv_probe+0x18/0x1c)
[    0.517944] [<c0317d24>] (platform_drv_probe+0x18/0x1c) from [<c0316ae4>] (driver_probe_device+0x78/0x210)
[    0.517944] [<c0316ae4>] (driver_probe_device+0x78/0x210) from [<c0316d10>] (__driver_attach+0x94/0x98)
[    0.517974] [<c0316d10>] (__driver_attach+0x94/0x98) from [<c03153e4>] (bus_for_each_dev+0x50/0x7c)
[    0.517974] [<c03153e4>] (bus_for_each_dev+0x50/0x7c) from [<c0316310>] (bus_add_driver+0x178/0x240)
[    0.518005] [<c0316310>] (bus_add_driver+0x178/0x240) from [<c03171dc>] (driver_register+0x78/0x144)
[    0.518005] [<c03171dc>] (driver_register+0x78/0x144) from [<c0317f14>] (platform_driver_probe+0x18/0x9c)
[    0.518035] [<c0317f14>] (platform_driver_probe+0x18/0x9c) from [<c00086e4>] (do_one_initcall+0x34/0x178)
[    0.518035] [<c00086e4>] (do_one_initcall+0x34/0x178) from [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc)
[    0.518066] [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc) from [<c04d7a78>] (kernel_init+0x8/0xe4)
[    0.518096] [<c04d7a78>] (kernel_init+0x8/0xe4) from [<c000dd10>] (ret_from_fork+0x14/0x24)
[    0.518096] ---[ end trace e713e7725948e01b ]---
[    0.649230] bounce pool size: 64 pages
[    0.649719] VFS: Disk quotas dquot_6.5.2
[    0.649932] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.652038] NFS: Registering the id_resolver key type
[    0.652374] Key type id_resolver registered
[    0.652374] Key type id_legacy registered
[    0.652496] jffs2: version 2.2. (NAND) (SUMMARY)  B) 2001-2006 Red Hat, Inc.
[    0.652984] msgmni has been set to 1475
[    0.655090] io scheduler noop registered
[    0.655090] io scheduler deadline registered
[    0.655181] io scheduler cfq registered (default)
[    0.657562] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.662078] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 104) is a OMAP UART0
[    0.663574] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 105) is a OMAP UART1
[    0.664520] omap_uart.2: ttyO2 at MMIO 0x48020000 (irq = 106) is a OMAP UART2
[    2.427429] console [ttyO2] enabled
[    2.432189] omap_uart.3: ttyO3 at MMIO 0x4806e000 (irq = 102) is a OMAP UART3
[    2.459594] brd: module loaded
[    2.474517] loop: module loaded
[    2.481048] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.488433] OneNAND driver initializing
[    2.498931] usbcore: registered new interface driver asix
[    2.504913] usbcore: registered new interface driver cdc_ether
[    2.511383] usbcore: registered new interface driver smsc95xx
[    2.517639] usbcore: registered new interface driver net1080
[    2.523864] usbcore: registered new interface driver cdc_subset
[    2.530334] usbcore: registered new interface driver zaurus
[    2.536499] usbcore: registered new interface driver cdc_ncm
[    2.543395] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.550262] ehci_hcd: block sizes: qh 60 qtd 96 itd 160 sitd 96
[    2.550506] ehci-omap ehci-omap.0: failed to get ehci port0 regulator
[    2.550567] ------------[ cut here ]------------
[    2.555450] WARNING: at /work/kernel/omap/dev/drivers/clk/clk.c:522 __clk_enable+0x8c/0x9c()
[    2.564300] Modules linked in:
[    2.567565] [<c00145a8>] (unwind_backtrace+0x0/0xf0) from [<c003bd6c>] (warn_slowpath_common+0x4c/0x64)
[    2.577423] [<c003bd6c>] (warn_slowpath_common+0x4c/0x64) from [<c003bda0>] (warn_slowpath_null+0x1c/0x24)
[    2.587585] [<c003bda0>] (warn_slowpath_null+0x1c/0x24) from [<c0412758>] (__clk_enable+0x8c/0x9c)
[    2.596984] [<c0412758>] (__clk_enable+0x8c/0x9c) from [<c0412788>] (clk_enable+0x20/0x3c)
[    2.605682] [<c0412788>] (clk_enable+0x20/0x3c) from [<c03317fc>] (usbhs_runtime_resume+0x60/0xa4)
[    2.615112] [<c03317fc>] (usbhs_runtime_resume+0x60/0xa4) from [<c031b408>] (pm_generic_runtime_resume+0x2c/0x40)
[    2.625915] [<c031b408>] (pm_generic_runtime_resume+0x2c/0x40) from [<c031f07c>] (__rpm_callback+0x34/0x70)
[    2.636138] [<c031f07c>] (__rpm_callback+0x34/0x70) from [<c0320040>] (rpm_resume+0x3bc/0x648)
[    2.645202] [<c0320040>] (rpm_resume+0x3bc/0x648) from [<c031ff40>] (rpm_resume+0x2bc/0x648)
[    2.654052] [<c031ff40>] (rpm_resume+0x2bc/0x648) from [<c0320548>] (__pm_runtime_resume+0x48/0x60)
[    2.663574] [<c0320548>] (__pm_runtime_resume+0x48/0x60) from [<c03b38ec>] (ehci_hcd_omap_probe+0xf0/0x23c)
[    2.673828] [<c03b38ec>] (ehci_hcd_omap_probe+0xf0/0x23c) from [<c0317d24>] (platform_drv_probe+0x18/0x1c)
[    2.683959] [<c0317d24>] (platform_drv_probe+0x18/0x1c) from [<c0316ae4>] (driver_probe_device+0x78/0x210)
[    2.694122] [<c0316ae4>] (driver_probe_device+0x78/0x210) from [<c0316d10>] (__driver_attach+0x94/0x98)
[    2.703979] [<c0316d10>] (__driver_attach+0x94/0x98) from [<c03153e4>] (bus_for_each_dev+0x50/0x7c)
[    2.713500] [<c03153e4>] (bus_for_each_dev+0x50/0x7c) from [<c0316310>] (bus_add_driver+0x178/0x240)
[    2.723083] [<c0316310>] (bus_add_driver+0x178/0x240) from [<c03171dc>] (driver_register+0x78/0x144)
[    2.732696] [<c03171dc>] (driver_register+0x78/0x144) from [<c071402c>] (ehci_hcd_init+0xa0/0xfc)
[    2.742034] [<c071402c>] (ehci_hcd_init+0xa0/0xfc) from [<c00086e4>] (do_one_initcall+0x34/0x178)
[    2.751373] [<c00086e4>] (do_one_initcall+0x34/0x178) from [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc)
[    2.761444] [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc) from [<c04d7a78>] (kernel_init+0x8/0xe4)
[    2.770965] [<c04d7a78>] (kernel_init+0x8/0xe4) from [<c000dd10>] (ret_from_fork+0x14/0x24)
[    2.779724] ---[ end trace e713e7725948e01c ]---
[    2.784576] ------------[ cut here ]------------
[    2.789428] WARNING: at /work/kernel/omap/dev/drivers/clk/clk.c:522 __clk_enable+0x8c/0x9c()
[    2.798278] Modules linked in:
[    2.801513] [<c00145a8>] (unwind_backtrace+0x0/0xf0) from [<c003bd6c>] (warn_slowpath_common+0x4c/0x64)
[    2.811370] [<c003bd6c>] (warn_slowpath_common+0x4c/0x64) from [<c003bda0>] (warn_slowpath_null+0x1c/0x24)
[    2.821533] [<c003bda0>] (warn_slowpath_null+0x1c/0x24) from [<c0412758>] (__clk_enable+0x8c/0x9c)
[    2.830932] [<c0412758>] (__clk_enable+0x8c/0x9c) from [<c0412788>] (clk_enable+0x20/0x3c)
[    2.839630] [<c0412788>] (clk_enable+0x20/0x3c) from [<c0331804>] (usbhs_runtime_resume+0x68/0xa4)
[    2.849029] [<c0331804>] (usbhs_runtime_resume+0x68/0xa4) from [<c031b408>] (pm_generic_runtime_resume+0x2c/0x40)
[    2.859832] [<c031b408>] (pm_generic_runtime_resume+0x2c/0x40) from [<c031f07c>] (__rpm_callback+0x34/0x70)
[    2.870056] [<c031f07c>] (__rpm_callback+0x34/0x70) from [<c0320040>] (rpm_resume+0x3bc/0x648)
[    2.879119] [<c0320040>] (rpm_resume+0x3bc/0x648) from [<c031ff40>] (rpm_resume+0x2bc/0x648)
[    2.887969] [<c031ff40>] (rpm_resume+0x2bc/0x648) from [<c0320548>] (__pm_runtime_resume+0x48/0x60)
[    2.897491] [<c0320548>] (__pm_runtime_resume+0x48/0x60) from [<c03b38ec>] (ehci_hcd_omap_probe+0xf0/0x23c)
[    2.907714] [<c03b38ec>] (ehci_hcd_omap_probe+0xf0/0x23c) from [<c0317d24>] (platform_drv_probe+0x18/0x1c)
[    2.917877] [<c0317d24>] (platform_drv_probe+0x18/0x1c) from [<c0316ae4>] (driver_probe_device+0x78/0x210)
[    2.928009] [<c0316ae4>] (driver_probe_device+0x78/0x210) from [<c0316d10>] (__driver_attach+0x94/0x98)
[    2.937896] [<c0316d10>] (__driver_attach+0x94/0x98) from [<c03153e4>] (bus_for_each_dev+0x50/0x7c)
[    2.947387] [<c03153e4>] (bus_for_each_dev+0x50/0x7c) from [<c0316310>] (bus_add_driver+0x178/0x240)
[    2.957000] [<c0316310>] (bus_add_driver+0x178/0x240) from [<c03171dc>] (driver_register+0x78/0x144)
[    2.966583] [<c03171dc>] (driver_register+0x78/0x144) from [<c071402c>] (ehci_hcd_init+0xa0/0xfc)
[    2.975921] [<c071402c>] (ehci_hcd_init+0xa0/0xfc) from [<c00086e4>] (do_one_initcall+0x34/0x178)
[    2.985229] [<c00086e4>] (do_one_initcall+0x34/0x178) from [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc)
[    2.995300] [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc) from [<c04d7a78>] (kernel_init+0x8/0xe4)
[    3.004791] [<c04d7a78>] (kernel_init+0x8/0xe4) from [<c000dd10>] (ret_from_fork+0x14/0x24)
[    3.013580] ---[ end trace e713e7725948e01d ]---
[    3.018463] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    3.026153] ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
[    3.033996] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=0 cc=1 pcc=3 ordered ports=3
[    3.033996] ehci-omap ehci-omap.0: reset hcc_params 20016 thresh 1 uframes 256/512/1024 park LPM
[    3.035125] ehci-omap ehci-omap.0: park 0
[    3.035247] ehci-omap ehci-omap.0: reset command 0080b02  park=3 ithresh=8 period=1024 Reset HALT
[    3.035308] ehci-omap ehci-omap.0: irq 109, io mem 0x4a064c00
[    3.041381] ehci-omap ehci-omap.0: init command 0010005 (park)=0 ithresh=1 period=512 RUN
[    3.061370] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    3.067932] usb usb1: default language 0x0409
[    3.067993] usb usb1: udev 1, busnum 1, minor = 0
[    3.068023] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.075164] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.082763] usb usb1: Product: OMAP-EHCI Host Controller
[    3.088348] usb usb1: Manufacturer: Linux 3.8.0-rc7-lo-ehci-12285-g3403fe6 ehci_hcd
[    3.096405] usb usb1: SerialNumber: ehci-omap.0
[    3.102783] usb usb1: usb_probe_device
[    3.102783] usb usb1: configuration #1 chosen from 1 choice
[    3.103210] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    3.103881] hub 1-0:1.0: usb_probe_interface
[    3.103912] hub 1-0:1.0: usb_probe_interface - got id
[    3.103942] hub 1-0:1.0: USB hub found
[    3.108001] hub 1-0:1.0: 3 ports detected
[    3.112243] hub 1-0:1.0: standalone hub
[    3.112274] hub 1-0:1.0: individual port power switching
[    3.112274] hub 1-0:1.0: individual port over-current protection
[    3.112274] hub 1-0:1.0: power on to power good time: 20ms
[    3.112548] hub 1-0:1.0: local power source is good
[    3.112884] hub 1-0:1.0: enabling power on all ports
[    3.114105] usbcore: registered new interface driver cdc_wdm
[    3.120056] Initializing USB Mass Storage driver...
[    3.125518] usbcore: registered new interface driver usb-storage
[    3.131866] USB Mass Storage support registered.
[    3.136993] usbcore: registered new interface driver usbtest
[    3.144165] mousedev: PS/2 mouse device common for all mice
[    3.153381] twl_rtc twl_rtc: Power up reset detected.
[    3.159515] twl_rtc twl_rtc: Enabling TWL-RTC
[    3.167999] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    3.174987] i2c /dev entries driver
[    3.181518] Driver for 1-wire Dallas network protocol.
[    3.189849] omap_wdt: OMAP Watchdog Timer Rev 0x00: initial timeout 60 sec
[    3.199493] omap-dma-engine omap-dma-engine: allocating channel for 62
[    3.206481] omap-dma-engine omap-dma-engine: allocating channel for 61
[    3.221618] ehci-omap ehci-omap.0: GetStatus port:1 status 001803 0  ACK POWER sig=j CSC CONNECT
[    3.221649] hub 1-0:1.0: port 1: status 0501 change 0001
[    3.271606] omap-dma-engine omap-dma-engine: allocating channel for 60
[    3.278472] omap-dma-engine omap-dma-engine: allocating channel for 59
[    3.356048] hub 1-0:1.0: state 7 ports 3 chg 0002 evt 0000
[    3.356140] hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[    3.395202] ledtrig-cpu: registered to indicate activity on CPUs
[    3.402465] usbcore: registered new interface driver usbhid
[    3.408325] usbhid: USB HID core driver
[    3.411743] ehci-omap ehci-omap.0: port 1 reset complete, port enabled
[    3.411773] ehci-omap ehci-omap.0: GetStatus port:1 status 001805 0  ACK POWER sig=j PE CONNECT
[    3.413238] oprofile: no performance counters
[    3.419128] oprofile: using timer interrupt.
[    3.424133] TCP: cubic registered
[    3.427612] Initializing XFRM netlink socket
[    3.432281] NET: Registered protocol family 17
[    3.437011] NET: Registered protocol family 15
[    3.441955] Key type dns_resolver registered
[    3.446533] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 1
[    3.460693] Power Management for TI OMAP4.
[    3.465179] OMAP4 PM: u-boot >= v2012.07 is required for full PM support
[    3.471405] usb 1-1: new high-speed USB device number 2 using ehci-omap
[    3.479431] ThumbEE CPU extension supported.
[    3.486633] VANA: incomplete constraints, leaving on
[    3.493164] VDAC: incomplete constraints, leaving on
[    3.499206] VUSB: incomplete constraints, leaving on
[    3.507446] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
[    3.531524] ehci-omap ehci-omap.0: port 1 reset complete, port enabled
[    3.531524] ehci-omap ehci-omap.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[    3.622100] usb 1-1: udev 2, busnum 1, minor = 1
[    3.622131] usb 1-1: New USB device found, idVendor=0424, idProduct=9514
[    3.629180] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.637695] usb 1-1: usb_probe_device
[    3.637725] usb 1-1: configuration #1 chosen from 1 choice
[    3.638153] usb 1-1: adding 1-1:1.0 (config #1, interface 0)
[    3.638580] hub 1-1:1.0: usb_probe_interface
[    3.638580] hub 1-1:1.0: usb_probe_interface - got id
[    3.638641] hub 1-1:1.0: USB hub found
[    3.642822] hub 1-1:1.0: 5 ports detected
[    3.647064] hub 1-1:1.0: compound device; port removable status: FRRRR
[    3.647094] hub 1-1:1.0: individual port power switching
[    3.647094] hub 1-1:1.0: individual port over-current protection
[    3.647552] hub 1-1:1.0: TT per port
[    3.647552] hub 1-1:1.0: TT requires at most 8 FS bit times (666 ns)
[    3.647583] hub 1-1:1.0: power on to power good time: 100ms
[    3.648101] hub 1-1:1.0: local power source is good
[    3.648529] hub 1-1:1.0: enabling power on all ports
[    3.730560] mmc0: host does not support reading read-only switch. assuming write-enable.
[    3.741943] mmc0: new high speed SD card at address 0260
[    3.749206] mmcblk0: mmc0:0260 1232  961 MiB 
[    3.759429]  mmcblk0: p1 p2
[    3.763092] hub 1-1:1.0: port 1: status 0101 change 0001
[    3.861389] usb 1-1: link qh256-0001/eda97c80 start 1 [1/0 us]
[    3.861572] hub 1-1:1.0: state 7 ports 5 chg 0002 evt 0000
[    3.861846] hub 1-1:1.0: port 1, status 0101, change 0000, 12 Mb/s
[    3.941436] usb 1-1.1: new high-speed USB device number 3 using ehci-omap
[    4.176086] usb 1-1.1: udev 3, busnum 1, minor = 2
[    4.176086] usb 1-1.1: New USB device found, idVendor=0424, idProduct=ec00
[    4.183349] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.191894] usb 1-1.1: usb_probe_device
[    4.191894] usb 1-1.1: configuration #1 chosen from 1 choice
[    4.194244] usb 1-1.1: adding 1-1.1:1.0 (config #1, interface 0)
[    4.194671] smsc95xx 1-1.1:1.0: usb_probe_interface
[    4.194702] smsc95xx 1-1.1:1.0: usb_probe_interface - got id
[    4.194793] smsc95xx v1.0.4
[    7.088775] smsc95xx 1-1.1:1.0 eth0: register 'smsc95xx' at usb-ehci-omap.0-1.1, smsc95xx USB 2.0 Ethernet, 0e:35:ac:08:c5:36
[    7.101043] hub 1-1:1.0: state 7 ports 5 chg 0000 evt 0002
[    9.641876] usb 1-1.1: link qh8-0001/eda97a00 start 2 [1/0 us]
[   11.005157] smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
[   11.001312] Sending DHCP requests ., OK
[   13.321441] IP-Config: Got DHCP answer from 192.168.1.254, my address is 192.168.1.214
[   13.330078] IP-Config: Complete:
[   13.333526]      device=eth0, hwaddr=0e:35:ac:08:c5:36, ipaddr=192.168.1.214, mask=255.255.255.0, gw=192.168.1.254
[   13.344421]      host=192.168.1.214, domain=lan, nis-domain=(none)
[   13.350921]      bootserver=192.168.1.254, rootserver=192.168.1.2, rootpath=
[   13.358154]      nameserver0=192.168.1.254<6>[   13.389282] VFS: Mounted root (nfs filesystem) on device 0:12.
[   13.397186] devtmpfs: mounted
[   13.400695] Freeing init memory: 340K
[   15.704620] udev[794]: starting version 164
[   25.569244] sshd (1305): /proc/1305/oom_adj is deprecated, please use /proc/1305/oom_score_adj instead.
root@paris:~# 
