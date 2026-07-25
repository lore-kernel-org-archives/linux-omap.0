Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921930DED1;
	Sat, 25 Jul 2026 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941835; cv=pass; b=hKloglg4+7JJRuKd20S73A63hRxAp18vAf/xLmjKy+MOaMOMNLFTEH2vyy5By+0FeMv8nPhbcMjCuPppKOJ6PHppe1E9/PFneK4gNsbuE265bz9YZ7kS1DwUBFlG57EpuXCihU0TMEKOz1oenLTdrI8X9EBe7NjSNUaIj7ulKWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941835; c=relaxed/simple;
	bh=054yeHR5ga2Rc5SeHVWwbxcCor09HbEuVvQ3jOtr9Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk4Md9sqFNNOiiWiiUf9nUYCdaEEgxpv6xm1mu4mdHGAY/iZ5o1FsreTfomB5s5OVDajdmwlM5eyNYi67FxgCJSYmWFcaT7KSG+2gY2Rh2Pt+UAOTWCrCvzrmptCGzsfYr4EKH2wIGRMB0slKo0b+ORMbLlW6kCADvhHRPD3yT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=TX4ZJIDU; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="TX4ZJIDU"
ARC-Seal: i=1; a=rsa-sha256; t=1784941815; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EdlawwZ8YJwQqpNhf8Lki3U+ZpqOzb6t+Z94+qJ152PzRDn6+ilztEfoZpx2WeuvXQxXzch6K7Xp/lGhJAX9wlJhgQfz+jLJHhAnJGa9r+WCLXFjhZ16L7R/3Lq9hDrxzeTFlDC49cE92WbGST4O8nf84S0oEy0yzM+Lo3wlGQo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784941815; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=n35ozwz3e7ikDeOGjdSijBDADCz0XuT+ksuNlq4i3+A=; 
	b=ioebfY581HfvkBRHYP5mKp7JXix8I2bzKLORbeUbsDEyWJWmg9lsRzX4GYGv9WgYsEhUimzQNlhwT/aO+PoWlvlQN1Xl8S+34pZJD6WXYTKWqym+IjMYPUQFcgfc5IE0Le7ATpU4e1miIPtYr3pptMRestIW0xyNiq6FN30HbZo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784941815;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=n35ozwz3e7ikDeOGjdSijBDADCz0XuT+ksuNlq4i3+A=;
	b=TX4ZJIDUyLokmw6kKyBmaz7zH1/YZGUjqp/+DF2GcgVXegYY8q/AaG8Xv8iFmzEz
	Ri3VXxch9yTBgE90VGAVX3v0JBQ7+btc5eG9VxJjZIYkCSjJWgd9Wmr6cGD3m5grat5
	P7mPECiKIuzoA+hqRpYbKrL6r3TsuZPvDaepeS20=
Received: by mx.zohomail.com with SMTPS id 1784941813271995.6317125823019;
	Fri, 24 Jul 2026 18:10:13 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id CA68F181F17; Sat, 25 Jul 2026 03:10:09 +0200 (CEST)
Date: Sat, 25 Jul 2026 03:10:09 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: ti: omap-twl4030: use per-device instance of
 headset jack gpio
Message-ID: <amQM056GAKZzudvp@venus>
References: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
 <20260724233432.31325-2-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3uipsqb5lgyeoyy"
Content-Disposition: inline
In-Reply-To: <20260724233432.31325-2-dmitry.torokhov@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.919.37
X-ZohoMailClient: External


--o3uipsqb5lgyeoyy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] ASoC: ti: omap-twl4030: use per-device instance of
 headset jack gpio
MIME-Version: 1.0

Hi,

