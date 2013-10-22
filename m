From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 01/14] DTS: ARM: OMAP3-N900: Add pinctrl for i2c devices
Date: Wed, 23 Oct 2013 00:49:30 +0200
Message-ID: <1382482183-14426-2-git-send-email-sre@debian.org>
References: <1382482183-14426-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382482183-14426-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Add pin muxing support for the Nokia N900 i2c controllers.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index e13b697..ad4edd9 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -28,7 +28,35 @@
 
 };
 
+&omap3_pmx_core {
+	pinctrl-names = "default";
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			0x18a (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+		>;
+	};
+
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			0x18e (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_scl */
+			0x190 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			0x192 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
+			0x194 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
+		>;
+	};
+};
+
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
 	clock-frequency = <2200000>;
 
 	twl: twl@48 {
@@ -39,6 +67,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
 
 &twl_gpio {
 	ti,pullups	= <0x0>;
@@ -46,10 +75,16 @@
 };
 
 &i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+
 	clock-frequency = <400000>;
 };
 
 &i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+
 	clock-frequency = <100000>;
 };
 
-- 
1.8.4.rc3
