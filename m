From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 2/5] ARM: dts: OMAP2+: use existing constants for GPIOs
Date: Thu, 23 May 2013 17:36:58 +0200
Message-ID: <1369323421-4180-3-git-send-email-florian.vaussard@epfl.ch>
References: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:35953 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757617Ab3EWPhS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 May 2013 11:37:18 -0400
In-Reply-To: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Use standard GPIO constants to enhance the readability of DT GPIOs.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap2.dtsi              |    2 ++
 arch/arm/boot/dts/omap3-beagle-xm.dts     |    4 ++--
 arch/arm/boot/dts/omap3-beagle.dts        |    6 +++---
 arch/arm/boot/dts/omap3-devkit8000.dts    |    6 +++---
 arch/arm/boot/dts/omap3-evm.dts           |    2 +-
 arch/arm/boot/dts/omap3-igep0020.dts      |    8 ++++----
 arch/arm/boot/dts/omap3-igep0030.dts      |    8 ++++----
 arch/arm/boot/dts/omap3-tobi.dts          |    2 +-
 arch/arm/boot/dts/omap3.dtsi              |    2 ++
 arch/arm/boot/dts/omap4-panda-common.dtsi |    4 ++--
 arch/arm/boot/dts/omap4-sdp.dts           |   16 ++++++++--------
 arch/arm/boot/dts/omap4.dtsi              |    2 ++
 arch/arm/boot/dts/omap5.dtsi              |    2 ++
 13 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index e6e4587..f39b237 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -8,6 +8,8 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index e0ce823..1e580d9 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -29,13 +29,13 @@
 
 		heartbeat {
 			label = "beagleboard::usr0";
-			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
+			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>; /* 150 -> D6 LED */
 			linux,default-trigger = "heartbeat";
 		};
 
 		mmc {
 			label = "beagleboard::usr1";
-			gpios = <&gpio5 21 0>; /* 149 -> D7 LED */
+			gpios = <&gpio5 21 GPIO_ACTIVE_HIGH>; /* 149 -> D7 LED */
 			linux,default-trigger = "mmc0";
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index fcac96a..434288f 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -28,18 +28,18 @@
 		compatible = "gpio-leds";
 		pmu_stat {
 			label = "beagleboard::pmu_stat";
-			gpios = <&twl_gpio 19 0>; /* LEDB */
+			gpios = <&twl_gpio 19 GPIO_ACTIVE_HIGH>; /* LEDB */
 		};
 
 		heartbeat {
 			label = "beagleboard::usr0";
-			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
+			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>; /* 150 -> D6 LED */
 			linux,default-trigger = "heartbeat";
 		};
 
 		mmc {
 			label = "beagleboard::usr1";
-			gpios = <&gpio5 21 0>; /* 149 -> D7 LED */
+			gpios = <&gpio5 21 GPIO_ACTIVE_HIGH>; /* 149 -> D7 LED */
 			linux,default-trigger = "mmc0";
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 8d0f5e4..5be71b1 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -22,21 +22,21 @@
 
 		heartbeat {
 			label = "devkit8000::led1";
-			gpios = <&gpio6 26 0>;	/* 186 -> LED1 */
+			gpios = <&gpio6 26 GPIO_ACTIVE_HIGH>;	/* 186 -> LED1 */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
 		mmc {
 			label = "devkit8000::led2";
-			gpios = <&gpio6 3 0>;	/* 163 -> LED2 */
+			gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>;	/* 163 -> LED2 */
 			default-state = "on";
 			linux,default-trigger = "none";
 		};
 
 		usr {
 			label = "devkit8000::led3";
-			gpios = <&gpio6 4 0>;	/* 164 -> LED3 */
+			gpios = <&gpio6 4 GPIO_ACTIVE_HIGH>;	/* 164 -> LED3 */
 			default-state = "on";
 			linux,default-trigger = "usr";
                 };
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index d75759b..baa24bb 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -28,7 +28,7 @@
 		compatible = "gpio-leds";
 		ledb {
 			label = "omap3evm::ledb";
-			gpios = <&twl_gpio 19 0>; /* LEDB */
+			gpios = <&twl_gpio 19 GPIO_ACTIVE_HIGH>; /* LEDB */
 			linux,default-trigger = "default-on";
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 2f96a5c..659e57c 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -19,25 +19,25 @@
 		compatible = "gpio-leds";
 		boot {
 			 label = "omap3:green:boot";
-			 gpios = <&gpio1 26 0>;
+			 gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 			 default-state = "on";
 		};
 
 		user0 {
 			 label = "omap3:red:user0";
-			 gpios = <&gpio1 27 0>;
+			 gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
 			 default-state = "off";
 		};
 
 		user1 {
 			 label = "omap3:red:user1";
-			 gpios = <&gpio1 28 0>;
+			 gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 			 default-state = "off";
 		};
 
 		user2 {
 			label = "omap3:green:user1";
-			gpios = <&twl_gpio 19 1>;
+			gpios = <&twl_gpio 19 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index f3a1bf0..8d3baef 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -19,25 +19,25 @@
 		compatible = "gpio-leds";
 		boot {
 			 label = "omap3:green:boot";
-			 gpios = <&twl_gpio 13 1>;
+			 gpios = <&twl_gpio 13 GPIO_ACTIVE_LOW>;
 			 default-state = "on";
 		};
 
 		user0 {
 			 label = "omap3:red:user0";
-			 gpios = <&twl_gpio 18 1>; /* LEDA */
+			 gpios = <&twl_gpio 18 GPIO_ACTIVE_LOW>; /* LEDA */
 			 default-state = "off";
 		};
 
 		user1 {
 			 label = "omap3:green:user1";
-			 gpios = <&twl_gpio 19 1>; /* LEDB */
+			 gpios = <&twl_gpio 19 GPIO_ACTIVE_LOW>; /* LEDB */
 			 default-state = "off";
 		};
 
 		user2 {
 			 label = "omap3:red:user1";
-			 gpios = <&gpio1 16 1>;
+			 gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 			 default-state = "off";
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index 5df894f..c7eebbf 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -20,7 +20,7 @@
 		compatible = "gpio-leds";
 		heartbeat {
 			label = "overo:red:gpio21";
-			gpios = <&gpio1 21 0>;
+			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 7c7d494..aede64d 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -8,6 +8,8 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 63148d1..a3ef2bd 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -20,13 +20,13 @@
 		compatible = "gpio-leds";
 		heartbeat {
 			label = "pandaboard::status1";
-			gpios = <&gpio1 7 0>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		mmc {
 			label = "pandaboard::status2";
-			gpios = <&gpio1 8 0>;
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 		};
 	};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 5edd08e..564d19b 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -41,42 +41,42 @@
 		compatible = "gpio-leds";
 		debug0 {
 			label = "omap4:green:debug0";
-			gpios = <&gpio2 29 0>; /* 61 */
+			gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>; /* 61 */
 		};
 
 		debug1 {
 			label = "omap4:green:debug1";
-			gpios = <&gpio1 30 0>; /* 30 */
+			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>; /* 30 */
 		};
 
 		debug2 {
 			label = "omap4:green:debug2";
-			gpios = <&gpio1 7 0>; /* 7 */
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>; /* 7 */
 		};
 
 		debug3 {
 			label = "omap4:green:debug3";
-			gpios = <&gpio1 8 0>; /* 8 */
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>; /* 8 */
 		};
 
 		debug4 {
 			label = "omap4:green:debug4";
-			gpios = <&gpio2 18 0>; /* 50 */
+			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>; /* 50 */
 		};
 
 		user1 {
 			label = "omap4:blue:user";
-			gpios = <&gpio6 9 0>; /* 169 */
+			gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* 169 */
 		};
 
 		user2 {
 			label = "omap4:red:user";
-			gpios = <&gpio6 10 0>; /* 170 */
+			gpios = <&gpio6 10 GPIO_ACTIVE_HIGH>; /* 170 */
 		};
 
 		user3 {
 			label = "omap4:green:user";
-			gpios = <&gpio5 11 0>; /* 139 */
+			gpios = <&gpio5 11 GPIO_ACTIVE_HIGH>; /* 139 */
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 53d80aa..00f6ab9 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -14,6 +14,8 @@
  */
 /memreserve/ 0x9d000000 0x03000000;
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e8e6653..d613bf5 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -15,6 +15,8 @@
  */
 /memreserve/ 0x9d000000 0x03000000;
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
-- 
1.7.5.4

