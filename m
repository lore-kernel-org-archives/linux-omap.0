From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Wed, 14 May 2014 13:56:49 -0700
Message-ID: <20140514205649.GC27426@atomide.com>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com>
 <5373C78E.7040301@linaro.org>
 <5373C8E8.6040208@ti.com>
 <5373CBB9.40506@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57172 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751175AbaENU44 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 16:56:56 -0400
Content-Disposition: inline
In-Reply-To: <5373CBB9.40506@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

* Daniel Lezcano <daniel.lezcano@linaro.org> [140514 13:02]:
> On 05/14/2014 09:50 PM, Santosh Shilimkar wrote:
> >On Wednesday 14 May 2014 03:44 PM, Daniel Lezcano wrote:
> >>On 05/13/2014 04:39 PM, Santosh Shilimkar wrote:
> >>>On OMAP4 panda board, there have been several bug reports about boot
> >>>hang and lock-ups with CPU_IDLE enabled. The root cause of the issue
> >>>is missing interrupts while in idle state. Commit cb7094e8 {cpuidle / omap4 :
> >>>use CPUIDLE_FLAG_TIMER_STOP flag} moved the broadcast notifiers to common
> >>>code for right reasons but on OMAP4 which suffers from a nasty ROM code
> >>>bug with GIC, commit ff999b8a {ARM: OMAP4460: Workaround for ROM bug ..},
> >>>we loose interrupts which leads to issues like lock-up, hangs etc.
> >>>
> >>>Patch reverts commit cb7094 {cpuidle / omap4 : use CPUIDLE_FLAG_TIMER_STOP
> >>>flag} to avoid the issue. With this change, OMAP4 panda boards, the mentioned
> >>>issues are getting fixed. We no longer loose interrupts which was the cause
> >>>of the regression.
> >>>
> >>>Cc: Roger Quadros <rogerq@ti.com>
> >>>Cc: Kevin Hilman <khilman@linaro.org>
> >>>Cc: Tony Lindgren <tony@atomide.com>
> >>>Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>Reported-tested-by: Roger Quadros <rogerq@ti.com>
> >>>Reported-tested-by: Kevin Hilman <khilman@linaro.org>
> >>>Tested-by: Tony Lindgren <tony@atomide.com>
> >>>Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>>---
> 
> [ ... ]
> 
> >>>
> >>>+    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
> >>>+
> >>>       /*
> >>>        * Call idle CPU PM enter notifier chain so that
> >>>        * VFP and per CPU interrupt context is saved.
> >>>@@ -165,6 +169,8 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
> >>>       if (dev->cpu == 0 && mpuss_can_lose_context)
> >>>           cpu_cluster_pm_exit();
> >>>
> >>>+    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
> 
> [ ... ]
> 
> >>
> >>Shouldn't the broadcast timer to be setup with CLOCK_EVT_NOTIFY_BROADCAST_ON also ?
> >>
> >Which is already taken care by __cpuidle_register_driver(). Note that setup code
> >is still used from generic code...
> 
> Nope, if the flag CPUIDLE_FLAG_TIMER_STOP is not set, the cpuidle framework
> won't setup the timer.
> 
> static void __cpuidle_driver_init(struct cpuidle_driver *drv)
> {
> 
> 	...
> 
> 	for (i = drv->state_count - 1; i >= 0 ; i--) {
> 		if (drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP) {
> 			drv->bctimer = 1;
> 			break;
> 		}
> 	}
> 
> 	...
> 
> }
> 
> static int __cpuidle_register_driver(struct cpuidle_driver *drv)
> {
> 	...
> 
> 	if (drv->bctimer)
> 		on_each_cpu_mask(drv->cpumask,
> 		cpuidle_setup_broadcast_timer,
> 		 (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON, 1);
> 
> 	...
> }
> 
> So the broadcast timer does not operate with this revert. Moreover, I am not
> sure reverting this patch is the right solution.

OK I'll hold on sending anything until there's some conclusion.

Are you able to reproduce the problem with current Linux next?

Regards,

Tony
