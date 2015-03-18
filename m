From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Set rule constraints if implicit
 BCLK divider is used
Date: Wed, 18 Mar 2015 10:08:46 +0200
Message-ID: <5509328E.5020606@ti.com>
References: <1426604203-6467-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35313 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755001AbbCRII7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 04:08:59 -0400
In-Reply-To: <1426604203-6467-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, lars@metafoo.de

On 03/17/2015 04:56 PM, Jyri Sarha wrote:
> Set a rule constraints to allow only combinations of sample-rate and
> number of frame-bits that can be played/captured with a reasonable
> sample-rate accuracy.
>=20
> Also, takes the number of serializers into account when implicitly
> selecting the BLCK divider.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
> Now this works as it should.
>=20
> Thanks,
> Jyri
>=20
>  sound/soc/davinci/davinci-mcasp.c | 150 ++++++++++++++++++++++++++++=
+++++++---
>  1 file changed, 140 insertions(+), 10 deletions(-)
>=20
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/da=
vinci-mcasp.c
> index de3b155..3ecee3b 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -26,6 +26,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_device.h>
> +#include <linux/math64.h>
> =20
>  #include <sound/asoundef.h>
>  #include <sound/core.h>
> @@ -64,6 +65,11 @@ struct davinci_mcasp_context {
>  	u32	*xrsr_regs; /* for serializer configuration */
>  };
> =20
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
> =20
>  static inline void mcasp_set_bits(struct davinci_mcasp *mcasp, u32 o=
ffset,
> @@ -855,6 +863,30 @@ static int mcasp_dit_hw_param(struct davinci_mca=
sp *mcasp,
>  	return 0;
>  }
> =20
> +static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
> +				      unsigned int bclk_freq,
> +				      int *error_ppm)
> +{
> +	int div =3D mcasp->sysclk_freq / bclk_freq;
> +	int rem =3D mcasp->sysclk_freq % bclk_freq;
> +
> +	if (rem !=3D 0) {
> +		if (div =3D=3D 0 ||
> +		    ((mcasp->sysclk_freq / div) - bclk_freq) >
> +		    (bclk_freq - (mcasp->sysclk_freq / (div+1)))) {
> +			div++;
> +			rem =3D rem - bclk_freq;
> +		}
> +	}
> +	if (error_ppm)
> +		*error_ppm =3D
> +			(div*1000000 + (int)div64_long(1000000LL*rem,
> +						       (int)bclk_freq))
> +			/div - 1000000;
> +
> +	return div;
> +}
> +
>  static int davinci_mcasp_hw_params(struct snd_pcm_substream *substre=
am,
>  					struct snd_pcm_hw_params *params,
>  					struct snd_soc_dai *cpu_dai)
> @@ -872,16 +904,19 @@ static int davinci_mcasp_hw_params(struct snd_p=
cm_substream *substream,
>  	 * the machine driver, we need to calculate the ratio.
>  	 */
>  	if (mcasp->bclk_master && mcasp->bclk_div =3D=3D 0 && mcasp->sysclk=
_freq) {
> -		unsigned int bclk_freq =3D snd_soc_params_to_bclk(params);
> -		unsigned int div =3D mcasp->sysclk_freq / bclk_freq;
> -		if (mcasp->sysclk_freq % bclk_freq !=3D 0) {
> -			if (((mcasp->sysclk_freq / div) - bclk_freq) >
> -			    (bclk_freq - (mcasp->sysclk_freq / (div+1))))
> -				div++;
> -			dev_warn(mcasp->dev,
> -				 "Inaccurate BCLK: %u Hz / %u !=3D %u Hz\n",
> -				 mcasp->sysclk_freq, div, bclk_freq);
> -		}
> +		uint bclk_freq =3D snd_soc_params_to_bclk(params);
> +		int dir =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK ?
> +			TX_MODE : RX_MODE;
> +		int ppm, div;
> +
> +		bclk_freq /=3D mcasp->ruledata[dir].serializers;

Not correct, see my comment below.

> +
> +		div =3D davinci_mcasp_calc_clk_div(mcasp, bclk_freq, &ppm);
> +
> +		if (ppm)
> +			dev_info(mcasp->dev, "Sample-rate is off by %d PPM\n",
> +				 ppm);
> +
>  		__davinci_mcasp_set_clkdiv(cpu_dai, 1, div, 0);
>  	}
> =20
> @@ -973,6 +1008,74 @@ static int davinci_mcasp_trigger(struct snd_pcm=
_substream *substream,
>  	return ret;
>  }
> =20
> +static const unsigned int davinci_mcasp_dai_rates[] =3D {
> +	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000,
> +	88200, 96000, 176400, 192000,
> +};
> +
> +#define DAVINCI_MAX_RATE_ERROR_PPM 1000
> +
> +static int davinci_mcasp_hw_rule_rate(struct snd_pcm_hw_params *para=
ms,
> +				      struct snd_pcm_hw_rule *rule)
> +{
> +	struct davinci_mcasp_ruledata *rd =3D rule->private;
> +	unsigned int list[ARRAY_SIZE(davinci_mcasp_dai_rates)];
> +	int frame_size;
> +	int i, count =3D 0;
> +
> +	frame_size =3D snd_soc_params_to_frame_size(params);
> +	if (frame_size < 0)
> +		return frame_size;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(davinci_mcasp_dai_rates); i++) {
> +		uint bclk_freq =3D frame_size*davinci_mcasp_dai_rates[i]/
> +			rd->serializers;
> +		int ppm;
> +
> +		davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
> +		if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM)
> +			list[count++] =3D davinci_mcasp_dai_rates[i];
> +
> +	}
> +	dev_dbg(rd->mcasp->dev, "%d frequencies for %u fsize (%d)\n",
> +		count, frame_size, rd->serializers);
> +
> +	return snd_interval_list(hw_param_interval(params, rule->var),
> +				 count, list, 0);
> +}
> +
> +static int davinci_mcasp_hw_rule_framebits(struct snd_pcm_hw_params =
*params,
> +					   struct snd_pcm_hw_rule *rule)
> +{
> +	struct davinci_mcasp_ruledata *rd =3D rule->private;
> +	struct snd_interval *ci =3D
> +		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
> +	unsigned int max_chan_per_wire =3D ci->max / rd->serializers;

This is not correct. Serializers are working in parallel. The
max_chan_per_wire can not be higher than tdm_slots and can not be less =
then 2
(in IIS mode).
Let's say we have 3 tx serializers and tdm_slots is 2:
in case of stereo stream we will have 2 channels worth of bclk on wire.
In case of 3 or 4 channel audio, we will have again 2 channels worth of=
 bclk

But if we have tdm_slots set to 6:
in case of stereo we will have 2 channels worth of bclk.
in case of 4 channel we will have 4, etc

I believe the places where you use the ->serializers need to be recheck=
ed again.


> +	unsigned int list[max_chan_per_wire*4];
> +	int rate =3D params_rate(params);
> +	int chans, fbits, count =3D 0;
> +
> +	for (chans =3D ci->min; chans <=3D max_chan_per_wire; chans++) {
> +		for (fbits =3D 8; fbits <=3D 32; fbits +=3D 8) {
> +			uint bclk_freq =3D chans*fbits*rate;
> +			int ppm;
> +
> +			davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
> +			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
> +				list[count++] =3D chans*fbits*rd->serializers;
> +				BUG_ON(count > ARRAY_SIZE(list));
> +			}
> +		}
> +	}
> +
> +	dev_dbg(rd->mcasp->dev,
> +		"%d possible frame size for %d Hz (%d)\n",
> +		count, rate, rd->serializers);
> +
> +	return snd_interval_list(hw_param_interval(params, rule->var),
> +				 count, list, 0);
> +}
> +
>  static int davinci_mcasp_startup(struct snd_pcm_substream *substream=
,
>  				 struct snd_soc_dai *cpu_dai)
>  {
> @@ -998,6 +1101,7 @@ static int davinci_mcasp_startup(struct snd_pcm_=
substream *substream,
>  		if (mcasp->serial_dir[i] =3D=3D dir)
>  			max_channels++;
>  	}
> +	mcasp->ruledata[dir].serializers =3D max_channels;
>  	max_channels *=3D mcasp->tdm_slots;
>  	/*
>  	 * If the already active stream has less channels than the calculat=
ed
> @@ -1012,6 +1116,32 @@ static int davinci_mcasp_startup(struct snd_pc=
m_substream *substream,
>  	snd_pcm_hw_constraint_minmax(substream->runtime,
>  				     SNDRV_PCM_HW_PARAM_CHANNELS,
>  				     2, max_channels);
> +
> +	/*
> +	 * If we rely on implicit BCLK divider setting we should
> +	 * set constraints based on what we can provide.
> +	 */
> +	if (mcasp->bclk_master && mcasp->bclk_div =3D=3D 0 && mcasp->sysclk=
_freq) {
> +		int ret;
> +
> +		mcasp->ruledata[dir].mcasp =3D mcasp;
> +
> +		ret =3D snd_pcm_hw_rule_add(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_RATE,
> +					  davinci_mcasp_hw_rule_rate,
> +					  &mcasp->ruledata[dir],
> +					  SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
> +		if (ret)
> +			return ret;
> +		ret =3D snd_pcm_hw_rule_add(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_FRAME_BITS,
> +					  davinci_mcasp_hw_rule_framebits,
> +					  &mcasp->ruledata[dir],
> +					  SNDRV_PCM_HW_PARAM_RATE, -1);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
> =20
>=20
--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
