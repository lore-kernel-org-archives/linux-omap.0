From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH v2 3/6] ARM: dts: cm-t54: add HDMI/DVI display data
Date: Wed, 17 Sep 2014 15:10:05 +0300
Message-ID: <1410955808-2174-4-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
 <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:53335 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634AbaIQMKT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2014 08:10:19 -0400
In-Reply-To: <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add DSS related pinmux and display data nodes required to support HDMI
and DVI video out on CM-T54.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
v2: * Fixed comment style issue for mux mode.
      Follow the convention mode0_name.modeX_name for pins
      which mux mode differs from MUX_MODE0

    * Moved aliases node to the top of dts file

 arch/arm/boot/dts/omap5-cm-t54.dts |  158 ++++++++++++++++++++++++++++++++++++
 1 files changed, 158 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 44a9f23..d2f241d 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -16,6 +16,11 @@
 		reg = <0x80000000 0x7F000000>; /* 2048 MB */
 	};
 
+	aliases {
+		display0 = &hdmi0;
+		display1 = &dvi0;
+	};
+
 	vmmcsd_fixed: fixed-regulator-mmcsd {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
@@ -66,6 +71,64 @@
 			default-state = "off";
 		};
 	};
+
+	hdmi0: connector@0 {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		type = "a";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_conn_pins>;
+
+		hpd-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>; /* GPIO 193, HPD */
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint@0 {
+					remote-endpoint = <&dpi_dvi_out>;
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
+	dvi0: connector@1 {
+		compatible = "dvi-connector";
+		label = "dvi";
+
+		digital;
+
+		ddc-i2c-bus = <&i2c2>;
+
+		port {
+			dvi_connector_in: endpoint {
+				remote-endpoint = <&tfp410_out>;
+			};
+		};
+	};
 };
 
 &omap5_pmx_core {
@@ -88,6 +151,13 @@
 		>;
 	};
 
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x01b8, PIN_INPUT | MUX_MODE0) /* i2c2_scl */
+			OMAP5_IOPAD(0x01ba, PIN_INPUT | MUX_MODE0) /* i2c2_sda */
+		>;
+	};
+
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
 			OMAP5_IOPAD(0x01e2, PIN_INPUT_PULLUP | MUX_MODE0) /* sdcard_clk */
@@ -144,6 +214,53 @@
 			OMAP5_IOPAD(0x00b6, PIN_OUTPUT | MUX_MODE6) /* hsi2_acdata.gpio3_83 */
 		>;
 	};
