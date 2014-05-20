From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH] ARM: dts: duovero-parlor: Add HDMI output
Date: Tue, 20 May 2014 16:25:46 +0200
Message-ID: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:40786 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbaETO0E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 10:26:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Add the necessary DTS nodes to enable the micro-HDMI output on Parlor
board.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap4-duovero-parlor.dts | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
index 96f51d8..3b234b8 100644
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
@@ -35,6 +39,19 @@
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
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
 };
 
 &omap4_pmx_core {
@@ -77,6 +94,15 @@
 			0x30 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48: amdix enabled */
 		>;
 	};
+
+	dss_hdmi_pins: pinmux_dss_hdmi_pins {
+		pinctrl-single,pins = <
+			0x58 (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_hpd.hdmi_hpd */
+			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+			0x5c (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_scl.hdmi_ddc_scl */
+			0x5e (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_sda.hdmi_ddc_sda */
+		>;
+	};
 };
 
 &i2c2 {
@@ -143,4 +169,20 @@
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

