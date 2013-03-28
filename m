From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 4/6] ARM: dts: AM33XX: Add pinctrl binding to gpio-leds node
Date: Thu, 28 Mar 2013 12:12:41 +0530
Message-ID: <1364452963-22083-5-git-send-email-hvaibhav@ti.com>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51550 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238Ab3C1GoD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 02:44:03 -0400
In-Reply-To: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, mporter@ti.com, b-cousson@ti.com, jacmet@sunsite.dk, Vaibhav Hiremath <hvaibhav@ti.com>

Now gpio-leds driver is using devm_pinctrl_get_select_default()
api to set default pinmux configuration required for the
functionality of the driver, so this patch moves respective
pinctrl binding inside leds node.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts  |    5 ++++-
 arch/arm/boot/dts/am335x-evmsk.dts |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 860630b..1d623e4 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -26,7 +26,7 @@

 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0>;
+		pinctrl-0 = <>;

 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -65,6 +65,9 @@
 	};

 	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
 		compatible = "gpio-leds";

 		led@2 {
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 15a3052..21d5a08 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -32,7 +32,7 @@

 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0 &gpio_keys_s0>;
+		pinctrl-0 = <&gpio_keys_s0>;

 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -121,6 +121,9 @@
 	};

 	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
 		compatible = "gpio-leds";

 		led@1 {
--
1.7.0.4

