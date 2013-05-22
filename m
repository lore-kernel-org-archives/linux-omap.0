From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 5/5] ARM: dts: OMAP4/5: use existing constants for IRQs
Date: Wed, 22 May 2013 16:27:44 +0200
Message-ID: <1369232864-14460-6-git-send-email-florian.vaussard@epfl.ch>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:35831 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755143Ab3EVO2U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 May 2013 10:28:20 -0400
In-Reply-To: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Use the constants defined in include/dt-bindings/interrupt-controller/
to enhance readability.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |    8 +-
 arch/arm/boot/dts/omap4-sdp.dts           |    6 +-
 arch/arm/boot/dts/omap4-var-som.dts       |    4 +-
 arch/arm/boot/dts/omap4.dtsi              |  113 ++++++++++++++-------------
 arch/arm/boot/dts/omap4460.dtsi           |    4 +-
 arch/arm/boot/dts/omap5.dtsi              |  121 +++++++++++++++--------------
 6 files changed, 129 insertions(+), 127 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index b71f5cd..c2354c9 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -145,16 +145,16 @@
 
 	twl: twl@48 {
 		reg = <0x48>;
-		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
-		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
+		/* IRQ# = 7 */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
 		interrupt-parent = <&gic>;
 	};
 
 	twl6040: twl@4b {
 		compatible = "ti,twl6040";
 		reg = <0x4b>;
-		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
-		interrupts = <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
+		/* IRQ# = 119 */
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
 		interrupt-parent = <&gic>;
 		ti,audpwron-gpio = OMAP_GPIO(127, GPIO_ACTIVE_HIGH);
 
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index f55bb68..3ce4987 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -286,7 +286,7 @@
 	twl: twl@48 {
 		reg = <0x48>;
 		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
-		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
 		interrupt-parent = <&gic>;
 	};
 
@@ -294,7 +294,7 @@
 		compatible = "ti,twl6040";
 		reg = <0x4b>;
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
-		interrupts = <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
 		interrupt-parent = <&gic>;
 		ti,audpwron-gpio = OMAP_GPIO(127, GPIO_ACTIVE_HIGH);
 
@@ -375,7 +375,7 @@
 		spi-max-frequency = <24000000>;
 		reg = <0>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <2 8>; /* gpio line 34, low triggered */
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>; /* gpio line 34, low triggered */
 		vdd-supply = <&vdd_eth>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-var-som.dts b/arch/arm/boot/dts/omap4-var-som.dts
index 6593607..135ba45 100644
--- a/arch/arm/boot/dts/omap4-var-som.dts
+++ b/arch/arm/boot/dts/omap4-var-som.dts
@@ -34,7 +34,7 @@
 	twl: twl@48 {
 		reg = <0x48>;
 		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
-		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
 		interrupt-parent = <&gic>;
 	};
 };
@@ -68,7 +68,7 @@
 		spi-max-frequency = <24000000>;
 		reg = <0>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <11 8>; /* gpio line 171, low triggered */
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* gpio line 171, low triggered */
 		vdd-supply = <&vdd_eth>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3c00b72..d1037ac 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -15,6 +15,7 @@
 /memreserve/ 0x9d000000 0x03000000;
 
 #include <dt-bindings/gpio/omap-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
 
@@ -58,7 +59,7 @@
 	local-timer@0x48240600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x48240600 0x20>;
