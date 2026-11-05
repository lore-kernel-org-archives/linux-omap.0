Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876803;
	b=3Uu4xaFO4+4Dww2rQjdUZ8qFGGiWSvL8OpTVqYBxWxkIEPKb6v0Z6L3rHhe0SLaI5rby
	 0aBwzOId6zZ3hAGfdvH8+Sl1hua3v+GfHhxYekW0qjoadMr2NVmhiQlqDgvw0oLQfmR4c
	 AZ52Px5lHr+ZTZvQZoTVC9NDHyzKIFEl1jc0g5CQR6S5prj8pk51FHdumTki3qXj5JPVq
	 p9WUBtUoPgnSSrs0XtXYAjxFsYdGJqh8JVxvBuYHl+Uhdmv9Lg+eoyvrUjLFL8ys+hcnt
	 3OeQnnBwWXmsusaTG7qRLCsC75y2tlX2WIhwg5sQvWkTeZquGRoSIO90h3J0rWCLsMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LOaUcszBeFc4BBZTn5mnxjNejVuuHalw0DHWazewRfk=;
	b=dkSz6/U1JqWVmsn+xiv/zP+hEENkb8ov2oZPdHj40AHoUctHnBdP1/JjrRRtxO3FL0IK
	 Sik4FosARvcDxjEQO/R2GvT+j2WUkg5oQWOgDz7fXObjWt3D4CxsNYwe01YPHKCbvu0i9
	 a6C4QTjXbMF4Ls81WqpltywSqu+rix4KY0/d4/U+NLOSNeYJT+2pV6MNrWZAl1YJHg+7A
	 btDq7FGhMzoqnQ40CsNakEpn44n4BAKd7oFZHtRit2cIhJzBEX6C+cLmI7Hk5hGWVNp4P
	 JQEebTzcjkz6iRzDlwMgwECsxdcDKPnM3DF11bWcDshDt5TMzjJH4K/zQhRZQtnt59w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B6606A33B
	for <linux-omap@vger.kernel.org>; Thu,  5 Nov 2026 11:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C2B6606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e4831c028so1568046f8f.0
        for <linux-omap@vger.kernel.org>; Thu, 05 Nov 2026 03:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793876796; x=1794481596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LOaUcszBeFc4BBZTn5mnxjNejVuuHalw0DHWazewRfk=;
        b=YRRtLmSiMfivZJM97R0EjPfSJFaKkxh73SxC1v75MA6sudRgHzTsOwKyvimrMZy3nF
         CEXfFiAlo0+CYwI35W9OP7RYSEUXaCfi9JP+VLaMgdqh3ECkKyUy3I5FmR7Y1XYBlw8B
         xkLbrwfRrl5r927YaBVRc9BSFtjdMh39/4cOeqPEO55i9O3tFyIR/6ACR6LAjHip6x2h
         uuVKIi86pMpJtnB1Cxdy71V76NsTTHAB6+EXBnzYcRMy3XEzrJwzLLjSRrl/D4rK04M4
         WGFJDlWarHUK3nCJ1W6yiXB2op0iK/nxuo3Xi2ea8ezE7iaSZXTg9cRLPpuf7ja4bkxO
         2Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876796; x=1794481596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOaUcszBeFc4BBZTn5mnxjNejVuuHalw0DHWazewRfk=;
        b=Hd9rye3ktNd59Czo//y3t6KEO9x3bn9ncWqYBTIWgYHhQFY2AL3AXG0mu0iwpoPLo7
         IJmtR6E4BfpqtYmbROMmhaN67bEv9iMsmTOueLphTPaiQsPvMJsBFHR9JH7QoCzAEoIS
         biiz54b+/u6xGZlJ5rCdl1nHWL6XU81WVmOGuNP+09kO4sADo2etgpIuslpmzep+gziY
         0X/rk9QooORFbL59UWHudulZmguAPS1XRi5oTbs0PzOmSoX7yHP3wPLJnVZg0bl9F3Pw
         8GOTx2639T3fNswT1w34ghamAyV+tTii7uqV8NEJG6/oEPemnSawJWhk4Zmr6njpZvab
         mCNg==
X-Forwarded-Encrypted: i=1; AKwUvBx4ejBUx6r1QuNmv40QBaqSZlaffX9atQhZ5SSgoe3U4SiY7Ne8pcD2MJYKyhCgt8TGFfmK7hSF0SVQ@vger.kernel.org
X-Gm-Message-State: APuU4Z8/Hb5I77EcDgDE0/D1NcozHwzDuMyy8igMKFWYCGFOfT2AuH1M
	eXqaawaQa9YpzuSpATfzNtVAlFIECFU/dC4Q2dqLNwpM/s/lJXe6gH6cNp66oSqZXmw=
X-Gm-Gg: AYBFou0eeF/w8Vbp+Z0GdexLbroTq/qJCvQ8TtkkGbCwILh7cHORV0pwq2HGM0DSuYU
	kuXMq6M1Q16FePkcdwPv3Bl7ct/5J2DFw7rIZ7I1SdncgmT6ySHuz3f/k4g5pz0WqotpGZVEsOI
	57LrcrKtZHljB/ibuCBtf/SnRuHZ67N9fwxMGyimVHXpkIiMI0kXWD29jjOJOVVvX2/hGRnROrS
	9wuqxEa2rGw8Uy6vp27hiE6F69JZvlZRRQc1Oo91YSrnWrUVswaG4XMhpgH69kdujLFueuo0Wov
	bPd7lSC9jHMi//Pde4cheKgAG9D1OTF8PYC52U1pwnreCdZ7x5EMuc5FCepyNj1LT191UVdHMDe
	ykV6FyvtxtkWB0pcZSP1DcBwbvZQD3NZT7C+vpvnkli0HJG+lBXasGBjVyh9EYpMZeYsN670KJT
	jsWREBBH0ZsPTEc6LjCjDo1vvMfw2vbB3N1v3d4yRf88hXx8irbdRESdNu9+lq7qz6urCAxlURr
	xALBIfH6cGv8nuZlUKas2KVlHIe3rt4H9BR9QbEaH6uZduC0VIn4gnIzNHXKPZi6ZN6AIzKL/2W
	iFwQPh+TyBKi8UuOuGF+d7o8nAiRvMLmUf3W7Hbe/l1tC5oov8+GuhopXGTnSbVZvJZmF5qIi0P
	HHBKN+B+81VPQTVfi
