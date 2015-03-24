From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3] ASoC: davinci-mcasp: Set rule
 constraints if implicit BCLK divider is used
Date: Tue, 24 Mar 2015 11:17:47 +0200
Message-ID: <55112BBB.3030909@ti.com>
References: <1426851068-26366-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1426851068-26366-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, broonie@kernel.org, lars@metafoo.de
List-Id: linux-omap@vger.kernel.org

On 03/20/2015 01:31 PM, Jyri Sarha wrote:
> Set rule constraints to allow only combinations of sample-rate,
> sample-format, and channels counts that can be played/captured with
> reasonable sample-rate accuracy.
> =

> The logic with tdm-slots and serializers (=3Di2s data wires) goes like
> this: The first wire will take all channels up to number of tdm-slots,
> before following wires (if any) are used. If the first wire is used
> fully, the remaining wires share the same clocks and the divider can
> be calculated for the first wire.
> =

> Also, takes the number of tdm-slots into account when implicitly
> selecting the BLCK divider.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
> Previous version of the patch:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/089319.ht=
ml
> =

> Since v2 I changed the SNDRV_PCM_HW_PARAM_SAMPLE_BITS rule in the to
> SNDRV_PCM_HW_PARAM_FORMAT rule. =

> =

> Somehow the constraints with a SNDRV_PCM_HW_PARAM_SAMPLE_BITS rule
> using snd_interval_list() converged to an empty set when ever I tried
> to play a format that could not pass the rule with any channel count
> or rate, resulting all too familiar assertion in alsa-lib. However,
> the direct tampering with SNDRV_PCM_HW_PARAM_FORMAT mask appears to
> work as it should.
> =

> In addition to SAMPLE_BITS- to FORMAT-rule change I optimized the rate
> rule a bit so that it does not try the rates that are outside current
> range. According to my tests this does not affect the behavior in any
> other way but slightly speeds up the decision making.
> =

>  sound/soc/davinci/davinci-mcasp.c | 207 ++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 197 insertions(+), 10 deletions(-)
> =

> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
> index d40b392..76156d18 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_data/davinci_asp.h>
> +#include <linux/math64.h>
>  =

>  #include <sound/asoundef.h>
>  #include <sound/core.h>
> @@ -65,6 +66,11 @@ struct davinci_mcasp_context {
>  	bool	pm_state;
>  };
>  =