-		interrupts = <1 13 0x304>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	/*
@@ -99,8 +100,8 @@
 		reg = <0x44000000 0x1000>,
 		      <0x44800000 0x2000>,
 		      <0x45000000 0x1000>;
-		interrupts = <0 9 0x4>,
-			     <0 10 0x4>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
 		counter32k: counter@4a304000 {
 			compatible = "ti,omap-counter32k";
@@ -128,10 +129,10 @@
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
-			interrupts = <0 12 0x4>,
-				     <0 13 0x4>,
-				     <0 14 0x4>,
-				     <0 15 0x4>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			#dma-channels = <32>;
 			#dma-requests = <127>;
@@ -140,7 +141,7 @@
 		gpio1: gpio@4a310000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4a310000 0x200>;
-			interrupts = <0 29 0x4>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio1";
 			ti,gpio-always-on;
 			gpio-controller;
@@ -152,7 +153,7 @@
 		gpio2: gpio@48055000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x48055000 0x200>;
-			interrupts = <0 30 0x4>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio2";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -163,7 +164,7 @@
 		gpio3: gpio@48057000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x48057000 0x200>;
-			interrupts = <0 31 0x4>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio3";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -174,7 +175,7 @@
 		gpio4: gpio@48059000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x48059000 0x200>;
-			interrupts = <0 32 0x4>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio4";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -185,7 +186,7 @@
 		gpio5: gpio@4805b000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4805b000 0x200>;
-			interrupts = <0 33 0x4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio5";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -196,7 +197,7 @@
 		gpio6: gpio@4805d000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4805d000 0x200>;
-			interrupts = <0 34 0x4>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio6";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -209,7 +210,7 @@
 			reg = <0x50000000 0x1000>;
 			#address-cells = <2>;
 			#size-cells = <1>;
-			interrupts = <0 20 0x4>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			gpmc,num-cs = <8>;
 			gpmc,num-waitpins = <4>;
 			ti,hwmods = "gpmc";
@@ -218,7 +219,7 @@
 		uart1: serial@4806a000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806a000 0x100>;
-			interrupts = <0 72 0x4>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
@@ -226,7 +227,7 @@
 		uart2: serial@4806c000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806c000 0x100>;
-			interrupts = <0 73 0x4>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
@@ -234,7 +235,7 @@
 		uart3: serial@48020000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48020000 0x100>;
-			interrupts = <0 74 0x4>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
@@ -242,7 +243,7 @@
 		uart4: serial@4806e000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806e000 0x100>;
-			interrupts = <0 70 0x4>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
@@ -250,7 +251,7 @@
 		i2c1: i2c@48070000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48070000 0x100>;
-			interrupts = <0 56 0x4>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
@@ -259,7 +260,7 @@
 		i2c2: i2c@48072000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48072000 0x100>;
-			interrupts = <0 57 0x4>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
@@ -268,7 +269,7 @@
 		i2c3: i2c@48060000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48060000 0x100>;
-			interrupts = <0 61 0x4>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
@@ -277,7 +278,7 @@
 		i2c4: i2c@48350000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48350000 0x100>;
-			interrupts = <0 62 0x4>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
@@ -286,7 +287,7 @@
 		mcspi1: spi@48098000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x48098000 0x200>;
-			interrupts = <0 65 0x4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
@@ -306,7 +307,7 @@
 		mcspi2: spi@4809a000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x4809a000 0x200>;
-			interrupts = <0 66 0x4>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
@@ -321,7 +322,7 @@
 		mcspi3: spi@480b8000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x480b8000 0x200>;
-			interrupts = <0 91 0x4>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
@@ -333,7 +334,7 @@
 		mcspi4: spi@480ba000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x480ba000 0x200>;
-			interrupts = <0 48 0x4>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
@@ -345,7 +346,7 @@
 		mmc1: mmc@4809c000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x4809c000 0x400>;
-			interrupts = <0 83 0x4>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
@@ -356,7 +357,7 @@
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x480b4000 0x400>;
-			interrupts = <0 86 0x4>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
 			dmas = <&sdma 47>, <&sdma 48>;
@@ -366,7 +367,7 @@
 		mmc3: mmc@480ad000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x480ad000 0x400>;
-			interrupts = <0 94 0x4>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
 			dmas = <&sdma 77>, <&sdma 78>;
@@ -376,7 +377,7 @@
 		mmc4: mmc@480d1000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x480d1000 0x400>;
-			interrupts = <0 96 0x4>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
 			dmas = <&sdma 57>, <&sdma 58>;
@@ -386,7 +387,7 @@
 		mmc5: mmc@480d5000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x480d5000 0x400>;
-			interrupts = <0 59 0x4>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 			dmas = <&sdma 59>, <&sdma 60>;
@@ -396,7 +397,7 @@
 		wdt2: wdt@4a314000 {
 			compatible = "ti,omap4-wdt", "ti,omap3-wdt";
 			reg = <0x4a314000 0x80>;
-			interrupts = <0 80 0x4>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "wd_timer2";
 		};
 
@@ -405,7 +406,7 @@
 			reg = <0x40132000 0x7f>, /* MPU private access */
 			      <0x49032000 0x7f>; /* L3 Interconnect */
 			reg-names = "mpu", "dma";
-			interrupts = <0 112 0x4>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mcpdm";
 			dmas = <&sdma 65>,
 			       <&sdma 66>;
