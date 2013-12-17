From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 27/41] ARM: dts: am33xx clock data
Date: Tue, 17 Dec 2013 09:48:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170947160.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-28-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54366 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab3LQJsS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 04:48:18 -0500
In-Reply-To: <1385453182-24421-28-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> This patch creates a unique node for each clock in the AM33xx power,
> reset and clock manager (PRCM).
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

...

> ---
>  arch/arm/boot/dts/am33xx-clocks.dtsi |  662 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/am33xx.dtsi        |   16 +
>  2 files changed, 678 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am33xx-clocks.dtsi
> 

...

> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index f6d8ffe..52c46e1 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -102,6 +102,20 @@
>  		ranges;
>  		ti,hwmods = "l3_main";
>  
> +		prcm: prcm@44e00000 {
> +			compatible = "ti,clock-master";

Same issues here with the compatible strings and separating out the
clocks and clockdomain data into separate DT nodes, as discussed with
the OMAP4 data patch.


- Paul
