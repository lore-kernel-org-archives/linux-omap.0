Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527502;
	b=TgHV/IPKgeWqZIzA3z9UnJi7Fafh5kCkWImENc4/iyoUBpYVW4jm3LRDjzP0mcFbyc63
	 DJSa3b9XYkuvcX+G0VvStnNO8ULoCWTWeOzve7cHcqiVmA/2U8rzFW8VEykFSWTUfx8U8
	 0OyY8h5kdo3jvpEZdc7v8kQ4IJImyqSykd1kv2VduR9Zre1XaiujlxMGbQ31wbowijlUZ
	 dkyvVbdX7K/OdWwYpfn4DEcqse6d6jTLVO3qihhy/UXGx7FSyqWK5CEeFVKvET96JyIKu
	 zuzxoGdiDOXTY6Oo/4dEUq5Ozv+oadE8Q6f6l6gb7tyVt25qEp+zpTYzXykCVzuleyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527502;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Cookie;
	bh=hBb7CziwmaEve0HjYdLhPP8A5dGN2yZ/4+i68vOpPLA=;
	b=vJuqxpx/TtiGo1GNlwXIoKnW47ZGRw8Sqd2uXwbCVuJbBERu+3bOJxqeJr/J1uocHSuw
	 Da6yHVEGPOjcCdtyBUhYJenLG2t4RN/ANWGiVK4NtMT5+3M8hPM+5G74o9e1rvC9tUd6w
	 f3vqd1mv/lq0h7By4s2Ez6AATF3szGhqeDeRNAQ0hHrspD5G1h6A3+18ZjEKoQ5LdVk3s
	 oX/uY6mZk1nXXVUwnbnmRduWRa+EVOdkWscfywwgNXz5gDvWQZNpn8sAia1sj7g+9oKYQ
	 NlRZLF9+H3b9yHDl1h36ENYDE/gN0YZ1lbOkU+B7KhXwqPZ/vjYCLuAGCNK0cdqhkCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEvA9JlK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E1606A321;
	Tue, 24 Nov 2026 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEvA9JlK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48451F000C0;
	Tue, 24 Nov 2026 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527501;
	bh=hBb7CziwmaEve0HjYdLhPP8A5dGN2yZ/4+i68vOpPLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oEvA9JlKinpj4CLa0YM6Nnu6QLmPew7urXHJpo4ZY1RapqnGsMeZoiTJ7ejlAh1wB
	 z/4fG12dJSX006iBcFfaePI0M82vQ/1lbBDsYhXFPYLKOy6787YEbjgE2NTsh2LOnd
	 YYS8P8FaEZ84WtS/L5EnxkSVgHxjjzXXJgJzz7UaNIBflVYxmWx/jPSoJ67DFMin7B
	 48FH10YLDBmkTcl4sT4odtP5IxcWGp7FR81EE+8XK88PyG8uKCTLcwZHYiH8ilxH3V
	 D8dFdk3x8iZiHSxDB1qrRh2eAI+U+TXTP3MiPubiQm0VUBtbo99xI2tQapnHz6R5jC
	 CTkpyiMWVUWdg==
Date: Tue, 24 Nov 2026 13:38:09 +0000
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
Subject: Re: [PATCH v2 00/20] ARM: omap3: pandora: Modernize audio and
 backlight to use Device Tree to finally remove pdata-quirks
Message-ID: <f31b5adb-f6e8-4cab-8d92-17645bf1b69a@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="nSbMoxGlmoiutN4J"
Content-Disposition: inline
In-Reply-To: <cover.1795505160.git.hns@goldelico.com>
X-Cookie: Real Users never use the Help key.


--nSbMoxGlmoiutN4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2026 at 08:25:40AM +0100, H. Nikolaus Schaller wrote:
> PATCH V2 2026-11-24 08:26:00:
> Changes in V2:
> The series has been reworked and expanded from 16 to 20 patches,
> addressing review feedback and issues identified during hardware testing.

> Audio and power management:
> ===========================

> PWM and backlight:
> ==================

> Device Tree and general cleanup:
> ================================

This is dealing with several tangentially related topics over multiple
subsystems in a single series, this makes it a lot less digestable and
results in a huge series with an extremely large CC list and murky merge
strategy.  Please split things out into separate serieses, even within
the various subsystems there are batches of independent work which
really do not need to be in the same series.

--nSbMoxGlmoiutN4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFk0AACgkQJNaLcl1U
h9C5/gf8Cm0A5yFYJVQeo/T7StRW0pHrKh1EmIz06r7u8NK09DP+BhXT8qRk1I41
F7QT+nveX8OD+3Wz+Zyw7iAN7DdNLpIpci7jqzm/9hHAIeCU9h5mbXgGLRZXlLLy
MJ/MIEGdSDswMSbHdd1qbOAph080P7loJJrXcVFvWHRwH6+Gc6umpSBfu7uLM+D0
W+mM6fRvvz0Ou0YBcV+gvdp/18n0MiQ11v7dn3UsQaFHkJfTZzKZh6WOuUZ3JdKr
H1DtRqRYCJooQcaZpUWdRGDHEAMHXgW1+o7r3gEfGTklbsyY+xeOhXEBbU7jQLjd
SS7bE1b2Y0pMX5XKGAjMXMyqtG/2dg==
=LtHo
-----END PGP SIGNATURE-----

--nSbMoxGlmoiutN4J--