On Fri, Jul 24, 2026 at 04:34:30PM -0700, Dmitry Torokhov wrote:
> hs_jack_gpios is being potentially shared among several instances of the
> same device, and is being modified. This is not the best approach to
> structuring the code (even if the device is in fact a singleton).
> Change it to allocate a per-device instance.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  sound/soc/ti/omap-twl4030.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
> index 950879fc7275..4abcfff04bc7 100644
> --- a/sound/soc/ti/omap-twl4030.c
> +++ b/sound/soc/ti/omap-twl4030.c
> @@ -28,6 +28,7 @@
>  #include "omap-mcbsp.h"
> =20
>  struct omap_twl4030 {
> +	struct snd_soc_jack_gpio hs_jack_gpio;
>  	struct snd_soc_jack hs_jack;
>  };
> =20
> @@ -123,15 +124,6 @@ static struct snd_soc_jack_pin hs_jack_pins[] =3D {
>  	},
>  };
> =20
> -/* Headset jack detection gpios */
> -static struct snd_soc_jack_gpio hs_jack_gpios[] =3D {
> -	{
> -		.name =3D "ti,jack-det",
> -		.report =3D SND_JACK_HEADSET,
> -		.debounce_time =3D 200,
> -	},
> -};
> -
>  static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct snd_soc_card *card =3D rtd->card;
> @@ -144,9 +136,6 @@ static int omap_twl4030_init(struct snd_soc_pcm_runti=
me *rtd)
>  	 * only want to add the jack detection if the GPIO is there.
>  	 */
>  	if (of_property_present(card->dev->of_node, "ti,jack-det-gpio")) {
> -		hs_jack_gpios[0].gpiod_dev =3D card->dev;
> -		hs_jack_gpios[0].idx =3D 0;
> -
>  		ret =3D snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
>  						 SND_JACK_HEADSET,
>  						 &priv->hs_jack, hs_jack_pins,
> @@ -154,9 +143,14 @@ static int omap_twl4030_init(struct snd_soc_pcm_runt=
ime *rtd)
>  		if (ret)
>  			return ret;
> =20
> -		ret =3D snd_soc_jack_add_gpios(&priv->hs_jack,
> -					     ARRAY_SIZE(hs_jack_gpios),
> -					     hs_jack_gpios);
> +		priv->hs_jack_gpio.name =3D "ti,jack-det";
> +		priv->hs_jack_gpio.report =3D SND_JACK_HEADSET;
> +		priv->hs_jack_gpio.debounce_time =3D 200;
> +		priv->hs_jack_gpio.gpiod_dev =3D card->dev;
> +		priv->hs_jack_gpio.idx =3D 0;
> +
> +		ret =3D snd_soc_jack_add_gpios(&priv->hs_jack, 1,
> +					     &priv->hs_jack_gpio);
>  		if (ret)
>  			return ret;
>  	}
> --=20
> 2.55.0.229.g6434b31f56-goog
>=20
>=20

--o3uipsqb5lgyeoyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpkDPEACgkQ2O7X88g7
+ppQJw//TjvNcLnNPlKJxNOMs105YOn3lsiqZzRORHpJrrRyiOUViVmi06WW/+rT
a+0D1/d6JElwDXTVY+4B1ngW5RTB+HH9U5rv1mzIFsf+F5GNcBv1DgI51QsAL88M
71F+t9Ozm3f/5ycAdFVpE7niOJAorYJLAdsv80KXHCSaeNl79WyFrNhLDvuFc8x/
nuvVrZbxZZe4ewM4a+2hEwN/hB/JyjgWynXtpUDB3qhaOcQNwdhPI/hk8otPVYQf
oV4wfRL6MD4Yba5mj4+waBF/GkG125+WgnnxdEytE8Wkemvavpl8zj8JC+ofPZ7/
/chRwnTeUNpq1FGdWSJpLBrF9FOVEPti0ZpGqzSnhQqwm2/2zV+iuri6Zs75s/a7
RRqcBuV1G/+6gZ80VELD1tX4fqmXQdxilxmWZpYaVt79MkSvbsmf8/n4t+0+xOgq
hfxePDL5gsLgJqt7fb3AilIhpdijxsiJnWF7b4lgilDWZoI701XVSUTbmh5EYRLc
n8EimKCJ/TJjx1YI9HK5bzXtbIkeudYdu5uP0cVcTzY2YqOdFrxfd9sEOvH/xv29
vbkRaeB32tKT8GIo7F/nA6QBl5FLY35cQl2bf8XD9Q4J9j7L3CR4NRE4Bmyu1S8Q
TVs91dV7Yv8/h6oRPrg5hfXORktXQiDJfzY1lI3tMlZ+w6b5CYg=
=6q2z
-----END PGP SIGNATURE-----

--o3uipsqb5lgyeoyy--
