From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 4/4] ARM: dts: AM33XX: Use pinctrl constants
Date: Mon,  3 Jun 2013 16:12:25 +0200
Message-ID: <1370268745-15860-5-git-send-email-florian.vaussard@epfl.ch>
References: <1370268745-15860-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:58790 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757296Ab3FCOMr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jun 2013 10:12:47 -0400
In-Reply-To: <1370268745-15860-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Joel A Fernandes <agnel.joel@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Using constants for pinctrl allows a better readability, and removes
redundancy with comments.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/am335x-bone.dts  |   18 +++++-----
 arch/arm/boot/dts/am335x-evm.dts   |   58 ++++++++++++++++++------------------
 arch/arm/boot/dts/am335x-evmsk.dts |   26 ++++++++--------
 arch/arm/boot/dts/am33xx.dtsi      |    1 +
 4 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 5bfb7dd..fd48173 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -30,30 +30,30 @@
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
-				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
-				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
-				0x5c 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
-				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
+				0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+				0x58 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+				0x5c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a7.gpio1_23 */
+				0x60 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
 			>;
 		};
 
 		i2c0_pins: pinmux_i2c0_pins {
 			pinctrl-single,pins = <
-				0x188 0x30	/* i2c0_sda.i2c0_sda PULLUP | INPUTENABLE | MODE0 */
-				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
+				0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+				0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
 
 		uart0_pins: pinmux_uart0_pins {
 			pinctrl-single,pins = <
-				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
-				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+				0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+				0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 			>;
 		};
 
 		clkout2_pin: pinmux_clkout2_pin {
 			pinctrl-single,pins = <
-				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+				0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index b74dbdf..2c53247 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -30,65 +30,65 @@
 
 		matrix_keypad_s0: matrix_keypad_s0 {
 			pinctrl-single,pins = <
-				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
-				0x58 0x7	/* gpmc_a6.gpio1_22, OUTPUT | MODE7 */
-				0x64 0x27	/* gpmc_a9.gpio1_25, INPUT | MODE7 */
-				0x68 0x27	/* gpmc_a10.gpio1_26, INPUT | MODE7 */
-				0x6c 0x27	/* gpmc_a11.gpio1_27, INPUT | MODE7 */
+				0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+				0x58 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+				0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a9.gpio1_25 */
+				0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
+				0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
 			>;
 		};
 
 		volume_keys_s0: volume_keys_s0 {
 			pinctrl-single,pins = <
-				0x150 0x27	/* spi0_sclk.gpio0_2, INPUT | MODE7 */
-				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
+				0x150 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* spi0_sclk.gpio0_2 */
+				0x154 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* spi0_d0.gpio0_3 */
 			>;
 		};
 
 		i2c0_pins: pinmux_i2c0_pins {
 			pinctrl-single,pins = <
-				0x188 0x30	/* i2c0_sda.i2c0_sda PULLUP | INPUTENABLE | MODE0 */
-				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
+				0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+				0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
 
 		i2c1_pins: pinmux_i2c1_pins {
 			pinctrl-single,pins = <
-				0x158 0x32	/* spi0_d1.i2c1_sda PULLUP | INPUTENABLE | MODE2 */
-				0x15c 0x32	/* spi0_cs0.i2c1_scl PULLUP | INPUTENABLE | MODE2 */
+				0x158 (PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_d1.i2c1_sda */
+				0x15c (PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_cs0.i2c1_scl */
 			>;
 		};
 
 		uart0_pins: pinmux_uart0_pins {
 			pinctrl-single,pins = <
-				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
-				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+				0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+				0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 			>;
 		};
 
 		clkout2_pin: pinmux_clkout2_pin {
 			pinctrl-single,pins = <
-				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+				0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 			>;
 		};
 
 		nandflash_pins_s0: nandflash_pins_s0 {
 			pinctrl-single,pins = <
-				0x0 0x30	/* gpmc_ad0.gpmc_ad0, INPUT | PULLUP | MODE0 */
-				0x4 0x30	/* gpmc_ad1.gpmc_ad1, INPUT | PULLUP | MODE0 */
-				0x8 0x30	/* gpmc_ad2.gpmc_ad2, INPUT | PULLUP | MODE0 */
-				0xc 0x30	/* gpmc_ad3.gpmc_ad3, INPUT | PULLUP | MODE0 */
-				0x10 0x30	/* gpmc_ad4.gpmc_ad4, INPUT | PULLUP | MODE0 */
-				0x14 0x30	/* gpmc_ad5.gpmc_ad5, INPUT | PULLUP | MODE0 */
-				0x18 0x30	/* gpmc_ad6.gpmc_ad6, INPUT | PULLUP | MODE0 */
-				0x1c 0x30	/* gpmc_ad7.gpmc_ad7, INPUT | PULLUP | MODE0 */
-				0x70 0x30	/* gpmc_wait0.gpmc_wait0, INPUT | PULLUP | MODE0 */
-				0x74 0x37	/* gpmc_wpn.gpio0_30, INPUT | PULLUP | MODE7 */
-				0x7c 0x8	/* gpmc_csn0.gpmc_csn0,  PULL DISA */
-				0x90 0x8	/* gpmc_advn_ale.gpmc_advn_ale, PULL DISA */
-				0x94 0x8	/* gpmc_oen_ren.gpmc_oen_ren, PULL DISA */
-				0x98 0x8	/* gpmc_wen.gpmc_wen, PULL DISA */
-				0x9c 0x8	/* gpmc_be0n_cle.gpmc_be0n_cle, PULL DISA */
+				0x0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+				0x4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+				0x8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+				0xc (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+				0x10 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+				0x14 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+				0x18 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+				0x1c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+				0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+				0x74 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
+				0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+				0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+				0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+				0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+				0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 16d17d6..338b681 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -36,39 +36,39 @@
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
-				0x10 0x7	/* gpmc_ad4.gpio1_4, OUTPUT | MODE7 */
-				0x14 0x7	/* gpmc_ad5.gpio1_5, OUTPUT | MODE7 */
-				0x18 0x7	/* gpmc_ad6.gpio1_6, OUTPUT | MODE7 */
-				0x1c 0x7	/* gpmc_ad7.gpio1_7, OUTPUT | MODE7 */
+				0x10 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
+				0x14 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad5.gpio1_5 */
+				0x18 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad6.gpio1_6 */
+				0x1c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad7.gpio1_7 */
 			>;
 		};
 
 		gpio_keys_s0: gpio_keys_s0 {
 			pinctrl-single,pins = <
-				0x94 0x27	/* gpmc_oen_ren.gpio2_3, INPUT | MODE7 */
-				0x90 0x27	/* gpmc_advn_ale.gpio2_2, INPUT | MODE7 */
-				0x70 0x27	/* gpmc_wait0.gpio0_30, INPUT | MODE7 */
-				0x9c 0x27	/* gpmc_ben0_cle.gpio2_5, INPUT | MODE7 */
+				0x94 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_oen_ren.gpio2_3 */
+				0x90 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_advn_ale.gpio2_2 */
+				0x70 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
+				0x9c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ben0_cle.gpio2_5 */
 			>;
 		};
 
 		i2c0_pins: pinmux_i2c0_pins {
 			pinctrl-single,pins = <
-				0x188 0x30	/* i2c0_sda.i2c0_sda PULLUP | INPUTENABLE | MODE0 */
-				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
+				0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+				0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
 
 		uart0_pins: pinmux_uart0_pins {
 			pinctrl-single,pins = <
-				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
-				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+				0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+				0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart0_txd.uart0_txd */
 			>;
 		};
 
 		clkout2_pin: pinmux_clkout2_pin {
 			pinctrl-single,pins = <
-				0x1b4 0x03	/* xdma_event_intr1.clkout2 OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
+				0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)		/* xdma_event_intr1.clkout2 */
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index d62feb2..7334642 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/am33xx.h>
 
 #include "skeleton.dtsi"
 
-- 
1.7.5.4

