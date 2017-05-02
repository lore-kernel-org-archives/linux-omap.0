From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/2] ARM: dts: omap4-droid4: Add vibrator
Date: Tue,  2 May 2017 18:27:26 +0200
Message-ID: <20170502162726.11577-3-sebastian.reichel@collabora.co.uk>
References: <20170502162726.11577-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170502162726.11577-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Add vibrator to Droid4's device tree.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 89eb607f4a9e..67d286a53368 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -116,6 +116,32 @@
 
 		};
 	};
+
+	pwm8: dmtimer-pwm-8 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&vibrator_direction_pin>;
+
+		compatible = "ti,omap-dmtimer-pwm";
+		#pwm-cells = <3>;
+		ti,timers = <&timer8>;
+		ti,clock-source = <0x01>;
+	};
+
+	pwm9: dmtimer-pwm-9 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&vibrator_enable_pin>;
+
+		compatible = "ti,omap-dmtimer-pwm";
+		#pwm-cells = <3>;
+		ti,timers = <&timer9>;
+		ti,clock-source = <0x01>;
+	};
+
+	vibrator {
+		compatible = "motorola,mapphone-pwm-vibrator";
+		pwms = <&pwm9 0 1000000000 0>, <&pwm8 0 1000000000 0>;
+		pwm-names = "enable", "direction";
+	};
 };
 
 &dss {
@@ -453,6 +479,18 @@
 		OMAP4_IOPAD(0x1c8, PIN_INPUT_PULLUP | MUX_MODE7)
 		>;
 	};
+
+	vibrator_direction_pin: pinmux_vibrator_direction_pin {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x1ce, PIN_OUTPUT | MUX_MODE1)	/* dmtimer8_pwm_evt (gpio_27) */
+		>;
+	};
+
+	vibrator_enable_pin: pinmux_vibrator_enable_pin {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0X1d0, PIN_OUTPUT | MUX_MODE1)	/* dmtimer9_pwm_evt (gpio_28) */
+		>;
+	};
 };
 
 &omap4_pmx_wkup {
-- 
2.11.0
