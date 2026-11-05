Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881538;
	b=yyVx+C0dmlW33MF/uREbt2SlNwKwxhJcvFHGEx3pcIxqboKClrFtN+WFX6uDFU7Ir9xx
	 /7XeITHBtM2TQZCw2rpgLpw3JzTebN1Aj+XUITHHYxvQh1lVGBIZxOfyPbYiLBNSeDzqQ
	 U28LS79Fhoy6id79/XlIqoUbrQ5zgrvQ6A5W1hrIUsKC6FwDxXpy12rGyJxPlcmFAMNBJ
	 CjvQietF75ei+k5OsF7qSRTFSufo3IOzgvTQnjHGIvrLXmxXFSBA/FxS+1bBCCeOGMDO7
	 4pBejgRqPEwodxDJKgkVouQ1Yet/RH/U5kSKjk/bCNHvO00xnb4/Y+4cziiSJxc0WaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881538;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=5triMnaj+pld1/ZkHnww/ZTGYlR4kdR37WbQmvo0E+I=;
	b=eSBHI8WeZ/phLyfkyORH8Mm6RrgJZGkdaBzP6bc+tKW2GemIOOPcO0pgsBmoPOzrsZJD
	 /eP5ofR9BccUQ3F4EssAVwH/l7rFE12ROzwgOfRwQpzc/8XZlJlA4u+4wqS0Wf/NqsIsL
	 1r1px8uBFZBWCauVjVJw/Fqta482P6txW7mZhro415KISFCJAwFdqjd+aOKprYr7MX+ia
	 GlGh2FfcCt1pIux6hfkOR/sPTizzBLnrtF/YdehjvOzOZW1acMZaDuERnhe2pfs3BIWfn
	 WQ0NaH1eTaIw76F39SgXbWz634nM0VPK6zD9pHJuAmnC555Q1jgZ/nVEJN9soaTihbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSW+bpRC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 02563606A335;
	Thu,  5 Nov 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSW+bpRC
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E9BD81F00A1C;
	Thu,  5 Nov 2026 12:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881537;
	bh=5triMnaj+pld1/ZkHnww/ZTGYlR4kdR37WbQmvo0E+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RSW+bpRC5/OtERfddmxxD47rtdgY7drS4x1h9FWwypwvgjQQLJG4iTAm6/TUtQUbq
	 IiZuATXLd3LAxCpuw8R+bMUOvh3lciPaGvevBovd3QKWsW5Y4FEE65Abpe70tcefDW
	 LNpOF1hD396m8K4hS/U5rd0wiR8PAmrXyC2g6JAfgX8u1ym3pLHliSZ1gqRgSLW+Bc
	 HX49I5XIf2eGuAaWlxtXXmvjW7Xb6hnAMLMzc+IGOOZWZbsMS43S+7Bz5Kl63ztaNT
	 pksjjqJMzfTRz7MCNKhc/3WIhoncfEvk6Lo0/zVDsCqyHXoooOlGiXvSfl7gdoDOj4
	 ig/01HIsQNlIg==
Date: Thu, 5 Nov 2026 13:25:34 +0100
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
Message-ID: <le5gbua6s2mhhv32di4j77qr2we5z5ngzyzmiemhodmblvjiji@q4wf5tdgrbtv>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
 <2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe>
 <auxh9PxpJScFO3i2@monoceros>
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
In-Reply-To: <auxh9PxpJScFO3i2@monoceros>

On Thu, Nov 05, 2026 at 12:06:33PM +0100, Uwe Kleine-König (The Capable Hub) wrote:
> 
> Maybe you just need to add `-3` to your workflow? ISTR this should be
> the default for b4, but it seems if failed to mention the -3 in the git
> am cmdline.
> 
> Should I still resend?
>

No, it's alright. I would have preferred a clean b4 shazam but that
works too, thanks.

Bart
