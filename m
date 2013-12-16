From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 19/27] ARM: omap3-beagle-xm.dts: add display information
Date: Mon, 16 Dec 2013 16:56:26 +0200
Message-ID: <1387205794-32246-20-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55744 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754494Ab3LPO61 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:58:27 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 118 ++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index df33a50bc070..60430e8229a9 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -94,6 +94,17 @@
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
@@ -125,6 +136,35 @@
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
@@ -222,3 +262,81 @@
 	regulator-max-microvolt = <1800000>;
 	regulator-always-on;
 };
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&dss_dpi_pins1
+		&dss_dpi_pins2
+	>;
+
+	vdds_dsi-supply = <&vpll2>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&tfp410_in>;
+		data-lines = <24>;
+	};
+};
+
+&venc {
+	vdda_dac-supply = <&vdac>;
+
+	venc_out: endpoint {
+		remote-endpoint = <&tv_connector_in>;
+	};
+};
+
+/ {
+	aliases {
+		display0 = &dvi0;
+		display1 = &tv0;
+	};
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
+};
-- 
1.8.3.2

