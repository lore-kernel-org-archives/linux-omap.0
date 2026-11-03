Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708685;
	b=fXr+R30FwqZG8SPbvzPVO1his1UrpHwMTMwWmsprkDo20lk4nhmud2rQxaSJjpp6ujue
	 QinzGqmG7ybon0E7bt33lymyKV+0KNnfLEZO9xxm20F8Tdv73kil/GQz7Il/hgkUSrDyT
	 i3ClIbOCBVDqBr9sm8c6pnhVDz1nGJrAhuP9M1qPQ4TcWXpkep3GDu7spkzcbM0DZFR4K
	 FwRLivBjgO80Zr6/LnnXlsVT5etd+1R7M2YGRdL2kyfwdo5v2bkxBPI5qnIr82Grdpy1B
	 HfBKB+aCOhQyuMb8/yF+xqd/g51VzGDYqIjN4aVEmufMD3mt1kWWKBAo5o3ULbnKOWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708685;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=2DQ96R/0ulhMhCPuDty/w5YNIxZWO7PXWDO3bMU5BOI=;
	b=Ip6E2j857ix97JXJu4uigVh4ksPNxv4W0fQllqJu6J6GMdOMsIbqzXrWkG1BIOk5emr9
	 KIwEKwkgux6R2Fdt576scKlr8q+q5iruCa6J8DLtVZ454k6Z21cYcyFw43zVamwT1OCQt
	 6qjPybwlsckujvLI6UNLzLa1Pr6szzIIIOBbXTMIqnOGTEn9heLtUm7cXxqtzdh09B35s
	 5HwW/Df7c8OVRBvxztspJtA9dBATYv+6t0UmqT0biAMqIsVswMA2iB0jJw2cwJ36HWkmE
	 GaHWe5UWRI9Xi2Y7XLDFG715H6Y2B9kGxUSZhucpeeiqXXrfM/2jMdOzDenUCNwCODQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2DPOtoe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AEBFE606A326;
	Tue,  3 Nov 2026 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2DPOtoe
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5D33F1F00919;
	Tue,  3 Nov 2026 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793708684;
	bh=2DQ96R/0ulhMhCPuDty/w5YNIxZWO7PXWDO3bMU5BOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y2DPOtoeBhQC9H3iDa32ycCqijeUsQyOWUtRGHIYLH0dXLxZUgEjv6SLfXFJy1+yx
	 REGyvcQMfuo3sZnBFrDxClG/MkMaDIKnK90l7RtK0PDTXjGL6CaKqpsTGr1H383bgl
	 4TyhCnpi2mmiJ18g5WO9YEH6HMlaMgnH5EIfxQ78ETdDfCbW0Nq7FnvPdbMq/lkRzu
	 YVxjlkUTO+w5EzhvM5yynGpZ7GDn2zzh6C78NzGOnNAyoUN8QGMgJIfas682UgvcoY
	 za6RIYThdNdxsriG9j3+KBkt/9fGZF5z8OM8R3azJs/Dg4hZMYuSZR8c3Kxw2uTAo8
	 Un2lK6ZcYoQzw==
Date: Tue, 3 Nov 2026 13:24:40 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
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
Message-ID: <oiwdi2r7fbay3dsghfaqzejpv7d5dpuerh5jy2vsw3kjyhvhdm@hyrpff5ytihz>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793097104.git.u.kleine-koenig@baylibre.com>

On Tue, Oct 27, 2026 at 11:48:37AM +0100, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> the original motivation for this series are the patches that convert the
> arrays to use named initializers, see
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> for the idea behind it. Looking left and right a bit while implementing
> that, the series grew a bit.
> 
> Changes since v3 (available at
> https://lore.kernel.org/all/cover.1793030820.git.u.kleine-koenig@baylibre.com):
> 
>  - Picked up review tags (b4 even found some from v2)
>  - Add a 2nd MODULE_DEVICE_TABLE(of, ...) in drivers/gpio/gpio-mpc5200.c
>    (My grep didn't handle >1 driver per file well), noticed by Sashiko
>  - New patch to use named initializers for auxiliary_device_id arrays
>  - Fix code style of of_device_id array in drivers/gpio/gpio-grgpio.c
>    (My script doesn't handle of_device_id::name) and
>    drivers/gpio/gpio-ppc44x.c (didn't exist yet when I sent v2 and
>    failed to notice that for v3)
>  - Fix code style of auxiliary_device_id array in
>    drivers/gpio/gpio-shared-proxy.c, missed as I didn't have a script
>    for auxiliary_device_id before.
>  - Dropped a few broken email addresses from Cc:
> 

If there are no objections, I'll queue it by the end of this week.

Bart
