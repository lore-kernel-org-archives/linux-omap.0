From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clocksource: Allow toggling between runtime and
 persistent clocksource for idle
Date: Mon, 6 Jul 2015 08:22:02 -0700
Message-ID: <20150706152201.GJ10705@atomide.com>
References: <1436166725-18353-1-git-send-email-tony@atomide.com>
 <alpine.DEB.2.11.1507061558040.3916@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1507061558040.3916@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, John Stultz <john.stultz@linaro.org>, Nishanth Menon <nm@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Thomas Gleixner <tglx@linutronix.de> [150706 07:20]:
> On Mon, 6 Jul 2015, Tony Lindgren wrote:
> 
> > Some persistent clocksources can be on a slow external bus. For shorter
> > latencies for RT use, let's allow toggling the clocksource during idle
> > between a faster non-persistent runtime clocksource and a slower persistent
> > clocksource.
> 
> I really cannot follow that RT argument here. The whole switchover
> causes latencies itself and whats worse is, that this breaks
> timekeeping accuracy because there is no way to switch clocksources
> atomically without loss.

It would be during deeper idle states.. But yeah the RT use would be
better replaced in the description with with "lower runtime timer
latency". 

The timekeeping accuracy issue certainly needs some thinking, and
also the resolution between the clocksources can be different.. In the
test case I have the slow timer is always on and of a lower resolution
than the ARM global timer being used during runtime.

Got some handy timer test in mind you want me to run to provide data
on the accuracy?
 
> > ---
> >  include/linuxt-email-lkml-omap/clocksource.h |  2 ++
> 
> Interesting file name.

Heh that needs to go back to sed land :)
 
> >  extern int timekeeping_notify(struct clocksource *clock);
> > +extern int clocksource_pm_enter(void);
> > +extern void clocksource_pm_exit(void);
> 
> Unfortunately you are not providing the call site, so I cannot see
> from which context this is going to be called.
> 
> I fear its from the guts of the idle code probably with interrupts
> disabled etc ...., right?

Yes from the last cpu active in cpuidle. Here's the related snippet
in my case:

--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -111,6 +111,7 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 				 (cx->mpu_logic_state == PWRDM_POWER_OFF);
 
 	tick_broadcast_enter();
+	clocksource_pm_enter();
 
 	/*
 	 * Call idle CPU PM enter notifier chain so that
@@ -167,6 +168,7 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 	if (dev->cpu == 0 && mpuss_can_lose_context)
 		cpu_cluster_pm_exit();
 
+	clocksource_pm_exit();
 	tick_broadcast_exit();
 
 fail:

   
> > +/**
> > + * clocksource_pm_enter - change to a persistent clocksource before idle
> > + *
> > + * Changes system to use a persistent clocksource for idle. Intended to
> > + * be called from CPUidle from the last active CPU.
> > + */
> > +int clocksource_pm_enter(void)
> > +{
> > +	bool oneshot = tick_oneshot_mode_active();
> > +	struct clocksource *best;
> > +
> > +	if (WARN_ONCE(!mutex_trylock(&clocksource_mutex),
> > +		      "Unable to get clocksource_mutex"))
> > +		return -EINTR;
> 
> This trylock serves which purpose?

Well we don't want to start changing clocksource if something is
running like you pointed out.

> > +	best = clocksource_find_best(oneshot, true, false);
> > +	if (best) {
> > +		if (curr_clocksource != best &&
> > +		    !timekeeping_notify(best)) {
> > +			runtime_clocksource = curr_clocksource;
> > +			curr_clocksource = best;
> > +		}
> > +	}
> > +	mutex_unlock(&clocksource_mutex);
> > +
> > +	return !!best;
> > +}
> > +
> > +/**
> > + * clocksource_pm_exit - change to a runtime clocksrouce after idle
> > + *
> > + * Changes system to use the best clocksource for runtime. Intended to
> > + * be called after waking up from CPUidle on the first active CPU.
> > + */
> > +void clocksource_pm_exit(void)
> > +{
> > +	if (WARN_ONCE(!mutex_trylock(&clocksource_mutex),
> > +		      "Unable to get clocksource_mutex"))
> > +		return;
> > +
> > +	if (runtime_clocksource) {
> > +		if (curr_clocksource != runtime_clocksource &&
> > +		    !timekeeping_notify(runtime_clocksource)) {
> > +			curr_clocksource = runtime_clocksource;
> > +			runtime_clocksource = NULL;
> > +		}
> > +	}
> > +	mutex_unlock(&clocksource_mutex);
> > +}
> 
> I really cannot see how this is proper serialized.

We need to allow this only from the last cpu before hitting idle.
 
> >  #ifdef CONFIG_SYSFS
> >  /**
> >   * sysfs_show_current_clocksources - sysfs interface for current clocksource
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index bca3667..0379260 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -1086,7 +1086,18 @@ int timekeeping_notify(struct clocksource *clock)
> >  
> >  	if (tk->tkr_mono.clock == clock)
> >  		return 0;
> > -	stop_machine(change_clocksource, clock, NULL);
> > +
> > +	/*
> > +	 * We may want to toggle between a fast and a persistent
> > +	 * clocksource from CPUidle on the last active CPU and can't
> > +	 * use stop_machine at that point.
> > +	 */
> > +	if (cpumask_test_cpu(smp_processor_id(), cpu_online_mask) &&
> 
> Can you please explain how this code gets called from an offline cpu?

Last cpu getting idled..
 
> > +	    !rcu_is_watching())
> 
> So pick some random combination of conditions and define that it is
> correct, right? How on earth does !rcu_watching() tell that this is
> the last running cpu.

We have called rcu_idle_enter() from cpuidle_idle_call(). Do you have
some better test in mind when the last cpu is about hit idle?
 
> > +		change_clocksource(clock);
> > +	else
> > +		stop_machine(change_clocksource, clock, NULL);
> 
> This patch definitely earns a place in my ugly code museum under the
> category 'Does not explode in my face, so it must be correct'.

Yeah TSC-like issues revisited on other architectures.. I was
expecting something like that from you on this one :)

Regards,

Tony