X-Received: by 2002:a05:6000:40e0:b0:48f:bb86:cc03 with SMTP id ffacd0b85a97d-48fbb86d828mr15698548f8f.11.1793876795617;
        Thu, 05 Nov 2026 03:06:35 -0800 (PST)
Received: from localhost (p200300f65f19a904ae40ca5165ccacb8.dip0.t-ipconnect.de. [2003:f6:5f19:a904:ae40:ca51:65cc:acb8])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48fece998absm10176189f8f.22.2026.11.05.03.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:06:34 -0800 (PST)
Date: Thu, 5 Nov 2026 12:06:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Daniel Palmer <daniel@thingy.jp>, 
	Romain Perier <romain.perier@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, 
	Mika Westerberg <westeri@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-hwmon@vger.kernel.org, 
	Matti Vaittinen <mazziesaccount@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, 
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-tegra@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>, 
	Robert Richter <rric@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
Message-ID: <auxh9PxpJScFO3i2@monoceros>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
 <2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe>
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
	protocol="application/pgp-signature"; boundary="qsdpu7ny4ekdton4"
Content-Disposition: inline
In-Reply-To: <2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe>


--qsdpu7ny4ekdton4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 09:47:39AM +0100, Bartosz Golaszewski wrote:
> On Tue, Oct 27, 2026 at 11:48:37AM +0100, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > Hello,
> >=20
> > the original motivation for this series are the patches that convert the
> > arrays to use named initializers, see
> > https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylib=
re.com/
> > for the idea behind it. Looking left and right a bit while implementing
> > that, the series grew a bit.
> >=20
>=20
> Hi Uwe!
>=20
> This no longer applies, can you rebase it on top of gpio/for-next and
> resend? I'll apply it right away before any additional conflicts.

Hmm:

	$ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git=
 gpio/for-next
	From https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
	 * branch                      gpio/for-next -> FETCH_HEAD

	$ git checkout FETCH_HEAD
	HEAD is now at d66b6b86d5a6 gpio: 74x164: add support for 74lv164 shift re=
gister variant

	$ b4 am -3 2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe
	Looking up 2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe
	Analyzing 33 messages in the thread
	Looking for additional code-review trailers on lore.kernel.org
	Analyzing 99 code-review messages
	Checking attestation on all messages, may take a moment...
	---
	  =E2=9C=93 [PATCH v4 1/23] gpio: Remove __maybe_unused annotations from a=
cpi_device_id arrays
	    + Acked-by: Frank Li <Frank.Li@nxp.com> (=E2=9C=97 DKIM/nxp1.onmicroso=
ft.com)
	    + Acked-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com> (=
=E2=9C=93 DKIM/intel.com)
	  =E2=9C=93 [PATCH v4 2/23] gpio: fxl6408: Remove __maybe_unused annotatio=
ns from of_device_id array
	[...]
	 Link: https://patch.msgid.link/cover.1793097104.git.u.kleine-koenig@bayli=
bre.com
	       git checkout -b v4_20261027_u_kleine_koenig_baylibre_com 20a33c6b6c=
be7e4805dfb6cd68816937443aa148
	       git am -3 ./v4_20261027_u_kleine_koenig_gpio_improvements_around_de=
vice_id_arrays.mbx

	$ git am -3 ./v4_20261027_u_kleine_koenig_gpio_improvements_around_device_=
id_arrays.mbx
	Applying: gpio: Remove __maybe_unused annotations from acpi_device_id arra=
ys
	Applying: gpio: fxl6408: Remove __maybe_unused annotations from of_device_=
id array
	Applying: gpio: Drop unused assignment of acpi_device_id driver data
	...
	Applying: gpio: Unify style of pci_device_id arrays
	Applying: gpio: Unify style of various *_device_id arrays

	$ echo $?
	0

Maybe you just need to add `-3` to your workflow? ISTR this should be
the default for b4, but it seems if failed to mention the -3 in the git
am cmdline.

Should I still resend?

Best regards
Uwe

--qsdpu7ny4ekdton4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrsYzcACgkQj4D7WH0S
/k6COAf+I352qHa+kMUOH9ETW9KNHC8dWhUfB6E/IB+8yoRbH4tQy5C0mLg76J11
sJdUuJGD2XjvAv2tgSWACC8Cq1A+CnMvgQXXDsLtC7JuQ0aQYwSFMTIEphdECYue
42itRdsMlxubgjyK4Ku9YeDItioMv2A2EX+InXlNcO6MoK9ty5ZgCfsCY3OyHGVT
OwfU948a3DowaasJORDv1w6dhDNg/sCysegJvjnBoz2vhmoeYeyxxNHTGIzcjxt/
CWYJqu4/QDxJQ9FDuS6d2VhmXYOGL2Dl/wntyyQZjatVXHe6I2wwFBNQoOWJvPaA
BRQb0uNoTqeBvO/Bc5+AYD34/xDKkg==
=tsLa
-----END PGP SIGNATURE-----

--qsdpu7ny4ekdton4--
