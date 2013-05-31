From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 4/4] ARM: dts: AM33XX: Use pinctrl constants
Date: Fri, 31 May 2013 14:42:22 +0200
Message-ID: <1370004142-30506-5-git-send-email-florian.vaussard@epfl.ch>
References: <1370004142-30506-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:40473 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756563Ab3EaMmz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 08:42:55 -0400
In-Reply-To: <1370004142-30506-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Using constants for pinctrl allows a better readability, and removes
redundancy with comments.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/am335x-bone.dts  |   18 +++++++++---------
 arch/arm/boot/dts/am335x-evm.dts   |   28 ++++++++++++++--------------
 arch/arm/boot/dts/am335x-evmsk.dts |   26 +++++++++++++-------------
 arch/arm/boot/dts/am33xx.dtsi      |    1 +
 4 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 5bfb7dd..61d0793 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -30,30 +30,30 @@
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
-				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
-				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
-				0x5c 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
-				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
+				0x54 (PIN_OUTPUT | MUX_MODE7)		/* gpmc_a5.gpio1_21 */
+				0x58 (PIN_OUTPUT | PULL_UP | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+				0x5c (PIN_OUTPUT | MUX_MODE7)		/* gpmc_a7.gpio1_23 */
+				0x60 (PIN_OUTPUT | PULL_UP | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
 			>;
 		};
 
 		i2c0_pins: pinmux_i2c0_pins {
 			pinctrl-single,pins = <
-				0x188 0x30	/* i2c0_sda.i2c0_sda PULLUP | INPUTENABLE | MODE0 */
-				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
+				0x188 (PIN_INPUT | PULL_UP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+				0x18c (PIN_INPUT | PULL_UP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
 
 		uart0_pins: pinmux_uart0_pins {
 			pinctrl-single,pins = <
-				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
-				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+				0x170 (PIN_INPUT | PULL_UP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+				0x174 (PIN_OUTPUT | MUX_MODE0)		/* uart0_txd.uart0_txd */
 			>;
 		};
 
 		clkout2_pin: pinmux_clkout2_pin {
 			pinctrl-single,pins = <
-				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+				0x1b4 (PIN_OUTPUT | MUX_MODE3)		/* xdma_event_intr1.clkout2 */
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 0fbecfd..0ee69ec 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -30,45 +30,45 @@
 
 		matrix_keypad_s0: matrix_keypad_s0 {
 			pinctrl-single,pins = <
-				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
-				0x58 0x7	/* gpmc_a6.gpio1_22, OUTPUT | MODE7 */
-				0x64 0x27	/* gpmc_a9.gpio1_25, INPUT | MODE7 */
-				0x68 0x27	/* gpmc_a10.gpio1_26, INPUT | MODE7 */
-				0x6c 0x27	/* gpmc_a11.gpio1_27, INPUT | MODE7 */
+				0x54 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+				0x58 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+				0x64 (PIN_INPUT | MUX_MODE7)	/* gpmc_a9.gpio1_25 */
+				0x68 (PIN_INPUT | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
+				0x6c (PIN_INPUT | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
 			>;
 		};
 
 		volume_keys_s0: volume_keys_s0 {
 			pinctrl-single,pins = <
-				0x150 0x27	/* spi0_sclk.gpio0_2, INPUT | MODE7 */
-				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
+				0x150 (PIN_INPUT | MUX_MODE7)	/* spi0_sclk.gpio0_2 */
+				0x154 (PIN_INPUT | MUX_MODE7)	/* spi0_d0.gpio0_3 */
 			>;
 		};
 
 		i2c0_pins: pinmux_i2c0_pins {
 			pinctrl-single,pins = <
-				0x188 0x30	/* i2c0_sda.i2c0_sda PULLUP | INPUTENABLE | MODE0 */
-				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
+				0x188 (PIN_INPUT | PULL_UP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+				0x18c (PIN_INPUT | PULL_UP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
 
 		i2c1_pins: pinmux_i2c1_pins {
 			pinctrl-single,pins = <
-				0x158 0x32	/* spi0_d1.i2c1_sda PULLUP | INPUTENABLE | MODE2 */
-				0x15c 0x32	/* spi0_cs0.i2c1_scl PULLUP | INPUTENABLE | MODE2 */
+				0x158 (PIN_INPUT | PULL_UP | MUX_MODE2)	/* spi0_d1.i2c1_sda */
+				0x15c (PIN_INPUT | PULL_UP | MUX_MODE2)	/* spi0_cs0.i2c1_scl */
 			>;
 		};
 
 		uart0_pins: pinmux_uart0_pins {
 			pinctrl-single,pins = <
-				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
-				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+				0x170 (PIN_INPUT | PULL_UP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+				0x174 (PIN_OUTPUT | MUX_MODE0)		/* uart0_txd.uart0_txd */
 			>;
 		};
 
 		clkout2_pin: pinmux_clkout2_pin {
 			pinctrl-single,pins = <
-				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+				0x1b4 (PIN_OUTPUT | MUX_MODE3)		/* xdma_event_intr1.clkout2 */
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 289ba2c..5e0e709 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -36,39 +36,39 @@
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
-				0x10 0x7	/* gpmc_ad4.gpio1_4, OUTPUT | MODE7 */
-				0x14 0x7	/* gpmc_ad5.gpio1_5, OUTPUT | MODE7 */
-				0x18 0x7	/* gpmc_ad6.gpio1_6, OUTPUT | MODE7 */
-				0x1c 0x7	/* gpmc_ad7.gpio1_7, OUTPUT | MODE7 */
+				0x10 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
+				0x14 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_ad5.gpio1_5 */
+				0x18 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_ad6.gpio1_6 */
+				0x1c (PIN_OUTPUT | MUX_MODE7)	/* gpmc_ad7.gpio1_7 */
 			>;
 		};
 
 		gpio_keys_s0: gpio_keys_s0 {
 			pinctrl-single,pins = <
-				0x94 0x27	/* gpmc_oen_ren.gpio2_3, INPUT | MODE7 */
-				0x90 0x27	/* gpmc_advn_ale.gpio2_2, INPUT | MODE7 */
-				0x70 0x27	/* gpmc_wait0.gpio0_30, INPUT | MODE7 */
-				0x9c 0x27	/* gpmc_ben0_cle.gpio2_5, INPUT | MODE7 */
+				0x94 (PIN_INPUT | MUX_MODE7)	/* gpmc_oen_ren.gpio2_3 */
+				0x90 (PIN_INPUT | MUX_MODE7)	/* gpmc_advn_ale.gpio2_2 */
+				0x70 (PIN_INPUT | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
+				0x9c (PIN_INPUT | MUX_MODE7)	/* gpmc_ben0_cle.gpio2_5 */
 			>;
 		};
 
 		i2c0_pins: pinmux_i2c0_pins {
 			pinctrl-single,pins = <
-				0x188 0x30	/* i2c0_sda.i2c0_sda PULLUP | INPUTENABLE | MODE0 */
-				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
+				0x188 (PIN_INPUT | PULL_UP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+				0x18c (PIN_INPUT | PULL_UP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
 
 		uart0_pins: pinmux_uart0_pins {
 			pinctrl-single,pins = <
-				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
-				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+				0x170 (PIN_INPUT | PULL_UP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+				0x174 (PIN_OUTPUT | MUX_MODE0)		/* uart0_txd.uart0_txd */
 			>;
 		};
 
 		clkout2_pin: pinmux_clkout2_pin {
 			pinctrl-single,pins = <
-				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+				0x1b4 (PIN_OUTPUT | MUX_MODE3)		/* xdma_event_intr1.clkout2 */
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f116c79..bdcc55f 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/am33xx.h>
 
 #include "skeleton.dtsi"
 
-- 
1.7.5.4

