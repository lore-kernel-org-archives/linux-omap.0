From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 21 May 2014 11:15:06 +0200
Message-ID: <1400663706-24104-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:33946 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbaEUJPY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 05:15:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Add the necessary DTS nodes to enable the micro-HDMI output on Parlor
board.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
v1->v2:
- Rebased on Tony's omap-for-v3.16/dt-v2
- Use OMAP4_IOPAD macro
- Use hpd pin as GPIO with hdmi-connector

 arch/arm/boot/dts/omap4-duovero-parlor.dts | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
index cd53a64..6dc84d9 100644
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -15,6 +15,10 @@
 	model = "OMAP4430 Gumstix Duovero on Parlor";
 	compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
 
+	aliases {
+		display0 = &hdmi0;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led0 {
@@ -35,6 +39,21 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	hdmi0: connector@0 {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		type = "d";
+
+		hpd-gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>;	/* gpio_63 */
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
 };
 
 &omap4_pmx_core {
@@ -77,6 +96,15 @@
 			OMAP4_IOPAD(0x070, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48: amdix enabled */
 		>;
 	};
+
+	dss_hdmi_pins: pinmux_dss_hdmi_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x098, PIN_INPUT | MUX_MODE3)		/* hdmi_hpd.gpio_63 */
+			OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+			OMAP4_IOPAD(0x09c, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_scl.hdmi_ddc_scl */
+			OMAP4_IOPAD(0x09e, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_sda.hdmi_ddc_sda */
+		>;
+	};
 };
 
 &i2c2 {
@@ -143,4 +171,20 @@
 	};
 };
 
+&dss {
+	status = "ok";
+};
+
+&hdmi {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_hdmi_pins>;
+
+	port {
+		hdmi_out: endpoint {
+			remote-endpoint = <&hdmi_connector_in>;
+		};
+	};
+};
 
-- 
1.8.3.2

