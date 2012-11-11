From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Sun, 11 Nov 2012 13:25:08 +0200
Message-ID: <509F8B14.8000703@compulab.co.il>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il> <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il> <509BDAF5.1010703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:59469 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab2KKLZR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Nov 2012 06:25:17 -0500
In-Reply-To: <509BDAF5.1010703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On 11/08/12 18:16, Jon Hunter wrote:
> 
> On 11/08/2012 01:59 AM, Igor Grinberg wrote:
>> On 11/07/12 23:36, Jon Hunter wrote:
>>> Hi Igor,
>>>
>>> On 11/07/2012 08:42 AM, Igor Grinberg wrote:
>>>> CONFIG_OMAP_32K_TIMER is kind of standing on the single zImage way.
>>>> Make OMAP2+ timer code independant from the CONFIG_OMAP_32K_TIMER
>>>> setting.
>>>> To remove the dependancy, several conversions/additions had to be done:
>>>> 1) Timer structures and initialization functions are named by the platform
>>>>    name and the clock source in use. The decision which timer is
>>>>    used is done statically from the machine_desc structure. In the
>>>>    future it should come from DT.
>>>> 2) Settings under the CONFIG_OMAP_32K_TIMER option are expanded into
>>>>    separate timer structures along with the timer init functions.
>>>>    This removes the CONFIG_OMAP_32K_TIMER on OMAP2+ timer code.
>>>> 3) Since we have all the timers defined inside machine_desc structure
>>>>    and we no longer need the fallback to gp_timer clock source in case
>>>>    32k_timer clock source is unavailable (namely on AM33xx), we no
>>>>    longer need the #ifdef around __omap2_sync32k_clocksource_init()
>>>>    function. Remove the #ifdef CONFIG_OMAP_32K_TIMER around the
>>>>    __omap2_sync32k_clocksource_init() function.
>>>>
>>>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>>>> Cc: Jon Hunter <jon-hunter@ti.com>
>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
>>>
>>> [snip]
>>>
>>>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>>>> index 684d2fc..a4ad7a0 100644
>>>> --- a/arch/arm/mach-omap2/timer.c
>>>> +++ b/arch/arm/mach-omap2/timer.c
>>>> @@ -63,20 +63,8 @@
>>>>  #define OMAP2_32K_SOURCE	"func_32k_ck"
>>>>  #define OMAP3_32K_SOURCE	"omap_32k_fck"
>>>>  #define OMAP4_32K_SOURCE	"sys_32k_ck"
>>>> -
>>>> -#ifdef CONFIG_OMAP_32K_TIMER
>>>> -#define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
>>>> -#define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
>>>> -#define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
>>>> -#define OMAP3_SECURE_TIMER	12
>>>>  #define TIMER_PROP_SECURE	"ti,timer-secure"
>>>> -#else
>>>> -#define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
>>>> -#define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
>>>> -#define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
>>>> -#define OMAP3_SECURE_TIMER	1
>>>> -#define TIMER_PROP_SECURE	"ti,timer-alwon"
>>>> -#endif
>>>> +#define TIMER_PROP_ALWON	"ti,timer-alwon"
>>>
>>> Nit-pick, can we drop the TIMER_PROP_SECURE/ALWON and use the
>>> "ti,timer-secure" and "ti,timer-alwon" directly?
>>>
>>> Initially, I also defined TIMER_PROP_ALWON and Rob Herring's feedback
>>> was to drop this and use the property string directly to remove any
>>> abstraction.
>>
>> Well, I don't understand what do you mean by "any abstraction".
>> The purpose of defining those two was to eliminate multiple occurrences
>> of the string in the code, so for example if someone decides to change the
>> property string for some currently unknown reason - it will be easy and small.
>> Defines are a common practice for that, no?
>> If you still think it should be inlined, I will do.
> 
> I understand your point, but right now I don't anticipate that we will
> have many options here and so I think that we should drop these.
> 
>>>>  #define REALTIME_COUNTER_BASE				0x48243200
>>>>  #define INCREMENTER_NUMERATOR_OFFSET			0x10
>>>> @@ -216,7 +204,7 @@ void __init omap_dmtimer_init(void)
>>>>  
>>>>  	/* If we are a secure device, remove any secure timer nodes */
>>>>  	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)) {
>>>> -		np = omap_get_timer_dt(omap_timer_match, "ti,timer-secure");
>>>> +		np = omap_get_timer_dt(omap_timer_match, TIMER_PROP_SECURE);
>>>>  		if (np)
>>>>  			of_node_put(np);
>>>>  	}
>>>> @@ -378,9 +366,8 @@ static u32 notrace dmtimer_read_sched_clock(void)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -#ifdef CONFIG_OMAP_32K_TIMER
>>>>  /* Setup free-running counter for clocksource */
>>>> -static int __init omap2_sync32k_clocksource_init(void)
>>>> +static int __init __omap2_sync32k_clocksource_init(void)
>>>
>>> Not sure I follow why you renamed this function here ...
>>
>> I didn't want to add unused arguments to this function, so I've made a
>> wrapper below to have both the sync32k and the gp functions have the same
>> signature (argument list) and be called from a single macro.
>> Anyway, see below.
> 
> Ok.
> 
>>>
>>>>  {
>>>>  	int ret;
>>>>  	struct device_node *np = NULL;
>>>> @@ -439,15 +426,9 @@ static int __init omap2_sync32k_clocksource_init(void)
>>>>  
>>>>  	return ret;
>>>>  }
>>>> -#else
>>>> -static inline int omap2_sync32k_clocksource_init(void)
>>>> -{
>>>> -	return -ENODEV;
>>>> -}
>>>> -#endif
>>>>  
>>>> -static void __init omap2_gptimer_clocksource_init(int gptimer_id,
>>>> -						const char *fck_source)
>>>> +static void __init omap2_gp_clocksource_init(int gptimer_id,
>>>> +					     const char *fck_source)
>>>
>>> Nit, I personally prefer keeping gptimer, because gp just means
>>> "general-purpose" and does not imply a timer per-se.
>>
>> I've made this change, so we will not get something like:
>> omapx_gptimer_timer_init(), but this really does not meter to me,
>> so no problem will do for v2.
> 
> Thanks.
> 
>>>
>>>>  {
>>>>  	int res;
>>>>  
>>>> @@ -466,23 +447,10 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
>>>>  			gptimer_id, clksrc.rate);
>>>>  }
>>>>  
>>>> -static void __init omap2_clocksource_init(int gptimer_id,
>>>> -						const char *fck_source)
>>>> +static void __init omap2_sync32k_clocksource_init(int gptimer_id,
>>>> +						  const char *fck_source)
>>>>  {
>>>> -	/*
>>>> -	 * First give preference to kernel parameter configuration
>>>> -	 * by user (clocksource="gp_timer").
>>>> -	 *
>>>> -	 * In case of missing kernel parameter for clocksource,
>>>> -	 * first check for availability for 32k-sync timer, in case
>>>> -	 * of failure in finding 32k_counter module or registering
>>>> -	 * it as clocksource, execution will fallback to gp-timer.
>>>> -	 */
>>>> -	if (use_gptimer_clksrc == true)
>>>> -		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
>>>> -	else if (omap2_sync32k_clocksource_init())
>>>> -		/* Fall back to gp-timer code */
>>>> -		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
>>>> +	__omap2_sync32k_clocksource_init();
>>>>  }
>>>
>>> ... this just appears to be a wrapper function, but I don't see why this
>>> is needed? Do we need this wrapper?
>>
>> no, not really, just consider the explanation above.
>> I will remove the wrapper for v2.
> 
> Ok, thanks.
> 
>>>
>>>>  #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
>>>> @@ -563,52 +531,64 @@ static inline void __init realtime_counter_init(void)
>>>>  {}
>>>>  #endif
>>>>  
>>>> -#define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
>>>> -				clksrc_nr, clksrc_src)			\
>>>> -static void __init omap##name##_timer_init(void)			\
>>>> +#define OMAP_SYS_TIMER_INIT(n, clksrc_name, clkev_nr, clkev_src,	\
>>>> +				clkev_prop, clksrc_nr, clksrc_src)	\
>>>> +static void __init omap##n##_##clksrc_name##_timer_init(void)		\
>>>
>>>
>>>>  {									\
>>>>  	omap_dmtimer_init();						\
>>>>  	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
>>>> -	omap2_clocksource_init((clksrc_nr), clksrc_src);		\
>>>> +									\
>>>> +	if (use_gptimer_clksrc)						\
>>>> +		omap2_gp_clocksource_init((clksrc_nr), clksrc_src);	\
>>>> +	else								\
>>>> +		omap2_##clksrc_name##_clocksource_init((clksrc_nr),	\
>>>> +						       clksrc_src);	\
>>>
>>> Something here seems a little odd. If "clksrc_name" is "gp", then the
>>> if-else parts will call the same function. Or am I missing something here?
>>
>> Yes, you are right - this is odd.
>> What do you think of:
>>
>> if (use_gptimer_clksrc) {
>> 	omap2_gp_clocksource_init((clksrc_nr), clksrc_src);
>> 	return;
>> }
>> omap2_##clksrc_name##_clocksource_init((clksrc_nr), clksrc_src);
> 
> Yes, but it still seems a little odd that we could have ...
> 
>  if (use_gptimer_clksrc) {
>  	omap2_gp_clocksource_init((clksrc_nr), clksrc_src);
>  	return;
>  }
>  omap2_gp_clocksource_init((clksrc_nr), clksrc_src);

