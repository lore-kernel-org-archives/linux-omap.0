From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 2/2] ARM: dts: keystone-k2g-evm: add HDMI video support
Date: Wed, 29 Jan 2020 19:03:03 +0200
Message-ID: <d8be8300e4a889e22c66900f0320175630cc233c.1580317147.git.jsarha@ti.com>
References: <cover.1580317147.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35398 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgA2RDg (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jan 2020 12:03:36 -0500
In-Reply-To: <cover.1580317147.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: tomi.valkeinen@ti.com, peter.ujfalusi@ti.com, bparrot@ti.com, praneeth@ti.com

Add DT nodes for HDMI video support for K2G EVM. The HDMI uses SiI9022
DPI as HDMI encoder. The DSS DPI is connected to SiI9022 HDMI
encoder's video input and encoder's output goes to HDMI connector.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 101 +++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index b7f10bf94576..db640bab8c1d 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -45,6 +45,19 @@
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
 	};
+
+	hdmi: connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
 };
 
 &k2g_pinctrl {
@@ -89,6 +102,13 @@
 		>;
 	};
 
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x1384) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* i2c1_scl.i2c1_scl */
+			K2G_CORE_IOPAD(0x1388) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* i2c1_sda.i2c1_sda */
+		>;
+	};
+
 	ecap0_pins: ecap0_pins {
 		pinctrl-single,pins = <
 			K2G_CORE_IOPAD(0x1374) (BUFFER_CLASS_B | MUX_MODE4)	/* pr1_mdio_data.ecap0_in_apwm0_out */
@@ -160,6 +180,40 @@
 			K2G_CORE_IOPAD(0x1188) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_DATA.MDIO_DATA */
 		>;
 	};
+
+	vout_pins: pinmux_vout_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x1078) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata23.dssdata23 */
+			K2G_CORE_IOPAD(0x107c) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata22.dssdata22 */
+			K2G_CORE_IOPAD(0x1080) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata21.dssdata21 */
+			K2G_CORE_IOPAD(0x1084) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata20.dssdata20 */
+			K2G_CORE_IOPAD(0x1088) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata19.dssdata19 */
+			K2G_CORE_IOPAD(0x108c) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata18.dssdata18 */
+			K2G_CORE_IOPAD(0x1090) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata17.dssdata17 */
+			K2G_CORE_IOPAD(0x1094) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata16.dssdata16 */
+			K2G_CORE_IOPAD(0x1098) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata15.dssdata15 */
+			K2G_CORE_IOPAD(0x109c) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata14.dssdata14 */
+			K2G_CORE_IOPAD(0x10a0) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata13.dssdata13 */
+			K2G_CORE_IOPAD(0x10a4) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata12.dssdata12 */
+			K2G_CORE_IOPAD(0x10a8) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata11.dssdata11 */
+			K2G_CORE_IOPAD(0x10ac) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata10.dssdata10 */
+			K2G_CORE_IOPAD(0x10b0) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata9.dssdata9 */
+			K2G_CORE_IOPAD(0x10b4) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata8.dssdata8 */
+			K2G_CORE_IOPAD(0x10b8) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata7.dssdata7 */
+			K2G_CORE_IOPAD(0x10bc) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata6.dssdata6 */
+			K2G_CORE_IOPAD(0x10c0) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata5.dssdata5 */
+			K2G_CORE_IOPAD(0x10c4) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata4.dssdata4 */
+			K2G_CORE_IOPAD(0x10c8) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata3.dssdata3 */
+			K2G_CORE_IOPAD(0x10cc) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata2.dssdata2 */
+			K2G_CORE_IOPAD(0x10d0) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata1.dssdata1 */
+			K2G_CORE_IOPAD(0x10d4) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssdata0.dssdata0 */
+			K2G_CORE_IOPAD(0x10d8) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssvsync.dssvsync */
+			K2G_CORE_IOPAD(0x10dc) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dsshsync.dsshsync */
+			K2G_CORE_IOPAD(0x10e0) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dsspclk.dsspclk */
+			K2G_CORE_IOPAD(0x10e4) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssde.dssde */
+			K2G_CORE_IOPAD(0x10e8) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssfid.dssfid */
+		>;
+	};
 };
 
 &uart0 {
@@ -357,3 +411,50 @@
 	pinctrl-0 = <&emac_pins>;
 	status = "okay";
 };
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	sii9022: sii9022@3b {
+		#sound-dai-cells = <0>;
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&vout_pins>;
+	status = "ok";
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+			data-lines = <24>;
+		};
+	};
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
