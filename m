From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 10/17] ARM: dts: am335x: pdu001: Replaced register offsets with defines
Date: Fri, 12 Apr 2019 18:26:20 +0200
Message-ID: <20190412162627.24518-11-cquast@hanoverdisplays.com>
References: <20190412162627.24518-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412162627.24518-1-cquast@hanoverdisplays.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Christina Quast <cquast@hanoverdisplays.com>, Benoit Cousson <bcousson@baylibre.com>, Mark Jackson <mpfj@newflow.co.uk>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am33xx.h

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 arch/arm/boot/dts/am335x-pdu001.dts | 170 ++++++++++++++--------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-pdu001.dts b/arch/arm/boot/dts/am335x-pdu001.dts
index ae43d61f4e8b..3141255f72c2 100644
--- a/arch/arm/boot/dts/am335x-pdu001.dts
+++ b/arch/arm/boot/dts/am335x-pdu001.dts
@@ -92,162 +92,162 @@
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_d1.i2c1_sda */
-			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_cs0.i2c1_scl */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE2)	/* spi0_d1.i2c1_sda */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE2)	/* spi0_cs0.i2c1_scl */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_clk.i2c2_sda */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_d0.i2c2_scl */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE2)	/* spi0_clk.i2c2_sda */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE2)	/* spi0_d0.i2c2_scl */
 		>;
 	};
 
 	spi1_pins: pinmux_spi1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x990, PIN_OUTPUT | MUX_MODE3)		/* mcasp0_aclkx.spi1_sclk */
-			AM33XX_IOPAD(0x994, PIN_OUTPUT | MUX_MODE3)		/* mcasp0_fsx.spi1_d0 */
-			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcasp0_axr0.spi1_d1 */
-			AM33XX_IOPAD(0x99C, PIN_OUTPUT | MUX_MODE3)		/* mcasp0_ahclkr.spi1_cs0 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKX, PIN_OUTPUT, MUX_MODE3)		/* mcasp0_aclkx.spi1_sclk */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSX, PIN_OUTPUT, MUX_MODE3)		/* mcasp0_fsx.spi1_d0 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR0, PIN_INPUT_PULLDOWN, MUX_MODE3)	/* mcasp0_axr0.spi1_d1 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKR, PIN_OUTPUT, MUX_MODE3)		/* mcasp0_ahclkr.spi1_cs0 */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x96C, PIN_OUTPUT | MUX_MODE7)		/* uart0_rtsn.gpio1_9 */
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE1)	/* spi0_cs1.uart3_rxd */
-			AM33XX_IOPAD(0x964, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* ecap0_in_pwm0_out.uart3_txd */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT_PULLUP, MUX_MODE1)	/* spi0_cs1.uart3_rxd */
+			AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* ecap0_in_pwm0_out.uart3_txd */
 		>;
 	};
 
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Port 1 (emac0) */
-			AM33XX_IOPAD(0x908, PIN_INPUT | MUX_MODE0)		/* mii1_col.mii1_col */
-			AM33XX_IOPAD(0x90C, PIN_INPUT | MUX_MODE0)		/* mii1_crs.mii1_crs */
-			AM33XX_IOPAD(0x910, PIN_INPUT | MUX_MODE0)		/* mii1_rxer.mii1_rxer */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT | MUX_MODE0)		/* mii1_txen.mii1_txen */
-			AM33XX_IOPAD(0x918, PIN_INPUT | MUX_MODE0)		/* mii1_rxdv.mii1_rxdv */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT | MUX_MODE0)		/* mii1_txd3.mii1_txd3 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT | MUX_MODE0)		/* mii1_txd2.mii1_txd2 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT | MUX_MODE0)		/* mii1_txd1.mii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT | MUX_MODE0)		/* mii1_txd0.mii1_txd0 */
-			AM33XX_IOPAD(0x92c, PIN_INPUT | MUX_MODE0)		/* mii1_txclk.mii1_txclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT | MUX_MODE0)		/* mii1_rxclk.mii1_rxclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT | MUX_MODE0)		/* mii1_rxd3.mii1_rxd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT | MUX_MODE0)		/* mii1_rxd2.mii1_rxd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT | MUX_MODE0)		/* mii1_rxd1.mii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT | MUX_MODE0)		/* mii1_rxd0.mii1_rxd0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_ER, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_DV, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT, MUX_MODE0)
 
 			/* Port 2 (emac1) */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE1)		/* mii2_txen.gpmc_a0 */
