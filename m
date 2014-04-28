From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 2/5] ASoC: Add HA (HEAD acoustics) DSP codec
 driver template
Date: Mon, 28 Apr 2014 16:45:50 +0200
Message-ID: <535E699E.3040305@metafoo.de>
References: <1398687476-10829-1-git-send-email-sr@denx.de> <1398687476-10829-2-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out-013.synserver.de ([212.40.185.13]:1069 "EHLO
	smtp-out-008.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756246AbaD1Owk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 10:52:40 -0400
In-Reply-To: <1398687476-10829-2-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>

On 04/28/2014 02:17 PM, Stefan Roese wrote:
> From: Jarkko Nikula <jarkko.nikula@bitmer.com>
>
> This codec driver template represents an I2C controlled multichannel audio
> codec that has many typical ASoC codec driver features like volume controls,
> mixer stages, mux selection, output power control, in-codec audio routings,
> codec bias management and DAI link configuration.
>
> Updates from Stefan Roese, 2014-04-28:
> Port the HA DSP codec driver to Linux v3.15-rc. This includes
> support for DT based probing. No platform-data code is needed
> any more, DT nodes are sufficient.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>

Looks very good. Couple of bits inline.

[...]
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/pm.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/tlv.h>
> +#include <sound/initval.h>

There seem to be a couple of includes here that are not really needed.

> +
> +#include "ha-dsp.h"
[...]
> +static const char *ha_dsp_mode_texts[] = {"Mode 1", "Mode 2"};

const char *const

> +static SOC_ENUM_SINGLE_DECL(ha_dsp_mode_enum, HA_DSP_CTRL, 0,
> +			    ha_dsp_mode_texts);
> +
> +/* Monitor output mux selection */
> +static const char *ha_dsp_monitor_texts[] = {"Off", "ADC", "DAC"};

const char *const

> +static SOC_ENUM_SINGLE_DECL(ha_dsp_monitor_enum, HA_DSP_CTRL, 1,
> +			    ha_dsp_monitor_texts);
> +
[...]
> +static const struct snd_soc_dapm_widget ha_dsp_widgets[] = {
> +	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
> +
> +	SND_SOC_DAPM_MIXER("OUT1 Mixer", SND_SOC_NOPM, 0, 0,
> +			   &ha_dsp_out1_mixer_controls[0],
> +			   ARRAY_SIZE(ha_dsp_out1_mixer_controls)),

There is the SOC_MIXER_ARRAY() helper macro that you can use here and below.

> +	SND_SOC_DAPM_MIXER("OUT2 Mixer", SND_SOC_NOPM, 0, 0,
> +			   &ha_dsp_out2_mixer_controls[0],
> +			   ARRAY_SIZE(ha_dsp_out2_mixer_controls)),
> +	SND_SOC_DAPM_MIXER("OUT3 Mixer", SND_SOC_NOPM, 0, 0,
> +			   &ha_dsp_out3_mixer_controls[0],
> +			   ARRAY_SIZE(ha_dsp_out3_mixer_controls)),
> +	SND_SOC_DAPM_MIXER("OUT4 Mixer", SND_SOC_NOPM, 0, 0,
> +			   &ha_dsp_out4_mixer_controls[0],
> +			   ARRAY_SIZE(ha_dsp_out4_mixer_controls)),
> +	SND_SOC_DAPM_MIXER("OUT5 Mixer", SND_SOC_NOPM, 0, 0,
> +			   &ha_dsp_out5_mixer_controls[0],
> +			   ARRAY_SIZE(ha_dsp_out5_mixer_controls)),
> +	SND_SOC_DAPM_MIXER("OUT6 Mixer", SND_SOC_NOPM, 0, 0,
> +			   &ha_dsp_out6_mixer_controls[0],
> +			   ARRAY_SIZE(ha_dsp_out6_mixer_controls)),
> +	SND_SOC_DAPM_MIXER("OUT7 Mixer", SND_SOC_NOPM, 0, 0,
> +			   &ha_dsp_out7_mixer_controls[0],
> +			   ARRAY_SIZE(ha_dsp_out7_mixer_controls)),
> +	SND_SOC_DAPM_MIXER("OUT8 Mixer", SND_SOC_NOPM, 0, 0,
> +			   &ha_dsp_out8_mixer_controls[0],
> +			   ARRAY_SIZE(ha_dsp_out8_mixer_controls)),
[...]
> +static int ha_dsp_hw_params(struct snd_pcm_substream *substream,
> +			    struct snd_pcm_hw_params *params,
> +			    struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;

A codec should never look at the pcm_runtime. The proper way to get a 
pointer to the codec in dai callbacks is dai->codec. Or just use dai->dev below.

> +
> +	dev_dbg(codec->dev, "Sample format 0x%X\n", params_format(params));
> +	dev_dbg(codec->dev, "Channels %d\n", params_channels(params));
> +	dev_dbg(codec->dev, "Rate %d\n", params_rate(params));
> +
> +	return 0;
> +}
[...]
> +static int ha_dsp_set_bias_level(struct snd_soc_codec *codec,
> +				 enum snd_soc_bias_level level)
> +{
> +	dev_dbg(codec->dev, "Changing bias from %d to %d\n",
> +		codec->dapm.bias_level, level);
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		break;
> +	case SND_SOC_BIAS_PREPARE:
> +		/* Set PLL on */
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		/* Set power on, Set PLL off */
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		/* Set power down */
> +		break;
> +	}
> +	codec->dapm.bias_level = level;

If you don't do anything in set_bias_level, just don't implement the 
function. The default implementation if no callback is specified is to set 
the bias_level to the requested level.

> +
> +	return 0;
> +}
> +
> +static struct snd_soc_dai_ops ha_dsp_dai_ops = {

const

> +	.hw_params	= ha_dsp_hw_params,
> +	.set_fmt	= ha_dsp_set_dai_fmt,
> +};
> +
> +static struct snd_soc_dai_driver ha_dsp_dai = {
> +	.name = "ha-dsp-hifi",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 2,
> +		.channels_max = 16,
> +		.rates = SNDRV_PCM_RATE_8000_96000,
> +		/* We use only 32 Bits for Audio */
> +		.formats = SNDRV_PCM_FMTBIT_S32_LE,
> +	},
> +	.capture = {
> +		.stream_name = "Capture",
> +		.channels_min = 2,
> +		.channels_max = 16,
> +		.rates = SNDRV_PCM_RATE_8000_96000,
> +		/* We use only 32 Bits for Audio */
> +		.formats = SNDRV_PCM_FMTBIT_S32_LE,
> +	},
> +	.ops = &ha_dsp_dai_ops,
> +};
> +
> +static int ha_dsp_probe(struct snd_soc_codec *codec)
> +{
> +	int ret;
> +
> +	codec->control_data = dev_get_regmap(codec->dev->parent, NULL);

Why do you want to use the regmap instance of the parent? That doesn't make 
sense given that you initialized a remgap instance for the device itself.

> +	ret = snd_soc_codec_set_cache_io(codec, codec->control_data);
> +	if (ret != 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ha_dsp_remove(struct snd_soc_codec *codec)
> +{
> +	snd_soc_write(codec, HA_DSP_CTRL, HA_DSP_SW_RESET);

To get the codec into a well know state it is best practice to also reset it 
when probing the device.

> +
> +	return 0;
> +}
> +
[...]
> +static int ha_dsp_i2c_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(client, &ha_dsp_regmap);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&client->dev, "Failed to create regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_register_codec(&client->dev, &soc_codec_dev_ha_dsp,
> +				     &ha_dsp_dai, 1);

Just return snd_soc_register_codec(...)

> +
> +	return ret;
> +}
[...]
