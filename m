From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] Revert "regulator: tps65217: remove tps65217.dtsi file"
Date: Fri, 19 Feb 2016 16:12:19 +0200
Message-ID: <1455891139-6139-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, hs@denx.de
Cc: j-keerthy@ti.com, broonie@kernel.org, robh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This reverts commit 8e6ebfaa9b384088002baa10f7534efa73a0794e.

Without the patch reverted regulators will not work. This prevents
MMC to be working for example so the boards can not boot to
MMC rootfs.

Tested it on beaglebone white and bisect also points to the
reverted commit.
The issue can be also fixed by adding "regulator-compatible =3D" to all=
 board
dts file for the regulators.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

I have noticed that bbw did not find the MMC with linux-next, but it tu=
rns out
that even 4.5-rc4 is behaving the same way.
I have run bisect and with this revert patch I can boot up fine.
To be honest I don't know why the tps65217.dtsi has been deleted in the=
 first
place.=20


 .../devicetree/bindings/regulator/tps65217.txt     | 10 ----
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 14 ++----
 arch/arm/boot/dts/am335x-chilisom.dtsi             | 14 +-----
 arch/arm/boot/dts/am335x-nano.dts                  | 14 +-----
 arch/arm/boot/dts/am335x-pepper.dts                | 14 +-----
 arch/arm/boot/dts/am335x-sl50.dts                  | 13 +----
 arch/arm/boot/dts/tps65217.dtsi                    | 56 ++++++++++++++=
++++++++
 7 files changed, 67 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi

diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b=
/Documentation/devicetree/bindings/regulator/tps65217.txt
index d18109657da6..4f05d208c95c 100644
--- a/Documentation/devicetree/bindings/regulator/tps65217.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65217.txt
@@ -26,11 +26,7 @@ Example:
 		ti,pmic-shutdown-controller;
=20
 		regulators {
-			#address-cells =3D <1>;
-			#size-cells =3D <0>;
-
 			dcdc1_reg: dcdc1 {
-				reg =3D <0>;
 				regulator-min-microvolt =3D <900000>;
 				regulator-max-microvolt =3D <1800000>;
 				regulator-boot-on;
@@ -38,7 +34,6 @@ Example:
 			};
=20
 			dcdc2_reg: dcdc2 {
-				reg =3D <1>;
 				regulator-min-microvolt =3D <900000>;
 				regulator-max-microvolt =3D <3300000>;
 				regulator-boot-on;
@@ -46,7 +41,6 @@ Example:
 			};
=20
 			dcdc3_reg: dcc3 {
-				reg =3D <2>;
 				regulator-min-microvolt =3D <900000>;
 				regulator-max-microvolt =3D <1500000>;
 				regulator-boot-on;
@@ -54,7 +48,6 @@ Example:
 			};
=20
 			ldo1_reg: ldo1 {
-				reg =3D <3>;
 				regulator-min-microvolt =3D <1000000>;
 				regulator-max-microvolt =3D <3300000>;
 				regulator-boot-on;
@@ -62,7 +55,6 @@ Example:
 			};
=20
 			ldo2_reg: ldo2 {
-				reg =3D <4>;
 				regulator-min-microvolt =3D <900000>;
 				regulator-max-microvolt =3D <3300000>;
 				regulator-boot-on;
@@ -70,7 +62,6 @@ Example:
 			};
=20
 			ldo3_reg: ldo3 {
-				reg =3D <5>;
 				regulator-min-microvolt =3D <1800000>;
 				regulator-max-microvolt =3D <3300000>;
 				regulator-boot-on;
@@ -78,7 +69,6 @@ Example:
 			};
=20
 			ldo4_reg: ldo4 {
-				reg =3D <6>;
 				regulator-min-microvolt =3D <1800000>;
 				regulator-max-microvolt =3D <3300000>;
 				regulator-boot-on;
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/=
dts/am335x-bone-common.dtsi
index f3db13d2d90e..0cc150b87b86 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -285,8 +285,10 @@
 	};
 };
