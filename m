From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: tlv320aic31xx: Add basic codec driver
 implementation
Date: Mon, 10 Mar 2014 12:58:48 +0000
Message-ID: <20140310125848.GI28112@sirena.org.uk>
References: <cover.1394440470.git.jsarha@ti.com>
 <dc68ce35a3f44b5c8a55be928e06f72f463338fa.1394440470.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l118U0+vX1D/6gtA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45921 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbaCJM66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 08:58:58 -0400
Content-Disposition: inline
In-Reply-To: <dc68ce35a3f44b5c8a55be928e06f72f463338fa.1394440470.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com


--l118U0+vX1D/6gtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 10:52:21AM +0200, Jyri Sarha wrote:

> +- ai31xx-micbias-vg - MicBias Voltage setting
> +        0 or MICBIAS_OFF - MICBIAS output it not powered

So, on every other version of this patch set I've suggested removing
this as there's no reason why the bias would be wired up but disabled.
Each time you seem to agree that the option should be removed yet here
it is again...

> +static int aic31xx_dapm_power_event(struct snd_soc_dapm_widget *w,
> +				    struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(w->codec);
> +	unsigned int reg = AIC31XX_DACFLAG1;
> +	unsigned int mask;
> +
> +	dev_dbg(w->codec->dev, "%s -> %s (event: %d)\n", w->name,
> +		event == SND_SOC_DAPM_POST_PMU ? "on" :
> +		event == SND_SOC_DAPM_POST_PMD ? "off" :
> +		"(unsupported event)", event);

The core should already be logging well enough for this.

> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		return aic31xx_wait_bits(aic31xx, reg, mask, mask, 5000, 100);
> +	case SND_SOC_DAPM_POST_PMD:
> +		return aic31xx_wait_bits(aic31xx, reg, mask, 0, 5000, 100);
> +	}
> +
> +	dev_dbg(w->codec->dev, "Unhandled dapm widget event %d from %s\n",
> +		event, w->name);

switch with a default would be more idiomatic here.

> +static int aic31xx_add_controls(struct snd_soc_codec *codec)
> +{
> +	int err = 0;
> +	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
> +
> +	if (aic31xx->pdata.codec_type & AIC31XX_STEREO_CLASS_D_BIT) {
> +		err = snd_soc_add_codec_controls(
> +			codec, aic311x_snd_controls,
> +			ARRAY_SIZE(aic311x_snd_controls));
> +		if (err < 0)
> +			dev_dbg(codec->dev, "Invalid control\n");
> +
> +	} else {
> +		err = snd_soc_add_codec_controls(
> +			codec, aic310x_snd_controls,
> +			ARRAY_SIZE(aic310x_snd_controls));
> +		if (err < 0)
> +			dev_dbg(codec->dev, "Invalid Control\n");
> +	}

Those error messages are real errors - you should print them out and
also return the error code.  Similarly for DAPM.

> +	if (event & REGULATOR_EVENT_DISABLE) {
> +		/*
> +		 * Put codec to reset and as at least one of the
> +		 * supplies was disabled. It may be to late to try
> +		 * soft reset, but it should not do any harm.
> +		 * Resetting the codec helps in minimizing leakage
> +		 * in case some of the regulators remains turned on.
> +		 */
> +		if (gpio_is_valid(aic31xx->pdata.gpio_reset))
> +			gpio_set_value(aic31xx->pdata.gpio_reset, 0);
> +		else
> +			snd_soc_write(aic31xx->codec, AIC31XX_RESET, 0x01);

I'd expect this write may fail (potentially loudly and annoyingly) if
the device really has just had its power pulled.

--l118U0+vX1D/6gtA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHbcFAAoJELSic+t+oim9CEoP/15Gz0UWzSdGips1z8ng8mpy
28SUqa5w/9/gAjJFbojJdH3vyQn/wJ2ii4Va2rGHrpKaB6fxBFiISsPSeBEebi+E
vk1xbIwyi4WE9wfVR1ue+/D44kchb8KszcxYdlcaumRdzCH6r9cKpHvsgy04Yd3y
rxl6lkr2KF8ue59DgcVpQ0LlWbKpDqfhKaQgGHCx4ogUq2sRyONPelXMTFRvS5zs
396WD+1pC1MT+DAHGANaKVRYfU/uHNVqT2SlBZydzt/SPmJU5RMKvvxapmkWYx0C
e/C8p6qMnXe0K++lx8jLPXoQBGQQbCIq2G99zWe9R8q9O83yZOFMl3RWtn5pGPDc
WKdvrzwErnQw2xrRZ8zZrMy1SGrP6Ai7aQVAXs2w7yCq0/XWqYHz6iWZpKIIfKRz
X63fYk9Rhb+xAeM6BE5ZSIDCQueZqBA1il32G+rk+pIVOUiBmFyL7BDfbNqA5jRj
QhosHKzzvdKM0nfa5iFCsPLtZtEq2nqAYXC9pjBfluPSaSFjEhL4R4EK9hqpzfpa
kRodGKYQBAKx9FdHdYVI3+X1kaGUiSL7r5aMNrrdAHd0yJDokzxDm+GJVnePkbVF
OfwB3/nOikvELFZRY8QUP/puexMXbY0K5d4V5Gzdscw8zPgBCb0uO6SFjOEK8pDQ
4PbJA9sfCvGAssCGQJ2i
=WSkA
-----END PGP SIGNATURE-----

--l118U0+vX1D/6gtA--
