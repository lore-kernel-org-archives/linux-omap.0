From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 1/4] dt-bindings: tps65217: Update binding documentation.
Date: Wed,  7 Jun 2017 12:32:39 +0200
Message-ID: <20170607103242.16008-1-enric.balletbo@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch adds a new binding documentation for the TPS65217 MFD and
updates the documentation for all the sub-devices in accordance to get
each individual sub-driver functioning correctly.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
 .../bindings/input/tps65218-pwrbutton.txt          |   2 +-
 .../bindings/leds/backlight/tps65217-backlight.txt |  24 ++---
 Documentation/devicetree/bindings/mfd/tps65217.txt | 100 +++++++++++++++++++++
 .../devicetree/bindings/regulator/tps65217.txt     |   8 +-
 4 files changed, 119 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/tps65217.txt

diff --git a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
index 8682ab6..603a3f0 100644
--- a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
+++ b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
@@ -1,7 +1,7 @@
 Texas Instruments TPS65217 and TPS65218 power button
 
 This module is part of the TPS65217/TPS65218. For more details about the whole
-TPS65217 chip see Documentation/devicetree/bindings/regulator/tps65217.txt.
+TPS65217 chip see Documentation/devicetree/bindings/mfd/tps65217.txt.
 
 This driver provides a simple power button event via an Interrupt.
 
diff --git a/Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
index 5fb9279..a1bc465 100644
--- a/Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
@@ -1,11 +1,13 @@
-TPS65217 family of regulators
+Texas Instruments TPS65217 backlight regulator
+
+This module is part of the TPS65217. For more details about the whole
+TPS65217 chip see Documentation/devicetree/bindings/mfd/tps65217.txt.
 
 The TPS65217 chip contains a boost converter and current sinks which can be
 used to drive LEDs for use as backlights.
 
 Required properties:
-- compatible: "ti,tps65217"
-- reg: I2C slave address
+- compatible: "ti,tps65217-bl"
 - backlight: node for specifying WLED1 and WLED2 lines in TPS65217
 - isel: selection bit, valid values: 1 for ISEL1 (low-level) and 2 for ISEL2 (high-level)
 - fdim: PWM dimming frequency, valid values: 100, 200, 500, 1000
@@ -15,13 +17,13 @@ Each regulator is defined using the standard binding for regulators.
 
 Example:
 
-	tps: tps@24 {
-		reg = <0x24>;
-		compatible = "ti,tps65217";
-		backlight {
-			isel = <1>;  /* 1 - ISET1, 2 ISET2 */
-			fdim = <100>; /* TPS65217_BL_FDIM_100HZ */
-			default-brightness = <50>;
-		};
+&tps {
+	backlight {
+		compatible = "ti,tps65217-bl";
+		status = "okay";
+		isel = <1>;  /* 1 - ISET1, 2 ISET2 */
+		fdim = <100>; /* TPS65217_BL_FDIM_100HZ */
+		default-brightness = <50>;
 	};
+};
 
diff --git a/Documentation/devicetree/bindings/mfd/tps65217.txt b/Documentation/devicetree/bindings/mfd/tps65217.txt
new file mode 100644
index 0000000..40c84ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/tps65217.txt
@@ -0,0 +1,100 @@
+Texas Instruments TPS65217 Single-Chip PMIC for Battery-Powered Systems
+
+Required properties:
+- compatible: "ti,tps65217"
+- reg: I2C slave address.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells: The number of cells to describe an IRQ, this should be 1.
+- backlight: Child node that specify the backlight regulator sub-device. See:
+	Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
+- charger: Child node that specify the charger sub-device. See:
+	Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
+- pwrbutton: Child node that specify the power button sub-device. See:
+	Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
+- regulators: List of child nodes that specify the regulator initialization
+	data. See:
+	Documentation/devicetree/bindings/regulator/tps65217.txt.
+
+Optional properties:
+- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.
+
+Example:
+
+	tps: tps@24 {
+		compatible = "ti,tps65217";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		ti,pmic-shutdown-controller;
+
+		backlight {
+			compatible = "ti,tps65217-bl";
+			status = "disabled";
+		};
+
+		charger {
+			compatible = "ti,tps65217-charger";
+			status = "disabled";
+		};
+
+		pwrbutton {
+			compatible = "ti,tps65217-pwrbutton";
+			status = "disabled";
+		};
+
+		regulators {
+			compatible = "ti,tps65217-pmic";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dcdc1_reg: dcdc1 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			dcdc2_reg: dcdc2 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			dcdc3_reg: dcc3 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: ldo1 {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b/Documentation/devicetree/bindings/regulator/tps65217.txt
index 4f05d20..2d9b519 100644
--- a/Documentation/devicetree/bindings/regulator/tps65217.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65217.txt
@@ -1,8 +1,10 @@
-TPS65217 family of regulators
+Texas Instruments TPS65217 family of regulators
+
+This module is part of the TPS65217. For more details about the whole
+TPS65217 chip see Documentation/devicetree/bindings/mfd/tps65217.txt.
 
 Required properties:
-- compatible: "ti,tps65217"
-- reg: I2C slave address
+- compatible: "ti,tps65217-pmic"
 - regulators: list of regulators provided by this controller, must be named
   after their hardware counterparts: dcdc[1-3] and ldo[1-4]
 - regulators: This is the list of child nodes that specify the regulator
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
