From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/23] ARM: dts: omap5-uevm.dts: add display nodes
Date: Thu, 24 Apr 2014 13:17:08 +0300
Message-ID: <1398334639-14172-13-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58180 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbaDXKUU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:20:20 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

omap5-uevm has a single HDMI output. Add the necessary display
information, including pinmuxing.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 9e7581eaeb23..f625a8708567 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -183,6 +183,19 @@
 		>;
 	};
 
+	dss_hdmi_pins: pinmux_dss_hdmi_pins {
+		pinctrl-single,pins = <
+			0x0fc (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+			0x100 (PIN_INPUT | MUX_MODE0)	/* hdmi_ddc_scl.hdmi_ddc_scl */
+			0x102 (PIN_INPUT | MUX_MODE0)	/* hdmi_ddc_sda.hdmi_ddc_sda */
+		>;
+	};
+
+	tpd12s015_pins: pinmux_tpd12s015_pins {
+		pinctrl-single,pins = <
+			0x0fe (PIN_INPUT_PULLDOWN | MUX_MODE6)	/* hdmi_hpd.gpio7_193 */
+		>;
+	};
 };
 
 &omap5_pmx_wkup {
@@ -498,3 +511,72 @@
 &cpu0 {
 	cpu0-supply = <&smps123_reg>;
 };
+
+/ {
+	aliases {
+		display0 = &hdmi0;
+	};
+
+	tpd12s015: encoder@0 {
+		compatible = "ti,tpd12s015";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpd12s015_pins>;
+
+		gpios = <&tca6424a 0 GPIO_ACTIVE_HIGH>,	/* TCA6424A P01, CT CP HPD */
+			<&tca6424a 1 GPIO_ACTIVE_HIGH>,	/* TCA6424A P00, LS OE */
+			<&gpio7 1 GPIO_ACTIVE_HIGH>;	/* GPIO 193, HPD */
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
+		type = "b";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&tpd12s015_out>;
+			};
+		};
+	};
+};
+
+&dss {
+	status = "ok";
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
+			remote-endpoint = <&tpd12s015_in>;
+		};
+	};
+};
-- 
1.9.1