+
+	dss_hdmi_pins: pinmux_dss_hdmi_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x013c, PIN_INPUT_PULLUP | MUX_MODE0) /* hdmi_cec */
+			OMAP5_IOPAD(0x0140, PIN_INPUT | MUX_MODE0) /* hdmi_ddc_scl */
+			OMAP5_IOPAD(0x0142, PIN_INPUT | MUX_MODE0) /* hdmi_ddc_sda */
+		>;
+	};
+
+	hdmi_conn_pins: pinmux_hdmi_conn_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x013e, PIN_INPUT | MUX_MODE6) /* hdmi_hpd.gpio7_193 */
+		>;
+	};
+
+	dss_dpi_pins: pinmux_dss_dpi_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x0104, PIN_OUTPUT | MUX_MODE3) /* rfbi_data15.dispc_data15 */
+			OMAP5_IOPAD(0x0106, PIN_OUTPUT | MUX_MODE3) /* rfbi_data14.dispc_data14 */
+			OMAP5_IOPAD(0x0108, PIN_OUTPUT | MUX_MODE3) /* rfbi_data13.dispc_data13 */
+			OMAP5_IOPAD(0x010a, PIN_OUTPUT | MUX_MODE3) /* rfbi_data12.dispc_data12 */
+			OMAP5_IOPAD(0x010c, PIN_OUTPUT | MUX_MODE3) /* rfbi_data11.dispc_data11 */
+			OMAP5_IOPAD(0x010e, PIN_OUTPUT | MUX_MODE3) /* rfbi_data10.dispc_data10 */
+			OMAP5_IOPAD(0x0110, PIN_OUTPUT | MUX_MODE3) /* rfbi_data9.dispc_data9 */
+			OMAP5_IOPAD(0x0112, PIN_OUTPUT | MUX_MODE3) /* rfbi_data8.dispc_data8 */
+			OMAP5_IOPAD(0x0114, PIN_OUTPUT | MUX_MODE3) /* rfbi_data7.dispc_data7 */
+			OMAP5_IOPAD(0x0116, PIN_OUTPUT | MUX_MODE3) /* rfbi_data6.dispc_data6 */
+			OMAP5_IOPAD(0x0118, PIN_OUTPUT | MUX_MODE3) /* rfbi_data5.dispc_data5 */
+			OMAP5_IOPAD(0x011a, PIN_OUTPUT | MUX_MODE3) /* rfbi_data4.dispc_data4 */
+			OMAP5_IOPAD(0x011c, PIN_OUTPUT | MUX_MODE3) /* rfbi_data3.dispc_data3 */
+			OMAP5_IOPAD(0x011e, PIN_OUTPUT | MUX_MODE3) /* rfbi_data2.dispc_data2 */
+			OMAP5_IOPAD(0x0120, PIN_OUTPUT | MUX_MODE3) /* rfbi_data1.dispc_data1 */
+			OMAP5_IOPAD(0x0122, PIN_OUTPUT | MUX_MODE3) /* rfbi_data0.dispc_data0 */
+			OMAP5_IOPAD(0x0124, PIN_OUTPUT | MUX_MODE3) /* rfbi_we.dispc_vsync */
+			OMAP5_IOPAD(0x0126, PIN_OUTPUT | MUX_MODE3) /* rfbi_cs0.dispc_hsync */
+			OMAP5_IOPAD(0x0128, PIN_OUTPUT | MUX_MODE3) /* rfbi_a0.dispc_de */
+			OMAP5_IOPAD(0x012a, PIN_OUTPUT | MUX_MODE3) /* rfbi_re.dispc_pclk */
+			OMAP5_IOPAD(0x012c, PIN_OUTPUT | MUX_MODE3) /* rfbi_hsync0.dispc_data17 */
+			OMAP5_IOPAD(0x012e, PIN_OUTPUT | MUX_MODE3) /* rfbi_te_vsync0.dispc_data16 */
+			OMAP5_IOPAD(0x0130, PIN_OUTPUT | MUX_MODE3) /* gpio6_182.dispc_data18 */
+			OMAP5_IOPAD(0x0132, PIN_OUTPUT | MUX_MODE3) /* gpio6_183.dispc_data19 */
+			OMAP5_IOPAD(0x0134, PIN_OUTPUT | MUX_MODE3) /* gpio6_184.dispc_data20 */
+			OMAP5_IOPAD(0x0136, PIN_OUTPUT | MUX_MODE3) /* gpio6_185.dispc_data21 */
+			OMAP5_IOPAD(0x0138, PIN_OUTPUT | MUX_MODE3) /* gpio6_186.dispc_data22 */
+			OMAP5_IOPAD(0x013a, PIN_OUTPUT | MUX_MODE3) /* gpio6_187.dispc_data23 */
+		>;
+	};
 };
 
 &mmc1 {
@@ -398,6 +515,13 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+
+	clock-frequency = <100000>;
+};
+
 &usbhshost {
 	port2-mode = "ehci-hsic";
 	port3-mode = "ehci-hsic";
@@ -410,3 +534,37 @@
 &cpu0 {
 	cpu0-supply = <&smps123_reg>;
 };
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	port {
+		dpi_dvi_out: endpoint@0 {
+			remote-endpoint = <&tfp410_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
+&dsi2 {
+ 	status = "ok";
+ 	vdd-supply = <&ldo4_reg>;
+};
+
+&hdmi {
+	status = "ok";
+	vdda-supply = <&ldo4_reg>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_hdmi_pins>;
+
+	port {
+		hdmi_out: endpoint {
+			remote-endpoint = <&hdmi_connector_in>;
+			lanes = <1 0 3 2 5 4 7 6>;
+		};
+	};
+};
-- 
1.7.5.4

