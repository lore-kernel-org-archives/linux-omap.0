From: Heiko Schocher <hs@denx.de>
Subject: [PATCH] regulator: tps65217: remove tps65217.dtsi file
Date: Mon, 26 Oct 2015 10:13:55 +0100
Message-ID: <1445850836-17863-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Georg.Soffel@bosch-si.com, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, Mark Jackson <mpfj@newflow.co.uk>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

remove tps65217.dtsi and adapt all boards, which
used it.

Signed-off-by: Heiko Schocher <hs@denx.de>
---
Suggested by Mark Brown, see:
https://lkml.org/lkml/2015/10/21/581

 .../devicetree/bindings/regulator/tps65217.txt     | 78 --------------=
--------
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 14 +++-
 arch/arm/boot/dts/am335x-chilisom.dtsi             | 14 +++-
 arch/arm/boot/dts/am335x-nano.dts                  | 14 +++-
 arch/arm/boot/dts/am335x-pepper.dts                | 14 +++-
 arch/arm/boot/dts/am335x-sl50.dts                  | 13 +++-
 arch/arm/boot/dts/tps65217.dtsi                    | 56 --------------=
--
 7 files changed, 58 insertions(+), 145 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps6521=
7.txt
 delete mode 100644 arch/arm/boot/dts/tps65217.dtsi

diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b=
/Documentation/devicetree/bindings/regulator/tps65217.txt
deleted file mode 100644
index 4f05d20..0000000
--- a/Documentation/devicetree/bindings/regulator/tps65217.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-TPS65217 family of regulators
-
-Required properties:
-- compatible: "ti,tps65217"
-- reg: I2C slave address
-- regulators: list of regulators provided by this controller, must be =
named
-  after their hardware counterparts: dcdc[1-3] and ldo[1-4]
-- regulators: This is the list of child nodes that specify the regulat=
or
-  initialization data for defined regulators. Not all regulators for t=
he given
-  device need to be present. The definition for each of these nodes is=
 defined
