From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/6] ARM: dts: omap5-uevm.dts: add display nodes
Date: Wed, 21 May 2014 15:50:25 +0300
Message-ID: <1400676625-30078-7-git-send-email-tomi.valkeinen@ti.com>
References: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50236 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbaEUMvE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 08:51:04 -0400
In-Reply-To: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

omap5-uevm has a single HDMI output. Add the necessary display
information, including pinmuxing.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 76877516f6df..9ffbe71b88c3 100644
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
+		gpios = <&gpio9 0 GPIO_ACTIVE_HIGH>,	/* TCA6424A P01, CT CP HPD */
+			<&gpio9 1 GPIO_ACTIVE_HIGH>,	/* TCA6424A P00, LS OE */
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

