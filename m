From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 10/10] ARM: dts: omap3/4/5/dra7: remove unneeded unit name for gpio-leds nodes
Date: Mon,  1 Aug 2016 12:47:04 -0400
Message-ID: <1470070024-30281-11-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/dra7-evm.dts              | 8 ++++----
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 8 ++++----
 arch/arm/boot/dts/omap5-board-common.dtsi   | 2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts          | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index bafcfac067ec..d47c8739bdaa 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -105,25 +105,25 @@
 
 	leds {
 		compatible = "gpio-leds";
-		led@0 {
+		led0 {
 			label = "dra7:usr1";
 			gpios = <&pcf_lcd 4 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		led@1 {
+		led1 {
 			label = "dra7:usr2";
 			gpios = <&pcf_lcd 5 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		led@2 {
+		led2 {
 			label = "dra7:usr3";
 			gpios = <&pcf_lcd 6 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		led@3 {
+		led3 {
 			label = "dra7:usr4";
 			gpios = <&pcf_lcd 7 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index dbc4dc721cc2..af30d4d99307 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -45,28 +45,28 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pins>;
 
-		led@1 {
+		led1 {
 			label = "pandora::sd1";
 			gpios = <&gpio5 0 GPIO_ACTIVE_HIGH>;	/* GPIO_128 */
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
-		led@2 {
+		led2 {
 			label = "pandora::sd2";
 			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;	/* GPIO_129 */
 			linux,default-trigger = "mmc1";
 			default-state = "off";
 		};
 
-		led@3 {
+		led3 {
 			label = "pandora::bluetooth";
 			gpios = <&gpio5 30 GPIO_ACTIVE_HIGH>;	/* GPIO_158 */
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
-		led@4 {
+		led4 {
 			label = "pandora::wifi";
 			gpios = <&gpio5 31 GPIO_ACTIVE_HIGH>;	/* GPIO_159 */
 			linux,default-trigger = "mmc2";
diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 5196113202a2..d1f5ce3d3651 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -79,7 +79,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		led@1 {
+		led1 {
 			label = "omap5:blue:usr1";
 			gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>; /* gpio5_153 D1 LED */
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index a9765605d53b..fe724da3ec0d 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -72,7 +72,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		led@1 {
+		led1 {
 			label = "Heartbeat";
 			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>; /* gpio3_80 ACT_LED */
 			linux,default-trigger = "heartbeat";
-- 
2.5.5
