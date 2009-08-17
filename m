From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 20/20] ASoC: OMAP: Use DMA operating mode of McBSP
Date: Mon, 17 Aug 2009 17:02:02 +0300
Message-ID: <20090817140201.GZ7278@atomide.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com> <1250509879-6703-21-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58134 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbZHQOCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 10:02:05 -0400
Content-Disposition: inline
In-Reply-To: <1250509879-6703-21-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

* Eduardo Valentin <eduardo.valentin@nokia.com> [090817 15:06]:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>

And this one too.
 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |   18 +++++++++++++++---
>  1 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 2aec7a6..60c360b 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -144,7 +144,14 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
>  	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
> -	int samples = snd_pcm_lib_period_bytes(substream) >> 1;
> +	int dma_op_mode = omap_mcbsp_get_dma_op_mode(mcbsp_data->bus_id);
> +	int samples;
> +
> +	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
> +	if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
> +		samples = snd_pcm_lib_period_bytes(substream) >> 1;
> +	else
> +		samples = 1;
>  
>  	/* Configure McBSP internal buffer usage */
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> @@ -166,6 +173,7 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
>  		err = omap_mcbsp_request(bus_id);
>  
>  	if (cpu_is_omap343x()) {
> +		int dma_op_mode = omap_mcbsp_get_dma_op_mode(bus_id);
>  		int max_period;
>  
>  		/*
> @@ -187,7 +195,8 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
>  		max_period++;
>  		max_period <<= 1;
>  
> -		snd_pcm_hw_constraint_minmax(substream->runtime,
> +		if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
> +			snd_pcm_hw_constraint_minmax(substream->runtime,
>  						SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
>  						32, max_period);
>  	}
> @@ -268,7 +277,10 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>  		port = omap34xx_mcbsp_port[bus_id][substream->stream];
>  		omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold =
>  						omap_mcbsp_set_threshold;
> -		sync_mode = OMAP_DMA_SYNC_FRAME;
> +		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
> +		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
> +						MCBSP_DMA_MODE_THRESHOLD)
> +			sync_mode = OMAP_DMA_SYNC_FRAME;
>  	} else {
>  		return -ENODEV;
>  	}
> -- 
> 1.6.2.GIT
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
