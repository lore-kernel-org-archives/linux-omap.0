From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: Add minimal support for LogicPD Torpedo
 DM3730 devkit
Date: Mon, 18 May 2015 15:39:35 -0700
Message-ID: <20150518223935.GM10274@atomide.com>
References: <1430528752-316-1-git-send-email-tony@atomide.com>
 <1430528752-316-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51961 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755021AbbERWjh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 May 2015 18:39:37 -0400
Content-Disposition: inline
In-Reply-To: <1430528752-316-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tim Nordell <tim.nordell@logicpd.com>

* Tony Lindgren <tony@atomide.com> [150501 18:07]:
> +&gpmc {
> +	ranges = <1 0 0x08000000 0x1000000>;	/* CS1: 16MB for LAN9221 */
> +
> +	ethernet@gpmc {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lan9221_pins>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> +		reg = <1 0 0xff>;
> +	};
> +};
> +
> +&mmc1 {
> +	interrupts-extended = <&intc 83 &omap3_pmx_core 0x11a>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins &mmc1_cd>;
> +	cd-gpios = <&gpio4 31 IRQ_TYPE_LEVEL_LOW>;
> +	vmmc-supply = <&vmmc1>;
> +	bus-width = <4>;
> +	cap-power-off-card;
> +};

And these were missing the comments for the GPIO line numbers as
done for the other GPIOs in the dts file. Updated patch below.

Regards,

Tony

8< ----------------------
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 13 May 2015 11:42:59 -0700
Subject: [PATCH] ARM: dts: Add minimal support for LogicPD Torpedo DM3730
 devkit

The LogicPD Torpedo DM3730 devkit consists of a base board and
two processor boards. One of the processor boards has a WLAN and
the other one does not.

Let's set up basic dts file so we can move to device tree only
based booting over next few merge windows. So far I've tested
that UARTs, MMC1, USB OTG, smsc911x, and basic PM support works.

Note that the wireless support in kernel for wl1283 seems to be
broken, it tries to load wl127x-nvs.bin instead of wl128x-nvs.bin
with firmware.

Cc: Tim Nordell <tim.nordell@logicpd.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -360,6 +360,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += \
 	am3517-craneboard.dtb \
 	am3517-evm.dtb \
 	am3517_mt_ventoux.dtb \
+	logicpd-torpedo-37xx-devkit.dtb \
 	omap3430-sdp.dtb \
 	omap3-beagle.dtb \
 	omap3-beagle-xm.dtb \
