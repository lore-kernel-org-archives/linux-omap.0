From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 2/4] ARM: dts: Add ctrl-core DT node for DRA7
Date: Fri, 18 Apr 2014 10:18:54 -0700
Message-ID: <20140418171854.GJ5354@atomide.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
 <1397654063-8055-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46945 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbaDRRS7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 13:18:59 -0400
Content-Disposition: inline
In-Reply-To: <1397654063-8055-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Archit Taneja <archit@ti.com> [140416 06:20]:
> Add DT node for the ctrl-core sub module of the DRA7 control module. We map the
> CTRL_MODULE_CORE address region up to 0x4a002d60, this region contains register
> fields which configure clocks. The remainder of the registers are related to
> pad configurations or cross-bar configurations, and therefore aren't mapped.

Can you please check if this can just use the existing
regmap syscon mapping:

syscon = <&dra7_ctrl_general>;

See how the drivers/regulator/pbias-regulator.c is using the
syscon to initialize a regulator and then omap_hsmmc.c just does
the standard regulator calls.

Depending what the range 0x4a002000 0x6d0 contains, you may
want to set it up as another syscon area.

Regards,

Tony

 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 1c0f8e1..58bbdf3 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -148,6 +148,19 @@
>  			};
>  		};
>  
> +		ctrl_core: ctrl_core@4a002000 {
> +			compatible = "ti,dra7-ctrl-core";
> +			reg = <0x4a002000 0x6d0>;
> +
> +			ctrl_core_clocks: clocks {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			ctrl_core_clockdomains: clockdomains {
> +			};
> +		};
> +
>  		counter32k: counter@4ae04000 {
>  			compatible = "ti,omap-counter32k";
>  			reg = <0x4ae04000 0x40>;
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
