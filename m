From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v2] ASoC: Add HA (HEAD acoustics) DSP codec driver
 template
Date: Sat, 16 Aug 2014 15:49:58 +0100
Message-ID: <20140816144958.GQ28623@sirena.org.uk>
References: <1399372596-10744-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A7FgPGrDEcSmmdo/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38916 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaHPVhg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Aug 2014 17:37:36 -0400
Content-Disposition: inline
In-Reply-To: <1399372596-10744-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>, Lars-Peter Clausen <lars@metafoo.de>


--A7FgPGrDEcSmmdo/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 12:36:35PM +0200, Stefan Roese wrote:

> This codec driver template represents an I2C controlled multichannel audio

It's not really a template, it's a driver for a specific device.

Again, naming is the biggest issue here - it's going to get confusing
with a second product.  While the code is pretty clean the template
comment and the really generic name make this seem like it's more of a
placeholder for something that people will hack on to deploy than an
actual driver that someone can pick up and use.

I'm also missing any real management of the actual DSP, this appears to
only control some analogue around the DSP and a single mode switch which
is a bit odd.

> codec that has many typical ASoC codec driver features like volume controls,
> mixer stages, mux selection, output power control, in-codec audio routings,
> codec bias management and DAI link configuration.

> +static int ha_dsp_probe(struct snd_soc_codec *codec)
> +{
> +	int ret;
> +
> +	codec->control_data = dev_get_regmap(codec->dev, NULL);
> +	ret = snd_soc_codec_set_cache_io(codec, codec->control_data);
> +	if (ret != 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}

This will be done automatically by the core.

> +	snd_soc_write(codec, HA_DSP_CTRL, HA_DSP_SW_RESET);

I'd expect this to be done in the I2C level probe.

> +/*
> + * This name/ID is neded to match the DT node for the codec
> + */
> +static const struct i2c_device_id ha_dsp_i2c_id[] = {
> +	{ "ha-dsp-audio", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ha_dsp_i2c_id);

For use with DT you should have an explicit compatible string.  There's
also no binding document here that I can see.

--A7FgPGrDEcSmmdo/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT72+TAAoJELSic+t+oim9DK0P/0sCCIiuJedj4ybqqX25cFiZ
9FQlJO7BsmkqfhnM1BzDUX6mHPpR6raqYOG9JzLIYLpaS2X4A5nROSxB4KO8ime/
XkjygtPFyfSCY7rXN34WlZVJNGaw+KaaXV4MAITIOCV02KqUQULaIYlBUNxynKk8
phC00s9NhL7zSn6V8Zw3YIJlABhObakMWc+oqLgDcXPWXfTa4oErh6yst1CDUr2F
i6fEqaMUtTXYfyiQEGCczpxdJVd4Vstf+tKNMSVztNKeVUVTwSehtjkOPSZKOYEV
9V41r6WZ4R1n2ebD3YfarxdXHo/VCdlFMG+Sfn8S0uA4ptx1Eo5taXalxUB1WnRq
PyrZ653lsX3T44MlcaBnjPEo1aXkk4cxHXkD+t5adSxK3lpOGCnF+IjIbYrh9KD+
x8KQmaHJSW3riUHxn5/haPCRgIbSjbWiENPUZPrFIpEM6t6LglW4WRNhp0yv9LQv
xwllMU5JKp7G+cHfH42bkq/QWAh6wO6KQ3VYHGJI00cIpSJIgo/8HosNDG2Ysg9c
rMP3HOOTQn8gq3BHWbxIh5ClSDhaqICkfQEZOb4ekg8hVvOwYWDI7xRexzbfGjXp
E/mzuDqkMjp6m0upAp8rcTYTNqciSpBZDsQVgJPoi8ptBvTQtb4kDKHiNj3CvF89
XhERCKMewVR9yHOKEHOt
=yp7g
-----END PGP SIGNATURE-----

--A7FgPGrDEcSmmdo/--
