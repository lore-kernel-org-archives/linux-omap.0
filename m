From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/5] [RFC] ALSA ASOC Support for 5912 osk
Date: Mon, 29 Sep 2008 14:38:09 +0300
Message-ID: <20080929143809.bd4c1db7.jarkko.nikula@nokia.com>
References: <dfeb90390809290248h5638e275n458e80743954c0cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18174 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYI2LjX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 07:39:23 -0400
In-Reply-To: <dfeb90390809290248h5638e275n458e80743954c0cf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arun KS <arunks@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, alsa-devel@vger.kernel.org, felipe.balbi@nokia.com

On Mon, 29 Sep 2008 15:18:32 +0530
"ext Arun KS" <arunks@mistralsolutions.com> wrote:

> Adding ASOC machine driver for osk
> 
> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  sound/soc/omap/Kconfig  |    8 ++
>  sound/soc/omap/Makefile |    3 +-
>  sound/soc/omap/osk.c    |  230 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 240 insertions(+), 1 deletions(-)
>  create mode 100644 sound/soc/omap/osk.c
> 
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index d7b8939..f2e6d01 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -22,3 +22,11 @@ config SND_OMAP_SOC_OVERO
>  	help
>  	  Say Y if you want to add support for SoC audio on the Gumstix Overo.
> 
> +config SND_OMAP_SOC_OSK
> +	tristate "SoC Audio support for 5912 OSK"
> +	depends on SND_OMAP_SOC && MACH_OMAP_OSK
> +	select SND_OMAP_SOC_MCBSP
> +	select SND_SOC_TLV320AIC23
> +	help
> +	  Say Y if you want to add support for SoC audio on 5912 OSK.
> +
>
This is generated against linux-omap. Generate it against a tree used in
alsa-devel (ASoC dev or Takashi's) since this ASoC for OSK5912 can go
directly there. Overo and Beagle are stalled until remaining McBSP
updates, OMAP3 and TWL4030 related patches are upstream from linux-omap.

> +static int osk_hw_params(struct snd_pcm_substream *substream,
> +			 struct snd_pcm_hw_params *params)
> +{
...
> +	/* Set the codec system clock for DAC and ADC */
> +	err = snd_soc_dai_set_sysclk(codec_dai, 0, 12000000, SND_SOC_CLOCK_IN);
...
> +#define CODEC_CLOCK 	12000000

Use this definition also above.

> +	aic23_mclk = clk_get(dev, "mclk");
> +	if (IS_ERR(aic23_mclk)) {
> +		printk(KERN_ERR "Could not get mclk clock\n");
> +		return -ENODEV;
> +	}
> +
...
> +	curRate = (uint) clk_get_rate(aic23_mclk);
> +	if (curRate != CODEC_CLOCK) {
> +		if (clk_set_rate(aic23_mclk, CODEC_CLOCK)) {
> +			printk(KERN_ERR "Cannot set MCLK for AIC23 CODEC\n");
> +			return -ECANCELED;
>
aic23_mclk is not released in this error path so set the err variable
and do goto err1 instead of returning.


Jarkko
