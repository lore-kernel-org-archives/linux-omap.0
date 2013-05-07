From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 2/2] ARM: dts: AM33XX: Set pinmux for clkout2 pad used for clock output
Date: Tue, 7 May 2013 15:09:34 +0530
Message-ID: <1367919574-21353-3-git-send-email-hvaibhav@ti.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56055 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755757Ab3EGJpC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 May 2013 05:45:02 -0400
In-Reply-To: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

xdma_event_intr1.clkout2 pad can be used to source clock
from either 32K OSC or any of the PLL (except MPU) outputs.
On the existing AM335x based boards (EVM, EVM-SK and Bone),
this pad is used to feed the clock to audio codes.

So, this patch configures the pinmux to get clkout2 on the pad.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts  |    8 +++++++-
 arch/arm/boot/dts/am335x-evm.dts   |    8 +++++++-
 arch/arm/boot/dts/am335x-evmsk.dts |    8 +++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index bfba6fc..f4630a3 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -26,7 +26,7 @@
 
 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <>;
+		pinctrl-0 = <&clkout2_pin>;
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -50,6 +50,12 @@
 				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
 			>;
 		};
+
+		clkout2_pin: pinumx_clkout2_pin {
+			pinctrl-single,pins = <
+				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+			>;
+		};
 	};
 
 	ocp {
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index f598ed2..0673308 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -26,7 +26,7 @@
 
 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0>;
+		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0 &clkout2_pin>;
 
 		matrix_keypad_s0: matrix_keypad_s0 {
 			pinctrl-single,pins = <
@@ -65,6 +65,12 @@
 				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
 			>;
 		};
+
+		clkout2_pin: pinumx_clkout2_pin {
+			pinctrl-single,pins = <
+				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+			>;
+		};
 	};
 
 	ocp {
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 0eec644..a559389 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -32,7 +32,7 @@
 
 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys_s0>;
+		pinctrl-0 = <&gpio_keys_s0 &clkout2_pin>;
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -65,6 +65,12 @@
 				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
 			>;
 		};
+
+		clkout2_pin: pinumx_clkout2_pin {
+			pinctrl-single,pins = <
+				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+			>;
+		};
 	};
 
 	ocp {
-- 
1.7.0.4

