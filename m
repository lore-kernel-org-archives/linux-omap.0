From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 09/39] ARM: dts: am335x-evmsk: Use AM33XX_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:47 -0300
Message-ID: <1447390457-1158-10-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use the pinmux IOPAD macro to define the register absolute physical
address instead of the offset from the padconf base address. This
makes the DTS easier to read since matches the addresses listed in
the Technical Reference Manual.

Also, use the mux defines instead of magic numbers for the padconf
values when defining the pinctrl lines to make it more readable.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am335x-evmsk.dts | 278 ++++++++++++++++++-------------------
 1 file changed, 139 insertions(+), 139 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 89442e98a837..9609668919f1 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -204,234 +204,234 @@
 
 	lcd_pins_default: lcd_pins_default {
 		pinctrl-single,pins = <
-			0x20 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data23 */
-			0x24 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data22 */
-			0x28 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data21 */
-			0x2c (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data20 */
-			0x30 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data19 */
-			0x34 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data18 */
-			0x38 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data17 */
-			0x3c (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data16 */
-			0xa0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
-			0xa4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
-			0xa8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
-			0xac (PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
-			0xb0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
-			0xb4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
-			0xb8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
-			0xbc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
-			0xc0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
-			0xc4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
-			0xc8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
-			0xcc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
-			0xd0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
-			0xd4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
-			0xd8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
-			0xdc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
-			0xe0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
-			0xe4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
-			0xe8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
-			0xec (PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data23 */
+			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data22 */
+			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data21 */
+			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data20 */
+			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data19 */
+			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data18 */
+			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data17 */
+			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data16 */
+			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
 		>;
 	};
 
 	lcd_pins_sleep: lcd_pins_sleep {
 		pinctrl-single,pins = <
-			0x20 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad8.lcd_data23 */
-			0x24 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad9.lcd_data22 */
-			0x28 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad10.lcd_data21 */
-			0x2c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad11.lcd_data20 */
-			0x30 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad12.lcd_data19 */
-			0x34 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad13.lcd_data18 */
-			0x38 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad14.lcd_data17 */
-			0x3c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad15.lcd_data16 */
-			0xa0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data0.lcd_data0 */
-			0xa4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data1.lcd_data1 */
-			0xa8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data2.lcd_data2 */
-			0xac (PULL_DISABLE | MUX_MODE7)	/* lcd_data3.lcd_data3 */
-			0xb0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data4.lcd_data4 */
-			0xb4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data5.lcd_data5 */
-			0xb8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data6.lcd_data6 */
-			0xbc (PULL_DISABLE | MUX_MODE7)	/* lcd_data7.lcd_data7 */
-			0xc0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data8.lcd_data8 */
-			0xc4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data9.lcd_data9 */
-			0xc8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data10.lcd_data10 */
-			0xcc (PULL_DISABLE | MUX_MODE7)	/* lcd_data11.lcd_data11 */
-			0xd0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data12.lcd_data12 */
-			0xd4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data13.lcd_data13 */
-			0xd8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data14.lcd_data14 */
-			0xdc (PULL_DISABLE | MUX_MODE7)	/* lcd_data15.lcd_data15 */
-			0xe0 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.lcd_vsync */
-			0xe4 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.lcd_hsync */
-			0xe8 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.lcd_pclk */
-			0xec (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(0x820, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad8.lcd_data23 */
+			AM33XX_IOPAD(0x824, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad9.lcd_data22 */
+			AM33XX_IOPAD(0x828, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad10.lcd_data21 */
+			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad11.lcd_data20 */
+			AM33XX_IOPAD(0x830, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad12.lcd_data19 */
+			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad13.lcd_data18 */
+			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad14.lcd_data17 */
+			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad15.lcd_data16 */
+			AM33XX_IOPAD(0x8a0, PULL_DISABLE | MUX_MODE7)	/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(0x8a4, PULL_DISABLE | MUX_MODE7)	/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(0x8a8, PULL_DISABLE | MUX_MODE7)	/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(0x8ac, PULL_DISABLE | MUX_MODE7)	/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(0x8b0, PULL_DISABLE | MUX_MODE7)	/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(0x8b4, PULL_DISABLE | MUX_MODE7)	/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(0x8b8, PULL_DISABLE | MUX_MODE7)	/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(0x8bc, PULL_DISABLE | MUX_MODE7)	/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(0x8c0, PULL_DISABLE | MUX_MODE7)	/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(0x8c4, PULL_DISABLE | MUX_MODE7)	/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(0x8c8, PULL_DISABLE | MUX_MODE7)	/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(0x8cc, PULL_DISABLE | MUX_MODE7)	/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(0x8d0, PULL_DISABLE | MUX_MODE7)	/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(0x8d4, PULL_DISABLE | MUX_MODE7)	/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(0x8d8, PULL_DISABLE | MUX_MODE7)	/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(0x8dc, PULL_DISABLE | MUX_MODE7)	/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.lcd_ac_bias_en */
 		>;
 	};
 
 
 	user_leds_s0: user_leds_s0 {
 		pinctrl-single,pins = <
-			0x10 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
-			0x14 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad5.gpio1_5 */
-			0x18 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad6.gpio1_6 */
-			0x1c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad7.gpio1_7 */
+			AM33XX_IOPAD(0x810, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
+			AM33XX_IOPAD(0x814, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad5.gpio1_5 */
+			AM33XX_IOPAD(0x818, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad6.gpio1_6 */
+			AM33XX_IOPAD(0x81c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad7.gpio1_7 */
 		>;
 	};
 
 	gpio_keys_s0: gpio_keys_s0 {
 		pinctrl-single,pins = <
-			0x94 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_oen_ren.gpio2_3 */
-			0x90 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_advn_ale.gpio2_2 */
-			0x70 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
-			0x9c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ben0_cle.gpio2_5 */
+			AM33XX_IOPAD(0x894, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_oen_ren.gpio2_3 */
+			AM33XX_IOPAD(0x890, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_advn_ale.gpio2_2 */
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
+			AM33XX_IOPAD(0x89c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ben0_cle.gpio2_5 */
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
-			0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)		/* xdma_event_intr1.clkout2 */
+			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 		>;
 	};
 
 	ecap2_pins: backlight_pins {
 		pinctrl-single,pins = <
-			0x19c 0x4	/* mcasp0_ahclkr.ecap2_in_pwm2_out MODE4 */
+			AM33XX_IOPAD(0x99c, MUX_MODE4)	/* mcasp0_ahclkr.ecap2_in_pwm2_out */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
-			0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
-			0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			0x12c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
-			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
-			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
-			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
-			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
-			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
+			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
+			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
+			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
+			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
 
 			/* Slave 2 */
-			0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
-			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
-			0x48 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
-			0x4c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
-			0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
-			0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
-			0x58 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
-			0x5c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
-			0x60 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
-			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
-			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
-			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
+			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
+			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
+			AM33XX_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
+			AM33XX_IOPAD(0x84c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
+			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
+			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
+			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
+			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
+			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
 
 			/* Slave 2 reset value*/
-			0x40 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x48 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x4c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x50 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x54 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x5c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x60 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x840, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x848, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x850, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x854, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 		>;
 	};
 
 	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
-			0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
-			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
+			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
 		>;
 	};
 
 	mcasp1_pins_sleep: mcasp1_pins_sleep {
 		pinctrl-single,pins = <
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x108 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			0x74 (PIN_INPUT_PULLUP | MUX_MODE7) /* gpmc_wpn.gpio0_31 */
-			0x80 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			0x84 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
-			0x00 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			0x04 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			0x08 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			0x0c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7) /* gpmc_wpn.gpio0_31 */
+			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
 		>;
 	};
 
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			0x7c (PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpmc_csn0.gpio1_29 */
+			AM33XX_IOPAD(0x87c, PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpmc_csn0.gpio1_29 */
 		>;
 	};
 };
-- 
2.4.3
