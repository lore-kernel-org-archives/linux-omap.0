Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9752E2DD2;
	Sat, 25 Jul 2026 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941815; cv=pass; b=ugVoNg+4h4Z0vHHBIbLE1O9eBXYJphCz4F0lx9wlk6iYAvyTP5Vn5I0oevBbih1lfWSX668UcsJmkE0VeQr0v2d3uN1pYJTQ5+Mt1rS4URqJ4SwfN8rG7t3wEBktX6VMAl0K5eErWwTyjGg4zEPh4n14w0F1WWIIZ4/o+JOF2Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941815; c=relaxed/simple;
	bh=af19IvVnCUabwx+aFfQC6n2d10QvCEEvG0pcfJnknBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAfOsZOF1kSAnrEO+lzPN7nMCuQwue4wIzk5zxM6xYxwbFw20Xss0bi+qQ00wo1b8KsT3vR8c7e9fW5IlOvVh4Uo99kFL5u6gbEAHZdxdxqdr7wALD2VJgna89/7dRkUq2UoIAEMxGO/bI1+J3lofLWmSsk6Cf9FE07iQ09m2WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=JXd3v9mb; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="JXd3v9mb"
ARC-Seal: i=1; a=rsa-sha256; t=1784941783; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FSTLfDPHo1BsxztzHiH83qR6oQT2hQz1IlaTs/Qih4RpHMddrFMSLHsIdokcGP33UMuwp/mdlCuv2wbjEpUqZWyioHwHXbJFv8iXOhQUzTa5B/5ke2exF/c7HvdxQD3SIl7wGckrJ13Ela43SiH8Dk/T9p66phdvYvLZsfHs6gM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784941783; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PTMI8gyIZJaUVfvOt9/O3jul7b1sSfGr5TgMSZNMVyo=; 
	b=UOQoPNLP6EgozuVjSQ7O2HQ3kw/WCz7P3wHkdm1Klt20Bor8+B+sRcf4YEV+OIBw4C6gra85QeonqVK/u7GVHp8QgQdITRDCIMoWocTQCWYfjgi1BnJq9lT7Z5HI4ryUg+y1esKuYAeGI5SPVfMpevG5W1HnICuB6IemQoCmXME=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784941783;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=PTMI8gyIZJaUVfvOt9/O3jul7b1sSfGr5TgMSZNMVyo=;
	b=JXd3v9mbZhaPjZnhU+9ckjcJEVV0O0M05dSIhj7moaFSgA+xWgHW6j09ly/fuvm3
	hNsYI4VBsy9rHmBymRQtfVDg3zjJmDOXdaXP3PPnBKYxzk9ClnkzjuIuPVLSSKL78qW
	ra/82XbNJCmp3e9jya27xtDjXwuw5OcVL+KLVIJ4=
Received: by mx.zohomail.com with SMTPS id 1784941781475626.0445496767242;
	Fri, 24 Jul 2026 18:09:41 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id DEF02181F17; Sat, 25 Jul 2026 03:09:37 +0200 (CEST)
Date: Sat, 25 Jul 2026 03:09:37 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: ti: omap-twl4030: drop support for platform
 data
Message-ID: <amQMsPAeErtOa6NU@venus>
References: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="so67j757oqyrqzxh"
Content-Disposition: inline
In-Reply-To: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.919.37
X-ZohoMailClient: External


--so67j757oqyrqzxh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] ASoC: ti: omap-twl4030: drop support for platform
 data
MIME-Version: 1.0

Hi,

