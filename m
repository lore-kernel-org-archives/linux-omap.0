From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: DRA7: wdt: Fix compatible property for
 watchdog node
Date: Wed, 12 Nov 2014 07:28:54 -0800
Message-ID: <20141112152853.GH26481@atomide.com>
References: <1415769855-32565-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61622 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbaKLP3d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 10:29:33 -0500
Content-Disposition: inline
In-Reply-To: <1415769855-32565-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, nsekhar@ti.com, t-kristo@ti.com

* Lokesh Vutla <lokeshvutla@ti.com> [141111 21:27]:
> OMAP wdt driver supports only ti,omap3-wdt compatible. In DRA7 dt
> wdt compatible property is defined as ti,omap4-wdt by mistake instead of
> ti,omap3-wdt. Correcting the typo.
> 
> Fixes: 6e58b8f1daaf1a ("ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board")
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks applying into omap-for-v3.19/fixes-not-urgent as this is
a feature that clearly never worked on dra7xx with mainline kernel.

Regards,

Tony

> ---
>  arch/arm/boot/dts/dra7.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 9cc9843..666e796 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -653,7 +653,7 @@
>  		};
>  
>  		wdt2: wdt@4ae14000 {
> -			compatible = "ti,omap4-wdt";
> +			compatible = "ti,omap3-wdt";
>  			reg = <0x4ae14000 0x80>;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>  			ti,hwmods = "wd_timer2";
> -- 
> 1.9.1
> 
