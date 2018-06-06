From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/8] ARM: dts: am335x-sl50: update backlight nodes
Date: Wed,  6 Jun 2018 17:54:06 +0200
Message-ID: <20180606155413.23542-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch updates the backlight nodes to improve the support and describe
better how hardware is done. The changes done were:

 * Use PWM_POLARITY_INVERTED instead of the hardcoded number.
 * Add pinctrl configuration.
 * Add the enable gpio definition.
 * Add the power supply definition.
 * Add more brightness levels.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm/boot/dts/am335x-sl50.dts | 61 ++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index ddfa7192afd5..6d78bf828bbf 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -5,6 +5,7 @@
 /dts-v1/;
 
 #include "am33xx.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Toby Churchill SL50 Series";
@@ -57,16 +58,44 @@
 
 	backlight0: disp0 {
 		compatible = "pwm-backlight";
-		pwms = <&ehrpwm1 0 500000 0>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 99>;
-		default-brightness-level = <6>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight0_pins>;
+		pwms = <&ehrpwm1 0 500000 PWM_POLARITY_INVERTED>;
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <50>;
+		enable-gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
+		power-supply = <&vdd_sys_reg>;
 	};
 
 	backlight1: disp1 {
 		compatible = "pwm-backlight";
-		pwms = <&ehrpwm1 1 500000 0>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 99>;
-		default-brightness-level = <6>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight1_pins>;
+		pwms = <&ehrpwm1 1 500000 PWM_POLARITY_INVERTED>;
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <50>;
+		enable-gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+		power-supply = <&vdd_sys_reg>;
 	};
 
 	clocks {
@@ -105,6 +134,14 @@
 		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 	};
 
+	vdd_sys_reg: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_sys_reg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
 	vmmcsd_fixed: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
@@ -117,6 +154,18 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&lwb_pins>;
 
+	backlight0_pins: pinmux_backlight0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE7)	/* gpmc_wen.gpio2_4 */
+		>;
+	};
+
+	backlight1_pins: pinmux_backlight1_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE7)     /* gpmc_ad10.gpio0_26 */
+		>;
+	};
+
 	led_pins: pinmux_led_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
-- 
2.17.1
