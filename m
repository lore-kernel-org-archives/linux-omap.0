Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.79.152.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792714;
	b=iYQS1RHYq6tE5ECu7MhfOaRTl23jYMUu5bd/UaJJVdFKecfUZL1hzTTG8rdocqSDzuQn
	 VA6XLWLYRnuDWspdJJSpke5zz1ZgMotO4PGkwiBMRIka522tAAoSR4EIZYp7eGx62MoOT
	 gk7XoAlpF6bI/F/NxyPz1f3iL70w8fa9ktJ1OUwc/NAf4GBSt+VxAon9se7zFb5KBvoCu
	 VETVPBtt6HJ1NAH/elMedrlRTcFGMU4Ee/w/GPhF+DqdBcp607EfEF6xIYAsG3y7ypxGZ
	 GswAup/Cb6sBUCyntYPrOM5wTL3ql58fASPYlUYi5brugfdDS51UbqS8XdBOlNmDtwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792714;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CRM114-Version:
	 X-CRM114-CacheID:X-CRM114-Status:X-CRM114-Notice;
	bh=QLyO54zaOTxAKKhIPvxsoMq4fEquUUXaIdWfMQwsWvU=;
	b=pRvjtW1egJK98TFywLn+tMwE5ucqD8uYOFb+/0v91JQNMEMMANgR1NxW8dFdIaTRD0Lk
	 bIOm9PhQJXJN4GDMG9hc/zWnwBxEkQlgxnRGqjp436A2x547UodeAQr0Y/taYZ8m0ENtW
	 ynfbBbrJO/Ho/OAlLUu0FrXSCxZl5dNP/WNbyL9vOgr06rXSIV7nOoOZK1F8Zek9aJQLh
	 Jjzs3DwWsGxDim8MATGRJqOR1rR8ZXJmWU83kZwYpYxOqPn6NwgK7rKCBj7VRBikQ1Zor
	 DG9afzzRk6tnYl+GuvRzdlLd241XPIIxPauOAtNjzc3X8AXHusYiO7X/9wprRTv7mAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mleia.com;
	spf=none smtp.mailfrom=mleia.com;
	dkim=pass header.d=mleia.com header.i=@mleia.com header.a=rsa-sha256 header.s=mail header.b=IbTbANt4;
	dkim=pass header.d=mleia.com header.i=@mleia.com header.a=rsa-sha256 header.s=mail header.b=IbTbANt4;
	arc=none smtp.remote-ip=178.79.152.223
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299CA606A333;
	Wed,  4 Nov 2026 11:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 299CA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mleia.com header.i=@mleia.com header.a=rsa-sha256 header.s=mail header.b=IbTbANt4;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.a=rsa-sha256 header.s=mail header.b=IbTbANt4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1793792706; bh=ebwSH394zYPUGs4q/CaA+jIBZjAqW6ZboyOen2iOpmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IbTbANt4V6mlhK1BXX5P+KA5FMS/4s9QpWEhFm3QbYFxDyV4eikpkxD2ht/VwYC+V
	 txGjhk0AN0fQLNMCy7tz+jAO0NLJvZIDEZU206DyTwVbG2P6rzZjXhVE1aBmNw/Kbh
	 7JDCWnUdfh5gbRQ9aXiqFs8OHx5Mr9OkHDKjdtFUYC/z0rZAnrNBFkvOFt9xkmp/vc
	 kCGIhxJ+aVj/+S/kRtE8BVF4eBSGP5QXQwJW+WDjTX6E6f1gnez9EiSTlQDM78Nnh8
	 cEWqc3GhUO9xvg2yLm2jj9hDYFfWA8eZOI0rBa+pohDffaPLWl9tFat1CFYQVNLEIx
	 ygw2LwV0pp30Q==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id BA62E40A6E6;
	Wed,  4 Nov 2026 11:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1793792706; bh=ebwSH394zYPUGs4q/CaA+jIBZjAqW6ZboyOen2iOpmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IbTbANt4V6mlhK1BXX5P+KA5FMS/4s9QpWEhFm3QbYFxDyV4eikpkxD2ht/VwYC+V
	 txGjhk0AN0fQLNMCy7tz+jAO0NLJvZIDEZU206DyTwVbG2P6rzZjXhVE1aBmNw/Kbh
	 7JDCWnUdfh5gbRQ9aXiqFs8OHx5Mr9OkHDKjdtFUYC/z0rZAnrNBFkvOFt9xkmp/vc
	 kCGIhxJ+aVj/+S/kRtE8BVF4eBSGP5QXQwJW+WDjTX6E6f1gnez9EiSTlQDM78Nnh8
	 cEWqc3GhUO9xvg2yLm2jj9hDYFfWA8eZOI0rBa+pohDffaPLWl9tFat1CFYQVNLEIx
	 ygw2LwV0pp30Q==
Message-ID: <5334e00c-67b6-4fbc-9090-17ff1c9d7494@mleia.com>
Date: Wed, 4 Nov 2026 13:45:00 +0200
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: Convert to subsys_platform_driver()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linus Walleij <linusw@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20261104113316.1634141-1-peng.fan@oss.nxp.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20261104113316.1634141-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20261104_114506_797044_64DF58E1 
X-CRM114-Status: UNSURE (   5.92  )
X-CRM114-Notice: Please train this message. 

On 11/4/26 13:33, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace the open-coded subsys_initcall()/module_exit() platform driver
> registration with subsys_platform_driver().
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com> # I2C PNX
