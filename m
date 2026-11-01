Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793568859;
	b=4KgtGcm8Gs7rJY7nLPNw2NwTNj3Hd7PLbbvRtquiE2mVnGTkguOCMV8wcDtQozHDprvx
	 X/+iY6AVuhV/7PSQNVnZr7lvCctaKHfGdcPuYJJuiT5HJwMZhTAoVYl4KKF32HZTCpFD+
	 7MJkWd3utSlfDFjrMzCbqLexgnid4cNsACb+/LiQv6iYi+LJfDnOczFtBpgg+bYCOgTFw
	 TkXL1ZM6wyo2vgxC6YDm+27uG72Z3aMhewJ7UXQ9JfEVHuGGOl2KToqU8h6cS41189/ij
	 pEi89xff8d7ItYkQJ3ef63g4w8//RWDcKBaTOjZesapCx5PfHBdrj0zA/Rwx6YjDtLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793568859;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HXvfofxYK0mJLvb5JZvTcm44cflpu/Uk4OWCfdYMWE4=;
	b=DrBTEoKtORybryk15TzKryJ5ihTXEHODhILbtweNYJlju1xpB6fZ2wF0ngq6tonhd2H6
	 02oi6SB/A/92M3XArsElXAHsF9wzALWEEF46BplYl7LTAUf7daDSbbP3ejwV8gWiYa/xP
	 zmq9zxSCKAz5Sr56gPMKvKOzkljx0335RsQ14nfzqcQUjWx1t35fmXVTKZRx/C8uootPR
	 7Bh0cinMlKS4ifrwpgsRVgYPCA8f62oCQeos8VcH0LCMb8Se/mNxQSq6hfgZNPs2kwJSM
	 UYK6q7LFgA3XaEAotZAJz1nJCXB61PeCAf2eLaoaU506Tul7yMMwz6Ch5XtM/o/bG6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=9UVX1Kpv;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3C606A324;
	Sun,  1 Nov 2026 21:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04A3C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=9UVX1Kpv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=HXvfofxYK0mJLvb5JZvTcm44cflpu/Uk4OWCfdYMWE4=; t=1793568858; x=1794778458; 
	b=9UVX1KpvbjZHoccxFDnE4VtMAp896QaqvNxOGUNP3i10/6HB6FLVHoBZmYObQbHPFhya40fEdAm
	rT+KR67EE6ElAJaEBYoA0TkaNWiIT2bQ52VXo9TRgS1wJ64SgQyfajWy7A8RrLm4UwrCLrOu9JJJV
	XF3FuSQzLQHZFWO/+fNcz1j4d9YylsF1cq3WLN56np2EzNsLNy3cV5FIaVxjxgZTd2k279CtRn8Bn
	v8QUUJ1Hv2wfMEznerLXuoSE5Lop+oIljo4FCCMJ0kdkh2uauitHj8/i9XTYeVvjRp6B5uOrYfALE
	J89QrSFmzJc6vJLW/OA3HSfrliZcUsJIgPqQ==;
Date: Sun, 1 Nov 2026 22:34:10 +0100
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
Subject: Re: [PATCH v2 9/9] ARM: dts: omap: dm8168-evm: enable MUSB
 multipoint support
Message-ID: <20261101223410.25cc6477@kemnade.info>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-9-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
	<20261028-patch-ektor5-dm8168-dts-v2-9-4544429251e2@linaro.org>
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

On Wed, 28 Oct 2026 17:06:10 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> From: Christopher Obbard <christopher.obbard@linaro.org>
> 
> The DM8168 USB controllers are used in host mode and must advertise
> multipoint support to the MUSB core. Without this the kernel disables
> external hub support and warns:
> 
>     musb-hdrc: kernel must disable external hubs, please fix the
> 	configuration
> 
> On the affected board this also prevents devices from enumerating
> reliably, with descriptor reads failing with -EPROTO:
> 
>     usb 1-1: device descriptor read/all, error -71
> 
> Set mentor,multipoint to the default value of 1 for both MUSB instances.
> With this enabled, USB devices enumerate successfully on the host ports.
> 
> Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/ti/omap/dm8168-evm.dts | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
> index a6d42766a496..4b4e4d850231 100644
> --- a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
> +++ b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
> @@ -198,17 +198,14 @@ &mmc1 {
>  	wp-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
>  };
>  
> -/* At least dm8168-evm rev c won't support multipoint, later may */
>  &usb0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&usb0_pins>;
> -	mentor,multipoint = <0>;
>  };
>  
>  &usb1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&usb1_pins>;
> -	mentor,multipoint = <0>;
>  };
>  
>  &sata {
> 

