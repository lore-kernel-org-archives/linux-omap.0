From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Mon, 24 Feb 2014 18:07:49 +0100
Message-ID: <1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:49284 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbaBXRIH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Feb 2014 12:08:07 -0500
In-Reply-To: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ash Charles <ash@gumstix.com>, Florian Vaussard <florian.vaussard@epfl.ch>

Add the necessary DTS nodes to enable the micro-HDMI output on Parlor
board.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap4-duovero-parlor.dts | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
index 96f51d8..d038242 100644
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
@@ -35,6 +39,15 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	hdmi0: connector@0 {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		hdmi_connector_in: endpoint {
+			remote-endpoint = <&hdmi_out>;
+		};
+	};
 };
 
 &omap4_pmx_core {
@@ -77,6 +90,15 @@
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
@@ -143,4 +165,18 @@
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
+	hdmi_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
 
-- 
1.8.1.2

