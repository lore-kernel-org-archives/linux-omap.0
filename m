From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] clocksource: Allow toggling between runtime and persistent
 clocksource for idle
Date: Mon, 6 Jul 2015 17:46:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507061737280.3916@nanos>
References: <1436166725-18353-1-git-send-email-tony@atomide.com> <alpine.DEB.2.11.1507061558040.3916@nanos> <20150706152201.GJ10705@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150706152201.GJ10705@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, John Stultz <john.stultz@linaro.org>, Nishanth Menon <nm@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 6 Jul 2015, Tony Lindgren wrote:
> * Thomas Gleixner <tglx@linutronix.de> [150706 07:20]:
> > On Mon, 6 Jul 2015, Tony Lindgren wrote:
> The timekeeping accuracy issue certainly needs some thinking, and
> also the resolution between the clocksources can be different.. In the
> test case I have the slow timer is always on and of a lower resolution
> than the ARM global timer being used during runtime.
> 
> Got some handy timer test in mind you want me to run to provide data
> on the accuracy?

John Stultz might have something.
  
> > > +/**
> > > + * clocksource_pm_enter - change to a persistent clocksource before idle
> > > + *
> > > + * Changes system to use a persistent clocksource for idle. Intended to
> > > + * be called from CPUidle from the last active CPU.
> > > + */
> > > +int clocksource_pm_enter(void)
> > > +{
> > > +	bool oneshot = tick_oneshot_mode_active();
> > > +	struct clocksource *best;
> > > +
> > > +	if (WARN_ONCE(!mutex_trylock(&clocksource_mutex),
> > > +		      "Unable to get clocksource_mutex"))
> > > +		return -EINTR;
> > 
> > This trylock serves which purpose?
> 
> Well we don't want to start changing clocksource if something is
> running like you pointed out.

Well yes, but ....
 
> > I really cannot see how this is proper serialized.
> 
> We need to allow this only from the last cpu before hitting idle.

And I cannot see anything which does so.

cpu0  	     	 	  	cpu1
				is_idle	
go_idle()
  clocksource_pm_enter()
    lock(cs_mutex);
				wakeup()
				clocksource_pm_exit()
				  trylock fails ....

    ...  
    unlock(cs_mutex);
  
--> Crap!

> > > @@ -1086,7 +1086,18 @@ int timekeeping_notify(struct clocksource *clock)
> > >  
> > >  	if (tk->tkr_mono.clock == clock)
> > >  		return 0;
> > > -	stop_machine(change_clocksource, clock, NULL);
> > > +
> > > +	/*
> > > +	 * We may want to toggle between a fast and a persistent
> > > +	 * clocksource from CPUidle on the last active CPU and can't
> > > +	 * use stop_machine at that point.
> > > +	 */
> > > +	if (cpumask_test_cpu(smp_processor_id(), cpu_online_mask) &&
> > 
> > Can you please explain how this code gets called from an offline cpu?
> 
> Last cpu getting idled..

That does not make any sense at all. How is idle related to the online
mask? An idle cpu is still online.

> > > +	    !rcu_is_watching())
> > 
> > So pick some random combination of conditions and define that it is
> > correct, right? How on earth does !rcu_watching() tell that this is
> > the last running cpu.
> 
> We have called rcu_idle_enter() from cpuidle_idle_call(). Do you have
> some better test in mind when the last cpu is about hit idle?

The cpuidle code should know that. And if it does not know, it better
should keep track of that information and based on it provide the
proper serialization, so the call into the timekeeping code is not a
subject to guess work and race conditions.

Thanks,

	tglx

  
