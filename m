From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] ASoC: davinci-mcasp: Set rule constraints if implicit
 BCLK divider is used
Date: Thu, 19 Mar 2015 11:11:00 +0200
Message-ID: <550A92A4.2090207@ti.com>
References: <1426755069-28644-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41709 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbbCSJLL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 05:11:11 -0400
In-Reply-To: <1426755069-28644-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com

On 03/19/2015 10:51 AM, Jyri Sarha wrote:
> Set rule constraints to allow only combinations of sample-rate,
> sample-bits, and channels that can be played/captured with reasonable
> sample-rate accuracy.
> 
> The logic with tdm-slots and serializers (=i2s data wires) goes like
> this: The first wire will take all channels up to number of tdm-slots,
> before following wires (if any) are used. If the first wire is used
> fully, the remaining wires share the same clocks and the divider can
> be calculated for the first wire.
> 
> Also, takes the number of tdm-slots into account when implicitly
> selecting the BLCK divider.

Looks good, thanks.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
> 
> I hope the logic with tdm-slots and serializers is now correct. I do
> not have HW to test multiple serializers case, so please review
> davinci_mcasp_hw_rule_channels() extra carefully.
> 
> Best regards,
> Jyri
> 
>  sound/soc/davinci/davinci-mcasp.c | 195 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 185 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index de3b155..3b2fb56 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -26,6 +26,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_device.h>
> +#include <linux/math64.h>
>  
>  #include <sound/asoundef.h>
>  #include <sound/core.h>
> @@ -64,6 +65,11 @@ struct davinci_mcasp_context {
>  	u32	*xrsr_regs; /* for serializer configuration */
>  };
>  
> +struct davinci_mcasp_ruledata {
> +	struct davinci_mcasp *mcasp;
> +	int serializers;
> +};
> +
>  struct davinci_mcasp {
>  	struct davinci_pcm_dma_params dma_params[2];
>  	struct snd_dmaengine_dai_dma_data dma_data[2];
> @@ -98,6 +104,8 @@ struct davinci_mcasp {
>  #ifdef CONFIG_PM_SLEEP
>  	struct davinci_mcasp_context context;
>  #endif
> +
> +	struct davinci_mcasp_ruledata ruledata[2];
>  };
>  
>  static inline void mcasp_set_bits(struct davinci_mcasp *mcasp, u32 offset,
> @@ -855,6 +863,30 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
>  	return 0;
>  }
>  
> +static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
> +				      unsigned int bclk_freq,
> +				      int *error_ppm)
> +{
> +	int div = mcasp->sysclk_freq / bclk_freq;
> +	int rem = mcasp->sysclk_freq % bclk_freq;
> +
> +	if (rem != 0) {
> +		if (div == 0 ||
> +		    ((mcasp->sysclk_freq / div) - bclk_freq) >
> +		    (bclk_freq - (mcasp->sysclk_freq / (div+1)))) {
> +			div++;
> +			rem = rem - bclk_freq;
> +		}
> +	}
> +	if (error_ppm)
> +		*error_ppm =
> +			(div*1000000 + (int)div64_long(1000000LL*rem,
> +						       (int)bclk_freq))
> +			/div - 1000000;
> +
> +	return div;
> +}
> +
>  static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
>  					struct snd_pcm_hw_params *params,
>  					struct snd_soc_dai *cpu_dai)
> @@ -872,16 +904,20 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
>  	 * the machine driver, we need to calculate the ratio.
>  	 */
>  	if (mcasp->bclk_master && mcasp->bclk_div == 0 && mcasp->sysclk_freq) {
> -		unsigned int bclk_freq = snd_soc_params_to_bclk(params);
> -		unsigned int div = mcasp->sysclk_freq / bclk_freq;
> -		if (mcasp->sysclk_freq % bclk_freq != 0) {
> -			if (((mcasp->sysclk_freq / div) - bclk_freq) >
> -			    (bclk_freq - (mcasp->sysclk_freq / (div+1))))
> -				div++;
> -			dev_warn(mcasp->dev,
> -				 "Inaccurate BCLK: %u Hz / %u != %u Hz\n",
> -				 mcasp->sysclk_freq, div, bclk_freq);
> -		}
> +		int channels = params_channels(params);
> +		int rate = params_rate(params);
> +		int sbits = params_width(params);
> +		int ppm, div;
> +
> +		if (channels > mcasp->tdm_slots)
> +			channels = mcasp->tdm_slots;
> +
> +		div = davinci_mcasp_calc_clk_div(mcasp, rate*sbits*channels,
> +						 &ppm);
> +		if (ppm)
> +			dev_info(mcasp->dev, "Sample-rate is off by %d PPM\n",
> +				 ppm);
> +
>  		__davinci_mcasp_set_clkdiv(cpu_dai, 1, div, 0);
>  	}
>  
> @@ -973,6 +1009,108 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
>  	return ret;
>  }
>  
> +static const unsigned int davinci_mcasp_dai_rates[] = {
> +	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000,
> +	88200, 96000, 176400, 192000,
> +};
> +
> +#define DAVINCI_MAX_RATE_ERROR_PPM 1000
> +
> +static int davinci_mcasp_hw_rule_rate(struct snd_pcm_hw_params *params,
> +				      struct snd_pcm_hw_rule *rule)
> +{
> +	struct davinci_mcasp_ruledata *rd = rule->private;
> +	int sbits = params_width(params);
> +	int channels = params_channels(params);
> +	unsigned int list[ARRAY_SIZE(davinci_mcasp_dai_rates)];
> +	int i, count = 0;
> +
> +	if (channels > rd->mcasp->tdm_slots)
> +		channels = rd->mcasp->tdm_slots;
> +
> +	for (i = 0; i < ARRAY_SIZE(davinci_mcasp_dai_rates); i++) {
> +		uint bclk_freq = sbits*channels*davinci_mcasp_dai_rates[i];
> +		int ppm;
> +
> +		davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
> +		if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM)
> +			list[count++] = davinci_mcasp_dai_rates[i];
> +
> +	}
> +	dev_dbg(rd->mcasp->dev, "%d frequencies for %d sbits and %d channels\n",
> +		count, sbits, channels);
> +
> +	return snd_interval_list(hw_param_interval(params, rule->var),
> +				 count, list, 0);
> +}
> +
> +static int davinci_mcasp_hw_rule_samplebits(struct snd_pcm_hw_params *params,
> +					    struct snd_pcm_hw_rule *rule)
> +{
> +	struct davinci_mcasp_ruledata *rd = rule->private;
> +	int channels = params_channels(params);
> +	int rate = params_rate(params);
> +	unsigned int list[4];
> +	int sbits, count = 0;
> +
> +	if (channels > rd->mcasp->tdm_slots)
> +		channels = rd->mcasp->tdm_slots;
> +
> +	for (sbits = 8; sbits <= 32; sbits += 8) {
> +		uint bclk_freq = channels*sbits*rate;
> +		int ppm;
> +
> +		davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
> +		if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM)
> +			list[count++] = sbits;
> +	}
> +	dev_dbg(rd->mcasp->dev,
> +		"%d possible sample size for %d Hz and %d channels\n",
> +		count, rate, channels);
> +
> +	return snd_interval_list(hw_param_interval(params, rule->var),
> +				 count, list, 0);
> +}
> +
> +static int davinci_mcasp_hw_rule_channels(struct snd_pcm_hw_params *params,
> +					  struct snd_pcm_hw_rule *rule)
> +{
> +	struct davinci_mcasp_ruledata *rd = rule->private;
> +	struct snd_interval *ci =
> +		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
> +	int sbits = params_width(params);
> +	int rate = params_rate(params);
> +	int max_chan_per_wire = rd->mcasp->tdm_slots < ci->max ?
> +		rd->mcasp->tdm_slots : ci->max;
> +	unsigned int list[ci->max - ci->min + 1];
> +	int c1, c, count = 0;
> +
> +	for (c1 = ci->min; c1 <= max_chan_per_wire; c1++) {
> +		uint bclk_freq = c1*sbits*rate;
> +		int ppm;
> +
> +		davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
> +		if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
> +			/* If we can use all tdm_slots, we can put any
> +			   amount of channels to remaining wires as
> +			   long as they fit in. */
> +			if (c1 == rd->mcasp->tdm_slots) {
> +				for (c = c1; c <= rd->serializers*c1 &&
> +					     c <= ci->max; c++)
> +					list[count++] = c;
> +			} else {
> +				list[count++] = c1;
> +			}
> +		}
> +	}
> +	dev_dbg(rd->mcasp->dev,
> +		"%d possible channel counts for %d Hz and %d sbits\n",
> +		count, rate, sbits);
> +
> +	return snd_interval_list(hw_param_interval(params, rule->var),
> +				 count, list, 0);
> +}
> +
>  static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
>  				 struct snd_soc_dai *cpu_dai)
>  {
> @@ -998,6 +1136,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
>  		if (mcasp->serial_dir[i] == dir)
>  			max_channels++;
>  	}
> +	mcasp->ruledata[dir].serializers = max_channels;
>  	max_channels *= mcasp->tdm_slots;
>  	/*
>  	 * If the already active stream has less channels than the calculated
> @@ -1012,6 +1151,42 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
>  	snd_pcm_hw_constraint_minmax(substream->runtime,
>  				     SNDRV_PCM_HW_PARAM_CHANNELS,
>  				     2, max_channels);
> +
> +	/*
> +	 * If we rely on implicit BCLK divider setting we should
> +	 * set constraints based on what we can provide.
> +	 */
> +	if (mcasp->bclk_master && mcasp->bclk_div == 0 && mcasp->sysclk_freq) {
> +		int ret;
> +
> +		mcasp->ruledata[dir].mcasp = mcasp;
> +
> +		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_RATE,
> +					  davinci_mcasp_hw_rule_rate,
> +					  &mcasp->ruledata[dir],
> +					  SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
> +					  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
> +		if (ret)
> +			return ret;
> +		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
> +					  davinci_mcasp_hw_rule_samplebits,
> +					  &mcasp->ruledata[dir],
> +					  SNDRV_PCM_HW_PARAM_RATE,
> +					  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
> +		if (ret)
> +			return ret;
> +		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_CHANNELS,
> +					  davinci_mcasp_hw_rule_channels,
> +					  &mcasp->ruledata[dir],
> +					  SNDRV_PCM_HW_PARAM_RATE,
> +					  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> 
