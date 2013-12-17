From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 23/41] ARM: dts: dra7 clock data
Date: Tue, 17 Dec 2013 09:46:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170946110.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-24-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54344 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab3LQJqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 04:46:45 -0500
In-Reply-To: <1385453182-24421-24-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> This patch creates a unique node for each clock in the DRA7 power,
> reset and clock manager (PRCM).
> 
> TODO: apll_pcie clock node is still a dummy in this version, and
> proper support for the APLL should be added.

...

> ---
>  arch/arm/boot/dts/dra7.dtsi          |   23 +
>  arch/arm/boot/dts/dra7xx-clocks.dtsi | 1983 ++++++++++++++++++++++++++++++++++
>  2 files changed, 2006 insertions(+)
>  create mode 100644 arch/arm/boot/dts/dra7xx-clocks.dtsi
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index d0df4c4..6cf1c76 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -104,6 +104,27 @@
>  		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>  
> +		prm: prm@4ae06000 {
> +			compatible = "ti,clock-master";


Likewise, same issues here with the compatible strings and
separating out the clocks and clockdomain data into separate DT
nodes, as discussed with the OMAP4 data patch.


- Paul
