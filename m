From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v11 6/8] dmtimer: switch-over to platform device driver
Date: Thu, 03 Mar 2011 17:25:38 -0800
Message-ID: <87y64vllrh.fsf@ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:38185 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759050Ab1CDBZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 20:25:57 -0500
Received: by gxk21 with SMTP id 21so649374gxk.36
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 17:25:56 -0800 (PST)
In-Reply-To: <1298546811-27055-7-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 24 Feb 2011 16:56:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> switch-over to platform device driver through following changes:
> (a) initiate dmtimer early initialization from omap2_gp_timer_init()
> in timer-gp.c. This is equivalent of timer_init()->timer->init().
> (b) modify plat-omap/dmtimer routines to use new register map and
> platform data.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>

[...]

> @@ -507,20 +394,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_start);
>  void omap_dm_timer_stop(struct omap_dm_timer *timer)
>  {
>  	u32 l;
> +	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
>  
>  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>  	if (l & OMAP_TIMER_CTRL_ST) {
>  		l &= ~0x1;
>  		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -		/* Readback to make sure write has completed */
> -		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> -		 /*
> -		  * Wait for functional clock period x 3.5 to make sure that
> -		  * timer is stopped
> -		  */
> -		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
> -#endif
> +
> +		if (!pdata->is_omap16xx) {
> +			/* Readback to make sure write has completed */
> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> +			/*
> +			 * Wait for functional clock period x 3.5 to make
> +			 * sure that timer is stopped
> +			 */
> +			udelay(3500000 / clk_get_rate(timer->fclk) + 1);
> +		}

Can't this 'is_omap16xx' check just be using the IP revision?


>  	}

Kevin
