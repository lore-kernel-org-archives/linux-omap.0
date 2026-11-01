Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793567967;
	b=wZC64nVA71lpBMOTwGQM+hOciNFhiFN3SmMxlZ+ROGNYqe+ybUn61zb1K5ZgZGj/0xqd
	 s0+gy0nNgeURqJYtbvQTFfIyW6rFxKJz7CFnAqg35v6ZlD/DvrKCp4k2cJrpmrI/17hGm
	 /tTUwIw1YP2+tgg79cd4iut3m674p3GV4jRgKuvPVzNnmsCfMuPndYbk24bt0coa9aWqz
	 CsyP2P6bUF++TtTdXokB82/Zi3JssIUcwsNcmVIISQIo59uuEL+Tp0vXZxQyPFEq5oiSd
	 ci9anVgsj7R8JFOXq0tgphxwIPIHRnVdZk9rV1xk09G5fTZwFfVHOvMWHWJvQFov0/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793567967;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OZvV+q5DV43ONtY61riaWk5gvmlm5puW/V+gDbugD30=;
	b=BBBaDB91+oCWQpEmn/u//VtMvB+FAr+/t7h3o15+8Dg/ZbjatQCP6sm4vUkdBcD58583
	 jxQyIfdLci6IC8HZ1KGzrv/2xPNbDRb18EyujFe5TXrz1TzqdFRW/ispfPtv/icAqObxq
	 FOnRSdSa9j8GYXS8Fx76ljeJ6nYgnmbi8O/ONgZwsNGYu/h027hDfpqRky6eQw7bvwl3H
	 r523Wso5d04kuwhj09DnHhwiDlL7F1JVsM5B/MQa0lwr8SgbuX/ZwGRDavmgQQ9dF09Cc
	 yg9+2MKK6PlnpPr7feKv+Fus/WBqkezSly7uNqTLoRkGNP/SbH4URqwI64zdSch+1Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=7+S0MWFE;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC89606A324;
	Sun,  1 Nov 2026 21:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEC89606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=7+S0MWFE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=OZvV+q5DV43ONtY61riaWk5gvmlm5puW/V+gDbugD30=; t=1793567966; x=1794777566; 
	b=7+S0MWFEnyRi7KinOo1sReb/u8F+8pRGa8TYjPoDEHeuwwLt25CsUaILaFZ3u/wYEyT6jKmGDmy
	A2MWWKaqLZKVVHSKV5W0ytodyzn0bqx6RWW8ur8l+B4Aj4af0oraD3CpHZkGd814F7WkBhWh8s3gm
	m6wKtpwIppSLjgn+m6ummiOVYqfZdfLx6EFpsiJQESgq+UVafSjbAck5ThoTwV5ng8zjXRwZYknbz
	5lkPeEnG3CCojlAiMG/bMqVTYfngvRM3h/6Xwo27aBIdtC0feMeFuKfKyadHIKbpcjz0i8D17JZuV
	92yNzN2cclMxKaHDVcB0TOmHXTgOMJ369+MA==;
Date: Sun, 1 Nov 2026 22:18:31 +0100
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
Subject: Re: [PATCH v2 3/9] ARM: dts: omap: dm816x: Fix pinctrl range
Message-ID: <20261101221831.7d63ec51@kemnade.info>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-3-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
	<20261028-patch-ektor5-dm8168-dts-v2-3-4544429251e2@linaro.org>
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

On Wed, 28 Oct 2026 17:06:04 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> From: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> The range of addresses accessed for the pinctrl module needs to be
> extended to take account of the fixing of the size of the pinctrl
> register to be 32 bits instead of 16 bits. So in order to allow the
> final pin control register the address range must end on a 32 bit
> boundary, not a 16 bit one.
> 
> Fixes: 86800ffe84055 ("ARM: dts: omap: dm816x: Correct pinctrl register")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
> Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  arch/arm/boot/dts/ti/omap/dm816x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> index 261ebca8863d..fc124f9ecfa1 100644
> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> @@ -90,7 +90,7 @@ scrm: scrm@48140000 {
>  
>  			dm816x_pinmux: pinmux@800 {
>  				compatible = "pinctrl-single";
> -				reg = <0x800 0x50a>;
> +				reg = <0x800 0x50c>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				#pinctrl-cells = <1>;
> 

