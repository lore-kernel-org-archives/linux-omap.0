From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] omap init_early changes for irq and timer init
Date: Wed, 30 Mar 2011 11:22:12 -0700
Message-ID: <20110330182211.GE18334@atomide.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
 <4D92E21F.6030608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18045 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab1C3SWR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2011 14:22:17 -0400
Content-Disposition: inline
In-Reply-To: <4D92E21F.6030608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110330 00:53]:
> 
> After going through entire series again, it looks very
> good clean-up and right step towards moving rest of
> the timer to drivers/ directory.
> 
> I also realized that the discussion we had before this series was
> because of miss-understating about the 'wakeu_up' timer
> terminology. After this series I see that you were mentioning
> about the pm debug timer where as I was taling about
> clock-event wakeups from CPUidle point of view.

Well this patcheset keeps the current behaviour, except for
the PM debug hack to program gpt1.

What it does not have is the code to dedicate gpt1 for PM
code, which can be done later once all the other dmtimer
changes are done.

So the earlier discussion is still a separate issue from the
PM debug hack removed in this series. I'll post some patches
later on for that.
 
> I still have few concerns about this series.
> 
> 1)We have removed the flexibility if choosing the timer from
>   from board files and hard-coded them in platform timer
>   header.

Well it's not removed, you can still select the timer setup
by setting .timer entry in the board-*.c file.

So for example, we have omap3_timer and omap3_beagle_timer
for the beagle rev a & b based boards.

>  Below board related hard-coding in platform files looks more
>  hacky and the interface done  by Pual still has a merits of
>  its own.
> 
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -34,7 +34,12 @@
>  struct sys_timer;
> 
>  extern void omap_map_common_io(void);
> -extern struct sys_timer omap_timer;
> +extern struct sys_timer omap1_timer;
> +extern struct sys_timer omap242x_timer;
> +extern struct sys_timer omap243x_timer;
> +extern struct sys_timer omap3_timer;
> +extern struct sys_timer omap3_beagle_timer;
> +extern struct sys_timer omap4_timer;
>  extern bool omap_32k_timer_init(void);
>  extern int __init omap_init_clocksource_32k(void);
>  extern unsigned long long notrace omap_32k_sched_clock(void);

Hmm the only reason for omap3_beagle_timer naming is the
hardware bug in rev a & b beagle boards.

> +/*
> + * Beagle based designs typically have an issue with gptimer1. Also note
> + * that GPTIMER12 can only use the secure 32KiHz clock source.
> + */
>  static void __init omap3_beagle_timer_init(void)
>  {
>  	omap_dm_timer_init();
> -	omap2_gp_clockevent_init();
> +	omap2_gp_clockevent_init(OMAP3_BEAGLE_TIMER, OMAP3_CLKEV_SOURCE);
>  	omap2_gp_clocksource_init();
>  }

Got any better name in mind for that timer?

For removing the old interface, I don't see any reason to
select timer combinations on omap3 other than omap3_timer
and omap3_beagle_timer.

If there's need, any new valid sane combinations can be esily
added, although I seriously doubt that we'll need more for
omap3.
 
> 2) In patch [6/10], you have removed wakeup timer debug
> capability with comment "Later on we can reserve gptimer1
> for PM code only and have similar functionality".
> 
> I don't know how this will work on OMAP. GPTIMER1 is the
> only timer which is in always on power domain and wakeup
> OMAP from deeper power states like CORE OSWR, CORE OFF,
> DEVICE OFF.

Right, that's why the PM code should manage it for the wake-up
events. For the clockevent and clocksource we just want to
use something fast for the runtime.

Then when we hit idle, we can just let PM code program gpt1
for the wake-up event.
 
> We do implement these C-state in CPUidle as well and hence
> the clock-event is expected to be of wakeup-capable.
> Hence GPTIMER1 is already reserved for clock-event.

The PM code can easily deal with gpt1 by either calling
next_timer_interrupt, or just by cloning the clockevent
timer value. But again, that's a separate patch series
to come..
 
> The wakeup timer used was only in suspend scenario's
> and that point of time the timer system is already
> suspended. So during that even if TIMER1 is re-used
> for wakeup (which is the case), I don't see any issue.

The reason is that for performance and latency reasons
we want to use localtimers for runtime on omap4+, and
need only gpt1 for PM wake-up.

The gpt1 using 32KiHz source clock is a very slow clock
to reprogram as it's on the external bus.
 
> At least I don't see other solution than using GPT1
> for wakeup.

Right, there's no other way to wake except gpt1 or wake-up
enabled gpio lines. But we don't need to use gpt1 during
runtime at all.

> 3) You have created few functions so that they can
> be used between system timer and dmtimer driver code.
> When we move the dmtimer driver to say some drivers/
> directory. Is it allowed to share such functions from
> device drivers

The only function we for clockevent and clocksource is
the init_one function, which will be implemented in in
arch/arm/mach-omap2/timer.c anyways. The function to
reprogram the timer is an inline function so dmtimer
can then be a loadable driver module :)
 
> Apart from above comments, I really liked this series.
> If you like you can add my,
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks for looking, will add.

Regards,

Tony
