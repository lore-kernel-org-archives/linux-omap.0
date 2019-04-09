From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 02/15] ARM: dts: am335x: baltos-ir3220: Replaced register offsets with defines
Date: Tue,  9 Apr 2019 18:03:33 +0200
Message-ID: <20190409160346.25599-3-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-baltos-ir3220.dts | 36 +++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index 1b215c425c57..e88d9f372f74 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -23,35 +23,35 @@
 &am33xx_pinmux {
 	tca6416_pins: pinmux_tca6416_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR1, PIN_INPUT_PULLUP, MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)      /* uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE0)      /* uart1_txd */
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)      /* uart1_rtsn */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
-			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)      /* spi0_sclk.uart2_rxd_mux3 */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)      /* spi0_d0.uart2_txd_mux3 */
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE2)      /* i2c0_sda.uart2_ctsn_mux0 */
-			AM33XX_IOPAD(0x98c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)      /* i2c0_scl.uart2_rtsn_mux0 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad12.gpio1[12] DTR */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad13.gpio1[13] DSR */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad14.gpio1[14] DCD */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)     /* gpmc_ad15.gpio1[15] RI */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE1)      /* spi0_sclk.uart2_rxd_mux3 */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)      /* spi0_d0.uart2_txd_mux3 */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLDOWN, MUX_MODE2)      /* i2c0_sda.uart2_ctsn_mux0 */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_OUTPUT_PULLDOWN, MUX_MODE2)      /* i2c0_scl.uart2_rtsn_mux0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_OUTPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad12.gpio1[12] DTR */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad13.gpio1[13] DSR */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad14.gpio1[14] DCD */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLDOWN, MUX_MODE7)     /* gpmc_ad15.gpio1[15] RI */
 
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
 		>;
 	};
 };
-- 
2.20.1
