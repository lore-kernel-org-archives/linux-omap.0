From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct
 constraints for streams
Date: Mon, 31 May 2010 11:00:21 +0100
Message-ID: <1275300021.3174.5.camel@odin>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	 <1275293810-31984-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58012 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850Ab0EaKA3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 06:00:29 -0400
Received: by wwb28 with SMTP id 28so1134288wwb.19
        for <linux-omap@vger.kernel.org>; Mon, 31 May 2010 03:00:27 -0700 (PDT)
In-Reply-To: <1275293810-31984-6-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, tony@atomide.com, broonie@opensource.wolfsonmicro.com, eduardo.valentin@nokia.com, ext-eero.nurkkala@nokia.com

On Mon, 2010-05-31 at 11:16 +0300, Peter Ujfalusi wrote:
> OMAP McBSP FIFO is word structured:
> McBSP2 has 1024 + 256 = 1280 word long buffer,
> McBSP1,3,4,5 has 128 word long buffer
> 
> This means, that the size of the FIFO
> depends on the McBSP word size configuration.
> For example on McBSP3:
> 16bit samples: size is 128 * 2 = 256 bytes
> 32bit samples: size is 128 * 4 = 512 bytes
> It is simpler to place constraint for buffer and period based on channels.
> McBSP3 as example again (16 or 32 bit samples):
> 1 channel (mono): size is 128 frames (128 words)
> 2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
> 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
> 
> Use the second method to place hw_rule on buffer size, and in threshold
> mode to period size.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |   98 +++++++++++++++++++++++++++++++++---------
>  1 files changed, 77 insertions(+), 21 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index b06d8f1..d6ed761 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -173,6 +173,52 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
>  		omap_mcbsp_set_rx_threshold(mcbsp_data->bus_id, words);
>  }
>  
> +static int hw_rule_bsize_by_channels(struct snd_pcm_hw_params *params,
> +				    struct snd_pcm_hw_rule *rule)
> +{
> +	struct snd_interval *bs = hw_param_interval(params,
> +					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
> +	struct snd_interval *c = hw_param_interval(params,
> +					SNDRV_PCM_HW_PARAM_CHANNELS);

Best to make these variable names more meaningful.

> +	struct omap_mcbsp_data *mcbsp_data = rule->private;
> +	struct snd_interval frames;
> +	int size;
> +
> +	snd_interval_any(&frames);
> +	size = omap_mcbsp_get_fifo_size(mcbsp_data->bus_id);
> +
> +	frames.min = size / c->min;
> +	frames.integer = 1;
> +	return snd_interval_refine(bs, &frames);
> +
> +}
> +
> +static int hw_rule_psize_by_channels(struct snd_pcm_hw_params *params,
> +				    struct snd_pcm_hw_rule *rule)
> +{
> +	struct snd_interval *ps = hw_param_interval(params,
> +					SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
> +	struct snd_interval *c = hw_param_interval(params,
> +					SNDRV_PCM_HW_PARAM_CHANNELS);

ditto

> +	struct snd_pcm_substream *substream = rule->private;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
> +	struct snd_interval frames;
> +	int size;
> +
> +	snd_interval_any(&frames);
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		size = omap_mcbsp_get_max_tx_threshold(mcbsp_data->bus_id);
> +	else
> +		size = omap_mcbsp_get_max_rx_threshold(mcbsp_data->bus_id);
> +
> +	frames.min = 8;
> +	frames.max = size / c->min;
> +	frames.integer = 1;
> +	return snd_interval_refine(ps, &frames);
> +}

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

