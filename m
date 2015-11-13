From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 08/39] ARM: dts: am335x-evm: Use AM33XX_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:46 -0300
Message-ID: <1447390457-1158-9-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am335x-evm.dts | 220 +++++++++++++++++++--------------------
 1 file changed, 110 insertions(+), 110 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d9d00ab863a2..4caf074063fe 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -168,215 +168,215 @@
 
 	matrix_keypad_s0: matrix_keypad_s0 {
 		pinctrl-single,pins = <
-			0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
-			0x58 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
-			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a9.gpio1_25 */
-			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
-			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a9.gpio1_25 */
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
 		>;
 	};
 
 	volume_keys_s0: volume_keys_s0 {
 		pinctrl-single,pins = <
-			0x150 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* spi0_sclk.gpio0_2 */
-			0x154 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* spi0_d0.gpio0_3 */
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* spi0_sclk.gpio0_2 */
+			AM33XX_IOPAD(0x954, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* spi0_d0.gpio0_3 */
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
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			0x158 (PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_d1.i2c1_sda */
-			0x15c (PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_cs0.i2c1_scl */
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_d1.i2c1_sda */
+			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_cs0.i2c1_scl */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			0x178 (PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
-			0x17C (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
-			0x180 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			0x184 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
 		>;
 	};
 
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
-			0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
+			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 		>;
 	};
 
 	nandflash_pins_s0: nandflash_pins_s0 {
 		pinctrl-single,pins = <
-			0x0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			0x4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			0x8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			0xc (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			0x10 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			0x14 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			0x18 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			0x1c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			0x74 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
-			0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
-			0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
+			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 		>;
 	};
 
 	ecap0_pins: backlight_pins {
 		pinctrl-single,pins = <
-			0x164 0x0	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
+			AM33XX_IOPAD(0x964, MUX_MODE0)	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out */
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
 
 	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			0x44 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a1.mmc2_dat0, INPUT_PULLUP | MODE3 */
-			0x48 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a2.mmc2_dat1, INPUT_PULLUP | MODE3 */
-			0x4C (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a3.mmc2_dat2, INPUT_PULLUP | MODE3 */
-			0x78 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ben1.mmc2_dat3, INPUT_PULLUP | MODE3 */
-			0x88 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd, INPUT_PULLUP | MODE3 */
-			0x8C (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a1.mmc2_dat0, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(0x848, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a2.mmc2_dat1, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a3.mmc2_dat2, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ben1.mmc2_dat3, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk, INPUT_PULLUP | MODE3 */
 		>;
 	};
 
 	wlan_pins: pinmux_wlan_pins {
 		pinctrl-single,pins = <
-			0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a0.gpio1_16 */
-			0x19C (PIN_INPUT | MUX_MODE7)		/* mcasp0_ahclkr.gpio3_17 */
-			0x1AC (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mcasp0_ahclkx.gpio3_21 */
+			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a0.gpio1_16 */
+			AM33XX_IOPAD(0x99c, PIN_INPUT | MUX_MODE7)		/* mcasp0_ahclkr.gpio3_17 */
+			AM33XX_IOPAD(0x9ac, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mcasp0_ahclkx.gpio3_21 */
 		>;
 	};
 
 	lcd_pins_s0: lcd_pins_s0 {
 		pinctrl-single,pins = <
-			0x20 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad8.lcd_data23 */
-			0x24 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad9.lcd_data22 */
-			0x28 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad10.lcd_data21 */
-			0x2c (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad11.lcd_data20 */
-			0x30 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad12.lcd_data19 */
-			0x34 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad13.lcd_data18 */
-			0x38 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad14.lcd_data17 */
-			0x3c (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad15.lcd_data16 */
-			0xa0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data0.lcd_data0 */
-			0xa4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data1.lcd_data1 */
-			0xa8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data2.lcd_data2 */
-			0xac (PIN_OUTPUT | MUX_MODE0)		/* lcd_data3.lcd_data3 */
-			0xb0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data4.lcd_data4 */
-			0xb4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data5.lcd_data5 */
-			0xb8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data6.lcd_data6 */
-			0xbc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data7.lcd_data7 */
-			0xc0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data8.lcd_data8 */
-			0xc4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data9.lcd_data9 */
-			0xc8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data10.lcd_data10 */
-			0xcc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data11.lcd_data11 */
-			0xd0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data12.lcd_data12 */
-			0xd4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data13.lcd_data13 */
-			0xd8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data14.lcd_data14 */
-			0xdc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data15.lcd_data15 */
-			0xe0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_vsync.lcd_vsync */
-			0xe4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_hsync.lcd_hsync */
-			0xe8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_pclk.lcd_pclk */
-			0xec (PIN_OUTPUT | MUX_MODE0)		/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad8.lcd_data23 */
+			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad9.lcd_data22 */
+			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad10.lcd_data21 */
+			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad11.lcd_data20 */
+			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad12.lcd_data19 */
+			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad13.lcd_data18 */
+			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad14.lcd_data17 */
+			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad15.lcd_data16 */
+			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)		/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)		/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)		/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)		/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)		/* lcd_ac_bias_en.lcd_ac_bias_en */
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
 
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
-			0x168 (PIN_OUTPUT | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
-			0x16c (PIN_INPUT_PULLDOWN | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
+			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLDOWN | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
 		>;
 	};
 };
-- 
2.4.3
