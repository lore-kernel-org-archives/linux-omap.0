From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Thu, 13 Mar 2014 14:28:29 +0530
Message-ID: <1394701109-6721-5-git-send-email-sathyap@ti.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60114 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbaCMI7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 04:59:06 -0400
In-Reply-To: <1394701109-6721-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, paul@pwsan.com
Cc: Sathya Prakash M R <sathyap@ti.com>

Add device node for DSS module for AM4372. Both the
AM437x-Gp evm and Am43x-Epos evm use the same LCD panel.
The lcd timings are added in respective dts files.
Adds display pinctrl and enables required gpio.
Also set the right parent clock to the DSS clock.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        |   28 +++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts  |   77 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts |   73 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am43xx-clocks.dtsi |    2 +
 4 files changed, 180 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ea55a4e..b72a7df 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -684,6 +684,34 @@
 			num-cs = <4>;
                         status = "disabled";
                 };
+
+		dss: dss@4832A000 {
+			compatible = "ti,omap3-dss", "simple-bus";
+			reg = <0x4832A000 0x200>;
+			ti,hwmods = "dss_core";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@4832A400 {
+				compatible = "ti,omap3-dispc";
+				reg = <0x4832A400 0x400>;
+				interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_dispc";
+			};
+
+			dpi: encoder@0 {
+				compatible = "ti,omap3-dpi";
+			};
+
+			rfbi: rfbi@4832A800 {
+				compatible = "ti,omap3-rfbi";
+			reg = <0x4832A800 0x100>;
+				ti,hwmods = "dss_rfbi";
+			};
+
+		};
+
 	};
 
 	clocks {
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
diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 85e7d4b..b20e192 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -512,6 +512,8 @@ disp_clk: disp_clk@44df4244 {
 	compatible = "ti,mux-clock";
 	clocks = <&dpll_disp_m2_ck>, <&dpll_core_m5_ck>, <&dpll_per_m2_ck>;
 	reg = <0x44df4244 0x4>;
+	bit-mask = <0x3>;
+	set-rate-parent;
 };
 
 dpll_extdev_ck: dpll_extdev_ck@44df2e60 {
-- 
1.7.9.5

