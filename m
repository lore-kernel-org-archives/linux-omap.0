Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793568704;
	b=P8gpQ5vT9fYW8bUUFfXj/s+UKDRiae5aiFjHD+/uVng0yxJ5GtDVz2+UgTf32H8qd9FG
	 wa+UZVkNbhofyeVKxocj8Vjtl8C8JGMP+WG0qg3anjSjI/UUlNq/Va9T0TsAZcdSIHrLp
	 swE9TvnmGQYmLHCYkvuep99U0CLsoyqv6NSAA/KMNaosxFis4fFqvP0XmFx54ReOQeugC
	 aES1qztBs/g1LFBPiOYaN8NztvYpVCI6JZar550wZN9XApVP+y0kQ5qwkj9vpa3e4NS67
	 7Vv0ysrqY2+oR9AFNaJ+5i6gms+OvSiZmc98ng4Px2K9O41fb6c8pg0CHgwvbi9pCdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793568704;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WivfJu6j5FvBeEaYfT1DOBLsHkNjmaHo37wIRykRTug=;
	b=2HKGeLx8dRdIJnweF8AYuF10aG052ScoHPv6K2r83XcsoeeOlP/jB7dFbGSOk2VOX/QS
	 FlMaMBn5KjETD/U4++8Y5sEKWG85wkJcCuhIzguzx6PvgfzI+tHUsdzgPGCgPdymxKaxN
	 X8FKW+83qLcXkfo9t+zi7Qi3mXoGBS5ke23LuTbrEOGwhZroyi/iZskcfDrUhUBGonLQJ
	 07XJYi/BzRHBXcal43fLihhNGPkr0SpgtDFOJak9rbfb5J4UlTB7BqOCDPgYof9hxS374
	 oByATu/qitnuKFht14A0JI/F49nQg+zVy840cAN0CwKQ4Eqr1azH/YHRkOwZa6Pax2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=ndjpUfXo;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5C606A324;
	Sun,  1 Nov 2026 21:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF5C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=ndjpUfXo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=WivfJu6j5FvBeEaYfT1DOBLsHkNjmaHo37wIRykRTug=; t=1793568703; x=1794778303; 
	b=ndjpUfXo2rtkbc+h+E3xnyKyap25mviUq44qG5hV277V/AMCucSrbNA8w7MhShnvwkNhFdNx7D2
	+ixMTO1RTkU5VSwFIVIyyzaF77pinjcZruX6ypXpNGwXXbWFvvu1xCzVdaBUzDiv0ZM+J4T08Vqs1
	AL9JAk+o/AKIqDCf/Cso3iRYrslQOTKaUBMoBXhC/UvqresO6du1fUwkpltxqooIuo0twbOkTsOnI
	xZ2lRDGi90RH0i0ZAKDTOBGeo9w/AGjNdJa6i91goZ3TTtCahs2ImfqBIe+HdfrLQwwMTPQO/CTbM
	2GzvQYWkazL7fhSfox5ri46T1mCK/Z7U/gIw==;
Date: Sun, 1 Nov 2026 22:31:32 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Christopher
 Obbard <chris.obbard@oss.qualcomm.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Paul Walmsley <paul@pwsan.com>, Russell King
 <linux@armlinux.org.uk>, Rouven Czerwinski <rouven.czerwinski@linaro.org>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 8/9] ARM: dts: omap: dm8168-evm: Correct SD card
 pinmux
Message-ID: <20261101223132.5db52879@kemnade.info>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-8-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
	<20261028-patch-ektor5-dm8168-dts-v2-8-4544429251e2@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 17:06:09 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> From: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> The SD card lines use external pullups and so the internal pullups need
> to be disabled so that they do not cause contention on the lines.
> This bug was revealed by correcting the effective bit mask of
> the pinctrl device. Use the correct macro for DM8168.
> 
> Also fix typo in comment SD_DAT2->SD_DAT3.
> 
> Fixes: 86800ffe84055 ("ARM: dts: omap: dm816x: Correct pinctrl register")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
> Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
> [ettore.chimenti@linaro.org: squashed after fixing DM816x macros ]
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/ti/omap/dm8168-evm.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
> index 81450e15b889..a6d42766a496 100644
> --- a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
> +++ b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
> @@ -45,13 +45,13 @@ DM816X_IOPAD(0x0aac, MUX_MODE0)			/* SPI_D1 */
>  
>  	mmc_pins: mmc-pins {
>  		pinctrl-single,pins = <
> -			DM816X_IOPAD(0x0a70, MUX_MODE0)			/* SD_POW */
> -			DM816X_IOPAD(0x0a74, MUX_MODE0)			/* SD_CLK */
> -			DM816X_IOPAD(0x0a78, MUX_MODE0)			/* SD_CMD */
> -			DM816X_IOPAD(0x0a7C, MUX_MODE0)			/* SD_DAT0 */
> -			DM816X_IOPAD(0x0a80, MUX_MODE0)			/* SD_DAT1 */
> -			DM816X_IOPAD(0x0a84, MUX_MODE0)			/* SD_DAT2 */
> -			DM816X_IOPAD(0x0a88, MUX_MODE0)			/* SD_DAT2 */
> +			DM816X_IOPAD(0x0a70, PULL_DIS | MUX_MODE0)	/* SD_POW */
> +			DM816X_IOPAD(0x0a74, PULL_DIS | MUX_MODE0)	/* SD_CLK */
> +			DM816X_IOPAD(0x0a78, PULL_DIS | MUX_MODE0)	/* SD_CMD */
> +			DM816X_IOPAD(0x0a7C, PULL_DIS | MUX_MODE0)	/* SD_DAT0 */
> +			DM816X_IOPAD(0x0a80, PULL_DIS | MUX_MODE0)	/* SD_DAT1 */
> +			DM816X_IOPAD(0x0a84, PULL_DIS | MUX_MODE0)	/* SD_DAT2 */
> +			DM816X_IOPAD(0x0a88, PULL_DIS | MUX_MODE0)	/* SD_DAT3 */
>  			DM816X_IOPAD(0x0a8c, MUX_MODE2)			/* GP1[7] */
>  			DM816X_IOPAD(0x0a90, MUX_MODE2)			/* GP1[8] */
>  		>;  
> 

