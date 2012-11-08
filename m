From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Thu, 8 Nov 2012 17:47:22 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB68654@DBDE01.ent.ti.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il>
 <509BDAF5.1010703@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com>
 <509BEE6D.9000902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53484 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab2KHRrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 12:47:35 -0500
In-Reply-To: <509BEE6D.9000902@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Thu, Nov 08, 2012 at 23:09:57, Hunter, Jon wrote:
> 
> On 11/08/2012 11:08 AM, Hiremath, Vaibhav wrote:
> > On Thu, Nov 08, 2012 at 21:46:53, Hunter, Jon wrote:
> >>
> >> On 11/08/2012 01:59 AM, Igor Grinberg wrote:
> >>> On 11/07/12 23:36, Jon Hunter wrote:
> >>>> Hi Igor,
> >>>>
> >>>> On 11/07/2012 08:42 AM, Igor Grinberg wrote:
> >>>>> CONFIG_OMAP_32K_TIMER is kind of standing on the single zImage way.
> >>>>> Make OMAP2+ timer code independant from the CONFIG_OMAP_32K_TIMER
> >>>>> setting.
> >>>>> To remove the dependancy, several conversions/additions had to be done:
> >>>>> 1) Timer structures and initialization functions are named by the platform
> >>>>>    name and the clock source in use. The decision which timer is
> >>>>>    used is done statically from the machine_desc structure. In the
> >>>>>    future it should come from DT.
> >>>>> 2) Settings under the CONFIG_OMAP_32K_TIMER option are expanded into
> >>>>>    separate timer structures along with the timer init functions.
> >>>>>    This removes the CONFIG_OMAP_32K_TIMER on OMAP2+ timer code.
> >>>>> 3) Since we have all the timers defined inside machine_desc structure
> >>>>>    and we no longer need the fallback to gp_timer clock source in case
> >>>>>    32k_timer clock source is unavailable (namely on AM33xx), we no
> >>>>>    longer need the #ifdef around __omap2_sync32k_clocksource_init()
> >>>>>    function. Remove the #ifdef CONFIG_OMAP_32K_TIMER around the
> >>>>>    __omap2_sync32k_clocksource_init() function.
> >>>>>
> >>>>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> >>>>> Cc: Jon Hunter <jon-hunter@ti.com>
> >>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>>>> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> >>>>
> >>>> [snip]
> >>>>
> >>>>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> >>>>> index 684d2fc..a4ad7a0 100644
> >>>>> --- a/arch/arm/mach-omap2/timer.c
> >>>>> +++ b/arch/arm/mach-omap2/timer.c
> >>>>> @@ -63,20 +63,8 @@
> >>>>>  #define OMAP2_32K_SOURCE	"func_32k_ck"
> >>>>>  #define OMAP3_32K_SOURCE	"omap_32k_fck"
> >>>>>  #define OMAP4_32K_SOURCE	"sys_32k_ck"
> >>>>> -
> >>>>> -#ifdef CONFIG_OMAP_32K_TIMER
> >>>>> -#define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
> >>>>> -#define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
> >>>>> -#define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
> >>>>> -#define OMAP3_SECURE_TIMER	12
> >>>>>  #define TIMER_PROP_SECURE	"ti,timer-secure"
> >>>>> -#else
> >>>>> -#define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
> >>>>> -#define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
> >>>>> -#define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
> >>>>> -#define OMAP3_SECURE_TIMER	1
> >>>>> -#define TIMER_PROP_SECURE	"ti,timer-alwon"
> >>>>> -#endif
> >>>>> +#define TIMER_PROP_ALWON	"ti,timer-alwon"
> >>>>
> >>>> Nit-pick, can we drop the TIMER_PROP_SECURE/ALWON and use the
> >>>> "ti,timer-secure" and "ti,timer-alwon" directly?
> >>>>
> >>>> Initially, I also defined TIMER_PROP_ALWON and Rob Herring's feedback
> >>>> was to drop this and use the property string directly to remove any
> >>>> abstraction.
> >>>
> >>> Well, I don't understand what do you mean by "any abstraction".
> >>> The purpose of defining those two was to eliminate multiple occurrences
> >>> of the string in the code, so for example if someone decides to change the
> >>> property string for some currently unknown reason - it will be easy and small.
> >>> Defines are a common practice for that, no?
> >>> If you still think it should be inlined, I will do.
> >>
> >> I understand your point, but right now I don't anticipate that we will
> >> have many options here and so I think that we should drop these.
> >>
> >>>>>  #define REALTIME_COUNTER_BASE				0x48243200
> >>>>>  #define INCREMENTER_NUMERATOR_OFFSET			0x10
> >>>>> @@ -216,7 +204,7 @@ void __init omap_dmtimer_init(void)
> >>>>>  
> >>>>>  	/* If we are a secure device, remove any secure timer nodes */
> >>>>>  	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)) {
> >>>>> -		np = omap_get_timer_dt(omap_timer_match, "ti,timer-secure");
> >>>>> +		np = omap_get_timer_dt(omap_timer_match, TIMER_PROP_SECURE);
> >>>>>  		if (np)
> >>>>>  			of_node_put(np);
> >>>>>  	}
> >>>>> @@ -378,9 +366,8 @@ static u32 notrace dmtimer_read_sched_clock(void)
> >>>>>  	return 0;
> >>>>>  }
> >>>>>  
> >>>>> -#ifdef CONFIG_OMAP_32K_TIMER
> >>>>>  /* Setup free-running counter for clocksource */
> >>>>> -static int __init omap2_sync32k_clocksource_init(void)
> >>>>> +static int __init __omap2_sync32k_clocksource_init(void)
> >>>>
> >>>> Not sure I follow why you renamed this function here ...
> >>>
> >>> I didn't want to add unused arguments to this function, so I've made a
> >>> wrapper below to have both the sync32k and the gp functions have the same
> >>> signature (argument list) and be called from a single macro.
> >>> Anyway, see below.
> >>
> >> Ok.
> >>
> >>>>
> >>>>>  {
> >>>>>  	int ret;
> >>>>>  	struct device_node *np = NULL;
> >>>>> @@ -439,15 +426,9 @@ static int __init omap2_sync32k_clocksource_init(void)
> >>>>>  
> >>>>>  	return ret;
> >>>>>  }
> >>>>> -#else
> >>>>> -static inline int omap2_sync32k_clocksource_init(void)
> >>>>> -{
> >>>>> -	return -ENODEV;
> >>>>> -}
> >>>>> -#endif
> >>>>>  
> >>>>> -static void __init omap2_gptimer_clocksource_init(int gptimer_id,
> >>>>> -						const char *fck_source)
> >>>>> +static void __init omap2_gp_clocksource_init(int gptimer_id,
> >>>>> +					     const char *fck_source)
> >>>>
> >>>> Nit, I personally prefer keeping gptimer, because gp just means
> >>>> "general-purpose" and does not imply a timer per-se.
> >>>
> >>> I've made this change, so we will not get something like:
> >>> omapx_gptimer_timer_init(), but this really does not meter to me,
> >>> so no problem will do for v2.
> >>
> >> Thanks.
> >>
> >>>>
> >>>>>  {
> >>>>>  	int res;
> >>>>>  
> >>>>> @@ -466,23 +447,10 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
> >>>>>  			gptimer_id, clksrc.rate);
> >>>>>  }
> >>>>>  
> >>>>> -static void __init omap2_clocksource_init(int gptimer_id,
> >>>>> -						const char *fck_source)
> >>>>> +static void __init omap2_sync32k_clocksource_init(int gptimer_id,
> >>>>> +						  const char *fck_source)
> >>>>>  {
> >>>>> -	/*
> >>>>> -	 * First give preference to kernel parameter configuration
> >>>>> -	 * by user (clocksource="gp_timer").
> >>>>> -	 *
> >>>>> -	 * In case of missing kernel parameter for clocksource,
> >>>>> -	 * first check for availability for 32k-sync timer, in case
> >>>>> -	 * of failure in finding 32k_counter module or registering
> >>>>> -	 * it as clocksource, execution will fallback to gp-timer.
> >>>>> -	 */
> >>>>> -	if (use_gptimer_clksrc == true)
> >>>>> -		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
> >>>>> -	else if (omap2_sync32k_clocksource_init())
> >>>>> -		/* Fall back to gp-timer code */
> >>>>> -		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
> >>>>> +	__omap2_sync32k_clocksource_init();
> >>>>>  }
> >>>>
> >>>> ... this just appears to be a wrapper function, but I don't see why this
> >>>> is needed? Do we need this wrapper?
> >>>
> >>> no, not really, just consider the explanation above.
> >>> I will remove the wrapper for v2.
> >>
> >> Ok, thanks.
> >>
> >>>>
> >>>>>  #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
> >>>>> @@ -563,52 +531,64 @@ static inline void __init realtime_counter_init(void)
> >>>>>  {}
> >>>>>  #endif
> >>>>>  
> >>>>> -#define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
> >>>>> -				clksrc_nr, clksrc_src)			\
> >>>>> -static void __init omap##name##_timer_init(void)			\
> >>>>> +#define OMAP_SYS_TIMER_INIT(n, clksrc_name, clkev_nr, clkev_src,	\
> >>>>> +				clkev_prop, clksrc_nr, clksrc_src)	\
> >>>>> +static void __init omap##n##_##clksrc_name##_timer_init(void)		\
> >>>>
> >>>>
> >>>>>  {									\
> >>>>>  	omap_dmtimer_init();						\
> >>>>>  	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
> >>>>> -	omap2_clocksource_init((clksrc_nr), clksrc_src);		\
> >>>>> +									\
> >>>>> +	if (use_gptimer_clksrc)						\
> >>>>> +		omap2_gp_clocksource_init((clksrc_nr), clksrc_src);	\
> >>>>> +	else								\
> >>>>> +		omap2_##clksrc_name##_clocksource_init((clksrc_nr),	\
> >>>>> +						       clksrc_src);	\
> >>>>
> >>>> Something here seems a little odd. If "clksrc_name" is "gp", then the
> >>>> if-else parts will call the same function. Or am I missing something here?
> >>>
> >>> Yes, you are right - this is odd.
> >>> What do you think of:
> >>>
> >>> if (use_gptimer_clksrc) {
> >>> 	omap2_gp_clocksource_init((clksrc_nr), clksrc_src);
> >>> 	return;
> >>> }
> >>> omap2_##clksrc_name##_clocksource_init((clksrc_nr), clksrc_src);
> >>
> >> Yes, but it still seems a little odd that we could have ...
> >>
> >>  if (use_gptimer_clksrc) {
> >>  	omap2_gp_clocksource_init((clksrc_nr), clksrc_src);
> >>  	return;
> >>  }
> >>  omap2_gp_clocksource_init((clksrc_nr), clksrc_src);
> >>
> >>>>
> >>>> I think that I prefer how it works today where we call just
> >>>> omap2_clocksource_init(), and it determines whether to use the gptimer
> >>>> or the 32k-sync.
> >>>
> >>> There is no reliable way to determine which source should be used in runtime
> >>> for boards that do not have the 32k oscillator wired.
> >>
> >> Hmmm ... well for OMAP devices the 32kHz clock is mandatory AFAIK. At
> >> least for OMAP devices and I would need to check on the AM33xx but I
> >> would imagine they are the same. Which devices are you referring to
> >> where the 32kHz is optional?
> >>
> > No we do not have 32k_counter block in AM335x.
> 
> I am painfully aware of that :-)
> 
> > If you are referring to 32Khz clock availability alone, then yes, we need to 
> > get persistent clock and we use RTC 32Khz clock source for it. 
> > But please note that this is not a 32k_counter block which OMAP family of 
> > devices has.
> > 
> > The way AM335x works is, we have timers (0-7), timer0 being secure timer.
> > We use timer1 and timer2 for clockevent and clocksource and they are driven 
> > by 26MHz OSC clock currently. So when you go into Low power state, OSC is turned off and you need persistent clock for time keeping, right?
> > 
> > And only persistent clock available is RTC 32khz crystal clock, being RTC is 
> > in wakeup domain.
> 
> I think you are missing the point here. For OMAP devices we have two
> main external clock sources which are the 32kHz clock and the sys_clk
> (can be a range of frequencies from 12-38.4MHz for OMAP4). The point is
> for OMAP these clock sources are always present and AFAIK there is no
> h/w configuration that allows you not to have the 32kHz clock source.
> PRCM needs it and I think for OMAP1 the reset logic needs it (if memory
> serves).
> 
> Igor was mentioning a h/w scenario where the 32kHz source is not
> present. However, I am not sure which devices support this and is
> applicable too.
> 
> So we are not discussing the 32k-sync-timer here. We are discussing
> whether there are any device configurations where a 32k clock source
> would not be available for the gptimer.
> 

Exactly that is the point I am trying to make here,

In case of AM33xx, it is certainly possible to build the system without 
this 32Khz clock. 

Interesting point here is, this 32KHz clock is external clock coming from 
crystal connected to in-built RTC module.

Thanks,
Vaibhav

