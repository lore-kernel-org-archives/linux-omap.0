From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: TWL6030: Add twl6030 codec driver
Date: Mon, 14 Sep 2009 18:21:36 +0100
Message-ID: <20090914172135.GA2481@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90432706@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56552 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750901AbZINRVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Sep 2009 13:21:34 -0400
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90432706@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>

On Mon, Sep 14, 2009 at 12:00:25PM -0500, Lopez Cruz, Misael wrote:

> 
> +/* propietary formats */
> +#define SND_SOC_DAIFMT_MCPDM           0x10 /* Texas Instruments McPDM */

This should really be split out into a separate patch.  Are you
absolutely positive that this is a proprietary interface that won't
interoperate with standard PDM?

Also note that your format doesn't match up with the existing numbering
scheme - they're all just 0, 1, 2, 3, ...

> +#define TWL6030_RATES   (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
> +#define TWL6030_FORMATS         (SNDRV_PCM_FMTBIT_S32_LE)

> +static void twl6030_power_up(struct snd_soc_codec *codec)
> +{
> +       struct snd_soc_device *socdev = codec->socdev;
> +       struct twl6030_setup_data *setup = socdev->codec_data;
> +
> +       setup->codec_enable(1);

That's interesting...?

> +       /* Capture gains */
> +       SOC_DOUBLE_TLV("Capture Preamplifier (Attenuator) Volume",
> +               TWL6030_REG_MICGAIN, 6, 7, 1, 1, mic_preamp_tlv),

No need to mention that it's an attenuator.

> +       SOC_DOUBLE_TLV("Capture Amplifier Volume",
> +               TWL6030_REG_MICGAIN, 0, 3, 4, 0, mic_amp_tlv),

Just "Capture Volume", probably.

> +static int twl6030_set_bias_level(struct snd_soc_codec *codec,
> +                               enum snd_soc_bias_level level)
> +{
> +       switch (level) {
> +       case SND_SOC_BIAS_ON:
> +               twl6030_power_up(codec);
> +               break;
> +       case SND_SOC_BIAS_PREPARE:
> +               twl6030_power_up(codec);
> +               break;
> +       case SND_SOC_BIAS_STANDBY:
> +               twl6030_power_up(codec);
> +               break;
> +       case SND_SOC_BIAS_OFF:
> +               twl6030_power_down(codec);
> +               break;

Is there any reason not to just fold these functions into the bias
management?  It looks like the only caller and it'd save jumping around
the file to find stuff.

> +static int twl6030_init(struct snd_soc_device *socdev)
> +{
> +       struct snd_soc_codec *codec = socdev->card->codec;
> +       int ret = 0;
> +
> +       dev_info(codec->dev, "TWL6030 Audio Codec init\n");

The driver should be probing as a platform device rather than using old
style registration - see wm8350 and wm8400 for examples.

> +       /* power on device */
> +       twl6030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +
> +       twl6030_init_chip(codec);

Is the the right ordering?  I'd have expected to see the one time init
stuff done prior to bringing up the power for the first time.
