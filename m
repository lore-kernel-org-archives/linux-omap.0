Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291688;
	b=GPsECR8wdfxAGFleaPzo1uss5ooj6rICx9QX91IJIXgSScAqo2LjV4Y0P2AwN9wb8JUg
	 I5ehnhsZCVnFeWh1Z00vUjWLCVCH3G7N2H6hIYb62EEhzFmp6f4AccgpoyuU02MZvfMVc
	 8VDdVk32gDhnZwkYg0EeIkkiFdI6fCoPqbM7+/8cZiKrs2sigeKnSK6kFnCU2WirSDGp1
	 O3gYhtJI0WtCTfEWdQP4JD7+ALH96SMJG19Jz4q3AWnJu4aWvkSi1JhtMD3s7uIZ5s+Vs
	 nMZ2Cvh7AwyeI7RYdQsYvRP6II4KNUcgFLFgkCceQKfEjJv3OPppA/fyjgD7cKxgZlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291688;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=elK6mDMEKfMlZvs1P5YKG6wAktFva3W0qwlwydywoP8=;
	b=BAxLKIc1IUQBpRX0R1t/dG/JD7//qjhrjI1TmZmrES+ytNstprZlohrG1IycTx8bMpU8
	 FzpZBcy7SStR2dk7BOwj9AJkIdaqG5iI7F89M16yjgtUUNJykm1AGky26gz+smp9T+fe1
	 JAUxVby9QKN5lTbGqAQ22vUjw0lVqJFI2+0RyYu16snuQsfdCaocviKHXINvFcSqamQZd
	 tKz2SBo1kYQ9wowmTeGasg2gZfml6i8h2mX8ahWAbYDIRGUBOfnR0P46PBr6/XC9CBmBa
	 XwyZogMTAloTFe68WxYZaCSM9UFeizsgv+ooSAbJBIi1br/U/jrBQZy8KBoeoq/Y+bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=WCGc5w2x;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72D606A31C;
	Tue, 10 Nov 2026 06:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B72D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=WCGc5w2x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=elK6mDMEKfMlZvs1P5YKG6wAktFva3W0qwlwydywoP8=; t=1794291688; x=1795501288; 
	b=WCGc5w2x2nO3gLD0D19s8t9hmT/KnzVObkzYPclcnExoC8azSnVtMZ7hvoglFZPJcTK9bo90A5P
	iPG2WvtV7Vqn4DeOA8A4ZiiEMYTLicCIb0dIwi3dqGHY8T5JWkhvvtIg05TdRibFM/SAKr7mfHUMB
	fJ87eWKPybpW/eUfgDQ0eXAiZlxQarZ6cQBtSCU8A/X7aAXZFIfExe8W9+uQX5NZiqgG74FbYK1dR
	uylwsSxjiDuf8YLljZaA62yVTNn+QoKn60P/zZ1QH7XB2SO0qRkykPY7z2pp5sQpsXiWWs2F00eqo
	TsckaL1/DQsRY99pyUg1WkejDvQdb7T3voxQ==;
Date: Tue, 10 Nov 2026 07:21:18 +0100
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
Subject: Re: [PATCH v3 4/9] ARM: dts: omap: dm816x: refactor and align MMC
 node
Message-ID: <20261110072118.1f1d5148@kemnade.info>
In-Reply-To: <20261102-patch-ektor5-dm8168-dts-v3-4-9bd6d1d128f2@linaro.org>
References: <20261102-patch-ektor5-dm8168-dts-v3-0-9bd6d1d128f2@linaro.org>
	<20261102-patch-ektor5-dm8168-dts-v3-4-9bd6d1d128f2@linaro.org>
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

On Mon, 02 Nov 2026 20:52:50 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> From: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> Update the MMC node in the TI Sitara DM816x device tree to align with
> the structure used in other similar SoCs. The changes include
> refactoring the node to better describe the target module and its
> sub-nodes. Also removing deprecated MMC `ti,hwmods` property in favour of
> ti-sysc implementation.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  arch/arm/boot/dts/ti/omap/dm816x.dtsi | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> index fc124f9ecfa1..1e8d225dfb2c 100644
> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> @@ -423,13 +423,33 @@ &edma 20 0 &edma 21 0
>  				    "tx2", "rx2", "tx3", "rx3";
>  		};
>  
> -		mmc1: mmc@48060000 {
> -			compatible = "ti,omap4-hsmmc";
> -			reg = <0x48060000 0x11000>;
> -			ti,hwmods = "mmc1";
> -			interrupts = <64>;
> -			dmas = <&edma 24 0 &edma 25 0>;
> -			dma-names = "tx", "rx";
> +		mmc1_target: target-module@48060000 {
> +			compatible = "ti,sysc-omap2", "ti,sysc";
> +			reg = <0x48060000 0x4>,
> +			      <0x48060110 0x4>,
> +			      <0x48060114 0x4>;
> +			reg-names = "rev", "sysc", "syss";
> +			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
> +					 SYSC_OMAP2_ENAWAKEUP |
> +					 SYSC_OMAP2_SOFTRESET |
> +					 SYSC_OMAP2_AUTOIDLE)>;
> +			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> +					<SYSC_IDLE_NO>,
> +					<SYSC_IDLE_SMART>;
> +			ti,syss-mask = <1>;
> +			clocks = <&alwon_clkctrl DM816_MMC1_CLKCTRL 0>;
> +			clock-names = "fck";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x48060000 0x11000>;
> +
> +			mmc1: mmc@0 {
> +				compatible = "ti,omap4-hsmmc";
> +				reg = <0x0 0x11000>;
> +				interrupts = <64>;
> +				dmas = <&edma 24 0 &edma 25 0>;
> +				dma-names = "tx", "rx";
> +			};
>  		};
>  
>  		timer1_target: target-module@4802e000 {
> 

