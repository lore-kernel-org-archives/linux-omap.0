From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/5] ARM: dts: omap3: Add support for INCOstartec a83x
 module
Date: Wed, 22 Jan 2014 13:48:14 -0600
Message-ID: <52E0207E.3050900@ti.com>
References: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com> <1390417460-3134-2-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36365 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbaAVTtK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jan 2014 14:49:10 -0500
In-Reply-To: <1390417460-3134-2-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, bcousson@baylibre.com, "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <zonque@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 01/22/2014 01:04 PM, Christoph Fritz wrote:
> INCOstartec LILLY-A83X module is a TI DM3730xx100 (OMAP3) SoC
> computer-on-module.
> 
> This patch adds device tree support for most of its features.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi |  445 +++++++++++++++++++++++++++++++
>  1 file changed, 445 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> 
> diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> new file mode 100644
> index 0000000..5e2137a
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> @@ -0,0 +1,445 @@
> +/*
> + * Copyright (C) 2014 Christoph Fritz <chf.fritzc@googlemail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include "omap36xx.dtsi"
> +
> +/ {
> +	model = "INCOstartec LILLY-A83X module (DM3730)";
> +	compatible = "incostartec,omap3-lilly-a83x", "ti,omap36xx", "ti,omap3";
> +
> +	chosen {
> +			bootargs = "console=ttyO0,115200n8 vt.global_cursor_default=0 consoleblank=0";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x8000000>;   /* 128 MB */
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		heartbeat1 {
> +			label = "lilly-a83x::led1";
> +			gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +	};
> +
> +	sound {
> +		compatible = "ti,omap-twl4030";
> +		ti,model = "lilly-a83x";
> +
> +		ti,mcbsp = <&mcbsp2>;
> +		ti,codec = <&twl_audio>;
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
Shrug, just moving the fixed regulator to root also will do the job,
not sure simple-bus much sense here :(

> +		reg_vcc3: vcc3 {
> +                        compatible = "regulator-fixed";
> +                        regulator-name = "VCC3";
> +                        regulator-min-microvolt = <3300000>;
> +                        regulator-max-microvolt = <3300000>;
> +                        regulator-always-on;
> +		};
> +	};
> +
> +	hsusb1_phy: hsusb1_phy {
> +		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&reg_vcc3>;
> +	};
> +};
> +
> +&omap3_pmx_wkup {
> +	pinctrl-names = "default";
> +
> +	lan9221_pins: pinmux_lan9221_pins {
> +		pinctrl-single,pins = <
> +			0x5A (PIN_INPUT | MUX_MODE4)   /* gpio_129 */
umm.. you might want to follow the convention as you followed later in
comments.
> +		>;
> +	};
> +
> +	tsc2048_pins: pinmux_tsc2048_pins {
> +		pinctrl-single,pins = <
> +			0x16 (PIN_INPUT_PULLUP | MUX_MODE4)   /* gpio_8 */
umm.. you might want to follow the convention as you followed later in
comments.
> +		>;
> +	};
> +
> +	mmc1cd_pins: pinmux_mmc1cd_pins {
> +		pinctrl-single,pins = <
> +			0x56 (PIN_INPUT | MUX_MODE4)   /* gpio_126 */
umm.. you might want to follow the convention as you followed later in
comments.
> +		>;
> +	};
> +};
> +
> +&omap3_pmx_core {
> +	pinctrl-names = "default";
> +
> +	gpio1_pins: pinmux_gpio1_pins {
> +		pinctrl-single,pins = <
> +			0x5ca (PIN_OUTPUT_PULLDOWN | MUX_MODE4)   /* gpio_29 */
umm.. you might want to follow the convention as you followed later in
comments.
> +		>;
> +	};
> +
> +	uart1_pins: pinmux_uart1_pins {
> +		pinctrl-single,pins = <
> +			0x14c (PIN_OUTPUT | MUX_MODE0)   /* uart1_tx.uart1_tx */
> +			0x14e (PIN_OUTPUT | MUX_MODE0)   /* uart1_rts.uart1_rts */
> +			0x150 (PIN_INPUT | MUX_MODE0)    /* uart1_cts.uart1_cts */
> +			0x152 (PIN_INPUT | MUX_MODE0)    /* uart1_rx.uart1_rx */
> +		>;
you may be interested in include/dt-bindings/pinctrl/omap.h
OMAP3_CORE1_IOPAD, OMAP3_CORE2_IOPAD as needed here.

> +	};
> +
> +	uart2_pins: pinmux_uart2_pins {
> +		pinctrl-single,pins = <
> +			0x140 (PIN_OUTPUT | MUX_MODE1)   /* mcbsp3_clkx.uart2_tx */
> +			0x142 (PIN_INPUT | MUX_MODE1)    /* mcbsp3_fsx.uart2_rx */
> +		>;
> +	};
> +
> +	uart3_pins: pinmux_uart3_pins {
> +		pinctrl-single,pins = <
> +			0x16e (PIN_INPUT | MUX_MODE0)    /* uart3_rx_irrx.uart3_rx_irrx */
> +			0x170 (PIN_OUTPUT | MUX_MODE0)   /* uart3_tx_irtx.uart3_tx_irtx */
> +		>;
> +	};
> +
> +	i2c1_pins: pinmux_i2c1_pins {
> +		pinctrl-single,pins = <
> +			0x18a (PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c1_scl */
> +			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c1_sda */
umm.. you might want to follow the convention as you followed
elsewhere in comments.
> +		>;
> +	};
> +
> +	i2c2_pins: pinmux_i2c2_pins {
> +		pinctrl-single,pins = <
> +			0x18e (PIN_INPUT | MUX_MODE0)   /* i2c2_scl.i2c2_scl */
> +			0x190 (PIN_INPUT | MUX_MODE0)   /* i2c2_sda.i2c2_sda */
> +		>;
> +	};
> +
> +	i2c3_pins: pinmux_i2c3_pins {
> +		pinctrl-single,pins = <
> +			0x192 (PIN_INPUT | MUX_MODE0)   /* i2c3_scl.i2c3_scl */
> +			0x194 (PIN_INPUT | MUX_MODE0)   /* i2c3_sda.i2c3_sda */
> +		>;
> +	};
> +
> +	hsusb1_pins: pinmux_hsusb1_pins {
> +		pinctrl-single,pins = <
> +			0x5a8 (PIN_OUTPUT | MUX_MODE3)  /* etk_clk.hsusb1_stp */
&omap3_pmx_core2 and OMAP3_CORE2_IOPAD probably here. and probably see
similar usage in other board dtsi.
> +			0x5aa (PIN_INPUT | MUX_MODE3)   /* etk_ctl.hsusb1_clk */
> +			0x5ac (PIN_INPUT | MUX_MODE3)   /* etk_d0.hsusb1_data0 */
> +			0x5ae (PIN_INPUT | MUX_MODE3)   /* etk_d1.hsusb1_data1 */
> +			0x5b0 (PIN_INPUT | MUX_MODE3)   /* etk_d2.hsusb1_data2 */
> +			0x5b2 (PIN_INPUT | MUX_MODE3)   /* etk_d3.hsusb1_data7 */
> +			0x5b4 (PIN_INPUT | MUX_MODE3)   /* etk_d4.hsusb1_data4 */
> +			0x5b6 (PIN_INPUT | MUX_MODE3)   /* etk_d5.hsusb1_data5 */
> +			0x5b8 (PIN_INPUT | MUX_MODE3)   /* etk_d6.hsusb1_data6 */
> +			0x5ba (PIN_INPUT | MUX_MODE3)   /* etk_d7.hsusb1_data3 */
> +			0x5bc (PIN_INPUT | MUX_MODE3)   /* etk_d8.hsusb1_dir */
> +			0x5be (PIN_INPUT | MUX_MODE3)   /* etk_d9.hsusb1_nxt */
> +
> +			/* GPIO 128 controls USB-Hub reset. But USB-Phy its
> +			 * reset can't be controlled. So we clamp this GPIO to
> +			 * high (PIN_OFF_OUTPUT_HIGH) to always enable USB-Hub.
> +			 */
> +
> +			0x1ae (PIN_OUTPUT_PULLUP | PIN_OFF_OUTPUT_HIGH | MUX_MODE4)   /* gpio_182 */
> +		>;
> +	};
> +
> +	hsusb_otg_pins: pinmux_hsusb_otg_pins {
> +		pinctrl-single,pins = <
> +			0x172 (PIN_INPUT | MUX_MODE0)   /* hsusb0_clk.hsusb0_clk */
> +			0x174 (PIN_OUTPUT | MUX_MODE0)  /* hsusb0_stp.hsusb0_stp */
> +			0x176 (PIN_INPUT | MUX_MODE0)   /* hsusb0_dir.hsusb0_dir */
> +			0x178 (PIN_INPUT | MUX_MODE0)   /* hsusb0_nxt.hsusb0_nxt */
> +			0x17a (PIN_INPUT | MUX_MODE0)   /* hsusb0_data0.hsusb0_data0 */
> +			0x17c (PIN_INPUT | MUX_MODE0)   /* hsusb0_data1.hsusb0_data1 */
> +			0x17e (PIN_INPUT | MUX_MODE0)   /* hsusb0_data2.hsusb0_data2 */
> +			0x180 (PIN_INPUT | MUX_MODE0)   /* hsusb0_data3.hsusb0_data3 */
> +			0x182 (PIN_INPUT | MUX_MODE0)   /* hsusb0_data4.hsusb0_data4 */
> +			0x184 (PIN_INPUT | MUX_MODE0)   /* hsusb0_data5.hsusb0_data5 */
> +			0x186 (PIN_INPUT | MUX_MODE0)   /* hsusb0_data6.hsusb0_data6 */
> +			0x188 (PIN_INPUT | MUX_MODE0)   /* hsusb0_data7.hsusb0_data7 */
> +		>;
> +	};
> +
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins = <
> +			0x114 (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc1_clk.sdmmc1_clk */
> +			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc1_cmd.sdmmc1_cmd */
> +			0x118 (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc1_dat0.sdmmc1_dat0 */
> +			0x11a (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc1_dat1.sdmmc1_dat1 */
> +			0x11c (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc1_dat2.sdmmc1_dat2 */
> +			0x11e (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc1_dat3.sdmmc1_dat3 */
> +		>;
> +	};
> +
> +	spi2_pins: pinmux_spi2_pins {
> +		pinctrl-single,pins = <
> +			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE0)   /* mcspi2_clk.mcspi2_clk */
> +			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE0)   /* mcspi2_simo.mcspi2_simo */
> +			0x1aa (PIN_INPUT_PULLDOWN | MUX_MODE0)   /* mcspi2_somi.mcspi2_somi */
> +			0x1ac (PIN_OUTPUT | MUX_MODE0)   /* mcspi2_cs0.mcspi2_cs0 */
> +		>;
> +	};
> +};
> +
> +&gpio1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gpio1_pins>;
> +};
> +
> +&i2c1 {
> +	clock-frequency = <2600000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <7>;   /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +
> +		twl_audio: audio {
> +			compatible = "ti,twl4030-audio";
> +			codec {
> +			};
> +		};
> +	};
> +};
> +
> +#include "twl4030.dtsi"
> +#include "twl4030_omap3.dtsi"
> +
> +&twl {
> +	vmmc1: regulator-vmmc1 {
> +		regulator-always-on;
> +	};
> +
> +	vdd1: regulator-vdd1 {
> +		regulator-always-on;
> +	};
> +
> +	vdd2: regulator-vdd2 {
> +		regulator-always-on;
> +	};
I hope you have covered all required regulators here including the
ones you might need for IO.1P8 perhaps?

> +};
> +
> +&i2c2 {
> +	clock-frequency = <2600000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +};
> +
> +&i2c3 {
> +	clock-frequency = <2600000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +		gpiom1: gpio@20 {
> +			compatible = "mcp,mcp23017";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			reg = <0x20>;
> +		};
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
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins>;
> +};
> +
> +&uart4 {
> +	status = "disabled";
> +};
> +
> +&mmc1 {
> +	reg = <0x4809c000 0x400>;
little curious as to why this. is that to override length 0x200 to
0x400? that belongs to soc.dtsi then.

> +	cd-gpios = <&gpio4 30 IRQ_TYPE_LEVEL_LOW>;
> +	cd-inverted;
> +	vmmc-supply = <&vmmc1>;
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins &mmc1cd_pins>;
> +	cap-sdio-irq;
> +	cap-sd-highspeed;
> +	cap-mmc-highspeed;
> +};
> +
> +&mmc2 {
> +	status = "disabled";
> +};
> +
> +&mmc3 {
> +	status = "disabled";
> +};
> +
> +&mcspi2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2_pins>;
> +
> +	tsc2046@0 {
> +		reg = <0>;   /* CS0 */
> +		compatible = "ti,tsc2046";
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <8 0>;   /* boot6 / gpio_8 */
> +		spi-max-frequency = <1000000>;
> +		pendown-gpio = <&gpio1 8 0>;
> +		vcc-supply = <&reg_vcc3>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tsc2048_pins>;
> +
> +		ti,x-min = <300>;
> +		ti,x-max = <3000>;
> +		ti,y-min = <600>;
> +		ti,y-max = <3600>;
> +		ti,x-plate-ohms = <80>;
> +		ti,pressure-max = <255>;
> +		ti,swap-xy;
> +
> +		linux,wakeup;
> +	};
> +};
> +
> +&usbhsehci {
> +	phys = <&hsusb1_phy>;
> +};
> +
> +&usbhshost {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hsusb1_pins>;
> +	num-ports = <2>;
> +	port1-mode = "ehci-phy";
> +};
> +
> +&usb_otg_hs {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hsusb_otg_pins>;
> +	interface-type = <0>;
> +	usb-phy = <&usb2_phy>;
> +	phys = <&usb2_phy>;
> +	phy-names = "usb2-phy";
> +	mode = <3>;
> +	power = <50>;
> +};
> +
> +&gpmc {
> +	ranges = <0 0 0x30000000 0x1000000>,
> +		<7 0 0x15000000 0x01000000>;
> +
> +	nand@0,0 {
> +		reg = <0 0 0x1000000>;
> +		nand-bus-width = <16>;
> +		ti,nand-ecc-opt = "bch8";
> +		/* no elm on omap3 */
> +
> +		gpmc,mux-add-data = <0>;
> +		gpmc,device-nand;
> +		gpmc,device-width = <2>;
> +		gpmc,wait-pin = <0>;
> +		gpmc,wait-monitoring-ns = <0>;
> +		gpmc,burst-length= <4>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <100>;
> +		gpmc,cs-wr-off-ns = <100>;
> +		gpmc,adv-on-ns = <0>;
> +		gpmc,adv-rd-off-ns = <100>;
> +		gpmc,adv-wr-off-ns = <100>;
> +		gpmc,oe-on-ns = <5>;
> +		gpmc,oe-off-ns = <75>;
> +		gpmc,we-on-ns = <5>;
> +		gpmc,we-off-ns = <75>;
> +		gpmc,rd-cycle-ns = <100>;
> +		gpmc,wr-cycle-ns = <100>;
> +		gpmc,access-ns = <60>;
> +		gpmc,page-burst-access-ns = <5>;
> +		gpmc,bus-turnaround-ns = <0>;
> +		gpmc,cycle2cycle-samecsen;
> +		gpmc,cycle2cycle-delay-ns = <50>;
> +		gpmc,wr-data-mux-bus-ns = <75>;
> +		gpmc,wr-access-ns = <155>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		partition@0 {
> +			label = "MLO";
> +			reg = <0 0x80000>;
> +		};
> +
> +		partition@0x80000 {
> +			label = "u-boot";
> +			reg = <0x80000 0x1e0000>;
> +		};
> +
> +		partition@0x260000 {
> +			label = "u-boot-environment";
> +			reg = <0x260000 0x20000>;
> +		};
> +
> +		partition@0x280000 {
> +			label = "kernel";
> +			reg = <0x280000 0x500000>;
> +		};
> +
> +		partition@0x780000 {
> +			label = "filesystem";
> +			reg = <0x780000 0xf880000>;
> +		};
> +	};
> +
> +	ethernet@7,0 {
> +		compatible = "smsc,lan9221", "smsc,lan9115";
> +		bank-width = <2>;
> +		gpmc,mux-add-data = <2>;
> +		gpmc,cs-on-ns = <10>;
> +		gpmc,cs-rd-off-ns = <60>;
> +		gpmc,cs-wr-off-ns = <60>;
> +		gpmc,adv-on-ns = <0>;
> +		gpmc,adv-rd-off-ns = <10>;
> +		gpmc,adv-wr-off-ns = <10>;
> +		gpmc,oe-on-ns = <10>;
> +		gpmc,oe-off-ns = <60>;
> +		gpmc,we-on-ns = <10>;
> +		gpmc,we-off-ns = <60>;
> +		gpmc,rd-cycle-ns = <100>;
> +		gpmc,wr-cycle-ns = <100>;
> +		gpmc,access-ns = <50>;
> +		gpmc,page-burst-access-ns = <5>;
> +		gpmc,bus-turnaround-ns = <0>;
> +		gpmc,cycle2cycle-delay-ns = <75>;
> +		gpmc,wr-data-mux-bus-ns = <15>;
> +		gpmc,wr-access-ns = <75>;
> +		gpmc,cycle2cycle-samecsen;
> +		gpmc,cycle2cycle-diffcsen;
> +		vddvario-supply = <&reg_vcc3>;
> +		vdd33a-supply = <&reg_vcc3>;
> +		reg-io-width = <4>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <1 0x2>;
> +		reg = <7 0 0xff>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lan9221_pins>;
> +		phy-mode = "mii";
> +	};
> +};
> 


-- 
Regards,
Nishanth Menon
