Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521957;
	b=VbHzNeZxpHuDCFxrNNyEf/ClNtfG2r7S8eZoMi3f4c5f2ACAGJV/ETxjZPOHT4IhGkOm
	 nhfVPgKjHLdU96zdlRCaRYtMD7SM+x2pXiWrPlRzYfo7EhFfE5KIcLcOIgqKeNtPZMnPG
	 K/ILMgwQzd4zLNWJulurk0TkqrfAc2Le/rYKDNRLxMQQ8AAblEjLturqmLmh+q9x6+5Cs
	 uXmHByBfQwIBtzpzqH2GPAvI+MhZwF13RlIr42TRhtL+gG3dLfHRB15mh8gxY3yPGDPoc
	 wAd0YuQoRp7hSEk5hXAf9ATOn/GMA+hBZMzngtm0btVpOEvc5YXua9Ra8s7sIbBXhfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Cookie;
	bh=0ARS0v6hibJb4Knj3M+C/3JdOmgCFDQR3VObQHYAdrs=;
	b=VhpmiSqwyEKgXejoUrX73tUdfNgoD47zTMG8J5PfVoKqOKdFoZcDgZ2wX8jsyiaLLtma
	 XVy7GCJIsWaU/IPI4i6VDFi70J5LPnO+0eUbh+u1O2IizwbYbq0pk9PKvOoai64zWHPxS
	 mK5AqRkAQ2yEmoZ85PCVbHjh3mEa0nrapsLn1bNPec4DhO10BkggMnThKvGE3UoZzHhEi
	 ZjG7lsj1W5/M34/G+3WNKoWoiv3n0K064ZbiO/eBc4O1F2fh7JsUe5RDHI5mQTRANA3kF
	 7ZRTjYh3b90wm58BwXyxNl64ydgTy9TCO6IjuKsTfjrsmxvW/wc1TNqkCoThQzV1PFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtVddkaI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1E606A321;
	Tue, 24 Nov 2026 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtVddkaI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580E41F000C4;
	Tue, 24 Nov 2026 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521956;
	bh=0ARS0v6hibJb4Knj3M+C/3JdOmgCFDQR3VObQHYAdrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JtVddkaIAO32sQA+hsx1h4/JcGjCV7sOarJQrXEhjbyVDCLNYagX4d216uvTWUv3U
	 rD4Df9LCD4DyeLmzK+GOoVu4mtQZOjT5nI8gl0EytgWkEAPmIx2QBydDw3KW/BXW8d
	 fbAGUobxtTpELM6KCQyiW7y4ig0oYZQ5TbqxgqJ4OwQltVUEAhTlVGnEn9BeZ+NqOU
	 UPZz4x0WHwaPMNzMh23H3IiaBEYukjqhd7fSeN0AtlUi8PFXilT9je5n1l0u8CtbIj
	 SFlbzs7DeHznmpCEzjp6SGr0YNSkmU9+S7JkWVKSUqEmONXVDRpUEsj4x6VumlYx80
	 uY66Y0gtK2aSw==
Date: Tue, 24 Nov 2026 12:05:46 +0000
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
Subject: Re: [PATCH v2 04/20] dt-bindings: sound: pcm1754: Describe PCM1773
Message-ID: <608d13a4-6634-406e-aba8-b48114895cc0@sirena.org.uk>
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
 <a92d44c4ba920358003d475d4cac7541af037f41.1795505160.git.hns@goldelico.com>
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
	protocol="application/pgp-signature"; boundary="Lm8vroyyHW3AIhzz"
Content-Disposition: inline
In-Reply-To: <a92d44c4ba920358003d475d4cac7541af037f41.1795505160.git.hns@goldelico.com>
X-Cookie: Real Users never use the Help key.


--Lm8vroyyHW3AIhzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2026 at 08:25:44AM +0100, H. Nikolaus Schaller wrote:
> Extend the PCM1754 device tree binding to describe the related
> PCM1773 stereo DAC.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Lm8vroyyHW3AIhzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFfZoACgkQJNaLcl1U
h9DhAQf+ILG2LleXAdzUJxA3hqS5WnJ0Cy1v4TXb/eWcYXraujstqUqC/WkBrPJF
1jm5ac0s0BM2yOF8OeMd+NZTic2OwQM665medO5X0orp1gH6FtoWYSd6KUScXDYj
BLMOMa81R9qZ0Iy/7vV9aV7pyhxZvOz2qJzmDdPnFn9RMyjcz1a3rg2aMUHPA5zy
TwsfM2Aq4Gi0Z4DgJZSBxwDKqBATI8zqVX2i1F2JXbk/ajufHZtQJC4bm+WBAvx9
rzQg69Yt5QJb9kCku5+t4+97Ei5FaQm0qD3gWz8Djb+GpK+7jNTEuK9o0nac12u5
/8CFTKpyGVx0NdLYRUDx42dLwrklRA==
=oiP8
-----END PGP SIGNATURE-----

--Lm8vroyyHW3AIhzz--
