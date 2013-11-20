From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 04/11] ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices
Date: Wed, 20 Nov 2013 02:06:08 +0100
Message-ID: <1384909575-19108-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:34716 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3KTBHd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 20:07:33 -0500
In-Reply-To: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Add pin muxing support for IGEP boards i2c controllers.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index e4c8769..165aaf7 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -113,10 +113,33 @@
 		>;
 	};
 
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			0x18a (PIN_INPUT | MUX_MODE0)   /* i2c1_scl.i2c1_scl */
+			0x18c (PIN_INPUT | MUX_MODE0)   /* i2c1_sda.i2c1_sda */
+		>;
+	};
+
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			0x18e (PIN_INPUT | MUX_MODE0)   /* i2c2_scl.i2c2_scl */
+			0x190 (PIN_INPUT | MUX_MODE0)   /* i2c2_sda.i2c2_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			0x192 (PIN_INPUT | MUX_MODE0)   /* i2c3_scl.i2c3_scl */
+			0x194 (PIN_INPUT | MUX_MODE0)   /* i2c3_sda.i2c3_sda */
+		>;
+	};
+
 	leds_pins: pinmux_leds_pins { };
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <2600000>;
 
 	twl: twl@48 {
@@ -136,9 +159,16 @@
 #include "twl4030_omap3.dtsi"
 
 &i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
 	clock-frequency = <400000>;
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+};
+
 &mcbsp2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcbsp2_pins>;
-- 
1.8.4.2

