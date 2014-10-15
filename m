From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH] ARM: dts: sbc-t3x: add DVI display data
Date: Wed, 15 Oct 2014 11:09:46 +0200
Message-ID: <1413364186-23752-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:40978 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbaJOIKm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Oct 2014 04:10:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Igor Grinberg <grinberg@compulab.co.il>, Dmitry Lifshitz <lifshitz@compulab.co.il>

Add DSS related pinmux and display data nodes required to support
DVI video out on SBC-T3530, SBC-T3730 and SBC-T3517.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3517.dts  |   22 +++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3530.dts  |   22 +++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3730.dts  |   24 ++++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   28 +++++++++++++++++++
 arch/arm/boot/dts/omap3-sb-t35.dtsi   |   49 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-sbc-t3517.dts |   14 +++++++++
 arch/arm/boot/dts/omap3-sbc-t3530.dts |   14 +++++++++
 arch/arm/boot/dts/omap3-sbc-t3730.dts |   14 +++++++++
 8 files changed, 187 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/omap3-cm-t3517.dts
index d00502f..65abe17 100644
--- a/arch/arm/boot/dts/omap3-cm-t3517.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
@@ -93,6 +93,17 @@
 			OMAP3_CORE1_IOPAD(0x2184, PIN_OUTPUT | MUX_MODE4)	/* mcbsp4_clkx.gpio_152 - USB HUB RST */
 		>;
 	};
+
+	dss_dpi_pins_cm_t3517: pinmux_dss_dpi_pins_cm_t3517 {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)		/* dss_data0.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)		/* dss_data1.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)		/* dss_data2.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)		/* dss_data3.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)		/* dss_data4.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)		/* dss_data5.dss_data5 */
+		>;
+	};
 };
 
 &hsusb1_phy {
@@ -134,3 +145,14 @@
 	bus-width = <4>;
 	cap-power-off-card;
 };
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&dss_dpi_pins_common
+		&dss_dpi_pins_cm_t3517
+	>;
+};
+
diff --git a/arch/arm/boot/dts/omap3-cm-t3530.dts b/arch/arm/boot/dts/omap3-cm-t3530.dts
index d145849..c1465a4 100644
--- a/arch/arm/boot/dts/omap3-cm-t3530.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3530.dts
@@ -36,6 +36,17 @@
 			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE1)		/* sdmmc2_dat7.sdmmc2_clkin */
 		>;
 	};
+
+	dss_dpi_pins_cm_t3530: pinmux_dss_dpi_pins_cm_t3530 {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)		/* dss_data0.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)		/* dss_data1.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)		/* dss_data2.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)		/* dss_data3.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)		/* dss_data4.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)		/* dss_data5.dss_data5 */
+		>;
+	};
 };
 
 &mmc2 {
@@ -46,3 +57,14 @@
 	bus-width = <4>;
 	cap-power-off-card;
 };
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&dss_dpi_pins_common
+		&dss_dpi_pins_cm_t3530
+	>;
+};
+
diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/omap3-cm-t3730.dts
index b3f9a50..4b36d80 100644
--- a/arch/arm/boot/dts/omap3-cm-t3730.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3730.dts
@@ -31,6 +31,19 @@
 	};
 };
 