On Fri, Jul 24, 2026 at 04:34:29PM -0700, Dmitry Torokhov wrote:
> There are no users of omap_tw4030_pdata in the mainline kernel so
> remove support for it from the driver.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  include/linux/platform_data/omap-twl4030.h |  42 -------
>  sound/soc/ti/omap-twl4030.c                | 134 +++++++--------------
>  2 files changed, 44 insertions(+), 132 deletions(-)
>  delete mode 100644 include/linux/platform_data/omap-twl4030.h
>=20
> diff --git a/include/linux/platform_data/omap-twl4030.h b/include/linux/p=
latform_data/omap-twl4030.h
> deleted file mode 100644
> index 7fcb55fe21c9..000000000000
> --- a/include/linux/platform_data/omap-twl4030.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> - * omap-twl4030.h - ASoC machine driver for TI SoC based boards with twl=
4030
> - *		    codec, header.
> - *
> - * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com
> - * All rights reserved.
> - *
> - * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> - */
> -
> -#ifndef _OMAP_TWL4030_H_
> -#define _OMAP_TWL4030_H_
> -
> -/* To select if only one channel is connected in a stereo port */
> -#define OMAP_TWL4030_LEFT	(1 << 0)
> -#define OMAP_TWL4030_RIGHT	(1 << 1)
> -
> -struct omap_tw4030_pdata {
> -	const char *card_name;
> -	/* Voice port is connected to McBSP3 */
> -	bool voice_connected;
> -
> -	/* The driver will parse the connection flags if this flag is set */
> -	bool	custom_routing;
> -	/* Flags to indicate connected audio ports. */
> -	u8	has_hs;
> -	u8	has_hf;
> -	u8	has_predriv;
> -	u8	has_carkit;
> -	bool	has_ear;
> -
> -	bool	has_mainmic;
> -	bool	has_submic;
> -	bool	has_hsmic;
> -	bool	has_carkitmic;
> -	bool	has_digimic0;
> -	bool	has_digimic1;
> -	u8	has_linein;
> -};
> -
> -#endif /* _OMAP_TWL4030_H_ */
> diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
> index 4d80f8a7a947..950879fc7275 100644
> --- a/sound/soc/ti/omap-twl4030.c
> +++ b/sound/soc/ti/omap-twl4030.c
> @@ -17,7 +17,6 @@
>   */
> =20
>  #include <linux/platform_device.h>
> -#include <linux/platform_data/omap-twl4030.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> =20
> @@ -133,20 +132,12 @@ static struct snd_soc_jack_gpio hs_jack_gpios[] =3D=
 {
>  	},
>  };
> =20
> -static inline void twl4030_disconnect_pin(struct snd_soc_dapm_context *d=
apm,
> -					  int connected, char *pin)
> -{
> -	if (!connected)
> -		snd_soc_dapm_disable_pin(dapm, pin);
> -}
> -
>  static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct snd_soc_card *card =3D rtd->card;
> -	struct snd_soc_dapm_context *dapm =3D snd_soc_card_to_dapm(card);
> -	struct omap_tw4030_pdata *pdata =3D dev_get_platdata(card->dev);
> +
>  	struct omap_twl4030 *priv =3D snd_soc_card_get_drvdata(card);
> -	int ret =3D 0;
> +	int ret;
> =20
>  	/*
>  	 * This is a bit of a hack, but the GPIO is optional so we
> @@ -170,29 +161,7 @@ static int omap_twl4030_init(struct snd_soc_pcm_runt=
ime *rtd)
>  			return ret;
>  	}
> =20
> -	/*
> -	 * NULL pdata means we booted with DT. In this case the routing is
> -	 * provided and the card is fully routed, no need to mark pins.
> -	 */
> -	if (!pdata || !pdata->custom_routing)
> -		return ret;
> -
> -	/* Disable not connected paths if not used */
> -	twl4030_disconnect_pin(dapm, pdata->has_ear, "Earpiece Spk");
> -	twl4030_disconnect_pin(dapm, pdata->has_hf, "Handsfree Spk");
> -	twl4030_disconnect_pin(dapm, pdata->has_hs, "Headset Stereophone");
> -	twl4030_disconnect_pin(dapm, pdata->has_predriv, "Ext Spk");
> -	twl4030_disconnect_pin(dapm, pdata->has_carkit, "Carkit Spk");
> -
> -	twl4030_disconnect_pin(dapm, pdata->has_mainmic, "Main Mic");
> -	twl4030_disconnect_pin(dapm, pdata->has_submic, "Sub Mic");
> -	twl4030_disconnect_pin(dapm, pdata->has_hsmic, "Headset Mic");
> -	twl4030_disconnect_pin(dapm, pdata->has_carkitmic, "Carkit Mic");
> -	twl4030_disconnect_pin(dapm, pdata->has_digimic0, "Digital0 Mic");
> -	twl4030_disconnect_pin(dapm, pdata->has_digimic1, "Digital1 Mic");
> -	twl4030_disconnect_pin(dapm, pdata->has_linein, "Line In");
> -
> -	return ret;
> +	return 0;
>  }
> =20
>  /* Digital audio interface glue - connects codec <--> CPU */
> @@ -237,11 +206,15 @@ static struct snd_soc_card omap_twl4030_card =3D {
> =20
>  static int omap_twl4030_probe(struct platform_device *pdev)
>  {
> -	struct omap_tw4030_pdata *pdata =3D dev_get_platdata(&pdev->dev);
> -	struct device_node *node =3D pdev->dev.of_node;
>  	struct snd_soc_card *card =3D &omap_twl4030_card;
> +	struct device_node *node, *dai_node;
>  	struct omap_twl4030 *priv;
> -	int ret =3D 0;
> +	struct property *prop;
> +	int ret;
> +
> +	node =3D pdev->dev.of_node;
> +	if (!node)
> +		return -ENODEV;
> =20
>  	card->dev =3D &pdev->dev;
> =20
> @@ -249,62 +222,43 @@ static int omap_twl4030_probe(struct platform_devic=
e *pdev)
>  	if (priv =3D=3D NULL)
>  		return -ENOMEM;
> =20
> -	if (node) {
> -		struct device_node *dai_node;
> -		struct property *prop;
> -
> -		if (snd_soc_of_parse_card_name(card, "ti,model")) {
> -			dev_err(&pdev->dev, "Card name is not provided\n");
> -			return -ENODEV;
> -		}
> -
> -		dai_node =3D of_parse_phandle(node, "ti,mcbsp", 0);
> -		if (!dai_node) {
> -			dev_err(&pdev->dev, "McBSP node is not provided\n");
> -			return -EINVAL;
> -		}
> -		omap_twl4030_dai_links[0].cpus->dai_name  =3D NULL;
> -		omap_twl4030_dai_links[0].cpus->of_node =3D dai_node;
> -
> -		omap_twl4030_dai_links[0].platforms->name  =3D NULL;
> -		omap_twl4030_dai_links[0].platforms->of_node =3D dai_node;
> -
> -		dai_node =3D of_parse_phandle(node, "ti,mcbsp-voice", 0);
> -		if (!dai_node) {
> -			card->num_links =3D 1;
> -		} else {
> -			omap_twl4030_dai_links[1].cpus->dai_name  =3D NULL;
> -			omap_twl4030_dai_links[1].cpus->of_node =3D dai_node;
> -
> -			omap_twl4030_dai_links[1].platforms->name  =3D NULL;
> -			omap_twl4030_dai_links[1].platforms->of_node =3D dai_node;
> -		}
> -
> -		/* Optional: audio routing can be provided */
> -		prop =3D of_find_property(node, "ti,audio-routing", NULL);
> -		if (prop) {
> -			ret =3D snd_soc_of_parse_audio_routing(card,
> -							    "ti,audio-routing");
> -			if (ret)
> -				return ret;
> -
> -			card->fully_routed =3D 1;
> -		}
> -	} else if (pdata) {
> -		if (pdata->card_name) {
> -			card->name =3D pdata->card_name;
> -		} else {
> -			dev_err(&pdev->dev, "Card name is not provided\n");
> -			return -ENODEV;
> -		}
> -
> -		if (!pdata->voice_connected)
> -			card->num_links =3D 1;
> -	} else {
> -		dev_err(&pdev->dev, "Missing pdata\n");
> +	if (snd_soc_of_parse_card_name(card, "ti,model")) {
> +		dev_err(&pdev->dev, "Card name is not provided\n");
>  		return -ENODEV;
>  	}
> =20
> +	dai_node =3D of_parse_phandle(node, "ti,mcbsp", 0);
> +	if (!dai_node) {
> +		dev_err(&pdev->dev, "McBSP node is not provided\n");
> +		return -EINVAL;
> +	}
> +	omap_twl4030_dai_links[0].cpus->dai_name  =3D NULL;
> +	omap_twl4030_dai_links[0].cpus->of_node =3D dai_node;
> +
> +	omap_twl4030_dai_links[0].platforms->name  =3D NULL;
> +	omap_twl4030_dai_links[0].platforms->of_node =3D dai_node;
> +
> +	dai_node =3D of_parse_phandle(node, "ti,mcbsp-voice", 0);
> +	if (!dai_node) {
> +		card->num_links =3D 1;
> +	} else {
> +		omap_twl4030_dai_links[1].cpus->dai_name  =3D NULL;
> +		omap_twl4030_dai_links[1].cpus->of_node =3D dai_node;
> +
> +		omap_twl4030_dai_links[1].platforms->name  =3D NULL;
> +		omap_twl4030_dai_links[1].platforms->of_node =3D dai_node;
> +	}
> +
> +	/* Optional: audio routing can be provided */
> +	prop =3D of_find_property(node, "ti,audio-routing", NULL);
> +	if (prop) {
> +		ret =3D snd_soc_of_parse_audio_routing(card, "ti,audio-routing");
> +		if (ret)
> +			return ret;
> +
> +		card->fully_routed =3D 1;
> +	}
> +
>  	snd_soc_card_set_drvdata(card, priv);
>  	ret =3D devm_snd_soc_register_card(&pdev->dev, card);
>  	if (ret) {
> --=20
> 2.55.0.229.g6434b31f56-goog
>=20
>=20

--so67j757oqyrqzxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpkDM0ACgkQ2O7X88g7
+ppQlA/9Grjih9lj61FY/M77Qhsm/xs3mjxhcl/qX+4I0aDD3ZyaNoGDnys+5kzT
xFS0e0x0pLH2Sh4haACnQlWmYqTbQSaCDrG4fkjU1VHuHErU/7EUIOEyNyLHv/UG
Ud5qoDP2BHl6XnVMK78zzhsnQmOrjipv1Wa7Pyr7VaH5Vf/3Hdl/u5Nxb0xRHRYH
FvrfResG3tzo6MdFpBcI6j3TUiFbyS9Rzmfz55rxX0/wv/4e3R/F9ONk2kVftdBw
Jf3cCbZiBkO32JGdlzF+HdmnEU+FAQ2FcPvaP1HlAuGcAlUauK3sY07Ppq6zRzyh
S/QVtuBjBA9dJ6kl99s6vlSvKN9FCHxePmBP4apNBE6F9/pytL4VFNgqtSQ2xn0x
bsTM3qnChIOJNSuNhNzswebNgc+F3slP56JDg96ad2lpfM14Ow1MuBOcn0/e7uA4
SYcqJjbjyrSh7XFmxKl3VMiSSzKbzvI4qNgBzitPgiehopYN1TFlbLDMNJjh0xBO
Of5tWyvRUew5fAro3L3/14tQlBkqfnYHF/u4p41hxfJoTs5iCVQwQ7zVAkh0I9d6
8vA/XbKoBEG9AzMpI2+xbEs/hRT8+vOdV0v9YZrl24GnzxS3DgYCq5UZIcgYlQoi
Pw6mgZ/V7gmtvvGiPXlBf8MA0n5Npd6zXrxDkdEtorjjQQc6I04=
=Weu5
-----END PGP SIGNATURE-----

--so67j757oqyrqzxh--
