From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 09/10] dt-bindings: mfd: ti-lmu: update for backlight
Date: Fri, 30 Mar 2018 19:24:13 +0200
Message-ID: <20180330172414.26575-10-sebastian.reichel@collabora.co.uk>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Update binding to integrate the backlight feature directly into
the main node, as suggested by Rob Herring.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 Documentation/devicetree/bindings/mfd/ti-lmu.txt | 119 ++++++++++++-----------
 1 file changed, 60 insertions(+), 59 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index c885cf89b8ce..b3433e95dfa5 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -28,10 +28,9 @@ Required properties:
 
 Optional property:
   - enable-gpios: A GPIO specifier for hardware enable pin.
-
-Required node:
-  - backlight: All LMU devices have backlight child nodes.
-               For the properties, please refer to [1].
+  - pwm-names: Should be either "lmu-backlight" or unset
+  - pwm: This should be a PWM specifier following ../pwm/pwm.txt and must
+         only be specified, if the backlight should be used in PWM mode.
 
 Optional nodes:
   - fault-monitor: Hardware fault monitoring driver for LM3633 and LM3697.
@@ -42,8 +41,31 @@ Optional nodes:
   - leds: LED properties for LM3633. Please refer to [2].
   - regulators: Regulator properties for LM3631 and LM3632.
                 Please refer to [3].
+  - bank0, bank1, bank2: This contains the backlight configuration
+                         for each backlight control bank.
+
+Required properties in the bank subnodes:
+  - label: A string describing the backlight. Should contain "keyboard"
+           for a keyboard backlight and "lcd" for LCD panel backlights.
+  - ti,led-sources: A list of channels, that should be driven. Each channel
+                    should only be driven by one bank.
+
+Optional properties in the bank subnodes:
+  - default-brightness-level: Backlight initial brightness value.
+                              Type is <u32>. It is set as soon as backlight
+			      device is created.
+			      0 ~ 2047 = LM3631, LM3632, LM3633, LM3695 and
+					 LM3697
+			      0 ~ 255  = LM3532
+  - ti,ramp-up-ms, ti,ramp-down-ms: Light dimming effect properties.
+				    Type is <u32>. Unit is millisecond.
+					0 ~ 65 ms    = LM3532
+					0 ~ 4000 ms  = LM3631
+					0 ~ 16000 ms = LM3633 and LM3697
+  - pwm-period: PWM period. Only valid in PWM brightness mode.
+                Type is <u32>. If this property is missing, then control
+		mode is set to I2C by default.
 
-[1] ../leds/backlight/ti-lmu-backlight.txt
 [2] ../leds/leds-lm3633.txt
 [3] ../regulator/lm363x-regulator.txt
 
@@ -53,14 +75,11 @@ lm3532@38 {
 
 	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
 
-	backlight {
-		compatible = "ti,lm3532-backlight";
-
-		lcd {
-			led-sources = <0 1 2>;
-			ramp-up-msec = <30>;
-			ramp-down-msec = <0>;
-		};
+	bank0 {
+		label = "lcd";
+		led-sources = <0 1 2>;
+		ramp-up-msec = <30>;
+		ramp-down-msec = <0>;
 	};
 };
 
@@ -105,13 +124,10 @@ lm3631@29 {
 		};
 	};
 
-	backlight {
-		compatible = "ti,lm3631-backlight";
-
-		lcd_bl {
-			led-sources = <0 1>;
-			ramp-up-msec = <300>;
-		};
+	bank0 {
+		label = "lcd_bl";
+		led-sources = <0 1>;
+		ramp-up-msec = <300>;
 	};
 };
 
@@ -147,16 +163,13 @@ lm3632@11 {
 		};
 	};
 
-	backlight {
-		compatible = "ti,lm3632-backlight";
-
-		pwms = <&pwm0 0 10000 0>; /* pwm number, period, polarity */
-		pwm-names = "lmu-backlight";
+	pwms = <&pwm0 0 10000 0>; /* pwm number, period, polarity */
+	pwm-names = "lmu-backlight";
 
-		lcd {
-			led-sources = <0 1>;
-			pwm-period = <10000>;
-		};
+	bank0 {
+		label = "lcd";
+		led-sources = <0 1>;
+		pwm-period = <10000>;
 	};
 };
 
@@ -166,22 +179,18 @@ lm3633@36 {
 
 	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
 
-	backlight {
-		compatible = "ti,lm3633-backlight";
-
-		main {
-			label = "main_lcd";
-			led-sources = <1 2>;
-			ramp-up-msec = <500>;
-			ramp-down-msec = <500>;
-		};
+	bank0 {
+		label = "main_lcd";
+		led-sources = <1 2>;
+		ramp-up-msec = <500>;
+		ramp-down-msec = <500>;
+	};
 
-		front {
-			label = "front_lcd";
-			led-sources = <0>;
-			ramp-up-msec = <1000>;
-			ramp-down-msec = <0>;
-		};
+	bank1 {
+		label = "front_lcd";
+		led-sources = <0>;
+		ramp-up-msec = <1000>;
+		ramp-down-msec = <0>;
 	};
 
 	leds {
@@ -211,13 +220,9 @@ lm3695@63 {
 
 	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
 
-	backlight {
-		compatible = "ti,lm3695-backlight";
-
-		lcd {
-			label = "bl";
-			led-sources = <0 1>;
-		};
+	bank0 {
+		label = "lcd_bl";
+		led-sources = <0 1>;
 	};
 };
 
@@ -227,14 +232,10 @@ lm3697@36 {
 
 	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
 
-	backlight {
-		compatible = "ti,lm3697-backlight";
-
-		lcd {
-			led-sources = <0 1 2>;
-			ramp-up-msec = <200>;
-			ramp-down-msec = <200>;
-		};
+	bank0 {
+		led-sources = <0 1 2>;
+		ramp-up-msec = <200>;
+		ramp-down-msec = <200>;
 	};
 
 	fault-monitor {
-- 
2.16.2
