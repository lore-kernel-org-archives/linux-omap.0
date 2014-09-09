From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: Add names for remaining
 regulators
Date: Mon, 8 Sep 2014 17:19:35 -0700
Message-ID: <20140909001935.GD10785@atomide.com>
References: <1409951525-30035-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54584 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754383AbaIIATk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 20:19:40 -0400
Content-Disposition: inline
In-Reply-To: <1409951525-30035-1-git-send-email-broonie@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org

* Mark Brown <broonie@kernel.org> [140905 14:12]:
> Add regulator-name properties for the regulators that don't have them,
> allowing the kernel to display the name from the schematic rather than
> the name of the regulator on the PMIC in order to improve diagnostics.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Applying into omap-for-v3.18/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index bde1777b62be..fe983d204b2b 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -227,6 +227,7 @@
>  &tps {
>  	regulators {
>  		dcdc1_reg: regulator@0 {
> +			regulator-name = "vdds_dpr";
>  			regulator-always-on;
>  		};
>  
> @@ -249,18 +250,22 @@
>  		};
>  
>  		ldo1_reg: regulator@3 {
> +			regulator-name = "vio,vrtc,vdds";
>  			regulator-always-on;
>  		};
>  
>  		ldo2_reg: regulator@4 {
> +			regulator-name = "vdd_3v3aux";
>  			regulator-always-on;
>  		};
>  
>  		ldo3_reg: regulator@5 {
> +			regulator-name = "vdd_1v8";
>  			regulator-always-on;
>  		};
>  
>  		ldo4_reg: regulator@6 {
> +			regulator-name = "vdd_3v3a";
>  			regulator-always-on;
>  		};
>  	};
> -- 
> 2.1.0
> 