> +struct davinci_mcasp_ruledata {
> +	struct davinci_mcasp *mcasp;
> +	int serializers;
> +};
> +
>  struct davinci_mcasp {
>  	struct snd_dmaengine_dai_dma_data dma_data[2];
>  	void __iomem *base;
> @@ -99,6 +105,8 @@ struct davinci_mcasp {
>  #ifdef CONFIG_PM_SLEEP
>  	struct davinci_mcasp_context context;
>  #endif
> +
> +	struct davinci_mcasp_ruledata ruledata[2];
>  };
>  =

>  static inline void mcasp_set_bits(struct davinci_mcasp *mcasp, u32 offse=
t,
> @@ -868,6 +876,30 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *=
mcasp,
>  	return 0;
>  }
>  =

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
>  static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
>  					struct snd_pcm_hw_params *params,
>  					struct snd_soc_dai *cpu_dai)
> @@ -883,16 +915,20 @@ static int davinci_mcasp_hw_params(struct snd_pcm_s=
ubstream *substream,
>  	 * the machine driver, we need to calculate the ratio.
>  	 */
>  	if (mcasp->bclk_master && mcasp->bclk_div =3D=3D 0 && mcasp->sysclk_fre=
q) {
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
> +		int channels =3D params_channels(params);
> +		int rate =3D params_rate(params);
> +		int sbits =3D params_width(params);
> +		int ppm, div;
> +
> +		if (channels > mcasp->tdm_slots)
> +			channels =3D mcasp->tdm_slots;
> +
> +		div =3D davinci_mcasp_calc_clk_div(mcasp, rate*sbits*channels,
> +						 &ppm);
> +		if (ppm)
> +			dev_info(mcasp->dev, "Sample-rate is off by %d PPM\n",
> +				 ppm);
> +
>  		__davinci_mcasp_set_clkdiv(cpu_dai, 1, div, 0);
>  	}
>  =

> @@ -974,6 +1010,120 @@ static int davinci_mcasp_trigger(struct snd_pcm_su=
bstream *substream,
>  	return ret;
>  }
>  =

> +static const unsigned int davinci_mcasp_dai_rates[] =3D {
> +	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000,
> +	88200, 96000, 176400, 192000,
> +};
> +
> +#define DAVINCI_MAX_RATE_ERROR_PPM 1000
> +
> +static int davinci_mcasp_hw_rule_rate(struct snd_pcm_hw_params *params,
> +				      struct snd_pcm_hw_rule *rule)
> +{
> +	struct davinci_mcasp_ruledata *rd =3D rule->private;
> +	struct snd_interval *ri =3D
> +		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
> +	int sbits =3D params_width(params);
> +	int channels =3D params_channels(params);
> +	unsigned int list[ARRAY_SIZE(davinci_mcasp_dai_rates)];
> +	int i, count =3D 0;
> +
> +	if (channels > rd->mcasp->tdm_slots)
> +		channels =3D rd->mcasp->tdm_slots;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(davinci_mcasp_dai_rates); i++) {
> +		if (ri->min <=3D davinci_mcasp_dai_rates[i] &&
> +		    ri->max >=3D davinci_mcasp_dai_rates[i]) {
> +			uint bclk_freq =3D sbits*channels*
> +				davinci_mcasp_dai_rates[i];
> +			int ppm;
> +
> +			davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
> +			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM)
> +				list[count++] =3D davinci_mcasp_dai_rates[i];
> +		}
> +	}
> +	dev_dbg(rd->mcasp->dev,
> +		"%d frequencies (%d-%d) for %d sbits and %d channels\n",
> +		count, ri->min, ri->max, sbits, channels);
> +
> +	return snd_interval_list(hw_param_interval(params, rule->var),
> +				 count, list, 0);
> +}
> +
> +static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
> +					struct snd_pcm_hw_rule *rule)
> +{
> +	struct davinci_mcasp_ruledata *rd =3D rule->private;
> +	struct snd_mask *fmt =3D hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMA=
T);
> +	struct snd_mask nfmt;
> +	int rate =3D params_rate(params);
> +	int channels =3D params_channels(params);
> +	int i, count =3D 0;
> +
> +	snd_mask_none(&nfmt);
> +
> +	if (channels > rd->mcasp->tdm_slots)
> +		channels =3D rd->mcasp->tdm_slots;
> +
> +	for (i =3D 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
> +		if (snd_mask_test(fmt, i)) {
> +			uint bclk_freq =3D snd_pcm_format_width(i)*channels*rate;
> +			int ppm;
> +
> +			davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
> +			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
> +				snd_mask_set(&nfmt, i);
> +				count++;
> +			}
> +		}
> +	}
> +	dev_dbg(rd->mcasp->dev,
> +		"%d possible sample format for %d Hz and %d channels\n",
> +		count, rate, channels);
> +
> +	return snd_mask_refine(fmt, &nfmt);
> +}
> +
> +static int davinci_mcasp_hw_rule_channels(struct snd_pcm_hw_params *para=
ms,
> +					  struct snd_pcm_hw_rule *rule)
> +{
> +	struct davinci_mcasp_ruledata *rd =3D rule->private;
> +	struct snd_interval *ci =3D
> +		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
> +	int sbits =3D params_width(params);
> +	int rate =3D params_rate(params);
> +	int max_chan_per_wire =3D rd->mcasp->tdm_slots < ci->max ?
> +		rd->mcasp->tdm_slots : ci->max;
> +	unsigned int list[ci->max - ci->min + 1];
> +	int c1, c, count =3D 0;
> +
> +	for (c1 =3D ci->min; c1 <=3D max_chan_per_wire; c1++) {
> +		uint bclk_freq =3D c1*sbits*rate;
> +		int ppm;
> +
> +		davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
> +		if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
> +			/* If we can use all tdm_slots, we can put any
> +			   amount of channels to remaining wires as
> +			   long as they fit in. */
> +			if (c1 =3D=3D rd->mcasp->tdm_slots) {
> +				for (c =3D c1; c <=3D rd->serializers*c1 &&
> +					     c <=3D ci->max; c++)
> +					list[count++] =3D c;
> +			} else {
> +				list[count++] =3D c1;
> +			}
> +		}
> +	}
> +	dev_dbg(rd->mcasp->dev,
> +		"%d possible channel counts (%d-%d) for %d Hz and %d sbits\n",
> +		count, ci->min, ci->max, rate, sbits);
> +
> +	return snd_interval_list(hw_param_interval(params, rule->var),
> +				 count, list, 0);
> +}
> +
>  static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
>  				 struct snd_soc_dai *cpu_dai)
>  {
> @@ -999,6 +1149,7 @@ static int davinci_mcasp_startup(struct snd_pcm_subs=
tream *substream,
>  		if (mcasp->serial_dir[i] =3D=3D dir)
>  			max_channels++;
>  	}
> +	mcasp->ruledata[dir].serializers =3D max_channels;
>  	max_channels *=3D mcasp->tdm_slots;
>  	/*
>  	 * If the already active stream has less channels than the calculated
> @@ -1013,6 +1164,42 @@ static int davinci_mcasp_startup(struct snd_pcm_su=
bstream *substream,
>  	snd_pcm_hw_constraint_minmax(substream->runtime,
>  				     SNDRV_PCM_HW_PARAM_CHANNELS,
>  				     2, max_channels);
> +
> +	/*
> +	 * If we rely on implicit BCLK divider setting we should
> +	 * set constraints based on what we can provide.
> +	 */
> +	if (mcasp->bclk_master && mcasp->bclk_div =3D=3D 0 && mcasp->sysclk_fre=
q) {
> +		int ret;
> +
> +		mcasp->ruledata[dir].mcasp =3D mcasp;
> +
> +		ret =3D snd_pcm_hw_rule_add(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_RATE,
> +					  davinci_mcasp_hw_rule_rate,
> +					  &mcasp->ruledata[dir],
> +					  SNDRV_PCM_HW_PARAM_FORMAT,
> +					  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
> +		if (ret)
> +			return ret;
> +		ret =3D snd_pcm_hw_rule_add(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_FORMAT,
> +					  davinci_mcasp_hw_rule_format,
> +					  &mcasp->ruledata[dir],
> +					  SNDRV_PCM_HW_PARAM_RATE,
> +					  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
> +		if (ret)
> +			return ret;
> +		ret =3D snd_pcm_hw_rule_add(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_CHANNELS,
> +					  davinci_mcasp_hw_rule_channels,
> +					  &mcasp->ruledata[dir],
> +					  SNDRV_PCM_HW_PARAM_RATE,
> +					  SNDRV_PCM_HW_PARAM_FORMAT, -1);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  =

> =



-- =

P=E9ter
