From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 06/17] ARM: dts: am335x: nano: Replaced register offsets with defines
Date: Fri, 12 Apr 2019 18:26:16 +0200
Message-ID: <20190412162627.24518-7-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-nano.dts | 132 +++++++++++++++---------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 9c9143ed4003..0052657331ee 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -41,121 +41,121 @@
 
 	misc_pins: misc_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x95c, PIN_OUTPUT | MUX_MODE7)	/* spi0_cs0.gpio0_5 */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS0, PIN_OUTPUT, MUX_MODE7)	/* spi0_cs0.gpio0_5 */
 		>;
 	};
 
 	gpmc_pins: gpmc_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad8.gpmc_ad8 */
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad9.gpmc_ad9 */
-			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad10.gpmc_ad10 */
-			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad11.gpmc_ad11 */
-			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad12.gpmc_ad12 */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad13.gpmc_ad13 */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad14.gpmc_ad14 */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad15.gpmc_ad15 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE0)
 
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
-			AM33XX_IOPAD(0x880, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn1.gpmc_csn1 */
-			AM33XX_IOPAD(0x884, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn2.gpmc_csn2 */
-			AM33XX_IOPAD(0x888, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn3.gpmc_csn3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN1, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN2, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_OUTPUT, MUX_MODE0)
 
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_ben0_cle.gpmc_ben0_cle */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE0)
 
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE1)		/* lcd_data1.gpmc_a1 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE1)		/* lcd_data2.gpmc_a2 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE1)		/* lcd_data3.gpmc_a3 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE1)		/* lcd_data4.gpmc_a4 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE1)		/* lcd_data5.gpmc_a5 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE1)		/* lcd_data6.gpmc_a6 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE1)		/* lcd_data7.gpmc_a7 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE1)		/* lcd_data1.gpmc_a1 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE1)		/* lcd_data2.gpmc_a2 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE1)		/* lcd_data3.gpmc_a3 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE1)		/* lcd_data4.gpmc_a4 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE1)		/* lcd_data5.gpmc_a5 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE1)		/* lcd_data6.gpmc_a6 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE1)		/* lcd_data7.gpmc_a7 */
 
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE1)		/* lcd_vsync.gpmc_a8 */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE1)		/* lcd_hsync.gpmc_a9 */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE1)		/* lcd_pclk.gpmc_a10 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE1)		/* lcd_vsync.gpmc_a8 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE1)		/* lcd_hsync.gpmc_a9 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE1)		/* lcd_pclk.gpmc_a10 */
 		>;
 	};
 
 	i2c0_pins: i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	uart0_pins: uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT | MUX_MODE0)		/* uart0_txd.uart0_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
 	uart1_pins: uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_OUTPUT | MUX_MODE7)		/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT | MUX_MODE7)		/* uart1_rtsn.uart1_rtsn */
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT | MUX_MODE0)		/* uart1_txd.uart1_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
 	uart2_pins: uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8c0, PIN_INPUT_PULLUP | MUX_MODE7)	/* lcd_data8.gpio2[14] */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE7)		/* lcd_data9.gpio2[15] */
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)		/* spi0_sclk.uart2_rxd */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)		/* spi0_d0.uart2_txd */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA8, PIN_INPUT_PULLUP, MUX_MODE7)	/* lcd_data8.gpio2[14] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE7)		/* lcd_data9.gpio2[15] */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE1)		/* spi0_sclk.uart2_rxd */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)		/* spi0_d0.uart2_txd */
 		>;
 	};
 
 	uart3_pins: uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8c8, PIN_INPUT_PULLUP | MUX_MODE6)	/* lcd_data10.uart3_ctsn */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE6)		/* lcd_data11.uart3_rtsn */
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE1)		/* spi0_cs1.uart3_rxd */
-			AM33XX_IOPAD(0x964, PIN_OUTPUT | MUX_MODE1)		/* ecap0_in_pwm0_out.uart3_txd */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PIN_INPUT_PULLUP, MUX_MODE6)	/* lcd_data10.uart3_ctsn */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE6)		/* lcd_data11.uart3_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE1)		/* spi0_cs1.uart3_rxd */
+			AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_OUTPUT, MUX_MODE1)		/* ecap0_in_pwm0_out.uart3_txd */
 		>;
 	};
 
 	uart4_pins: uart4_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8d0, PIN_INPUT_PULLUP | MUX_MODE6)	/* lcd_data12.uart4_ctsn */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE6)		/* lcd_data13.uart4_rtsn */
-			AM33XX_IOPAD(0x968, PIN_INPUT | MUX_MODE1)		/* uart0_ctsn.uart4_rxd */
-			AM33XX_IOPAD(0x96c, PIN_OUTPUT | MUX_MODE1)		/* uart0_rtsn.uart4_txd */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_INPUT_PULLUP, MUX_MODE6)	/* lcd_data12.uart4_ctsn */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE6)		/* lcd_data13.uart4_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT, MUX_MODE1)		/* uart0_ctsn.uart4_rxd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_OUTPUT, MUX_MODE1)		/* uart0_rtsn.uart4_txd */
 		>;
 	};
 
 	uart5_pins: uart5_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8d8, PIN_INPUT | MUX_MODE4)		/* lcd_data14.uart5_rxd */
-			AM33XX_IOPAD(0x944, PIN_OUTPUT | MUX_MODE3)		/* rmiii1_refclk.uart5_txd */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA14, PIN_INPUT, MUX_MODE4)		/* lcd_data14.uart5_rxd */
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_OUTPUT, MUX_MODE3)		/* rmiii1_refclk.uart5_txd */
 		>;
 	};
 
 	mmc1_pins: mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x9e8, PIN_INPUT_PULLUP | MUX_MODE7)	/* emu1.gpio3[8] */
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkr.gpio3[18] */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_PADCONF(AM335X_PIN_EMU1, PIN_INPUT_PULLUP, MUX_MODE7)	/* emu1.gpio3[8] */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7)	/* mcasp0_aclkr.gpio3[18] */
 		>;
 	};
 };
-- 
2.20.1
