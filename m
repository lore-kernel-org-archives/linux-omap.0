From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv4 10/10] arm/dts: am57xx-beagle-x15.dts: add HDMI
Date: Mon, 1 Jun 2015 09:23:18 +0300
Message-ID: <1433139798-23450-11-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57685 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbbFAGYP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 02:24:15 -0400
In-Reply-To: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

AM57xx Beagle X15 has a HDMI output. This patch adds the device tree
nodes required for HDMI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 15f198e4864d..f1e430507e4f 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -18,6 +18,7 @@
 	aliases {
 		rtc0 = &mcp_rtc;
 		rtc1 = &tps659038_rtc;
+		display0 = &hdmi0;
 	};
 
 	memory {
@@ -102,6 +103,51 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&extcon_usb2_pins>;
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
@@ -121,6 +167,13 @@
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
@@ -277,6 +330,14 @@
 			0x3e8 (PIN_INPUT_PULLUP | MUX_MODE14) /* uart1_ctsn.gpio7_24 */
 		>;
 	};
+
+	tpd12s015_pins: pinmux_tpd12s015_pins {
+		pinctrl-single,pins = <
+			0x3b0 (PIN_OUTPUT | MUX_MODE14)		/* gpio7_10 CT_CP_HPD */
+			0x3b8 (PIN_INPUT_PULLDOWN | MUX_MODE14)	/* gpio7_12 HPD */
+			0x370 (PIN_OUTPUT | MUX_MODE14)		/* gpio6_28 LS_OE */
+		>;
+	};
 };
 
 &i2c1 {
@@ -607,3 +668,23 @@
 		};
        };
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
2.1.4

