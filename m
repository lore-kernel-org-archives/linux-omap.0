Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D64AF69A;
	Fri, 11 Sep 2026 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154771; cv=none; b=O3fe6VghRLefIi4IFhOxqbG6Lxuz04Bi4zSYBOOX6zmvSH80ztN/YB16a57Glj5Tm1vIucDXO/t58BNAn5E5l+4XwIBozuicxE8LAMHGTcWKy+wJOuyxdl9iucs9dCnO0QBc0amOvrPXb4DPPw/VyRJl7dqjOZUDS/Ti7IewTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154771; c=relaxed/simple;
	bh=dE+o+f490yWX+XohTAQWImtcJFaNeQcze7Th761MDWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt2NcCx25fXBavRzMn4MsR307Qvra61HECxsWnxRYHveh2cEQuP8b88PgnwoE0EwJMxs0rVRih+CEMY7JIM0wQoCvmKjTX9XpWq1Lk7awx6kz4j3YtKQoLKOjl/Un1i/I9olqncQIlE9QCzv6Ecxk2xhdiLHMH99KV5XpJ1A0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr+PSViy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr+PSViy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388D01F000FF;
	Fri, 11 Sep 2026 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154765;
	bh=zwltEYL3YNdlrAP6IKVR5tGeGFPOBBkOKK5RahqTZLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hr+PSViyFYrJMGSoit0iid0wlgstQnN2Aw0vdLi8Df0yH1Sl8uz+vL3v/h/dEAZ61
	 +LQH6UC8LgKeh54qenqYP3tPy1ZM5fhHgcTvRuNDJ/ScEVU8NAWUW60fiVd3tiyww8
	 LBoUw//JCyW4/WDCRaQ/Q0BNg8QPA1DP36bASCFBwHtDfxfroQaZmMgsPJmKTb4kwt
	 vCCgjZkBA3/3+3xGP6NxDhe2Wo6tpFAuLNlZ4yytlrtOllS1I5gOtG4vtqXSfDB4co
	 GF8IueQmiCrLa2kAmNZB75e8gMd/7MZ4UysauHMXCa/r4OYGI8h2rwGxGVTxZbJko6
	 HYjUzaEbvmfcw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 698F0DAC7A8; Fri, 11 Sep 2026 20:25:20 +0100 (BST)
Date: Fri, 11 Sep 2026 20:25:20 +0100
From: Mark Brown <broonie@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Grond <grond66@riseup.net>, Stefan Leichter <sle85276@gmx.de>,
	Grazvydas Ignotas <notasas@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Sen Wang <sen@ti.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>, letux-kernel@openphoenux.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	kernel@pyra-handheld.com, mfd@lists.linux.dev
Subject: Re: [PATCH 08/16] ASoC: pcm1773-codec: write a driver for the
 PCM1773 chip from TI
Message-ID: <aqRVoOCvVwZA3uV5@sirena.org.uk>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Grond <grond66@riseup.net>, Stefan Leichter <sle85276@gmx.de>,
	Grazvydas Ignotas <notasas@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Sen Wang <sen@ti.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>, letux-kernel@openphoenux.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	kernel@pyra-handheld.com, mfd@lists.linux.dev
References: <cover.1783749722.git.hns@goldelico.com>
 <7d8989813cbd750259dfdde2e1187082493279a0.1783749722.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8VWMi9X2XTocGtq+"
Content-Disposition: inline
In-Reply-To: <7d8989813cbd750259dfdde2e1187082493279a0.1783749722.git.hns@goldelico.com>
X-Cookie: Orders subject to approval.


--8VWMi9X2XTocGtq+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 08:01:55AM +0200, H. Nikolaus Schaller wrote:
> From: Grond <grond66@riseup.net>
>=20
> This chip is used in the OpenPandora.

> +++ b/sound/soc/codecs/pcm1773.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * pcm1773.c -- codec for the simple PCM1773 output codec from TI
> + *
> + * Shamelessly cobbled together from sound/soc/ti/omap3pandora.c and a f=
ew
> + * other codec drivers in sound/soc/codecs/

Please make the entire comment a C++ one so things look more
intentional.

> +	.playback =3D {
> +		.stream_name =3D "PCM1773 IN",
> +		.channels_min =3D 2,
> +		.channels_max =3D 2,
> +		.rates =3D SNDRV_PCM_RATE_8000_48000,
> +		// [TODO] these really should be BE, per the data sheet but for
> +		// some reason the omap-mcbsp driver claims only to support LE.
> +		// investigate
> +		.formats =3D SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
> +	},

The format described here is the in memory format, not the wire format.

> +	ctx->regulator =3D devm_regulator_get(dev, "vcc");
> +	if (IS_ERR(ctx->regulator)) {
> +		dev_warn(dev, "cannot get regulator 'vcc'");
> +		ctx->regulator =3D NULL;
> +	}

This is obviously broken.  The driver should handle the error as a
normal error, not just ignore it.

--8VWMi9X2XTocGtq+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqkVZ8ACgkQJNaLcl1U
h9ANxQf+NbBkZEJZSsd9ku1cZsPpGBfxhrqMreka7Y24CMLjnIcmPGw4KRrBOcWh
rRYxpERw/bNXc0OPrSz0k4v7pUdnPmD7XL6q8smQFUqO0cAIZfkapEByQ5NNYXx/
vNSxUay1sNHex7SauqBichHdhyfPV1YSHJnPu9X2RPsbcvh60u0xvhnTlHIC8egT
wIPtdj6srM7K+biEegoal8Cvy+5koZfoyRkIHQkSbMD1JFrFDkza3XbamNhPyIlv
5mP5Lwf0erONIrnizgA3LYZjHMUb6RmtEVoiu1azEwHRv87q42R9pOeiKDQiBhnH
Gb+jZpZREv9HI5PwAFfeg4z9OuPDwQ==
=K9b0
-----END PGP SIGNATURE-----

--8VWMi9X2XTocGtq+--
