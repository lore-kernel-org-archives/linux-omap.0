From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
Date: Wed, 24 Sep 2014 12:04:59 +0300
Message-ID: <5422893B.60501@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com> <20140918171650.GK14505@atomide.com> <20140918191615.GN14505@atomide.com> <alpine.DEB.2.02.1409191633180.22526@utopia.booyaka.com> <alpine.DEB.2.02.1409191726050.22526@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34769 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549AbaIXJE0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Sep 2014 05:04:26 -0400
In-Reply-To: <alpine.DEB.2.02.1409191726050.22526@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

On 09/19/2014 08:27 PM, Paul Walmsley wrote:
> On Fri, 19 Sep 2014, Paul Walmsley wrote:
>
>> However, I saw the following crash at boot on 37xxevm during one of
>> the boot test.  Ran thirty more boot tests afterwards on that board
>> and it did not recur.  It seems unlikely that the problem is related
>> to this series, but looks like we may have some intermittent boot
>> failure or race on 37xx :-(
>
> ...
>
>> [    4.892211] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa318034
>> [    4.900299] Internal error: : 1028 [#1] SMP ARM
>> [    4.905090] Modules linked in:
>> [    4.908325] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.17.0-rc5-12866-g0164b2d #1
>> [    4.916320] task: c0835db0 ti: c082a000 task.ti: c082a000
>> [    4.922027] PC is at omap2_gp_timer_set_next_event+0x24/0x78
>> [    4.928009] LR is at clockevents_program_event+0xc0/0x148
>> [    4.933715] pc : [<c002622c>]    lr : [<c00a2800>]    psr: 00000193
>> [    4.933715] sp : c082bed8  ip : 00000000  fp : 00000000
>> [    4.945800] r10: 00000000  r9 : 24101100  r8 : c0839080
>> [    4.951324] r7 : 00000001  r6 : 237bc339  r5 : 0000009f  r4 : 3d9759e7
>> [    4.958190] r3 : fa318034  r2 : c08cb920  r1 : 00000003  r0 : fffffec1
>> [    4.965087] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>> [    4.972900] Control: 10c5387d  Table: 80004019  DAC: 00000015
>> [    4.978942] Process swapper/0 (pid: 0, stack limit = 0xc082a248)
>> [    4.985290] Stack: (0xc082bed8 to 0xc082c000)
>> [    4.989868] bec0:                                                       237bc339 00000001
>> [    4.998504] bee0: 00000001 24101100 00000001 cfc7d6c8 00000001 cfc7da50 cfc7d720 c00a4780
>> [    5.007141] bf00: 00000000 c00962b0 cfc7d720 c0096180 00000001 00000000 00000001 c08256c8
>> [    5.015777] bf20: c082a000 c08256c8 00000000 c00962b0 237b4c04 00000001 00000002 a0000193
>> [    5.024414] bf40: 00989680 00000000 00000000 24101100 00000001 cfc7da50 00000000 c108cc78
>> [    5.033020] bf60: 00000000 c00962b0 00000000 00000002 00000001 00000000 c108cc78 c00a56f0
>> [    5.041656] bf80: 00000000 00000002 237b4c04 00000001 c08c8ce8 c082a000 00000000 c08c8ce8
>> [    5.050292] bfa0: c08329dc c0832978 cfc7f0f8 c0072808 c0559928 c08270f0 c08caf40 c080fdc0
>> [    5.058929] bfc0: 00000000 c07c3b74 ffffffff ffffffff c07c35f0 00000000 00000000 c080fdc0
>> [    5.067535] bfe0: c08cb154 c0832968 c080fdbc c083763c 80004059 80008074 00000000 00000000
>> [    5.076171] [<c002622c>] (omap2_gp_timer_set_next_event) from [<c00a2800>] (clockevents_program_event+0xc0/0x148)
>> [    5.087005] [<c00a2800>] (clockevents_program_event) from [<c00a4780>] (tick_program_event+0x44/0x54)
>> [    5.096771] [<c00a4780>] (tick_program_event) from [<c0096180>] (__hrtimer_start_range_ns+0x3c0/0x4a0)
>> [    5.106597] [<c0096180>] (__hrtimer_start_range_ns) from [<c00962b0>] (hrtimer_start_range_ns+0x24/0x2c)
>> [    5.116577] [<c00962b0>] (hrtimer_start_range_ns) from [<c00a56f0>] (tick_nohz_idle_exit+0x140/0x1ec)
>> [    5.126342] [<c00a56f0>] (tick_nohz_idle_exit) from [<c0072808>] (cpu_startup_entry+0xf4/0x2d0)
>> [    5.135528] [<c0072808>] (cpu_startup_entry) from [<c07c3b74>] (start_kernel+0x340/0x3a8)
>> [    5.144165] [<c07c3b74>] (start_kernel) from [<80008074>] (0x80008074)
>> [    5.151031] Code: 13a0c000 0a000004 ee07cfba e592301c (e5931000)
>> [    5.157470] ---[ end trace f92de024d996d904 ]---
>> [    5.162353] Kernel panic - not syncing: Attempted to kill the idle task!
>> [    5.169433] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
>
> Actually it just occurred to me that if something broke
> *wait_target_ready(), we'd expect to see intermittent failures like this,
> and this series touches *wait_target_ready().  So it might be worth taking
> a look at that with a magnifying glass to make sure that it's working.

I think this is probably something else, and most likely more hideous. 
The clock source timers are only enabled once during a boot, and they 
are never idled after that. This error happens almost 5 seconds after 
the initial module enable...?

-Tero

