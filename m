From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V5 3/3] ARM: OMAP: Make OMAP clocksource source selection using kernel param
Date: Thu, 26 Apr 2012 15:26:56 -0700
Message-ID: <87vckm6sen.fsf@ti.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
	<1335362340-14960-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53889 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755321Ab2DZW06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 18:26:58 -0400
Received: by pbcwy12 with SMTP id wy12so207693pbc.10
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 15:26:57 -0700 (PDT)
In-Reply-To: <1335362340-14960-4-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Wed, 25 Apr 2012 19:29:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> So there can be 3 options -
>
> 1. 32KHz sync-timer
> 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> 3. 32KHz based gptimer.
>
> The optional gptimer based clocksource was added so that it can
> give the high precision than sync-timer, so expected usage was 2
> and not 3.
> Unfortunately option 2, clocksource doesn't meet the requirement of
> free-running clock as per clocksource need. It stops in low power states
> when sys_clock is cut. That makes gptimer based clocksource option
> useless for OMAP2/3/4 devices with sys_clock as a clock input.
> So, in order to use option 2, deeper idle state MUST be disabled.
>
> Option 3 will still work but it is no better than 32K sync-timer
> based clocksource.
>
> We must support both sync timer and gptimer based clocksource as
> some OMAP based derivative SoCs like AM33XX does not have the
> sync timer.
>
> Considering above, make sync-timer and gptimer clocksource runtime
> selectable so that both OMAP and AMXXXX continue to use the same code.
>
> Also, in order to precisely configure/setup sched_clock for given
> clocksource, decision has to be made early enough in boot sequence.
>
> So, the solution is,
>
> Use standard kernel parameter ("clocksource=") to override
> default 32k_sync-timer, in addition to this, we also use hwmod database
> lookup mechanism, through which at run-time we can identify availability
> of 32k-sync timer on the device, else fall back to gptimer.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Ming Lei <tom.leiming@gmail.com>
> ---
> NOTE: This patch is same as V3, without any code changes. Only
>       commit description has been modified.

I assume you menat v4 here, since you also change the ioremap() range in
this version compared to v3?

Also, I boot tested this on OMAP1 (5912/OSK) and OMAP3530/Overo and with
the fix for clocksource_mmio_init() below, it worked fine.  I also
tested the cmdline override on OMAP3.

That being said, a few minor comments below...

>  arch/arm/mach-omap1/timer32k.c           |    6 ++-
>  arch/arm/mach-omap2/timer.c              |   99 +++++++++++++++++++++------
>  arch/arm/plat-omap/counter_32k.c         |  108 +++++++++++++++---------------
>  arch/arm/plat-omap/include/plat/common.h |    2 +-
>  4 files changed, 138 insertions(+), 77 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
> index 325b9a0..6262e11 100644
> --- a/arch/arm/mach-omap1/timer32k.c
> +++ b/arch/arm/mach-omap1/timer32k.c
> @@ -71,6 +71,7 @@
>
>  /* 16xx specific defines */
>  #define OMAP1_32K_TIMER_BASE		0xfffb9000
> +#define OMAP1_32KSYNC_TIMER_BASE	0xfffbc400
>  #define OMAP1_32K_TIMER_CR		0x08
>  #define OMAP1_32K_TIMER_TVR		0x00
>  #define OMAP1_32K_TIMER_TCR		0x04
> @@ -184,7 +185,10 @@ static __init void omap_init_32k_timer(void)
>   */
>  bool __init omap_32k_timer_init(void)
>  {
> -	omap_init_clocksource_32k();
> +	u32 pbase;
> +
> +	pbase = cpu_is_omap16xx() ? OMAP1_32KSYNC_TIMER_BASE : NULL;

Compile testing on OMAP1 (using omap1_defconfig) gives a few compiler
warnings:

/work/kernel/omap/dev/arch/arm/mach-omap1/timer32k.c: In function 'omap_32k_timer_init':
/work/kernel/omap/dev/arch/arm/mach-omap1/timer32k.c:190:37: warning: pointer/integer type mismatch in conditional expression [enabled by default]
/work/kernel/omap/dev/arch/arm/mach-omap1/timer32k.c:190:8: warning: assignment makes integer from pointer without a cast [enabled by default]

> +	omap_init_clocksource_32k(pbase, SZ_1K);

Should this be called if pbase == NULL?

If this clocksource does fail, how does the MPU clocksource get
registered?

Looking a bit closer, it appears the whole MPU vs. 32k init is even more
messed up on OMAP1 than OMAP2+ and needs some cleanup.  However,
it's not directly related to this series since it was messed up before
your series.

>  	omap_init_32k_timer();
>  	return true;
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index ecec873..d720f58 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -243,22 +243,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
>  }
>
>  /* Clocksource code */
> -
> -#ifdef CONFIG_OMAP_32K_TIMER
> -/*
> - * When 32k-timer is enabled, don't use GPTimer for clocksource
> - * instead, just leave default clocksource which uses the 32k
> - * sync counter.  See clocksource setup in plat-omap/counter_32k.c
> - */
> -
> -static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
> -{
> -	omap_init_clocksource_32k();
> -}
> -
> -#else
> -
>  static struct omap_dm_timer clksrc;
> +static bool use_gptimer_clksrc;
>
>  /*
>   * clocksource
> @@ -285,7 +271,33 @@ static u32 notrace dmtimer_read_sched_clock(void)
>  }
>
>  /* Setup free-running counter for clocksource */
> -static void __init omap2_gp_clocksource_init(int gptimer_id,
> +static int __init omap2_sync32k_clocksource_init(void)
> +{
> +	int ret;
> +	struct omap_hwmod *oh;
> +	struct resource res;
> +	const char *oh_name = "counter_32k";
> +
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh || oh->slaves_cnt == 0)
> +		return -ENODEV;
> +
> +	ret = omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM, NULL, &res);
> +	if (ret) {
> +		pr_warn("%s: failed to get counter_32k resource (%d)\n",
> +							__func__, ret);
> +		return ret;
> +	}

