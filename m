From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 3/5] ARM: dts: OMAP2+: convert DT files to use the new OMAP_GPIO macro
Date: Wed, 22 May 2013 16:27:42 +0200
Message-ID: <1369232864-14460-4-git-send-email-florian.vaussard@epfl.ch>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:35806 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754696Ab3EVO2R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 May 2013 10:28:17 -0400
In-Reply-To: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Use OMAP_GPIO(), in conjunction with standard GPIO flags, to enhance the
readability of DT GPIOs.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap2.dtsi              |    2 ++
 arch/arm/boot/dts/omap3-beagle-xm.dts     |    4 ++--
 arch/arm/boot/dts/omap3-beagle.dts        |    6 +++---
 arch/arm/boot/dts/omap3-devkit8000.dts    |    6 +++---
 arch/arm/boot/dts/omap3-igep0020.dts      |    6 +++---
 arch/arm/boot/dts/omap3-igep0030.dts      |    2 +-
 arch/arm/boot/dts/omap3-tobi.dts          |    2 +-
 arch/arm/boot/dts/omap3.dtsi              |    2 ++
 arch/arm/boot/dts/omap4-panda-common.dtsi |    6 +++---
 arch/arm/boot/dts/omap4-sdp.dts           |   20 ++++++++++----------
 arch/arm/boot/dts/omap4.dtsi              |    2 ++
 arch/arm/boot/dts/omap5.dtsi              |    2 ++
 12 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index e6e4587..7ea5df4 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -8,6 +8,8 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/gpio/omap-gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index e0ce823..e773a5e 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -29,13 +29,13 @@
 
 		heartbeat {
 			label = "beagleboard::usr0";
-			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
+			gpios = OMAP_GPIO(150, GPIO_ACTIVE_HIGH); /* 150 -> D6 LED */
 			linux,default-trigger = "heartbeat";
 		};
 
 		mmc {
 			label = "beagleboard::usr1";
-			gpios = <&gpio5 21 0>; /* 149 -> D7 LED */
+			gpios = OMAP_GPIO(149, GPIO_ACTIVE_HIGH); /* 149 -> D7 LED */
 			linux,default-trigger = "mmc0";
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index fcac96a..f1fd002 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -33,13 +33,13 @@
 
 		heartbeat {
 			label = "beagleboard::usr0";
-			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
+			gpios = OMAP_GPIO(150, GPIO_ACTIVE_HIGH); /* 150 -> D6 LED */
 			linux,default-trigger = "heartbeat";
 		};
 
 		mmc {
 			label = "beagleboard::usr1";
-			gpios = <&gpio5 21 0>; /* 149 -> D7 LED */
+			gpios = OMAP_GPIO(149, GPIO_ACTIVE_HIGH); /* 149 -> D7 LED */
 			linux,default-trigger = "mmc0";
 		};
 	};
@@ -50,7 +50,7 @@
 		regulator-name = "hsusb2_reset";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 19 0>;	/* gpio_147 */
