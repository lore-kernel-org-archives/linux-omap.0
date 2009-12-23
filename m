From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization
 delay
Date: Wed, 23 Dec 2009 20:02:13 +0530
Message-ID: <4B3229ED.10005@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E202@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50451 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbZLWOcS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Dec 2009 09:32:18 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBNEWF2V002762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Dec 2009 08:32:17 -0600
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E202@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> +#ifdef CONFIG_ARCH_OMAP3
> +unsigned long (*_omap3_sram_delay)(unsigned long);
> +unsigned int  measure_sram_delay(unsigned int loop)
> +{
> +	static struct omap_dm_timer *gpt;
> +	unsigned long flags, diff = 0, gt_rate, mpurate;
> +	unsigned int delay_sram, error_gain;
> +
> +	omap_dm_timer_init();
> +	gpt = omap_dm_timer_request_specific(10);
> +	if (!gpt)
> +		pr_err("Could not get the gptimer\n");
> +	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
> +
> +	gt_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
> +	omap_dm_timer_set_load_start(gpt, 0, 0);
> +
> +	local_irq_save(flags);
> +	diff = _omap3_sram_delay(loop);
> +	local_irq_restore(flags);
> +
> +	omap_dm_timer_stop(gpt);
> +	omap_dm_timer_free(gpt);
> +
> +	mpurate = clk_get_rate(clk_get(NULL, "arm_fck"));
> +
> +	/* calculate the sram delay */
> +	delay_sram = ((((mpurate/1000000) / (gt_rate/1000000)) * diff) / 20000);
Can remove the 1000000 from the denominators as they cancel out.
> +
> +	error_gain = ((mpurate/1000000) / (gt_rate/1000000));
Same as before.
> +	delay_sram = delay_sram + error_gain;
> +
> +	return delay_sram;
> +}