-			AM33XX_IOPAD(0x844, PIN_INPUT | MUX_MODE1)		/* mii2_rxdv.gpmc_a1 */
-			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE1)		/* mii2_txd3.gpmc_a2 */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE1)		/* mii2_txd2.gpmc_a3 */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT | MUX_MODE1)		/* mii2_txd1.gpmc_a4 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE1)		/* mii2_txd0.gpmc_a5 */
-			AM33XX_IOPAD(0x858, PIN_INPUT | MUX_MODE1)		/* mii2_txclk.gpmc_a6 */
-			AM33XX_IOPAD(0x85c, PIN_INPUT | MUX_MODE1)		/* mii2_rxclk.gpmc_a7 */
-			AM33XX_IOPAD(0x860, PIN_INPUT | MUX_MODE1)		/* mii2_rxd3.gpmc_a8 */
-			AM33XX_IOPAD(0x864, PIN_INPUT | MUX_MODE1)		/* mii2_rxd2.gpmc_a9 */
-			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE1)		/* mii2_rxd1.gpmc_a10 */
-			AM33XX_IOPAD(0x86C, PIN_INPUT | MUX_MODE1)		/* mii2_rxd0.gpmc_a11 */
-			AM33XX_IOPAD(0x870, PIN_INPUT | MUX_MODE1)		/* mii2_crs.gpmc_wait0 */
-			AM33XX_IOPAD(0x874, PIN_INPUT | MUX_MODE1)		/* mii2_rxer.gpmc_wpn */
-			AM33XX_IOPAD(0x878, PIN_INPUT | MUX_MODE1)		/* mii2_col.gpmc_ben1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_OUTPUT, MUX_MODE1)		/* mii2_txen.gpmc_a0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A1, PIN_INPUT, MUX_MODE1)		/* mii2_rxdv.gpmc_a1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A2, PIN_OUTPUT, MUX_MODE1)		/* mii2_txd3.gpmc_a2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A3, PIN_OUTPUT, MUX_MODE1)		/* mii2_txd2.gpmc_a3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_OUTPUT, MUX_MODE1)		/* mii2_txd1.gpmc_a4 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE1)		/* mii2_txd0.gpmc_a5 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_INPUT, MUX_MODE1)		/* mii2_txclk.gpmc_a6 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A7, PIN_INPUT, MUX_MODE1)		/* mii2_rxclk.gpmc_a7 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A8, PIN_INPUT, MUX_MODE1)		/* mii2_rxd3.gpmc_a8 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A9, PIN_INPUT, MUX_MODE1)		/* mii2_rxd2.gpmc_a9 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT, MUX_MODE1)		/* mii2_rxd1.gpmc_a10 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_INPUT, MUX_MODE1)		/* mii2_rxd0.gpmc_a11 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT, MUX_MODE1)		/* mii2_crs.gpmc_wait0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT, MUX_MODE1)		/* mii2_rxer.gpmc_wpn */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_INPUT, MUX_MODE1)		/* mii2_col.gpmc_ben1 */
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		/* eMMC */
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	mmc2_pins: pinmux_mmc2_pins {
 		/* SD cardcage */
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
 			/* card change signal for frontpanel SD cardcage */
-			AM33XX_IOPAD(0x890, PIN_INPUT | MUX_MODE7)		/* gpmc_advn_ale.gpio2_2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_INPUT, MUX_MODE7)		/* gpmc_advn_ale.gpio2_2 */
 		>;
 	};
 
 	lcd_pins_s0: lcd_pins_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)		/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)		/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)		/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)		/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)		/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
 	dcan0_pins: pinmux_dcan0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_OUTPUT | MUX_MODE2)		/* uart1_ctsn.d_can0_tx */
-			AM33XX_IOPAD(0x97c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* uart1_rtsn.d_can0_rx */
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_OUTPUT, MUX_MODE2)		/* uart1_ctsn.d_can0_tx */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* uart1_rtsn.d_can0_rx */
 		>;
 	};
 };
-- 
2.20.1
