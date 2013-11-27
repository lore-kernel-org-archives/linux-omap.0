From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 2/5] ARM: dts: am43x-epos-evm: Add pwm backlight support.
Date: Wed, 27 Nov 2013 13:00:44 +0530
Message-ID: <1385537447-6922-3-git-send-email-sourav.poddar@ti.com>
References: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49417 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab3K0HbE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 02:31:04 -0500
In-Reply-To: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com, "Sourav Poddar Date: Sat, 5 Oct 2013 05:19:46 +0530" <sourav.poddar@ti.com>

From: Sourav Poddar Date: Sat, 5 Oct 2013 05:19:46 +0530 <sourav.poddar@ti.com>

Add pwm backlight support for am43x epos evm.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index a037a92..5521999 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -13,6 +13,7 @@
 #include "am4372.dtsi"
 #include <dt-bindings/pinctrl/am43xx.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "TI AM43x EPOS EVM";
@@ -90,6 +91,12 @@
 				0x9c (PIN_INPUT_PULLUP | MUX_MODE3)
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
@@ -124,6 +131,13 @@
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
@@ -212,3 +226,13 @@
 		spi-rx-bus-width = <4>;
 	};
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
1.7.1