I think Paul mentioned this already, but you should really have an
omap_hwmod_enable() here.

> +	ret = omap_init_clocksource_32k(res.start, resource_size(&res));
> +	if (ret)
> +		pr_warn("%s: failed to initialize counter_32k (%d)\n",
> +							__func__, ret);
> +
> +	return ret;
> +}
> +
> +static void __init omap2_gptimer_clocksource_init(int gptimer_id,
>  						const char *fck_source)
>  {
>  	int res;
> @@ -293,9 +305,6 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
>  	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
>  	BUG_ON(res);
>
> -	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
> -		gptimer_id, clksrc.rate);
> -
>  	__omap_dm_timer_load_start(&clksrc,
>  			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
>  	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
> @@ -303,15 +312,36 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
>  	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
>  		pr_err("Could not register clocksource %s\n",
>  			clocksource_gpt.name);
> +	else
> +		pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
> +			gptimer_id, clksrc.rate);
> +}
> +
> +static void __init omap2_clocksource_init(int gptimer_id,
> +						const char *fck_source)
> +{
> +	/*
> +	 * First give preference to kernel parameter configuration
> +	 * by user (clocksource="gp timer").
> +	 *
> +	 * In case of missing kernel parameter for clocksource,
> +	 * first check for availability for 32k-sync timer, in case
> +	 * of failure in finding 32k_counter module or registering
> +	 * it as clocksource, execution will fallback to gp-timer.
> +	 */
> +	if (use_gptimer_clksrc == true)
> +		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
> +	else if (omap2_sync32k_clocksource_init())
> +		/* Fall back to gp-timer code */
> +		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
>  }
> -#endif
>
>  #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
>  				clksrc_nr, clksrc_src)			\
>  static void __init omap##name##_timer_init(void)			\
>  {									\
>  	omap2_gp_clockevent_init((clkev_nr), clkev_src);		\
> -	omap2_gp_clocksource_init((clksrc_nr), clksrc_src);		\
> +	omap2_clocksource_init((clksrc_nr), clksrc_src);		\
>  }
>
>  #define OMAP_SYS_TIMER(name)						\
> @@ -342,7 +372,7 @@ static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
>  static void __init omap4_timer_init(void)
>  {
>  	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
> -	omap2_gp_clocksource_init(2, OMAP4_MPU_SOURCE);
> +	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
>  #ifdef CONFIG_LOCAL_TIMERS
>  	/* Local timers are not supprted on OMAP4430 ES1.0 */
>  	if (omap_rev() != OMAP4430_REV_ES1_0) {
> @@ -510,3 +540,28 @@ static int __init omap2_dm_timer_init(void)
>  	return 0;
>  }
>  arch_initcall(omap2_dm_timer_init);
> +
> +/**
> + * omap2_override_clocksource - clocksource override with user configuration
> + *
> + * Allows user to override default clocksource, using kernel parameter
> + *   clocksource="gp timer"	(For all OMAP2PLUS architectures)

Passing command-line arguments with spaces might be a little
problematic, depending on the bootloader.  e.g. the u-boot on my 3530/Overo
doesn't seem to pass along the quotes, so this function only gets the
'gp' part of the string, so the override never works.

I suggest changing the name of this timer to gp_timer to simplify kernel
command-line handling.

> + * Note that, here we are using same standard kernel parameter "clocksource=",
> + * and not introducing any OMAP specific interface.
> + */
> +static int __init omap2_override_clocksource(char *str)
> +{
> +	if (!str)
> +		return 0;
> +	/*
> +	 * For OMAP architecture, we only have two options
> +	 *    - sync_32k (default)
> +	 *    - gp timer (sys_clk based)
> +	 */
> +	if (!strcmp(str, "gp timer"))
> +		use_gptimer_clksrc = true;
> +
> +	return 0;
> +}
> +early_param("clocksource", omap2_override_clocksource);
> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> index 5068fe5..3e3cdab 100644
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@ -27,19 +27,20 @@
>
>  #include <plat/clock.h>
>
> +/* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
> +#define OMAP2_32KSYNCNT_CR_OFF		0x10

This is valid for OMAP1 also.

>  /*
>   * 32KHz clocksource ... always available, on pretty most chips except
>   * OMAP 730 and 1510.  Other timers could be used as clocksources, with
>   * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
>   * but systems won't necessarily want to spend resources that way.
>   */
> -static void __iomem *timer_32k_base;
> -
> -#define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
> +static void __iomem *sync32k_cnt_reg;
>  static u32 notrace omap_32k_read_sched_clock(void)
>  {
> -	return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
> +	return sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
>  }
>
>  /**
> @@ -59,7 +60,7 @@ void read_persistent_clock(struct timespec *ts)
>  	struct timespec *tsp = &persistent_ts;
>
>  	last_cycles = cycles;
> -	cycles = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
> +	cycles = sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
>  	delta = cycles - last_cycles;
>
>  	nsecs = clocksource_cyc2ns(delta, persistent_mult, persistent_shift);
> @@ -68,54 +69,55 @@ void read_persistent_clock(struct timespec *ts)
>  	*ts = *tsp;
>  }
>
> -int __init omap_init_clocksource_32k(void)
> +/**
> + * omap_init_clocksource_32k - setup and register counter 32k as a
> + * kernel clocksource
> + * @pbase: base addr of counter_32k module
> + * @size: size of counter_32k to map
> + *
> + * Returns 0 upon success or negative error code upon failure.
> + *
> + */
> +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
>  {
> -	static char err[] __initdata = KERN_ERR
> -			"%s: can't register clocksource!\n";
> -
> -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> -		u32 pbase;
> -		unsigned long size = SZ_4K;
> -		void __iomem *base;
> -		struct clk *sync_32k_ick;
> -
> -		if (cpu_is_omap16xx()) {
> -			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
> -			size = SZ_1K;
> -		} else if (cpu_is_omap2420())
> -			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
> -		else if (cpu_is_omap2430())
> -			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
> -		else if (cpu_is_omap34xx())
> -			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
> -		else if (cpu_is_omap44xx())
> -			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
> -		else
> -			return -ENODEV;
> -
> -		/* For this to work we must have a static mapping in io.c for this area */
> -		base = ioremap(pbase, size);
> -		if (!base)
> -			return -ENODEV;
> -
> -		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
> -		if (!IS_ERR(sync_32k_ick))
> -			clk_enable(sync_32k_ick);
> -
> -		timer_32k_base = base;
> -
> -		/*
> -		 * 120000 rough estimate from the calculations in
> -		 * __clocksource_updatefreq_scale.
> -		 */
> -		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> -				32768, NSEC_PER_SEC, 120000);
> -
> -		if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
> -					  clocksource_mmio_readl_up))
> -			printk(err, "32k_counter");
> -
> -		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
> +	int ret;
> +	void __iomem *base;
> +	struct clk *sync32k_ick;
> +
> +	if (!pbase || !size)
> +		return -ENODEV;
> +	/*
> +	 * For this to work we must have a static mapping in io.c
> +	 * for this area
> +	 */
> +	base = ioremap(pbase, size);
> +	if (!base) {
> +		pr_err("32k_counter: failed to map base addr\n");
> +		return -ENODEV;
>  	}
> -	return 0;
> +
> +	sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
> +	if (!IS_ERR(sync32k_ick))
> +		clk_enable(sync32k_ick);
> +
> +	sync32k_cnt_reg = base + OMAP2_32KSYNCNT_CR_OFF;
> +
> +	/*
> +	 * 120000 rough estimate from the calculations in
> +	 * __clocksource_updatefreq_scale.
> +	 */
> +	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> +			32768, NSEC_PER_SEC, 120000);
> +
> +	ret = clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
> +				clocksource_mmio_readl_up);

Just to be thorough, even though we already discussed this off-list:

s/base/sync32k_cnt_reg/

Kevin

> +	if (ret) {
> +		pr_err("32k_counter: can't register clocksource\n");
> +		return ret;
> +	}
> +
> +	setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
> +	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
> +
> +	return ret;
>  }
> diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
> index a557b84..eed5335 100644
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -30,7 +30,7 @@
>  #include <plat/i2c.h>
>  #include <plat/omap_hwmod.h>
>
> -extern int __init omap_init_clocksource_32k(void);
> +extern int __init omap_init_clocksource_32k(u32 pbase, unsigned long size);
>
>  extern void __init omap_check_revision(void);
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