=20
+
+/include/ "tps65217.dtsi"
+
 &tps {
-	compatible =3D "ti,tps65217";
 	/*
 	 * Configure pmic to enter OFF-state instead of SLEEP-state ("RTC-onl=
y
 	 * mode") at poweroff.  Most BeagleBone versions do not support RTC-o=
nly
@@ -307,17 +309,12 @@
 	ti,pmic-shutdown-controller;
=20
 	regulators {
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-
 		dcdc1_reg: regulator@0 {
-			reg =3D <0>;
 			regulator-name =3D "vdds_dpr";
 			regulator-always-on;
 		};
=20
 		dcdc2_reg: regulator@1 {
-			reg =3D <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name =3D "vdd_mpu";
 			regulator-min-microvolt =3D <925000>;
@@ -327,7 +324,6 @@
 		};
=20
 		dcdc3_reg: regulator@2 {
-			reg =3D <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name =3D "vdd_core";
 			regulator-min-microvolt =3D <925000>;
@@ -337,25 +333,21 @@
 		};
=20
 		ldo1_reg: regulator@3 {
-			reg =3D <3>;
 			regulator-name =3D "vio,vrtc,vdds";
 			regulator-always-on;
 		};
=20
 		ldo2_reg: regulator@4 {
-			reg =3D <4>;
 			regulator-name =3D "vdd_3v3aux";
 			regulator-always-on;
 		};
=20
 		ldo3_reg: regulator@5 {
-			reg =3D <5>;
 			regulator-name =3D "vdd_1v8";
 			regulator-always-on;
 		};
=20
 		ldo4_reg: regulator@6 {
-			reg =3D <6>;
 			regulator-name =3D "vdd_3v3a";
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts=
/am335x-chilisom.dtsi
index fda457b07e15..857d9894103a 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -128,21 +128,16 @@
=20
 };
=20
-&tps {
-	compatible =3D "ti,tps65217";
+/include/ "tps65217.dtsi"
=20
+&tps {
 	regulators {
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-
 		dcdc1_reg: regulator@0 {
-			reg =3D <0>;
 			regulator-name =3D "vdds_dpr";
 			regulator-always-on;
 		};
=20
 		dcdc2_reg: regulator@1 {
-			reg =3D <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name =3D "vdd_mpu";
 			regulator-min-microvolt =3D <925000>;
@@ -152,7 +147,6 @@
 		};
=20
 		dcdc3_reg: regulator@2 {
-			reg =3D <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name =3D "vdd_core";
 			regulator-min-microvolt =3D <925000>;
@@ -162,28 +156,24 @@
 		};
=20
 		ldo1_reg: regulator@3 {
-			reg =3D <3>;
 			regulator-name =3D "vio,vrtc,vdds";
 			regulator-boot-on;
 			regulator-always-on;
 		};
=20
 		ldo2_reg: regulator@4 {
-			reg =3D <4>;
 			regulator-name =3D "vdd_3v3aux";
 			regulator-boot-on;
 			regulator-always-on;
 		};
=20
 		ldo3_reg: regulator@5 {
-			reg =3D <5>;
 			regulator-name =3D "vdd_1v8";
 			regulator-boot-on;
 			regulator-always-on;
 		};
=20
 		ldo4_reg: regulator@6 {
-			reg =3D <6>;
 			regulator-name =3D "vdd_3v3d";
 			regulator-boot-on;
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am33=
5x-nano.dts
index 77559a1ded60..f313999c503e 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -375,15 +375,11 @@
 	wp-gpios =3D <&gpio3 18 0>;
 };
=20
-&tps {
-	compatible =3D "ti,tps65217";
+#include "tps65217.dtsi"
=20
+&tps {
 	regulators {
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-
 		dcdc1_reg: regulator@0 {
-			reg =3D <0>;
 			/* +1.5V voltage with =C2=B14% tolerance */
 			regulator-min-microvolt =3D <1450000>;
 			regulator-max-microvolt =3D <1550000>;
@@ -392,7 +388,6 @@
 		};
=20
 		dcdc2_reg: regulator@1 {
-			reg =3D <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.1V with =C2=B14% tolerance */
 			regulator-name =3D "vdd_mpu";
 			regulator-min-microvolt =3D <915000>;
@@ -402,7 +397,6 @@
 		};
=20
 		dcdc3_reg: regulator@2 {
-			reg =3D <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with =C2=B14% tolerance */
 			regulator-name =3D "vdd_core";
 			regulator-min-microvolt =3D <915000>;
@@ -412,7 +406,6 @@
 		};
=20
 		ldo1_reg: regulator@3 {
-			reg =3D <3>;
 			/* +1.8V voltage with =C2=B14% tolerance */
 			regulator-min-microvolt =3D <1750000>;
 			regulator-max-microvolt =3D <1870000>;
@@ -421,7 +414,6 @@
 		};
=20
 		ldo2_reg: regulator@4 {
-			reg =3D <4>;
 			/* +3.3V voltage with =C2=B14% tolerance */
 			regulator-min-microvolt =3D <3175000>;
 			regulator-max-microvolt =3D <3430000>;
@@ -430,7 +422,6 @@
 		};
=20
 		ldo3_reg: regulator@5 {
-			reg =3D <5>;
 			/* +1.8V voltage with =C2=B14% tolerance */
 			regulator-min-microvolt =3D <1750000>;
 			regulator-max-microvolt =3D <1870000>;
@@ -439,7 +430,6 @@
 		};
=20
 		ldo4_reg: regulator@6 {
-			reg =3D <6>;
 			/* +3.3V voltage with =C2=B14% tolerance */
 			regulator-min-microvolt =3D <3175000>;
 			regulator-max-microvolt =3D <3430000>;
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am=
335x-pepper.dts
index 471a3a70ea1f..8867aaaec54d 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -420,9 +420,9 @@
 	vin-supply =3D <&vbat>;
 };
