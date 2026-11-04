Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813933;
	b=hUI+VLpSV/ta984ZIZdX4jl/N17oa42hAaNIklaihoJmY85LwF4/81J2dCoJmxnL/7PW
	 s3bFeUmS3Y2Wi6Xf9x0a1ZLX+F1QAKt275yaec14pKn83UrCbRA8ZwJdoIToKb09QJxIb
	 oDXEIgWglDoqhqb4m4ELjesfAYATnjSuf83cc4AEQjgyLINdFeg84b5ns18nuCBOU4q68
	 4JIBb3ZlwkC8bKYfpkoM90Pe6nZ6hslGdmwQ7uYN2whhzqlCal/KwU4tRXwLDhvfTbQsh
	 /BgS6ivYxui4Mh0PvP274CzU6OG6DhJ0RN0LbScI2OacMoAjoBuqs61iSK3VF4lOtJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813933;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VBTftESCyh0yxPgmjsbtevP+1+uG9koiMGzvN+ELLp8=;
	b=Plh+J3O2B4EosF+30KyQXZHy+sN8pKC1Xgu7pZ6ICwbgo9ODH1YzYoDpUP7a5Z66R9on
	 Wzp85JNopu8YIRxbJgP+r2muG2+CLiY0/nLmRE8PxfO07mroCHfnCaqvyGLnL3CotND2C
	 upLT+g0X34RPduc7O4/iJWZSqU+BJnZsHb6lgSUMKZ/Qgmk29bInUDEBTXGk350OENnHp
	 cYmcnWfNMGA3JyF8eoD8GgNQzBkfq8M/4YBlSk2pg/irwVy+rAPrFx/IuCIRIP8lybUZW
	 8UF22ZTWTdR8b8+5Un7K00xSLevY747getmfmUspUVNFxy6nmD2k1z1nEu9M0+Kp6yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQtdgw0J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9A606A93C;
	Wed,  4 Nov 2026 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQtdgw0J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD821F00919;
	Wed,  4 Nov 2026 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813933;
	bh=VBTftESCyh0yxPgmjsbtevP+1+uG9koiMGzvN+ELLp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NQtdgw0JAZJnyRdcvgREO77S1JBlhrbMLT8xYWT9Ymw8m9R16hz1iQ6/w5YcDVPcD
	 MExx0lk5JI4Y90lOOug6EBjj6waiJYKOuCd/pGJrum+ATMgimwBU5YXeV/Fsh2pMqb
	 svZFEajEmUCtcamQT3L0ONP0k4wTRqtYOZsuOCwZ6v959MF0lFv1aS8Ru/H6lsCdGy
	 ZDA2NrKu40mAzo2mtPxwNGOvA8lrcBk3TqU94GgCcAGeXne/KqLn2jhFfhWguQOEOF
	 W0hssNC3Kywynv9/r1tn+6q4u+E29xTBdvNGgyApFVoKQ/S2tju6Wywm36Q7IUozjB
	 l11w62SfMuHfA==
Message-ID: <93534aaf-00f3-45f4-982e-7fd44ab3799c@kernel.org>
Date: Wed, 4 Nov 2026 18:38:40 +0100
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
 Roger Quadros <rogerq@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linus Walleij <linusw@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20261104113316.1634141-1-peng.fan@oss.nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261104113316.1634141-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 12:33, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace the open-coded subsys_initcall()/module_exit() platform driver
> registration with subsys_platform_driver().
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/i2c/busses/i2c-at91-core.c          | 13 +------------
>  drivers/i2c/busses/i2c-davinci.c            | 14 +-------------
>  drivers/i2c/busses/i2c-designware-platdrv.c | 13 +------------
>  drivers/i2c/busses/i2c-imx.c                | 13 +------------
>  drivers/i2c/busses/i2c-mxs.c                | 13 +------------
>  drivers/i2c/busses/i2c-omap.c               | 15 +--------------
>  drivers/i2c/busses/i2c-pnx.c                | 13 +------------
>  drivers/i2c/busses/i2c-pxa.c                | 13 +------------
>  drivers/i2c/busses/i2c-s3c2410.c            | 13 +------------
>  drivers/i2c/busses/i2c-sh_mobile.c          | 13 +------------
>  drivers/i2c/busses/i2c-versatile.c          | 13 +------------
>  11 files changed, 11 insertions(+), 135 deletions(-)
> 


> -subsys_initcall(i2c_adap_pxa_init);
> -module_exit(i2c_adap_pxa_exit);
> +subsys_platform_driver(i2c_pxa_driver);
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 15e14a6fe6dc..dd1f6f854a32 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -1188,18 +1188,7 @@ static struct platform_driver s3c24xx_i2c_driver = {
>  		.of_match_table = of_match_ptr(s3c24xx_i2c_match),
>  	},
>  };
> -
> -static int __init i2c_adap_s3c_init(void)
> -{
> -	return platform_driver_register(&s3c24xx_i2c_driver);
> -}
> -subsys_initcall(i2c_adap_s3c_init);
> -
> -static void __exit i2c_adap_s3c_exit(void)
> -{
> -	platform_driver_unregister(&s3c24xx_i2c_driver);
> -}
> -module_exit(i2c_adap_s3c_exit);
> +subsys_platform_driver(s3c24xx_i2c_driver);

Apparently reviewing only a few lines out of 300 is still reviewing:

https://lore.kernel.org/all/9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org/

Therefore:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
