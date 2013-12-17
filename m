From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 30/41] ARM: dts: am43xx clock data
Date: Tue, 17 Dec 2013 09:52:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170951360.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-31-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54408 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab3LQJwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 04:52:15 -0500
In-Reply-To: <1385453182-24421-31-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> This patch creates a unique node for each clock in the AM43xx power,
> reset and clock manager (PRCM).
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

...

> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 974d103..18f2401 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -67,6 +67,20 @@
>  		ranges;
>  		ti,hwmods = "l3_main";
>  
> +		prcm: prcm@44df0000 {
> +			compatible = "ti,clock-master";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x44df0000 0x11000>;
> +		};
> +
> +		scrm: scrm@44e10000 {
> +			compatible = "ti,clock-master";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x44e10000 0x2000>;
> +		};

Same issues here with the compatible strings and
separating out the clocks and clockdomain data into separate DT
nodes, as discussed with the OMAP4 data patch.


- Paul