Yes, of course I understand your point, but that's how macro expansion work.
The only idea left in my mind is to move the check for use_gptimer_clksrc
to the omap2_sync32k_clocksource_init() function, but I don't like it, as
omap2_sync32k_clocksource_init() function should deal with the sync32k init
and if use_gptimer_clksrc is set, the function should not be called at all.
I really don't think this is a problem.
Do you have another idea how we can reuse the macro and
not have the above oddness?

> 
>>>
>>> I think that I prefer how it works today where we call just
>>> omap2_clocksource_init(), and it determines whether to use the gptimer
>>> or the 32k-sync.
>>
>> There is no reliable way to determine which source should be used in runtime
>> for boards that do not have the 32k oscillator wired.
> 
> Hmmm ... well for OMAP devices the 32kHz clock is mandatory AFAIK. At
> least for OMAP devices and I would need to check on the AM33xx but I
> would imagine they are the same. Which devices are you referring to
> where the 32kHz is optional?

As Paul already mentioned, AM35xx can work without the external 32kHz
oscillator.

> 
>>> For OMAP I think that it is fine to default to the 32k-sync and then if
>>> the gptimer is selected, it uses the higher frequency sys_clk as the
>>> timer source.
>>
>> I agree for the 32k-sync as a default, but gptimer will not be selected
>> on SoC that have 32k while board does not have the 32k wired.
> 
> Ok, again let me know which device(s) this applies too.

