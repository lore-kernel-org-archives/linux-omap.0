From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH v2 2/5] ARM: dts: omap3: Add support for INCOstartec DBB056 baseboard
Date: Wed, 22 Jan 2014 20:04:17 +0100
Message-ID: <1390417460-3134-3-git-send-email-chf.fritz@googlemail.com>
References: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:61611 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbaAVTEr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jan 2014 14:04:47 -0500
In-Reply-To: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, bcousson@baylibre.com, "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <zonque@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

INCOstartec LILLY-DBB056 is a carrier board (baseboard) for
computer-on-module LILLY-A83X.

This patch adds device-tree support for most of its features.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/omap3-lilly-dbb056.dts |  160 ++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-lilly-dbb056.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cfd364d..b449161 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -215,6 +215,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-gta04.dtb \
 	omap3-igep0020.dtb \
 	omap3-igep0030.dtb \
+	omap3-lilly-dbb056.dtb \
 	omap3-zoom3.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
diff --git a/arch/arm/boot/dts/omap3-lilly-dbb056.dts b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
new file mode 100644
index 0000000..a700b71
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
@@ -0,0 +1,160 @@
+/*
+ * Copyright (C) 2014 Christoph Fritz <chf.fritzc@googlemail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+/dts-v1/;
+
+#include "omap3-lilly-a83x.dtsi"
+
+/ {
+	model = "INCOstartec LILLY-DBB056 (DM3730)";
+	compatible = "incostartec,omap3-lilly-dbb056", "incostartec,omap3-lilly-a83x", "ti,omap36xx", "ti,omap3";
+};
+
+&twl {
+	vaux2: regulator-vaux2 {
+		compatible = "ti,twl4030-vaux2";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+};
+
+&omap3_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_pins>;
+
+	lan9117_pins: pinmux_lan9117_pins {
+		pinctrl-single,pins = <
+			0xe4 (PIN_INPUT | MUX_MODE4)   /* gpio_98 */
+		>;
+	};
+
+	gpio4_pins: pinmux_gpio4_pins {
+		pinctrl-single,pins = <
+			0xfe (PIN_INPUT | MUX_MODE4)   /* gpio_111 -> sja1000 IRQ */
+		>;
+	};
+
+	lcd_pins: pinmux_lcd_pins {
+		pinctrl-single,pins = <
+			0x0a4 (PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
+			0x0a6 (PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
+			0x0a8 (PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
+			0x0aa (PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
+			0x0ac (PIN_OUTPUT | MUX_MODE0)   /* dss_data0.dss_data0 */
+			0x0ae (PIN_OUTPUT | MUX_MODE0)   /* dss_data1.dss_data1 */
+			0x0b0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data2.dss_data2 */
+			0x0b2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data3.dss_data3 */
+			0x0b4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data4.dss_data4 */
+			0x0b6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data5.dss_data5 */
+			0x0b8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
+			0x0ba (PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
+			0x0bc (PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
+			0x0be (PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
+			0x0c0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
+			0x0c2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
+			0x0c4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
+			0x0c6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
+			0x0c8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
+			0x0ca (PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
+			0x0cc (PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
+			0x0ce (PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
+			0x15c (PIN_OUTPUT | MUX_MODE4)   /* gpio_156 -> enable DSS */
+		>;
+	};
+
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_clk.sdmmc2_clk */
+			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_cmd.sdmmc2_cmd */
+			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_dat0.sdmmc2_dat0 */
+			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_dat1.sdmmc2_dat1 */
+			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_dat2.sdmmc2_dat2 */
+			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_dat3.sdmmc2_dat3 */
+			0x134 (PIN_OUTPUT | MUX_MODE1)   /* sdmmc2_dat4.sdmmc2_dir_dat0 */
+			0x136 (PIN_OUTPUT | MUX_MODE1)   /* sdmmc2_dat5.sdmmc2_dir_dat1 */
+			0x138 (PIN_OUTPUT | MUX_MODE1)   /* sdmmc2_dat6.sdmmc2_dir_cmd */
+			0x13a (PIN_INPUT | MUX_MODE1)    /* sdmmc2_dat7.sdmmc2_clkin */
+			0x16a (PIN_INPUT_PULLUP | MUX_MODE4)   /* gpio_163 -> wp */
+			0x16c (PIN_INPUT_PULLUP | MUX_MODE4)   /* gpio_164 -> cd */
+		>;
+	};
+
+	spi1_pins: pinmux_spi1_pins {
+		pinctrl-single,pins = <
+			0x198 (PIN_INPUT | MUX_MODE0)   /* mcspi1_clk.mcspi1_clk */
+			0x19a (PIN_INPUT | MUX_MODE0)   /* mcspi1_simo.mcspi1_simo */
+			0x19c (PIN_INPUT | MUX_MODE0)   /* mcspi1_somi.mcspi1_somi */
+			0x19e (PIN_INPUT_PULLDOWN | MUX_MODE0)   /* mcspi1_cs0.mcspi1_cs0 */
+		>;
+	};
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio4_pins>;
+};
+
+&mmc2 {
+	status = "okay";
+	bus-width = <4>;
+	vmmc-supply = <&vmmc1>;
+	cd-gpios = <&gpio6 4 0>;   /* gpio_164 */
+	wp-gpios = <&gpio6 3 0>;   /* gpio_163 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	ti,dual-volt;
+};
+
+&mcspi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+};
+
+&gpmc {
+	ranges = <0 0 0x30000000 0x1000000>,   /* nand assigned by COM a83x */
+		<4 0 0x20000000 0x01000000>,
+		<7 0 0x15000000 0x01000000>;   /* eth assigend by COM a83x */
+
+	ethernet@4,0 {
+		compatible = "smsc,lan9117", "smsc,lan9115";
+		bank-width = <2>;
+		gpmc,mux-add-data = <2>;
+		gpmc,cs-on-ns = <10>;
+		gpmc,cs-rd-off-ns = <65>;
+		gpmc,cs-wr-off-ns = <65>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <10>;
+		gpmc,adv-wr-off-ns = <10>;
+		gpmc,oe-on-ns = <10>;
+		gpmc,oe-off-ns = <65>;
+		gpmc,we-on-ns = <10>;
+		gpmc,we-off-ns = <65>;
+		gpmc,rd-cycle-ns = <100>;
+		gpmc,wr-cycle-ns = <100>;
+		gpmc,access-ns = <60>;
+		gpmc,page-burst-access-ns = <5>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <75>;
+		gpmc,wr-data-mux-bus-ns = <15>;
+		gpmc,wr-access-ns = <75>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,cycle2cycle-diffcsen;
+		vddvario-supply = <&reg_vcc3>;
+		vdd33a-supply = <&reg_vcc3>;
+		reg-io-width = <4>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <2 0x2>;
+		reg = <4 0 0xff>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lan9117_pins>;
+		phy-mode = "mii";
+		smsc,force-internal-phy;
+	};
+};
-- 
1.7.10.4

