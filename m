From: Jon Hunter <jon-hunter@TI.COM>
Subject: Re: [PATCH-V2 3/3] ARM: OMAP: Make OMAP clocksource source selection
 runtime
Date: Mon, 2 Apr 2012 10:31:20 -0500
Message-ID: <4F79C648.5020504@ti.com>
References: <1333115655-28530-1-git-send-email-hvaibhav@ti.com> <1333115655-28530-4-git-send-email-hvaibhav@ti.com> <4F75D290.8090706@ti.com> <79CD15C6BA57404B839C016229A409A831843008@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43761 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab2DBPb1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Apr 2012 11:31:27 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A831843008@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@TI.COM>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@TI.COM>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@TI.COM>, "tony@atomide.com" <tony@atomide.com>, "tom.leiming@gmail.com" <tom.leiming@gmail.com>, "Nayak, Rajendra" <rnayak@TI.COM>, "Shilimkar, Santosh" <santosh.shilimkar@TI.COM>, "Balbi, Felipe" <balbi@TI.COM>, "DebBarma, Tarun Kanti" <tarun.kanti@TI.COM>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 4/2/2012 1:06, Hiremath, Vaibhav wrote:

>> [...]
>>
>>> @@ -280,13 +265,33 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
>>>  						const char *fck_source)
>>>  {
>>>  	int res;
>>> +	struct omap_hwmod *oh;
>>> +	const char *oh_name = "counter_32k";
>>> +
>>> +	/*
>>> +	 * First check for availability for 32k-sync timer.
>>> +	 *
>>> +	 * In case of failure in finding 32k_counter module or
>>> +	 * registering it as clocksource, execution will fallback to
>>> +	 * gp-timer.
>>> +	 */
>>> +	oh = omap_hwmod_lookup(oh_name);
>>> +	if (oh && oh->slaves_cnt != 0) {
>>> +		u32 pbase;
>>> +		unsigned long size;
>>> +
>>> +		pbase = oh->slaves[0]->addr->pa_start + 0x10;
>>> +		size = oh->slaves[0]->addr->pa_end -
>>> +			oh->slaves[0]->addr->pa_start;
>>> +		res = omap_init_clocksource_32k(pbase, size);
>>> +		if (!res)
>>> +			return;
>>
>>
>> If omap_init_clocksource_32k() fails should we also call BUG_ON here?
>>
> 
> I don't think we should do that, for following reasons,
> 
> 	- There will be platforms without 32k_counter modules, like am33xx.
>         For them, this BUG_ON will miss-leading.
> 	- pr_err is already used to provide failure in this function.
> 	- We have safe fallback option here.


Ok, sorry I mis-read the code. I see the return here is on success and
not failure. So this is fine.

By the way, for an AM33xx device, I assume that the omap_hwmod_lookup
will return NULL because the module does not exist. Therefore, you would
not even enter the if statement and so there should not be any impact.
Which still raises the question, if omap_hwmod_lookup() finds the device
but omap_init_clocksource_32k() fails, should we at least WARN?

The fallback option is only safe for devices that are not using power
management and don't cut the sys-clk.


>>> +	}
>>>
>>> +	/* Fall back to gp-timer code */
>>>  	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
>>>  	BUG_ON(res);
>>>
>>> -	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
>>> -		gptimer_id, clksrc.rate);
>>> -
>>>  	__omap_dm_timer_load_start(&clksrc,
>>>  			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
>>>  	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
>>> @@ -294,8 +299,10 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
>>>  	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
>>>  		pr_err("Could not register clocksource %s\n",
>>>  			clocksource_gpt.name);
>>> +	else
>>> +		pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
>>> +			gptimer_id, clksrc.rate);
>>>  }
>>> -#endif
>>>
>>>  #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
>>>  				clksrc_nr, clksrc_src)			\
>>> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
>>> index 5068fe5..c1af18c 100644
>>> --- a/arch/arm/plat-omap/counter_32k.c
>>> +++ b/arch/arm/plat-omap/counter_32k.c
>>> @@ -35,8 +35,6 @@
>>>   */
>>>  static void __iomem *timer_32k_base;
>>>
>>> -#define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
>>> -
>>>  static u32 notrace omap_32k_read_sched_clock(void)
>>>  {
>>>  	return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
>>> @@ -68,54 +66,42 @@ void read_persistent_clock(struct timespec *ts)
>>>  	*ts = *tsp;
>>>  }
>>>
>>> -int __init omap_init_clocksource_32k(void)
>>> +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
>>>  {
>>> -	static char err[] __initdata = KERN_ERR
>>> -			"%s: can't register clocksource!\n";
>>> -
>>> -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
>>> -		u32 pbase;
>>> -		unsigned long size = SZ_4K;
>>> -		void __iomem *base;
>>> -		struct clk *sync_32k_ick;
>>> -
>>> -		if (cpu_is_omap16xx()) {
>>> -			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
>>> -			size = SZ_1K;
>>> -		} else if (cpu_is_omap2420())
>>> -			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
>>> -		else if (cpu_is_omap2430())
>>> -			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
>>> -		else if (cpu_is_omap34xx())
>>> -			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
>>> -		else if (cpu_is_omap44xx())
>>> -			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
>>> -		else
>>> -			return -ENODEV;
>>> -
>>> -		/* For this to work we must have a static mapping in io.c for this area */
>>> -		base = ioremap(pbase, size);
>>> -		if (!base)
>>> -			return -ENODEV;
>>> -
>>> -		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
>>> -		if (!IS_ERR(sync_32k_ick))
>>> -			clk_enable(sync_32k_ick);
>>
>>> -
>>
>>> -		timer_32k_base = base;
>>> -
>>> -		/*
>>> -		 * 120000 rough estimate from the calculations in
>>> -		 * __clocksource_updatefreq_scale.
>>> -		 */
>>> -		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
>>> -				32768, NSEC_PER_SEC, 120000);
>>> -
>>> -		if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
>>> -					  clocksource_mmio_readl_up))
>>> -			printk(err, "32k_counter");
>>> -
>>> -		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
>>> -	}
>>> +	void __iomem *base;
>>> +	struct clk *sync_32k_ick;
>>> +
>>> +	if (!pbase || !size)
>>> +		return -ENODEV;
>>> +	/*
>>> +	 * For this to work we must have a static mapping in io.c
>>> +	 * for this area
>>> +	 */
>>> +	base = ioremap(pbase, size);
>>> +	if (!base)
>>> +		return -ENODEV;
>>> +
>>> +	sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
>>> +	if (!IS_ERR(sync_32k_ick))
>>> +		clk_enable(sync_32k_ick);
>>
>>
>> I know that this is carry over from the original code, but seems that if
>> clk_get fails we should return an error. So maybe ...
>>
> 
> I thought of this before, but again the next thought came to my mind was, 
> somebody might have done this for some specific reasons, may be OMAP1 
> dependency or something? So I choose it to keep it as is...
> 
> So before doing this, I thing we should conform from the original author
> about this implementation.


Ok, yes good point.

Cheers
Jon
