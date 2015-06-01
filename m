From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv4 09/10] arm/dts: dra72-evm.dts: add HDMI
Date: Mon, 1 Jun 2015 09:23:17 +0300
Message-ID: <1433139798-23450-10-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57686 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758808AbbFAGYP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 02:24:15 -0400
In-Reply-To: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

DRA72 EVM has a HDMI output. This patch adds the device tree nodes
required for HDMI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/dra72-evm.dts | 110 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index ce0390f081d9..4e1b60581782 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -19,6 +19,10 @@
 		reg = <0x80000000 0x40000000>; /* 1024 MB */
 	};
 
+	aliases {
+		display0 = &hdmi0;
+	};
+
 	evm_3v3: fixedregulator-evm_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3";
@@ -35,6 +39,51 @@
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&pcf_gpio_21 2 GPIO_ACTIVE_HIGH>;
 	};
+
+	hdmi0: connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&tpd12s015_out>;
+			};
+		};
+	};
+
+	tpd12s015: encoder {
+		compatible = "ti,tpd12s015";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpd12s015_pins>;
+
+		gpios = <&pcf_hdmi 4 GPIO_ACTIVE_HIGH>,	/* P4, CT CP HPD */
+			<&pcf_hdmi 5 GPIO_ACTIVE_HIGH>,	/* P5, LS OE */
+			<&gpio7 12 GPIO_ACTIVE_HIGH>;	/* gpio7_12/sp1_cs2, HPD */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tpd12s015_in: endpoint {
+					remote-endpoint = <&hdmi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tpd12s015_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &dra7_pmx_core {
@@ -45,6 +94,13 @@
 		>;
 	};
 
+	i2c5_pins: pinmux_i2c5_pins {
+		pinctrl-single,pins = <
+			0x2b4 (PIN_INPUT | MUX_MODE10) /* mcasp1_axr0.i2c5_sda */
+			0x2b8 (PIN_INPUT | MUX_MODE10) /* mcasp1_axr1.i2c5_scl */
+		>;
+	};
+
 	nand_default: nand_default {
 		pinctrl-single,pins = <
 			0x0	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad0 */
@@ -142,6 +198,19 @@
 			0xb8 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_cs2.qspi1_cs0 */
 		>;
 	};
+
+	hdmi_pins: pinmux_hdmi_pins {
+		pinctrl-single,pins = <
+			0x408 (PIN_INPUT | MUX_MODE1) /* i2c2_sda.hdmi1_ddc_scl */
+			0x40c (PIN_INPUT | MUX_MODE1) /* i2c2_scl.hdmi1_ddc_sda */
+		>;
+	};
+
+	tpd12s015_pins: pinmux_tpd12s015_pins {
+		pinctrl-single,pins = <
+			0x3b8 (PIN_INPUT_PULLDOWN | MUX_MODE14) /* gpio7_12 HPD */
+		>;
+	};
 };
 
 &i2c1 {
@@ -277,6 +346,27 @@
 	};
 };
 
+&i2c5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	clock-frequency = <400000>;
+
+	pcf_hdmi: pcf8575@26 {
+		compatible = "nxp,pcf8575";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		/*
+		 * initial state is used here to keep the mdio interface
+		 * selected on RU89 through SEL_VIN4_MUX_S0, VIN2_S1 and
+		 * VIN2_S0 driven high otherwise Ethernet stops working
+		 * VIN6_SEL_S0 is low, thus selecting McASP3 over VIN6
+		 */
+		lines-initial-states = <0x0f2b>;
+	};
+};
+
 &uart1 {
 	status = "okay";
 };
@@ -566,3 +656,23 @@
 		};
 	};
 };
+
+&dss {
+	status = "ok";
+
+	vdda_video-supply = <&ldo5_reg>;
+};
+
+&hdmi {
+	status = "ok";
+	vdda-supply = <&ldo3_reg>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_pins>;
+
+	port {
+		hdmi_out: endpoint {
+			remote-endpoint = <&tpd12s015_in>;
+		};
+	};
+};
-- 
2.1.4

