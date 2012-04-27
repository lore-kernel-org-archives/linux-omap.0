From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V5 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Fri, 27 Apr 2012 05:51:23 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA0011F@DBDE01.ent.ti.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
	<1335362340-14960-4-git-send-email-hvaibhav@ti.com> <87vckm6sen.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52311 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057Ab2D0Fvh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 01:51:37 -0400
In-Reply-To: <87vckm6sen.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Fri, Apr 27, 2012 at 03:56:56, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > Current OMAP code supports couple of clocksource options based
> > on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> > and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> > So there can be 3 options -
> >
> > 1. 32KHz sync-timer
> > 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> > 3. 32KHz based gptimer.
> >
> > The optional gptimer based clocksource was added so that it can
> > give the high precision than sync-timer, so expected usage was 2
> > and not 3.
> > Unfortunately option 2, clocksource doesn't meet the requirement of
> > free-running clock as per clocksource need. It stops in low power states
> > when sys_clock is cut. That makes gptimer based clocksource option
> > useless for OMAP2/3/4 devices with sys_clock as a clock input.
> > So, in order to use option 2, deeper idle state MUST be disabled.
> >
> > Option 3 will still work but it is no better than 32K sync-timer
> > based clocksource.
> >
> > We must support both sync timer and gptimer based clocksource as
> > some OMAP based derivative SoCs like AM33XX does not have the
> > sync timer.
> >
> > Considering above, make sync-timer and gptimer clocksource runtime
> > selectable so that both OMAP and AMXXXX continue to use the same code.
> >
> > Also, in order to precisely configure/setup sched_clock for given
> > clocksource, decision has to be made early enough in boot sequence.
> >
> > So, the solution is,
> >
> > Use standard kernel parameter ("clocksource=") to override
> > default 32k_sync-timer, in addition to this, we also use hwmod database
> > lookup mechanism, through which at run-time we can identify availability
> > of 32k-sync timer on the device, else fall back to gptimer.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Cc: Ming Lei <tom.leiming@gmail.com>
> > ---
> > NOTE: This patch is same as V3, without any code changes. Only
> >       commit description has been modified.
> 
> I assume you menat v4 here, since you also change the ioremap() range in
> this version compared to v3?
> 

Yes, I meant V4 here.

> Also, I boot tested this on OMAP1 (5912/OSK) and OMAP3530/Overo and with
> the fix for clocksource_mmio_init() below, it worked fine.  I also
> tested the cmdline override on OMAP3.
> 

Great, thanks for testing it on OMAP1.

