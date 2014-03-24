From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH V3 6/6] ARM: DTS: AM43xx: Add DSS nodes
Date: Mon, 24 Mar 2014 16:31:56 +0530
Message-ID: <1395658916-9032-7-git-send-email-sathyap@ti.com>
References: <1395658916-9032-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48679 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbaCXLCM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Mar 2014 07:02:12 -0400
In-Reply-To: <1395658916-9032-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Sathya Prakash M R <sathyap@ti.com>

Both the AM437x-Gp evm and Am43x-Epos evm
use the same LCD panel.
The lcd timings are added in respective dts files.
Adds display pinctrl and enables required gpio.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  |   77 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts |   73 ++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 2e79bda..a178e8d 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -24,6 +24,33 @@
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
 		default-brightness-level = <8>;
 	};
+
+	aliases {
+		display0 = &lcd0;
+	};
+
+	lcd0: display {
+		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		label = "lcd";
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
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+	};
 };
 
 &am43xx_pinmux {
@@ -46,6 +73,40 @@
 			0x164 MUX_MODE0       /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
 		>;
 	};
+
+	dss_pinctrl: dss_pinctrl {
+		pinctrl-single,pins = <
+			0x020 (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
+			0x024 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x028 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x02C (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x030 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x034 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x038 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x03C (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 15 -> DSS DATA 16 */
+			0x0A0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
+			0x0A4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0A8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0AC (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0B0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0B4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0B8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0BC (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0C0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0C4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0C8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0CC (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0D0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0D4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0D8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0DC (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
+			0x0E0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
+			0x0E4 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
+			0x0E8 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
+			0x0EC (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
+			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7) /* GPIO 5_8 to select LCD / HDMI */
+		>;
+	};
 };
 
 &i2c0 {
@@ -69,3 +130,19 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&ecap0_pins>;
 };
+
+&gpio5 {
+	status = "okay";
+};
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_pinctrl>;
+
+	dpi_out: endpoint@0 {
+		remote-endpoint = <&lcd_in>;
+		data-lines = <24>;
+	};
+};
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 2ebcde6..3f9643b 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -27,6 +27,33 @@
 		enable-active-high;
 	};
 
+	aliases {
+		display0 = &lcd0;
+	};
+
+	lcd0: display {
+		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		label = "lcd";
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
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+	};
+
 	am43xx_pinmux: pinmux@44e10800 {
 		cpsw_default: cpsw_default {
 			pinctrl-single,pins = <
@@ -122,6 +149,40 @@
 				0x19c (PIN_OUTPUT | MUX_MODE3)          /* mcasp0_ahclkr.spi1_cs0 */
 			>;
 		};
+
+		dss_pinctrl: dss_pinctrl {
+		pinctrl-single,pins = <
+			0x020 (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
+			0x024 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x028 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x02C (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x030 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x034 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x038 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x03C (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 15 -> DSS DATA 16 */
+			0x0A0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
+			0x0A4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0A8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0AC (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0B0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0B4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0B8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0BC (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0C0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0C4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0C8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0CC (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0D0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0D4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0D8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0DC (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
+			0x0E0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
+			0x0E4 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
+			0x0E8 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
+			0x0EC (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
+			0x08C (PIN_OUTPUT_PULLUP | MUX_MODE7) /* GPMC CLK -> GPIO 2_1 to select LCD / HDMI */
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -279,3 +340,15 @@
 	pinctrl-0 = <&spi1_pins>;
 	status = "okay";
 };
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_pinctrl>;
+
+	dpi_out: endpoint@0 {
+		remote-endpoint = <&lcd_in>;
+		data-lines = <24>;
+	};
+};
-- 
1.7.9.5

