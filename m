From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 08/10] omap2+: Use dmtimer macros for clocksource
Date: Thu, 23 Jun 2011 10:10:50 -0700
Message-ID: <87iprwa2xx.fsf@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092345.357.11154.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57226 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759408Ab1FWRKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 13:10:53 -0400
Received: by mail-pw0-f51.google.com with SMTP id 18so1426741pwi.38
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 10:10:53 -0700 (PDT)
In-Reply-To: <20110620092345.357.11154.stgit@kaulin> (Tony Lindgren's message
	of "Mon, 20 Jun 2011 02:23:45 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Use dmtimer macros for clocksource. As with the clockevent,
> this allows us to initialize the rest of dmtimer code later on.
>
> Note that eventually we will be initializing the timesource
> from init_early so sched_clock will work properly for
> CONFIG_PRINTK_TIME.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/timer-gp.c   |   64 +++++++++++++++++++++-----------------
>  arch/arm/plat-omap/counter_32k.c |    2 +
>  2 files changed, 37 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
> index cf2ec85..52e295e 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -262,20 +262,22 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
>   * sync counter.  See clocksource setup in plat-omap/counter_32k.c
>   */
>  
> -static void __init omap2_gp_clocksource_init(void)
> +static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
>  {
>  	omap_init_clocksource_32k();
>  }
>  
>  #else
> +
> +static struct omap_dm_timer clksrc;
> +
>  /*
>   * clocksource
>   */
>  static DEFINE_CLOCK_DATA(cd);
> -static struct omap_dm_timer *gpt_clocksource;
>  static cycle_t clocksource_read_cycles(struct clocksource *cs)
>  {
> -	return (cycle_t)omap_dm_timer_read_counter(gpt_clocksource);
> +	return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1);
>  }
>  
>  static struct clocksource clocksource_gpt = {
> @@ -290,43 +292,48 @@ static void notrace dmtimer_update_sched_clock(void)
>  {
>  	u32 cyc;
>  
> -	cyc = omap_dm_timer_read_counter(gpt_clocksource);
> +	cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
>  
>  	update_sched_clock(&cd, cyc, (u32)~0);
>  }
>  
> -/* Setup free-running counter for clocksource */
> -static void __init omap2_gp_clocksource_init(void)
> +unsigned long long notrace sched_clock(void)
>  {
> -	static struct omap_dm_timer *gpt;
> -	u32 tick_rate;
> -	static char err1[] __initdata = KERN_ERR
> -		"%s: failed to request dm-timer\n";
> -	static char err2[] __initdata = KERN_ERR
> -		"%s: can't register clocksource!\n";
> +	u32 cyc = 0;
>  
> -	gpt = omap_dm_timer_request();
> -	if (!gpt)
> -		printk(err1, clocksource_gpt.name);
> -	gpt_clocksource = gpt;
> +	if (clksrc.reserved)
> +		cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
>  
> -	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
> -	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
> +	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
> +}
> +
> +/* Setup free-running counter for clocksource */
> +static void __init omap2_gp_clocksource_init(int gptimer_id,
> +						const char *fck_source)
> +{
> +	int res;
> +
> +	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);

This function makes calls into "real" driver, but is called from
sys_timer.init so happens before driver is initialized.


> +	BUG_ON(res);
>  
> -	omap_dm_timer_set_load_start(gpt, 1, 0);
> +	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
> +		gptimer_id, clksrc.rate);
>  
> -	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, tick_rate);
> +	omap_dm_timer_set_load_start(&clksrc, 1, 0);

Here's another call into the real driver.  I think you need
__omap_dm_timer_set_load_start() here.

> +	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
>  
> -	if (clocksource_register_hz(&clocksource_gpt, tick_rate))
> -		printk(err2, clocksource_gpt.name);
> +	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
> +		pr_err("Could not register clocksource %s\n",
> +			clocksource_gpt.name);
>  }
>  #endif

Kevin
