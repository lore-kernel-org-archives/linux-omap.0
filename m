From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 8/9] arm/dts: am57xx-beagle-x15.dts: add HDMI
Date: Fri, 13 Feb 2015 17:11:25 +0200
Message-ID: <1423840286-18377-9-git-send-email-tomi.valkeinen@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43955 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048AbbBMPMu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 10:12:50 -0500
In-Reply-To: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

AM57xx Beagle X15 has a HDMI output. This patch adds the device tree
nodes required for HDMI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 80 +++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 49edbda68cd5..0b838d34b8a1 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -19,6 +19,7 @@
 	aliases {
 		rtc0 = &mcp_rtc;
 		rtc1 = &tps659038_rtc;
+		display0 = &hdmi0;
 	};
 
 	memory {
@@ -80,6 +81,51 @@
 			default-state = "off";
 		};
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
+		gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>,	/* gpio7_10, CT CP HPD */
+			<&gpio6 28 GPIO_ACTIVE_HIGH>,	/* gpio6_28, LS OE */
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
@@ -99,6 +145,13 @@
 		>;
 	};
 
+	hdmi_pins: pinmux_hdmi_pins {
+		pinctrl-single,pins = <
+			0x408 (PIN_INPUT | MUX_MODE1)	/* i2c2_sda.hdmi1_ddc_scl */
+			0x40c (PIN_INPUT | MUX_MODE1)	/* i2c2_scl.hdmi1_ddc_sda */
+		>;
+	};
+
 	i2c3_pins_default: i2c3_pins_default {
 		pinctrl-single,pins = <
 			0x2a4 (PIN_INPUT| MUX_MODE10)	/* mcasp1_aclkx.i2c3_sda */
@@ -164,6 +217,13 @@
 		>;
 	};
 
+	tpd12s015_pins: pinmux_tpd12s015_pins {
+		pinctrl-single,pins = <
+			0x3b0 (PIN_OUTPUT | MUX_MODE14)		/* gpio7_10 CT_CP_HPD */
+			0x3b8 (PIN_INPUT_PULLDOWN | MUX_MODE14)	/* gpio7_12 HPD */
+			0x370 (PIN_OUTPUT | MUX_MODE14)		/* gpio6_28 LS_OE */
+		>;
+	};
 };
 
 &i2c1 {
@@ -403,3 +463,23 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
+
+&dss {
+	status = "ok";
+
+	vdda_video-supply = <&ldoln_reg>;
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