> That being said, a few minor comments below...
> 
> >  arch/arm/mach-omap1/timer32k.c           |    6 ++-
> >  arch/arm/mach-omap2/timer.c              |   99 +++++++++++++++++++++------
> >  arch/arm/plat-omap/counter_32k.c         |  108 +++++++++++++++---------------
> >  arch/arm/plat-omap/include/plat/common.h |    2 +-
> >  4 files changed, 138 insertions(+), 77 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
> > index 325b9a0..6262e11 100644
> > --- a/arch/arm/mach-omap1/timer32k.c
> > +++ b/arch/arm/mach-omap1/timer32k.c
> > @@ -71,6 +71,7 @@
> >
> >  /* 16xx specific defines */
> >  #define OMAP1_32K_TIMER_BASE		0xfffb9000
> > +#define OMAP1_32KSYNC_TIMER_BASE	0xfffbc400
> >  #define OMAP1_32K_TIMER_CR		0x08
> >  #define OMAP1_32K_TIMER_TVR		0x00
> >  #define OMAP1_32K_TIMER_TCR		0x04
> > @@ -184,7 +185,10 @@ static __init void omap_init_32k_timer(void)
> >   */
> >  bool __init omap_32k_timer_init(void)
> >  {
> > -	omap_init_clocksource_32k();
> > +	u32 pbase;
> > +
> > +	pbase = cpu_is_omap16xx() ? OMAP1_32KSYNC_TIMER_BASE : NULL;
> 
> Compile testing on OMAP1 (using omap1_defconfig) gives a few compiler
> warnings:
> 
> /work/kernel/omap/dev/arch/arm/mach-omap1/timer32k.c: In function 'omap_32k_timer_init':
> /work/kernel/omap/dev/arch/arm/mach-omap1/timer32k.c:190:37: warning: pointer/integer type mismatch in conditional expression [enabled by default]
> /work/kernel/omap/dev/arch/arm/mach-omap1/timer32k.c:190:8: warning: assignment makes integer from pointer without a cast [enabled by default]
> 

Oops. I only tested with omap2plus_defconfig, I should have also checked 
omap1_defconfig. I will fix this in next version.

> > +	omap_init_clocksource_32k(pbase, SZ_1K);
> 
> Should this be called if pbase == NULL?
> 

The first thing in the function we do is to check for pbase != NULL, and
returns error; so I did not put check again here.


> If this clocksource does fail, how does the MPU clocksource get
> registered?

I believe, the original code itself was written with the assumption that,
there will not be any failures from omap_32k_timer_init(), I did not modify
it, since I can not test it here at my end. Don't have omap1 board with me.

If you help me in validating it, I will create a patch for this cleanup.

> 
> Looking a bit closer, it appears the whole MPU vs. 32k init is even more
> messed up on OMAP1 than OMAP2+ and needs some cleanup.  However,
> it's not directly related to this series since it was messed up before
> your series.
> 

Some of the things I know, they need cleanup,

	- omap1:
		- Handle return value check omap_init_clocksource_32k()
		- Return value check for omap_32k_timer_init()
		- Remove usage of OMAP_32K_TIMER in omap_32k_timer_usable()

I volunteer myself for this, but need your help in validating them. Please 
let me know if you have anything else in your mind.


> >  	omap_init_32k_timer();
> >  	return true;
> > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > index ecec873..d720f58 100644
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -243,22 +243,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
> >  }
> >
> >  /* Clocksource code */
> > -
> > -#ifdef CONFIG_OMAP_32K_TIMER
> > -/*
> > - * When 32k-timer is enabled, don't use GPTimer for clocksource
> > - * instead, just leave default clocksource which uses the 32k
> > - * sync counter.  See clocksource setup in plat-omap/counter_32k.c
> > - */
> > -
> > -static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
> > -{
> > -	omap_init_clocksource_32k();
> > -}
> > -
> > -#else
> > -
> >  static struct omap_dm_timer clksrc;
> > +static bool use_gptimer_clksrc;
> >
> >  /*
> >   * clocksource
> > @@ -285,7 +271,33 @@ static u32 notrace dmtimer_read_sched_clock(void)
> >  }
> >
> >  /* Setup free-running counter for clocksource */
> > -static void __init omap2_gp_clocksource_init(int gptimer_id,
> > +static int __init omap2_sync32k_clocksource_init(void)
> > +{
> > +	int ret;
> > +	struct omap_hwmod *oh;
> > +	struct resource res;
> > +	const char *oh_name = "counter_32k";
> > +
> > +	oh = omap_hwmod_lookup(oh_name);
> > +	if (!oh || oh->slaves_cnt == 0)
> > +		return -ENODEV;
> > +
> > +	ret = omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM, NULL, &res);
> > +	if (ret) {
> > +		pr_warn("%s: failed to get counter_32k resource (%d)\n",
> > +							__func__, ret);
> > +		return ret;
> > +	}
> 
> I think Paul mentioned this already, but you should really have an
> omap_hwmod_enable() here.
> 

I have doubt on omap1, will this work on omap1? Do we have these api's 
available on omap1?

> > +	ret = omap_init_clocksource_32k(res.start, resource_size(&res));
> > +	if (ret)
> > +		pr_warn("%s: failed to initialize counter_32k (%d)\n",
> > +							__func__, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static void __init omap2_gptimer_clocksource_init(int gptimer_id,
> >  						const char *fck_source)
> >  {
> >  	int res;
> > @@ -293,9 +305,6 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
> >  	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
> >  	BUG_ON(res);
> >
> > -	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
> > -		gptimer_id, clksrc.rate);
> > -
> >  	__omap_dm_timer_load_start(&clksrc,
> >  			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
> >  	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
> > @@ -303,15 +312,36 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
> >  	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
> >  		pr_err("Could not register clocksource %s\n",
> >  			clocksource_gpt.name);
> > +	else
> > +		pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
> > +			gptimer_id, clksrc.rate);
> > +}
> > +
> > +static void __init omap2_clocksource_init(int gptimer_id,
> > +						const char *fck_source)
> > +{
> > +	/*
> > +	 * First give preference to kernel parameter configuration
> > +	 * by user (clocksource="gp timer").
> > +	 *
> > +	 * In case of missing kernel parameter for clocksource,
> > +	 * first check for availability for 32k-sync timer, in case
> > +	 * of failure in finding 32k_counter module or registering
> > +	 * it as clocksource, execution will fallback to gp-timer.
> > +	 */
> > +	if (use_gptimer_clksrc == true)
> > +		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
> > +	else if (omap2_sync32k_clocksource_init())
> > +		/* Fall back to gp-timer code */
> > +		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
> >  }
> > -#endif
> >
> >  #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
> >  				clksrc_nr, clksrc_src)			\
> >  static void __init omap##name##_timer_init(void)			\
> >  {									\
> >  	omap2_gp_clockevent_init((clkev_nr), clkev_src);		\
> > -	omap2_gp_clocksource_init((clksrc_nr), clksrc_src);		\
> > +	omap2_clocksource_init((clksrc_nr), clksrc_src);		\
> >  }
> >
> >  #define OMAP_SYS_TIMER(name)						\
> > @@ -342,7 +372,7 @@ static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
> >  static void __init omap4_timer_init(void)
> >  {
> >  	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
> > -	omap2_gp_clocksource_init(2, OMAP4_MPU_SOURCE);
> > +	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
> >  #ifdef CONFIG_LOCAL_TIMERS
> >  	/* Local timers are not supprted on OMAP4430 ES1.0 */
> >  	if (omap_rev() != OMAP4430_REV_ES1_0) {
> > @@ -510,3 +540,28 @@ static int __init omap2_dm_timer_init(void)
> >  	return 0;
> >  }
> >  arch_initcall(omap2_dm_timer_init);
> > +
> > +/**
> > + * omap2_override_clocksource - clocksource override with user configuration
> > + *
> > + * Allows user to override default clocksource, using kernel parameter
> > + *   clocksource="gp timer"	(For all OMAP2PLUS architectures)
> 
> Passing command-line arguments with spaces might be a little
> problematic, depending on the bootloader.  e.g. the u-boot on my 3530/Overo
> doesn't seem to pass along the quotes, so this function only gets the
> 'gp' part of the string, so the override never works.
> 
> I suggest changing the name of this timer to gp_timer to simplify kernel
> command-line handling.
> 

Ok, I will change it accordingly in my next version.

> > + * Note that, here we are using same standard kernel parameter "clocksource=",
> > + * and not introducing any OMAP specific interface.
> > + */
> > +static int __init omap2_override_clocksource(char *str)
> > +{
> > +	if (!str)
> > +		return 0;
> > +	/*
> > +	 * For OMAP architecture, we only have two options
> > +	 *    - sync_32k (default)
> > +	 *    - gp timer (sys_clk based)
> > +	 */
> > +	if (!strcmp(str, "gp timer"))
> > +		use_gptimer_clksrc = true;
> > +
> > +	return 0;
> > +}
> > +early_param("clocksource", omap2_override_clocksource);
> > diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> > index 5068fe5..3e3cdab 100644
> > --- a/arch/arm/plat-omap/counter_32k.c
> > +++ b/arch/arm/plat-omap/counter_32k.c
> > @@ -27,19 +27,20 @@
> >
> >  #include <plat/clock.h>
> >
> > +/* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
> > +#define OMAP2_32KSYNCNT_CR_OFF		0x10
> 
> This is valid for OMAP1 also.
> 

Not sure whether it is question or information, Yes, this applies to omap1 
also.

> >  /*
> >   * 32KHz clocksource ... always available, on pretty most chips except
> >   * OMAP 730 and 1510.  Other timers could be used as clocksources, with
> >   * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
> >   * but systems won't necessarily want to spend resources that way.
> >   */
> > -static void __iomem *timer_32k_base;
> > -
> > -#define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
> > +static void __iomem *sync32k_cnt_reg;
> >  static u32 notrace omap_32k_read_sched_clock(void)
> >  {
> > -	return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
> > +	return sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
> >  }
> >
> >  /**
> > @@ -59,7 +60,7 @@ void read_persistent_clock(struct timespec *ts)
> >  	struct timespec *tsp = &persistent_ts;
> >
> >  	last_cycles = cycles;
> > -	cycles = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
> > +	cycles = sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
> >  	delta = cycles - last_cycles;
> >
> >  	nsecs = clocksource_cyc2ns(delta, persistent_mult, persistent_shift);
> > @@ -68,54 +69,55 @@ void read_persistent_clock(struct timespec *ts)
> >  	*ts = *tsp;
> >  }
> >
> > -int __init omap_init_clocksource_32k(void)
> > +/**
> > + * omap_init_clocksource_32k - setup and register counter 32k as a
> > + * kernel clocksource
> > + * @pbase: base addr of counter_32k module
> > + * @size: size of counter_32k to map
> > + *
> > + * Returns 0 upon success or negative error code upon failure.
> > + *
> > + */
> > +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
> >  {
> > -	static char err[] __initdata = KERN_ERR
> > -			"%s: can't register clocksource!\n";
> > -
> > -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> > -		u32 pbase;
> > -		unsigned long size = SZ_4K;
> > -		void __iomem *base;
> > -		struct clk *sync_32k_ick;
> > -
> > -		if (cpu_is_omap16xx()) {
> > -			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
> > -			size = SZ_1K;
> > -		} else if (cpu_is_omap2420())
> > -			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
> > -		else if (cpu_is_omap2430())
> > -			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
> > -		else if (cpu_is_omap34xx())
> > -			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
> > -		else if (cpu_is_omap44xx())
> > -			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
> > -		else
> > -			return -ENODEV;
> > -
> > -		/* For this to work we must have a static mapping in io.c for this area */
> > -		base = ioremap(pbase, size);
> > -		if (!base)
> > -			return -ENODEV;
> > -
> > -		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
> > -		if (!IS_ERR(sync_32k_ick))
> > -			clk_enable(sync_32k_ick);
> > -
> > -		timer_32k_base = base;
> > -
> > -		/*
> > -		 * 120000 rough estimate from the calculations in
> > -		 * __clocksource_updatefreq_scale.
> > -		 */
> > -		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> > -				32768, NSEC_PER_SEC, 120000);
> > -
> > -		if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
> > -					  clocksource_mmio_readl_up))
> > -			printk(err, "32k_counter");
> > -
> > -		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
> > +	int ret;
> > +	void __iomem *base;
> > +	struct clk *sync32k_ick;
> > +
> > +	if (!pbase || !size)
> > +		return -ENODEV;
> > +	/*
> > +	 * For this to work we must have a static mapping in io.c
> > +	 * for this area
> > +	 */
> > +	base = ioremap(pbase, size);
> > +	if (!base) {
> > +		pr_err("32k_counter: failed to map base addr\n");
> > +		return -ENODEV;
> >  	}
> > -	return 0;
> > +
> > +	sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
> > +	if (!IS_ERR(sync32k_ick))
> > +		clk_enable(sync32k_ick);
> > +
> > +	sync32k_cnt_reg = base + OMAP2_32KSYNCNT_CR_OFF;
> > +
> > +	/*
> > +	 * 120000 rough estimate from the calculations in
> > +	 * __clocksource_updatefreq_scale.
> > +	 */
> > +	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> > +			32768, NSEC_PER_SEC, 120000);
> > +
> > +	ret = clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
> > +				clocksource_mmio_readl_up);
> 
> Just to be thorough, even though we already discussed this off-list:
> 
> s/base/sync32k_cnt_reg/
> 

Thanks,
Vaibhav

