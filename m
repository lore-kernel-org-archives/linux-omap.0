From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 09/10] ARM: dts: am335x/437x/57xx: remove unneeded unit name for gpio-leds nodes
Date: Mon,  1 Aug 2016 12:47:03 -0400
Message-ID: <1470070024-30281-10-git-send-email-javier@osg.samsung.com>
References: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for many boards:

"Node /leds/led@1 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am335x-base0033.dts     |  4 ++--
 arch/arm/boot/dts/am335x-bone-common.dtsi |  8 ++++----
 arch/arm/boot/dts/am335x-cm-t335.dts      |  2 +-
 arch/arm/boot/dts/am335x-evmsk.dts        |  8 ++++----
 arch/arm/boot/dts/am335x-icev2.dts        | 32 +++++++++++++++----------------
 arch/arm/boot/dts/am335x-igep0033.dtsi    |  2 +-
 arch/arm/boot/dts/am335x-nano.dts         |  2 +-
 arch/arm/boot/dts/am335x-pepper.dts       |  4 ++--
 arch/arm/boot/dts/am335x-shc.dts          | 12 ++++++------
 arch/arm/boot/dts/am335x-sl50.dts         |  8 ++++----
 arch/arm/boot/dts/am437x-sk-evm.dts       |  8 ++++----
 arch/arm/boot/dts/am57xx-beagle-x15.dts   |  8 ++++----
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts |  2 +-
 13 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
index 58a05f7d0b7c..c2bee452dab8 100644
--- a/arch/arm/boot/dts/am335x-base0033.dts
+++ b/arch/arm/boot/dts/am335x-base0033.dts
@@ -29,13 +29,13 @@
 
 		compatible = "gpio-leds";
 