@@ -417,7 +418,7 @@
 			reg = <0x4012e000 0x7f>, /* MPU private access */
 			      <0x4902e000 0x7f>; /* L3 Interconnect */
 			reg-names = "mpu", "dma";
-			interrupts = <0 114 0x4>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "dmic";
 			dmas = <&sdma 67>;
 			dma-names = "up_link";
@@ -428,7 +429,7 @@
 			reg = <0x40122000 0xff>, /* MPU private access */
 			      <0x49022000 0xff>; /* L3 Interconnect */
 			reg-names = "mpu", "dma";
-			interrupts = <0 17 0x4>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp1";
@@ -442,7 +443,7 @@
 			reg = <0x40124000 0xff>, /* MPU private access */
 			      <0x49024000 0xff>; /* L3 Interconnect */
 			reg-names = "mpu", "dma";
-			interrupts = <0 22 0x4>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp2";
@@ -456,7 +457,7 @@
 			reg = <0x40126000 0xff>, /* MPU private access */
 			      <0x49026000 0xff>; /* L3 Interconnect */
 			reg-names = "mpu", "dma";
-			interrupts = <0 23 0x4>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3";
@@ -469,7 +470,7 @@
 			compatible = "ti,omap4-mcbsp";
 			reg = <0x48096000 0xff>; /* L4 Interconnect */
 			reg-names = "mpu";
-			interrupts = <0 16 0x4>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp4";
@@ -481,7 +482,7 @@
 		keypad: keypad@4a31c000 {
 			compatible = "ti,omap4-keypad";
 			reg = <0x4a31c000 0x80>;
-			interrupts = <0 120 0x4>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			reg-names = "mpu";
 			ti,hwmods = "kbd";
 		};
@@ -489,7 +490,7 @@
 		emif1: emif@4c000000 {
 			compatible = "ti,emif-4d";
 			reg = <0x4c000000 0x100>;
-			interrupts = <0 110 0x4>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "emif1";
 			phy-type = <1>;
 			hw-caps-read-idle-ctrl;
@@ -500,7 +501,7 @@
 		emif2: emif@4d000000 {
 			compatible = "ti,emif-4d";
 			reg = <0x4d000000 0x100>;
-			interrupts = <0 111 0x4>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "emif2";
 			phy-type = <1>;
 			hw-caps-read-idle-ctrl;
@@ -525,7 +526,7 @@
 		timer1: timer@4a318000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x4a318000 0x80>;
-			interrupts = <0 37 0x4>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
 		};
@@ -533,21 +534,21 @@
 		timer2: timer@48032000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x48032000 0x80>;
-			interrupts = <0 38 0x4>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer2";
 		};
 
 		timer3: timer@48034000 {
 			compatible = "ti,omap4430-timer";
 			reg = <0x48034000 0x80>;
-			interrupts = <0 39 0x4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer3";
 		};
 
 		timer4: timer@48036000 {
 			compatible = "ti,omap4430-timer";
 			reg = <0x48036000 0x80>;
-			interrupts = <0 40 0x4>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer4";
 		};
 
@@ -555,7 +556,7 @@
 			compatible = "ti,omap4430-timer";
 			reg = <0x40138000 0x80>,
 			      <0x49038000 0x80>;
-			interrupts = <0 41 0x4>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer5";
 			ti,timer-dsp;
 		};
@@ -564,7 +565,7 @@
 			compatible = "ti,omap4430-timer";
 			reg = <0x4013a000 0x80>,
 			      <0x4903a000 0x80>;
-			interrupts = <0 42 0x4>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer6";
 			ti,timer-dsp;
 		};
@@ -573,7 +574,7 @@
 			compatible = "ti,omap4430-timer";
 			reg = <0x4013c000 0x80>,
 			      <0x4903c000 0x80>;
-			interrupts = <0 43 0x4>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer7";
 			ti,timer-dsp;
 		};
@@ -582,7 +583,7 @@
 			compatible = "ti,omap4430-timer";
 			reg = <0x4013e000 0x80>,
 			      <0x4903e000 0x80>;
-			interrupts = <0 44 0x4>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer8";
 			ti,timer-pwm;
 			ti,timer-dsp;
@@ -591,7 +592,7 @@
 		timer9: timer@4803e000 {
 			compatible = "ti,omap4430-timer";
 			reg = <0x4803e000 0x80>;
-			interrupts = <0 45 0x4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer9";
 			ti,timer-pwm;
 		};
