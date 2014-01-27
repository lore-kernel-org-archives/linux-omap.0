From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 2/4] ARM: dts: omap3: Add support for INCOstartec DBB056 baseboard
Date: Mon, 27 Jan 2014 01:33:15 +0100
Message-ID: <1390782797-24105-3-git-send-email-chf.fritz@googlemail.com>
References: <1390782797-24105-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:56927 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbaA0Ado (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jan 2014 19:33:44 -0500
In-Reply-To: <1390782797-24105-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, bcousson@baylibre.com, Daniel Mack <zonque@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

INCOstartec LILLY-DBB056 is a carrier board (baseboard) for
computer-on-module LILLY-A83X.

This patch adds device-tree support for most of its features.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/omap3-lilly-dbb056.dts |  165 ++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)
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
index 0000000..89e2b68
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
@@ -0,0 +1,165 @@
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
+&vpll2 {
+        /* Needed for DSS */
+        regulator-name = "vdds_dsi";
+};
+
+&omap3_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_pins>;
+
+	lan9117_pins: pinmux_lan9117_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2114, PIN_INPUT | MUX_MODE4)   /* cam_fld.gpio_98 */
+		>;
+	};
+
+	gpio4_pins: pinmux_gpio4_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x212e, PIN_INPUT | MUX_MODE4)   /* cam_xclkb.gpio_111 -> sja1000 IRQ */
+		>;
+	};
+
+	lcd_pins: pinmux_lcd_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
+			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
+			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
+			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)   /* dss_data0.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)   /* dss_data1.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)   /* dss_data2.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)   /* dss_data3.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)   /* dss_data4.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)   /* dss_data5.dss_data5 */
+			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
+			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
+			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
+			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
+			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
+			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
+			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
+			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
+			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
+			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
+			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
+			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
+			OMAP3_CORE1_IOPAD(0x218c, PIN_OUTPUT | MUX_MODE4)   /* mcbsp1_clk.gpio_156 -> enable DSS */
+		>;
+	};
+
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_clk.sdmmc2_clk */
+			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_cmd.sdmmc2_cmd */
+			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_dat0.sdmmc2_dat0 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_dat1.sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_dat2.sdmmc2_dat2 */
+			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)   /* sdmmc2_dat3.sdmmc2_dat3 */
+			OMAP3_CORE1_IOPAD(0x2164, PIN_OUTPUT | MUX_MODE1)   /* sdmmc2_dat4.sdmmc2_dir_dat0 */
+			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE1)   /* sdmmc2_dat5.sdmmc2_dir_dat1 */
+			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE1)   /* sdmmc2_dat6.sdmmc2_dir_cmd */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE1)    /* sdmmc2_dat7.sdmmc2_clkin */
+			OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLUP | MUX_MODE4)   /* uart3_cts_rctx.gpio_163 -> wp */
+			OMAP3_CORE1_IOPAD(0x219c, PIN_INPUT_PULLUP | MUX_MODE4)   /* uart3_rts_sd.gpio_164 -> cd */
+		>;
+	};
+
+	spi1_pins: pinmux_spi1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c8, PIN_INPUT | MUX_MODE0)   /* mcspi1_clk.mcspi1_clk */
+			OMAP3_CORE1_IOPAD(0x21ca, PIN_INPUT | MUX_MODE0)   /* mcspi1_simo.mcspi1_simo */
+			OMAP3_CORE1_IOPAD(0x21cc, PIN_INPUT | MUX_MODE0)   /* mcspi1_somi.mcspi1_somi */
+			OMAP3_CORE1_IOPAD(0x21ce, PIN_INPUT_PULLDOWN | MUX_MODE0)   /* mcspi1_cs0.mcspi1_cs0 */
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

