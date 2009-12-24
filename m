From: "Reddy, Teerth" <teerth@ti.com>
Subject: RE: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock
 stabilization delay
Date: Thu, 24 Dec 2009 11:01:53 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E2BD@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E202@dbde02.ent.ti.com>
 <4B3229ED.10005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55442 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbZLXFb6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Dec 2009 00:31:58 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBO5VtC1022269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Dec 2009 23:31:57 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBO5Vs80017280
	for <linux-omap@vger.kernel.org>; Thu, 24 Dec 2009 11:01:54 +0530 (IST)
In-Reply-To: <4B3229ED.10005@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks Romit..

Will fix and send the patch.

Regards
Teerth

> -----Original Message-----
> From: Dasgupta, Romit
> Sent: Wednesday, December 23, 2009 8:02 PM
> To: Reddy, Teerth
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3: PM: Dynamic calculation of SDRC clock
> stabilization delay
> 
> > +#ifdef CONFIG_ARCH_OMAP3
> > +unsigned long (*_omap3_sram_delay)(unsigned long);
> > +unsigned int  measure_sram_delay(unsigned int loop)
> > +{
> > +	static struct omap_dm_timer *gpt;
> > +	unsigned long flags, diff = 0, gt_rate, mpurate;
> > +	unsigned int delay_sram, error_gain;
> > +
> > +	omap_dm_timer_init();
> > +	gpt = omap_dm_timer_request_specific(10);
> > +	if (!gpt)
> > +		pr_err("Could not get the gptimer\n");
> > +	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
> > +
> > +	gt_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
> > +	omap_dm_timer_set_load_start(gpt, 0, 0);
> > +
> > +	local_irq_save(flags);
> > +	diff = _omap3_sram_delay(loop);
> > +	local_irq_restore(flags);
> > +
> > +	omap_dm_timer_stop(gpt);
> > +	omap_dm_timer_free(gpt);
> > +
> > +	mpurate = clk_get_rate(clk_get(NULL, "arm_fck"));
> > +
> > +	/* calculate the sram delay */
> > +	delay_sram = ((((mpurate/1000000) / (gt_rate/1000000)) * diff) /
> 20000);
> Can remove the 1000000 from the denominators as they cancel out.
> > +
> > +	error_gain = ((mpurate/1000000) / (gt_rate/1000000));
> Same as before.
> > +	delay_sram = delay_sram + error_gain;
> > +
> > +	return delay_sram;
> > +}

