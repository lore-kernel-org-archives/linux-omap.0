From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v12 6/9] dmtimer: switch-over to platform device driver
Date: Thu, 10 Mar 2011 20:57:45 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD852@dbde02.ent.ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-7-git-send-email-tarun.kanti@ti.com>
 <20110309220241.GR26463@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55152 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab1CJP1v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 10:27:51 -0500
In-Reply-To: <20110309220241.GR26463@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, March 10, 2011 3:33 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v12 6/9] dmtimer: switch-over to platform device
> driver
> 
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110308 15:41]:
> > switch-over to platform device driver through following changes:
> > (a) initiate dmtimer early initialization from omap2_gp_timer_init()
> > in timer-gp.c. This is equivalent of timer_init()->timer->init().
> > (b) modify plat-omap/dmtimer routines to use new register map and
> > platform data.
> 
> This patch breaks booting for 2420 and makes boot hang early
> on 2430. Note that to test with omap-for-linus branch you need
> to disable the following in omap2plus_defconfig:
> 
> CONFIG_ARCH_OMAP3
> CONFIG_ARCH_OMAP4
> CONFIG_CPU_32v6K
I disabled above options on omap-for-linus *WITHOUT* my patch series.
I am still seeing crash. Here is the log.
I tried on two different setups. Not sure if I am missing something.

[...]
[    0.000000] WARNING: at arch/arm/kernel/hw_breakpoint.c:142 get_debug_arch+0x3c/0x68()
[    0.000000] CPUID feature registers not supported. Assuming v6 debug is present.
[    0.000000] Modules linked in:
[    0.000000] [<c073f9b0>] (unwind_backtrace+0x0/0xec) from [<c0762348>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c0762348>] (warn_slowpath_common+0x4c/0x64) from [<c07623e0>] (warn_slowpath_fmt+0x2c/0x3c)
[    0.000000] [<c07623e0>] (warn_slowpath_fmt+0x2c/0x3c) from [<c074029c>] (get_debug_arch+0x3c/0x68)
[    0.000000] [<c074029c>] (get_debug_arch+0x3c/0x68) from [<c07402d0>] (debug_arch_supported+0x8/0x20)
[    0.000000] [<c07402d0>] (debug_arch_supported+0x8/0x20) from [<c074038c>] (hw_breakpoint_slots+0xc/0x50)
[    0.000000] [<c074038c>] (hw_breakpoint_slots+0xc/0x50) from [<c0016a54>] (init_hw_breakpoint+0xc/0x98)
[    0.000000] [<c0016a54>] (init_hw_breakpoint+0xc/0x98) from [<c00169e4>] (perf_event_init+0xb8/0x11c)
[    0.000000] [<c00169e4>] (perf_event_init+0xb8/0x11c) from [<c0008ad0>] (start_kernel+0x150/0x2d8)
[    0.000000] [<c0008ad0>] (start_kernel+0x150/0x2d8) from [<80008034>] (0x80008034)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] NR_IRQS:409
[    0.000000] IRQ: Found an INTC at 0xfa0fe000 (revision 2.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000078
[    0.000000] pgd = c0004000
[    0.000000] [00000078] *pgd=00000000
[    0.000000] Internal error: Oops: 5 [#1]
[    0.000000] last sysfs file:
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Tainted: G        W    (2.6.38-rc7-00165-g0dde52a #199)
[    0.000000] PC is at gpmc_cs_read_reg+0x14/0x20
[    0.000000] LR is at gpmc_cs_mem_enabled+0xc/0x14
[    0.000000] pc : [<c07469b0>]    lr : [<c07469c8>]    psr: 600001d3
[    0.000000] sp : c0c2bf80  ip : 00000028  fp : c0c2bfc4
[    0.000000] r10: 00000000  r9 : 4107b362  r8 : 8002b490
[    0.000000] r7 : c0c3087c  r6 : 00000000  r5 : c0c7a700  r4 : 04000000
[    0.000000] r3 : 00000000  r2 : 00000000  r1 : 00000078  r0 : 00000000
[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 00c5387f  Table: 80004000  DAC: 00000017
[    0.000000] Process swapper (pid: 0, stack limit = 0xc0c2a268)
[    0.000000] Stack: (0xc0c2bf80 to 0xc0c2c000)
[    0.000000] bf80: 04000000 c0746f9c c0722578 c0c3087c c0c49868 c0ab3a50 0000005f c072257c
[    0.000000] bfa0: c0c7a700 c0722578 c0c3087c 8002b490 4107b362 8002b3f0 00000000 c00114a8
[    0.000000] bfc0: 00000000 00000001 c0008000 c000b314 c072257c c0008adc c0008744 00000000
[    0.000000] bfe0: 00000000 c072257c 00000000 00c5387d c0c2c080 80008034 00000000 00000000
[    0.000000] [<c07469b0>] (gpmc_cs_read_reg+0x14/0x20) from [<c07469c8>] (gpmc_cs_mem_enabled+0xc/0x14)
[    0.000000] [<c07469c8>] (gpmc_cs_mem_enabled+0xc/0x14) from [<c0746f9c>] (gpmc_cs_request+0x60/0x134)
[    0.000000] [<c0746f9c>] (gpmc_cs_request+0x60/0x134) from [<c00114a8>] (omap_h4_init_irq+0x18/0x48)
[    0.000000] [<c00114a8>] (omap_h4_init_irq+0x18/0x48) from [<c000b314>] (init_IRQ+0x14/0x1c)
[    0.000000] [<c000b314>] (init_IRQ+0x14/0x1c) from [<c0008adc>] (start_kernel+0x15c/0x2d8)
[    0.000000] [<c0008adc>] (start_kernel+0x15c/0x2d8) from [<80008034>] (0x80008034)
[    0.000000] Code: e0211093 e59f300c e2811060 e5933000 (e7930001)
[    0.000000] ---[ end trace 1b75b31a2719ed1d ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

- Tarun

> 
> In general, let's continue with this series after the merge
> window. We must merge intrusive changes like this early around
> -rc2, not late in the merge window.
> 
> Regards,
> 
> Tony
