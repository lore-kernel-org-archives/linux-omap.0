From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 28/41] ARM: dts: omap3 clock data
Date: Tue, 17 Dec 2013 09:50:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170950150.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-29-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54386 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab3LQJuw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 04:50:52 -0500
In-Reply-To: <1385453182-24421-29-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> This patch creates a unique node for each clock in the OMAP3 power,
> reset and clock manager (PRCM).
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>


> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index f3a0c26..9e6ea02 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -82,6 +82,27 @@
>  		ranges;
>  		ti,hwmods = "l3_main";
>  
> +		prm: prm@48306000 {
> +			compatible = "ti,clock-master";

Likewise, same issues here with the compatible strings and
separating out the clocks and clockdomain data into separate DT
nodes, as discussed with the OMAP4 data patch.



- Paul
