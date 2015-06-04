From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Thu, 4 Jun 2015 15:20:57 -0700
Message-ID: <20150604222057.GA8099@codeaurora.org>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com>
 <55701E93.60303@free.fr>
 <20150604200850.GF5710@saruman.tx.rr.com>
 <20150604201825.GG5710@saruman.tx.rr.com>
 <20150604202943.GH5710@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35164 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbbFDWVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2015 18:21:00 -0400
Content-Disposition: inline
In-Reply-To: <20150604202943.GH5710@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mason <slash.tmp@free.fr>, Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 06/04, Felipe Balbi wrote:
> On Thu, Jun 04, 2015 at 03:18:25PM -0500, Felipe Balbi wrote:
> > On Thu, Jun 04, 2015 at 03:08:50PM -0500, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
> > > > Also, check /proc/timer_list for a "Broadcast device". If you don't
> > > > define one, the TWD timers are set to periodic mode, with hrtimers
> > > > disabled.
> > > 
> > > Did you manage to turn global timer into Broadcast device ?
> > 
> > arm_global_timer is marked PERCPU, so it will never be chosen as
> > broadcast.
> 
> Perhaps this is acceptable ?
> 
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index e6833771a716..8c0170ac367d 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -169,8 +169,9 @@ static int gt_clockevents_init(struct clock_event_device *clk)
>  	int cpu = smp_processor_id();
>  
>  	clk->name = "arm_global_timer";
> -	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
> -		CLOCK_EVT_FEAT_PERCPU;
> +	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> +	if (is_smp() || setup_max_cpus)
> +		clk->features |= CLOCK_EVT_FEAT_PERCPU;
>  	clk->set_mode = gt_clockevent_set_mode;
>  	clk->set_next_event = gt_clockevent_set_next_event;
>  	clk->cpumask = cpumask_of(cpu);
> 

What is this doing? Allowing the global timer to become the
broadcast timer? Can you share all the clockevents that are being
registered in the system and what ratings and features they have?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
