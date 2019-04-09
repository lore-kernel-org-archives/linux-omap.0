From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 08/15] ARM: dts: am335x: boneblue: Replaced register offsets with defines
Date: Tue,  9 Apr 2019 18:03:39 +0200
Message-ID: <20190409160346.25599-9-cquast@hanoverdisplays.com>
References: <20190409160346.25599-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409160346.25599-1-cquast@hanoverdisplays.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: Christina Quast <cquast@hanoverdisplays.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am33xx.h

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 arch/arm/boot/dts/am335x-boneblue.dts | 104 +++++++++++++-------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index ccb147e70d17..8d241c856c8d 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -130,135 +130,135 @@
 &am33xx_pinmux {
 	user_leds_s0: user_leds_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7) /* (V15) gpmc_a5.gpio1[21] - USR_LED_0 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT | MUX_MODE7) /* (U15) gpmc_a6.gpio1[22] - USR_LED_1 */
-			AM33XX_IOPAD(0x85c, PIN_OUTPUT | MUX_MODE7) /* (T15) gpmc_a7.gpio1[23] - USR_LED_2 */
-			AM33XX_IOPAD(0x860, PIN_OUTPUT | MUX_MODE7) /* (V16) gpmc_a8.gpio1[24] - USR_LED_3 */
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] - WIFI_LED */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE7) /* (R7) gpmc_advn_ale.gpio2[2] - P8.7, LED_RED, GP1_PIN_5 */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE7) /* (T7) gpmc_oen_ren.gpio2[3] - P8.8, LED_GREEN, GP1_PIN_6 */
-			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE7) /* (U12) gpmc_ad11.gpio0[27] - P8.17, BATT_LED_1 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE7) /* (T5) lcd_data15.gpio0[11] - P8.32, BATT_LED_2 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE7) /* (V6) gpmc_csn0.gpio1[29] - P8.26, BATT_LED_3 */
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE7) /* (T11) gpmc_ad10.gpio0[26] - P8.14, BATT_LED_4 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE7) /* (V15) gpmc_a5.gpio1[21] - USR_LED_0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_OUTPUT, MUX_MODE7) /* (U15) gpmc_a6.gpio1[22] - USR_LED_1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A7, PIN_OUTPUT, MUX_MODE7) /* (T15) gpmc_a7.gpio1[23] - USR_LED_2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A8, PIN_OUTPUT, MUX_MODE7) /* (V16) gpmc_a8.gpio1[24] - USR_LED_3 */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT, MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] - WIFI_LED */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE7) /* (R7) gpmc_advn_ale.gpio2[2] - P8.7, LED_RED, GP1_PIN_5 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE7) /* (T7) gpmc_oen_ren.gpio2[3] - P8.8, LED_GREEN, GP1_PIN_6 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_OUTPUT, MUX_MODE7) /* (U12) gpmc_ad11.gpio0[27] - P8.17, BATT_LED_1 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE7) /* (T5) lcd_data15.gpio0[11] - P8.32, BATT_LED_2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE7) /* (V6) gpmc_csn0.gpio1[29] - P8.26, BATT_LED_3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE7) /* (T11) gpmc_ad10.gpio0[26] - P8.14, BATT_LED_4 */
 
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C17) I2C0_SDA.I2C0_SDA */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C16) I2C0_SCL.I2C0_SCL */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* (C17) I2C0_SDA.I2C0_SDA */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* (C16) I2C0_SCL.I2C0_SCL */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE3)	/* (D18) uart1_ctsn.I2C2_SDA */
-			AM33XX_IOPAD(0x97c, PIN_INPUT_PULLUP | MUX_MODE3)	/* (D17) uart1_rtsn.I2C2_SCL */
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* (D18) uart1_ctsn.I2C2_SDA */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* (D17) uart1_rtsn.I2C2_SCL */
 		>;
 	};
 
 	/* UT0 */
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* (E15) uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* (E16) uart0_txd.uart0_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	/* UT1 */
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* (D16) uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* (D15) uart1_txd.uart1_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	/* GPS */
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE1)	/* (A17) spi0_sclk.uart2_rxd */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* (B17) spi0_d0.uart2_txd */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE1)	/* (A17) spi0_sclk.uart2_rxd */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* (B17) spi0_d0.uart2_txd */
 		>;
 	};
 
 	/* DSM2 */
 	uart4_pins: pinmux_uart4_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE6)	/* (T17) gpmc_wait0.uart4_rxd */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE6)	/* (T17) gpmc_wait0.uart4_rxd */
 		>;
 	};
 
 	/* UT5 */
 	uart5_pins: pinmux_uart5_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8C4, PIN_INPUT_PULLUP | MUX_MODE4)	/* (U2) lcd_data9.uart5_rxd */
