From: "Reizer, Eyal" <eyalr@ti.com>
Subject: RE: [PATCHv2] am437x-gp-evm: add wilink8 support
Date: Thu, 14 May 2015 12:44:12 +0000
Message-ID: <8665E2433BC68541A24DFFCA87B70F5B23666106@DFRE01.ent.ti.com>
References: <1430742264-2397-1-git-send-email-eyalr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41747 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420AbbENMot convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2015 08:44:49 -0400
In-Reply-To: <1430742264-2397-1-git-send-email-eyalr@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eyal Reizer <eyalreizer@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "tony@atomide.com" <tony@atomide.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ping on this patch

> -----Original Message-----
> From: Eyal Reizer [mailto:eyalreizer@gmail.com]
> Sent: Monday, May 04, 2015 3:24 PM
> To: bcousson@baylibre.com; tony@atomide.com; robh+dt@kernel.org;
> pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org;
> linux@arm.linux.org.uk; linux-omap@vger.kernel.org
> Cc: Reizer, Eyal
> Subject: [PATCHv2] am437x-gp-evm: add wilink8 support
> 
> enable mmc3 used for wlan and uart3 used for bluetooth
> 
> configure the gpios used for wlan and bluetooth controls
> 
> add fixed voltage regulator used for wlan power control
> 
> Signed-off-by: Eyal Reizer <eyalr@ti.com>
> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts  |  102
> ++++++++++++++++++++++++++++++++++
>  include/dt-bindings/pinctrl/am43xx.h |    1 +
>  2 files changed, 103 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts
> b/arch/arm/boot/dts/am437x-gp-evm.dts
> index 26956cb..6395f57 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -21,6 +21,7 @@
> 
>  	aliases {
>  		display0 = &lcd0;
> +		serial3 = &uart3;
>  	};
> 
>  	vmmcsd_fixed: fixedregulator-sd {
> @@ -42,6 +43,15 @@
>  		gpio = <&gpio5 7 GPIO_ACTIVE_HIGH>;
>  	};
> 
> +	vmmcwl_fixed: fixedregulator-mmcwl {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmcwl_fixed";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&gpio1 20 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>; @@
> -109,6 +119,10 @@  };
> 
>  &am43xx_pinmux {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&wlan_pins_default>;
> +	pinctrl-1 = <&wlan_pins_sleep>;
> +
>  	i2c0_pins: i2c0_pins {
>  		pinctrl-single,pins = <
>  			0x188 (PIN_INPUT_PULLUP | SLEWCTRL_FAST |
> MUX_MODE0)  /* i2c0_sda.i2c0_sda */ @@ -340,6 +354,53 @@
>  			0x204 (DS0_PULL_UP_DOWN_EN | INPUT_EN |
> MUX_MODE7)  /* cam1_data7 mode 0*/
>  		>;
>  	};
> +
> +	mmc3_pins_default: pinmux_mmc3_pins_default {
> +		pinctrl-single,pins = <
> +			0x8c (PIN_INPUT_PULLUP | MUX_MODE3)      /*
> gpmc_clk.mmc2_clk */
> +			0x88 (PIN_INPUT_PULLUP | MUX_MODE3)      /*
> gpmc_csn3.mmc2_cmd */
> +			0x44 (PIN_INPUT_PULLUP | MUX_MODE3)      /*
> gpmc_a1.mmc2_dat0 */
> +			0x48 (PIN_INPUT_PULLUP | MUX_MODE3)      /*
> gpmc_a2.mmc2_dat1 */
> +			0x4c (PIN_INPUT_PULLUP | MUX_MODE3)      /*
> gpmc_a3.mmc2_dat2 */
> +			0x78 (PIN_INPUT_PULLUP | MUX_MODE3)      /*
> gpmc_be1n.mmc2_dat3 */
> +		>;
> +	};
> +
> +	mmc3_pins_sleep: pinmux_mmc3_pins_sleep {
> +		pinctrl-single,pins = <
> +			0x8c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/*
> gpmc_clk.mmc2_clk */
> +			0x88 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/*
> gpmc_csn3.mmc2_cmd */
> +			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/*
> gpmc_a1.mmc2_dat0 */
> +			0x48 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/*
> gpmc_a2.mmc2_dat1 */
> +			0x4c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/*
> gpmc_a3.mmc2_dat2 */
> +			0x78 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/*
> gpmc_be1n.mmc2_dat3 */
> +		>;
> +	};
> +
> +	wlan_pins_default: pinmux_wlan_pins_default {
> +		pinctrl-single,pins = <
> +			0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)
> 		/* gpmc_a4.gpio1_20 WL_EN */
> +			0x5c (PIN_INPUT | WAKEUP_ENABLE | MUX_MODE7)
> 	/* gpmc_a7.gpio1_23 WL_IRQ*/
> +			0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)
> 		/* gpmc_a0.gpio1_16 BT_EN*/
> +		>;
> +	};
> +
> +	wlan_pins_sleep: pinmux_wlan_pins_sleep {
> +		pinctrl-single,pins = <
> +			0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)
> 		/* gpmc_a4.gpio1_20 WL_EN */
> +			0x5c (PIN_INPUT | WAKEUP_ENABLE | MUX_MODE7)
> 	/* gpmc_a7.gpio1_23 WL_IRQ*/
> +			0x40 (PIN_OUTPUT_PULLUP | MUX_MODE7)
> 	/* gpmc_a0.gpio1_16 BT_EN*/
> +		>;
> +	};
> +
> +	uart3_pins: uart3_pins {
> +		pinctrl-single,pins = <
> +			0x228 (PIN_INPUT | MUX_MODE0)		/*
> uart3_rxd.uart3_rxd */
> +			0x22c (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /*
> uart3_txd.uart3_txd */
> +			0x230 (PIN_INPUT_PULLUP | MUX_MODE0)	/*
> uart3_ctsn.uart3_ctsn */
> +			0x234 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /*
> uart3_rtsn.uart3_rtsn */
> +		>;
> +	};
>  };
> 
>  &i2c0 {
> @@ -446,6 +507,10 @@
>  	status = "okay";
>  };
> 
> +&gpio1 {
> +	status = "okay";
> +};
> +
>  &gpio3 {
>  	status = "okay";
>  };
> @@ -468,6 +533,43 @@
>  	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;  };
> 
> +&mmc3 {
> +	status = "okay";
> +	/* these are on the crossbar and are outlined in the
> +	   xbar-event-map element */
> +	dmas = <&edma 30
> +		&edma 31>;
> +	dma-names = "tx", "rx";
> +	vmmc-supply = <&vmmcwl_fixed>;
> +	bus-width = <4>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&mmc3_pins_default>;
> +	pinctrl-1 = <&mmc3_pins_sleep>;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
> +	ti,non-removable;
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	wlcore: wlcore@0 {
> +		compatible = "ti,wl1835";
> +		reg = <2>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +};
> +
> +&edma {
> +	ti,edma-xbar-event-map = /bits/ 16 <1 30
> +					    2 31>;
> +};
> +
> +&uart3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins>;
> +};
> +
>  &usb2_phy1 {
>  	status = "okay";
>  };
> diff --git a/include/dt-bindings/pinctrl/am43xx.h b/include/dt-
> bindings/pinctrl/am43xx.h
> index 5f4d0189..b00bbc9 100644
> --- a/include/dt-bindings/pinctrl/am43xx.h
> +++ b/include/dt-bindings/pinctrl/am43xx.h
> @@ -21,6 +21,7 @@
>  #define SLEWCTRL_SLOW		(1 << 19)
>  #define SLEWCTRL_FAST		0
>  #define DS0_PULL_UP_DOWN_EN	(1 << 27)
> +#define WAKEUP_ENABLE		(1 << 29)
> 
>  #define PIN_OUTPUT		(PULL_DISABLE)
>  #define PIN_OUTPUT_PULLUP	(PULL_UP)
> --
> 1.7.9.5

