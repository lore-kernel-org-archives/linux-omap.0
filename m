From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 2/9] ARM: dts: am43x-epos-evm: Add pwm backlight support.
Date: Thu, 19 Dec 2013 18:03:34 +0530
Message-ID: <1387456421-21379-3-git-send-email-sourav.poddar@ti.com>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44487 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756996Ab3LSMeD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 07:34:03 -0500
In-Reply-To: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: balbi@ti.com, devicetree@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, mark.rutland@arm.com, afzal@ti.com, lokeshvutla@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add pwm backlight support for am43x epos evm.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index fbf9c4c..0899c5f 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -13,6 +13,7 @@
 #include "am4372.dtsi"
 #include <dt-bindings/pinctrl/am43xx.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "TI AM43x EPOS EVM";
@@ -79,6 +80,12 @@
 				0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
+
+		ecap0_pins: backlight_pins {
+			pinctrl-single,pins = <
+				0x164 MUX_MODE0         /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -113,6 +120,13 @@
 				0x0203006c	/* DOWN */
 				0x03030069>;	/* LEFT */
 		};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 51 53 56 62 75 101 152 255>;
+		default-brightness-level = <8>;
+	};
 };
 
 &mmc1 {
@@ -184,3 +198,13 @@
 &gpio3 {
 	status = "okay";
 };
+
+&epwmss0 {
+	status = "okay";
+};
+
+&ecap0 {
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ecap0_pins>;
+};
-- 
1.7.9.5