@@ -599,7 +600,7 @@
 		timer10: timer@48086000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x48086000 0x80>;
-			interrupts = <0 46 0x4>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer10";
 			ti,timer-pwm;
 		};
@@ -607,7 +608,7 @@
 		timer11: timer@48088000 {
 			compatible = "ti,omap4430-timer";
 			reg = <0x48088000 0x80>;
-			interrupts = <0 47 0x4>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer11";
 			ti,timer-pwm;
 		};
@@ -615,7 +616,7 @@
 		usbhstll: usbhstll@4a062000 {
 			compatible = "ti,usbhs-tll";
 			reg = <0x4a062000 0x1000>;
-			interrupts = <0 78 0x4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "usb_tll_hs";
 		};
 
@@ -631,14 +632,14 @@
 				compatible = "ti,ohci-omap3", "usb-ohci";
 				reg = <0x4a064800 0x400>;
 				interrupt-parent = <&gic>;
-				interrupts = <0 76 0x4>;
+				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			usbhsehci: ehci@4a064c00 {
 				compatible = "ti,ehci-omap", "usb-ehci";
 				reg = <0x4a064c00 0x400>;
 				interrupt-parent = <&gic>;
-				interrupts = <0 77 0x4>;
+				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -653,7 +654,7 @@
 		usb_otg_hs: usb_otg_hs@4a0ab000 {
 			compatible = "ti,omap4-musb";
 			reg = <0x4a0ab000 0x7ff>;
-			interrupts = <0 92 0x4>, <0 93 0x4>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc", "dma";
 			ti,hwmods = "usb_otg_hs";
 			usb-phy = <&usb2_phy>;
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 41762c2..19628b1 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -25,8 +25,8 @@
 
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
-		interrupts = <0 54 0x4>,
-			     <0 55 0x4>;
+		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 		ti,hwmods = "debugss";
 	};
 };
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index af849e6..cbdaa3c 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -16,6 +16,7 @@
 /memreserve/ 0x9d000000 0x03000000;
 
 #include <dt-bindings/gpio/omap-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
 
@@ -47,10 +48,10 @@
 	timer {
 		compatible = "arm,armv7-timer";
 		/* PPI secure/nonsecure IRQ, active low level-sensitive */
-		interrupts = <1 13 0x308>,
-			     <1 14 0x308>,
-			     <1 11 0x308>,
-			     <1 10 0x308>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
 		clock-frequency = <6144000>;
 	};
 
@@ -92,8 +93,8 @@
 		reg = <0x44000000 0x2000>,
 		      <0x44800000 0x3000>,
 		      <0x45000000 0x4000>;
