From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Configure USB host for 37xx-evm
Date: Tue, 23 May 2017 10:37:30 +0300
Message-ID: <921f6aa1-d410-0942-6ddd-692377acb349@ti.com>
References: <20170522160647.9606-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170522160647.9606-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-GB
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 22/05/17 19:06, Tony Lindgren wrote:
> Looks like nobody bothered to configure USB host for 37xx-evm
> when we converted things to device tree, so let's add it. This
> is similar to beagleboard configuration with few extra quirks
> to configure the port. And as with beagleboard, OHCI won't work
> because there is no USB LS/FS PHY. A HS USB hub is needed to use
> devices like keyboard and mice.
> 
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3-evm-37xx.dts    | 82 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-evm-common.dtsi | 33 +++++++++++++
>  2 files changed, 115 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
> --- a/arch/arm/boot/dts/omap3-evm-37xx.dts
> +++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
> @@ -98,6 +98,32 @@
>  		>;
>  	};
>  
> +	hsusb2_pins: pinmux_hsusb2_pins {
> +		pinctrl-single,pins = <
> +
> +		/* On-board EHCI USB2 gpmc_nbe1.gpio_61 */
> +		OMAP3_CORE1_IOPAD(0x20c8, PIN_OUTPUT | MUX_MODE4)

GPIO_61 looks like nUSB2_EN_1V8 from you comment. This is PHY power related and not hsusb2 related
so it should be in a different group?

> +
> +		/* mcspi1_cs3.hsusb2_data2 */
> +		OMAP3_CORE1_IOPAD(0x21d4, PIN_INPUT_PULLDOWN | MUX_MODE3)
> +
> +		/* mcspi2_clk.hsusb2_data7 */
> +		OMAP3_CORE1_IOPAD(0x21d6, PIN_INPUT_PULLDOWN | MUX_MODE3)
> +
> +		/* mcspi2_simo.hsusb2_data4 */
> +		OMAP3_CORE1_IOPAD(0x21d8, PIN_INPUT_PULLDOWN | MUX_MODE3)
> +
> +		/* mcspi2_somi.hsusb2_data5 */
> +		OMAP3_CORE1_IOPAD(0x21da, PIN_INPUT_PULLDOWN | MUX_MODE3)
> +
> +		/* mcspi2_cs0.hsusb2_data6 */
> +		OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT_PULLDOWN | MUX_MODE3)
> +
> +		/* mcspi2_cs1.hsusb2_data3 */
> +		OMAP3_CORE1_IOPAD(0x21de, PIN_INPUT_PULLDOWN | MUX_MODE3)
> +		>;
> +	};
> +
>  	wl12xx_gpio: pinmux_wl12xx_gpio {
>  		pinctrl-single,pins = <
>  			OMAP3_CORE1_IOPAD(0x2180, PIN_OUTPUT | MUX_MODE4)		/* uart1_cts.gpio_150 */
> @@ -112,6 +138,37 @@
>  	};
>  };
>  
> +&omap3_pmx_core2 {
> +	hsusb2_2_pins: pinmux_hsusb2_2_pins {
> +		pinctrl-single,pins = <
> +
> +		/* EHCI PHY reset GPIO etk_d7.gpio_21 */
> +		OMAP3630_CORE2_IOPAD(0x25ea, PIN_OUTPUT | MUX_MODE4)

GPIO_21 is PHY RESET related and not hsusb2 related. Can we have this in a pin group for hsusb2_phy?

Also, hsusb2_pins and hsusb2_2_pins are both related to hsusb2. In omap3-beagle.dts
we don't assign them to any node and they are just setup once at boot by pincltrl default.

> +
> +		/* EHCI VBUS etk_d8.gpio_22 */
> +		OMAP3630_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX_MODE4)

GPIO_21 is PHY power enable so can we have this in a pin group for hsusb2_power?

> +
> +		/* etk_d10.hsusb2_clk */
> +		OMAP3630_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)
> +
> +		/* etk_d11.hsusb2_stp */
> +		OMAP3630_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)
> +
> +		/* etk_d12.hsusb2_dir */
> +		OMAP3630_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)
> +
> +		/* etk_d13.hsusb2_nxt */
> +		OMAP3630_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)
> +
> +		/* etk_d14.hsusb2_data0 */
> +		OMAP3630_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)
> +
> +		/* etk_d15.hsusb2_data1 */
> +		OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)
> +		>;
> +	};
> +};
> +
>  &omap3_pmx_wkup {
>  	dss_dpi_pins2: pinmux_dss_dpi_pins1 {
>  		pinctrl-single,pins = <
> @@ -153,6 +210,31 @@
>  	pinctrl-0 = <&uart3_pins>;
>  };
>  
> +&hsusb2_power {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hsusb2_pins &hsusb2_2_pins>;
> +};
> +
> +/* GPIO_61 (nUSB2_EN_1V8) low for on-board EHCI USB2 interface */
> +&gpio2 {
> +	en_hsusb2_clk {

Is this GPIO_61 enabling 1V8 supply or clk? Node name should be fixed accordingly.

> +		gpio-hog;
> +		gpios = <29 GPIO_ACTIVE_HIGH>;

Should this be be GPIO_61?
Does this need to be a hog?

> +		output-low;
> +		line-name = "hsusb2 port";

Can line name be more revealing? e.g. hsusb2 power or hsusb2 clock?

> +	};
> +};
> +
> +/* T2_GPIO_2 low to route GPIO_61 to on-board devices */
> +&twl_gpio {
> +	en_hsusb2_clk {
> +		gpio-hog;
> +		gpios = <2 GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name = "en_hsusb2_clk";
> +	};
> +};
> +
>  &gpmc {
>  	ranges = <0 0 0x30000000 0x1000000>,	/* CS0: 16MB for NAND */
>  		 <5 0 0x2c000000 0x01000000>;
> diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
> --- a/arch/arm/boot/dts/omap3-evm-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
> @@ -12,6 +12,24 @@
>  		};
>  	};
>  
> +	/* HS USB Port 2 Power */
> +	hsusb2_power: hsusb2_power_reg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "hsusb2_vbus";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>; /* gpio_22 */
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +	};
> +
> +	/* HS USB Host PHY on PORT 2 */
> +	hsusb2_phy: hsusb2_phy {

Here we can put the PHY reset related pinmux group.

> +		compatible = "usb-nop-xceiv";
> +		reset-gpios = <&gpio1 21 GPIO_ACTIVE_LOW>; /* gpio_21 */
> +		vcc-supply = <&hsusb2_power>;
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  		ledb {
> @@ -143,6 +161,14 @@
>  			>;
>  };
>  
> +&usbhshost {
> +	port2-mode = "ehci-phy";
> +};
> +
> +&usbhsehci {
> +	phys = <0 &hsusb2_phy>;
> +};
> +
>  &usb_otg_hs {
>  	interface-type = <0>;
>  	usb-phy = <&usb2_phy>;
> @@ -159,3 +185,10 @@
>  		reg = <5 0 0xff>;
>  	};
>  };
> +
> +&vaux2 {
> +	regulator-name = "usb_1v8";
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <1800000>;
> +	regulator-always-on> +};
> 

-- 
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
