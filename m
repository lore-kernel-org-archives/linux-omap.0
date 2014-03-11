From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 3/3] ARM: dts: overo: Add support for 3.5'' LCD output
Date: Tue, 11 Mar 2014 13:34:17 +0100
Message-ID: <1394541257-25605-4-git-send-email-florian.vaussard@epfl.ch>
References: <1394541257-25605-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:57000 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755327AbaCKMec (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Mar 2014 08:34:32 -0400
In-Reply-To: <1394541257-25605-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Alto35 expansion board has a ZIF connector for a 3.5'' LCD.
Add a common include file for this configuration, and use it
on Alto35.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi |   1 +
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi  | 145 +++++++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi

diff --git a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
index 19d6486..7aae8fb 100644
--- a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
@@ -11,6 +11,7 @@
  */
 
 #include "omap3-overo-common-peripherals.dtsi"
+#include "omap3-overo-common-lcd35.dtsi"
 
 #include <dt-bindings/input/input.h>
 
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
new file mode 100644
index 0000000..5e0373b3
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
@@ -0,0 +1,145 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * 4.3'' LCD panel output for some Gumstix Overo boards (Gallop43, Chestnut43)
+ */
+
+&omap3_pmx_core {
+	dss_dpi_pins: pinmux_dss_dpi_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)	/* dss_pclk.dss_pclk */
+			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)	/* dss_hsync.dss_hsync */
+			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)	/* dss_vsync.dss_vsync */
+			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)	/* dss_acbias.dss_acbias */
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)	/* dss_data0.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)	/* dss_data1.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)	/* dss_data2.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)	/* dss_data3.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)	/* dss_data4.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)	/* dss_data5.dss_data5 */
+			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)	/* dss_data6.dss_data6 */
+			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)	/* dss_data7.dss_data7 */
+			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)	/* dss_data8.dss_data8 */
+			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)	/* dss_data9.dss_data9 */
+			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)	/* dss_data10.dss_data10 */
+			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)	/* dss_data11.dss_data11 */
+			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)	/* dss_data12.dss_data12 */
+			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)	/* dss_data13.dss_data13 */
+			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)	/* dss_data14.dss_data14 */
+			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)	/* dss_data15.dss_data15 */
+			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE0)	/* dss_data16.dss_data16 */
+			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE0)	/* dss_data17.dss_data17 */
+			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE0)	/* dss_data18.dss_data18 */
+			OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MODE0)	/* dss_data19.dss_data19 */
+			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE0)	/* dss_data20.dss_data20 */
+			OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE0)	/* dss_data21.dss_data21 */
+			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)	/* dss_data22.dss_data22 */
+			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)	/* dss_data23.dss_data23 */
+			OMAP3_CORE1_IOPAD(0x2174, PIN_OUTPUT | MUX_MODE4)	/* uart2_cts.gpio_144 */
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE4)	/* uart2_rts.gpio_145 */
+		>;
+	};
+
+	mcspi1_pins: pinmux_mcspi1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c8, PIN_INPUT | MUX_MODE0)	/* mcspi1_clk.mcspi1_clk */
+			OMAP3_CORE1_IOPAD(0x21ca, PIN_INPUT | MUX_MODE0)	/* mcspi1_simo.mcspi1_simo */
+			OMAP3_CORE1_IOPAD(0x21cc, PIN_INPUT | MUX_MODE0)	/* mcspi1_somi.mcspi1_somi */
+			OMAP3_CORE1_IOPAD(0x21ce, PIN_INPUT | MUX_MODE0)	/* mcspi1_cs0.mcspi1_cs0 */
+		>;
+	};
+
+	ads7846_pins: pinmux_ads7846_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2138, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* csi2_dx1.gpio_114 */
+		>;
+	};
+};
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&lcd_in>;
+		data-lines = <24>;
+	};
+};
+
+/ {
+	aliases {
+		display0 = &lcd0;
+	};
+
+	lcd0: display@0 {
+		compatible = "lg,lb035q02", "panel-dpi";
+		label = "lcd";
+
+		gpios = <&gpio5 16 GPIO_ACTIVE_HIGH		/* gpio_144 */
+			 &gpio5 17 GPIO_ACTIVE_HIGH>;		/* gpio_145 */
+
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+
+		panel-timing {
+			clock-frequency = <6500000>;
+			hactive = <320>;
+			vactive = <240>;
+			hfront-porch = <20>;
+			hback-porch = <68>;
+			hsync-len = <2>;
+			vback-porch = <18>;
+			vfront-porch = <4>;
+			vsync-len = <2>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+	};
+
+	ads7846reg: ads7846-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "ads7846-reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&mcspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi1_pins>;
+
+	/* touch controller */
+	ads7846@0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ads7846_pins>;
+
+		reg = <0>;				/* CS0 */
+		compatible = "ti,ads7846";
+		interrupt-parent = <&gpio4>;
+		interrupts = <18 0>;			/* gpio_114 */
+		spi-max-frequency = <1500000>;
+		pendown-gpio = <&gpio4 18 0>;
+		vcc-supply = <&ads7846reg>;
+
+		ti,x-min = /bits/ 16 <0x0>;
+		ti,x-max = /bits/ 16 <0x0fff>;
+		ti,y-min = /bits/ 16 <0x0>;
+		ti,y-max = /bits/ 16 <0x0fff>;
+		ti,x-plate-ohms = /bits/ 16 <180>;
+		ti,pressure-max = /bits/ 16 <255>;
+
+		linux,wakeup;
+	};
+};
-- 
1.8.3.2

