From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP
 DMIC
Date: Sun, 27 Nov 2011 19:50:41 +0000
Message-ID: <20111127195040.GC25598@opensource.wolfsonmicro.com>
References: <1322223636-31623-1-git-send-email-peter.ujfalusi@ti.com>
 <1322223636-31623-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58421 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755358Ab1K0Tun (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Nov 2011 14:50:43 -0500
Content-Disposition: inline
In-Reply-To: <1322223636-31623-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Fri, Nov 25, 2011 at 02:20:33PM +0200, Peter Ujfalusi wrote:

> +	/*
> +	 * 192KHz rate is only supported with 19.2MHz/3.84MHz clock
> +	 * configuration. The same clock configuration allows 96KHz sampling
> +	 * rate as well. omap_dmic_select_divider() function configures the
> +	 * dividers for 96KHz, if the current stream is running in 192KHz we
> +	 * can change the divider value, while respecting the machine driver
> +	 * requested clock configuration.
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

So what happens if the user starts recording at 192kHz then goes back to
96kHz?  This all feels a bit clunky and fragile.  It seems like the
neatest solution here is to just record the desired DMICCLK rate when
the user sets it and then apply it here rather than doing this patching
later on.
