From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH/RFC] ARM: omap3: Split the pinmux core device
Date: Wed, 4 Dec 2013 09:28:53 -0800
Message-ID: <20131204172852.GP26766@atomide.com>
References: <1386177110-26424-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386177110-26424-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, sakari.ailus-X3B1VOXEql0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [131204 09:12]:
> The omap3_pmx_core pinmux device in the device tree handles the system
> controller module (SCM) PADCONFS fonction. Its control registers are
> split in two distinct areas, with other SCM registers in-between. Those
> other registers can't thus be requested by other drivers as the memory
> region gets reserved by the pinmux driver.
> 
> Split the omap3_pmx_core device tree node in two for the two memory
> regions.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3-beagle-xm.dts | 45 ++++++++++++++++++++++++++++-------
>  arch/arm/boot/dts/omap3-beagle.dts    | 28 +++++++++++++++-------
>  arch/arm/boot/dts/omap3-igep0020.dts  | 26 ++++++++++----------
>  arch/arm/boot/dts/omap3-zoom3.dts     | 19 ++++++++++-----
>  arch/arm/boot/dts/omap3.dtsi          | 13 +++++++++-
>  5 files changed, 95 insertions(+), 36 deletions(-)
> 
> While working on the OMAP3 ISP driver I've run into a failure to request a
> memory region already requested by the pinctrl-single driver. This patch is an
> attempt to fix the problem. An alternative approach would be to support
> multiple reg values in the pinctrl-single driver, but that might not be much
> cleaner. I'm open to suggestions.

Makes sense to me to split it into two, we can save some memory that way too.

It should not cause problems with the wake-up interrupts either as we're
already using a single chained wake-up interrupt between core and wkup
pins.

Do you have some perl or sed script to look for and convert the core2
registers? Or do we just not have that many of them defined yet?

Regards,