-		led@0 {
+		led0 {
 			label = "base:red:user";
 			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;	/* gpio1_21 */
 			default-state = "off";
 		};
 
-		led@1 {
+		led1 {
 			label = "base:green:user";
 			gpios = <&gpio2 0 GPIO_ACTIVE_HIGH>;	/* gpio2_0 */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index d4890149dac4..8d21aca69f37 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -28,28 +28,28 @@
 
 		compatible = "gpio-leds";
 
-		led@2 {
+		led2 {
 			label = "beaglebone:green:heartbeat";
 			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
-		led@3 {
+		led3 {
 			label = "beaglebone:green:mmc0";
 			gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
-		led@4 {
+		led4 {
 			label = "beaglebone:green:usr2";
 			gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "cpu0";
 			default-state = "off";
 		};
 
-		led@5 {
+		led5 {
 			label = "beaglebone:green:usr3";
 			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc1";
diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 1dbc70de1070..4c0d6d7a37c2 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -26,7 +26,7 @@
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_led_pins>;
-		led@0 {
+		led0 {
 			label = "cm_t335:green";
 			gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;	/* gpio2_0 */
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 80e9978402e1..c9b11107803d 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -75,26 +75,26 @@
 
 		compatible = "gpio-leds";
 
-		led@1 {
+		led1 {
 			label = "evmsk:green:usr0";
 			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@2 {
+		led2 {
 			label = "evmsk:green:usr1";
 			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@3 {
+		led3 {
 			label = "evmsk:green:mmc0";
 			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
-		led@4 {
+		led4 {
 			label = "evmsk:green:heartbeat";
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index 859e801f7627..bc0190e4f10f 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -43,52 +43,52 @@
 		enable-active-high;
 	};
 
-	leds@0 {
+	leds0 {
 		compatible = "gpio-leds";
 
-		led@0 {
+		led0 {
 			label = "out0";
 			gpios = <&tpic2810 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@1 {
+		led1 {
 			label = "out1";
 			gpios = <&tpic2810 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@2 {
+		led2 {
 			label = "out2";
 			gpios = <&tpic2810 2 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@3 {
+		led3 {
 			label = "out3";
 			gpios = <&tpic2810 3 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@4 {
+		led4 {
 			label = "out4";
 			gpios = <&tpic2810 4 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@5 {
+		led5 {
 			label = "out5";
 			gpios = <&tpic2810 5 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@6 {
+		led6 {
 			label = "out6";
 			gpios = <&tpic2810 6 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@7 {
+		led7 {
 			label = "out7";
 			gpios = <&tpic2810 7 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
@@ -96,44 +96,44 @@
 	};
 
 	/* Tricolor status LEDs */
-	leds@1 {
+	leds1 {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&user_leds>;
 
-		led@0 {
+		led0 {
 			label = "status0:red:cpu0";
 			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 			linux,default-trigger = "cpu0";
 		};
 
-		led@1 {
+		led1 {
 			label = "status0:green:usr";
 			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@2 {
+		led2 {
 			label = "status0:yellow:usr";
 			gpios = <&gpio3 9 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@3 {
+		led3 {
 			label = "status1:red:mmc0";
 			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 			linux,default-trigger = "mmc0";
 		};
 
-		led@4 {
+		led4 {
 			label = "status1:green:usr";
 			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@5 {
+		led5 {
 			label = "status1:yellow:usr";
 			gpios = <&gpio0 19 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 639bb9748942..667f0d02a5ec 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -31,7 +31,7 @@
 
 		compatible = "gpio-leds";
 
-		led@0 {
+		led0 {
 			label = "com:green:user";
 			gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index f313999c503e..71e082ca3f34 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -27,7 +27,7 @@
 	leds {
 		compatible = "gpio-leds";
 
-		led@0 {
+		led0 {
 			label = "nanobone:green:usr1";
 			gpios = <&gpio1 5 0>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index dbf079065659..ddfdf3ca3d66 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -595,14 +595,14 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&user_leds_pins>;
 
-	led@0 {
+	led0 {
 		label = "pepper:user0:blue";
 		gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
 		linux,default-trigger = "none";
 		default-state = "off";
 	};
 
-	led@1 {
+	led1 {
 		label = "pepper:user1:red";
 		gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
 		linux,default-trigger = "none";
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 41b1b1206c31..f9a15afb66c7 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -64,38 +64,38 @@
 
 		compatible = "gpio-leds";
 
-		led@1 {
+		led1 {
 			label = "shc:power:red";
 			gpios = <&gpio0 23 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@2 {
+		led2 {
 			label = "shc:power:bl";
 			gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "timer";
 			default-state = "on";
 		};
 
-		led@3 {
+		led3 {
 			label = "shc:lan:red";
 			gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@4 {
+		led4 {
 			label = "shc:lan:bl";
 			gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@5 {
+		led5 {
 			label = "shc:cloud:red";
 			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led@6 {
+		led6 {
 			label = "shc:cloud:bl";
 			gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 560ebfcddcc5..f802adb23ff9 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -28,25 +28,25 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pins>;
 
-		led@0 {
+		led0 {
 			label = "sl50:green:usr0";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		led@1 {
+		led1 {
 			label = "sl50:red:usr1";
 			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		led@2 {
+		led2 {
 			label = "sl50:green:usr2";
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		led@3 {
+		led3 {
 			label = "sl50:red:usr3";
 			gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 9d71246d31ad..23e7c9ecb76f 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -93,28 +93,28 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&leds_pins>;
 
-		led@0 {
+		led0 {
 			label = "am437x-sk:red:heartbeat";
 			gpios = <&gpio5 0 GPIO_ACTIVE_HIGH>;	/* Bank 5, pin 0 */
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
-		led@1 {
+		led1 {
 			label = "am437x-sk:green:mmc1";
 			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;	/* Bank 5, pin 1 */
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
-		led@2 {
+		led2 {
 			label = "am437x-sk:blue:cpu0";
 			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;	/* Bank 5, pin 2 */
 			linux,default-trigger = "cpu0";
 			default-state = "off";
 		};
 
-		led@3 {
+		led3 {
 			label = "am437x-sk:blue:usr3";
 			gpios = <&gpio5 3 GPIO_ACTIVE_HIGH>;	/* Bank 5, pin 3 */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index c4d04c5293b9..8b115e1b48a3 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -62,28 +62,28 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&leds_pins_default>;
 
-		led@0 {
+		led0 {
 			label = "beagle-x15:usr0";
 			gpios = <&gpio7 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
-		led@1 {
+		led1 {
 			label = "beagle-x15:usr1";
 			gpios = <&gpio7 8 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "cpu0";
 			default-state = "off";
 		};
 
-		led@2 {
+		led2 {
 			label = "beagle-x15:usr2";
 			gpios = <&gpio7 14 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
-		led@3 {
+		led3 {
 			label = "beagle-x15:usr3";
 			gpios = <&gpio7 15 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "disk-activity";
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 378b142ef88c..832d766cd31e 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -29,7 +29,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&leds_pins_default>;
 
-		led@0 {
+		led0 {
 			label = "cl-som-am57x:green";
 			gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
-- 
2.5.5
