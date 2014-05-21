From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/6] ARM: dts: am43x-epos-evm: add LCD data
Date: Wed, 21 May 2014 15:50:22 +0300
Message-ID: <1400676625-30078-4-git-send-email-tomi.valkeinen@ti.com>
References: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50237 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbaEUMvE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 08:51:04 -0400
In-Reply-To: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT data for am43x-epos-evm's LCD panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 101 +++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 167dbc8494de..9aa5af71f96f 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -19,6 +19,10 @@
 	model = "TI AM43x EPOS EVM";
 	compatible = "ti,am43x-epos-evm","ti,am4372","ti,am43";
 
+	aliases {
+		display0 = &lcd0;
+	};
+
 	vmmcsd_fixed: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
@@ -27,6 +31,44 @@
 		enable-active-high;
 	};
 
+	lcd0: display {
+		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		label = "lcd";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+
+		/*
+		 * SelLCDorHDMI, LOW to select HDMI. This is not really the
+		 * panel's enable GPIO, but we don't have HDMI driver support nor
+		 * support to switch between two displays, so using this gpio as
+		 * panel's enable should be safe.
+		 */
+		enable-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+
+		panel-timing {
+			clock-frequency = <33000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <210>;
+			hback-porch = <16>;
+			hsync-len = <30>;
+			vback-porch = <10>;
+			vfront-porch = <22>;
+			vsync-len = <13>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+	};
+
 	am43xx_pinmux: pinmux@44e10800 {
 		cpsw_default: cpsw_default {
 			pinctrl-single,pins = <
@@ -138,6 +180,46 @@
 				0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 			>;
 		};
+
+		dss_pins: dss_pins {
+			pinctrl-single,pins = <
+				0x020 (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
+				0x024 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+				0x028 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+				0x02C (PIN_OUTPUT_PULLUP | MUX_MODE1)
+				0x030 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+				0x034 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+				0x038 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+				0x03C (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 15 -> DSS DATA 16 */
+				0x0A0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
+				0x0A4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0A8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0AC (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0B0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0B4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0B8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0BC (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0C0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0C4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0C8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0CC (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0D0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0D4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0D8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+				0x0DC (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
+				0x0E0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
+				0x0E4 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
+				0x0E8 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
+				0x0EC (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
+			>;
+		};
+
+		lcd_pins: lcd_pins {
+			pinctrl-single,pins = <
+				/* GPMC CLK -> GPIO 2_1 to select LCD / HDMI */
+				0x08C (PIN_OUTPUT_PULLUP | MUX_MODE7)
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -260,6 +342,10 @@
 	status = "okay";
 };
 
+&gpio5 {
+	status = "okay";
+};
+
 &elm {
 	status = "okay";
 };
@@ -367,3 +453,18 @@
 	pinctrl-0 = <&spi1_pins>;
 	status = "okay";
 };
+
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_pins>;
+
+	port {
+		dpi_out: endpoint@0 {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <24>;
+		};
+	};
+};
-- 
1.9.1