Tony
 
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index 8d7c813..7028e6a 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -103,7 +103,7 @@
>  &omap3_pmx_core {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <
> -			&hsusbb2_pins
> +			&hsusb2_pins
>  	>;
>  
>  	uart3_pins: pinmux_uart3_pins {
> @@ -113,14 +113,8 @@
>  		>;
>  	};
>  
> -	hsusbb2_pins: pinmux_hsusbb2_pins {
> +	hsusb2_pins: pinmux_hsusb2_pins {
>  		pinctrl-single,pins = <
> -			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
> -			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
> -			0x5c4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
> -			0x5c6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
> -			0x5c8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
> -			0x5cA (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
>  			0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
>  			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
>  			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
> @@ -131,6 +125,24 @@
>  	};
>  };
>  
> +&omap3_pmx_core2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +			&hsusb2_2_pins
> +	>;
> +
> +	hsusb2_2_pins: pinmux_hsusb2_2_pins {
> +		pinctrl-single,pins = <
> +			0x050 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
> +			0x052 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
> +			0x054 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
> +			0x056 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
> +			0x058 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
> +			0x05a (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
> +		>;
> +	};
> +};
> +
>  &i2c1 {
>  	clock-frequency = <2600000>;
>  
> @@ -152,6 +164,23 @@
>  
>  &i2c2 {
>  	clock-frequency = <400000>;
> +
> +	switch@73 {
> +		compatible = "nxp,pca9543";
> +		reg = <0x73>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
>  };
>  
>  &i2c3 {
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 9764556..d2c7322 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -85,17 +85,11 @@
>  &omap3_pmx_core {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <
> -			&hsusbb2_pins
> +			&hsusb2_pins
>  	>;
>  
> -	hsusbb2_pins: pinmux_hsusbb2_pins {
> +	hsusb2_pins: pinmux_hsusb2_pins {
>  		pinctrl-single,pins = <
> -			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
> -			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
> -			0x5c4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
> -			0x5c6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
> -			0x5c8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
> -			0x5cA (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
>  			0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
>  			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
>  			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
> @@ -113,6 +107,24 @@
>  	};
>  };
>  
> +&omap3_pmx_core2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +			&hsusb2_2_pins
> +	>;
> +
> +	hsusb2_2_pins: pinmux_hsusb2_2_pins {
> +		pinctrl-single,pins = <
> +			0x050 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
> +			0x052 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
> +			0x054 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
> +			0x056 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
> +			0x058 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
> +			0x05a (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
> +		>;
> +	};
> +};
> +
>  &i2c1 {
>  	clock-frequency = <2600000>;
>  
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
> index d5cc792..0f77be8 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -63,7 +63,7 @@
>  	};
>  };
>  
> -&omap3_pmx_core {
> +&omap3_pmx_core2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <
>  		&hsusbb1_pins
> @@ -71,18 +71,18 @@
>  
>  	hsusbb1_pins: pinmux_hsusbb1_pins {
>  		pinctrl-single,pins = <
> -			0x5aa (PIN_OUTPUT | MUX_MODE3)		/* etk_ctl.hsusb1_clk */
> -			0x5a8 (PIN_OUTPUT | MUX_MODE3)		/* etk_clk.hsusb1_stp */
> -			0x5bc (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d8.hsusb1_dir */
> -			0x5be (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d9.hsusb1_nxt */
> -			0x5ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d0.hsusb1_data0 */
> -			0x5ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d1.hsusb1_data1 */
> -			0x5b0 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d2.hsusb1_data2 */
> -			0x5b2 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
> -			0x5b4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d4.hsusb1_data4 */
> -			0x5b6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d5.hsusb1_data5 */
> -			0x5b8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d6.hsusb1_data6 */
> -			0x5ba (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d7.hsusb1_data3 */
> +			0x03a (PIN_OUTPUT | MUX_MODE3)		/* etk_ctl.hsusb1_clk */
> +			0x038 (PIN_OUTPUT | MUX_MODE3)		/* etk_clk.hsusb1_stp */
> +			0x04c (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d8.hsusb1_dir */
> +			0x04e (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d9.hsusb1_nxt */
> +			0x03c (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d0.hsusb1_data0 */
> +			0x03e (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d1.hsusb1_data1 */
> +			0x040 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d2.hsusb1_data2 */
> +			0x042 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
> +			0x044 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d4.hsusb1_data4 */
> +			0x046 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d5.hsusb1_data5 */
> +			0x048 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d6.hsusb1_data6 */
> +			0x04a (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d7.hsusb1_data3 */
>  		>;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
> index 15eb9fe..a1bec6b 100644
> --- a/arch/arm/boot/dts/omap3-zoom3.dts
> +++ b/arch/arm/boot/dts/omap3-zoom3.dts
> @@ -82,11 +82,6 @@
>  		pinctrl-single,pins = <
>  			0x168 (PIN_INPUT | MUX_MODE4)	/* mcbsp1_clkx.gpio_162 WLAN IRQ */
>  			0x1a0 (PIN_INPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs1.sdmmc3_cmd */
> -			0x5a8 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_clk.sdmmc3_clk */
> -			0x5b4 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d4.sdmmc3_dat0 */
> -			0x5b6 (WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE2) /* etk_d5.sdmmc3_dat1 */
> -			0x5b8 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d6.sdmmc3_dat2 */
> -			0x5b2 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d3.sdmmc3_dat3 */
>  		>;
>  	};
>  
> @@ -125,6 +120,18 @@
>  	};
>  };
>  
> +&omap3_pmx_core2 {
> +	mmc3_2_pins: pinmux_mmc3_2_pins {
> +		pinctrl-single,pins = <
> +			0x038 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_clk.sdmmc3_clk */
> +			0x044 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d4.sdmmc3_dat0 */
> +			0x046 (WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE2) /* etk_d5.sdmmc3_dat1 */
> +			0x048 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d6.sdmmc3_dat2 */
> +			0x042 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d3.sdmmc3_dat3 */
> +		>;
> +	};
> +};
> +
>  &omap3_pmx_wkup {
>  	wlan_host_wkup: pinmux_wlan_host_wkup_pins {
>  		pinctrl-single,pins = <
> @@ -187,7 +194,7 @@
>  	bus-width = <4>;
>  	cap-power-off-card;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc3_pins>;
> +	pinctrl-0 = <&mmc3_pins &mmc3_2_pins>;
>  };
>  
>  &uart1 {
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index f3a0c26..c740e28 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -110,7 +110,18 @@
>  
>  		omap3_pmx_core: pinmux@48002030 {
>  			compatible = "ti,omap3-padconf", "pinctrl-single";
> -			reg = <0x48002030 0x05cc>;
> +			reg = <0x48002030 0x0238>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			pinctrl-single,register-width = <16>;
> +			pinctrl-single,function-mask = <0xff1f>;
> +		};
> +
> +		omap3_pmx_core2: pinmux@480025a0 {
> +			compatible = "ti,omap3-padconf", "pinctrl-single";
> +			reg = <0x480025a0 0x005c>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			#interrupt-cells = <1>;
> -- 
> 1.8.3.2
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
