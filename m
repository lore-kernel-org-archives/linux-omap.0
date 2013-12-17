From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 22/41] ARM: dts: omap5 clock data
Date: Tue, 17 Dec 2013 09:46:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170944250.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-23-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54317 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab3LQJqF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 04:46:05 -0500
In-Reply-To: <1385453182-24421-23-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> This patch creates a unique node for each clock in the OMAP5 power,
> reset and clock manager (PRCM).
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

...

> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 17fe896..3920087 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -107,6 +107,34 @@
>  		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>  
> +		prm: prm@4ae06000 {
> +			compatible = "ti,clock-master";

Same issues here with the compatible strings and separating out the clocks 
and clockdomain data into separate DT nodes, as discussed with the OMAP4 
data patch.


- Paul