-		interrupts = <0 9 0x4>,
-			     <0 10 0x4>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
 		counter32k: counter@4ae04000 {
 			compatible = "ti,omap-counter32k";
@@ -121,10 +122,10 @@
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
-			interrupts = <0 12 0x4>,
-				     <0 13 0x4>,
-				     <0 14 0x4>,
-				     <0 15 0x4>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			#dma-channels = <32>;
 			#dma-requests = <127>;
@@ -133,7 +134,7 @@
 		gpio1: gpio@4ae10000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4ae10000 0x200>;
-			interrupts = <0 29 0x4>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio1";
 			ti,gpio-always-on;
 			gpio-controller;
@@ -145,7 +146,7 @@
 		gpio2: gpio@48055000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x48055000 0x200>;
-			interrupts = <0 30 0x4>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio2";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -156,7 +157,7 @@
 		gpio3: gpio@48057000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x48057000 0x200>;
-			interrupts = <0 31 0x4>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio3";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -167,7 +168,7 @@
 		gpio4: gpio@48059000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x48059000 0x200>;
-			interrupts = <0 32 0x4>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio4";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -178,7 +179,7 @@
 		gpio5: gpio@4805b000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4805b000 0x200>;
-			interrupts = <0 33 0x4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio5";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -189,7 +190,7 @@
 		gpio6: gpio@4805d000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4805d000 0x200>;
-			interrupts = <0 34 0x4>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio6";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -200,7 +201,7 @@
 		gpio7: gpio@48051000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x48051000 0x200>;
-			interrupts = <0 35 0x4>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio7";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -211,7 +212,7 @@
 		gpio8: gpio@48053000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x48053000 0x200>;
-			interrupts = <0 121 0x4>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio8";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -224,7 +225,7 @@
 			reg = <0x50000000 0x1000>;
 			#address-cells = <2>;
 			#size-cells = <1>;
-			interrupts = <0 20 0x4>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			gpmc,num-cs = <8>;
 			gpmc,num-waitpins = <4>;
 			ti,hwmods = "gpmc";
@@ -233,7 +234,7 @@
 		i2c1: i2c@48070000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48070000 0x100>;
-			interrupts = <0 56 0x4>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
@@ -242,7 +243,7 @@
 		i2c2: i2c@48072000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48072000 0x100>;
-			interrupts = <0 57 0x4>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
@@ -251,7 +252,7 @@
 		i2c3: i2c@48060000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48060000 0x100>;
-			interrupts = <0 61 0x4>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
@@ -260,7 +261,7 @@
 		i2c4: i2c@4807a000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x4807a000 0x100>;
-			interrupts = <0 62 0x4>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
@@ -269,7 +270,7 @@
 		i2c5: i2c@4807c000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x4807c000 0x100>;
-			interrupts = <0 60 0x4>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c5";
@@ -278,7 +279,7 @@
 		mcspi1: spi@48098000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x48098000 0x200>;
-			interrupts = <0 65 0x4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
@@ -298,7 +299,7 @@
 		mcspi2: spi@4809a000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x4809a000 0x200>;
-			interrupts = <0 66 0x4>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
@@ -313,7 +314,7 @@
 		mcspi3: spi@480b8000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x480b8000 0x200>;
-			interrupts = <0 91 0x4>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
@@ -325,7 +326,7 @@
 		mcspi4: spi@480ba000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x480ba000 0x200>;
-			interrupts = <0 48 0x4>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
@@ -337,7 +338,7 @@
 		uart1: serial@4806a000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806a000 0x100>;
-			interrupts = <0 72 0x4>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
@@ -345,7 +346,7 @@
 		uart2: serial@4806c000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806c000 0x100>;
-			interrupts = <0 73 0x4>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
@@ -353,7 +354,7 @@
 		uart3: serial@48020000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48020000 0x100>;
-			interrupts = <0 74 0x4>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
@@ -361,7 +362,7 @@
 		uart4: serial@4806e000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806e000 0x100>;
-			interrupts = <0 70 0x4>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
@@ -369,7 +370,7 @@
 		uart5: serial@48066000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48066000 0x100>;
-			interrupts = <0 105 0x4>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 		};
@@ -377,7 +378,7 @@
 		uart6: serial@48068000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48068000 0x100>;
-			interrupts = <0 106 0x4>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 		};
@@ -385,7 +386,7 @@
 		mmc1: mmc@4809c000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x4809c000 0x400>;
-			interrupts = <0 83 0x4>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
@@ -396,7 +397,7 @@
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x480b4000 0x400>;
-			interrupts = <0 86 0x4>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
 			dmas = <&sdma 47>, <&sdma 48>;
@@ -406,7 +407,7 @@
 		mmc3: mmc@480ad000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x480ad000 0x400>;
-			interrupts = <0 94 0x4>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
 			dmas = <&sdma 77>, <&sdma 78>;
@@ -416,7 +417,7 @@
 		mmc4: mmc@480d1000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x480d1000 0x400>;
-			interrupts = <0 96 0x4>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
 			dmas = <&sdma 57>, <&sdma 58>;
@@ -426,7 +427,7 @@
 		mmc5: mmc@480d5000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x480d5000 0x400>;
-			interrupts = <0 59 0x4>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 			dmas = <&sdma 59>, <&sdma 60>;
@@ -444,7 +445,7 @@
 			reg = <0x40132000 0x7f>, /* MPU private access */
 			      <0x49032000 0x7f>; /* L3 Interconnect */
 			reg-names = "mpu", "dma";
-			interrupts = <0 112 0x4>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mcpdm";
 			dmas = <&sdma 65>,
 			       <&sdma 66>;
@@ -456,7 +457,7 @@
 			reg = <0x4012e000 0x7f>, /* MPU private access */
 			      <0x4902e000 0x7f>; /* L3 Interconnect */
 			reg-names = "mpu", "dma";
-			interrupts = <0 114 0x4>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "dmic";
 			dmas = <&sdma 67>;
 			dma-names = "up_link";
