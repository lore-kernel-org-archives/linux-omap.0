From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 13/14] ARM: OMAP24xx: clock: remove legacy clock data
Date: Tue, 4 Mar 2014 09:32:00 -0800
Message-ID: <20140304173200.GA17470@atomide.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
 <1393924700-6510-14-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15731 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbaCDRcM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Mar 2014 12:32:12 -0500
Content-Disposition: inline
In-Reply-To: <1393924700-6510-14-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, mturquette@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [140304 01:22]:
> This is no longer needed as clock data is provided through DT.

Looks like there's a new error even before applying this patch in
the series as I'm now getting the following oops on n8x0. So cannot
test this patch yet.

Regards,

Tony

[    0.000000] Linux version 3.14.0-rc4-00012-g4c73c72 (tmlind@muffinssi) (gcc version 4.3.5 (Debian 4.3.5-4) ) #393 Tue Mar 4 09:28:18 PST 2014
[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387d
[    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Nokia N800
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c0764e70, node_mem_map c7ef9000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP2420
[    0.000000] 
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: root=/dev/mmcblk0p2 rootwait console=ttyO2,115200 earlyprintk ignore_loglevel
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 116716K/131072K available (5085K kernel code, 354K rwdata, 1828K rodata, 278K init, 5483K bss, 14356K reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06c8a68   (6915 kB)
[    0.000000]       .init : 0xc06c9000 - 0xc070e9ac   ( 279 kB)
[    0.000000]       .data : 0xc0710000 - 0xc0768b50   ( 355 kB)
[    0.000000]        .bss : 0xc0768b50 - 0xc0cc3a10   (5484 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa0fe000 (revision 2.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] ti_dt_clocks_register: failed to lookup clock node usb_l4_ick
[    0.000000] ti_dt_clocks_register: failed to lookup clock node dsp_ick
[    0.000000] Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000061] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65536000000000ns
[    0.008758] OMAP clocksource: 32k_counter at 32768 Hz
[    0.014465] hw-breakpoint: CPUID feature registers not supported. Assuming v6 debug is present.
[    0.026245] Console: colour dummy device 80x30
[    0.030975] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.039184] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.043609] ... MAX_LOCK_DEPTH:          48
[    0.048004] ... MAX_LOCKDEP_KEYS:        8191
[    0.052673] ... CLASSHASH_SIZE:          4096
[    0.057250] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.061981] ... MAX_LOCKDEP_CHAINS:      32768
[    0.066680] ... CHAINHASH_SIZE:          16384
[    0.071411]  memory used by lock dependency info: 3695 kB
[    0.077056]  per task-struct memory footprint: 1152 bytes
[    0.082916] Calibrating delay loop... 324.40 BogoMIPS (lpj=1622016)
[    0.143707] pid_max: default: 32768 minimum: 301
[    0.149230] Security Framework initialized
[    0.153930] Mount-cache hash table entries: 512
[    0.246917] CPU: Testing write buffer coherency: ok
[    0.256347] Setting up static identity map for 0x804d7bf0 - 0x804d7c60
[    0.286285] VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
[    0.313659] omap_hwmod: dsp: cannot clk_get interface_clk dsp_ick
[    0.320068] omap_hwmod: dsp: cannot _init_clocks
[    0.325042] ------------[ cut here ]------------
[    0.329956] WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2543 _init+0xcc/0x18c()
[    0.339019] omap_hwmod: dsp: couldn't init clocks
[    0.344024] Modules linked in:
[    0.347320] CPU: 0 PID: 1 Comm: swapper Not tainted 3.14.0-rc4-00012-g4c73c72 #393
[    0.355346] [<c0013f9c>] (unwind_backtrace) from [<c00123cc>] (show_stack+0x14/0x1c)
[    0.363555] [<c00123cc>] (show_stack) from [<c00369ac>] (warn_slowpath_common+0x64/0x84)
[    0.372100] [<c00369ac>] (warn_slowpath_common) from [<c0036a60>] (warn_slowpath_fmt+0x30/0x40)
[    0.381286] [<c0036a60>] (warn_slowpath_fmt) from [<c06d4c24>] (_init+0xcc/0x18c)
[    0.389129] [<c06d4c24>] (_init) from [<c0023d14>] (omap_hwmod_for_each+0x50/0x64)
[    0.397155] [<c0023d14>] (omap_hwmod_for_each) from [<c06d4e14>] (__omap_hwmod_setup_all+0x34/0x4c)
[    0.406707] [<c06d4e14>] (__omap_hwmod_setup_all) from [<c0008778>] (do_one_initcall+0x2c/0x14c)
[    0.415954] [<c0008778>] (do_one_initcall) from [<c06c9568>] (do_basic_setup+0x94/0xd4)
[    0.424438] [<c06c9568>] (do_basic_setup) from [<c06c9610>] (kernel_init_freeable+0x68/0x108)
[    0.433441] [<c06c9610>] (kernel_init_freeable) from [<c04cc39c>] (kernel_init+0x8/0xf0)
[    0.441986] [<c04cc39c>] (kernel_init) from [<c000e768>] (ret_from_fork+0x14/0x2c)
[    0.450286] ---[ end trace c2c0c340faab4ca1 ]---
[    0.455352] Unable to handle kernel NULL pointer dereference at virtual address 00000040
[    0.463928] pgd = c0004000
[    0.466827] [00000040] *pgd=00000000
[    0.470703] Internal error: Oops: 5 [#1] ARM
[    0.475219] Modules linked in:
[    0.478454] CPU: 0 PID: 1 Comm: swapper Tainted: G        W    3.14.0-rc4-00012-g4c73c72 #393
[    0.487365] task: c78894c0 ti: c788a000 task.ti: c788a000
[    0.493041] PC is at omap_hwmod_read+0x14/0x30
[    0.497741] LR is at dispc_disable_outputs+0x2c/0x1e8
[    0.503051] pc : [<c0023c6c>]    lr : [<c0023438>]    psr: 40000153
[    0.503051] sp : c788be60  ip : c0613034  fp : 00000000
[    0.515075] r10: c06c96b0  r9 : c06d4de0  r8 : c071e931
[    0.520538] r7 : 00000002  r6 : c0726430  r5 : 00000002  r4 : c7810500
[    0.527374] r3 : 00000040  r2 : 0000000a  r1 : 00000040  r0 : c0726430
[    0.534179] Flags: nZcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.541900] Control: 00c5387d  Table: 80004000  DAC: 00000017
[    0.547912] Process swapper (pid: 1, stack limit = 0xc788a240)
[    0.554046] Stack: (0xc788be60 to 0xc788c000)
[    0.558654] be60: 60000153 c7810500 00000002 c0726d54 00000002 c0726398 c06c96b0 c002367c
[    0.567199] be80: 00000000 00000002 c0726398 c0726398 c06d48ac c788a000 c06c96b0 c0025b04
[    0.575744] bea0: c07263e4 00000002 c07263e4 c06d4994 c0613774 c061559c c0726398 c071e848
[    0.584289] bec0: 00000000 c0023d14 c0702ca0 c070e3b8 c0702ca0 00000002 0000009e c06d4e20
[    0.592803] bee0: 00000000 c0008778 c06a1c10 c005388c 60000153 60000153 c7ffc900 00000000
[    0.601348] bf00: c7ffc8fe 00000000 c066ab70 c051399c 00000000 c0053c80 0000009e 00000001
[    0.609893] bf20: 00000001 c06c96b0 00000001 00000001 0000009e c06a1230 60000153 c070e3b8
[    0.618438] bf40: c0702ca0 00000002 0000009e c0768b90 c0702c7c c06c96b0 c0768b80 c06c9568
[    0.626983] bf60: 00000001 00000001 c06c96b0 ffffffff ffffffff c070e398 c070e398 00000000
[    0.635528] bf80: 00000000 00000000 00000000 00000000 00000000 c06c9610 00000000 00000000
[    0.644073] bfa0: c04cc394 c04cc39c 00000000 c000e768 00000000 00000000 00000000 00000000
[    0.652587] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.661132] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[    0.669708] [<c0023c6c>] (omap_hwmod_read) from [<c0023438>] (dispc_disable_outputs+0x2c/0x1e8)
[    0.678802] [<c0023438>] (dispc_disable_outputs) from [<c002367c>] (omap_dss_reset+0x88/0x160)
[    0.687774] [<c002367c>] (omap_dss_reset) from [<c0025b04>] (_reset+0x20/0x120)
[    0.695434] [<c0025b04>] (_reset) from [<c06d4994>] (_setup+0xe8/0x164)
[    0.702362] [<c06d4994>] (_setup) from [<c0023d14>] (omap_hwmod_for_each+0x50/0x64)
[    0.710388] [<c0023d14>] (omap_hwmod_for_each) from [<c06d4e20>] (__omap_hwmod_setup_all+0x40/0x4c)
[    0.719818] [<c06d4e20>] (__omap_hwmod_setup_all) from [<c0008778>] (do_one_initcall+0x2c/0x14c)
[    0.728973] [<c0008778>] (do_one_initcall) from [<c06c9568>] (do_basic_setup+0x94/0xd4)
[    0.737335] [<c06c9568>] (do_basic_setup) from [<c06c9610>] (kernel_init_freeable+0x68/0x108)
[    0.746246] [<c06c9610>] (kernel_init_freeable) from [<c04cc39c>] (kernel_init+0x8/0xf0)
[    0.754730] [<c04cc39c>] (kernel_init) from [<c000e768>] (ret_from_fork+0x14/0x2c)
[    0.762634] Code: e3130c01 1a000003 e590305c e0833001 (e5930000) 
[    0.769104] ---[ end trace c2c0c340faab4ca2 ]---
[    0.774078] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.774078] 

