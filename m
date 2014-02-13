From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3 clocks: simplify ssi aliases
Date: Thu, 13 Feb 2014 14:49:14 -0800
Message-ID: <20140213224914.GD28216@atomide.com>
References: <52DE24DA.8050104@ti.com>
 <1390315061-14441-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15397 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbaBMWtb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 17:49:31 -0500
Content-Disposition: inline
In-Reply-To: <1390315061-14441-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>, Tero Kristo <t-kristo@ti.com>, mturquette@linaro.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [140121 06:39]:
> update aliases for the ssi clocks ssi_ssr_fck, ssi_sst_fck and ssi_ick
> to make them consistent for omap34xx and omap36xx. This makes it
> possible to reference the clocks from generic omap3 dts files.

Is this needed as a fix for v3.14-rc? If so, please let me know
and ack if you want me to take it.

Tony
 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
>  arch/arm/boot/dts/omap3430es1-clocks.dtsi              | 10 +++++-----
>  arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3430es1-clocks.dtsi b/arch/arm/boot/dts/omap3430es1-clocks.dtsi
> index 02f6c7f..6f31954 100644
> --- a/arch/arm/boot/dts/omap3430es1-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap3430es1-clocks.dtsi
> @@ -82,16 +82,16 @@
>  		ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>;
>  	};
>  
> -	ssi_ssr_fck_3430es1: ssi_ssr_fck_3430es1 {
> +	ssi_ssr_fck: ssi_ssr_fck_3430es1 {
>  		#clock-cells = <0>;
>  		compatible = "ti,composite-clock";
>  		clocks = <&ssi_ssr_gate_fck_3430es1>, <&ssi_ssr_div_fck_3430es1>;
>  	};
>  
> -	ssi_sst_fck_3430es1: ssi_sst_fck_3430es1 {
> +	ssi_sst_fck: ssi_sst_fck_3430es1 {
>  		#clock-cells = <0>;
>  		compatible = "fixed-factor-clock";
> -		clocks = <&ssi_ssr_fck_3430es1>;
> +		clocks = <&ssi_ssr_fck>;
>  		clock-mult = <1>;
>  		clock-div = <2>;
>  	};
> @@ -120,7 +120,7 @@
>  		clock-div = <1>;
>  	};
>  
> -	ssi_ick_3430es1: ssi_ick_3430es1 {
> +	ssi_ick: ssi_ick_3430es1 {
>  		#clock-cells = <0>;
>  		compatible = "ti,omap3-no-wait-interface-clock";
>  		clocks = <&ssi_l4_ick>;
> @@ -203,6 +203,6 @@
>  			 <&i2c1_ick>, <&uart2_ick>, <&uart1_ick>, <&gpt11_ick>,
>  			 <&gpt10_ick>, <&mcbsp5_ick>, <&mcbsp1_ick>,
>  			 <&omapctrl_ick>, <&aes2_ick>, <&sha12_ick>,
> -			 <&fshostusb_fck>, <&fac_ick>, <&ssi_ick_3430es1>;
> +			 <&fshostusb_fck>, <&fac_ick>, <&ssi_ick>;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi b/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
> index 8ed475d..877318c 100644
> --- a/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
> @@ -25,16 +25,16 @@
>  		ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>;
>  	};
>  
> -	ssi_ssr_fck_3430es2: ssi_ssr_fck_3430es2 {
> +	ssi_ssr_fck: ssi_ssr_fck_3430es2 {
>  		#clock-cells = <0>;
>  		compatible = "ti,composite-clock";
>  		clocks = <&ssi_ssr_gate_fck_3430es2>, <&ssi_ssr_div_fck_3430es2>;
>  	};
>  
> -	ssi_sst_fck_3430es2: ssi_sst_fck_3430es2 {
> +	ssi_sst_fck: ssi_sst_fck_3430es2 {
>  		#clock-cells = <0>;
>  		compatible = "fixed-factor-clock";
> -		clocks = <&ssi_ssr_fck_3430es2>;
> +		clocks = <&ssi_ssr_fck>;
>  		clock-mult = <1>;
>  		clock-div = <2>;
>  	};
> @@ -55,7 +55,7 @@
>  		clock-div = <1>;
>  	};
>  
> -	ssi_ick_3430es2: ssi_ick_3430es2 {
> +	ssi_ick: ssi_ick_3430es2 {
>  		#clock-cells = <0>;
>  		compatible = "ti,omap3-ssi-interface-clock";
>  		clocks = <&ssi_l4_ick>;
> @@ -193,6 +193,6 @@
>  			 <&i2c1_ick>, <&uart2_ick>, <&uart1_ick>, <&gpt11_ick>,
>  			 <&gpt10_ick>, <&mcbsp5_ick>, <&mcbsp1_ick>,
>  			 <&omapctrl_ick>, <&aes2_ick>, <&sha12_ick>,
> -			 <&ssi_ick_3430es2>;
> +			 <&ssi_ick>;
>  	};
>  };
> -- 
> 1.8.5.2
> 