@@ -467,7 +468,7 @@
 			reg = <0x40122000 0xff>, /* MPU private access */
 			      <0x49022000 0xff>; /* L3 Interconnect */
 			reg-names = "mpu", "dma";
-			interrupts = <0 17 0x4>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp1";
@@ -481,7 +482,7 @@
 			reg = <0x40124000 0xff>, /* MPU private access */
 			      <0x49024000 0xff>; /* L3 Interconnect */
 			reg-names = "mpu", "dma";
-			interrupts = <0 22 0x4>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp2";
@@ -495,7 +496,7 @@
 			reg = <0x40126000 0xff>, /* MPU private access */
 			      <0x49026000 0xff>; /* L3 Interconnect */
 			reg-names = "mpu", "dma";
-			interrupts = <0 23 0x4>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3";
@@ -507,7 +508,7 @@
 		timer1: timer@4ae18000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x4ae18000 0x80>;
-			interrupts = <0 37 0x4>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
 		};
@@ -515,21 +516,21 @@
 		timer2: timer@48032000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x48032000 0x80>;
-			interrupts = <0 38 0x4>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer2";
 		};
 
 		timer3: timer@48034000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x48034000 0x80>;
-			interrupts = <0 39 0x4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer3";
 		};
 
 		timer4: timer@48036000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x48036000 0x80>;
-			interrupts = <0 40 0x4>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer4";
 		};
 
@@ -537,7 +538,7 @@
 			compatible = "ti,omap5430-timer";
 			reg = <0x40138000 0x80>,
 			      <0x49038000 0x80>;
-			interrupts = <0 41 0x4>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer5";
 			ti,timer-dsp;
 		};
@@ -546,7 +547,7 @@
 			compatible = "ti,omap5430-timer";
 			reg = <0x4013a000 0x80>,
 			      <0x4903a000 0x80>;
-			interrupts = <0 42 0x4>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer6";
 			ti,timer-dsp;
 			ti,timer-pwm;
@@ -556,7 +557,7 @@
 			compatible = "ti,omap5430-timer";
 			reg = <0x4013c000 0x80>,
 			      <0x4903c000 0x80>;
-			interrupts = <0 43 0x4>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer7";
 			ti,timer-dsp;
 		};
@@ -565,7 +566,7 @@
 			compatible = "ti,omap5430-timer";
 			reg = <0x4013e000 0x80>,
 			      <0x4903e000 0x80>;
-			interrupts = <0 44 0x4>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer8";
 			ti,timer-dsp;
 			ti,timer-pwm;
@@ -574,21 +575,21 @@
 		timer9: timer@4803e000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x4803e000 0x80>;
-			interrupts = <0 45 0x4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer9";
 		};
 
 		timer10: timer@48086000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x48086000 0x80>;
-			interrupts = <0 46 0x4>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer10";
 		};
 
 		timer11: timer@48088000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x48088000 0x80>;
-			interrupts = <0 47 0x4>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer11";
 			ti,timer-pwm;
 		};
@@ -596,7 +597,7 @@
 		wdt2: wdt@4ae14000 {
 			compatible = "ti,omap5-wdt", "ti,omap3-wdt";
 			reg = <0x4ae14000 0x80>;
-			interrupts = <0 80 0x4>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "wd_timer2";
 		};
 
@@ -605,7 +606,7 @@
 			ti,hwmods	= "emif1";
 			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
 			reg = <0x4c000000 0x400>;
-			interrupts = <0 110 0x4>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			hw-caps-read-idle-ctrl;
 			hw-caps-ll-interface;
 			hw-caps-temp-alert;
@@ -616,7 +617,7 @@
 			ti,hwmods	= "emif2";
 			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
 			reg = <0x4d000000 0x400>;
-			interrupts = <0 111 0x4>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			hw-caps-read-idle-ctrl;
 			hw-caps-ll-interface;
 			hw-caps-temp-alert;
@@ -634,7 +635,7 @@
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss";
 			reg = <0x4a020000 0x1000>;
-			interrupts = <0 93 4>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			utmi-mode = <2>;
@@ -642,7 +643,7 @@
 			dwc3@4a030000 {
 				compatible = "synopsys,dwc3";
 				reg = <0x4a030000 0x1000>;
-				interrupts = <0 92 4>;
+				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 				usb-phy = <&usb2_phy>, <&usb3_phy>;
 				tx-fifo-resize;
 			};
-- 
1.7.5.4

