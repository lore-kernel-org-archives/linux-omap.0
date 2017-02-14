From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Add dra7 iodelay configuration and use it for
 MMC
Date: Tue, 14 Feb 2017 10:51:21 -0800
Message-ID: <20170214185120.GL21809@atomide.com>
References: <20161230183732.5595-1-tony@atomide.com>
 <20161230183732.5595-3-tony@atomide.com>
 <20161230184914.GC3940@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161230184914.GC3940@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
Cc: Gary Bisson <gary.bisson@boundarydevices.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Nishanth,

* Tony Lindgren <tony@atomide.com> [161230 10:50]:
> Add dra7 iodelay configuration and use it for MMC.

I just noticed that this patch should probably be:

From: Nishanth Menon <nm@ti.com>

I think I just added the description to the patch.

Can you please confirm and reply with your Signed-off-by
if that's the case?

Regards,

Tony


> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 21 ++++++++++++++++++++-
>  arch/arm/boot/dts/dra7.dtsi                     |  8 ++++++++
>  include/dt-bindings/pinctrl/dra.h               |  4 ++++
>  3 files changed, 32 insertions(+), 1 deletion(-)
> ---
> 
> And ere are the related dts changes.
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> --- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> @@ -190,6 +190,25 @@
>  		>;
>  	};
>  };
> +
> +&dra7_iodelay_core
> +{
> +	mmc2_iodelay_3v3_conf: mmc2_iodelay_3v3_conf {
> +		pinctrl-pin-array = <
> +			0x18c A_DELAY_PS(0) G_DELAY_PS(120)	/* CFG_GPMC_A19_IN */
> +			0x1a4 A_DELAY_PS(265) G_DELAY_PS(360)	/* CFG_GPMC_A20_IN */
> +			0x1b0 A_DELAY_PS(0) G_DELAY_PS(120)	/* CFG_GPMC_A21_IN */
> +			0x1bc A_DELAY_PS(0) G_DELAY_PS(120)	/* CFG_GPMC_A22_IN */
> +			0x1c8 A_DELAY_PS(287) G_DELAY_PS(420)	/* CFG_GPMC_A23_IN */
> +			0x1d4 A_DELAY_PS(144) G_DELAY_PS(240)	/* CFG_GPMC_A24_IN */
> +			0x1e0 A_DELAY_PS(0) G_DELAY_PS(0)	/* CFG_GPMC_A25_IN */
> +			0x1ec A_DELAY_PS(120) G_DELAY_PS(0)	/* CFG_GPMC_A26_IN */
> +			0x1f8 A_DELAY_PS(120) G_DELAY_PS(180)	/* CFG_GPMC_A27_IN */
> +			0x360 A_DELAY_PS(0) G_DELAY_PS(0)	/* CFG_GPMC_CS1_IN */
> +		>;
> +	};
> +};
> +
>  &i2c1 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> @@ -452,7 +471,7 @@
>  	status = "okay";
>  
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc2_pins_default>;
> +	pinctrl-0 = <&mmc2_pins_default &mmc2_iodelay_3v3_conf>;
>  
>  	vmmc-supply = <&vdd_3v3>;
>  	bus-width = <8>;
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -401,6 +401,14 @@
>  			reg = <0x40d00000 0x100>;
>  		};
>  
> +		dra7_iodelay_core: padconf@4844a000 {
> +			compatible = "ti,dra7-iodelay";
> +			reg = <0x4844a000 0x0d1c>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#pinctrl-cells = <2>;
> +		};
> +
>  		sdma: dma-controller@4a056000 {
>  			compatible = "ti,omap4430-sdma";
>  			reg = <0x4a056000 0x1000>;
> diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
> --- a/include/dt-bindings/pinctrl/dra.h
> +++ b/include/dt-bindings/pinctrl/dra.h
> @@ -73,5 +73,9 @@
>   */
>  #define DRA7XX_CORE_IOPAD(pa, val)	(((pa) & 0xffff) - 0x3400) (val)
>  
> +/* DRA7 IODELAY configuration parameters */
> +#define A_DELAY_PS(val)		((val) & 0xffff)
> +#define G_DELAY_PS(val)		((val) & 0xffff)
> +
>  #endif
>  
> -- 
> 2.11.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
