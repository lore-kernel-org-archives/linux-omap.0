From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: Add support for phyCORE-AM335x PCM-953
 carrier board
Date: Thu, 19 Jan 2017 16:24:18 +0200
Message-ID: <dda40964-44b5-e9ca-ebcf-273814e27440@mentor.com>
References: <1484831270-7251-1-git-send-email-t.remmet@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484831270-7251-1-git-send-email-t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wadim Egorov <w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/19/2017 03:07 PM, Teresa Remmet wrote:
> The phyCORE-AM335x development kit is a combination of the
> phyCORE-AM335x SoM and a PCM-953 carrier board. The features
> of the PCM-953 are:
> * ETH phy on carrier board: 1x RGMII
> * 1x CAN
> * Up to 4x UART
> * USB0 (otg)
> * USB1 (host)
> * SD slot
> * User gpio-keys
> * User LEDs
> 
> Signed-off-by: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
> Reviewed-by: Wadim Egorov <w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/am335x-pcm-953.dtsi              | 303 +++++++++++++++++++++
>  arch/arm/boot/dts/am335x-phycore-rdk.dts           |  27 ++
>  4 files changed, 334 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-pcm-953.dtsi
>  create mode 100644 arch/arm/boot/dts/am335x-phycore-rdk.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 05f95c3..8219b2c 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -151,6 +151,9 @@ Boards:
>  - AM335X SBC-T335 : single board computer, built around the Sitara AM3352/4
>    compatible = "compulab,sbc-t335", "compulab,cm-t335", "ti,am33xx"
>  
> +- AM335X phyCORE-AM335x: Development kit
> +  compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx"
> +
>  - OMAP5 EVM : Evaluation Module
>    compatible = "ti,omap5-evm", "ti,omap5"
>  
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7327250..dd71afe 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -573,6 +573,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
>  	am335x-lxm.dtb \
>  	am335x-nano.dtb \
>  	am335x-pepper.dtb \
> +	am335x-phycore-rdk.dtb \
>  	am335x-shc.dtb \
>  	am335x-sbc-t335.dtb \
>  	am335x-sl50.dtb \
> diff --git a/arch/arm/boot/dts/am335x-pcm-953.dtsi b/arch/arm/boot/dts/am335x-pcm-953.dtsi
> new file mode 100644
> index 0000000..54a171d
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-pcm-953.dtsi
> @@ -0,0 +1,303 @@
> +/*
> + * Copyright (C) 2014-2017 Phytec Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
> + *	   Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Phytec AM335x PCM-953";
> +	compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx";
> +
> +	user_leds: user_leds {
> +		compatible = "gpio-leds";
> +	};
> +
> +	user_buttons: user_buttons {
> +		compatible = "gpio-keys";
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";

Please drop "simple-bus" compatible, see http://www.spinics.net/lists/linux-usb/msg101497.html

> +
> +		vcc3v3: fixedregulator@1 {
> +			compatible = "regulator-fixed";
> +		};
> +
> +		vcc1v8: fixedregulator@2 {
> +			compatible = "regulator-fixed";
> +		};
> +	};
> +};
> +
> +/* CAN */
> +&am33xx_pinmux {

Which .dtsi file contains the referenced am33xx_pinmux device node?

You should include that file firstly, this is relevant to all other
references to device nodes used in this file.

> +	dcan1_pins: pinmux_dcan1 {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x980, PIN_OUTPUT_PULLUP | MUX_MODE2)	/* uart1_rxd.dcan1_tx_mux2 */
> +			AM33XX_IOPAD(0x984, PIN_INPUT_PULLUP | MUX_MODE2)	/* uart1_txd.dcan1_rx_mux2 */
> +		>;
> +	};
> +};
> +
> +&dcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dcan1_pins>;
> +	status = "okay";
> +};
> +
> +/* Ethernet */
> +&am33xx_pinmux {
> +	ethernet1_pins: pinmux_ethernet1 {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
> +			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
> +			AM33XX_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
> +			AM33XX_IOPAD(0x84c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
> +			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
> +			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
> +			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
> +			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
> +			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
> +			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
> +			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
> +			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
> +		>;
> +	};
> +};
> +
> +&cpsw_emac1 {
> +	phy-handle = <&phy1>;
> +	phy-mode = "rgmii-id";
> +	dual_emac_res_vlan = <2>;
> +	status = "okay";
> +};
> +
> +&davinci_mdio {
> +	phy1: ethernet-phy@1 {
> +		reg = <2>;

There is a mismatch between unit address and 'reg' property values.

> +
> +		/* Register 260 (104h) – RGMII Clock and Control Pad Skew */
> +		rxc-skew-ps = <1400>;
> +		rxdv-skew-ps = <0>;
> +		txc-skew-ps = <1400>;
> +		txen-skew-ps = <0>;
> +		/* Register 261 (105h) – RGMII RX Data Pad Skew */
> +		rxd3-skew-ps = <0>;
> +		rxd2-skew-ps = <0>;
> +		rxd1-skew-ps = <0>;
> +		rxd0-skew-ps = <0>;
> +		/* Register 262 (106h) – RGMII TX Data Pad Skew */
> +		txd3-skew-ps = <0>;
> +		txd2-skew-ps = <0>;
> +		txd1-skew-ps = <0>;
> +		txd0-skew-ps = <0>;
> +	};
> +};
> +
> +&mac {
> +	slaves = <2>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ethernet0_pins &ethernet1_pins>;
> +	dual_emac;

It seems that TI has properties with underscores in the names, acked.

> +};
> +
> +/* Misc */
> +&am33xx_pinmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cb_gpio_pins>;
> +
> +	cb_gpio_pins: pinmux_cb_gpio {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x968, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* uart0_ctsn.gpio1_8 */
> +			AM33XX_IOPAD(0x96c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* uart0_rtsn.gpio1_9 */
> +		>;
> +	};
> +};
> +
> +/* MMC */
> +&am33xx_pinmux {
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
> +			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
> +			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
> +			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
> +			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
> +			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
> +			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
> +		>;
> +	};
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&vcc3v3>;
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +/* Power */
> +&vcc3v3 {
> +	regulator-name = "vcc3v3";
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-boot-on;
> +};

Please add properties directly into vcc3v3 device node.

> +
> +&vcc1v8 {
> +	regulator-name = "vcc1v8";
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <1800000>;
> +	regulator-boot-on;
> +};
> +

Please add properties directly into vcc1v8 device node.

> +/* UARTs */
> +&am33xx_pinmux {
> +	uart0_pins: pinmux_uart0 {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
> +			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
> +		>;
> +	};
> +
> +	uart1_pins: pinmux_uart1 {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
> +			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
> +			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
> +			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
> +		>;
> +	};
> +
> +	uart2_pins: pinmux_uart2 {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_tx_clk.uart2_rxd */
> +			AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_rx_clk.uart2_txd */
> +		>;
> +	};
> +
> +	uart3_pins: pinmux_uart3 {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd3.uart3_rxd */
> +			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd2.uart3_txd */
> +		>;
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>;
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins>;
> +	status = "okay";
> +};
> +
> +/* USB */
> +&cppi41dma {
> +	status = "okay";
> +};
> +
> +&usb_ctrl_mod {
> +	status = "okay";
> +};
> +
> +&usb {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb0_phy {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +&usb1_phy {
> +	status = "okay";
> +};
> +
> +/* User IO */
> +&am33xx_pinmux {
> +	user_buttons_pins: pinmux_user_buttons {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x9e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* emu0.gpio3_7 */
> +			AM33XX_IOPAD(0x9e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* emu1.gpio3_8 */
> +		>;
> +	};
> +
> +	user_leds_pins: pinmux_user_leds {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x880, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn1.gpio1_30 */
> +			AM33XX_IOPAD(0x884, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn2.gpio1_31 */
> +		>;
> +	};
> +};
> +
> +&user_buttons {

Please add properties directly into user_buttons device node.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&user_buttons_pins>;
> +	status = "okay";

Please remove the redundant property above.

> +
> +	button@0 {
> +		label = "home";
> +		linux,code = <KEY_HOME>;
> +		gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		gpio-key,wakeup;
> +	};
> +
> +	button@1 {
> +		label = "menu";
> +		linux,code = <KEY_MENU>;
> +		gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
> +		gpio-key,wakeup;
> +	};
> +};
> +
> +&user_leds {

Please add properties directly into user_leds device node.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&user_leds_pins>;
> +	status = "okay";

Please remove the redundant property above.

> +
> +	green {
> +		label = "green:user";
> +		gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
> +		linux,default-trigger = "gpio";
> +		default-state = "on";
> +	};
> +
> +	yellow {
> +		label = "yellow:user";
> +		gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
> +		linux,default-trigger = "gpio";
> +		default-state = "on";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/am335x-phycore-rdk.dts b/arch/arm/boot/dts/am335x-phycore-rdk.dts
> new file mode 100644
> index 0000000..305f0b3
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-phycore-rdk.dts
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2014 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +#include "am335x-phycore-som.dtsi"
> +#include "am335x-pcm-953.dtsi"
> +
> +/* SoM */
> +&i2c_eeprom {
> +	status = "okay";
> +};
> +
> +&i2c_rtc {
> +	status = "okay";
> +};
> +
> +&serial_flash {
> +	status = "okay";
> +
> +};
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