+		gpio = OMAP_GPIO(147, GPIO_ACTIVE_HIGH);
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 8d0f5e4..fecb5ac 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -22,21 +22,21 @@
 
 		heartbeat {
 			label = "devkit8000::led1";
-			gpios = <&gpio6 26 0>;	/* 186 -> LED1 */
+			gpios = OMAP_GPIO(186, GPIO_ACTIVE_HIGH);	/* 186 -> LED1 */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
 		mmc {
 			label = "devkit8000::led2";
-			gpios = <&gpio6 3 0>;	/* 163 -> LED2 */
+			gpios = OMAP_GPIO(163, GPIO_ACTIVE_HIGH);	/* 163 -> LED2 */
 			default-state = "on";
 			linux,default-trigger = "none";
 		};
 
 		usr {
 			label = "devkit8000::led3";
-			gpios = <&gpio6 4 0>;	/* 164 -> LED3 */
+			gpios = OMAP_GPIO(164, GPIO_ACTIVE_HIGH);	/* 164 -> LED3 */
 			default-state = "on";
 			linux,default-trigger = "usr";
                 };
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 2f96a5c..4be8ba1 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -19,19 +19,19 @@
 		compatible = "gpio-leds";
 		boot {
 			 label = "omap3:green:boot";
-			 gpios = <&gpio1 26 0>;
+			 gpios = OMAP_GPIO(26, GPIO_ACTIVE_HIGH);
 			 default-state = "on";
 		};
 
 		user0 {
 			 label = "omap3:red:user0";
-			 gpios = <&gpio1 27 0>;
+			 gpios = OMAP_GPIO(27, GPIO_ACTIVE_HIGH);
 			 default-state = "off";
 		};
 
 		user1 {
 			 label = "omap3:red:user1";
-			 gpios = <&gpio1 28 0>;
+			 gpios = OMAP_GPIO(28, GPIO_ACTIVE_HIGH);
 			 default-state = "off";
 		};
 
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index f3a1bf0..5a2c7a6 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -37,7 +37,7 @@
 
 		user2 {
 			 label = "omap3:red:user1";
-			 gpios = <&gpio1 16 1>;
+			 gpios = OMAP_GPIO(16, GPIO_ACTIVE_LOW);
 			 default-state = "off";
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index 5df894f..8390c8b 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -20,7 +20,7 @@
 		compatible = "gpio-leds";
 		heartbeat {
 			label = "overo:red:gpio21";
-			gpios = <&gpio1 21 0>;
+			gpios = OMAP_GPIO(21, GPIO_ACTIVE_HIGH);
 			linux,default-trigger = "heartbeat";
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 7c7d494..15049b8 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -8,6 +8,8 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/gpio/omap-gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 63148d1..b71f5cd 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -20,13 +20,13 @@
 		compatible = "gpio-leds";
 		heartbeat {
 			label = "pandaboard::status1";
-			gpios = <&gpio1 7 0>;
+			gpios = OMAP_GPIO(7, GPIO_ACTIVE_HIGH);
 			linux,default-trigger = "heartbeat";
 		};
 
 		mmc {
 			label = "pandaboard::status2";
-			gpios = <&gpio1 8 0>;
+			gpios = OMAP_GPIO(8, GPIO_ACTIVE_HIGH);
 			linux,default-trigger = "mmc0";
 		};
 	};
@@ -156,7 +156,7 @@
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
 		interrupt-parent = <&gic>;
-		ti,audpwron-gpio = <&gpio4 31 0>;  /* gpio line 127 */
+		ti,audpwron-gpio = OMAP_GPIO(127, GPIO_ACTIVE_HIGH);
 
 		vio-supply = <&v1v8>;
 		v2v1-supply = <&v2v1>;
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 5edd08e..f55bb68 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -24,7 +24,7 @@
 		regulator-name = "VDD_ETH";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 16 0>;  /* gpio line 48 */
+		gpio = OMAP_GPIO(48, GPIO_ACTIVE_HIGH);
 		enable-active-high;
 		regulator-boot-on;
 	};
@@ -41,42 +41,42 @@
 		compatible = "gpio-leds";
 		debug0 {
 			label = "omap4:green:debug0";
-			gpios = <&gpio2 29 0>; /* 61 */
+			gpios = OMAP_GPIO(61, GPIO_ACTIVE_HIGH);
 		};
 
 		debug1 {
 			label = "omap4:green:debug1";
-			gpios = <&gpio1 30 0>; /* 30 */
+			gpios = OMAP_GPIO(30, GPIO_ACTIVE_HIGH);
 		};
 
 		debug2 {
 			label = "omap4:green:debug2";
-			gpios = <&gpio1 7 0>; /* 7 */
+			gpios = OMAP_GPIO(7, GPIO_ACTIVE_HIGH);
 		};
 
 		debug3 {
 			label = "omap4:green:debug3";
-			gpios = <&gpio1 8 0>; /* 8 */
+			gpios = OMAP_GPIO(8, GPIO_ACTIVE_HIGH);
 		};
 
 		debug4 {
 			label = "omap4:green:debug4";
-			gpios = <&gpio2 18 0>; /* 50 */
+			gpios = OMAP_GPIO(50, GPIO_ACTIVE_HIGH);
 		};
 
 		user1 {
 			label = "omap4:blue:user";
-			gpios = <&gpio6 9 0>; /* 169 */
+			gpios = OMAP_GPIO(169, GPIO_ACTIVE_HIGH);
 		};
 
 		user2 {
 			label = "omap4:red:user";
-			gpios = <&gpio6 10 0>; /* 170 */
+			gpios = OMAP_GPIO(170, GPIO_ACTIVE_HIGH);
 		};
 
 		user3 {
 			label = "omap4:green:user";
-			gpios = <&gpio5 11 0>; /* 139 */
+			gpios = OMAP_GPIO(139, GPIO_ACTIVE_HIGH);
 		};
 	};
 
@@ -296,7 +296,7 @@
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
 		interrupt-parent = <&gic>;
-		ti,audpwron-gpio = <&gpio4 31 0>;  /* gpio line 127 */
+		ti,audpwron-gpio = OMAP_GPIO(127, GPIO_ACTIVE_HIGH);
 
 		vio-supply = <&v1v8>;
 		v2v1-supply = <&v2v1>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 53d80aa..3c00b72 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -14,6 +14,8 @@
  */
 /memreserve/ 0x9d000000 0x03000000;
 
+#include <dt-bindings/gpio/omap-gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e8e6653..af849e6 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -15,6 +15,8 @@
  */
 /memreserve/ 0x9d000000 0x03000000;
 
+#include <dt-bindings/gpio/omap-gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
-- 
1.7.5.4

