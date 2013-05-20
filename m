From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 2/2] ARM: dts: AM33XX: Set pinmux for clkout2 pad used for clock output
Date: Mon, 20 May 2013 18:58:10 +0530
Message-ID: <1369056490-12632-3-git-send-email-hvaibhav@ti.com>
References: <1369056490-12632-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55874 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756632Ab3ETN2t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 May 2013 09:28:49 -0400
In-Reply-To: <1369056490-12632-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

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
index bfba6fc..74bfcc6 100644
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
+		clkout2_pin: pinmux_clkout2_pin {
+			pinctrl-single,pins = <
+				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+			>;
+		};
 	};

 	ocp {
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 7647c9d..896d392 100644
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
+		clkout2_pin: pinmux_clkout2_pin {
+			pinctrl-single,pins = <
+				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+			>;
+		};
 	};

 	ocp {
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 0eec644..4d81dbc 100644
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
+		clkout2_pin: pinmux_clkout2_pin {
+			pinctrl-single,pins = <
+				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+			>;
+		};
 	};

 	ocp {
--
1.7.0.4

