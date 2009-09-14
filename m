From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: TWL6030: Add support for low-power mode
Date: Mon, 14 Sep 2009 18:25:21 +0100
Message-ID: <20090914172521.GB2481@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90432708@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35874 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751242AbZINRZS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Sep 2009 13:25:18 -0400
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90432708@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>

On Mon, Sep 14, 2009 at 12:00:34PM -0500, Lopez Cruz, Misael wrote:

> +static int twl6030_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
> +				unsigned int freq_in, unsigned int freq_out)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct twl6030_priv_data *twl6030_priv = codec->private_data;
> +	int div;
> +
> +	if (!freq_in || !freq_out)
> +		return -EINVAL;

This is normally supported in order to allow the PLL to be stopped for
power saving - an output of zero means turn the PLL off.

> +	twl6030_priv = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
> +	if (twl6030_priv == NULL) {
> +		ret = -ENOMEM;
> +		goto priv_err;
> +	}

The sizeof() looks wrong here, especially given that you're not actually
embedding the snd_soc_codec in the private data (though that's a good
idea to save doing two allocations).

>  /* LPPLLCTL (0x08) fields */
>  
>  #define TWL6030_LPLLENA			0x01
>  #define TWL6030_LPLLRST			0x02
>  #define TWL6030_LPLLSEL			0x04
> -#define TWL6030_FIN			0x08
> +#define TWL6030_LPLLFIN			0x08
>  #define TWL6030_HPLLSEL			0x10

I guess that should be squashed into the first patch?
