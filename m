From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization
 delay
Date: Thu, 24 Dec 2009 16:01:08 +0530
Message-ID: <4B3342EC.2070501@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E2C2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36451 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbZLXKbN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Dec 2009 05:31:13 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBOAVA4Z024871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Dec 2009 04:31:12 -0600
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E2C2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Teerth, one more correction/improvement below:
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index d8d5094..ddbdaaf 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
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
> +	delay_sram = (((mpurate / gt_rate) * diff) / 20000);
Instead of 20000 it should be (loop * 2).
> +
> +	error_gain = mpurate / gt_rate;
> +	delay_sram = delay_sram + error_gain;
> +
> +	return delay_sram;
> +}
> +#endif
> 