So we already have two devices: AM35xx and AM33xx, right?

> 
>>>
>>> For AMxxx, devices, sync-32k does not exist, and so I understand it does
>>> not work the same.
>>>
>>> I am wondering if the use_gptimer_clksrc, should become
>>> use_sysclk_clksrc, and then ...
>>>
>>> For OMAP ...
>>> use_sysclk_clksrc = 0 --> use sync-32k (default)
>>> use_sysclk_clksrc = 1 --> use gptimer with sys_clk
>>>
>>> For AM33xx ...
>>> use_sysclk_clksrc = 0 --> use gptimer with 32khz clock (default)
>>> use_sysclk_clksrc = 1 --> use gptimer with sys_clk
>>
>> Well, this is more or less how it works today, but it does not consider
>> the board wiring information that after all defines which source should
>> be used. (Not all boards out there are clones of beagles and evms...)
>> And the generic code should be flexible enough
>> to enable any legal configuration.
> 
> My whole thought here was that the 32kHz is always present. If that is
> not the case then I would agree this would not work.

We have also, another case where, you don't want to use the 32k as a source
and use sys_clk to have higher precision.

> 
>>>
>>>>  }
>>>>  
>>>> -#define OMAP_SYS_TIMER(name)						\
>>>> -struct sys_timer omap##name##_timer = {					\
>>>> -	.init	= omap##name##_timer_init,				\
>>>> -};
>>>> +#define OMAP_SYS_TIMER(n, clksrc)					\
>>>> +struct sys_timer omap##n##_##clksrc##_timer = {				\
>>>> +	.init	= omap##n##_##clksrc##_timer_init,			\
>>>> +}
>>>>  
>>>>  #ifdef CONFIG_ARCH_OMAP2
>>>> -OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, "ti,timer-alwon",
>>>> -		    2, OMAP2_MPU_SOURCE)
>>>> -OMAP_SYS_TIMER(2)
>>>> +OMAP_SYS_TIMER_INIT(2, sync32k, 1, OMAP2_32K_SOURCE, TIMER_PROP_ALWON,
>>>> +		    2, OMAP2_MPU_SOURCE);
>>>> +OMAP_SYS_TIMER(2, sync32k);
>>>> +OMAP_SYS_TIMER_INIT(2, gp, 1, OMAP2_MPU_SOURCE, TIMER_PROP_ALWON,
>>>> +		    2, OMAP2_MPU_SOURCE);
>>>> +OMAP_SYS_TIMER(2, gp);
>>>
>>> It would be good if we can avoid having two timer_init functions for
>>> each OMAP generation.
>>
>> Yes, but then we will not have the right description of the hardware
>> but IMHO workarounds on workarounds on...
>>
>> There are several clock sources - all can be used,
>> why not have them described and ready for use?
> 
> Well we really want to simplify this code and so I was thinking that if
> a device has a 32k-sync timer AND there is a 32kHz source, then what's
> the point in having an option to use a gptimer with a 32kHz source for
> that device?

Hmmm, that how it is done currently (before my patch),
or do I miss something?

> I guess I don't see the benefit there, at least for OMAP2-5
> devices specifically.

Well, this allows certain hardware variants to work properly.
Isn't this a benefit?


-- 
Regards,
Igor.
