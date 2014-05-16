From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support for omap3-evm and ldp
Date: Fri, 16 May 2014 10:30:02 +0300
Message-ID: <1400225402-18274-5-git-send-email-tomi.valkeinen@ti.com>
References: <1400225402-18274-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39999 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785AbaEPHbG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 03:31:06 -0400
In-Reply-To: <1400225402-18274-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>

From: Tony Lindgren <tony@atomide.com>

Looks like quite a few omap3 boards have sharp ls037v7dw01 that's
configured as various panel dpi entries for whatever legacy reasons.
For device tree based support, let's just configure these properly for
panel ls037v7dw01 instead of panel dpi.

This patch creates a common file for panel ls037v7dw01, and makes
boards ldp and omap3-evm to use it.

The ls037v7dw01 also seems to be coupled with an ad7846 touchscreen
controller for the omaps, so let's add a basic configuration for
the touchscreen also using the default values.

Note that we can now remove the regulator-name = "vdds_dsi"
entry for ldp, that's no longer needed as we have the entry
for vdds_dsi-supply = <&vpll2>.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-evm-37xx.dts               | 50 ++++++++++++++++
 arch/arm/boot/dts/omap3-evm-common.dtsi            | 26 +++++++++
 arch/arm/boot/dts/omap3-ldp.dts                    | 29 ++++++++--
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    | 67 ++++++++++++++++++++++
 4 files changed, 167 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi

diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index 4df68ad3736a..a181e30daaef 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -26,7 +26,44 @@
 	};
 };
 
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&dss_dpi_pins1
+		&dss_dpi_pins2
+	>;
+};
+
 &omap3_pmx_core {
+	dss_dpi_pins1: pinmux_dss_dpi_pins2 {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
+			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
+			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
+			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
+
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
+
+			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE3)   /* dss_data18.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MODE3)   /* dss_data19.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE3)   /* dss_data20.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE3)   /* dss_data21.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE3)   /* dss_data22.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE3)   /* dss_data23.dss_data5 */
+		>;
+	};
+
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
 			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
@@ -75,6 +112,19 @@
 	};
 };
 
+&omap3_pmx_wkup {
+	dss_dpi_pins2: pinmux_dss_dpi_pins1 {
+		pinctrl-single,pins = <
+			0x0a (PIN_OUTPUT | MUX_MODE3)   /* sys_boot0.dss_data18 */
+			0x0c (PIN_OUTPUT | MUX_MODE3)   /* sys_boot1.dss_data19 */
+			0x10 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot3.dss_data20 */
+			0x12 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot4.dss_data21 */
+			0x14 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot5.dss_data22 */
+			0x16 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot6.dss_data23 */
+		>;
+	};
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index 3007e79c9cd6..8ae8f007c8ad 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -44,6 +44,11 @@
 
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
+#include "omap3-panel-sharp-ls037v7dw01.dtsi"
+
+&backlight0 {
+	gpios = <&twl_gpio 18 GPIO_ACTIVE_LOW>;
+};
 
 &i2c2 {
 	clock-frequency = <400000>;
@@ -61,6 +66,27 @@
 	};
 };
 
+&lcd_3v3 {
+	gpio = <&gpio5 25 GPIO_ACTIVE_LOW>;	/* gpio153 */
+	enable-active-low;
+};
+
+&lcd0 {
+	enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
+	reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
+	mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
+		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
+		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
+};
+
+&mcspi1 {
+	tsc2046@0 {
+		interrupt-parent = <&gpio6>;
+		interrupts = <15 0>;		/* gpio175 */
+		pendown-gpio = <&gpio6 15 0>;
+	};
+};
+
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 0abe986a4ecc..9c751e420f37 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -164,6 +164,11 @@
 
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
+#include "omap3-panel-sharp-ls037v7dw01.dtsi"
+
+&backlight0 {
+	gpios = <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
+};
 
 &i2c2 {
 	clock-frequency = <400000>;
@@ -173,6 +178,25 @@
 	clock-frequency = <400000>;
 };
 
+/* tps61130rsa enabled by twl4030 regen */
+&lcd_3v3 {
+	regulator-always-on;
+};
+
+&lcd0 {
+	enable-gpios = <&twl_gpio 15 GPIO_ACTIVE_HIGH>;	/* lcd INI */
+	reset-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;	/* gpio55, lcd RESB */
+	mode-gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>;	/* gpio56, lcd MO */
+};
+
+&mcspi1 {
+	tsc2046@0 {
+		interrupt-parent = <&gpio2>;
+		interrupts = <22 0>;		/* gpio54 */
+		pendown-gpio = <&gpio2 22 0>;
+	};
+};
+
 &mmc1 {
 	/* See 35xx errata 2.1.1.128 in SPRZ278F */
 	compatible = "ti,omap3-pre-es3-hsmmc";
@@ -247,8 +271,3 @@
 	/* Needed for ads7846 */
         regulator-name = "vcc";
 };
-
-&vpll2 {
-       /* Needed for DSS */
-       regulator-name = "vdds_dsi";
-};
diff --git a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
new file mode 100644
index 000000000000..93934762f6d5
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
@@ -0,0 +1,67 @@
+/*
+ * Common file for omap dpi panels with QVGA and reset pins
+ *
+ * Note that the board specifc DTS file needs to specify
+ * at minimum the GPIO enable-gpios for display, and
+ * gpios for gpio-backlight.
+ */
+
+/ {
+	aliases {
+		display0 = &lcd0;
+	};
+
+	backlight0: backlight {
+		compatible = "gpio-backlight";
+		default-on;
+	};
+
+	/* 3.3V GPIO controlled regulator for LCD_ENVDD */
+	lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <70000>;
+	};
+
+	lcd0: display {
+		compatible = "sharp,ls037v7dw01";
+		label = "lcd";
+		power-supply = <&lcd_3v3>;
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+	};
+};
+
+&dss {
+	status = "ok";
+	vdds_dsi-supply = <&vpll2>;
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <18>;
+		};
+	};
+};
+
+&mcspi1 {
+	tsc2046@0 {
+		reg = <0>;			/* CS0 */
+		compatible = "ti,tsc2046";
+		spi-max-frequency = <1000000>;
+		vcc-supply = <&lcd_3v3>;
+		ti,x-min = /bits/ 16 <0>;
+		ti,x-max = /bits/ 16 <8000>;
+		ti,y-min = /bits/ 16 <0>;
+		ti,y-max = /bits/ 16 <4800>;
+		ti,x-plate-ohms = /bits/ 16 <40>;
+		ti,pressure-max = /bits/ 16 <255>;
+		ti,swap-xy;
+		linux,wakeup;
+	};
+};
-- 
1.9.1

