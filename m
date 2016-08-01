From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 08/10] ARM: dts: omap3/4: remove unneeded unit name for gpio-keys nodes
Date: Mon,  1 Aug 2016 12:47:02 -0400
Message-ID: <1470070024-30281-9-git-send-email-javier@osg.samsung.com>
References: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for many boards:

"Node /gpio_keys/button0@10 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi     | 2 +-
 arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi | 4 ++--
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi   | 4 ++--
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi     | 4 ++--
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi     | 4 ++--
 arch/arm/boot/dts/omap4-duovero-parlor.dts           | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
index 3b3a75997f81..99a7eee6e61f 100644
--- a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
@@ -44,7 +44,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&button_pins>;
-		button0@10 {
+		button0 {
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;		/* gpio_10 */
diff --git a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi b/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
index 7df27926ead2..a57671c4a664 100644
--- a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
@@ -37,13 +37,13 @@
 		pinctrl-0 = <&button_pins>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		button0@23 {
+		button0 {
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
 			wakeup-source;
 		};
-		button1@14 {
+		button1 {
 			label = "button1";
 			linux,code = <BTN_1>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
diff --git a/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi b/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
index 250cc7fe5d5e..286f5baddf07 100644
--- a/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
@@ -37,13 +37,13 @@
 		pinctrl-0 = <&button_pins>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		button0@23 {
+		button0 {
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
 			wakeup-source;
 		};
-		button1@14 {
+		button1 {
 			label = "button1";
 			linux,code = <BTN_1>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
diff --git a/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi b/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
index 8df7ec35d17d..a8020fb42464 100644
--- a/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
@@ -37,13 +37,13 @@
 		pinctrl-0 = <&button_pins>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		button0@23 {
+		button0 {
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
 			wakeup-source;
 		};
-		button1@14 {
+		button1 {
 			label = "button1";
 			linux,code = <BTN_1>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
diff --git a/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi b/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
index 0ea2c451c809..11965737e2c9 100644
--- a/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
@@ -37,13 +37,13 @@
 		pinctrl-0 = <&button_pins>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		button0@23 {
+		button0 {
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
 			wakeup-source;
 		};
-		button1@14 {
+		button1 {
 			label = "button1";
 			linux,code = <BTN_1>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
index 6b39808b8313..1b825128a7b9 100644
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -32,7 +32,7 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		button0@121 {
+		button0 {
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;	/* gpio_121 */
-- 
2.5.5
