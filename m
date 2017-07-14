From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 3/3] ARM: dts: omap4-droid4: Add vibrator
Date: Fri, 14 Jul 2017 12:01:51 +0200
Message-ID: <20170714100151.31234-4-sebastian.reichel@collabora.co.uk>
References: <20170714100151.31234-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170714100151.31234-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Add vibrator to Droid4's device tree.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index a182f9fb1c7a..25c0f81e9628 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -136,6 +136,34 @@
 
 		dais = <&mcbsp2_port>, <&mcbsp3_port>;
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
+		compatible = "pwm-vibrator";
+		pwms = <&pwm9 0 10000000 0>, <&pwm8 0 10000000 0>;
+		pwm-names = "enable", "direction";
+		direction-duty-cycle-ns = <10000000>;
+	};
+
 };
 
 &dss {
@@ -517,6 +545,18 @@
 		OMAP4_IOPAD(0x10c, PIN_INPUT | MUX_MODE1)	/* abe_mcbsp3_fsx */
 		>;
 	};
+
+	vibrator_direction_pin: pinmux_vibrator_direction_pin {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x1ce, PIN_OUTPUT | MUX_MODE1)	/* dmtimer8_pwm_evt (gpio_27) */
+		>;
+	};
+
+	vibrator_enable_pin: pinmux_vibrator_enable_pin {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0X1d0, PIN_OUTPUT | MUX_MODE1)	/* dmtimer9_pwm_evt (gpio_28) */
+		>;
+	};
 };
 
 &omap4_pmx_wkup {
-- 
2.13.2
