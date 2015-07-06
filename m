From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] clocksource: Allow toggling between runtime and persistent
 clocksource for idle
Date: Mon, 6 Jul 2015 16:18:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507061558040.3916@nanos>
References: <1436166725-18353-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436166725-18353-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, John Stultz <john.stultz@linaro.org>, Nishanth Menon <nm@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 6 Jul 2015, Tony Lindgren wrote:

> Some persistent clocksources can be on a slow external bus. For shorter
> latencies for RT use, let's allow toggling the clocksource during idle
> between a faster non-persistent runtime clocksource and a slower persistent
> clocksource.

I really cannot follow that RT argument here. The whole switchover
causes latencies itself and whats worse is, that this breaks
timekeeping accuracy because there is no way to switch clocksources
atomically without loss.

> ---
>  include/linuxt-email-lkml-omap/clocksource.h |  2 ++

Interesting file name.

>  extern int timekeeping_notify(struct clocksource *clock);
> +extern int clocksource_pm_enter(void);
> +extern void clocksource_pm_exit(void);

Unfortunately you are not providing the call site, so I cannot see
from which context this is going to be called.

I fear its from the guts of the idle code probably with interrupts
disabled etc ...., right?
  
> +/**
> + * clocksource_pm_enter - change to a persistent clocksource before idle
> + *
> + * Changes system to use a persistent clocksource for idle. Intended to
> + * be called from CPUidle from the last active CPU.
> + */
> +int clocksource_pm_enter(void)
> +{
> +	bool oneshot = tick_oneshot_mode_active();
> +	struct clocksource *best;
> +
> +	if (WARN_ONCE(!mutex_trylock(&clocksource_mutex),
> +		      "Unable to get clocksource_mutex"))
> +		return -EINTR;

This trylock serves which purpose?

> +
> +	best = clocksource_find_best(oneshot, true, false);
> +	if (best) {
> +		if (curr_clocksource != best &&
> +		    !timekeeping_notify(best)) {
> +			runtime_clocksource = curr_clocksource;
> +			curr_clocksource = best;
> +		}
> +	}
> +	mutex_unlock(&clocksource_mutex);
> +
> +	return !!best;
> +}
> +
> +/**
> + * clocksource_pm_exit - change to a runtime clocksrouce after idle
> + *
> + * Changes system to use the best clocksource for runtime. Intended to
> + * be called after waking up from CPUidle on the first active CPU.
> + */
> +void clocksource_pm_exit(void)
> +{
> +	if (WARN_ONCE(!mutex_trylock(&clocksource_mutex),
> +		      "Unable to get clocksource_mutex"))
> +		return;
> +
> +	if (runtime_clocksource) {
> +		if (curr_clocksource != runtime_clocksource &&
> +		    !timekeeping_notify(runtime_clocksource)) {
> +			curr_clocksource = runtime_clocksource;
> +			runtime_clocksource = NULL;
> +		}
> +	}
> +	mutex_unlock(&clocksource_mutex);
> +}

I really cannot see how this is proper serialized.

>  #ifdef CONFIG_SYSFS
>  /**
>   * sysfs_show_current_clocksources - sysfs interface for current clocksource
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index bca3667..0379260 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1086,7 +1086,18 @@ int timekeeping_notify(struct clocksource *clock)
>  
>  	if (tk->tkr_mono.clock == clock)
>  		return 0;
> -	stop_machine(change_clocksource, clock, NULL);
> +
> +	/*
> +	 * We may want to toggle between a fast and a persistent
> +	 * clocksource from CPUidle on the last active CPU and can't
> +	 * use stop_machine at that point.
> +	 */
> +	if (cpumask_test_cpu(smp_processor_id(), cpu_online_mask) &&

Can you please explain how this code gets called from an offline cpu?

> +	    !rcu_is_watching())

So pick some random combination of conditions and define that it is
correct, right? How on earth does !rcu_watching() tell that this is
the last running cpu.

> +		change_clocksource(clock);
> +	else
> +		stop_machine(change_clocksource, clock, NULL);

This patch definitely earns a place in my ugly code museum under the
category 'Does not explode in my face, so it must be correct'.

Thanks,

	tglx
