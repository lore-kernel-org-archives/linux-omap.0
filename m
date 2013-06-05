From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 1/4] ARM: dts: omap5: Rename omap5-evm to omap5-uevm
Date: Wed, 5 Jun 2013 12:20:54 +0530
Message-ID: <51AEDFCE.2020303@ti.com>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com> <1370414770-1485-2-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58880 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab3FEGvX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jun 2013 02:51:23 -0400
In-Reply-To: <1370414770-1485-2-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com

On Wednesday 05 June 2013 12:16 PM, Sricharan R wrote:
> The uevm is the official board supported for the OMAP5 soc
> in mainline. The uevm has an OMAP5432 with a DDR3 memory.
> Renaming the board dts file and adding the following cleanups.
>
>  * There are no devices connected on I2C 2,3,4 buses. So remove
>    the pinmux data for the same.
>
>  * DDR3 memory is used in the uevm. Neither DVFS or temperature
>    polling is supported with DDR3. So remove the DDR3 device and
>    emif nodes.
>
>  * Keypad is not supported on uevm. So remove the device node.
>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
>  arch/arm/boot/dts/Makefile       |    2 +-
>  arch/arm/boot/dts/omap5-evm.dts  |  261 --------------------------------------
>  arch/arm/boot/dts/omap5-uevm.dts |  184 +++++++++++++++++++++++++++
>  3 files changed, 185 insertions(+), 262 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/omap5-evm.dts
>  create mode 100644 arch/arm/boot/dts/omap5-uevm.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f0895c5..13b86bf 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -149,7 +149,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>  	omap4-panda-es.dtb \
>  	omap4-var-som.dtb \
>  	omap4-sdp.dtb \
> -	omap5-evm.dtb \
> +	omap5-uevm.dtb \
>  	am335x-evm.dtb \
>  	am335x-evmsk.dtb \
>  	am335x-bone.dtb
> diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
> deleted file mode 100644
> index 22e9ee8..0000000
> --- a/arch/arm/boot/dts/omap5-evm.dts
> +++ /dev/null
> @@ -1,261 +0,0 @@
> -/*
> - * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -/dts-v1/;
> -
> -#include "omap5.dtsi"
> -#include "samsung_k3pe0e000b.dtsi"
> -
> -/ {
> -	model = "TI OMAP5 EVM board";
> -	compatible = "ti,omap5-evm", "ti,omap5";
> -
> -	memory {
> -		device_type = "memory";
> -		reg = <0x80000000 0x7F000000>; /* 2032 MB */
> -	};
> -
> -	vmmcsd_fixed: fixedregulator-mmcsd {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vmmcsd_fixed";
> -		regulator-min-microvolt = <3000000>;
> -		regulator-max-microvolt = <3000000>;
> -	};
> -
> -};
> -
> -&omap5_pmx_core {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <
> -			&twl6040_pins
> -			&mcpdm_pins
> -			&dmic_pins
> -			&mcbsp1_pins
> -			&mcbsp2_pins
> -	>;
> -
> -	twl6040_pins: pinmux_twl6040_pins {
> -		pinctrl-single,pins = <
> -			0x18a (PIN_OUTPUT | MUX_MODE6)	/* perslimbus2_clock.gpio5_145 */
> -		>;
> -	};
> -
> -	mcpdm_pins: pinmux_mcpdm_pins {
> -		pinctrl-single,pins = <
> -			0x142 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
> -			0x15c (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_ul_data.abemcpdm_ul_data */
> -			0x15e (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_dl_data.abemcpdm_dl_data */
> -			0x160 (PIN_INPUT_PULLUP | MUX_MODE0)	/* abemcpdm_frame.abemcpdm_frame */
> -			0x162 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_lb_clk.abemcpdm_lb_clk */
> -		>;
> -	};
> -
> -	dmic_pins: pinmux_dmic_pins {
> -		pinctrl-single,pins = <
> -			0x144 (PIN_INPUT | MUX_MODE0)		/* abedmic_din1.abedmic_din1 */
> -			0x146 (PIN_INPUT | MUX_MODE0)		/* abedmic_din2.abedmic_din2 */
> -			0x148 (PIN_INPUT | MUX_MODE0)		/* abedmic_din3.abedmic_din3 */
> -			0x14a (PIN_OUTPUT | MUX_MODE0)		/* abedmic_clk1.abedmic_clk1 */
> -		>;
> -	};
> -
> -	mcbsp1_pins: pinmux_mcbsp1_pins {
> -		pinctrl-single,pins = <
> -			0x14c (PIN_INPUT | MUX_MODE1)		/* abedmic_clk2.abemcbsp1_fsx */
> -			0x14e (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* abedmic_clk3.abemcbsp1_dx */
> -			0x150 (PIN_INPUT | MUX_MODE1)		/* abeslimbus1_clock.abemcbsp1_clkx */
> -			0x152 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* abeslimbus1_data.abemcbsp1_dr */
> -		>;
> -	};
> -
> -	mcbsp2_pins: pinmux_mcbsp2_pins {
> -		pinctrl-single,pins = <
> -			0x154 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcbsp2_dr.abemcbsp2_dr */
> -			0x156 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abemcbsp2_dx.abemcbsp2_dx */
> -			0x158 (PIN_INPUT | MUX_MODE0)		/* abemcbsp2_fsx.abemcbsp2_fsx */
> -			0x15a (PIN_INPUT | MUX_MODE0)		/* abemcbsp2_clkx.abemcbsp2_clkx */
> -		>;
> -	};
> -
> -	i2c1_pins: pinmux_i2c1_pins {
> -		pinctrl-single,pins = <
> -			0x1b2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
> -			0x1b4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
> -		>;
> -	};
> -
> -	i2c2_pins: pinmux_i2c2_pins {
> -		pinctrl-single,pins = <
> -			0x178 (PIN_INPUT | MUX_MODE0)		/* i2c2_scl */
> -			0x17a (PIN_INPUT | MUX_MODE0)		/* i2c2_sda */
> -		>;
> -	};
> -
> -	i2c3_pins: pinmux_i2c3_pins {
> -		pinctrl-single,pins = <
> -			0x13a (PIN_INPUT | MUX_MODE0)		/* i2c3_scl */
> -			0x13c (PIN_INPUT | MUX_MODE0)		/* i2c3_sda */
> -		>;
> -	};
> -
> -	i2c4_pins: pinmux_i2c4_pins {
> -		pinctrl-single,pins = <
> -			0xb8 (PIN_INPUT | MUX_MODE0)		/* i2c4_scl */
> -			0xba (PIN_INPUT | MUX_MODE0)		/* i2c4_sda */
> -		>;
> -	};
> -
> -	i2c5_pins: pinmux_i2c5_pins {
> -		pinctrl-single,pins = <
> -			0x184 (PIN_INPUT | MUX_MODE0)		/* i2c5_scl */
> -			0x186 (PIN_INPUT | MUX_MODE0)		/* i2c5_sda */
> -		>;
> -	};
> -
> -	mcspi2_pins: pinmux_mcspi2_pins {
> -		pinctrl-single,pins = <
> -			0xbc (PIN_INPUT | MUX_MODE0)		/*  mcspi2_clk */
> -			0xbe (PIN_INPUT | MUX_MODE0)		/*  mcspi2_simo */
> -			0xc0 (PIN_INPUT_PULLUP | MUX_MODE0)	/*  mcspi2_somi */
> -			0xc2 (PIN_OUTPUT | MUX_MODE0)		/*  mcspi2_cs */
> -		>;
> -	};
> -
> -	mcspi3_pins: pinmux_mcspi3_pins {
> -		pinctrl-single,pins = <
> -			0x78 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_somi */
> -			0x7a (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
> -			0x7c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_simo */
> -			0x7e (PIN_INPUT | MUX_MODE1)		/*  mcspi2_clk */
> -		>;
> -	};
> -
> -	mcspi4_pins: pinmux_mcspi4_pins {
> -		pinctrl-single,pins = <
> -			0x164 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_clk */
> -			0x168 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_simo */
> -			0x16a (PIN_INPUT | MUX_MODE1)		/*  mcspi2_somi */
> -			0x16c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
> -		>;
> -	};
> -};
> -
> -&mmc1 {
> -	vmmc-supply = <&vmmcsd_fixed>;
> -	bus-width = <4>;
> -};
> -
> -&mmc2 {
> -	vmmc-supply = <&vmmcsd_fixed>;
> -	bus-width = <8>;
> -	ti,non-removable;
> -};
> -
> -&mmc3 {
> -	bus-width = <4>;
> -	ti,non-removable;
> -};
> -
> -&mmc4 {
> -	status = "disabled";
> -};
> -
> -&mmc5 {
> -	status = "disabled";
> -};
> -
> -&i2c1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c1_pins>;
> -
> -	clock-frequency = <400000>;
> -};
> -
> -&i2c2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c2_pins>;
> -
> -	clock-frequency = <400000>;
> -
> -	/* Pressure Sensor */
> -	bmp085@77 {
> -		compatible = "bosch,bmp085";
> -		reg = <0x77>;
> -	};
> -};
> -
> -&i2c3 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c3_pins>;
> -
> -	clock-frequency = <400000>;
> -};
> -
> -&i2c4 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c4_pins>;
> -
> -	clock-frequency = <400000>;
> -
> -	/* Temperature Sensor */
> -	tmp102@48{
> -		compatible = "ti,tmp102";
> -		reg = <0x48>;
> -	};
> -};
> -
> -&i2c5 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c5_pins>;
> -
> -	clock-frequency = <400000>;
> -};
> -
> -&keypad {
> -	keypad,num-rows = <8>;
> -	keypad,num-columns = <8>;
> -	linux,keymap = <0x02020073	/* VOLUP */
> -			0x02030072	/* VOLDOWM */
> -			0x020400e7	/* SEND */
> -			0x02050066	/* HOME */
> -			0x0206006b	/* END */
> -			0x020700d9>;	/* SEARCH */
> -	linux,input-no-autorepeat;
> -};
> -
> -&mcbsp3 {
> -	status = "disabled";
> -};
> -
> -&emif1 {
> -	cs1-used;
> -	device-handle = <&samsung_K3PE0E000B>;
> -};
> -
> -&emif2 {
> -	cs1-used;
> -	device-handle = <&samsung_K3PE0E000B>;
> -};
> -
> -&mcspi1 {
> -
> -};
> -
> -&mcspi2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mcspi2_pins>;
> -};
> -
> -&mcspi3 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mcspi3_pins>;
> -};
> -
> -&mcspi4 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mcspi4_pins>;
> -};
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> new file mode 100644
> index 0000000..843a001
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -0,0 +1,184 @@
> +/*
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +#include "omap5.dtsi"
> +
> +/ {
> +	model = "TI OMAP5 uEVM board";
> +	compatible = "ti,omap5-uevm", "ti,omap5";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x7F000000>; /* 2032 MB */
> +	};
> +
> +	vmmcsd_fixed: fixedregulator-mmcsd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmcsd_fixed";
> +		regulator-min-microvolt = <3000000>;
> +		regulator-max-microvolt = <3000000>;
> +	};
> +
> +};
> +
> +&omap5_pmx_core {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +			&twl6040_pins
> +			&mcpdm_pins
> +			&dmic_pins
> +			&mcbsp1_pins
> +			&mcbsp2_pins
> +	>;
> +
> +	twl6040_pins: pinmux_twl6040_pins {
> +		pinctrl-single,pins = <
> +			0x18a (PIN_OUTPUT | MUX_MODE6)	/* perslimbus2_clock.gpio5_145 */
> +		>;
> +	};
> +
> +	mcpdm_pins: pinmux_mcpdm_pins {
> +		pinctrl-single,pins = <
> +			0x142 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
> +			0x15c (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_ul_data.abemcpdm_ul_data */
> +			0x15e (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_dl_data.abemcpdm_dl_data */
> +			0x160 (PIN_INPUT_PULLUP | MUX_MODE0)	/* abemcpdm_frame.abemcpdm_frame */
> +			0x162 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_lb_clk.abemcpdm_lb_clk */
> +		>;
> +	};
> +
> +	dmic_pins: pinmux_dmic_pins {
> +		pinctrl-single,pins = <
> +			0x144 (PIN_INPUT | MUX_MODE0)		/* abedmic_din1.abedmic_din1 */
> +			0x146 (PIN_INPUT | MUX_MODE0)		/* abedmic_din2.abedmic_din2 */
> +			0x148 (PIN_INPUT | MUX_MODE0)		/* abedmic_din3.abedmic_din3 */
> +			0x14a (PIN_OUTPUT | MUX_MODE0)		/* abedmic_clk1.abedmic_clk1 */
> +		>;
> +	};
> +
> +	mcbsp1_pins: pinmux_mcbsp1_pins {
> +		pinctrl-single,pins = <
> +			0x14c (PIN_INPUT | MUX_MODE1)		/* abedmic_clk2.abemcbsp1_fsx */
> +			0x14e (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* abedmic_clk3.abemcbsp1_dx */
> +			0x150 (PIN_INPUT | MUX_MODE1)		/* abeslimbus1_clock.abemcbsp1_clkx */
> +			0x152 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* abeslimbus1_data.abemcbsp1_dr */
> +		>;
> +	};
> +
> +	mcbsp2_pins: pinmux_mcbsp2_pins {
> +		pinctrl-single,pins = <
> +			0x154 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcbsp2_dr.abemcbsp2_dr */
> +			0x156 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abemcbsp2_dx.abemcbsp2_dx */
> +			0x158 (PIN_INPUT | MUX_MODE0)		/* abemcbsp2_fsx.abemcbsp2_fsx */
> +			0x15a (PIN_INPUT | MUX_MODE0)		/* abemcbsp2_clkx.abemcbsp2_clkx */
> +		>;
> +	};
> +
> +	i2c1_pins: pinmux_i2c1_pins {
> +		pinctrl-single,pins = <
> +			0x1b2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
> +			0x1b4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
> +		>;
> +	};
> +
> +	i2c5_pins: pinmux_i2c5_pins {
> +		pinctrl-single,pins = <
> +			0x184 (PIN_INPUT | MUX_MODE0)		/* i2c5_scl */
> +			0x186 (PIN_INPUT | MUX_MODE0)		/* i2c5_sda */
> +		>;
> +	};
> +
> +	mcspi2_pins: pinmux_mcspi2_pins {
> +		pinctrl-single,pins = <
> +			0xbc (PIN_INPUT | MUX_MODE0)		/*  mcspi2_clk */
> +			0xbe (PIN_INPUT | MUX_MODE0)		/*  mcspi2_simo */
> +			0xc0 (PIN_INPUT_PULLUP | MUX_MODE0)	/*  mcspi2_somi */
> +			0xc2 (PIN_OUTPUT | MUX_MODE0)		/*  mcspi2_cs */
> +		>;
> +	};
> +
> +	mcspi3_pins: pinmux_mcspi3_pins {
> +		pinctrl-single,pins = <
> +			0x78 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_somi */
> +			0x7a (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
> +			0x7c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_simo */
> +			0x7e (PIN_INPUT | MUX_MODE1)		/*  mcspi2_clk */
> +		>;
> +	};
> +
> +	mcspi4_pins: pinmux_mcspi4_pins {
> +		pinctrl-single,pins = <
> +			0x164 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_clk */
> +			0x168 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_simo */
> +			0x16a (PIN_INPUT | MUX_MODE1)		/*  mcspi2_somi */
> +			0x16c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
> +		>;
> +	};
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&vmmcsd_fixed>;
> +	bus-width = <4>;
> +};
> +
> +&mmc2 {
> +	vmmc-supply = <&vmmcsd_fixed>;
> +	bus-width = <8>;
> +	ti,non-removable;
> +};
> +
> +&mmc3 {
> +	bus-width = <4>;
> +	ti,non-removable;
> +};
> +
> +&mmc4 {
> +	status = "disabled";
> +};
> +
> +&mmc5 {
> +	status = "disabled";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +
> +	clock-frequency = <400000>;
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5_pins>;
> +
> +	clock-frequency = <400000>;
> +};
> +
> +&mcbsp3 {
> +	status = "disabled";
> +};
> +
> +&mcspi1 {
> +
> +};
> +
> +&mcspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcspi2_pins>;
> +};
> +
> +&mcspi3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcspi3_pins>;
> +};
> +
> +&mcspi4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcspi4_pins>;
> +};
 Sorry missed -C option in formatting.
 Will resend for that

Regards,
 Sricharan
