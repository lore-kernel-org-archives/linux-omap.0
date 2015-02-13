From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/9] arm/dts: dra72-evm.dts: add HDMI
Date: Fri, 13 Feb 2015 17:11:24 +0200
Message-ID: <1423840286-18377-8-git-send-email-tomi.valkeinen@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51219 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbbBMPMt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 10:12:49 -0500
In-Reply-To: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

DRA72 EVM has a HDMI output. This patch adds the device tree nodes
required for HDMI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/dra72-evm.dts | 111 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 89085d066c65..85f9aa4fc94f 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "dra72x.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "TI DRA722";
@@ -18,12 +19,61 @@
 		reg = <0x80000000 0x40000000>; /* 1024 MB */
 	};
 
+	aliases {
+		display0 = &hdmi0;
+	};
+
 	evm_3v3: fixedregulator-evm_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
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
@@ -34,6 +84,13 @@
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
@@ -121,6 +178,19 @@
 			0x418   (MUX_MODE15)	/* wakeup0.off */
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
@@ -245,6 +315,27 @@
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
@@ -461,3 +552,23 @@
 	pinctrl-0 = <&dcan1_pins_default>;
 	pinctrl-1 = <&dcan1_pins_sleep>;
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
2.3.0

