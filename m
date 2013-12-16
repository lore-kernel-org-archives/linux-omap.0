From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 15/27] ARM: omap4-panda.dts: add display information
Date: Mon, 16 Dec 2013 16:56:22 +0200
Message-ID: <1387205794-32246-16-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33055 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754395Ab3LPO6V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:58:21 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 121 +++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 88c6a05cab41..dc71645dee9b 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -112,10 +112,6 @@
 			&twl6040_pins
 			&mcpdm_pins
 			&mcbsp1_pins
-			&dss_dpi_pins
-			&tfp410_pins
-			&dss_hdmi_pins
-			&tpd12s015_pins
 			&hsusbb1_pins
 	>;
 
@@ -409,3 +405,120 @@
 &usbhsehci {
 	phys = <&hsusb1_phy>;
 };
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&tfp410_in>;
+		data-lines = <24>;
+	};
+};
+
+&dsi1 {
+	vdds_dsi-supply = <&vcxio>;
+};
+
+&dsi2 {
+	vdds_dsi-supply = <&vcxio>;
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
+		display0 = &dvi0;
+		display1 = &hdmi0;
+	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+		gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;	/* 0, power-down */
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tfp410_pins>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint@0 {
+					remote-endpoint = <&dpi_out>;
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
+	dvi0: connector@0 {
+		compatible = "dvi-connector";
+		label = "dvi";
+
+		i2c-bus = <&i2c3>;
+
+		dvi_connector_in: endpoint {
+			remote-endpoint = <&tfp410_out>;
+		};
+	};
+
+	tpd12s015: encoder@1 {
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
+	hdmi0: connector@1 {
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

