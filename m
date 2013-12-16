From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 20/27] ARM: omap3-igep0020.dts: add display information
Date: Mon, 16 Dec 2013 16:56:27 +0200
Message-ID: <1387205794-32246-21-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55755 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754526Ab3LPO6h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:58:37 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The IGEPv2 has a TFP410 DPI-to-DVI encoder attached
to OMAP's Display SubSystem (DSS). Add DeviceTree
nodes for these devices.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3-igep0020.dts | 64 +++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index b9a9e17acb58..6d34abf5b421 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -67,8 +67,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <
 		&hsusbb1_pins
-		&tfp410_pins
-		&dss_pins
 	>;
 
 	hsusbb1_pins: pinmux_hsusbb1_pins {
@@ -88,13 +86,13 @@
 		>;
 	};
 
-	tfp410_pins: tfp410_dvi_pins {
+	tfp410_pins: pinmux_tfp410_pins {
 		pinctrl-single,pins = <
 			0x196 (PIN_OUTPUT | MUX_MODE4)   /* hdq_sio.gpio_170 */
 		>;
 	};
 
-	dss_pins: pinmux_dss_dvi_pins {
+	dss_dpi_pins: pinmux_dss_dpi_pins {
 		pinctrl-single,pins = <
 			0x0a4 (PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
 			0x0a6 (PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
@@ -215,3 +213,61 @@
 &usbhsehci {
 	phys = <&hsusb1_phy>;
 };
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	vdds_dsi-supply = <&vpll2>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&tfp410_in>;
+		data-lines = <24>;
+	};
+};
+
+/ {
+	aliases {
+		display0 = &dvi0;
+	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+		gpios = <&gpio6 10 GPIO_ACTIVE_LOW>; /* 170, power-down */
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
+};
-- 
1.8.3.2

