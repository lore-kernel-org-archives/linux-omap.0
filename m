From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 1/3] dt-bindings: input: add pwm-vibrator
Date: Fri, 14 Jul 2017 12:01:49 +0200
Message-ID: <20170714100151.31234-2-sebastian.reichel@collabora.co.uk>
References: <20170714100151.31234-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170714100151.31234-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Add DT binding document for PWM controlled vibrator devices.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 .../devicetree/bindings/input/pwm-vibrator.txt     | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.txt

diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
new file mode 100644
index 000000000000..09145d18491d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
@@ -0,0 +1,66 @@
+* PWM vibrator device tree bindings
+
+Registers a PWM device as vibrator. It is expected, that the vibrator's
+strength increases based on the duty cycle of the enable PWM channel
+(100% duty cycle meaning strongest vibration, 0% meaning no vibration).
+
+The binding supports an optional direction PWM channel, that can be
+driven at fixed duty cycle. If available this is can be used to increase
+the vibration effect of some devices.
+
+Required properties:
+- compatible: should contain "pwm-vibrator"
+- pwm-names: Should contain "enable" and optionally "direction"
+- pwms: Should contain a PWM handle for each entry in pwm-names
+
+Optional properties:
+- vcc-supply: Phandle for the regulator supplying power
+- direction-duty-cycle-ns: Duty cycle of the direction PWM channel in
+                           nanoseconds, defaults to 50% of the channel's
+			   period.
+
+Example from Motorola Droid 4:
+
+&omap4_pmx_core {
+	vibrator_direction_pin: pinmux_vibrator_direction_pin {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x1ce, PIN_OUTPUT | MUX_MODE1) /* dmtimer8_pwm_evt (gpio_27) */
+		>;
+	};
+
+	vibrator_enable_pin: pinmux_vibrator_enable_pin {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0X1d0, PIN_OUTPUT | MUX_MODE1) /* dmtimer9_pwm_evt (gpio_28) */
+		>;
+	};
+};
+
+/ {
+	pwm8: dmtimer-pwm {
+		pinctrl-names = "default";
+		pinctrl-0 = <&vibrator_direction_pin>;
+
+		compatible = "ti,omap-dmtimer-pwm";
+		#pwm-cells = <3>;
+		ti,timers = <&timer8>;
+		ti,clock-source = <0x01>;
+	};
+
+	pwm9: dmtimer-pwm {
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
+		pwms = <&pwm8 0 1000000000 0>,
+		       <&pwm9 0 1000000000 0>;
+		pwm-names = "enable", "direction";
+		direction-duty-cycle-ns = <1000000000>;
+	};
+};
-- 
2.13.2
