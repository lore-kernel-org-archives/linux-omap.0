From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] CBUS Patches
Date: Tue, 14 Jun 2011 06:44:35 -0700
Message-ID: <20110614134434.GF23145@atomide.com>
References: <1307994058-25486-1-git-send-email-balbi@ti.com>
 <20110614100643.GM3352@atomide.com>
 <20110614131139.GE23145@atomide.com>
 <20110614131415.GM2353@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:46932 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750864Ab1FNNoh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 09:44:37 -0400
Content-Disposition: inline
In-Reply-To: <20110614131415.GM2353@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110614 06:12]:
> On Tue, Jun 14, 2011 at 06:11:39AM -0700, Tony Lindgren wrote:
> > 
> > Hmm the second patch "cbus: pass device as argument" breaks
> > booting on n800. Anyways pushed out already so that will
> > need to be fixed in a separate patch.
> 
> any good dmesg output for me to take a look at ?

Here's the trace with DEBUG_LL + EARLY_PRINTK + earlyprintk in the
added to the CMDLINE in .config.

Regards,

Tony


Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 3.0.0-rc3-11084-g9d85261 (tmlind@kaulin) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #18 SMP Tue Jun 14 06:40:28 PDT 2011
[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387f
[    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
[    0.000000] Machine: Nokia N800
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP2420
[    0.000000] 
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0xa0000
[    0.000000] Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
[    0.000000] PERCPU: Embedded 7 pages/cpu @c0cc4000 s5952 r8192 d14528 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: root=/dev/mmcblk0p2 rootwait console=ttyO2,115200 earlyprintk
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 117868k/117868k available, 13204k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0053000   ( 300 kB)
[    0.000000]       .text : 0xc0053000 - 0xc05e7e90   (5716 kB)
[    0.000000]       .data : 0xc05e8000 - 0xc066a6f0   ( 522 kB)
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/kernel/hw_breakpoint.c:142 get_debug_arch+0x4c/0x68()
[    0.000000] CPUID feature registers not supported. Assuming v6 debug is present.
[    0.000000] Modules linked in:
[    0.000000] [<c0065e14>] (unwind_backtrace+0x0/0xf8) from [<c009a794>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c009a794>] (warn_slowpath_common+0x4c/0x64) from [<c009a840>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c009a840>] (warn_slowpath_fmt+0x30/0x40) from [<c006676c>] (get_debug_arch+0x4c/0x68)
[    0.000000] [<c006676c>] (get_debug_arch+0x4c/0x68) from [<c0066834>] (hw_breakpoint_slots+0xc/0x54)
[    0.000000] [<c0066834>] (hw_breakpoint_slots+0xc/0x54) from [<c001f628>] (init_hw_breakpoint+0x10/0x150)
[    0.000000] [<c001f628>] (init_hw_breakpoint+0x10/0x150) from [<c001f5a8>] (perf_event_init+0x118/0x188)
[    0.000000] [<c001f5a8>] (perf_event_init+0x118/0x188) from [<c0008a44>] (start_kernel+0x164/0x300)
[    0.000000] [<c0008a44>] (start_kernel+0x164/0x300) from [<80008040>] (0x80008040)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:426
[    0.000000] IRQ: Found an INTC at 0xfa0fe000 (revision 2.0) with 96 interrupts
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
[    0.058380] Calibrating delay loop... 325.10 BogoMIPS (lpj=1271808)
[    0.119628] pid_max: default: 32768 minimum: 301
[    0.125976] Security Framework initialized
[    0.131011] Mount-cache hash table entries: 512
[    0.145416] CPU: Testing write buffer coherency: ok
[    0.159057] Brought up 1 CPUs
[    0.162231] SMP: Total of 1 processors activated (325.10 BogoMIPS).
[    0.199188] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l3_main
[    0.206787] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_core
[    0.214324] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_wkup
[    0.238128] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
[    0.259277] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
[    0.277587] print_constraints: dummy: 
[    0.284423] NET: Registered protocol family 16
[    0.289825] GPMC revision 2.0
[    0.308715] omap_device: omap_gpio.0: new worst case activate latency 0: 244140
[    0.322479] OMAP GPIO hardware version 1.8
[    0.330535] OMAP GPIO hardware version 1.8
[    0.338073] OMAP GPIO hardware version 1.8
[    0.345703] OMAP GPIO hardware version 1.8
[    0.371704] omap_mux_init: Add partition: #1: core, flags: 3
[    0.395080] omap_device: omap_uart.0: new worst case activate latency 0: 30517
[    0.407348] omap_device: omap_uart.1: new worst case deactivate latency 0: 30517
[    0.423431] hw-breakpoint: found 6 breakpoint and 1 watchpoint registers.
[    0.430755] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.455413] pm_dbg_init: only OMAP3 supported
[    0.463348] OMAP DMA hardware revision 2.0
[    0.636199] bio: create slab <bio-0> at 0
[    0.662750] SCSI subsystem initialized
[    0.668457] omap_device: omap2_mcspi.1: new worst case activate latency 0: 30517
[    0.680267] omap_device: omap2_mcspi.1: new worst case deactivate latency 0: 30517
[    0.704010] usbcore: registered new interface driver usbfs
[    0.713226] usbcore: registered new interface driver hub
[    0.721343] usbcore: registered new device driver usb
[    0.731781] omap_device: omap_i2c.1: new worst case activate latency 0: 30517
[    0.750518] omap_i2c omap_i2c.1: bus 1 rev3.4 at 400 kHz
[    0.762237] omap_device: omap_i2c.1: new worst case deactivate latency 0: 30517
[    0.781188] omap_i2c omap_i2c.2: bus 2 rev3.4 at 400 kHz
[    0.793243] tahvo tahvo: Betty v2.1 found
[    0.801361] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.809997] pgd = c0004000
[    0.812988] [00000000] *pgd=00000000
[    0.816772] Internal error: Oops: 5 [#1] SMP
[    0.821289] Modules linked in:
[    0.824554] CPU: 0    Tainted: G        W    (3.0.0-rc3-11084-g9d85261 #18)
[    0.831848] PC is at cbus_read_reg+0x10/0x38
[    0.836364] LR is at retu_probe+0xe4/0x2f8
[    0.840698] pc : [<c0368a8c>]    lr : [<c002e124>]    psr: 60000013
[    0.840698] sp : c7825eb0  ip : 00000006  fp : c066a720
[    0.852722] r10: c0660b8c  r9 : c0bb81f0  r8 : c0653cf0
[    0.858215] r7 : c0632ce0  r6 : 000001aa  r5 : 00000000  r4 : 00000001
[    0.865020] r3 : 000095e6  r2 : 00000000  r1 : 00000001  r0 : 00000000
[    0.871856] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.879516] Control: 00c5387f  Table: 80004000  DAC: 00000017
[    0.885528] Process swapper (pid: 1, stack limit = 0xc78242f8)
[    0.891662] Stack: (0xc7825eb0 to 0xc7826000)
[    0.896240] 5ea0:                                     000001a9 60000013 000001aa 000001aa
[    0.904815] 5ec0: c78d5a40 c002e124 c0660b8c c0632ce0 c0632ce0 c0632ce0 c0660b8c c02c9950
[    0.913360] 5ee0: c0653cf0 c0bb6310 c0660b8c c02cabb4 c0632ce0 c02c9824 c0632ce0 c0632d14
[    0.921905] 5f00: c0660b8c c02c9950 c0653cf0 00000000 c78d5ac0 c02c99e4 00000000 c7825f28
[    0.930450] 5f20: c0660b8c c02c9050 c781a658 c7880eb0 00000000 c0553a64 c00371c0 c0660b8c
[    0.939025] 5f40: c0660b8c c02c8960 c0553a64 c026c440 c0660b78 c00371c0 c0660b8c 00000013
[    0.947570] 5f60: c7824000 c002e02c 00000000 c02c9fe4 c0660b78 c00371c0 c0036c94 00000013
[    0.956115] 5f80: c7824000 c02cafc8 c0036e14 c00371c0 c0036c94 c0053520 c05ee880 c00e629c
[    0.964660] 5fa0: 0000005f 00000000 c0036c94 35390013 00000000 00000000 00000000 000001aa
[    0.973236] 5fc0: c06436cc c0036e14 c00371c0 c0036c94 00000013 00000000 00000000 00000000
[    0.981781] 5fe0: 00000000 c000859c 00000000 c00084e8 c005fc54 c005fc54 ffffffff ffffffff
[    0.990356] [<c0368a8c>] (cbus_read_reg+0x10/0x38) from [<c002e124>] (retu_probe+0xe4/0x2f8)
[    0.999206] [<c002e124>] (retu_probe+0xe4/0x2f8) from [<c02cabb4>] (platform_drv_probe+0x18/0x1c)
[    1.008483] [<c02cabb4>] (platform_drv_probe+0x18/0x1c) from [<c02c9824>] (driver_probe_device+0x98/0x1c4)
[    1.018554] [<c02c9824>] (driver_probe_device+0x98/0x1c4) from [<c02c99e4>] (__driver_attach+0x94/0x98)
[    1.028381] [<c02c99e4>] (__driver_attach+0x94/0x98) from [<c02c9050>] (bus_for_each_dev+0x60/0x8c)
[    1.037811] [<c02c9050>] (bus_for_each_dev+0x60/0x8c) from [<c02c8960>] (bus_add_driver+0x198/0x260)
[    1.047363] [<c02c8960>] (bus_add_driver+0x198/0x260) from [<c02c9fe4>] (driver_register+0x6c/0x150)
[    1.056915] [<c02c9fe4>] (driver_register+0x6c/0x150) from [<c02cafc8>] (platform_driver_probe+0x18/0x9c)
[    1.066925] [<c02cafc8>] (platform_driver_probe+0x18/0x9c) from [<c0053520>] (do_one_initcall+0x34/0x180)
[    1.076904] [<c0053520>] (do_one_initcall+0x34/0x180) from [<c000859c>] (kernel_init+0xb4/0x168)
[    1.086120] [<c000859c>] (kernel_init+0xb4/0x168) from [<c005fc54>] (kernel_thread_exit+0x0/0x8)
[    1.095306] Code: e92d4030 e1a04001 e1a05002 e24dd00c (e5900000) 
[    1.101776] ---[ end trace 1b75b31a2719ed1d ]---
[    1.106689] Kernel panic - not syncing: Attempted to kill init!
