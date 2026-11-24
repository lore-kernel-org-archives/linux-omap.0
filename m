Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521887;
	b=4KkthwvzqiM6u/9O7fAH3ZPTDVQjzyi/ctXTkHxMz9YAgkLV3HT7AcIvCUkH0N301ikj
	 tLPbvi1WSj4LindQ7ohK4R+4bMlpZHYYJA3aKLf18a/+j8Ql4svuG2ADrge0OyXqbtnFK
	 TPLPgi2JCLftXCY2Cu1V97ggblsKSOnApEcv2e6JOaOYYQYyJ6fuSvaRAISq1Pp6qjdIo
	 WYDGHHn1QKVF2yRaLTq1dOgUo+k5MYzWpJaieYc0aoy2EEVVnJ9ppgYlCBEd3ysZ3hIvS
	 KMDiSs8d94UhJvRJB/qh0COIedxj/R8Y0YUagjUX06kB/tiisum5uJ2jvatKTPyYbKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521887;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Cookie;
	bh=+M6+ZCCIkRa8fbkv07qcInuQEah/247vguNP+jafsWQ=;
	b=NC66W1KX8wXFHVtdAj3LER7K4IeDAo9ozQYcn4uTIuJrIwPQ5rOpjw6QN+zLfjEhxACE
	 Lxur372CAgyFEdN8hPB+ryB4Rfc9kkCpEJPdZZgmmFNxGtijTmGDDoGWMODI2Up93ZURt
	 8TYftHgd2VPEjA6G99mXuo3RqRufmCMB6GdR1E1/01mZ22dCRsUgvQQwGxa4HwPIVCRu5
	 8TKwG6XwZ0SNynJ606xR+p8ilhLB6BRF+UBKoofwFtfiBgGKnGVn2QOJtaffZMqhasnO9
	 ViW90Qgl4596eR6mF2FvrlCb3BgB+OSHeyhuZ9hHriCnx2y0VllTYAArFzYaNkYiQcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1MQfmss;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A53606A33B;
	Tue, 24 Nov 2026 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1MQfmss
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7681F000C4;
	Tue, 24 Nov 2026 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521886;
	bh=+M6+ZCCIkRa8fbkv07qcInuQEah/247vguNP+jafsWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m1MQfmssaNaFtc2SVz5nm/8E4cRYpNtMQ1cfMrhMdc+T1BG1aSt2apFBSZdnv6vPx
	 6L1q8khrbGMvY5L0M7E7qsYlVXMyI7sGvJ8kEE9bf5ePqJ4O74P7VfQMedAKwYRXW4
	 3mADxW91HRgPZhtIpXt+3VsMHdljHhACgYJVI49jePIy5MWIcAR1WwXTbUchILrB8C
	 oiZZxvm27YiNGscVwU46MoKKDeSe/bp2BbiLG8HPTlNHf/Y88m0/2LbJKMEoaWwkwb
	 gAKUZce9JKX+iTA1Ja7f4ueDrb9YUPdQDlcbqKqjSn/+TPw2tZdcTQuDD0/s8MP5ga
	 5DEf4DbTpUh3A==
Date: Tue, 24 Nov 2026 12:04:36 +0000
From: Mark Brown <broonie@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Helge Deller <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
	letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v2 06/20] dt-bindings: sound: Document OpenPandora sound
 card
Message-ID: <271fc308-817e-43eb-872e-67cf4e342c00@sirena.org.uk>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Helge Deller <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
	letux-kernel@openphoenux.org, kernel@pyra-handheld.com
References: <cover.1795505160.git.hns@goldelico.com>
 <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uuPL/vWJ8gpBO2/v"
Content-Disposition: inline
In-Reply-To: <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
X-Cookie: Real Users never use the Help key.


--uuPL/vWJ8gpBO2/v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2026 at 08:25:46AM +0100, H. Nikolaus Schaller wrote:
> The OpenPandora audio subsystem describes the routing links between the
> OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 audio
> codec, alongside amplifiers and power supplies.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--uuPL/vWJ8gpBO2/v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFfVMACgkQJNaLcl1U
h9A/9wf/bewyPvKKERGxwebE/8gZWsJyo/QfqgyTiJAAEhPRC9n66F8TduLm/PaK
JzYBcXrO+BemacpAPeAAFowFxoyvCP8YAp8yrvh4DJh5qcLAenIvMXFmmo8tCjjy
HBONuyEzrD2hRre4lCtzRG3utxWZtlV1vo6aR2dYOvxEj/xTKVlJuAqHmo+8nWBE
FnZwgc83dKFND8t6kl30S/hRu3ttiV7gVknY4JlXJ6Gu00lvaN2DaLl3cfRRn3xM
Df3t1SC938uezOlyU0AUZzmGgxbttqnFLSDybQDCn3G8mTV6LWGRGFKpPQ/TFmbJ
wENvF5OUuKyp84S4bCZhzspjeM1UEg==
=Nj9l
-----END PGP SIGNATURE-----

--uuPL/vWJ8gpBO2/v--
