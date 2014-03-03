From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 1/2] ARM: dts: Add support for OMAP4 Gumstix DuoVero/Parlor
Date: Mon, 03 Mar 2014 11:08:28 +0100
Message-ID: <5314549C.1030400@epfl.ch>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch> <1393261669-32039-2-git-send-email-florian.vaussard@epfl.ch>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:51503 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754279AbaCCKId (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Mar 2014 05:08:33 -0500
In-Reply-To: <1393261669-32039-2-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ash Charles <ash@gumstix.com>

Hi Tony, Benoit,

On 02/24/2014 06:07 PM, Florian Vaussard wrote:
> Gumstix DuoVero is an OMAP4430-based Computer On Module.
> Parlor is one of the available expansion board.
> 
> Tested features:
> - GPMC ethernet
> - HSUSB2 and OTG
> - Audio out
> - WiFi and Bluetooth (w2cbw0015 SDIO module)
> - LED and button
> 

Can this patch go into 3.15? The other one (HDMI support) can wait for
the DSS support to be merged, but I would like to give to this DTS a
wider exposure to testing opportunities.

Regards,
Florian

> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/omap4-duovero-parlor.dts         | 146 ++++++++++++
>  arch/arm/boot/dts/omap4-duovero.dtsi               | 252 +++++++++++++++++++++
>  4 files changed, 402 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap4-duovero-parlor.dts
>  create mode 100644 arch/arm/boot/dts/omap4-duovero.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index af9b4a0..95b1372 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -99,6 +99,9 @@ Boards:
>  - OMAP4 PandaBoard : Low cost community board
>    compatible = "ti,omap4-panda", "ti,omap4430"
>  
> +- OMAP4 DuoVero with Parlor : Commercial expansion board with daughter board
> +  compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
> +
>  - OMAP3 EVM : Software Development Board for OMAP35x, AM/DM37x
>    compatible = "ti,omap3-evm", "ti,omap3"
>  
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0320303..8b23abb 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -215,6 +215,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>  	omap3-igep0020.dtb \
>  	omap3-igep0030.dtb \
>  	omap3-zoom3.dtb \
> +	omap4-duovero-parlor.dtb \
>  	omap4-panda.dtb \
>  	omap4-panda-a4.dtb \
>  	omap4-panda-es.dtb \
> diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
> new file mode 100644
> index 0000000..96f51d8
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
> @@ -0,0 +1,146 @@
> +/*
> + * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +#include "omap4-duovero.dtsi"
> +
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "OMAP4430 Gumstix Duovero on Parlor";
> +	compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led0 {
> +			label = "duovero:blue:led0";
> +			gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;	/* gpio_122 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		button0@121 {
> +			label = "button0";
> +			linux,code = <BTN_0>;
> +			gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;	/* gpio_121 */
> +			gpio-key,wakeup;
> +		};
> +	};
> +};
> +
> +&omap4_pmx_core {
> +	pinctrl-0 = <
> +			&led_pins
> +			&button_pins
> +			&smsc_pins
> +	>;
> +
> +	led_pins: pinmux_led_pins {
> +		pinctrl-single,pins = <
> +			0xd6 (PIN_OUTPUT | MUX_MODE3)		/* abe_dmic_din3.gpio_122 */
> +		>;
> +	};
> +
> +	button_pins: pinmux_button_pins {
> +		pinctrl-single,pins = <
> +			0xd4 (PIN_INPUT_PULLUP | MUX_MODE3)	/* abe_dmic_din2.gpio_121 */
> +		>;
> +	};
> +
> +	i2c2_pins: pinmux_i2c2_pins {
> +		pinctrl-single,pins = <
> +			0xe6 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_scl */
> +			0xe8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_sda */
> +		>;
> +	};
> +
> +	i2c3_pins: pinmux_i2c3_pins {
> +		pinctrl-single,pins = <
> +			0xea (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
> +			0xec (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
> +		>;
> +	};
> +
> +	smsc_pins: pinmux_smsc_pins {
> +		pinctrl-single,pins = <
> +			0x28 (PIN_INPUT | MUX_MODE3)		/* gpmc_a20.gpio_44: IRQ */
> +			0x2a (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a21.gpio_45: nReset */
> +			0x30 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48: amdix enabled */
> +		>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +
> +	clock-frequency = <400000>;
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +
> +	clock-frequency = <100000>;
> +
> +	/* optional 1K EEPROM with revision information */
> +	eeprom@51 {
> +		compatible = "atmel,24c01";
> +		reg = <0x51>;
> +		pagesize = <8>;
> +	};
> +};
> +
> +&mmc3 {
> +	status = "disabled";
> +};
> +
> +#include "omap-gpmc-smsc911x.dtsi"
> +
> +&gpmc {
> +	ranges = <5 0 0x2c000000 0x1000000>;			/* CS5 */
> +
> +	ethernet@gpmc {
> +		reg = <5 0 0xff>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;		/* gpio_44 */
> +
> +		phy-mode = "mii";
> +
> +		gpmc,cs-on-ns = <10>;
> +		gpmc,cs-rd-off-ns = <50>;
> +		gpmc,cs-wr-off-ns = <50>;
> +		gpmc,adv-on-ns = <0>;
> +		gpmc,adv-rd-off-ns = <10>;
> +		gpmc,adv-wr-off-ns = <10>;
> +		gpmc,oe-on-ns = <15>;
> +		gpmc,oe-off-ns = <50>;
> +		gpmc,we-on-ns = <15>;
> +		gpmc,we-off-ns = <50>;
> +		gpmc,rd-cycle-ns = <50>;
> +		gpmc,wr-cycle-ns = <50>;
> +		gpmc,access-ns = <50>;
> +		gpmc,page-burst-access-ns = <0>;
> +		gpmc,bus-turnaround-ns = <35>;
> +		gpmc,cycle2cycle-delay-ns = <35>;
> +		gpmc,wr-data-mux-bus-ns = <35>;
> +		gpmc,wr-access-ns = <50>;
> +
> +		gpmc,mux-add-data = <2>;
> +		gpmc,sync-read;
> +		gpmc,sync-write;
> +		gpmc,clk-activation-ns = <5>;
> +		gpmc,sync-clk-ps = <20000>;
> +	};
> +};
> +
> +
> diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/omap4-duovero.dtsi
> new file mode 100644
> index 0000000..a514791
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap4-duovero.dtsi
> @@ -0,0 +1,252 @@
> +/*
> + * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "omap443x.dtsi"
> +
> +/ {
> +	model = "Gumstix Duovero";
> +	compatible = "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>; /* 1 GB */
> +	};
> +
> +	sound {
> +		compatible = "ti,abe-twl6040";
> +		ti,model = "DuoVero";
> +
> +		ti,mclk-freq = <38400000>;
> +
> +		ti,mcpdm = <&mcpdm>;
> +
> +		ti,twl6040 = <&twl6040>;
> +
> +		/* Audio routing */
> +		ti,audio-routing =
> +			"Headset Stereophone", "HSOL",
> +			"Headset Stereophone", "HSOR",
> +			"HSMIC", "Headset Mic",
> +			"Headset Mic", "Headset Mic Bias";
> +	};
> +
> +	/* HS USB Host PHY on PORT 1 */
> +	hsusb1_phy: hsusb1_phy {
> +		compatible = "usb-nop-xceiv";
> +		reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;	/* gpio_62 */
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hsusb1phy_pins>;
> +
> +		clocks = <&auxclk3_ck>;
> +		clock-names = "main_clk";
> +		clock-frequency = <19200000>;
> +	};
> +
> +	/* regulator for w2cbw0015 on sdio5 */
> +	w2cbw0015_vmmc: w2cbw0015_vmmc {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&w2cbw0015_pins>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "w2cbw0015";
> +		regulator-min-microvolt = <3000000>;
> +		regulator-max-microvolt = <3000000>;
> +		gpio = <&gpio2 11 GPIO_ACTIVE_LOW>;		/* gpio_43 */
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&omap4_pmx_core {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +			&twl6040_pins
> +			&mcpdm_pins
> +			&mcbsp1_pins
> +			&hsusbb1_pins
> +	>;
> +
> +	twl6040_pins: pinmux_twl6040_pins {
> +		pinctrl-single,pins = <
> +			0x126 (PIN_OUTPUT | MUX_MODE3)		/* usbb2_ulpitll_nxt.gpio_160 */
> +			0x160 (PIN_INPUT | MUX_MODE0)		/* sys_nirq2.sys_nirq2 */
> +		>;
> +	};
> +
> +	mcpdm_pins: pinmux_mcpdm_pins {
> +		pinctrl-single,pins = <
> +			0xc6 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_ul_data.abe_pdm_ul_data */
> +			0xc8 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_dl_data.abe_pdm_dl_data */
> +			0xca (PIN_INPUT_PULLUP   | MUX_MODE0)	/* abe_pdm_frame.abe_pdm_frame */
> +			0xcc (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_lb_clk.abe_pdm_lb_clk */
> +			0xce (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
> +		>;
> +	};
> +
> +	mcbsp1_pins: pinmux_mcbsp1_pins {
> +		pinctrl-single,pins = <
> +			0xbe (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_clkx.abe_mcbsp1_clkx */
> +			0xc0 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dr.abe_mcbsp1_dr */
> +			0xc2 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dx.abe_mcbsp1_dx */
> +			0xc4 (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_fsx.abe_mcbsp1_fsx */
> +		>;
> +	};
> +
> +	hsusbb1_pins: pinmux_hsusbb1_pins {
> +		pinctrl-single,pins = <
> +			0x82 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_clk.usbb1_ulpiphy_clk */
> +			0x84 (PIN_OUTPUT | MUX_MODE4)		/* usbb1_ulpitll_stp.usbb1_ulpiphy_stp */
> +			0x86 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dir.usbb1_ulpiphy_dir */
> +			0x88 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_nxt.usbb1_ulpiphy_nxt */
> +			0x8a (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat0.usbb1_ulpiphy_dat0 */
> +			0x8c (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat1.usbb1_ulpiphy_dat1 */
> +			0x8e (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat2.usbb1_ulpiphy_dat2 */
> +			0x90 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat3.usbb1_ulpiphy_dat3 */
> +			0x92 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat4.usbb1_ulpiphy_dat4 */
> +			0x94 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat5.usbb1_ulpiphy_dat5 */
> +			0x96 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat6.usbb1_ulpiphy_dat6 */
> +			0x98 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat7.usbb1_ulpiphy_dat7 */
> +		>;
> +	};
> +
> +	hsusb1phy_pins: pinmux_hsusb1phy_pins {
> +		pinctrl-single,pins = <
> +			0x4c (PIN_OUTPUT | MUX_MODE3)		/* gpmc_wait1.gpio_62 */
> +		>;
> +	};
> +
> +	w2cbw0015_pins: pinmux_w2cbw0015_pins {
> +		pinctrl-single,pins = <
> +			0x26 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_a19.gpio_43 */
> +			0x3a (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
> +		>;
> +	};
> +
> +	i2c1_pins: pinmux_i2c1_pins {
> +		pinctrl-single,pins = <
> +			0xe2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
> +			0xe4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
> +		>;
> +	};
> +
> +	i2c4_pins: pinmux_i2c4_pins {
> +		pinctrl-single,pins = <
> +			0xee (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
> +			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
> +		>;
> +	};
> +
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins = <
> +			0xa2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
> +			0xa4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc1_cmd */
> +			0xa6 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc1_dat0 */
> +			0xa8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1 */
> +			0xaa (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2 */
> +			0xac (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
> +		>;
> +	};
> +
> +	mmc5_pins: pinmux_mmc5_pins {
> +		pinctrl-single,pins = <
> +			0x108 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_clk */
> +			0x10a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc5_cmd */
> +			0x10c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc5_dat0 */
> +			0x10e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1 */
> +			0x110 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat2 */
> +			0x112 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3 */
> +		>;
> +	};
> +};
> +
> +/* PMIC */
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +
> +	clock-frequency = <400000>;
> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;		/* IRQ_SYS_1N cascaded to gic */
> +		interrupt-parent = <&gic>;
> +	};
> +
> +	twl6040: twl@4b {
> +		compatible = "ti,twl6040";
> +		reg = <0x4b>;
> +		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;		/* IRQ_SYS_2N cascaded to gic */
> +		interrupt-parent = <&gic>;
> +		ti,audpwron-gpio = <&gpio6 0 GPIO_ACTIVE_HIGH>;		/* gpio_160 */
> +
> +		vio-supply = <&v1v8>;
> +		v2v1-supply = <&v2v1>;
> +		enable-active-high;
> +	};
> +};
> +
> +#include "twl6030.dtsi"
> +#include "twl6030_omap4.dtsi"
> +
> +/* on-board bluetooth / WiFi module */
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins>;
> +
> +	clock-frequency = <400000>;
> +};
> +
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +
> +	vmmc-supply = <&vmmc>;
> +	ti,bus-width = <4>;
> +	ti,non-removable;		/* FIXME: use PMIC_MMC detect */
> +};
> +
> +&mmc2 {
> +	status = "disabled";
> +};
> +
> +/* mmc3 is available to the expansion board */
> +
> +&mmc4 {
> +	status = "disabled";
> +};
> +
> +/* on-board WiFi module */
> +&mmc5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc5_pins>;
> +
> +	vmmc-supply = <&w2cbw0015_vmmc>;
> +	ti,bus-width = <4>;
> +	ti,non-removable;
> +	cap-power-off-card;
> +};
> +
> +&twl_usb_comparator {
> +	usb-supply = <&vusb>;
> +};
> +
> +&usb_otg_hs {
> +	interface-type = <1>;
> +	mode = <3>;
> +	power = <50>;
> +};
> +
> +&usbhshost {
> +	port1-mode = "ehci-phy";
> +};
> +
> +&usbhsehci {
> +	phys = <&hsusb1_phy>;
> +};
> +
> 