--- /dev/null
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -0,0 +1,157 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "omap36xx.dtsi"
+#include "logicpd-torpedo-som.dtsi"
+#include "omap-gpmc-smsc9221.dtsi"
+
+/ {
+	model = "LogicPD Zoom DM3730 Torpedo Development Kit";
+	compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap36xx";
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_key_pins &gpio_key_pins_wkup>;
+
+		sysboot2 {
+			label = "sysboot2";
+			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;	/* gpio2 */
+			linux,code = <BTN_0>;
+			gpio-key,wakeup;
+		};
+
+		sysboot5 {
+			label = "sysboot5";
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;	/* gpio7 */
+			linux,code = <BTN_1>;
+			gpio-key,wakeup;
+		};
+
+		gpio1 {
+			label = "gpio1";
+			gpios = <&gpio6 21 GPIO_ACTIVE_LOW>;	/* gpio181 */
+			linux,code = <BTN_2>;
+			gpio-key,wakeup;
+		};
+
+		gpio2 {
+			label = "gpio2";
+			gpios = <&gpio6 18 GPIO_ACTIVE_LOW>;	/* gpio178 */
+			linux,code = <BTN_3>;
+			gpio-key,wakeup;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio6 20 GPIO_ACTIVE_HIGH>;	/* gpio180 */
+			linux,default-trigger = "cpu0";
+		};
+
+		led2 {
+			label = "led2";
+			gpios = <&gpio6 19 GPIO_ACTIVE_HIGH>;	/* gpio179 */
+			linux,default-trigger = "none";
+		};
+	};
+};
+
+&charger {
+	ti,bb-uvolt = <3200000>;
+	ti,bb-uamp = <150>;
+};
+
+&gpmc {
+	ranges = <1 0 0x08000000 0x1000000>;	/* CS1: 16MB for LAN9221 */
+
+	ethernet@gpmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&lan9221_pins>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;		/* gpio129 */
+		reg = <1 0 0xff>;
+	};
+};
+
+&mmc1 {
+	interrupts-extended = <&intc 83 &omap3_pmx_core 0x11a>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins &mmc1_cd>;
+	cd-gpios = <&gpio4 31 IRQ_TYPE_LEVEL_LOW>;		/* gpio127 */
+	vmmc-supply = <&vmmc1>;
+	bus-width = <4>;
+	cap-power-off-card;
+};
+
+&omap3_pmx_core {
+	gpio_key_pins: pinmux_gpio_key_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21d6, PIN_INPUT_PULLUP | MUX_MODE4)	/* mcspi2_clk.gpio_178 */
+			OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT_PULLUP | MUX_MODE4)	/* mcspi2_cs0.gpio_181 */
+		>;
+	};
+
+	led_pins: pinmux_led_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21d8, PIN_OUTPUT | MUX_MODE4)	/* gpio_179 */
+			OMAP3_CORE1_IOPAD(0x21da, PIN_OUTPUT | MUX_MODE4)	/* gpio_180 */
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2144, PIN_OUTPUT | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
+			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
+			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat0.sdmmc1_dat0 */
+			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
+			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
+			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
+		>;
+	};
+};
+
+&omap3_pmx_wkup {
+	gpio_key_pins_wkup: pinmux_gpio_key_pins_wkup {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a0a, PIN_INPUT_PULLUP | MUX_MODE4)	/* sys_boot0.gpio_2 */
+			OMAP3_WKUP_IOPAD(0x2a14, PIN_INPUT_PULLUP | MUX_MODE4)	/* sys_boot5.gpio_7 */
+		>;
+	};
+
+	lan9221_pins: pinmux_lan9221_pins {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a5a, PIN_INPUT | MUX_MODE4)		/* reserved.gpio_129 */
+		>;
+	};
+
+	mmc1_cd: pinmux_mmc1_cd {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a54, PIN_INPUT_PULLUP | MUX_MODE4)	/* reserved.gpio_127 */
+		>;
+	};
+};
+
+&uart1 {
+	interrupts-extended = <&intc 72 &omap3_pmx_core OMAP3_UART1_RX>;
+};
+
+/* Wired to the tps65950 on the SOM, only the USB connector is on the devkit */
+&usb_otg_hs {
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
+	mode = <3>;
+	power = <50>;
+};
--- /dev/null
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -0,0 +1,162 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	cpus {
+		cpu@0 {
+			cpu0-supply = <&vcc>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		user0 {
+			label = "user0";
+			gpios = <&twl_gpio 18 GPIO_ACTIVE_LOW>;	/* LEDA */
+			linux,default-trigger = "none";
+		};
+	};
+
+	wl12xx_vmmc: wl12xx_vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio5 29 0>;   /* gpio157 */
+		startup-delay-us = <70000>;
+		enable-active-high;
+		vin-supply = <&vmmc2>;
+	};
+};
+
+&gpmc {
+	ranges = <0 0 0x00000000 0x1000000>;	/* CS0: 16MB for NAND */
+
+	nand@0,0 {
+		linux,mtd-name = "micron,mt29f4g16abbda3w";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		nand-bus-width = <16>;
+		ti,nand-ecc-opt = "bch8";
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		gpmc,device-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* u-boot uses mtdparts=omap2-nand.0:512k(x-loader),1920k(u-boot),128k(u-boot-env),4m(kernel),-(fs) */
+
+		x-loader@0 {
+			label = "x-loader";
+			reg = <0 0x80000>;
+		};
+
+		bootloaders@80000 {
+			label = "u-boot";
+			reg = <0x80000 0x1e0000>;
+		};
+
+		bootloaders_env@260000 {
+			label = "u-boot-env";
+			reg = <0x260000 0x20000>;
+		};
+
+		kernel@280000 {
+			label = "kernel";
+			reg = <0x280000 0x400000>;
+		};
+
+		filesystem@680000 {
+			label = "fs";
+			reg = <0x680000 0>;	/* 0 = MTDPART_SIZ_FULL */
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+	};
+};
+
+/*
+ * Only found on the wireless SOM. For the SOM without wireless, the pins for
+ * MMC3 can be routed with jumpers to the second MMC slot on the devkit and
+ * gpio157 is not connected. So this should be OK to keep common for now,
+ * probably device tree overlays is the way to go with the various SOM and
+ * jumpering combinations for the long run.
+ */
+&mmc3 {
+	interrupts-extended = <&intc 94 &omap3_pmx_core2 0x46>;
+	pinctrl-0 = <&mmc3_pins &mmc3_core2_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&wl12xx_vmmc>;
+	non-removable;
+	bus-width = <4>;
+	cap-power-off-card;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1283";
+		reg = <2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>; /* gpio 152 */
+		ref-clock-frequency = <26000000>;
+	};
+};
+
+&omap3_pmx_core {
+	mmc3_pins: pinmux_mm3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2164, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat4.sdmmc3_dat0 */
+			OMAP3_CORE1_IOPAD(0x2166, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat5.sdmmc3_dat1 */
+			OMAP3_CORE1_IOPAD(0x2168, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat6.sdmmc3_dat2 */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat6.sdmmc3_dat3 */
+			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT_PULLUP | MUX_MODE4)	/* mcbsp4_clkx.gpio_152 */
+			OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE4)	/* mcbsp1_fsr.gpio_157 */
+		>;
+	};
+};
+
+&omap3_pmx_core2 {
+	mmc3_core2_pins: pinmux_mmc3_core2_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25d8, PIN_INPUT_PULLUP | MUX_MODE2)   /* etk_clk.sdmmc3_clk */
+			OMAP3630_CORE2_IOPAD(0x25da, PIN_INPUT_PULLUP | MUX_MODE2)   /* etk_ctl.sdmmc3_cmd */
+		>;
+	};
+};
+
+#include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
+
+&twl {
+	twl_power: power {
+		compatible = "ti,twl4030-power-idle-osc-off", "ti,twl4030-power-idle";
+		ti,use_poweroff;
+	};
+};
+
+&twl_gpio {
+	ti,use-leds;
+};
