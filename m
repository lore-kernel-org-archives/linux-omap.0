Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801918;
	b=Ob4DrBqqVd6i/Yg0tKlT5UidmLVBPRwZ+Dnx1mdaTJQt+tIJFjOV/bNGBNw6XL/0g4Qa
	 oG6FHxx7dZdNAWJFojYiB5yvZELUViDX0GYav7EDADHxOHqrLGP4dhSvU3kx6WI4ca1Ft
	 2Cx07Fg7U4f/ZS82TGlZgFSvZUoO12DcJ+b0PUxbdnq/WmnQBzZJjxJGI/YRqWW+BEyY7
	 GmV9Wh/GYLPW9nBM3iVVv7SOJs/CfclHUNOXgCLyscXueqy1jtXRaudBnW0j5TffCMa9F
	 PD39v1ilMTYToF9xlkC3xALrfdxHnLI8h5lrrgfqgR7/7KJTMnsC8vmFB7SL84KD45w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801918;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tIsim5wpkIICh192gsX8FGT+MKKG5Z56KVBTAyYasJg=;
	b=yTE2YOIC+92iH2bjQTb3ooQWzJhJZ3FMlZKB5eiklSlSR9mNxXZTTztkeschRjlhDRe6
	 f8TONV2UCGtXHIu7e8eNRNQF6ncT10Ciw3Hv3Xa6iOG6JWNiA1ozKn0hTnEv7fVBkTgrB
	 J6Bb6uFftSiHrqe+c39Cg3EwrLXY4dggd6Fhd8ua8dJUuCfk5zLDvlLpZS4TeLMjt9St0
	 7OiS24C1EwO+yCMWv7wBgBIWBBqv9ObuH+eIhT2YSNR+at7GO7pfpCT2sC49sdN9w2ZrL
	 thKUyHvKGu4VForUdrmsMFoicGJs33DSlNYhMWPjUlTNXHpJcFRBxjrEI6RquFNj0KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEBFhzWR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F1D64606A326;
	Wed,  4 Nov 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEBFhzWR
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6513B1F000C1;
	Wed,  4 Nov 2026 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801917;
	bh=tIsim5wpkIICh192gsX8FGT+MKKG5Z56KVBTAyYasJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nEBFhzWRIks+RPRMz6B9YBuEcxelF78jOoxhaGbQlrGOIEOF3j0r4ZN3AsSw82HWM
	 PfVd37jaJHJA+9usuXZNPgGRYSimbNDnYfzEwcjLVi5tPC1p2ENsIUifco3Hk2uHSN
	 P/0XtOlU/mMN6xk3YzmiKARg901Rn0WgDEBbY4JlDVbPe2swPcY88Z1iwTzkQCWHhv
	 c+SQFgiIZzd+Pr4Baa+2NRTAiI8nBCg1miIKasAnUU3Bp3toOaQJe1MOLo/AwjY39B
	 7KmrsqnOjGE0Cvdu5GFOyqlkNWPdX6oqfaiJmVQdZ+RhaBXHtAonVyvJLCZIenqIm2
	 dkqzeViYeSr+Q==
Date: Wed, 4 Nov 2026 15:18:33 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Linus Walleij <linusw@kernel.org>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] i2c: Convert to subsys_platform_driver()
Message-ID: <ef6ce6fqyefm6ywoaym2f4ww5nclotp7i7ohmqnaikb2lb5dsm@lcrmzg2z7v7n>
References: <20261104113316.1634141-1-peng.fan@oss.nxp.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104113316.1634141-1-peng.fan@oss.nxp.com>

On Wed, Nov 04, 2026 at 07:33:16PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace the open-coded subsys_initcall()/module_exit() platform driver
> registration with subsys_platform_driver().
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com> 
