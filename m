From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
 hwmodright before timer init
Date: Thu, 24 Feb 2011 02:00:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102240158070.6198@utopia.booyaka.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <20110223071153.5874.58923.stgit@twilight.localdomain> <581270b49665fcf8227a96065dbbc584@mail.gmail.com> <alpine.DEB.2.00.1102240109500.6198@utopia.booyaka.com> <alpine.DEB.2.00.1102240114160.6198@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A0958B7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40779 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699Ab1BXJAU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 04:00:20 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A0958B7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Thu, 24 Feb 2011, DebBarma, Tarun Kanti wrote:

> I have tested on OMAP3 and works fine.
> On OMAP2, I guess there is different issue for which it does not work.

Works fine for me on N800.  Boot log below.


- Paul

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.38-rc5-00065-g8a2f1db (paul@twilight) (gcc version 4.3.2 (Sourcery G++ Lite 2008q3-72) ) #180 Thu Feb 24 01:56:43 MST1
[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387f
[    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
[    0.000000] Machine: Nokia N800
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP2420
[    0.000000] 
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0xa0000
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c03c9850, node_mem_map c08ee000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32512 pages, LIFO batch:7
[    0.000000] Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
[    0.000000] GPMC revision 2.0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: root=/dev/mmcblk0p1 rootwait console=ttyO2,115200 earlyprintk debug init=/bin/bash
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 120756k/120756k available, 10316k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc002c000   ( 144 kB)
[    0.000000]       .text : 0xc002c000 - 0xc0390bfc   (3475 kB)
[    0.000000]       .data : 0xc0392000 - 0xc03c9f20   ( 224 kB)
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/kernel/hw_breakpoint.c:142 get_debug_arch+0x3c/0x68()
[    0.000000] CPUID feature registers not supported. Assuming v6 debug is present.
[    0.000000] Modules linked in:
[    0.000000] [<c003cbd8>] (unwind_backtrace+0x0/0xec) from [<c005bce4>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c005bce4>] (warn_slowpath_common+0x4c/0x64) from [<c005bd7c>] (warn_slowpath_fmt+0x2c/0x3c)
[    0.000000] [<c005bd7c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c003d4c4>] (get_debug_arch+0x3c/0x68)
[    0.000000] [<c003d4c4>] (get_debug_arch+0x3c/0x68) from [<c003d4f8>] (debug_arch_supported+0x8/0x20)
[    0.000000] [<c003d4f8>] (debug_arch_supported+0x8/0x20) from [<c003d5b4>] (hw_breakpoint_slots+0xc/0x50)
[    0.000000] [<c003d5b4>] (hw_breakpoint_slots+0xc/0x50) from [<c0013f50>] (init_hw_breakpoint+0xc/0x98)
[    0.000000] [<c0013f50>] (init_hw_breakpoint+0xc/0x98) from [<c0013ee8>] (perf_event_init+0xa8/0x104)
[    0.000000] [<c0013ee8>] (perf_event_init+0xa8/0x104) from [<c0008ad0>] (start_kernel+0x150/0x2d4)
[    0.000000] [<c0008ad0>] (start_kernel+0x150/0x2d4) from [<80008034>] (0x80008034)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] NR_IRQS:402
[    0.000000] IRQ: Found an INTC at 0xfa0fe000 (revision 2.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32000 Hz
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
[    0.057922] Calibrating delay loop... 319.32 BogoMIPS (lpj=1249280)
[    0.246368] pid_max: default: 32768 minimum: 301
[    0.252197] Security Framework initialized
[    0.257080] Mount-cache hash table entries: 512
[    0.269104] CPU: Testing write buffer coherency: ok
[    0.276367] hw perfevents: enabled with v6 PMU driver, 3 counters available
[    0.302276] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l3_main
[    0.309844] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_core
[    0.317352] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_wkup
[    0.326904] omap_voltage_early_init: voltage driver support not added
[    0.345275] print_constraints: dummy: 
[    0.362274] omap_device: omap_gpio.0: new worst case activate latency 0: 274658
[    0.371246] OMAP GPIO hardware version 1.8
[    0.376678] OMAP GPIO hardware version 1.8
[    0.381958] OMAP GPIO hardware version 1.8
[    0.387115] OMAP GPIO hardware version 1.8
[    0.415069] omap_mux_init: Add partition: #1: core, flags: 3
[    0.430908] omap_device: omap_uart.0: new worst case activate latency 0: 30517
[    0.431518] omap_device: omap_uart.0: new worst case deactivate latency 0: 30517
[    0.456970] hw-breakpoint: found 6 breakpoint and 1 watchpoint registers.
[    0.464233] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.487426] pm_dbg_init: only OMAP3 supported
[    0.495056] OMAP DMA hardware revision 2.0
[    0.588745] bio: create slab <bio-0> at 0
[    0.610168] SCSI subsystem initialized
[    0.615234] omap_device: omap2_mcspi.1: new worst case activate latency 0: 30517
[    0.626403] omap_device: omap2_mcspi.1: new worst case deactivate latency 0: 30517
[    0.644897] usbcore: registered new interface driver usbfs
[    0.653442] usbcore: registered new interface driver hub
[    0.661193] usbcore: registered new device driver usb
[    0.670562] omap_device: omap_i2c.1: new worst case activate latency 0: 30517
[    0.678344] omap_i2c omap_i2c.1: bus 1 rev3.4 at 400 kHz
[    0.690063] omap_device: omap_i2c.1: new worst case deactivate latency 0: 30517
[    0.698272] omap_i2c omap_i2c.2: bus 2 rev3.4 at 400 kHz
[    0.714233] Switching to clocksource 32k_counter
[    0.724639] Switched to NOHz mode on CPU #0
[    0.873931] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.886077] PMU: registered new PMU device of type 0
[    0.910186] VFS: Disk quotas dquot_6.5.2
[    0.914581] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.924377] JFFS2 version 2.2. (NAND) (SUMMARY)
[    0.933959] msgmni has been set to 235
[    0.946075] io scheduler noop registered
[    0.950256] io scheduler deadline registered
[    0.955078] io scheduler cfq registered (default)
[    0.970458] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.992492] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
[    1.003753] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
[    1.014373] omap_uart.2: ttyO2 at MMIO 0x4806e000 (irq = 74) is a OMAP UART2
[    1.022521] console [ttyO2] enabled, bootconsole disabled
[    1.022521] console [ttyO2] enabled, bootconsole disabled
[    1.043029] omap_rng omap_rng: OMAP Random Number Generator ver. 40
[    1.126007] brd: module loaded
[    1.167938] loop: module loaded
[    1.174621] Menelaus rev 2.2
[    1.178771] omap_device: omap_i2c.1: new worst case activate latency 0: 152587
[    1.210601] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.218261] omap2-nand driver initializing
[    1.224273] OneNAND driver initializing
[    1.230163] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base c8880000
[    1.240386] OneNAND Manufacturer: Samsung (0xec)
[    1.245330] Muxed OneNAND(DDP) 256MB 1.8V 16-bit (0x48)
[    1.250885] OneNAND version = 0x0011
[    1.254638] Chip support all block unlock
[    1.259124] onenand_wait: controller error! state 15 ctrl 0x0440 intr 0x8000
[    1.268249] Scanning device for bad blocks
[    1.489715] Creating 5 MTD partitions on "omap2-onenand":
[    1.495574] 0x000000000000-0x000000020000 : "bootloader"
[    1.516876] 0x000000020000-0x000000080000 : "config"
[    1.532928] 0x000000080000-0x000000280000 : "kernel"
[    1.549377] 0x000000280000-0x000000680000 : "initfs"
[    1.565887] 0x000000680000-0x000010000000 : "rootfs"
[    1.614929] usbcore: registered new interface driver cdc_wdm
[    1.621063] Initializing USB Mass Storage driver...
[    1.627868] usbcore: registered new interface driver usb-storage
[    1.634338] USB Mass Storage support registered.
[    1.642150] usbcore: registered new interface driver libusual
[    1.649902] usbcore: registered new interface driver usbtest
[    1.655883] udc: OMAP UDC driver, version: 4 October 2004 (iso) (dma)
[    1.670349] mousedev: PS/2 mouse device common for all mice
[    1.689666] i2c /dev entries driver
[    1.701751] Driver for 1-wire Dallas network protocol.
[    1.711456] omap_device: omap_wdt.-1: new worst case activate latency 0: 30517
[    1.722717] OMAP Watchdog Timer Rev 0x11: initial timeout 60 sec
[    1.729309] omap_device: omap_wdt.-1: new worst case deactivate latency 0: 30517
[    1.836456] usbcore: registered new interface driver usbhid
[    1.842498] usbhid: USB HID core driver
[    1.846618] VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
[    1.870056] omap_voltage_late_init: Voltage driver support not added
[    1.876892] Power Management for OMAP2 initializing
[    1.882019] PRCM revision 1.0
[    1.922149] clock: disabling unused clocks to save power
[    1.930511] mmci-omap mmci-omap.0: command timeout (CMD52)
[    1.937744] mmci-omap mmci-omap.0: command timeout (CMD52)
[    1.951721] mmci-omap mmci-omap.0: command timeout (CMD5)
[    1.958282] mmci-omap mmci-omap.0: command timeout (CMD5)
[    1.964660] mmci-omap mmci-omap.0: command timeout (CMD5)
[    1.970367] mmci-omap mmci-omap.0: command timeout (CMD5)
[    1.976776] mmci-omap mmci-omap.0: command timeout (CMD5)
[    1.983428] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.997192] Waiting for root device /dev/mmcblk0p1...
[    2.112396] mmc0: host does not support reading read-only switch. assuming write-enable.
[    2.121459] mmc0: new SD card at address e624
[    2.131561] mmcblk0: mmc0:e624 SD01G 968 MiB 
[    2.148162]  mmcblk0: p1
[    2.225433] mmci-omap mmci-omap.0: command timeout (CMD52)
[    2.232391] mmci-omap mmci-omap.0: command timeout (CMD52)
[    2.245483] mmci-omap mmci-omap.0: command timeout (CMD8)
[    2.252319] mmci-omap mmci-omap.0: command timeout (CMD5)
[    2.260284] mmci-omap mmci-omap.0: command timeout (CMD5)
[    2.266082] EXT3-fs: barriers not enabled
[    2.270416] mmci-omap mmci-omap.0: command timeout (CMD5)
[    2.277099] mmci-omap mmci-omap.0: command timeout (CMD5)
[    2.285156] mmci-omap mmci-omap.0: command timeout (CMD55)
[    2.293060] mmci-omap mmci-omap.0: command timeout (CMD55)
[    2.304626] mmci-omap mmci-omap.0: command timeout (CMD55)
[    2.312713] mmci-omap mmci-omap.0: command timeout (CMD55)
[    2.320800] mmci-omap mmci-omap.0: command timeout (CMD1)
[    2.415588] mmci-omap mmci-omap.0: command timeout (CMD52)
[    2.422454] mmci-omap mmci-omap.0: command timeout (CMD52)
[    2.433319] mmci-omap mmci-omap.0: command timeout (CMD8)
[    2.440856] mmci-omap mmci-omap.0: command timeout (CMD5)
[    2.447601] mmci-omap mmci-omap.0: command timeout (CMD5)
[    2.455078] mmci-omap mmci-omap.0: command timeout (CMD5)
[    2.461761] mmci-omap mmci-omap.0: command timeout (CMD5)
[    2.468475] mmci-omap mmci-omap.0: command timeout (CMD55)
[    2.476287] mmci-omap mmci-omap.0: command timeout (CMD55)
[    2.483978] mmci-omap mmci-omap.0: command timeout (CMD55)
[    2.489959] kjournald starting.  Commit interval 5 seconds
[    2.496856] mmci-omap mmci-omap.0: command timeout (CMD55)
[    2.504852] mmci-omap mmci-omap.0: command timeout (CMD1)
[    2.511108] EXT3-fs (mmcblk0p1): using internal journal
[    2.516754] EXT3-fs (mmcblk0p1): recovery complete
[    2.540832] EXT3-fs (mmcblk0p1): mounted filesystem with ordered data mode
[    2.549194] VFS: Mounted root (ext3 filesystem) on device 179:1.
[    2.556030] Freeing init memory: 144K
root@(none):/# 
