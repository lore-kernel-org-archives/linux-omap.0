From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 05/17] ARM: dts: am335x: moxa-uc-8100-me-t: Replaced register offsets with defines
Date: Fri, 12 Apr 2019 18:26:15 +0200
Message-ID: <20190412162627.24518-6-cquast@hanoverdisplays.com>
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
 .../arm/boot/dts/am335x-moxa-uc-8100-me-t.dts | 116 +++++++++---------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
index 5a58efc0c874..43b5348456ea 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -104,79 +104,79 @@
 
 	minipcie_pins: pinmux_minipcie {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.gpio2_24 */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.gpio2_25 */
-			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.gpio2_22  Power off PIN*/
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_pclk.gpio2_24 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_ac_bias_en.gpio2_25 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_vsync.gpio2_22  Power off PIN*/
 		>;
 	};
 
 	push_button_pins: pinmux_push_button {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* mcasp0_ahcklx.gpio3_21 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKX, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* mcasp0_ahcklx.gpio3_21 */
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c0_scl.i2c0_scl */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart0_ctsn.i2c1_sda */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart0_rtsn.i2c1_scl */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart0_ctsn.i2c1_sda */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart0_rtsn.i2c1_scl */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart1_rtsn.uart1_rtsn */
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)    /* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT | MUX_MODE0)		/* uart1_txd.uart1_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8d8, PIN_INPUT | MUX_MODE6)		/* lcd_data14.uart5_ctsn */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT_PULLDOWN | MUX_MODE6)  /* lcd_data15.uart5_rtsn */
-			AM33XX_IOPAD(0x8c4, PIN_INPUT_PULLUP | MUX_MODE4)     /* lcd_data9.uart5_rxd */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE4)		/* lcd_data8.uart5_txd */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA14, PIN_INPUT, MUX_MODE6)		/* lcd_data14.uart5_ctsn */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA15, PIN_OUTPUT_PULLDOWN, MUX_MODE6)  /* lcd_data15.uart5_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA9, PIN_INPUT_PULLUP, MUX_MODE4)     /* lcd_data9.uart5_rxd */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE4)		/* lcd_data8.uart5_txd */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_rxerr.rmii1_rxerr */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txen.rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mii1_refclk.rmii1_refclk */
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE0)
 
 			/* Slave 2 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_crs_dv */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rxer */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_txen */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_td1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_td0 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rd0 */
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE1)  /* rmii2_refclk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLDOWN, MUX_MODE3)   /* rmii2_crs_dv */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE3)   /* rmii2_rxer */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)  /* rmii2_txen */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLDOWN, MUX_MODE3)  /* rmii2_td1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE3)  /* rmii2_td0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE3)   /* rmii2_rd1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE3)   /* rmii2_rd0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE1)  /* rmii2_refclk */
 
 		>;
 	};
@@ -184,46 +184,46 @@
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	mmc0_pins_default: pinmux_mmc0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd */
-			AM33XX_IOPAD(0x990, PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkx.gpio3_14 */
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)    /* mcasp0_aclkx.gpio3_18 */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKX, PIN_INPUT_PULLUP, MUX_MODE7)	/* mcasp0_aclkx.gpio3_14 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7)    /* mcasp0_aclkx.gpio3_18 */
 		>;
 	};
 
 	mmc2_pins_default: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
 			/* eMMC */
-			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
-			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad8.mmc2_dat4 */
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad9.mmc2_dat5 */
-			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad10.mmc2_dat6 */
-			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad11.mmc2_dat7 */
-			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_csn3.mmc2_cmd */
-			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad8.mmc2_dat4 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad9.mmc2_dat5 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad10.mmc2_dat6 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad11.mmc2_dat7 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE3)     /* gpmc_csn3.mmc2_cmd */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_clk.mmc2_clk */
 		>;
 	};
 
 	spi0_pins: pinmux_spi0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d1.spi0_d1 */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
-- 
2.20.1
