From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 28/41] ARM: omap3-beagle-xm.dts: add display information
Date: Tue, 21 Jan 2014 12:57:00 +0200
Message-ID: <1390301833-24944-29-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39152 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547AbaAULAy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 06:00:54 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT data for OMAP3 Beagle-xM board. The board has the following displays:

dvi: uses TFP410 encoder to convert DPI to DVI
tv: analog svideo

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 119 ++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index df33a50bc070..f6cec7e6ac11 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -24,6 +24,11 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 
+	aliases {
+		display0 = &dvi0;
+		display1 = &tv0;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -86,6 +91,54 @@
 		reset-gpios = <&gpio5 19 GPIO_ACTIVE_LOW>; /* gpio_147 */
 		vcc-supply = <&hsusb2_power>;
 	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+		gpios = <&twl_gpio 2 GPIO_ACTIVE_LOW>;
+
+		/* XXX pinctrl from twl */
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
+	tv0: connector@1 {
+		compatible = "svideo-connector";
+		label = "tv";
+
+		tv_connector_in: endpoint {
+			remote-endpoint = <&venc_out>;
+		};
+	};
 };
 
 &omap3_pmx_wkup {
@@ -94,6 +147,17 @@
 			0x0e (PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE4) /* sys_boot2.gpio_4 */
 		>;
 	};
+
+	dss_dpi_pins2: pinmux_dss_dpi_pins {
+		pinctrl-single,pins = <
+			0x0a (PIN_OUTPUT | MUX_MODE3)   /* sys_boot0.dss_data18 */
+			0x0c (PIN_OUTPUT | MUX_MODE3)   /* sys_boot1.dss_data19 */
+			0x10 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot3.dss_data20 */
+			0x12 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot4.dss_data21 */
+			0x14 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot5.dss_data22 */
+			0x16 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot6.dss_data23 */
+		>;
+	};
 };
 
 &omap3_pmx_core {
@@ -125,6 +189,35 @@
 			0x1ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
 		>;
 	};
+
+	dss_dpi_pins1: pinmux_dss_dpi_pins {
+		pinctrl-single,pins = <
+			0x0a4 (PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
+			0x0a6 (PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
+			0x0a8 (PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
+			0x0aa (PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
+
+			0x0b8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
+			0x0ba (PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
+			0x0bc (PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
+			0x0be (PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
+			0x0c0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
+			0x0c2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
+			0x0c4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
+			0x0c6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
+			0x0c8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
+			0x0ca (PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
+			0x0cc (PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
+			0x0ce (PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
+
+			0x0d0 (PIN_OUTPUT | MUX_MODE3)   /* dss_data18.dss_data0 */
+			0x0d2 (PIN_OUTPUT | MUX_MODE3)   /* dss_data19.dss_data1 */
+			0x0d4 (PIN_OUTPUT | MUX_MODE3)   /* dss_data20.dss_data2 */
+			0x0d6 (PIN_OUTPUT | MUX_MODE3)   /* dss_data21.dss_data3 */
+			0x0d8 (PIN_OUTPUT | MUX_MODE3)   /* dss_data22.dss_data4 */
+			0x0da (PIN_OUTPUT | MUX_MODE3)   /* dss_data23.dss_data5 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -222,3 +315,29 @@
 	regulator-max-microvolt = <1800000>;
 	regulator-always-on;
 };
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&dss_dpi_pins1
+		&dss_dpi_pins2
+	>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&tfp410_in>;
+		data-lines = <24>;
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
+		ti,channels = <2>;
+	};
+};
-- 
1.8.3.2

