Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292294;
	b=26qVE4kyc6oFUSPpGzJdWVZEoz27gY022NRR2iPSjL+6JIdbZXvjH+sdzXxnu/YaFSC3
	 1R4T+gKLgi+sW/t6ZLlfjUDCpfVIRkWeOi32SZHJLjcoDkRPNV/IED5YoHvgh5AmGsc4x
	 o5OX1LBbfaTs5w2DPAsQ04MkFihkQc+vSg/6cHAA3/QDNSbQHFJZEQL9IdJFC7DnBmyuQ
	 Kq8gcr4GFd1aiLVyibkJjY5uI7EcvfLsMPLx2mtJVqHFPJrwUXVQh4B639uTVVdbho7xX
	 5k37GU87YqvpQ+HUJG8S03DJa0ClvBFkmRU3mS0LQvwmt0MLT0ve31UqDCf0xB5as9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292294;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pJFFAlvHvpv/DNb0ovxFiTKs4dBdzL3exBW92NJume8=;
	b=06wvy2WFUjo22S8czKLFREvgeUJmuQwIaeVFSofz1I6L7FubDZ0nT+Mpa3h6xMCn+DJx
	 aqoPguZJzXiHypYXNAgUv4SkT5ie3mfrYQEslxrc0moOEd9q6doZ+Oe7i/fvTn4HqvBtG
	 OYF8lplI1S0CHkAKZ2a+/pvPaq/6rBtjjNQaFZZNGlU95Tgkc1k23/27JZ4VsssUPMywY
	 oqEUT2zLnde9TZ/Mfs2STIdrYbnlZzFGWmyiCR/Cdlkx6eOkUbHjhJpmsDNUhzr14VKuZ
	 CS83Vttopt5oMI7H07bNHW1BeLdiUsNPsnStbJ4abLTQqgiZTZxPsPXFOaR9cEb7/Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=IRsjWwn9;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC8606A31C;
	Tue, 10 Nov 2026 06:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FCC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=IRsjWwn9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=pJFFAlvHvpv/DNb0ovxFiTKs4dBdzL3exBW92NJume8=; t=1794292293; x=1795501893; 
	b=IRsjWwn9JUuBB77lN5SpOhKFN8eK0drtAfJP0YLHUOv4Hbn8WfOtoljfaftpAgigza/hgkZ8SzI
	KZaeAkW1VHG2V76FzyX3nmhugdMzGhXOHC/LbT5ZARoQfetfzP/INd0b4aHkyJZ+t/Y6V4p7cvFKJ
	keVOKwaaEFF+b+Zo46MN3oK0dQw67F+GCLG88/MuCKIR8n1QZNffXF5HduRIvvLl/A/jhcJkmo92L
	WTSCxOqg6onbK6MkUTOJdRLyCceC3bcQIUBS5+7jlQvtRjmFJhSClwddetonVAZ9kGSqkPm3yHvkh
	aTxmUWYYnhntH3zSfgwqmNAe1XT9zZOxKmTg==;
Date: Tue, 10 Nov 2026 07:31:26 +0100
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
Subject: Re: [PATCH v3 6/9] ARM: dts: omap: dm816x: Update USB node
Message-ID: <20261110073126.5c434695@kemnade.info>
In-Reply-To: <20261102-patch-ektor5-dm8168-dts-v3-6-9bd6d1d128f2@linaro.org>
References: <20261102-patch-ektor5-dm8168-dts-v3-0-9bd6d1d128f2@linaro.org>
	<20261102-patch-ektor5-dm8168-dts-v3-6-9bd6d1d128f2@linaro.org>
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

On Mon, 02 Nov 2026 20:52:52 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> From: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> USB node was not working correctly with DMA enabled as the supporting
> code had been updated without updating this SoC's device tree. Bring the
> device tree more up to date so that it works with DMA enabled.
> Removing deprecated usb_otg_hs `ti,hwmods` property in DT node in favour
> of ti-sysc implementation.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/ti/omap/dm816x.dtsi | 40 +++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> index 1e8d225dfb2c..314e5e580c8b 100644
> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> @@ -573,18 +573,26 @@ uart3: serial@48024000 {
>  		};
>  
>  		/* NOTE: USB needs a transceiver driver for phys to work */
> -		usb: usb_otg_hs@47401000 {
> -			compatible = "ti,am33xx-usb";
> -			reg = <0x47401000 0x400000>;
> -			ranges;
> +		usb: target-module@47400000 {
> +			compatible = "ti,sysc-omap4", "ti,sysc";
> +			reg = <0x47400000 0x4>,
> +			      <0x47400010 0x4>;
> +			reg-names = "rev", "sysc";
> +			ti,sysc-mask = <SYSC_OMAP4_SOFTRESET>;
> +			ti,sysc-midle = <SYSC_IDLE_FORCE>,
> +					<SYSC_IDLE_SMART>;
> +			ti,sysc-sidle = <SYSC_IDLE_SMART>;
> +			ti,sysc-delay-us = <2>;
> +			clocks = <&default_clkctrl DM816_USB_OTG_HS_CLKCTRL 0>;
> +			clock-names = "fck";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ti,hwmods = "usb_otg_hs";
> +			ranges = <0x0 0x47400000 0x8000>;
>  
> -			usb0: usb@47401000 {
> +			usb0: usb@1400 {
>  				compatible = "ti,musb-dm816";
> -				reg = <0x47401400 0x400
> -				       0x47401000 0x200>;
> +				reg = <0x1400 0x400>,
> +				      <0x1000 0x200>;
>  				reg-names = "mc", "control";
>  				interrupts = <18>;
>  				interrupt-names = "mc";
> @@ -621,10 +629,10 @@ &cppi41dma 11 1 &cppi41dma 12 1
>  					"tx14", "tx15";
>  			};
>  
> -			usb1: usb@47401800 {
> +			usb1: usb@1c00 {
>  				compatible = "ti,musb-dm816";
> -				reg = <0x47401c00 0x400
> -				       0x47401800 0x200>;
> +				reg = <0x1c00 0x400>,
> +				      <0x1800 0x200>;
>  				reg-names = "mc", "control";
>  				interrupts = <19>;
>  				interrupt-names = "mc";
> @@ -661,12 +669,12 @@ &cppi41dma 26 1 &cppi41dma 27 1
>  					"tx14", "tx15";
>  			};
>  
> -			cppi41dma: dma-controller@47402000 {
> +			cppi41dma: dma-controller@2000 {
>  				compatible = "ti,am3359-cppi41";
> -				reg = <0x47400000 0x1000>,
> -				      <0x47402000 0x1000>,
> -				      <0x47403000 0x1000>,
> -				      <0x47404000 0x4000>;
> +				reg =  <0x0000 0x1000>,
> +				       <0x2000 0x1000>,
> +				       <0x3000 0x1000>,
> +				       <0x4000 0x4000>;
>  				reg-names = "glue", "controller", "scheduler", "queuemgr";
>  				interrupts = <17>;
>  				interrupt-names = "glue";
> 

