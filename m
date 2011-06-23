From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 05/10] omap2+: Use dmtimer macros for clockevent
Date: Thu, 23 Jun 2011 10:07:10 -0700
Message-ID: <87r56ka341.fsf@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092339.357.10396.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:39825 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932313Ab1FWRHO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 13:07:14 -0400
Received: by mail-pv0-f171.google.com with SMTP id 4so1940655pva.16
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 10:07:13 -0700 (PDT)
In-Reply-To: <20110620092339.357.10396.stgit@kaulin> (Tony Lindgren's message
	of "Mon, 20 Jun 2011 02:23:39 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> This patch makes timer-gp.c to use only a subset of dmtimer
> functions without the need to initialize dmtimer code early.
>
> Also note that now with the inline functions, timer_set_next_event
> becomes more efficient in the lines of assembly code.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

In order for this to work, *all* the dmtimer functions need to be
converted.  Some still call the real driver, which may not yet be
initialized (as pointed out for [7/10]...

[...]

> +static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
> +						int gptimer_id,
> +						const char *fck_source)
>  {
> -	u32 tick_rate;
> -	int src;
> -	char clockevent_hwmod_name[8]; /* 8 = sizeof("timerXX0") */
> +	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
> +	struct omap_hwmod *oh;
> +	size_t size;
> +	int res = 0;
> +
> +	sprintf(name, "timer%d", gptimer_id);
> +	omap_hwmod_setup_one(name);
> +	oh = omap_hwmod_lookup(name);
> +	if (!oh)
> +		return -ENODEV;
> +
> +	timer->irq = oh->mpu_irqs[0].irq;
> +	timer->phys_base = oh->slaves[0]->addr->pa_start;
> +	size = oh->slaves[0]->addr->pa_end - timer->phys_base;
> +
> +	/* Static mapping, never released */
> +	timer->io_base = ioremap(timer->phys_base, size);
> +	if (!timer->io_base)
> +		return -ENXIO;
> +
> +	/* After the dmtimer is using hwmod these clocks won't be needed */
> +	sprintf(name, "gpt%d_fck", gptimer_id);
> +	timer->fclk = clk_get(NULL, name);
> +	if (IS_ERR(timer->fclk))
> +		return -ENODEV;
> +
> +	sprintf(name, "gpt%d_ick", gptimer_id);
> +	timer->iclk = clk_get(NULL, name);
> +	if (IS_ERR(timer->iclk)) {
> +		clk_put(timer->fclk);
> +		return -ENODEV;
> +	}
>  
> -	inited = 1;
> +	omap_hwmod_enable(oh);
> +
> +	if (gptimer_id != 12) {
> +		struct clk *src;
> +
> +		src = clk_get(NULL, fck_source);
> +		if (IS_ERR(src)) {
> +			res = -EINVAL;
> +		} else {
> +			res = __omap_dm_timer_set_source(timer->fclk, src);
> +			if (IS_ERR_VALUE(res))
> +				pr_warning("%s: timer%i cannot set source\n",
> +						__func__, gptimer_id);
> +			clk_put(src);
> +		}
> +	}
> +	__omap_dm_timer_reset(timer->io_base, 1, 1);
> +	timer->posted = 1;
> +
> +	timer->rate = clk_get_rate(timer->fclk);
>  
> -	sprintf(clockevent_hwmod_name, "timer%d", gptimer_id);
> -	omap_hwmod_setup_one(clockevent_hwmod_name);
> +	timer->reserved = 1;
>  
>  	gptimer = omap_dm_timer_request_specific(gptimer_id);

Here remains a call to the real driver, which is not yet initialized
when called from sys_timer.init.

>  	BUG_ON(gptimer == NULL);
>  	gptimer_wakeup = gptimer;
>  
> -#if defined(CONFIG_OMAP_32K_TIMER)
> -	src = OMAP_TIMER_SRC_32_KHZ;
> -#else
> -	src = OMAP_TIMER_SRC_SYS_CLK;
> -	WARN(gptimer_id == 12, "WARNING: GPTIMER12 can only use the "
> -	     "secure 32KiHz clock source\n");
> -#endif
> +	return res;
> +}

Kevin
