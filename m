From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 16/27] ARM: omap4-sdp.dts: add display information
Date: Mon, 16 Dec 2013 16:56:23 +0200
Message-ID: <1387205794-32246-17-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54784 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754488Ab3LPO6X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:58:23 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 116 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index c13ada99e0bc..bdfab844533b 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -309,6 +309,22 @@
 			0x112 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3.sdmmc5_dat3 */
 		>;
 	};
+
+	dss_hdmi_pins: pinmux_dss_hdmi_pins {
+		pinctrl-single,pins = <
+			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+			0x5c (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_scl.hdmi_scl */
+			0x5e (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_sda.hdmi_sda */
+		>;
+	};
+
+	tpd12s015_pins: pinmux_tpd12s015_pins {
+		pinctrl-single,pins = <
+			0x22 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_a17.gpio_41 */
+			0x48 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_nbe1.gpio_60 */
+			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* hdmi_hpd.gpio_63 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -551,3 +567,103 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&dsi1 {
+	vdds_dsi-supply = <&vcxio>;
+
+	dsi1_out_ep: endpoint {
+		remote-endpoint = <&lcd0_in>;
+		lanes = <0 1 2 3 4 5>;
+	};
+
+	lcd0: display {
+		compatible = "tpo,taal", "panel-dsi-cm";
+		label = "lcd0";
+
+		gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;	/* 102, reset */
+
+		lcd0_in: endpoint {
+			remote-endpoint = <&dsi1_out_ep>;
+		};
+	};
+};
+
+&dsi2 {
+	vdds_dsi-supply = <&vcxio>;
+
+	dsi2_out_ep: endpoint {
+		remote-endpoint = <&lcd1_in>;
+		lanes = <0 1 2 3 4 5>;
+	};
+
+	lcd1: display {
+		compatible = "tpo,taal", "panel-dsi-cm";
+		label = "lcd1";
+
+		gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>;	/* 104, reset */
+
+		lcd1_in: endpoint {
+			remote-endpoint = <&dsi2_out_ep>;
+		};
+	};
+};
+
+&hdmi {
+	vdda_hdmi_dac-supply = <&vdac>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_hdmi_pins>;
+
+	hdmi_out: endpoint {
+		remote-endpoint = <&tpd12s015_in>;
+	};
+};
+
+/ {
+	aliases {
+		display0 = &lcd0;
+		display1 = &lcd1;
+		display2 = &hdmi0;
+	};
+
+	tpd12s015: encoder@0 {
+		compatible = "ti,tpd12s015";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpd12s015_pins>;
+
+		gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
+			<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
+			<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tpd12s015_in: endpoint@0 {
+					remote-endpoint = <&hdmi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tpd12s015_out: endpoint@0 {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
+	hdmi0: connector@0 {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		hdmi_connector_in: endpoint {
+			remote-endpoint = <&tpd12s015_out>;
+		};
+	};
+};
-- 
1.8.3.2

