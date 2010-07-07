From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3]OMAP:GPTIMER:1ms tick generation correction
Date: Wed, 7 Jul 2010 14:59:47 +0300
Message-ID: <20100707115946.GM1920@atomide.com>
References: <1277239078-31386-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59918 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0GGL7v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 07:59:51 -0400
Content-Disposition: inline
In-Reply-To: <1277239078-31386-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [100622 12:35]:
> +/**
> + * omap_dm_timer_ms_correction - hardware correction for millisecond timer
> + * @timer: GPTIMER on which the correction support is to be applied
> + * @load: timer load value, used here to extract the expiry count
> + */
> +static void omap_dm_timer_ms_correction(struct omap_dm_timer *timer, u32 load)
> +{
> +	int pos_increment, neg_increment;
> +	unsigned int count = (0xFFFFFFFF - load) * 1024;
> +
> +	pos_increment = (DIV_ROUND_UP(count, 1000) * 1000000) \
> +			- (count * 1000);
> +	neg_increment = ((DIV_ROUND_UP(count, 1000) - 1) * 1000000) \
> +			- (count * 1000);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_POS_REG, pos_increment);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_NEG_REG, neg_increment);
> +}
>  
>  struct omap_dm_timer *omap_dm_timer_request(void)
>  {
> @@ -612,6 +639,10 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
>  {
>  	u32 l;
>  
> +#ifdef CONFIG_ARCH_OMAP2PLUS
> +	if (timer->ms_correction)
> +		omap_dm_timer_ms_correction(timer, load);
> +#endif
>  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>  	if (autoreload) {
>  		l |= OMAP_TIMER_CTRL_AR;

How do you know that the timer is configured to use the 32KiHZ source?

Also, since omap2_gp_timer_set_next_event calls all the time,
we don't want to do this calculation for every tick.. So we should
make it a separate optional function.

Or can we somehow calculate this drift once during init?

Regards,

Tony