-  using the standard binding for regulators found at
-  Documentation/devicetree/bindings/regulator/regulator.txt.
-
-Optional properties:
-- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN =
toggle.
-
-  The valid names for regulators are:
-  tps65217: dcdc1, dcdc2, dcdc3, ldo1, ldo2, ldo3 and ldo4
-
-Each regulator is defined using the standard binding for regulators.
-
-Example:
-
-	tps: tps@24 {
-		compatible =3D "ti,tps65217";
-		ti,pmic-shutdown-controller;
-
-		regulators {
-			dcdc1_reg: dcdc1 {
-				regulator-min-microvolt =3D <900000>;
-				regulator-max-microvolt =3D <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			dcdc2_reg: dcdc2 {
-				regulator-min-microvolt =3D <900000>;
-				regulator-max-microvolt =3D <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			dcdc3_reg: dcc3 {
-				regulator-min-microvolt =3D <900000>;
-				regulator-max-microvolt =3D <1500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1_reg: ldo1 {
-				regulator-min-microvolt =3D <1000000>;
-				regulator-max-microvolt =3D <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2_reg: ldo2 {
-				regulator-min-microvolt =3D <900000>;
-				regulator-max-microvolt =3D <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3_reg: ldo3 {
-				regulator-min-microvolt =3D <1800000>;
-				regulator-max-microvolt =3D <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: ldo4 {
-				regulator-min-microvolt =3D <1800000>;
-				regulator-max-microvolt =3D <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/=
dts/am335x-bone-common.dtsi
index fec7834..0c4bde0 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -285,10 +285,8 @@
 	};
 };
=20
-
-/include/ "tps65217.dtsi"
-
 &tps {
+	compatible =3D "ti,tps65217";
 	/*
 	 * Configure pmic to enter OFF-state instead of SLEEP-state ("RTC-onl=
y
 	 * mode") at poweroff.  Most BeagleBone versions do not support RTC-o=
nly
@@ -309,12 +307,17 @@
 	ti,pmic-shutdown-controller;
=20
 	regulators {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
 		dcdc1_reg: regulator@0 {
+			reg =3D <0>;
 			regulator-name =3D "vdds_dpr";
 			regulator-always-on;
 		};
=20
 		dcdc2_reg: regulator@1 {
+			reg =3D <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name =3D "vdd_mpu";
 			regulator-min-microvolt =3D <925000>;
@@ -324,6 +327,7 @@
 		};
=20
 		dcdc3_reg: regulator@2 {
+			reg =3D <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name =3D "vdd_core";
 			regulator-min-microvolt =3D <925000>;
@@ -333,21 +337,25 @@
 		};
=20
 		ldo1_reg: regulator@3 {
+			reg =3D <3>;
 			regulator-name =3D "vio,vrtc,vdds";
 			regulator-always-on;
 		};
=20
 		ldo2_reg: regulator@4 {
+			reg =3D <4>;
 			regulator-name =3D "vdd_3v3aux";
 			regulator-always-on;
 		};
=20
 		ldo3_reg: regulator@5 {
+			reg =3D <5>;
 			regulator-name =3D "vdd_1v8";
 			regulator-always-on;
 		};
=20
 		ldo4_reg: regulator@6 {
+			reg =3D <6>;
 			regulator-name =3D "vdd_3v3a";
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts=
/am335x-chilisom.dtsi
index 7e9a34d..9f5ee9a 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -128,16 +128,21 @@
=20
 };
=20
-/include/ "tps65217.dtsi"
-
 &tps {
+	compatible =3D "ti,tps65217";
+
 	regulators {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
 		dcdc1_reg: regulator@0 {
+			reg =3D <0>;
 			regulator-name =3D "vdds_dpr";
 			regulator-always-on;
 		};
=20
 		dcdc2_reg: regulator@1 {
+			reg =3D <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name =3D "vdd_mpu";
 			regulator-min-microvolt =3D <925000>;
@@ -147,6 +152,7 @@
 		};
=20
 		dcdc3_reg: regulator@2 {
+			reg =3D <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name =3D "vdd_core";
 			regulator-min-microvolt =3D <925000>;
@@ -156,24 +162,28 @@
 		};
=20
 		ldo1_reg: regulator@3 {
+			reg =3D <3>;
 			regulator-name =3D "vio,vrtc,vdds";
 			regulator-boot-on;
 			regulator-always-on;
 		};
=20
 		ldo2_reg: regulator@4 {
+			reg =3D <4>;
 			regulator-name =3D "vdd_3v3aux";
 			regulator-boot-on;
 			regulator-always-on;
 		};
=20
 		ldo3_reg: regulator@5 {
+			reg =3D <5>;
 			regulator-name =3D "vdd_1v8";
 			regulator-boot-on;
 			regulator-always-on;
 		};
=20
 		ldo4_reg: regulator@6 {
+			reg =3D <6>;
 			regulator-name =3D "vdd_3v3d";
 			regulator-boot-on;
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am33=
5x-nano.dts
index 5ed4ca6..041adb8 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -375,11 +375,15 @@
 	wp-gpios =3D <&gpio3 18 0>;
 };
=20
-#include "tps65217.dtsi"
-
 &tps {
+	compatible =3D "ti,tps65217";
+
 	regulators {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
 		dcdc1_reg: regulator@0 {
+			reg =3D <0>;
 			/* +1.5V voltage with =C2=B14% tolerance */
 			regulator-min-microvolt =3D <1450000>;
 			regulator-max-microvolt =3D <1550000>;
@@ -388,6 +392,7 @@
 		};
=20
 		dcdc2_reg: regulator@1 {
+			reg =3D <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.1V with =C2=B14% tolerance */
 			regulator-name =3D "vdd_mpu";
 			regulator-min-microvolt =3D <915000>;
@@ -397,6 +402,7 @@
 		};
=20
 		dcdc3_reg: regulator@2 {
+			reg =3D <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with =C2=B14% tolerance */
 			regulator-name =3D "vdd_core";
 			regulator-min-microvolt =3D <915000>;
@@ -406,6 +412,7 @@
 		};
=20
 		ldo1_reg: regulator@3 {
+			reg =3D <3>;
 			/* +1.8V voltage with =C2=B14% tolerance */
 			regulator-min-microvolt =3D <1750000>;
 			regulator-max-microvolt =3D <1870000>;
@@ -414,6 +421,7 @@
 		};
=20
 		ldo2_reg: regulator@4 {
+			reg =3D <4>;
 			/* +3.3V voltage with =C2=B14% tolerance */
 			regulator-min-microvolt =3D <3175000>;
 			regulator-max-microvolt =3D <3430000>;
@@ -422,6 +430,7 @@
 		};
=20
 		ldo3_reg: regulator@5 {
+			reg =3D <5>;
 			/* +1.8V voltage with =C2=B14% tolerance */
 			regulator-min-microvolt =3D <1750000>;
 			regulator-max-microvolt =3D <1870000>;
@@ -430,6 +439,7 @@
 		};
=20
 		ldo4_reg: regulator@6 {
+			reg =3D <6>;
 			/* +3.3V voltage with =C2=B14% tolerance */
 			regulator-min-microvolt =3D <3175000>;
 			regulator-max-microvolt =3D <3430000>;
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am=
335x-pepper.dts
index 7106114..32924a9 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -427,9 +427,9 @@
 	vin-supply =3D <&vbat>;
 };
=20
-/include/ "tps65217.dtsi"
-
 &tps {
+	compatible =3D "ti,tps65217";
+
 	backlight {
 		isel =3D <1>; /* ISET1 */
 		fdim =3D <200>; /* TPS65217_BL_FDIM_200HZ */
@@ -437,12 +437,17 @@
 	};
=20
 	regulators {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
 		dcdc1_reg: regulator@0 {
+			reg =3D <0>;
 			/* VDD_1V8 system supply */
 			regulator-always-on;
 		};
=20
 		dcdc2_reg: regulator@1 {
+			reg =3D <1>;
 			/* VDD_CORE voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name =3D "vdd_core";
 			regulator-min-microvolt =3D <925000>;
@@ -452,6 +457,7 @@
 		};
=20
 		dcdc3_reg: regulator@2 {
+			reg =3D <2>;
 			/* VDD_MPU voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name =3D "vdd_mpu";
 			regulator-min-microvolt =3D <925000>;
@@ -461,18 +467,21 @@
 		};
=20
 		ldo1_reg: regulator@3 {
+			reg =3D <3>;
 			/* VRTC 1.8V always-on supply */
 			regulator-name =3D "vrtc,vdds";
 			regulator-always-on;
 		};
=20
 		ldo2_reg: regulator@4 {
+			reg =3D <4>;
 			/* 3.3V rail */
 			regulator-name =3D "vdd_3v3aux";
 			regulator-always-on;
 		};
=20
 		ldo3_reg: regulator@5 {
+			reg =3D <5>;
 			/* VDD_3V3A 3.3V rail */
 			regulator-name =3D "vdd_3v3a";
 			regulator-min-microvolt =3D <3300000>;
@@ -480,6 +489,7 @@
 		};
=20
 		ldo4_reg: regulator@6 {
+			reg =3D <6>;
 			/* VDD_3V3B 3.3V rail */
 			regulator-name =3D "vdd_3v3b";
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am33=
5x-sl50.dts
index 3303c28..d38edfa 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -375,16 +375,19 @@
 	pinctrl-0 =3D <&uart4_pins>;
 };
=20
-#include "tps65217.dtsi"
-
 &tps {
+	compatible =3D "ti,tps65217";
 	ti,pmic-shutdown-controller;
=20
 	interrupt-parent =3D <&intc>;
 	interrupts =3D <7>;	/* NNMI */
=20
 	regulators {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
 		dcdc1_reg: regulator@0 {
+			reg =3D <0>;
 			/* VDDS_DDR */
 			regulator-min-microvolt =3D <1500000>;
 			regulator-max-microvolt =3D <1500000>;
@@ -392,6 +395,7 @@
 		};
=20
 		dcdc2_reg: regulator@1 {
+			reg =3D <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name =3D "vdd_mpu";
 			regulator-min-microvolt =3D <925000>;
@@ -401,6 +405,7 @@
 		};
=20
 		dcdc3_reg: regulator@2 {
+			reg =3D <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name =3D "vdd_core";
 			regulator-min-microvolt =3D <925000>;
@@ -410,6 +415,7 @@
 		};
=20
 		ldo1_reg: regulator@3 {
+			reg =3D <3>;
 			/* VRTC / VIO / VDDS*/
 			regulator-always-on;
 			regulator-min-microvolt =3D <1800000>;
@@ -417,6 +423,7 @@
 		};
=20
 		ldo2_reg: regulator@4 {
+			reg =3D <4>;
 			/* VDD_3V3AUX */
 			regulator-always-on;
 			regulator-min-microvolt =3D <3300000>;
@@ -424,6 +431,7 @@
 		};
=20
 		ldo3_reg: regulator@5 {
+			reg =3D <5>;
 			/* VDD_1V8 */
 			regulator-min-microvolt =3D <1800000>;
 			regulator-max-microvolt =3D <1800000>;
@@ -431,6 +439,7 @@
 		};
=20
 		ldo4_reg: regulator@6 {
+			reg =3D <6>;
 			/* VDD_3V3A */
 			regulator-min-microvolt =3D <3300000>;
 			regulator-max-microvolt =3D <3300000>;
diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps652=
17.dtsi
deleted file mode 100644
index a632724..0000000
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.c=
om/
- *
- * This program is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-/*
- * Integrated Power Management Chip
- * http://www.ti.com/lit/ds/symlink/tps65217.pdf
- */
-
-&tps {
-	compatible =3D "ti,tps65217";
-
-	regulators {
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-
-		dcdc1_reg: regulator@0 {
-			reg =3D <0>;
-			regulator-compatible =3D "dcdc1";
-		};
-
-		dcdc2_reg: regulator@1 {
-			reg =3D <1>;
-			regulator-compatible =3D "dcdc2";
-		};
-
-		dcdc3_reg: regulator@2 {
-			reg =3D <2>;
-			regulator-compatible =3D "dcdc3";
-		};
-
-		ldo1_reg: regulator@3 {
-			reg =3D <3>;
-			regulator-compatible =3D "ldo1";
-		};
-
-		ldo2_reg: regulator@4 {
-			reg =3D <4>;
-			regulator-compatible =3D "ldo2";
-		};
-
-		ldo3_reg: regulator@5 {
-			reg =3D <5>;
-			regulator-compatible =3D "ldo3";
-		};
-
-		ldo4_reg: regulator@6 {
-			reg =3D <6>;
-			regulator-compatible =3D "ldo4";
-		};
-	};
-};
--=20
2.1.0
