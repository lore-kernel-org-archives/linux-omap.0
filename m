From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 3/7] ASoC: TWL6030: Add twl6030 codec driver
Date: Mon, 28 Sep 2009 14:15:39 +0100
Message-ID: <20090928131539.GB31899@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391E1@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58475 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752873AbZI1NPh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Sep 2009 09:15:37 -0400
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90A391E1@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 25, 2009 at 09:03:01PM -0500, Lopez Cruz, Misael wrote:
> Initial version of TWL6030 codec driver.

> The TWL6030 codec uses a propietary PDM-based digital audio interface.
> TWL6030 codec has two power modes: low-power and high-performance,
> this initial version only supports high-performance mode.

This looks basically good.  A few pretty minor issues below.

> +       select SND_SOC_TWL6030 if TWL6030_CORE && GPIOLIB

I don't think the gpiolib dependency is needed here.  If gpiolib is not
enabled then stubs are provided which cause all the functions to error
out.  Since the driver doesn't require gpios to be specified at all this
should be fine for the purposes of SND_SOC_ALL_CODECS - it's really only
looking for a build test.

> +       /* avoid read-only registers (ASICID, ASICREV, STATUS) */
> +       for (i = 2; i < (TWL6030_VIOREGNUM - 1); i++) {
> +               reg = twl6030_vio_reg[i];
> +               twl6030_write(codec, reg, cache[reg]);
> +       }

It's not obvious how those registers are being avoided here...

> +static int twl6030_set_bias_level(struct snd_soc_codec *codec,
> +                               enum snd_soc_bias_level level)
> +{
> +       struct twl_codec_data *twl_codec = codec->control_data;
> +       struct twl6030_data *priv = codec->private_data;
> +       int audpwron_gpio = twl_codec->audpwron_gpio;
> +
> +       switch (level) {
> +       case SND_SOC_BIAS_ON:
> +       case SND_SOC_BIAS_PREPARE:
> +       case SND_SOC_BIAS_STANDBY:
> +               if (priv->codec_powered)
> +                       return 0;

This should still set codec->bias_level, as should the power off case.

> +       /* the sample lenght handled by codec at A-D and D-A
> +        * conversion is 16-bits, but the dai requires 32-bits
> +        */
> +       format = params_format(params);
> +       if (format != SNDRV_PCM_FORMAT_S32_LE) {
> +               dev_err(codec->dev, "unknown format %d\n", format);
> +               return -EINVAL;
> +       }

I suspect that for PDM you're as well just ignoring the format here and
leaving it up to the controller side of the link to worry about it.

> +static int twl6030_set_dai_fmt(struct snd_soc_dai *codec_dai,
> +                               unsigned int fmt)
> +{
> +       int format = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
> +
> +       /* propietary pdm dai format */
> +       if (format != SND_SOC_DAIFMT_PDM)
> +               return -EINVAL;
> +
> +       return 0;
> +}

May as well just leave this out if it's the only supported format and
the device doesn't have any actual configuration.
