From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP DMIC
Date: Tue, 22 Nov 2011 16:01:05 +0000
Message-ID: <20111122160105.GC30583@opensource.wolfsonmicro.com>
References: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com>
 <1321970520-8909-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44265 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754000Ab1KVQBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 11:01:08 -0500
Content-Disposition: inline
In-Reply-To: <1321970520-8909-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Tue, Nov 22, 2011 at 04:01:57PM +0200, Peter Ujfalusi wrote:

> +	switch (params_rate(params)) {
> +	case 96000:
> +	case 192000:
> +		break;

Why doesn't the driver need to tell the hardware what sample rate to run
at?

> +	dmic_clk = clk_get(dmic->dev, "dmic_fck");
> +	if (IS_ERR(dmic_clk)) {
> +		dev_err(dmic->dev, "cant get dmic_fck\n");
> +		return -ENODEV;
> +	}

Why aren't we getting and holding a reference to the clock over the
entire lifetime of the driver?

> +	/* disable clock while reparenting */
> +	pm_runtime_put_sync(dmic->dev);
> +	ret = clk_set_parent(dmic_clk, parent_clk);
> +	pm_runtime_get_sync(dmic->dev);

Since we're only allowing reclocking while idle shouldn't the clock
already be disabled?  Seems like it ought to be good for power if
nothing else...

> +static int omap_dmic_set_clkdiv(struct snd_soc_dai *dai,
> +				int div_id, int div)
> +{

DMIC clocking is usually fairly simple so it seems surprising that the
driver isn't able to figure this out for itself.
