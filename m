Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868464;
	b=Bzx+2Qw32ndqIq96lPWZEyvC6yfLbEep8P2mk4KO3qg3vSMUUxJvfGY60qpvndkk3qJC
	 JxQCttZ3TajfI+EL3iGgBnzJWhxJA0hWMdz/uYQ8/n8Gs7YwSxXaO110rrk0M7+lNKZ8e
	 iUAGeOYeH6CEuB3D68Mqxkjfr2Hlq/WEkdanrIFjSWNCQvEPaFdentBzVgk/RWK8ue+Hp
	 81b6UddAWTxdwc0ZZL04169laHF1CnDtJOLvbG9aJY5isKElHDlbuOuoZXuUsXmtpXZra
	 A3CWN5LZ1VqzvXxCpsUgl+iiloJf0/agCgvlcO8bthskucRDyeUJL9u5o2+txtDG1cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868464;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=7Cao3FJR5MdJH+ZnumyAVfl5Aw5BXwagSddECWxWGQ8=;
	b=UzmlBWGeLZOsqz8tZAQA/TtM5XESy8udzUKoMFCZPgxu23Qk0AvfGINOzTOZy0XfHztN
	 ySOQhfqz8GwnvMVtQmqzU5EUAgNt8FWmzqFWtm757hj/V43tBz1hmatjwdReh5jnUHD4U
	 Kg3fKUtWhiFu1525aKWSJWoyv6VUDCkz97UOYn1nJuhS+9q5oLrtBOmUZ3lYRoDkVnQfs
	 EhJx1uIrpswKSClDcANLtvD/xtP2LFbRgBqUZq6GITRIwPhVdDvizaXlKbaUWrlJAEg29
	 N8mAJqeUVUDMQ32FOnIdwWdQSLdFD6bR9UXEESQvoEaTQiJdgtMVnMBjqmsHptOWXwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Brt8unw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E6A95606A31B;
	Thu,  5 Nov 2026 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Brt8unw4
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 55AA61F000C1;
	Thu,  5 Nov 2026 08:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868463;
	bh=7Cao3FJR5MdJH+ZnumyAVfl5Aw5BXwagSddECWxWGQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Brt8unw4v4IBCfyHYflx+ovCkQpkF9kkBD7yN+mFMxqgVSqmmhdZimNjzgT7NPi+C
	 6NNsZPKGCHXdcQBhPCvJx353LOvvo6XmlR8HWZXl25vlftL8nkaXSy4KfV5eFM1jU7
	 4i7HkeRO5gXorGVfhbzQf8zGQNQeRkemG2dnSKynmoJhgkxwdW7EiopLWKaptRntXT
	 db40KHNFd2TH12noKLi71Q2L/eJUaUmHUohTYTgf0hg2ZiZLF3t9tOVTsopBowQKDv
	 gnWZPINPDIGqs9hd1bi1EzxYGRl1mp/tX5fL2mYXbQT+XTW0yGu6+Dcz43I5W1uquX
	 a/c9gAKcLS92A==
Date: Thu, 5 Nov 2026 09:47:39 +0100
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
Message-ID: <2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe>
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

Hi Uwe!

This no longer applies, can you rebase it on top of gpio/for-next and
resend? I'll apply it right away before any additional conflicts.

Bart
