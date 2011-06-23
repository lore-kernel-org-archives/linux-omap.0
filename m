From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 07/10] omap2+: Reserve clocksource and timesource and initialize dmtimer later
Date: Thu, 23 Jun 2011 10:01:20 -0700
Message-ID: <87wrgca3dr.fsf@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092343.357.60445.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37843 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932225Ab1FWRBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 13:01:23 -0400
Received: by mail-pv0-f180.google.com with SMTP id 21so1180332pvc.25
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 10:01:23 -0700 (PDT)
In-Reply-To: <20110620092343.357.60445.stgit@kaulin> (Tony Lindgren's message
	of "Mon, 20 Jun 2011 02:23:43 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> There's no need to initialize the dmtimer framework early.

Actually, there is, because it's being used from the early code.

The sys_timer.init functions are called before arch_initcalls, so before
omap_dm_timer_init() is called, you have:

omap3_timer_init()
    omap2_gp_clockevent_init()
        omap_dm_timer_init_one()
           omap_dm_timer_request_specific()
               

Among other things, the spinlock is taken before it has been initialized
in omap_dm_timer_init() (that's how I noticed this problem), but the
rest of the init of course hasn't been done either.

Basically, the problem is that this "early init" code is not only using
the new macros, but it's also using functions from the "real" driver,
which is not yet initialized.

Kevin

> Just mark the clocksource and timesource as reserved, and
> initialize dmtimer with an arch_initcall.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap1/timer32k.c            |    4 ----
>  arch/arm/mach-omap2/timer-gp.c            |    6 ++++--
>  arch/arm/plat-omap/dmtimer.c              |    8 ++++++++
>  arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
>  4 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
> index 13d7b8f..96604a5 100644
> --- a/arch/arm/mach-omap1/timer32k.c
> +++ b/arch/arm/mach-omap1/timer32k.c
> @@ -183,10 +183,6 @@ static __init void omap_init_32k_timer(void)
>  bool __init omap_32k_timer_init(void)
>  {
>  	omap_init_clocksource_32k();
> -
> -#ifdef CONFIG_OMAP_DM_TIMER
> -	omap_dm_timer_init();
> -#endif
>  	omap_init_32k_timer();
>  
>  	return true;
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
> index 578e9df..cf2ec85 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -69,6 +69,8 @@
>  /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
>  #define MAX_GPTIMER_ID		12
>  
> +u32 sys_timer_reserved;
> +
>  /* Clockevent code */
>  
>  static struct omap_dm_timer clkev;
> @@ -195,6 +197,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>  
>  	omap_hwmod_enable(oh);
>  
> +	sys_timer_reserved |= (1 << (gptimer_id - 1));
> +
>  	if (gptimer_id != 12) {
>  		struct clk *src;
>  
> @@ -321,7 +325,6 @@ static void __init omap2_gp_clocksource_init(void)
>  #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src)			\
>  static void __init omap##name##_timer_init(void)			\
>  {									\
> -	omap_dm_timer_init();						\
>  	omap2_gp_clockevent_init((clkev_nr), clkev_src);		\
>  	omap2_gp_clocksource_init();					\
>  }
> @@ -350,7 +353,6 @@ static void __init omap4_timer_init(void)
>  	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
>  	BUG_ON(!twd_base);
>  #endif
> -	omap_dm_timer_init();
>  	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
>  	omap2_gp_clocksource_init();
>  }
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 7c5cb4e..1462784 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -625,8 +625,16 @@ int __init omap_dm_timer_init(void)
>  			sprintf(clk_name, "gpt%d_fck", i + 1);
>  			timer->fclk = clk_get(NULL, clk_name);
>  		}
> +
> +		/* One or two timers may be set up early for sys_timer */
> +		if (sys_timer_reserved & (1  << i)) {
> +			timer->reserved = 1;
> +			timer->posted = 1;
> +		}
>  #endif
>  	}
>  
>  	return 0;
>  }
> +
> +arch_initcall(omap_dm_timer_init);
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index dd8b3ff..f6dc77a 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -222,6 +222,7 @@ struct omap_dm_timer {
>  	unsigned posted:1;
>  };
>  
> +extern u32 sys_timer_reserved;
>  void omap_dm_timer_prepare(struct omap_dm_timer *timer);
>  
>  static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
