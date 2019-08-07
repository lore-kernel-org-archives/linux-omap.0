From: David Lechner <david@lechnology.com>
Subject: [PATCH v2] ARM: dts: am335x-boneblue: Use of am335x-osd335x-common.dtsi
Date: Wed,  7 Aug 2019 15:09:34 -0500
Message-ID: <20190807200934.25173-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>
List-Id: linux-omap@vger.kernel.org

This makes use of the am335x-osd335x-common.dtsi file that contains the
common device tree components for Octavo Systems AM335x System-in-
Package that is used on the BeagleBone Blue.

This has two minor side-effects:
1. pinmux_i2c0_pins is renamed to pinmux-i2c0-pins
2. the 1000MHz cpufreq operating point is enabled

Cc: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes:
- fix typo s/1MHz/1000MHz/ in commit message

 arch/arm/boot/dts/am335x-boneblue.dts | 92 +--------------------------
 1 file changed, 2 insertions(+), 90 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index df3978ce061c..cde8dd4320b0 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -5,23 +5,13 @@
 /dts-v1/;
 
 #include "am33xx.dtsi"
+#include "am335x-osd335x-common.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "TI AM335x BeagleBone Blue";
 	compatible = "ti,am335x-bone-blue", "ti,am33xx";
 
-	cpus {
-		cpu@0 {
-			cpu0-supply = <&dcdc2_reg>;
-		};
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x20000000>; /* 512 MB */
-	};
-
 	chosen {
 		stdout-path = &uart0;
 	};
@@ -142,13 +132,6 @@
 		>;
 	};
 
-	i2c0_pins: pinmux_i2c0_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* (C17) I2C0_SDA.I2C0_SDA */
-			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* (C16) I2C0_SCL.I2C0_SCL */
-		>;
-	};
-
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
 			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* (D18) uart1_ctsn.I2C2_SDA */
@@ -352,16 +335,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
-
-	status = "okay";
-	clock-frequency = <400000>;
-
-	tps: tps@24 {
-		reg = <0x24>;
-	};
-
 	baseboard_eeprom: baseboard_eeprom@50 {
 		compatible = "atmel,24c256";
 		reg = <0x50>;
@@ -405,66 +378,13 @@
 /include/ "tps65217.dtsi"
 
 &tps {
-	interrupts = <7>; /* NMI */
-	interrupt-parent = <&intc>;
+	/delete-property/ ti,pmic-shutdown-controller;
 
 	charger {
 		interrupts = <0>, <1>;
 		interrupt-names = "USB", "AC";
 		status = "okay";
 	};
-
-	pwrbutton {
-		interrupts = <2>;
-		status = "okay";
-	};
-
-	regulators {
-		dcdc1_reg: regulator@0 {
-			regulator-name = "vdds_dpr";
-			regulator-always-on;
-		};
-
-		dcdc2_reg: regulator@1 {
-			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
-			regulator-name = "vdd_mpu";
-			regulator-min-microvolt = <925000>;
-			regulator-max-microvolt = <1351500>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
-
-		dcdc3_reg: regulator@2 {
-			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
-			regulator-name = "vdd_core";
-			regulator-min-microvolt = <925000>;
-			regulator-max-microvolt = <1150000>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
-
-		ldo1_reg: regulator@3 {
-			regulator-name = "vio,vrtc,vdds";
-			regulator-always-on;
-		};
-
-		ldo2_reg: regulator@4 {
-			regulator-name = "vdd_3v3aux";
-			regulator-always-on;
-		};
-
-		ldo3_reg: regulator@5 {
-			regulator-name = "vdd_1v8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-
-		ldo4_reg: regulator@6 {
-			regulator-name = "vdd_3v3a";
-			regulator-always-on;
-		};
-	};
 };
 
 &mmc1 {
@@ -526,14 +446,6 @@
 	};
 };
 
-&aes {
-	status = "okay";
-};
-
-&sham {
-	status = "okay";
-};
-
 &rtc {
 	system-power-controller;
 	clocks = <&clk_32768_ck>, <&clk_24mhz_clkctrl AM3_CLK_24MHZ_CLKDIV32K_CLKCTRL 0>;
-- 
2.17.1
