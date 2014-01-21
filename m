From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 25/41] ARM: omap4-panda.dts: add display information
Date: Tue, 21 Jan 2014 12:56:57 +0200
Message-ID: <1390301833-24944-26-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34947 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbaAULAw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 06:00:52 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT data for OMAP4 Pandaboard. The board has the following displays:

dvi: uses TFP410 encoder to convert DPI to DVI
hdmi: OMAP HDMI output with TPD12S015 ESD/level shifter

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 119 +++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 88c6a05cab41..20aa18ff4823 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -16,6 +16,11 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 
+	aliases {
+		display0 = &dvi0;
+		display1 = &hdmi0;
+	};
+
 	leds: leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -104,6 +109,87 @@
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
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
 };
 
 &omap4_pmx_core {
@@ -112,10 +198,6 @@
 			&twl6040_pins
 			&mcpdm_pins
 			&mcbsp1_pins
-			&dss_dpi_pins
-			&tfp410_pins
-			&dss_hdmi_pins
-			&tpd12s015_pins
 			&hsusbb1_pins
 	>;
 
@@ -409,3 +491,32 @@
 &usbhsehci {
 	phys = <&hsusb1_phy>;
 };
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&tfp410_in>;
+		data-lines = <24>;
+	};
+};
+
+&dsi2 {
+	status = "ok";
+	vdd-supply = <&vcxio>;
+};
+
+&hdmi {
+	status = "ok";
+	vdda-supply = <&vdac>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_hdmi_pins>;
+
+	hdmi_out: endpoint {
+		remote-endpoint = <&tpd12s015_in>;
+	};
+};
-- 
1.8.3.2

