From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 06/10] omap2+: Remove gptimer_wakekup for now
Date: Thu, 31 Mar 2011 15:09:45 -0700
Message-ID: <87zkob6ixi.fsf@ti.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222142.4046.4677.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51451 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759365Ab1CaWJv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 18:09:51 -0400
Received: by iym7 with SMTP id 7so2819271iym.10
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 15:09:48 -0700 (PDT)
In-Reply-To: <20110328222142.4046.4677.stgit@baageli.muru.com> (Tony
	Lindgren's message of "Mon, 28 Mar 2011 15:21:43 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> This removes the support for setting the wake-up timer for debugging.
>
> Later on we can reserve gptimer1 for PM code only and have similar
> functionality.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

While we work on an alternative, rather than completely remove this
functionality, below is a very small patch (replaces $SUBJECT patch)
that will keep the current wakeup-from-suspend timer for PM debug
working.

Note that GPT1 fs not just used for wakeups from suspend.  GPT1 needs to
also be the clockevent (at least during idle) so that next-timer
interrupts during idle are also programmed for GPT1.

Here is what I see as a possible "real" solution.  Let's see if we're on
the same page.

- GPT1 reserved for "special" PM wakeup
- GPT2 used as high-resolution clockevent (using sys_clk, but stops during idle)
- GPT3 (or counter_32k) used as clocksource depending on Kconfig

Whenever we're going idle (or suspend), we have to effectively switch
the clockevent from GPT2 to GPT1.  I assume this is what you have in
mind as well.

We'll need to dig into the clockevent (and tick broadcast) code to get
this to work on UP.  On SMP, the C3STOP flag is used to signify that at
clockevent will stop during specific power states, so an alternate
clockevent is used, but IIUC, this doesn't currently work the same on
UP.  I think Santosh has looked into this more recently than I have.
Santosh, if you have any recent status on this, could you share?  I'll
gladly work on the clockevent layer if necessary for this.

Tony, in the mean time, can you use something like the patch below
instead of $SUBJECT patch?  At least we won't loose functionality while
working on this feature.

Kevin


>From e7affbb60e292b507ee1259b6a47f1e30b7fc071 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Thu, 31 Mar 2011 14:49:27 -0700
Subject: [PATCH] OMAP2+: PM debug: update suspend wakeup timer for DM timer changes

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    4 ++--
 arch/arm/mach-omap2/timer-gp.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index a5a83b3..eccf117 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -171,8 +171,8 @@ void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
 
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
 	cycles = tick_rate * seconds + tick_rate * milliseconds / 1000;
-	omap_dm_timer_stop(gptimer_wakeup);
-	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
+	__omap_dm_timer_load_start(gptimer_wakeup->io_base, OMAP_TIMER_CTRL_ST,
+				   0xffffffff - cycles, 1);
 
 	pr_info("PM: Resume timer in %u.%03u secs"
 		" (%d ticks at %d ticks/sec.)\n",
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index c21e99f..52100b2 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -76,7 +76,7 @@ static struct omap_dm_timer *gptimer;
 static struct clock_event_device clockevent_gpt;
 static u8 __initdata gptimer_id = 1;
 static u8 __initdata inited;
-struct omap_dm_timer *gptimer_wakeup;
+struct omap_dm_timer *gptimer_wakeup = &clkev;
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
-- 
1.7.4

