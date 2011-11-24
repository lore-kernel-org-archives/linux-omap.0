From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP
 DMIC
Date: Thu, 24 Nov 2011 17:10:19 +0000
Message-ID: <20111124171019.GQ8470@opensource.wolfsonmicro.com>
References: <1322142889-12017-1-git-send-email-peter.ujfalusi@ti.com>
 <1322142889-12017-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48735 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756845Ab1KXRKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 12:10:22 -0500
Content-Disposition: inline
In-Reply-To: <1322142889-12017-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Thu, Nov 24, 2011 at 03:54:46PM +0200, Peter Ujfalusi wrote:

> +	/*
> +	 * 192KHz rate is only supported with 19.2MHz/3.84MHz clock
> +	 * configuration. Fix the dmic clock divider for 192KHz
> +	 */
> +	if (params_rate(params) == 192000) {
> +		if (dmic->fclk_freq == 19200000 && dmic->clk_div == 0x1) {
> +			dmic->clk_div = 0x6;
> +		} else {
> +			dev_err(dmic->dev,
> +				"invalid clock configuration for 192KHz\n");
> +			return -EINVAL;
> +		}
> +	}

That's a bit wierd, magic numbers there and it'll mean we're trashing
the user's configuration.  Why not just return an error if the clock
setup is broken, or alternatively aren't there other invalid
configurations we should be trapping and fixing up (looking at the
divider setting code it seems unlikely that if the user doesn't
configure things we're not going to have a valid divider setup)?

> +static int omap_dmic_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
> +				    unsigned int freq, int dir)
> +{
> +	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
> +
> +	if (dir == SND_SOC_CLOCK_IN)
> +		return omap_dmic_select_fclk(dmic, clk_id, freq);
> +	else if (dir == SND_SOC_CLOCK_OUT)
> +		return omap_dmic_select_divider(dmic, freq);

Might be better to specify using clk_id in case the next revision of the
IP has more clocks or something.

> +	dmic = kzalloc(sizeof(struct omap_dmic), GFP_KERNEL);
> +	if (!dmic)
> +		return -ENOMEM;

devm_ would save you having to clean stuff up later.

> +static int __init snd_omap_dmic_init(void)
> +{
> +	return platform_driver_register(&asoc_dmic_driver);
> +}
> +module_init(snd_omap_dmic_init);
> +
> +static void __exit snd_omap_dmic_exit(void)
> +{
> +	platform_driver_unregister(&asoc_dmic_driver);
> +}
> +module_exit(snd_omap_dmic_exit);

module_platform_driver.
