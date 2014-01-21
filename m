From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 30/41] ARM: omap3-n900.dts: add display information
Date: Tue, 21 Jan 2014 12:57:02 +0200
Message-ID: <1390301833-24944-31-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38860 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558AbaAULBF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 06:01:05 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT data for OMAP3 N900 board. The board has the following displays:

lcd: LCD panel connected to OMAP's SDI output
tv: analog svideo

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 70 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 6fc85f963530..c1bb04d55d4b 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -74,6 +74,14 @@
 		};
 	};
 
+	tv: connector {
+		compatible = "composite-connector";
+		label = "tv";
+
+		tv_connector_in: endpoint {
+			remote-endpoint = <&venc_out>;
+		};
+	};
 };
 
 &omap3_pmx_core {
@@ -140,11 +148,23 @@
 		>;
 	};
 
-	display_pins: pinmux_display_pins {
+	acx565akm_pins: pinmux_acx565akm_pins {
 		pinctrl-single,pins = <
 			0x0d4 (PIN_OUTPUT | MUX_MODE4)		/* RX51_LCD_RESET_GPIO */
 		>;
 	};
+
+	dss_sdi_pins: pinmux_dss_sdi_pins {
+		pinctrl-single,pins = <
+			0x0c0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data10.sdi_dat1n */
+			0x0c2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data11.sdi_dat1p */
+			0x0c4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data12.sdi_dat2n */
+			0x0c6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data13.sdi_dat2p */
+
+			0x0d8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data22.sdi_clkp */
+			0x0da (PIN_OUTPUT | MUX_MODE1)   /* dss_data23.sdi_clkn */
+		>;
+	};
 };
 
 &i2c1 {
@@ -471,13 +491,21 @@
 		spi-max-frequency = <6000000>;
 		reg = <0>;
 	};
-	mipid@2 {
-		compatible = "acx565akm";
+
+	acx565akm@2 {
+		compatible = "sony,acx565akm";
 		spi-max-frequency = <6000000>;
 		reg = <2>;
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&display_pins>;
+		pinctrl-0 = <&acx565akm_pins>;
+
+		label = "lcd";
+		gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
+
+		lcd_in: endpoint {
+			remote-endpoint = <&sdi_out>;
+		};
 	};
 };
 
@@ -503,3 +531,37 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_sdi_pins>;
+
+	vdds_sdi-supply = <&vaux1>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			sdi_out: endpoint {
+				remote-endpoint = <&lcd_in>;
+				datapairs = <2>;
+			};
+		};
+	};
+};
+
+&venc {
+	status = "ok";
+
+	vdda-supply = <&vdac>;
+
+	venc_out: endpoint {
+		remote-endpoint = <&tv_connector_in>;
+		ti,channels = <1>;
+	};
+};
-- 
1.8.3.2

