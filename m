From: Paul Walmsley <paul@pwsan.com>
Subject: Interesting L3 driver panic on v3.2-rc5 on 3530
Date: Fri, 16 Dec 2011 19:02:51 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112161859190.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56926 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150Ab1LQCCw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 21:02:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: santosh.shilimkar@pwsan.com


Hi

Just got this on a cold boot on 3530 BeagleBoard.  The hwmod warnings
are expected, but the BUG() from the L3 bus driver ISR is not.

Probably we should not BUG there, but log something akin to an x86
machine check exception.


- Paul


Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.2.0-rc5-00009-g2c199c7 (paul@dusk) (gcc version 4.5.1 (Sourcery G++ Lite 20101
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c06dd1a0, node_mem_map c0c34000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65024 pages, LIFO batch:15
[    0.000000] OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:2005 omap_hwmod_register+0x11c/0x158()
[    0.000000] omap_hwmod: iva: _register returned -22
[    0.000000] Modules linked in:
[    0.000000] [<c001b4e4>] (unwind_backtrace+0x0/0xf0) from [<c0053be4>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c0053be4>] (warn_slowpath_common+0x4c/0x64) from [<c0053c90>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c0053c90>] (warn_slowpath_fmt+0x30/0x40) from [<c0614458>] (omap_hwmod_register+0x11c/0x158)
[    0.000000] [<c0614458>] (omap_hwmod_register+0x11c/0x158) from [<c0611810>] (omap3_init_early+0x1c/0x28)
[    0.000000] [<c0611810>] (omap3_init_early+0x1c/0x28) from [<c060dcf4>] (setup_arch+0x7dc/0x8f4)
[    0.000000] [<c060dcf4>] (setup_arch+0x7dc/0x8f4) from [<c060a560>] (start_kernel+0x80/0x304)
[    0.000000] [<c060a560>] (start_kernel+0x80/0x304) from [<80008044>] (0x80008044)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:2005 omap_hwmod_register+0x11c/0x158()
[    0.000000] omap_hwmod: mailbox: _register returned -22
[    0.000000] Modules linked in:
[    0.000000] [<c001b4e4>] (unwind_backtrace+0x0/0xf0) from [<c0053be4>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c0053be4>] (warn_slowpath_common+0x4c/0x64) from [<c0053c90>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c0053c90>] (warn_slowpath_fmt+0x30/0x40) from [<c0614458>] (omap_hwmod_register+0x11c/0x158)
[    0.000000] [<c0614458>] (omap_hwmod_register+0x11c/0x158) from [<c0611810>] (omap3_init_early+0x1c/0x28)
[    0.000000] [<c0611810>] (omap3_init_early+0x1c/0x28) from [<c060dcf4>] (setup_arch+0x7dc/0x8f4)
[    0.000000] [<c060dcf4>] (setup_arch+0x7dc/0x8f4) from [<c060a560>] (start_kernel+0x80/0x304)
[    0.000000] [<c060a560>] (start_kernel+0x80/0x304) from [<80008044>] (0x80008044)
[    0.000000] ---[ end trace 1b75b31a2719ed1d ]---
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0e39000 s10112 r8192 d14464 u32768
[    0.000000] pcpu-alloc: s10112 r8192 d14464 u32768 alloc=8*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: console=ttyO2,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext3 mem=256M ik
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 256MB = 256MB total
[    0.000000] Memory: 247352k/247352k available, 14792k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0609414   (6150 kB)
[    0.000000]       .init : 0xc060a000 - 0xc0656780   ( 306 kB)
[    0.000000]       .data : 0xc0658000 - 0xc06deb10   ( 539 kB)
[    0.000000]        .bss : 0xc06deb34 - 0xc0c33040   (5458 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:410
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
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
[    0.057373] Calibrating delay loop... 471.61 BogoMIPS (lpj=1843200)
[    0.108123] pid_max: default: 32768 minimum: 301
[    0.113922] Security Framework initialized
[    0.118591] Mount-cache hash table entries: 512
[    0.129455] CPU: Testing write buffer coherency: ok
[    0.135864] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.143585] Brought up 1 CPUs
[    0.146759] SMP: Total of 1 processors activated (471.61 BogoMIPS).
[    0.180877] print_constraints: dummy: 
[    0.187683] NET: Registered protocol family 16
[    0.193786] GPMC revision 5.0
[    0.211791] OMAP GPIO hardware version 2.5
[    0.233642] ------------[ cut here ]------------
[    0.238494] Kernel BUG at c0033e34 [verbose debug info unavailable]
[    0.245025] Internal error: Oops - undefined instruction: 0 [#1] SMP
[    0.251678] Modules linked in:
[    0.254913] CPU: 0    Tainted: G        W     (3.2.0-rc5-00009-g2c199c7 #317)
[    0.262390] PC is at omap3_l3_app_irq+0x108/0x12c
[    0.267333] LR is at handle_irq_event_percpu+0x5c/0x22c
[    0.272796] pc : [<c0033e34>]    lr : [<c009e298>]    psr: 20000193
[    0.272796] sp : cf82fd80  ip : f8000000  fp : c06ddbd4
[    0.284790] r10: 00000000  r9 : c06ddbc0  r8 : 00000000
[    0.290283] r7 : c0033d2c  r6 : 0000000a  r5 : 00000000  r4 : 00008000
[    0.297088] r3 : 00000000  r2 : 00008000  r1 : 00000000  r0 : 00008000
[    0.303894] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.311614] Control: 10c5387d  Table: 80004019  DAC: 00000017
[    0.317626] Process swapper/0 (pid: 1, stack limit = 0xcf82e2f8)
[    0.323883] Stack: (0xcf82fd80 to 0xcf830000)
[    0.328491] fd80: 00000000 c00a1b10 60000193 00000080 60000193 cf861460 c065a914 0000000a
[    0.337005] fda0: c0033d2c c009e298 00000000 60000013 60000193 c065a8c0 c065a914 c065a8c0
[    0.345520] fdc0: c065a914 cf861460 0000000a 00000000 00000000 60000013 00000000 c009e4a4
[    0.354034] fde0: c065a8c0 c065a914 00000001 c00a087c c066ed80 c0655e78 cf82e000 c009daac
[    0.362548] fe00: 0000019a c0014bf8 c046104c 20000013 fa200000 cf82fe54 c065a914 c046129c
[    0.371093] fe20: 000045df 00000002 00000000 cf82d380 60000013 c065a914 0000000a 00000000
[    0.379608] fe40: c065a914 00000000 60000013 00000000 c0b0e568 cf82fe68 000045e0 c046104c
[    0.388122] fe60: 20000013 ffffffff c065a8c0 cf861460 0000000a c009f728 c009f9c4 c0100150
[    0.396636] fe80: 60000013 00000018 cf881e80 cf881e80 c0033d2c 00000000 0000000a c065a8c0
[    0.405151] fea0: cf861460 c009fa0c 00000000 00000021 cf85e008 cf881e80 cf85e000 cf85e008
[    0.413665] fec0: c05696a4 00000000 00000000 c06173fc c05696a4 cf881e80 c069a3cc cf85e008
[    0.422210] fee0: c0c29b70 cf85e03c c069a3cc c02b31f0 c02b31d8 c02b1e2c cf85e008 c069a3cc
[    0.430725] ff00: cf85e03c 00000000 00000000 c02b1fc8 c069a3cc c02b1f34 00000000 c02b0f10
[    0.439239] ff20: cf81a658 cf85cbb0 c069a3cc c06c7230 cf85c160 c02b16b0 c0560464 c0248064
[    0.447753] ff40: cf81a600 c069a3cc c06deb40 cf82e000 00000000 00000000 00000000 00000000
[    0.456268] ff60: 00000000 c02b24f8 00000000 c069a3b8 c06deb40 cf82e000 00000000 00000000
[    0.464813] ff80: 00000000 c02b36dc 00000000 c065334c c06deb40 c0008770 c00a2ddc c065e880
[    0.473327] ffa0: 0000005f c06172dc 0000005f 00000013 00000000 3539c224 00000000 00000000
[    0.481842] ffc0: c06b4adc c065334c c06537bc c0014e38 00000013 00000000 00000000 00000000
[    0.490356] ffe0: 00000000 c060a870 cf82d380 00000000 c060a7e4 c0014e38 02b7ef04 00735f8e
[    0.498901] [<c0033e34>] (omap3_l3_app_irq+0x108/0x12c) from [<c009e298>] (handle_irq_event_percpu+0x5c/0)
[    0.509307] [<c009e298>] (handle_irq_event_percpu+0x5c/0x22c) from [<c009e4a4>] (handle_irq_event+0x3c/0x)
[    0.519531] [<c009e4a4>] (handle_irq_event+0x3c/0x5c) from [<c00a087c>] (handle_level_irq+0xac/0x130)
[    0.529144] [<c00a087c>] (handle_level_irq+0xac/0x130) from [<c009daac>] (generic_handle_irq+0x30/0x48)
[    0.538909] [<c009daac>] (generic_handle_irq+0x30/0x48) from [<c0014bf8>] (handle_IRQ+0x4c/0xac)
[    0.548065] [<c0014bf8>] (handle_IRQ+0x4c/0xac) from [<c046129c>] (__irq_svc+0x3c/0xe0)
[    0.556427] [<c046129c>] (__irq_svc+0x3c/0xe0) from [<c046104c>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[    0.566284] [<c046104c>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<c009f728>] (__setup_irq+0x208/0x4)
[    0.576507] [<c009f728>] (__setup_irq+0x208/0x414) from [<c009fa0c>] (request_threaded_irq+0xd8/0x150)
[    0.586212] [<c009fa0c>] (request_threaded_irq+0xd8/0x150) from [<c06173fc>] (omap3_l3_probe+0x10c/0x16c)
[    0.596160] [<c06173fc>] (omap3_l3_probe+0x10c/0x16c) from [<c02b31f0>] (platform_drv_probe+0x18/0x1c)
[    0.605865] [<c02b31f0>] (platform_drv_probe+0x18/0x1c) from [<c02b1e2c>] (driver_probe_device+0x98/0x1a0)
[    0.615905] [<c02b1e2c>] (driver_probe_device+0x98/0x1a0) from [<c02b1fc8>] (__driver_attach+0x94/0x98)
[    0.625701] [<c02b1fc8>] (__driver_attach+0x94/0x98) from [<c02b0f10>] (bus_for_each_dev+0x50/0x7c)
[    0.635101] [<c02b0f10>] (bus_for_each_dev+0x50/0x7c) from [<c02b16b0>] (bus_add_driver+0xa0/0x2a8)
[    0.644531] [<c02b16b0>] (bus_add_driver+0xa0/0x2a8) from [<c02b24f8>] (driver_register+0x78/0x178)
[    0.653961] [<c02b24f8>] (driver_register+0x78/0x178) from [<c02b36dc>] (platform_driver_probe+0x18/0x9c)
[    0.663909] [<c02b36dc>] (platform_driver_probe+0x18/0x9c) from [<c0008770>] (do_one_initcall+0x34/0x194)
[    0.673858] [<c0008770>] (do_one_initcall+0x34/0x194) from [<c060a870>] (kernel_init+0x8c/0x134)
[    0.683013] [<c060a870>] (kernel_init+0x8c/0x134) from [<c0014e38>] (kernel_thread_exit+0x0/0x8)
[    0.692169] Code: e591c008 e28c3e53 e1c320d0 eaffffcd (e7f001f2) 
[    0.698608] ---[ end trace 1b75b31a2719ed1e ]---
[    0.703491] Kernel panic - not syncing: Fatal exception in interrupt