=20
-&tps {
-	compatible =3D "ti,tps65217";
+/include/ "tps65217.dtsi"
=20
+&tps {
 	backlight {
 		isel =3D <1>; /* ISET1 */
 		fdim =3D <200>; /* TPS65217_BL_FDIM_200HZ */
@@ -430,17 +430,12 @@
 	};
=20
 	regulators {
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-
 		dcdc1_reg: regulator@0 {
-			reg =3D <0>;
 			/* VDD_1V8 system supply */
 			regulator-always-on;
 		};
=20
 		dcdc2_reg: regulator@1 {
-			reg =3D <1>;
 			/* VDD_CORE voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name =3D "vdd_core";
 			regulator-min-microvolt =3D <925000>;
@@ -450,7 +445,6 @@
 		};
=20
 		dcdc3_reg: regulator@2 {
-			reg =3D <2>;
 			/* VDD_MPU voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name =3D "vdd_mpu";
 			regulator-min-microvolt =3D <925000>;
@@ -460,21 +454,18 @@
 		};
=20
 		ldo1_reg: regulator@3 {
-			reg =3D <3>;
 			/* VRTC 1.8V always-on supply */
 			regulator-name =3D "vrtc,vdds";
 			regulator-always-on;
 		};
=20
 		ldo2_reg: regulator@4 {
-			reg =3D <4>;
 			/* 3.3V rail */
 			regulator-name =3D "vdd_3v3aux";
 			regulator-always-on;
 		};
=20
 		ldo3_reg: regulator@5 {
-			reg =3D <5>;
 			/* VDD_3V3A 3.3V rail */
 			regulator-name =3D "vdd_3v3a";
 			regulator-min-microvolt =3D <3300000>;
@@ -482,7 +473,6 @@
 		};
=20
 		ldo4_reg: regulator@6 {
-			reg =3D <6>;
 			/* VDD_3V3B 3.3V rail */
 			regulator-name =3D "vdd_3v3b";
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am33=
5x-sl50.dts
index a676869536bc..a6efbe6eda3b 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -395,19 +395,16 @@
 	pinctrl-0 =3D <&uart4_pins>;
 };
=20
+#include "tps65217.dtsi"
+
 &tps {
-	compatible =3D "ti,tps65217";
 	ti,pmic-shutdown-controller;
=20
 	interrupt-parent =3D <&intc>;
 	interrupts =3D <7>;	/* NNMI */
=20
 	regulators {
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-
 		dcdc1_reg: regulator@0 {
-			reg =3D <0>;
 			/* VDDS_DDR */
 			regulator-min-microvolt =3D <1500000>;
 			regulator-max-microvolt =3D <1500000>;
@@ -415,7 +412,6 @@
 		};
=20
 		dcdc2_reg: regulator@1 {
-			reg =3D <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name =3D "vdd_mpu";
 			regulator-min-microvolt =3D <925000>;
@@ -425,7 +421,6 @@
 		};
=20
 		dcdc3_reg: regulator@2 {
-			reg =3D <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name =3D "vdd_core";
 			regulator-min-microvolt =3D <925000>;
@@ -435,7 +430,6 @@
 		};
=20
 		ldo1_reg: regulator@3 {
-			reg =3D <3>;
 			/* VRTC / VIO / VDDS*/
 			regulator-always-on;
 			regulator-min-microvolt =3D <1800000>;
@@ -443,7 +437,6 @@
 		};
=20
 		ldo2_reg: regulator@4 {
-			reg =3D <4>;
 			/* VDD_3V3AUX */
 			regulator-always-on;
 			regulator-min-microvolt =3D <3300000>;
@@ -451,7 +444,6 @@
 		};
=20
 		ldo3_reg: regulator@5 {
-			reg =3D <5>;
 			/* VDD_1V8 */
 			regulator-min-microvolt =3D <1800000>;
 			regulator-max-microvolt =3D <1800000>;
@@ -459,7 +451,6 @@
 		};
=20
 		ldo4_reg: regulator@6 {
-			reg =3D <6>;
 			/* VDD_3V3A */
 			regulator-min-microvolt =3D <3300000>;
 			regulator-max-microvolt =3D <3300000>;
diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps652=
17.dtsi
new file mode 100644
index 000000000000..a63272422d76
--- /dev/null
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.c=
om/
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Integrated Power Management Chip
+ * http://www.ti.com/lit/ds/symlink/tps65217.pdf
+ */
+
+&tps {
+	compatible =3D "ti,tps65217";
+
+	regulators {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		dcdc1_reg: regulator@0 {
+			reg =3D <0>;
+			regulator-compatible =3D "dcdc1";
+		};
+
+		dcdc2_reg: regulator@1 {
+			reg =3D <1>;
+			regulator-compatible =3D "dcdc2";
+		};
+
+		dcdc3_reg: regulator@2 {
+			reg =3D <2>;
+			regulator-compatible =3D "dcdc3";
+		};
+
+		ldo1_reg: regulator@3 {
+			reg =3D <3>;
+			regulator-compatible =3D "ldo1";
+		};
+
+		ldo2_reg: regulator@4 {
+			reg =3D <4>;
+			regulator-compatible =3D "ldo2";
+		};
+
+		ldo3_reg: regulator@5 {
+			reg =3D <5>;
+			regulator-compatible =3D "ldo3";
+		};
+
+		ldo4_reg: regulator@6 {
+			reg =3D <6>;
+			regulator-compatible =3D "ldo4";
+		};
+	};
+};
--=20
2.7.1