+&omap3_pmx_wkup {
+	dss_dpi_pins_cm_t3730: pinmux_dss_dpi_pins_cm_t3730 {
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
 &omap3_pmx_core {
 
 	mmc2_pins: pinmux_mmc2_pins {
@@ -61,3 +74,14 @@
 	bus-width = <4>;
 	cap-power-off-card;
 };
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&dss_dpi_pins_common
+		&dss_dpi_pins_cm_t3730
+	>;
+};
+
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index c671a22..6b6c2f4 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -76,6 +76,34 @@
 			OMAP3_CORE1_IOPAD(0x21e2, PIN_OUTPUT | MUX_MODE4)	/* sys_clkout2.gpio_186 */
 		>;
 	};
+
+	dss_dpi_pins_common: pinmux_dss_dpi_pins_common {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)	/* dss_pclk.dss_pclk */
+			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)	/* dss_hsync.dss_hsync */
+			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)	/* dss_vsync.dss_vsync */
+			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)	/* dss_acbias.dss_acbias */
+
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
+		>;
+	};
 };
 
 &uart3 {
diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index d59e3de..103922c 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -2,6 +2,49 @@
  * Common support for CompuLab SB-T35 used on SBC-T3530, SBC-T3517 and SBC-T3730
  */
 
+/ {
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+	
+		powerdown-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;  /* gpio_54 */
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tfp410_pins>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint@0 {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tfp410_out: endpoint@0 {
+					remote-endpoint = <&dvi_connector_in>;
+				};
+			};
+		};
+	};
+
+	dvi0: connector@0 {
+		compatible = "dvi-connector";
+		label = "dvi";
+
+		port {
+			dvi_connector_in: endpoint {
+				remote-endpoint = <&tfp410_out>;
+			};
+		};
+	};
+};
+
 &omap3_pmx_core {
 	smsc2_pins: pinmux_smsc2_pins {
 		pinctrl-single,pins = <
@@ -9,6 +52,12 @@
 			OMAP3_CORE1_IOPAD(0x20d2, PIN_INPUT_PULLUP | MUX_MODE4)	/* gpmc_wait3.gpio_65 */
 		>;
 	};
+
+        tfp410_pins: pinmux_tfp410_pins {
+                pinctrl-single,pins = <
+                        OMAP3_CORE1_IOPAD(0x20b4, PIN_OUTPUT | MUX_MODE4)	/* gpmc_ncs3.gpio_54 */
+                >;
+        };
 };
 
 &gpmc {
diff --git a/arch/arm/boot/dts/omap3-sbc-t3517.dts b/arch/arm/boot/dts/omap3-sbc-t3517.dts
index 42189b6..4ec5d86 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3517.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
@@ -9,6 +9,10 @@
 	model = "CompuLab SBC-T3517 with CM-T3517";
 	compatible = "compulab,omap3-sbc-t3517", "compulab,omap3-cm-t3517", "ti,am3517", "ti,omap3";
 
+	aliases {
+		display0 = &dvi0;
+	};
+
 	/* Only one GPMC smsc9220 on SBC-T3517, CM-T3517 uses am35x Ethernet */
 	vddvario: regulator-vddvario-sb-t35 {
 		compatible = "regulator-fixed";
@@ -54,3 +58,13 @@
 	wp-gpios =  <&gpio2 27 GPIO_ACTIVE_HIGH>; /* gpio_59  */
 	cd-gpios =  <&gpio5 16 GPIO_ACTIVE_HIGH>; /* gpio_144 */
 };
+
+&dss {
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&tfp410_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
index bbbeea6..8dfc1df 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3530.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
@@ -8,6 +8,10 @@
 / {
 	model = "CompuLab SBC-T3530 with CM-T3530";
 	compatible = "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap3";
+
+	aliases {
+		display0 = &dvi0;
+	};
 };
 
 &omap3_pmx_core {
@@ -34,3 +38,13 @@
 &mmc1 {
 	cd-gpios =  <&twl_gpio 0 GPIO_ACTIVE_HIGH>;
 };
+
+&dss {
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&tfp410_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
index 08e4a70..6b69864 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
@@ -8,6 +8,10 @@
 / {
 	model = "CompuLab SBC-T3730 with CM-T3730";
 	compatible = "compulab,omap3-sbc-t3730", "compulab,omap3-cm-t3730", "ti,omap36xx", "ti,omap3";
+
+	aliases {
+		display0 = &dvi0;
+	};
 };
 
 &omap3_pmx_core {
@@ -25,3 +29,13 @@
 	ranges = <5 0 0x2c000000 0x01000000>,
 		 <4 0 0x2d000000 0x01000000>;
 };
+
+&dss {
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&tfp410_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
-- 
1.7.5.4