-			AM33XX_IOPAD(0x8C0, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* (U1) lcd_data8.uart5_txd */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA9, PIN_INPUT_PULLUP, MUX_MODE4)	/* (U2) lcd_data9.uart5_rxd */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA8, PIN_OUTPUT_PULLDOWN, MUX_MODE4)	/* (U1) lcd_data8.uart5_txd */
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* (C15) spi0_cs1.gpio0[6] */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7)		/* (C15) spi0_cs1.gpio0[6] */
 		>;
 	};
 
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* (U9) gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* (V9) gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* (U7) gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* (V7) gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* (R8) gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* (T8) gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* (U8) gpmc_ad4.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)	/* (V8) gpmc_ad5.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* (R9) gpmc_ad6.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* (T9) gpmc_ad7.mmc1_dat7 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)	/* (U9) gpmc_csn1.mmc1_clk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)	/* (V9) gpmc_csn2.mmc1_cmd */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* (U7) gpmc_ad0.mmc1_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* (V7) gpmc_ad1.mmc1_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1)	/* (R8) gpmc_ad2.mmc1_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* (T8) gpmc_ad3.mmc1_dat3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1)	/* (U8) gpmc_ad4.mmc1_dat4 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1)	/* (V8) gpmc_ad5.mmc1_dat5 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1)	/* (R9) gpmc_ad6.mmc1_dat6 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1)	/* (T9) gpmc_ad7.mmc1_dat7 */
 		>;
 	};
 
 	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE6)	/* (L15) gmii1_rxd1.mmc2_clk */
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLUP | MUX_MODE6)	/* (J16) gmii1_txen.mmc2_cmd */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLUP | MUX_MODE5)	/* (J17) gmii1_rxdv.mmc2_dat0 */
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLUP | MUX_MODE5)	/* (J18) gmii1_txd3.mmc2_dat1 */
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLUP | MUX_MODE5)	/* (K15) gmii1_txd2.mmc2_dat2 */
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLUP | MUX_MODE5)	/* (H16) gmii1_col.mmc2_dat3 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE6)	/* (L15) gmii1_rxd1.mmc2_clk */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLUP, MUX_MODE6)	/* (J16) gmii1_txen.mmc2_cmd */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLUP, MUX_MODE5)	/* (J17) gmii1_rxdv.mmc2_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLUP, MUX_MODE5)	/* (J18) gmii1_txd3.mmc2_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLUP, MUX_MODE5)	/* (K15) gmii1_txd2.mmc2_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_INPUT_PULLUP, MUX_MODE5)	/* (H16) gmii1_col.mmc2_dat3 */
 		>;
 	};
 
 	bt_pins: pinmux_bt_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* (K17) gmii1_txd0.gpio0[28] - BT_EN */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* (K17) gmii1_txd0.gpio0[28] - BT_EN */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)	/* (L17) gmii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* (L16) gmii1_rxd2.uart3_txd */
-			AM33XX_IOPAD(0x948, PIN_INPUT | MUX_MODE3)		/* (M17) mdio_data.uart3_ctsn */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* (M18) mdio_clk.uart3_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* (L17) gmii1_rxd3.uart3_rxd */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* (L16) gmii1_rxd2.uart3_txd */
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT, MUX_MODE3)		/* (M17) mdio_data.uart3_ctsn */
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* (M18) mdio_clk.uart3_rtsn */
 		>;
 	};
 
 	wl18xx_pins: pinmux_wl18xx_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* (K18) gmii1_txclk.gpio3[9] - WL_EN */
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* (K16) gmii1_txd1.gpio0[21] - WL_IRQ */
-			AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* (L18) gmii1_rxclk.gpio3[10] - LS_BUF_EN */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* (K18) gmii1_txclk.gpio3[9] - WL_EN */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* (K16) gmii1_txd1.gpio0[21] - WL_IRQ */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* (L18) gmii1_rxclk.gpio3[10] - LS_BUF_EN */
 		>;
 	};
 
 	/* DCAN */
 	dcan1_pins: pinmux_dcan1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x96c, PIN_INPUT | MUX_MODE2)		/* (E17) uart0_rtsn.dcan1_rx */
-			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2)		/* (E18) uart0_ctsn.dcan1_tx */
-			AM33XX_IOPAD(0x940, PIN_OUTPUT | MUX_MODE7)		/* (M16) gmii1_rxd0.gpio2[21] */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_INPUT, MUX_MODE2)		/* (E17) uart0_rtsn.dcan1_rx */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_OUTPUT, MUX_MODE2)		/* (E18) uart0_ctsn.dcan1_tx */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_OUTPUT, MUX_MODE7)		/* (M16) gmii1_rxd0.gpio2[21] */
 		>;
 	};
 };
-- 
2.20.1
