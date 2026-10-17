Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC042AD77;
	Sat, 17 Oct 2026 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792221754; cv=none; b=ckTuVseROwjXSUNt10PaICR3PpXwe61p3+qRvB0CFjgpZweQLuSScKebohFXlwlqPabxSIu/y2wDgks6YYhowhuDPDA5k2BcbO5Khg070LmeuO9uBzO4Cfqwy2hjqQwepH9Bwsb06rB+/bMmMgpVxizXfOAi4V4SM79WYIg9HYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792221754; c=relaxed/simple;
	bh=4tlM9DH26Jk6K9xCLPb1uHMYubLY+sTMCGdKo5juFPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlMpK6LagHzHfZz2nRtOoAy0l6db6OCiRQVQ0dNGPvJsR23LaOmTY0FPXjkj2jEMvX2FY3EkCQNC1sRYUurt4I64DQwL8GuJnyRndJnPbv5E08DXZHHUCaPGYre0dfa1H1Dx4ORW9VSG0aw7ZF3zouiSu+hmwQGYSc2zG6wNiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=v6DqruYv; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="v6DqruYv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=PANH83LO9KrofHVTq/98fVVjN62lrjOODBRAe7r1vek=; t=1792221751; x=1793431351; 
	b=v6DqruYvktfGsukun84zvQb/WAe/b4thD4K1wOw0VuqGIbjQsxOYOr2JqCuS0FzDfKHEG+j2uJG
	akTaeaIHt8fNTy8rDPYDQbCdZkuq9eLajmQizkECnI0ZsNN5qz7g7BC+oT0bm6InTIPuSefF+vBH7
	rkrmVyH1NevNmF94zSpLHuH6WWQisPeb77Y3LDNXLl9NKV+qxJ9hhAqjLxa/lAXUnhJejfXm0XeRu
	I77wYK1KbRDGZB7SxvQjhL8WP71c6EbcJHcvDgAyNK0Xvkn5XconU7yPPPr+383CPZuX/axM3vsqR
	reNLwbaNW4gLKrqiZHMGjgzExBViDxuQn3lQ==;
Date: Sat, 17 Oct 2026 08:39:57 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Christopher Obbard
 <chris.obbard@oss.qualcomm.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Linus Walleij <linusw@kernel.org>, Rouven
 Czerwinski <rouven.czerwinski@linaro.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 06/10] ARM: dts: omap: dm816x: Update USB node
Message-ID: <20261017083957.7c2696f5@kemnade.info>
In-Reply-To: <20261016-patch-ektor5-dm8168-dts-v1-6-b4ce30217028@linaro.org>
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
	<20261016-patch-ektor5-dm8168-dts-v1-6-b4ce30217028@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 16:41:21 +0200
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> From: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> USB node was not working correctly with DMA enabled as the supporting
> code had been updated without updating this SoC's device tree. Bring the
> device tree more up to date so that it works with DMA enabled.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> ---
>  arch/arm/boot/dts/ti/omap/dm816x.dtsi | 41 +++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> index 7f3ef3a00ab8..5be9efc60785 100644
> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> @@ -574,18 +574,27 @@ uart3: serial@48024000 {
>  		};
>  
>  		/* NOTE: USB needs a transceiver driver for phys to work */
> -		usb: usb_otg_hs@47401000 {
> -			compatible = "ti,am33xx-usb";
> -			reg = <0x47401000 0x400000>;
> -			ranges;
> +		usb: target-module@47400000 {
> +			compatible = "ti,sysc-omap4", "ti,sysc";
> +			ti,hwmods = "usb_otg_hs";

Why do we still need this? It is depcrecated.

Regards,
Andreas
