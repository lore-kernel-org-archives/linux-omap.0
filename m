From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 3/5] ARM: dts: AM33XX: Fix gpio numbering to match hardware/TRM
Date: Wed, 27 Mar 2013 18:29:14 +0530
Message-ID: <1364389156-8273-4-git-send-email-hvaibhav@ti.com>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38942 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab3C0M7e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 08:59:34 -0400
In-Reply-To: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, mporter@ti.com, devicetree-discuss@lists.ozlabs.org, Vaibhav Hiremath <hvaibhav@ti.com>

With DT support, where naming convention is based on base-addr
and not id, so we should follow TRM/Spec numbering label.

This patch changes GPIO numbering as per TRM, as gpio0-3.

Matt Porter had submitted base patch sometime back but it
didn't make it to the mainline -
https://patchwork.kernel.org/patch/1433001/

Later DT nodes for gpio based keypad and led driver got
merged, so this fix needs to propagate to board dts files
as well.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Matt Porter <mporter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts  |    8 ++++----
 arch/arm/boot/dts/am335x-evm.dts   |   14 +++++++-------
 arch/arm/boot/dts/am335x-evmsk.dts |   16 ++++++++--------
 arch/arm/boot/dts/am33xx.dtsi      |    8 ++++----
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index c917efa..860630b 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -69,27 +69,27 @@
 
 		led@2 {
 			label = "beaglebone:green:heartbeat";
-			gpios = <&gpio2 21 0>;
+			gpios = <&gpio1 21 0>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
 		led@3 {
 			label = "beaglebone:green:mmc0";
-			gpios = <&gpio2 22 0>;
+			gpios = <&gpio1 22 0>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		led@4 {
 			label = "beaglebone:green:usr2";
-			gpios = <&gpio2 23 0>;
+			gpios = <&gpio1 23 0>;
 			default-state = "off";
 		};
 
 		led@5 {
 			label = "beaglebone:green:usr3";
-			gpios = <&gpio2 24 0>;
+			gpios = <&gpio1 24 0>;
 			default-state = "off";
 		};
 	};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index db52d3c..79b3cc8 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -143,12 +143,12 @@
 		debounce-delay-ms = <5>;
 		col-scan-delay-us = <2>;
 
-		row-gpios = <&gpio2 25 0	/* Bank1, pin25 */
-			     &gpio2 26 0	/* Bank1, pin26 */
-			     &gpio2 27 0>;	/* Bank1, pin27 */
+		row-gpios = <&gpio1 25 0	/* Bank1, pin25 */
+			     &gpio1 26 0	/* Bank1, pin26 */
+			     &gpio1 27 0>;	/* Bank1, pin27 */
 
-		col-gpios = <&gpio2 21 0	/* Bank1, pin21 */
-			     &gpio2 22 0>;	/* Bank1, pin22 */
+		col-gpios = <&gpio1 21 0	/* Bank1, pin21 */
+			     &gpio1 22 0>;	/* Bank1, pin22 */
 
 		linux,keymap = <0x0000008b	/* MENU */
 				0x0100009e	/* BACK */
@@ -167,14 +167,14 @@
 		switch@9 {
 			label = "volume-up";
 			linux,code = <115>;
-			gpios = <&gpio1 2 1>;
+			gpios = <&gpio0 2 1>;	/* Bank0, pin2 */
 			gpio-key,wakeup;
 		};
 
 		switch@10 {
 			label = "volume-down";
 			linux,code = <114>;
-			gpios = <&gpio1 3 1>;
+			gpios = <&gpio0 3 1>;	/* Bank0, pin3 */
 			gpio-key,wakeup;
 		};
 	};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 24e915c..15a3052 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -125,26 +125,26 @@
 
 		led@1 {
 			label = "evmsk:green:usr0";
-			gpios = <&gpio2 4 0>;
+			gpios = <&gpio1 4 0>;
 			default-state = "off";
 		};
 
 		led@2 {
 			label = "evmsk:green:usr1";
-			gpios = <&gpio2 5 0>;
+			gpios = <&gpio1 5 0>;
 			default-state = "off";
 		};
 
 		led@3 {
 			label = "evmsk:green:mmc0";
-			gpios = <&gpio2 6 0>;
+			gpios = <&gpio1 6 0>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		led@4 {
 			label = "evmsk:green:heartbeat";
-			gpios = <&gpio2 7 0>;
+			gpios = <&gpio1 7 0>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
@@ -158,26 +158,26 @@
 		switch@1 {
 			label = "button0";
 			linux,code = <0x100>;
-			gpios = <&gpio3 3 0>;
+			gpios = <&gpio2 3 0>;
 		};
 
 		switch@2 {
 			label = "button1";
 			linux,code = <0x101>;
-			gpios = <&gpio3 2 0>;
+			gpios = <&gpio2 2 0>;
 		};
 
 		switch@3 {
 			label = "button2";
 			linux,code = <0x102>;
-			gpios = <&gpio1 30 0>;
+			gpios = <&gpio0 30 0>;
 			gpio-key,wakeup;
 		};
 
 		switch@4 {
 			label = "button3";
 			linux,code = <0x103>;
-			gpios = <&gpio3 5 0>;
+			gpios = <&gpio2 5 0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c38b2fa..dd237de 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -87,7 +87,7 @@
 			reg = <0x48200000 0x1000>;
 		};
 
-		gpio1: gpio@44e07000 {
+		gpio0: gpio@44e07000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
 			gpio-controller;
@@ -98,7 +98,7 @@
 			interrupts = <96>;
 		};
 
-		gpio2: gpio@4804c000 {
+		gpio1: gpio@4804c000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio2";
 			gpio-controller;
@@ -109,7 +109,7 @@
 			interrupts = <98>;
 		};
 
-		gpio3: gpio@481ac000 {
+		gpio2: gpio@481ac000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio3";
 			gpio-controller;
@@ -120,7 +120,7 @@
 			interrupts = <32>;
 		};
 
-		gpio4: gpio@481ae000 {
+		gpio3: gpio@481ae000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio4";
 			gpio-controller;
-- 
1.7.0.4

