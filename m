From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 2/2] ARM: dts: am335x-wega: Clean up regulators
Date: Thu, 3 Sep 2015 14:00:07 +0200
Message-ID: <1441281607-35457-2-git-send-email-t.remmet@phytec.de>
References: <1441281607-35457-1-git-send-email-t.remmet@phytec.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441281607-35457-1-git-send-email-t.remmet@phytec.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

Cleaned up the regulators on the wega board. Created a simple bus,
renamed the regulators according to the schematics and added missing
regulator on wega.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 36 ++++++++++++++++---------------
 arch/arm/boot/dts/am335x-wega.dtsi        | 13 ++++++++++-
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 5dd084f..2f43e45 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -29,8 +29,17 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
-	vbat: fixedregulator@0 {
-		compatible = "regulator-fixed";
+	regulators {
+		compatible = "simple-bus";
+
+		vcc5v: fixedregulator@0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vcc5v";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
 	};
 };
 
@@ -233,14 +242,14 @@
 #include "tps65910.dtsi"
 
 &tps {
-	vcc1-supply = <&vbat>;
-	vcc2-supply = <&vbat>;
-	vcc3-supply = <&vbat>;
-	vcc4-supply = <&vbat>;
-	vcc5-supply = <&vbat>;
-	vcc6-supply = <&vbat>;
-	vcc7-supply = <&vbat>;
-	vccio-supply = <&vbat>;
+	vcc1-supply = <&vcc5v>;
+	vcc2-supply = <&vcc5v>;
+	vcc3-supply = <&vcc5v>;
+	vcc4-supply = <&vcc5v>;
+	vcc5-supply = <&vcc5v>;
+	vcc6-supply = <&vcc5v>;
+	vcc7-supply = <&vcc5v>;
+	vccio-supply = <&vcc5v>;
 
 	regulators {
 		vrtc_reg: regulator@0 {
@@ -311,13 +320,6 @@
 	};
 };
 
-&vbat {
-	regulator-name = "vbat";
-	regulator-min-microvolt = <5000000>;
-	regulator-max-microvolt = <5000000>;
-	regulator-boot-on;
-};
-
 /* SPI Busses */
 &am33xx_pinmux {
 	spi0_pins: pinmux_spi0 {
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 5e541bd..2cecb39 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -11,6 +11,17 @@
 	model = "Phytec AM335x phyBOARD-WEGA";
 	compatible = "phytec,am335x-wega", "phytec,am335x-phycore-som", "ti,am33xx";
 
+	regulators {
+		compatible = "simple-bus";
+
+		vcc3v3: fixedregulator@1 {
+			compatible = "regulator-fixed";
+			regulator-name = "vcc3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+		};
+	};
 };
 
 /* CAN Busses */
@@ -80,7 +91,7 @@
 };
 
 &mmc1 {
-	vmmc-supply = <&vmmc_reg>;
+	vmmc-supply = <&vcc3v3>;
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-- 
1.9.1
