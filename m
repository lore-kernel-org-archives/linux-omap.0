From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: DMIC codec: Adding a generic DMIC codec
Date: Tue, 28 Dec 2010 14:29:09 +0000
Message-ID: <20101228142909.GB31883@opensource.wolfsonmicro.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-3-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58078 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753242Ab0L1O27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Dec 2010 09:28:59 -0500
Content-Disposition: inline
In-Reply-To: <1293509826-23253-3-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Mon, Dec 27, 2010 at 10:17:03PM -0600, David Lambert wrote:

> At this time, the codec driver just registers the codec DAI.

If it's doing more than that it's going to be a separate driver anyway I
expect.

> +static struct snd_soc_dai_driver dmic_dai = {
> +	.name = "dmic-hifi",
> +	.capture = {
> +		.stream_name = "Capture",
> +		.channels_min = 1,
> +		.channels_max = 8,
> +		.rates = SNDRV_PCM_RATE_CONTINUOUS,
> +		.formats = SNDRV_PCM_FMTBIT_S32_LE
> +			| SNDRV_PCM_FMTBIT_S24_LE
> +			| SNDRV_PCM_FMTBIT_S16_LE,

Hrm, so.  DMIC signals are inherantly stereo, though obviously you can
bind multiple DMICs in parallel using the same clock line so from the
CPU side the channel limit makes sense.  Similarly the format here
really makes very little odds on a PDM interface.

What we probably want here is wildcards for both channel and format
limits which we can use to say "this is meaningless, just match
anything" in case the other end needs it (like a CPU PDM interface does
to set up the DMA).

> +static struct platform_driver dmic_driver = {
> +	.driver = {
> +		.name = "dmic-codec",

Just -dmic.

> +MODULE_DESCRIPTION("Generic DMIC driver");
> +MODULE_AUTHOR("Liam Girdwood <lrg@slimlogic.co.uk>");
> +MODULE_LICENSE("GPL");

MODULE_ALIAS().
