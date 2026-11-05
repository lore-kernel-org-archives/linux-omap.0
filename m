Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866589;
	b=LDVUHSKZatsD3xmf9mwIw32wkNsWKU8Kcoi29F9hpbsJyNql7pRKzJYck3qts1MvIpw4
	 adx4NkBmPLOAAJdMpTXdmflshqyVXLak1X/si+KXujGy8XTe3SF1if91D6qWlmSFvBZh0
	 heUm+7/cOI00F2sDRMg7FesnuGrYGJFPv97xTpHTJz/dEDcBUVH8X4uwgwcDo63Ww0CBl
	 arg7zzSBoWYlR7KVTHBnUbOnq5h+W6ZPiPvp7Ty9FE9icYtIs2z3t/E0mGn4BveCl0Usb
	 v+l4Fp30+cY4ipy/pYLq0pfN+lPALVXwuIVLeBuUAXhrQI5DnCI3WXNnSD8snfky/mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866589;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CuJQoyb7IoYC0y7UfGHpRmB84OJXh943j/1/oLn+lg0=;
	b=PXdRP2OME6mGXqN6z8guPkZvQHyDEE+Rz4NkBOhe8EW4dNhx7VjjDmZQZ3MviGcjQyEH
	 4DtHZxUvfNRnNLR6UGH6UlYt6Fo5yWLgZAvAZ84szEtQKmuSffzjITDm+Jet0IUfg9CQc
	 Xg+5OD4Z7A+o1UlFD7vEdjVrPQ1Bc+AoGi5A8MX2D6CgWbac7xO7Ym5ycqvyw/EfGa/fM
	 Fb3zqL2X8dHKPZX9NvRE0imGAMx5Cy2m6qGa0CT5pQdqYxGh70REWqlIWqQkCPspMxXpX
	 qnaVvo/GFxo10kME30iHE/uP593qJQHgyrg8Efzh0NMGu73eLi38N+1uNzfCZjS95kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkEDMbG3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789E606A326;
	Thu,  5 Nov 2026 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkEDMbG3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49381F00A1D;
	Thu,  5 Nov 2026 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793866588;
	bh=CuJQoyb7IoYC0y7UfGHpRmB84OJXh943j/1/oLn+lg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GkEDMbG3pbvOmv5QL4XpIyruzvCSEfqqg7tw75JazXjzBE9yvyowMepOn3y6+Som6
	 7bZHMUqOxbR+1afQEh4X82o+M7uBBtCmbmCrBd5nH38d+ZFUyy3I4KRFYRc88Lvm4d
	 lBe8qw2bc/IRVFhNya7rKkiajtNroKwHTm0QOMzaSLnDW4zquT95X7oazy/nNUGhtl
	 7Fnay1nN7tTQn++UjaZidM0Cz2h86y4vRunnxH3KU1Y2ZpxnqTDaoX7OjobZCB674s
	 bolXu8ulBcO5NL7Vio6ysB8oYk1nctYzD7LDAhYQD/GU0KjZDgVyBeoqHqUz5uujYP
	 2TsXd8gBTPirg==
Message-ID: <c6664dd8-871e-4b38-8017-d4c1a02fd36e@kernel.org>
Date: Thu, 5 Nov 2026 09:16:15 +0100
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
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
 Linus Walleij <linusw@kernel.org>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-omap@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20261104113316.1634141-1-peng.fan@oss.nxp.com>
 <93534aaf-00f3-45f4-982e-7fd44ab3799c@kernel.org>
 <auuXnndiQOkEaOsj@ashevche-desk.local>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <auuXnndiQOkEaOsj@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 21:37, Andy Shevchenko wrote:
> On Wed, Nov 04, 2026 at 06:38:40PM +0100, Krzysztof Kozlowski wrote:
>> On 04/11/2026 12:33, Peng Fan (OSS) wrote:
>>>
>>> Replace the open-coded subsys_initcall()/module_exit() platform driver
>>> registration with subsys_platform_driver().
>>>
>>> No functional change.
> 
> ...
> 
>>> -subsys_initcall(i2c_adap_pxa_init);
>>> -module_exit(i2c_adap_pxa_exit);
>>> +subsys_platform_driver(i2c_pxa_driver);
>>> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
>>> index 15e14a6fe6dc..dd1f6f854a32 100644
>>> --- a/drivers/i2c/busses/i2c-s3c2410.c
>>> +++ b/drivers/i2c/busses/i2c-s3c2410.c
>>> @@ -1188,18 +1188,7 @@ static struct platform_driver s3c24xx_i2c_driver = {
>>>  		.of_match_table = of_match_ptr(s3c24xx_i2c_match),
>>>  	},
>>>  };
>>> -
>>> -static int __init i2c_adap_s3c_init(void)
>>> -{
>>> -	return platform_driver_register(&s3c24xx_i2c_driver);
>>> -}
>>> -subsys_initcall(i2c_adap_s3c_init);
>>> -
>>> -static void __exit i2c_adap_s3c_exit(void)
>>> -{
>>> -	platform_driver_unregister(&s3c24xx_i2c_driver);
>>> -}
>>> -module_exit(i2c_adap_s3c_exit);
>>> +subsys_platform_driver(s3c24xx_i2c_driver);
>>
>> Apparently reviewing only a few lines out of 300 is still reviewing:
>>
>> https://lore.kernel.org/all/9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org/
>>
>> Therefore:
>>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> In the similar way
> 
>   Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org> # s3c24xx
> 
> (Note, I specifically put double space in front to make this as an example and not overwrite your tags)
> 
> And to others, the problem with partial reviews are lying on the side of the
> sender as it's not reviewer's fault that unrelated things are going in a bundle
> and not in the proper per-driver series (where each of the driver may have
> distinct maintainer).

Re-iterating my earlier opinion, the reviewer is at fault as well
because either should use Ack, because person did not review THE patch,
or at least path-limiting comment like you pointed above.

I'll send v2 of my patch for submitting patches mentioning this syntax.

Best regards,
Krzysztof
