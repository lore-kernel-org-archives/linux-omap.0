From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 2/2] ARM: dts: am335x: Replaced register offsets with defines
Date: Wed, 13 Mar 2019 15:27:24 +0100
Message-ID: <20190313142724.27446-3-cquast@hanoverdisplays.com>
References: <20190313142724.27446-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313142724.27446-1-cquast@hanoverdisplays.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, mpfj@newflow.co.uk, cquast@hanoverdisplays.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am335x.h

Updated AM33XX_IOPAD to take three instead of two parameters:
AM33XX_IOPAD(register_offset, pin_direction_pullups, mux_mode)

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 arch/arm/boot/dts/am335x-baltos-ir2110.dts    |  16 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts    |  36 +--
 arch/arm/boot/dts/am335x-baltos-ir5221.dts    |  40 +--
 arch/arm/boot/dts/am335x-baltos-leds.dtsi     |   6 +-
 arch/arm/boot/dts/am335x-baltos.dtsi          | 140 ++++-----
 arch/arm/boot/dts/am335x-base0033.dts         |  48 +--
 arch/arm/boot/dts/am335x-bone-common.dtsi     | 116 +++----
 .../arm/boot/dts/am335x-boneblack-common.dtsi |  54 ++--
 .../boot/dts/am335x-boneblack-wireless.dts    |  28 +-
 arch/arm/boot/dts/am335x-boneblue.dts         | 104 +++----
 .../arm/boot/dts/am335x-bonegreen-common.dtsi |   4 +-
 .../boot/dts/am335x-bonegreen-wireless.dts    |  28 +-
 arch/arm/boot/dts/am335x-chiliboard.dts       |  66 ++--
 arch/arm/boot/dts/am335x-chilisom.dtsi        |  32 +-
 arch/arm/boot/dts/am335x-cm-t335.dts          | 154 ++++-----
 arch/arm/boot/dts/am335x-evm.dts              | 234 +++++++-------
 arch/arm/boot/dts/am335x-evmsk.dts            | 292 +++++++++---------
 arch/arm/boot/dts/am335x-icev2.dts            | 116 +++----
 arch/arm/boot/dts/am335x-igep0033.dtsi        |  40 +--
 arch/arm/boot/dts/am335x-lxm.dts              | 120 +++----
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi  |  42 +--
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts     |  24 +-
 .../arm/boot/dts/am335x-moxa-uc-8100-me-t.dts | 116 +++----
 arch/arm/boot/dts/am335x-nano.dts             | 132 ++++----
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts   | 168 +++++-----
 arch/arm/boot/dts/am335x-osd335x-common.dtsi  |   4 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi         |  74 ++---
 arch/arm/boot/dts/am335x-pdu001.dts           | 170 +++++-----
 arch/arm/boot/dts/am335x-pepper.dts           | 200 ++++++------
 arch/arm/boot/dts/am335x-phycore-som.dtsi     |  60 ++--
 arch/arm/boot/dts/am335x-pocketbeagle.dts     |  56 ++--
 arch/arm/boot/dts/am335x-sancloud-bbe.dts     |  62 ++--
 arch/arm/boot/dts/am335x-sbc-t335.dts         | 112 +++----
 arch/arm/boot/dts/am335x-shc.dts              | 224 +++++++-------
 arch/arm/boot/dts/am335x-sl50.dts             | 208 ++++++-------
 arch/arm/boot/dts/am335x-wega.dtsi            |  68 ++--
 arch/arm/boot/dts/am33xx.dtsi                 |   1 +
 include/dt-bindings/pinctrl/omap.h            |   2 +-
 38 files changed, 1699 insertions(+), 1698 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
index 75de1e723303..b459cda6cee2 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir2110.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
@@ -23,14 +23,14 @@
 &am33xx_pinmux {
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
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)      /* uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE0)      /* uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE0)      /* uart1_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)      /* uart1_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index 1b215c425c57..d3771b495406 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -23,35 +23,35 @@
 &am33xx_pinmux {
 	tca6416_pins: pinmux_tca6416_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_INPUT_PULLUP, MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
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
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)      /* uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE0)      /* uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE0)      /* uart1_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)      /* uart1_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
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
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE1)      /* spi0_sclk.uart2_rxd_mux3 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)      /* spi0_d0.uart2_txd_mux3 */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLDOWN, MUX_MODE2)      /* i2c0_sda.uart2_ctsn_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_OUTPUT_PULLDOWN, MUX_MODE2)      /* i2c0_scl.uart2_rtsn_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_OUTPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad12.gpio1[12] DTR */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad13.gpio1[13] DSR */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad14.gpio1[14] DCD */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLDOWN, MUX_MODE7)     /* gpmc_ad15.gpio1[15] RI */
 
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 832ead864dc5..19e377442685 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -23,43 +23,43 @@
 &am33xx_pinmux {
 	tca6416_pins: pinmux_tca6416_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_INPUT_PULLUP, MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
 		>;
 	};
 
 
 	dcan1_pins: pinmux_dcan1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2)      /* uart0_ctsn.dcan1_tx_mux0 */
-			AM33XX_IOPAD(0x96c, PIN_INPUT | MUX_MODE2)      /* uart0_rtsn.dcan1_rx_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_OUTPUT, MUX_MODE2)      /* uart0_ctsn.dcan1_tx_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_INPUT, MUX_MODE2)      /* uart0_rtsn.dcan1_rx_mux0 */
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
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)      /* uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE0)      /* uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE0)      /* uart1_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)      /* uart1_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
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
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE1)      /* spi0_sclk.uart2_rxd_mux3 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)      /* spi0_d0.uart2_txd_mux3 */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLDOWN, MUX_MODE2)      /* i2c0_sda.uart2_ctsn_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_OUTPUT_PULLDOWN, MUX_MODE2)      /* i2c0_scl.uart2_rtsn_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_OUTPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad12.gpio1[12] DTR */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad13.gpio1[13] DSR */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad14.gpio1[14] DCD */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLDOWN, MUX_MODE7)     /* gpmc_ad15.gpio1[15] RI */
 
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am335x-baltos-leds.dtsi b/arch/arm/boot/dts/am335x-baltos-leds.dtsi
index 3ab1767d5c13..dbc7fa609458 100644
--- a/arch/arm/boot/dts/am335x-baltos-leds.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos-leds.dtsi
@@ -42,9 +42,9 @@
 &am33xx_pinmux {
 	user_leds: pinmux_user_leds {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_col.gpio3_0 PWR LED */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd3.gpio0_16 WLAN LED */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd2.gpio0_17 APP LED */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* mii1_col.gpio3_0 PWR LED */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* mii1_txd3.gpio0_16 WLAN LED */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* mii1_txd2.gpio0_17 APP LED */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index 8c6fc4161ad7..3fbb433772f8 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -53,130 +53,130 @@
 &am33xx_pinmux {
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad8.mmc1_dat0_mux0 */
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad9.mmc1_dat1_mux0 */
-			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad10.mmc1_dat2_mux0 */
-			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad11.mmc1_dat3_mux0 */
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_csn1.mmc1_clk_mux0 */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_csn2.mmc1_cmd_mux0 */
-			AM33XX_IOPAD(0x9e4, PIN_INPUT_PULLUP | MUX_MODE7)      /* emu0.gpio3[7] */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_ad8.mmc1_dat0_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_ad9.mmc1_dat1_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_ad10.mmc1_dat2_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_ad11.mmc1_dat3_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_csn1.mmc1_clk_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_csn2.mmc1_cmd_mux0 */
+			AM33XX_IOPAD(AM335X_PIN_EMU0, PIN_INPUT_PULLUP, MUX_MODE7)      /* emu0.gpio3[7] */
 		>;
 	};
 
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9e8, PIN_OUTPUT_PULLUP | MUX_MODE7)      /* emu1.gpio3[8] */
+			AM33XX_IOPAD(AM335X_PIN_EMU1, PIN_OUTPUT_PULLUP, MUX_MODE7)      /* emu1.gpio3[8] */
 		>;
 	};
 
 	tps65910_pins: pinmux_tps65910_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE7)      /* gpmc_ben1.gpio1[28] */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLUP, MUX_MODE7)      /* gpmc_ben1.gpio1[28] */
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x958, PIN_INPUT | MUX_MODE2)      /* spi0_d1.i2c1_sda_mux3 */
-			AM33XX_IOPAD(0x95c, PIN_INPUT | MUX_MODE2)      /* spi0_cs0.i2c1_scl_mux3 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT, MUX_MODE2)      /* spi0_d1.i2c1_sda_mux3 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS0, PIN_INPUT, MUX_MODE2)      /* spi0_cs0.i2c1_scl_mux3 */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)		/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)       /* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_tx_en.rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)      /* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)      /* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* rmii1_ref_clk.rmii1_refclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE1)       /* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE1)      /* mii1_tx_en.rmii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE1)      /* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)      /* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE1)      /* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE1)      /* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE0)      /* rmii1_ref_clk.rmii1_refclk */
 
 
 			/* Slave 2 */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
-			AM33XX_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
 
 			/* Slave 2 reset value*/
-			AM33XX_IOPAD(0x840, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x848, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x850, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x854, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	nandflash_pins_s0: nandflash_pins_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLUP, MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
index 29782be07605..5e2e1d7c9d84 100644
--- a/arch/arm/boot/dts/am335x-base0033.dts
+++ b/arch/arm/boot/dts/am335x-base0033.dts
@@ -46,39 +46,39 @@
 &am33xx_pinmux {
 	nxp_hdmi_pins: pinmux_nxp_hdmi_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE3)	/* xdma_event_intr0.clkout1 */
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15 */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT, MUX_MODE3)	/* xdma_event_intr0.clkout1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)	/* lcd_data0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)	/* lcd_data1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)	/* lcd_data2 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)	/* lcd_data3 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)	/* lcd_data4 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)	/* lcd_data5 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)	/* lcd_data6 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)	/* lcd_data7 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)	/* lcd_data8 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)	/* lcd_data9 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)	/* lcd_data10 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)	/* lcd_data11 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)	/* lcd_data12 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)	/* lcd_data13 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)	/* lcd_data14 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)	/* lcd_data15 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE0)	/* lcd_vsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE0)	/* lcd_hsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE0)	/* lcd_pclk */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE0)	/* lcd_ac_bias_en */
 		>;
 	};
 	nxp_hdmi_off_pins: pinmux_nxp_hdmi_off_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE3)	/* xdma_event_intr0.clkout1 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT, MUX_MODE3)	/* xdma_event_intr0.clkout1 */
 		>;
 	};
 
 	leds_base_pins: pinmux_leds_base_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
-			AM33XX_IOPAD(0x888, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN3, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 456eef57ef89..cacb013293e7 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -71,118 +71,118 @@
 
 	user_leds_s0: user_leds_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
-			AM33XX_IOPAD(0x85c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a7.gpio1_23 */
-			AM33XX_IOPAD(0x860, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a7.gpio1_23 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_a8.gpio1_24 */
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
-			AM33XX_IOPAD(0x97c, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxerr.mii1_rxerr */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txen.mii1_txen */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxdv.mii1_rxdv */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd3.mii1_txd3 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd2.mii1_txd2 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd1.mii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd0.mii1_txd0 */
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_txclk.mii1_txclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxclk.mii1_rxclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd3.mii1_rxd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd2.mii1_rxd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd1.mii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd0.mii1_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxerr.mii1_rxerr */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* mii1_txen.mii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxdv.mii1_rxdv */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* mii1_txd3.mii1_txd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* mii1_txd2.mii1_txd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* mii1_txd1.mii1_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* mii1_txd0.mii1_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_txclk.mii1_txclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxclk.mii1_rxclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxd3.mii1_rxd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxd2.mii1_rxd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxd1.mii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxd0.mii1_rxd0 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* spio0_cs1.gpio0_6 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7)		/* spio0_cs1.gpio0_6 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk.mmc0_clk */
 		>;
 	};
 
 	emmc_pins: pinmux_emmc_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2) /* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-boneblack-common.dtsi b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
index e543c2bee8c2..da9cdc549c27 100644
--- a/arch/arm/boot/dts/am335x-boneblack-common.dtsi
+++ b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
@@ -30,43 +30,43 @@
 &am33xx_pinmux {
 	nxp_hdmi_bonelt_pins: nxp_hdmi_bonelt_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr0 */
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
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)		/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)		/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)		/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)		/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)		/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)		/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)		/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)		/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)		/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)		/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)		/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)		/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)		/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)		/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)		/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)		/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
 		>;
 	};
 
 	nxp_hdmi_bonelt_off_pins: nxp_hdmi_bonelt_off_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr0 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr0 */
 		>;
 	};
 
 	mcasp0_pins: mcasp0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLUP | MUX_MODE0) /* mcasp0_ahcklx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2*/
-			AM33XX_IOPAD(0x994, PIN_OUTPUT_PULLUP | MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x990, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpmc_a11.GPIO1_27 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKX, PIN_INPUT_PULLUP, MUX_MODE0) /* mcasp0_ahcklx.mcasp0_ahclkx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKR, PIN_OUTPUT_PULLDOWN, MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2*/
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_FSX, PIN_OUTPUT_PULLUP, MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKX, PIN_OUTPUT_PULLDOWN, MUX_MODE0) /* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_OUTPUT_PULLDOWN, MUX_MODE7) /* gpmc_a11.GPIO1_27 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-boneblack-wireless.dts b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
index 83f49f616b19..8022d41d3cb1 100644
--- a/arch/arm/boot/dts/am335x-boneblack-wireless.dts
+++ b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
@@ -32,35 +32,35 @@
 &am33xx_pinmux {
 	bt_pins: pinmux_bt_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gmii1_txd0.gpio0_28 - BT_EN */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gmii1_txd0.gpio0_28 - BT_EN */
 		>;
 	};
 
 	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE6 ) /* (L15) gmii1_rxd1.mmc2_clk */
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLUP | MUX_MODE6 ) /* (J16) gmii1_txen.mmc2_cmd */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (J17) gmii1_rxdv.mmc2_dat0 */
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (J18) gmii1_txd3.mmc2_dat1 */
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (K15) gmii1_txd2.mmc2_dat2 */
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (H16) gmii1_col.mmc2_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE6 ) /* (L15) gmii1_rxd1.mmc2_clk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLUP, MUX_MODE6 ) /* (J16) gmii1_txen.mmc2_cmd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLUP, MUX_MODE5 ) /* (J17) gmii1_rxdv.mmc2_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLUP, MUX_MODE5 ) /* (J18) gmii1_txd3.mmc2_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLUP, MUX_MODE5 ) /* (K15) gmii1_txd2.mmc2_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLUP, MUX_MODE5 ) /* (H16) gmii1_col.mmc2_dat3 */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)	/* gmii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gmii1_rxd2.uart3_txd */
-			AM33XX_IOPAD(0x948, PIN_INPUT | MUX_MODE3)		/* mdio_data.uart3_ctsn */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* mdio_clk.uart3_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gmii1_rxd3.uart3_rxd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* gmii1_rxd2.uart3_txd */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT, MUX_MODE3)		/* mdio_data.uart3_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* mdio_clk.uart3_rtsn */
 		>;
 	};
 
 	wl18xx_pins: pinmux_wl18xx_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gmii1_txclk.gpio3_9 WL_EN */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_refclk.gpio0_29 WL_IRQ */
-			AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gmii1_rxclk.gpio3_10 LS_BUF_EN */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gmii1_txclk.gpio3_9 WL_EN */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_refclk.gpio0_29 WL_IRQ */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gmii1_rxclk.gpio3_10 LS_BUF_EN */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index ccb147e70d17..e9c3ab42e687 100644
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
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE7) /* (V15) gpmc_a5.gpio1[21] - USR_LED_0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_OUTPUT, MUX_MODE7) /* (U15) gpmc_a6.gpio1[22] - USR_LED_1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_OUTPUT, MUX_MODE7) /* (T15) gpmc_a7.gpio1[23] - USR_LED_2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_OUTPUT, MUX_MODE7) /* (V16) gpmc_a8.gpio1[24] - USR_LED_3 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT, MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] - WIFI_LED */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE7) /* (R7) gpmc_advn_ale.gpio2[2] - P8.7, LED_RED, GP1_PIN_5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE7) /* (T7) gpmc_oen_ren.gpio2[3] - P8.8, LED_GREEN, GP1_PIN_6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_OUTPUT, MUX_MODE7) /* (U12) gpmc_ad11.gpio0[27] - P8.17, BATT_LED_1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE7) /* (T5) lcd_data15.gpio0[11] - P8.32, BATT_LED_2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE7) /* (V6) gpmc_csn0.gpio1[29] - P8.26, BATT_LED_3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE7) /* (T11) gpmc_ad10.gpio0[26] - P8.14, BATT_LED_4 */
 
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C17) I2C0_SDA.I2C0_SDA */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C16) I2C0_SCL.I2C0_SCL */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* (C17) I2C0_SDA.I2C0_SDA */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* (C16) I2C0_SCL.I2C0_SCL */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE3)	/* (D18) uart1_ctsn.I2C2_SDA */
-			AM33XX_IOPAD(0x97c, PIN_INPUT_PULLUP | MUX_MODE3)	/* (D17) uart1_rtsn.I2C2_SCL */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* (D18) uart1_ctsn.I2C2_SDA */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* (D17) uart1_rtsn.I2C2_SCL */
 		>;
 	};
 
 	/* UT0 */
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* (E15) uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* (E16) uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* (E15) uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* (E16) uart0_txd.uart0_txd */
 		>;
 	};
 
 	/* UT1 */
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* (D16) uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* (D15) uart1_txd.uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* (D16) uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* (D15) uart1_txd.uart1_txd */
 		>;
 	};
 
 	/* GPS */
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE1)	/* (A17) spi0_sclk.uart2_rxd */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* (B17) spi0_d0.uart2_txd */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE1)	/* (A17) spi0_sclk.uart2_rxd */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* (B17) spi0_d0.uart2_txd */
 		>;
 	};
 
 	/* DSM2 */
 	uart4_pins: pinmux_uart4_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE6)	/* (T17) gpmc_wait0.uart4_rxd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE6)	/* (T17) gpmc_wait0.uart4_rxd */
 		>;
 	};
 
 	/* UT5 */
 	uart5_pins: pinmux_uart5_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8C4, PIN_INPUT_PULLUP | MUX_MODE4)	/* (U2) lcd_data9.uart5_rxd */
-			AM33XX_IOPAD(0x8C0, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* (U1) lcd_data8.uart5_txd */
+			AM33XX_IOPAD(0x8C4, PIN_INPUT_PULLUP, MUX_MODE4)	/* (U2) lcd_data9.uart5_rxd */
+			AM33XX_IOPAD(0x8C0, PIN_OUTPUT_PULLDOWN, MUX_MODE4)	/* (U1) lcd_data8.uart5_txd */
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* (C15) spi0_cs1.gpio0[6] */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7)		/* (C15) spi0_cs1.gpio0[6] */
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
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)	/* (U9) gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)	/* (V9) gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* (U7) gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* (V7) gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1)	/* (R8) gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* (T8) gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1)	/* (U8) gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1)	/* (V8) gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1)	/* (R9) gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1)	/* (T9) gpmc_ad7.mmc1_dat7 */
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
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE6)	/* (L15) gmii1_rxd1.mmc2_clk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLUP, MUX_MODE6)	/* (J16) gmii1_txen.mmc2_cmd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLUP, MUX_MODE5)	/* (J17) gmii1_rxdv.mmc2_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLUP, MUX_MODE5)	/* (J18) gmii1_txd3.mmc2_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLUP, MUX_MODE5)	/* (K15) gmii1_txd2.mmc2_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLUP, MUX_MODE5)	/* (H16) gmii1_col.mmc2_dat3 */
 		>;
 	};
 
 	bt_pins: pinmux_bt_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* (K17) gmii1_txd0.gpio0[28] - BT_EN */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* (K17) gmii1_txd0.gpio0[28] - BT_EN */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)	/* (L17) gmii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* (L16) gmii1_rxd2.uart3_txd */
-			AM33XX_IOPAD(0x948, PIN_INPUT | MUX_MODE3)		/* (M17) mdio_data.uart3_ctsn */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* (M18) mdio_clk.uart3_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* (L17) gmii1_rxd3.uart3_rxd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* (L16) gmii1_rxd2.uart3_txd */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT, MUX_MODE3)		/* (M17) mdio_data.uart3_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* (M18) mdio_clk.uart3_rtsn */
 		>;
 	};
 
 	wl18xx_pins: pinmux_wl18xx_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* (K18) gmii1_txclk.gpio3[9] - WL_EN */
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* (K16) gmii1_txd1.gpio0[21] - WL_IRQ */
-			AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* (L18) gmii1_rxclk.gpio3[10] - LS_BUF_EN */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* (K18) gmii1_txclk.gpio3[9] - WL_EN */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* (K16) gmii1_txd1.gpio0[21] - WL_IRQ */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* (L18) gmii1_rxclk.gpio3[10] - LS_BUF_EN */
 		>;
 	};
 
 	/* DCAN */
 	dcan1_pins: pinmux_dcan1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x96c, PIN_INPUT | MUX_MODE2)		/* (E17) uart0_rtsn.dcan1_rx */
-			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2)		/* (E18) uart0_ctsn.dcan1_tx */
-			AM33XX_IOPAD(0x940, PIN_OUTPUT | MUX_MODE7)		/* (M16) gmii1_rxd0.gpio2[21] */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_INPUT, MUX_MODE2)		/* (E17) uart0_rtsn.dcan1_rx */
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_OUTPUT, MUX_MODE2)		/* (E18) uart0_ctsn.dcan1_tx */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_OUTPUT, MUX_MODE7)		/* (M16) gmii1_rxd0.gpio2[21] */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-bonegreen-common.dtsi b/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
index 853e6d3a028d..d2ecf491637e 100644
--- a/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
@@ -27,8 +27,8 @@
 &am33xx_pinmux {
 	uart2_pins: uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)	/* spi0_sclk.uart2_rxd */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)	/* spi0_d0.uart2_txd */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE1)	/* spi0_sclk.uart2_rxd */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)	/* spi0_d0.uart2_txd */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
index 57731f0daf10..ed2aa832e2dc 100644
--- a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
+++ b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
@@ -32,35 +32,35 @@
 &am33xx_pinmux {
 	bt_pins: pinmux_bt_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x878, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_ad12.gpio1_28 BT_EN */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN1, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_ad12.gpio1_28 BT_EN */
 		>;
 	};
 
 	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
-			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
-			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_clk.mmc2_clk */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)	/* gmii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gmii1_rxd2.uart3_txd */
-			AM33XX_IOPAD(0x948, PIN_INPUT | MUX_MODE3)		/* mdio_data.uart3_ctsn */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* mdio_clk.uart3_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gmii1_rxd3.uart3_rxd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* gmii1_rxd2.uart3_txd */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT, MUX_MODE3)		/* mdio_data.uart3_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* mdio_clk.uart3_rtsn */
 		>;
 	};
 
 	wl18xx_pins: pinmux_wl18xx_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x828, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad10.gpio0_26 WL_EN */
-			AM33XX_IOPAD(0x82C, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad11.gpio0_27 WL_IRQ */
-			AM33XX_IOPAD(0x87C, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_csn0.gpio1_29 LS_BUF_EN */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad10.gpio0_26 WL_EN */
+			AM33XX_IOPAD(0x82C, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad11.gpio0_27 WL_IRQ */
+			AM33XX_IOPAD(0x87C, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_csn0.gpio1_29 LS_BUF_EN */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/am335x-chiliboard.dts
index 9c2a947aacf5..912de80c825a 100644
--- a/arch/arm/boot/dts/am335x-chiliboard.dts
+++ b/arch/arm/boot/dts/am335x-chiliboard.dts
@@ -37,79 +37,79 @@
 &am33xx_pinmux {
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_crs.rmii1_crs */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_ref_clk.rmii_ref_clk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE1)  /* mii1_crs.rmii1_crs */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txen.rmii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* rmii1_ref_clk.rmii_ref_clk */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
 			/* mdio_clk.mdio_clk */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	usb1_drvvbus: usb1_drvvbus {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0xa34, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* usb1_drvvbus.usb1_drvvbus */
+			AM33XX_IOPAD(AM335X_PIN_USB1_DRVVBUS, PIN_OUTPUT_PULLDOWN, MUX_MODE0) /* usb1_drvvbus.usb1_drvvbus */
 		>;
 	};
 
 	sd_pins: pinmux_sd_card {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x900, PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT, MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT, MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT, MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT, MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT, MUX_MODE0) /* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT, MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7) /* spi0_cs1.gpio0_6 */
 		>;
 	};
 
 	led_gpio_pins: led_gpio_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9e4, PIN_OUTPUT | MUX_MODE7) /* emu0.gpio3_7 */
-			AM33XX_IOPAD(0x9e8, PIN_OUTPUT | MUX_MODE7) /* emu1.gpio3_8 */
+			AM33XX_IOPAD(AM335X_PIN_EMU0, PIN_OUTPUT, MUX_MODE7) /* emu0.gpio3_7 */
+			AM33XX_IOPAD(AM335X_PIN_EMU1, PIN_OUTPUT, MUX_MODE7) /* emu1.gpio3_8 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index 1b43ebd08b38..e36fdd8d7681 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -30,28 +30,28 @@
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	nandflash_pins: nandflash_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
 
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_csn0.gpmc_csn0 */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT_PULLUP, MUX_MODE0)	/* gpmc_csn0.gpmc_csn0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT_PULLUP, MUX_MODE0)	/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT_PULLUP, MUX_MODE0)	/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WEN, PIN_OUTPUT_PULLUP, MUX_MODE0)	/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT_PULLUP, MUX_MODE0)	/* gpmc_be0n_cle.gpmc_be0n_cle */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 2c724bb60417..a3d5fe0538b7 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -95,107 +95,107 @@
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
 			/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* i2c0_scl.i2c0_scl */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
 			/* uart0_ctsn.i2c1_sda */
-			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLUP, MUX_MODE2)
 			/* uart0_rtsn.i2c1_scl */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLUP, MUX_MODE2)
 		>;
 	};
 
 	gpio_led_pins: pinmux_gpio_led_pins {
 		pinctrl-single,pins = <
 			/* gpmc_csn3.gpio2_0 */
-			AM33XX_IOPAD(0x888, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN3, PIN_OUTPUT, MUX_MODE7)
 		>;
 	};
 
 	nandflash_pins: pinmux_nandflash_pins {
 		pinctrl-single,pins = <
 			/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* gpmc_ad7.gpmc_ad7 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* gpmc_wpn.gpio0_30 */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLUP, MUX_MODE7)
 			/* gpmc_csn0.gpmc_csn0  */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE0)
 			/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE0)
 			/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE0)
 			/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE0)
 			/* gpmc_ben0_cle.gpmc_ben0_cle */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
 			/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* uart0_txd.uart0_txd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
 			/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT, MUX_MODE0)
 			/* uart1_rtsn.uart1_rtsn */
-			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 			/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* uart1_txd.uart1_txd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	dcan0_pins: pinmux_dcan0_pins {
 		pinctrl-single,pins = <
 			/* uart1_ctsn.dcan0_tx */
-			AM33XX_IOPAD(0x978, PIN_OUTPUT | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_OUTPUT, MUX_MODE2)
 			/* uart1_rtsn.dcan0_rx */
-			AM33XX_IOPAD(0x97C, PIN_INPUT | MUX_MODE2)
+			AM33XX_IOPAD(0x97C, PIN_INPUT, MUX_MODE2)
 		>;
 	};
 
 	dcan1_pins: pinmux_dcan1_pins {
 		pinctrl-single,pins = <
 			/* uart1_rxd.dcan1_tx */
-			AM33XX_IOPAD(0x980, PIN_OUTPUT | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_OUTPUT, MUX_MODE2)
 			/* uart1_txd.dcan1_rx */
-			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE2)
 		>;
 	};
 
 	ecap0_pins: pinmux_ecap0_pins {
 		pinctrl-single,pins = <
 			/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
-			AM33XX_IOPAD(0x964, 0x0)
+			AM33XX_IOPAD(AM335X_PIN_ECAP0_IN_PWM0_OUT, 0x0, MUX_MODE0)
 		>;
 	};
 
@@ -203,96 +203,96 @@
 		pinctrl-single,pins = <
 			/* Slave 1 */
 			/* mii1_tx_en.rgmii1_tctl */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxdv.rgmii1_rctl */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_txd3.rgmii1_td3 */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_txd2.rgmii1_td2 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_txd1.rgmii1_td1 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_txd0.rgmii1_td0 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_txclk.rgmii1_tclk */
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxclk.rgmii1_rclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxd3.rgmii1_rd3 */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxd2.rgmii1_rd2 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxd1.rgmii1_rd1 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxd0.rgmii1_rd0 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE2)
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
 			/* mdio_clk.mdio_clk */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
 			/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	spi0_pins: pinmux_spi0_pins {
 		pinctrl-single,pins = <
 			/* spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE0)
 			/* spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLUP, MUX_MODE0)
 			/* spi0_d1.spi0_d1 */
-			AM33XX_IOPAD(0x958, PIN_INPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT, MUX_MODE0)
 			/* spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x95C, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(0x95C, PIN_OUTPUT, MUX_MODE0)
 			/* spi0_cs1.spi0_cs1 */
-			AM33XX_IOPAD(0x960, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
@@ -300,7 +300,7 @@
 	bluetooth_pins: pinmux_bluetooth_pins {
 		pinctrl-single,pins = <
 			/* XDMA_EVENT_INTR0.gpio0_19 - bluetooth enable */
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLUP | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT_PULLUP, MUX_MODE7)
 		>;
 	};
 
@@ -308,13 +308,13 @@
 	mcasp1_pins: pinmux_mcasp1_pins {
 		pinctrl-single,pins = <
 			/* MII1_CRS.mcasp1_aclkx */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE4)
 			/* MII1_RX_ER.mcasp1_fsx */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE4)
 			/* MII1_COL.mcasp1_axr2 */
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE4)
 			/* RMII1_REF_CLK.mcasp1_axr3 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE4)
 		>;
 	};
 
@@ -322,9 +322,9 @@
 	wifi_pins: pinmux_wifi_pins {
 		pinctrl-single,pins = <
 			/* EMU1.gpio3_8 - WiFi IRQ */
-			AM33XX_IOPAD(0x9e8, PIN_INPUT_PULLUP | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_EMU1, PIN_INPUT_PULLUP, MUX_MODE7)
 			/* XDMA_EVENT_INTR1.gpio0_20 - WiFi enable */
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT, MUX_MODE7)
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index b67f5fee1469..b306e8c19890 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -172,222 +172,222 @@
 
 	matrix_keypad_s0: matrix_keypad_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a9.gpio1_25 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a9.gpio1_25 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a10.gpio1_26 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a11.gpio1_27 */
 		>;
 	};
 
 	volume_keys_s0: volume_keys_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* spi0_sclk.gpio0_2 */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* spi0_d0.gpio0_3 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* spi0_sclk.gpio0_2 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* spi0_d0.gpio0_3 */
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_d1.i2c1_sda */
-			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_cs0.i2c1_scl */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE2)	/* spi0_d1.i2c1_sda */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE2)	/* spi0_cs0.i2c1_scl */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT, MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart1_txd.uart1_txd */
 		>;
 	};
 
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 		>;
 	};
 
 	nandflash_pins_s0: nandflash_pins_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLUP, MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 		>;
 	};
 
 	ecap0_pins: backlight_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x964, MUX_MODE0)	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out */
+			AM33XX_IOPAD(AM335X_PIN_ECAP0_IN_PWM0_OUT, 0x0, MUX_MODE0)	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* spi0_cs1.gpio0_6 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x9a0, PIN_INPUT | MUX_MODE4)		/* mcasp0_aclkr.mmc0_sdwp */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7)		/* spi0_cs1.gpio0_6 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT, MUX_MODE4)		/* mcasp0_aclkr.mmc0_sdwp */
 		>;
 	};
 
 	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a1.mmc2_dat0, INPUT_PULLUP | MODE3 */
-			AM33XX_IOPAD(0x848, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a2.mmc2_dat1, INPUT_PULLUP | MODE3 */
-			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a3.mmc2_dat2, INPUT_PULLUP | MODE3 */
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ben1.mmc2_dat3, INPUT_PULLUP | MODE3 */
-			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd, INPUT_PULLUP | MODE3 */
-			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a1.mmc2_dat0, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a2.mmc2_dat1, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a3.mmc2_dat2, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ben1.mmc2_dat3, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_csn3.mmc2_cmd, INPUT_PULLUP | MODE3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_clk.mmc2_clk, INPUT_PULLUP | MODE3 */
 		>;
 	};
 
 	wlan_pins: pinmux_wlan_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a0.gpio1_16 */
-			AM33XX_IOPAD(0x99c, PIN_INPUT | MUX_MODE7)		/* mcasp0_ahclkr.gpio3_17 */
-			AM33XX_IOPAD(0x9ac, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mcasp0_ahclkx.gpio3_21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a0.gpio1_16 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKR, PIN_INPUT, MUX_MODE7)		/* mcasp0_ahclkr.gpio3_17 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKX, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* mcasp0_ahclkx.gpio3_21 */
 		>;
 	};
 
 	lcd_pins_s0: lcd_pins_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad8.lcd_data23 */
-			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad9.lcd_data22 */
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad10.lcd_data21 */
-			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad11.lcd_data20 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad12.lcd_data19 */
-			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad13.lcd_data18 */
-			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad14.lcd_data17 */
-			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad15.lcd_data16 */
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
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_OUTPUT, MUX_MODE1)		/* gpmc_ad8.lcd_data23 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_OUTPUT, MUX_MODE1)		/* gpmc_ad9.lcd_data22 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE1)		/* gpmc_ad10.lcd_data21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_OUTPUT, MUX_MODE1)		/* gpmc_ad11.lcd_data20 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_OUTPUT, MUX_MODE1)		/* gpmc_ad12.lcd_data19 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_OUTPUT, MUX_MODE1)		/* gpmc_ad13.lcd_data18 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_OUTPUT, MUX_MODE1)		/* gpmc_ad14.lcd_data17 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_OUTPUT, MUX_MODE1)		/* gpmc_ad15.lcd_data16 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)		/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)		/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)		/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)		/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)		/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)		/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)		/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)		/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)		/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)		/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)		/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)		/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)		/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)		/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)		/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)		/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE0)		/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE0)		/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE0)		/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE0)		/* lcd_ac_bias_en.lcd_ac_bias_en */
 		>;
 	};
 
 	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
-			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_OUTPUT_PULLDOWN, MUX_MODE4) /* mii1_col.mcasp1_axr2 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
 		>;
 	};
 
 	mcasp1_pins_sleep: mcasp1_pins_sleep {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLDOWN | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_OUTPUT, MUX_MODE2) /* uart0_ctsn.d_can1_tx */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLDOWN, MUX_MODE2) /* uart0_rtsn.d_can1_rx */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 172c0224e7f6..e914b452609c 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -209,241 +209,241 @@
 
 	lcd_pins_default: lcd_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data23 */
-			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data22 */
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data21 */
-			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data20 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data19 */
-			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data18 */
-			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data17 */
-			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data16 */
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad8.lcd_data23 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad9.lcd_data22 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad10.lcd_data21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad11.lcd_data20 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad12.lcd_data19 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad13.lcd_data18 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad14.lcd_data17 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad15.lcd_data16 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)	/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)	/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)	/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)	/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)	/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)	/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)	/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)	/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)	/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)	/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)	/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)	/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)	/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)	/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)	/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)	/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE0)	/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE0)	/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE0)	/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
 		>;
 	};
 
 	lcd_pins_sleep: lcd_pins_sleep {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x820, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad8.lcd_data23 */
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad9.lcd_data22 */
-			AM33XX_IOPAD(0x828, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad10.lcd_data21 */
-			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad11.lcd_data20 */
-			AM33XX_IOPAD(0x830, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad12.lcd_data19 */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad13.lcd_data18 */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad14.lcd_data17 */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad15.lcd_data16 */
-			AM33XX_IOPAD(0x8a0, PULL_DISABLE | MUX_MODE7)	/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a4, PULL_DISABLE | MUX_MODE7)	/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a8, PULL_DISABLE | MUX_MODE7)	/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8ac, PULL_DISABLE | MUX_MODE7)	/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8b0, PULL_DISABLE | MUX_MODE7)	/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b4, PULL_DISABLE | MUX_MODE7)	/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b8, PULL_DISABLE | MUX_MODE7)	/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8bc, PULL_DISABLE | MUX_MODE7)	/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8c0, PULL_DISABLE | MUX_MODE7)	/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c4, PULL_DISABLE | MUX_MODE7)	/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c8, PULL_DISABLE | MUX_MODE7)	/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8cc, PULL_DISABLE | MUX_MODE7)	/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8d0, PULL_DISABLE | MUX_MODE7)	/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d4, PULL_DISABLE | MUX_MODE7)	/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d8, PULL_DISABLE | MUX_MODE7)	/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8dc, PULL_DISABLE | MUX_MODE7)	/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad8.lcd_data23 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad9.lcd_data22 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad10.lcd_data21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad11.lcd_data20 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad12.lcd_data19 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad13.lcd_data18 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad14.lcd_data17 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad15.lcd_data16 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PULL_DISABLE, MUX_MODE7)	/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PULL_DISABLE, MUX_MODE7)	/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PULL_DISABLE, MUX_MODE7)	/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PULL_DISABLE, MUX_MODE7)	/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PULL_DISABLE, MUX_MODE7)	/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PULL_DISABLE, MUX_MODE7)	/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PULL_DISABLE, MUX_MODE7)	/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PULL_DISABLE, MUX_MODE7)	/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PULL_DISABLE, MUX_MODE7)	/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PULL_DISABLE, MUX_MODE7)	/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PULL_DISABLE, MUX_MODE7)	/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PULL_DISABLE, MUX_MODE7)	/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PULL_DISABLE, MUX_MODE7)	/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PULL_DISABLE, MUX_MODE7)	/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PULL_DISABLE, MUX_MODE7)	/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PULL_DISABLE, MUX_MODE7)	/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_ac_bias_en.lcd_ac_bias_en */
 		>;
 	};
 
 
 	user_leds_s0: user_leds_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x810, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
-			AM33XX_IOPAD(0x814, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad5.gpio1_5 */
-			AM33XX_IOPAD(0x818, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad6.gpio1_6 */
-			AM33XX_IOPAD(0x81c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad7.gpio1_7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad5.gpio1_5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad6.gpio1_6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad7.gpio1_7 */
 		>;
 	};
 
 	gpio_keys_s0: gpio_keys_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x894, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_oen_ren.gpio2_3 */
-			AM33XX_IOPAD(0x890, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_advn_ale.gpio2_2 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
-			AM33XX_IOPAD(0x89c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ben0_cle.gpio2_5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_OEN_REN, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_oen_ren.gpio2_3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_advn_ale.gpio2_2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN0_CLE, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ben0_cle.gpio2_5 */
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 		>;
 	};
 
 	ecap2_pins: backlight_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x99c, MUX_MODE4)	/* mcasp0_ahclkr.ecap2_in_pwm2_out */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKR, 0x0, MUX_MODE4)	/* mcasp0_ahclkr.ecap2_in_pwm2_out */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
 
 			/* Slave 2 */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
-			AM33XX_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 
 			/* Slave 2 reset value*/
-			AM33XX_IOPAD(0x840, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x848, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x850, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x854, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) 		/* spi0_cs1.gpio0_6 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x9a0, PIN_INPUT | MUX_MODE4)		/* mcasp0_aclkr.mmc0_sdwp */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7) 		/* spi0_cs1.gpio0_6 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT, MUX_MODE4)		/* mcasp0_aclkr.mmc0_sdwp */
 		>;
 	};
 
 	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
-			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_OUTPUT_PULLDOWN, MUX_MODE4) /* mii1_col.mcasp1_axr2 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
 		>;
 	};
 
 	mcasp1_pins_sleep: mcasp1_pins_sleep {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7) /* gpmc_wpn.gpio0_31 */
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLUP, MUX_MODE7) /* gpmc_wpn.gpio0_31 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2) /* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
 		>;
 	};
 
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpmc_csn0.gpio1_29 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT_PULLUP, MUX_MODE7) /* gpmc_csn0.gpio1_29 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index f2005ecca74f..471a2dfdeb86 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -157,111 +157,111 @@
 &am33xx_pinmux {
 	user_leds: user_leds {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT | MUX_MODE7) /* (J18) gmii1_txd3.gpio0[16] */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT | MUX_MODE7) /* (K15) gmii1_txd2.gpio0[17] */
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] */
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT | MUX_MODE7) /* (D14) xdma_event_intr1.gpio0[20] */
-			AM33XX_IOPAD(0x880, PIN_OUTPUT | MUX_MODE7) /* (U9) gpmc_csn1.gpio1[30] */
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT | MUX_MODE7) /* (K18) gmii1_txclk.gpio3[9] */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT, MUX_MODE7) /* (J18) gmii1_txd3.gpio0[16] */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT, MUX_MODE7) /* (K15) gmii1_txd2.gpio0[17] */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT, MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT, MUX_MODE7) /* (D14) xdma_event_intr1.gpio0[20] */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_OUTPUT, MUX_MODE7) /* (U9) gpmc_csn1.gpio1[30] */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT, MUX_MODE7) /* (K18) gmii1_txclk.gpio3[9] */
 		>;
 	};
 
 	mmc0_pins_default: mmc0_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0) /* (F17) mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0) /* (F18) mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0) /* (G15) mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0) /* (G16) mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0) /* (G17) mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0) /* (G18) mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0) /* (F17) mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0) /* (F18) mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0) /* (G15) mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0) /* (G16) mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0) /* (G17) mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0) /* (G18) mmc0_cmd.mmc0_cmd */
 		>;
 	};
 
 	i2c0_pins_default: i2c0_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0) /* (C17) I2C0_SDA.I2C0_SDA */
-			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0) /* (C16) I2C0_SCL.I2C0_SCL */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT, MUX_MODE0) /* (C17) I2C0_SDA.I2C0_SDA */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT, MUX_MODE0) /* (C16) I2C0_SCL.I2C0_SCL */
 		>;
 	};
 
 	spi0_pins_default: spi0_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* (A17) spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* (B17) spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* (B16) spi0_d1.spi0_d1 */
-			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0) /* (A16) spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE0) /* (C15) spi0_cs1.spi0_cs1 */
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7) /* (B12) mcasp0_aclkr.gpio3[18] */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE0) /* (A17) spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE0) /* (B17) spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0) /* (B16) spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE0) /* (A16) spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT_PULLUP, MUX_MODE0) /* (C15) spi0_cs1.spi0_cs1 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7) /* (B12) mcasp0_aclkr.gpio3[18] */
 		>;
 	};
 
 	uart3_pins_default: uart3_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1) /* (L17) gmii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLUP | MUX_MODE1) /* (L16) gmii1_rxd2.uart3_txd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1) /* (L17) gmii1_rxd3.uart3_rxd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLUP, MUX_MODE1) /* (L16) gmii1_rxd2.uart3_txd */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1, RMII mode */
-			AM33XX_IOPAD(0x90c, (PIN_INPUT_PULLUP | MUX_MODE1))	/* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x944, (PIN_INPUT_PULLUP | MUX_MODE0))	/* rmii1_refclk.rmii1_refclk */
-			AM33XX_IOPAD(0x940, (PIN_INPUT_PULLUP | MUX_MODE1))	/* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x93c, (PIN_INPUT_PULLUP | MUX_MODE1))	/* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x910, (PIN_INPUT_PULLUP | MUX_MODE1))	/* mii1_rxerr.rmii1_rxerr */
-			AM33XX_IOPAD(0x928, (PIN_OUTPUT_PULLDOWN | MUX_MODE1))	/* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x924, (PIN_OUTPUT_PULLDOWN | MUX_MODE1))	/* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x914, (PIN_OUTPUT_PULLDOWN | MUX_MODE1))	/* mii1_txen.rmii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* rmii1_refclk.rmii1_refclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txen.rmii1_txen */
 			/* Slave 2, RMII mode */
-			AM33XX_IOPAD(0x870, (PIN_INPUT_PULLUP | MUX_MODE3))	/* gpmc_wait0.rmii2_crs_dv */
-			AM33XX_IOPAD(0x908, (PIN_INPUT_PULLUP | MUX_MODE1))	/* mii1_col.rmii2_refclk */
-			AM33XX_IOPAD(0x86c, (PIN_INPUT_PULLUP | MUX_MODE3))	/* gpmc_a11.rmii2_rxd0 */
-			AM33XX_IOPAD(0x868, (PIN_INPUT_PULLUP | MUX_MODE3))	/* gpmc_a10.rmii2_rxd1 */
-			AM33XX_IOPAD(0x874, (PIN_INPUT_PULLUP | MUX_MODE3))	/* gpmc_wpn.rmii2_rxerr */
-			AM33XX_IOPAD(0x854, (PIN_OUTPUT_PULLDOWN | MUX_MODE3))	/* gpmc_a5.rmii2_txd0 */
-			AM33XX_IOPAD(0x850, (PIN_OUTPUT_PULLDOWN | MUX_MODE3))	/* gpmc_a4.rmii2_txd1 */
-			AM33XX_IOPAD(0x840, (PIN_OUTPUT_PULLDOWN | MUX_MODE3))	/* gpmc_a0.rmii2_txen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_wait0.rmii2_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_col.rmii2_refclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a11.rmii2_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a10.rmii2_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_wpn.rmii2_rxerr */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* gpmc_a5.rmii2_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* gpmc_a4.rmii2_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* gpmc_a0.rmii2_txen */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x90c, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x944, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x940, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x93c, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x910, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x928, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x924, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x914, (PIN_INPUT_PULLDOWN | MUX_MODE7))
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
 
 			/* Slave 2 reset value */
-			AM33XX_IOPAD(0x870, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x908, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x86c, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x868, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x874, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x854, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x850, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x840, (PIN_INPUT_PULLDOWN | MUX_MODE7))
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0))	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, (PIN_OUTPUT_PULLUP | MUX_MODE0))			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x94c, (PIN_INPUT_PULLDOWN | MUX_MODE7))
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 55b4c94cfafb..96cf06500e81 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -57,41 +57,41 @@
 &am33xx_pinmux {
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	nandflash_pins: pinmux_nandflash_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLUP, MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	leds_pins: pinmux_leds_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x85c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a7.gpio1_23 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a7.gpio1_23 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index 481edcfaf121..754cb98a8c00 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -46,109 +46,109 @@
 &am33xx_pinmux {
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd */
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_int */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_crs_dv */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_rxer */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* rmii1_td1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* rmii1_td0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_rd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_rd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_refclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_int */
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* rmii1_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* rmii1_rxer */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* rmii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* rmii1_td1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* rmii1_td0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* rmii1_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* rmii1_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* rmii1_refclk */
 
 			/* Slave 2 */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_txen */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_td1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_td0 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rd0 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_crs_dv */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rxer */
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_int */
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii2_refclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* rmii2_txen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* rmii2_td1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* rmii2_td0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE3)	/* rmii2_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE3)	/* rmii2_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLDOWN, MUX_MODE3)	/* rmii2_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE3)	/* rmii2_rxer */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii2_int */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* rmii2_refclk */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_int */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_crs_dv */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_rxer */
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_td1 */
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_td0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_rd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_rd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_refclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_int */
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_rxer */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_td1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_td0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_refclk */
 
 			/* Slave 2 reset value*/
-			AM33XX_IOPAD(0x840, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_txen */
-			AM33XX_IOPAD(0x850, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_td1 */
-			AM33XX_IOPAD(0x854, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_td0 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_rd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_rd0 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_crs_dv */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_rxer */
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_int */
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_refclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii2_txen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii2_td1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii2_td0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii2_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii2_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii2_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii2_rxer */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii2_int */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii2_refclk */
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	emmc_pins: pinmux_emmc_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2) /* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
index 14f781953475..9643f9739ed1 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -33,54 +33,54 @@
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	push_button_pins: pinmux_push_button {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.gpio2_23 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_hsync.gpio2_23 */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	mmc1_pins_default: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
 			/* eMMC */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad12.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad13.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad14.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad15.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad8.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad9.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad10.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad11.mmc1_dat7 */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad12.mmc1_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad13.mmc1_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad14.mmc1_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad15.mmc1_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad8.mmc1_dat4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad9.mmc1_dat5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad10.mmc1_dat6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad11.mmc1_dat7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
 		>;
 	};
 
 	spi0_pins: pinmux_spi0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0)	 /* spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0)	 /* spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0)	 /* spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)	 /* spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE0)	 /* spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE0)	 /* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE0)	 /* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0)	 /* spi0_d1.spi0_d1 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
index 48aee6de4cdb..3a7bbee85553 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
@@ -31,23 +31,23 @@
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mii1_refclk.rmii1_refclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txen.rmii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* mii1_refclk.rmii1_refclk */
 		>;
 	};
 
 	spi1_pins: pinmux_spi1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x964, PIN_INPUT_PULLUP | MUX_MODE4)	 /* ecap0_in_pwm0_out.spi1_sclk */
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart1_ctsn.spi1_cs0 */
-			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart0_ctsn.spi1_d0 */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart0_rtsn.spi1_d1 */
+			AM33XX_IOPAD(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_INPUT_PULLUP, MUX_MODE4)	 /* ecap0_in_pwm0_out.spi1_sclk */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE4)	 /* uart1_ctsn.spi1_cs0 */
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLUP, MUX_MODE4)	 /* uart0_ctsn.spi1_d0 */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLUP, MUX_MODE4)	 /* uart0_rtsn.spi1_d1 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
index 5a58efc0c874..c812babc8007 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -104,79 +104,79 @@
 
 	minipcie_pins: pinmux_minipcie {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.gpio2_24 */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.gpio2_25 */
-			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.gpio2_22  Power off PIN*/
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_pclk.gpio2_24 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_ac_bias_en.gpio2_25 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* lcd_vsync.gpio2_22  Power off PIN*/
 		>;
 	};
 
 	push_button_pins: pinmux_push_button {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* mcasp0_ahcklx.gpio3_21 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKX, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* mcasp0_ahcklx.gpio3_21 */
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)    /* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)    /* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart0_ctsn.i2c1_sda */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart0_rtsn.i2c1_scl */
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart0_ctsn.i2c1_sda */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart0_rtsn.i2c1_scl */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart1_rtsn.uart1_rtsn */
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)    /* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT | MUX_MODE0)		/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT, MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN, MUX_MODE0) /* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)    /* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT, MUX_MODE0)		/* uart1_txd.uart1_txd */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8d8, PIN_INPUT | MUX_MODE6)		/* lcd_data14.uart5_ctsn */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT_PULLDOWN | MUX_MODE6)  /* lcd_data15.uart5_rtsn */
-			AM33XX_IOPAD(0x8c4, PIN_INPUT_PULLUP | MUX_MODE4)     /* lcd_data9.uart5_rxd */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE4)		/* lcd_data8.uart5_txd */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_INPUT, MUX_MODE6)		/* lcd_data14.uart5_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT_PULLDOWN, MUX_MODE6)  /* lcd_data15.uart5_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_INPUT_PULLUP, MUX_MODE4)     /* lcd_data9.uart5_rxd */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE4)		/* lcd_data8.uart5_txd */
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
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE1)  /* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE1)    /* mii1_rxerr.rmii1_rxerr */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE1) /* mii1_txen.rmii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE1) /* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE1) /* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE1)    /* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE1)    /* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE0)  /* mii1_refclk.rmii1_refclk */
 
 			/* Slave 2 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_crs_dv */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rxer */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_txen */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_td1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_td0 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rd0 */
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE1)  /* rmii2_refclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLDOWN, MUX_MODE3)   /* rmii2_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE3)   /* rmii2_rxer */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)  /* rmii2_txen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLDOWN, MUX_MODE3)  /* rmii2_td1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE3)  /* rmii2_td0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE3)   /* rmii2_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE3)   /* rmii2_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE1)  /* rmii2_refclk */
 
 		>;
 	};
@@ -184,46 +184,46 @@
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
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
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKX, PIN_INPUT_PULLUP, MUX_MODE7)	/* mcasp0_aclkx.gpio3_14 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7)    /* mcasp0_aclkx.gpio3_18 */
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
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad8.mmc2_dat4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad9.mmc2_dat5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad10.mmc2_dat6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad11.mmc2_dat7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE3)     /* gpmc_csn3.mmc2_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_clk.mmc2_clk */
 		>;
 	};
 
 	spi0_pins: pinmux_spi0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE0) /* spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP, MUX_MODE0) /* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE0) /* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0) /* spi0_d1.spi0_d1 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 9c9143ed4003..320ecda9c6c4 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -41,121 +41,121 @@
 
 	misc_pins: misc_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x95c, PIN_OUTPUT | MUX_MODE7)	/* spi0_cs0.gpio0_5 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS0, PIN_OUTPUT, MUX_MODE7)	/* spi0_cs0.gpio0_5 */
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
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad8.gpmc_ad8 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad9.gpmc_ad9 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad10.gpmc_ad10 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad11.gpmc_ad11 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad12.gpmc_ad12 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad13.gpmc_ad13 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad14.gpmc_ad14 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad15.gpmc_ad15 */
 
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
-			AM33XX_IOPAD(0x880, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn1.gpmc_csn1 */
-			AM33XX_IOPAD(0x884, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn2.gpmc_csn2 */
-			AM33XX_IOPAD(0x888, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn3.gpmc_csn3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_OUTPUT, MUX_MODE0)		/* gpmc_csn1.gpmc_csn1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_OUTPUT, MUX_MODE0)		/* gpmc_csn2.gpmc_csn2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN3, PIN_OUTPUT, MUX_MODE0)		/* gpmc_csn3.gpmc_csn3 */
 
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_ben0_cle.gpmc_ben0_cle */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_ben0_cle.gpmc_ben0_cle */
 
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE1)		/* lcd_data1.gpmc_a1 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE1)		/* lcd_data2.gpmc_a2 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE1)		/* lcd_data3.gpmc_a3 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE1)		/* lcd_data4.gpmc_a4 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE1)		/* lcd_data5.gpmc_a5 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE1)		/* lcd_data6.gpmc_a6 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE1)		/* lcd_data7.gpmc_a7 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE1)		/* lcd_data1.gpmc_a1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE1)		/* lcd_data2.gpmc_a2 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE1)		/* lcd_data3.gpmc_a3 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE1)		/* lcd_data4.gpmc_a4 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE1)		/* lcd_data5.gpmc_a5 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE1)		/* lcd_data6.gpmc_a6 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE1)		/* lcd_data7.gpmc_a7 */
 
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE1)		/* lcd_vsync.gpmc_a8 */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE1)		/* lcd_hsync.gpmc_a9 */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE1)		/* lcd_pclk.gpmc_a10 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE1)		/* lcd_vsync.gpmc_a8 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE1)		/* lcd_hsync.gpmc_a9 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE1)		/* lcd_pclk.gpmc_a10 */
 		>;
 	};
 
 	i2c0_pins: i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	uart0_pins: uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT | MUX_MODE0)		/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT, MUX_MODE0)		/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart1_pins: uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_OUTPUT | MUX_MODE7)		/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT | MUX_MODE7)		/* uart1_rtsn.uart1_rtsn */
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT | MUX_MODE0)		/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_OUTPUT, MUX_MODE7)		/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_OUTPUT, MUX_MODE7)		/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT, MUX_MODE0)		/* uart1_txd.uart1_txd */
 		>;
 	};
 
 	uart2_pins: uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8c0, PIN_INPUT_PULLUP | MUX_MODE7)	/* lcd_data8.gpio2[14] */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE7)		/* lcd_data9.gpio2[15] */
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)		/* spi0_sclk.uart2_rxd */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)		/* spi0_d0.uart2_txd */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_INPUT_PULLUP, MUX_MODE7)	/* lcd_data8.gpio2[14] */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE7)		/* lcd_data9.gpio2[15] */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE1)		/* spi0_sclk.uart2_rxd */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)		/* spi0_d0.uart2_txd */
 		>;
 	};
 
 	uart3_pins: uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8c8, PIN_INPUT_PULLUP | MUX_MODE6)	/* lcd_data10.uart3_ctsn */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE6)		/* lcd_data11.uart3_rtsn */
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE1)		/* spi0_cs1.uart3_rxd */
-			AM33XX_IOPAD(0x964, PIN_OUTPUT | MUX_MODE1)		/* ecap0_in_pwm0_out.uart3_txd */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_INPUT_PULLUP, MUX_MODE6)	/* lcd_data10.uart3_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE6)		/* lcd_data11.uart3_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE1)		/* spi0_cs1.uart3_rxd */
+			AM33XX_IOPAD(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_OUTPUT, MUX_MODE1)		/* ecap0_in_pwm0_out.uart3_txd */
 		>;
 	};
 
 	uart4_pins: uart4_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8d0, PIN_INPUT_PULLUP | MUX_MODE6)	/* lcd_data12.uart4_ctsn */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE6)		/* lcd_data13.uart4_rtsn */
-			AM33XX_IOPAD(0x968, PIN_INPUT | MUX_MODE1)		/* uart0_ctsn.uart4_rxd */
-			AM33XX_IOPAD(0x96c, PIN_OUTPUT | MUX_MODE1)		/* uart0_rtsn.uart4_txd */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_INPUT_PULLUP, MUX_MODE6)	/* lcd_data12.uart4_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE6)		/* lcd_data13.uart4_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_INPUT, MUX_MODE1)		/* uart0_ctsn.uart4_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_OUTPUT, MUX_MODE1)		/* uart0_rtsn.uart4_txd */
 		>;
 	};
 
 	uart5_pins: uart5_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8d8, PIN_INPUT | MUX_MODE4)		/* lcd_data14.uart5_rxd */
-			AM33XX_IOPAD(0x944, PIN_OUTPUT | MUX_MODE3)		/* rmiii1_refclk.uart5_txd */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_INPUT, MUX_MODE4)		/* lcd_data14.uart5_rxd */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_OUTPUT, MUX_MODE3)		/* rmiii1_refclk.uart5_txd */
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
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_EMU1, PIN_INPUT_PULLUP, MUX_MODE7)	/* emu1.gpio3[8] */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7)	/* mcasp0_aclkr.gpio3[18] */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
index 95d54cf3849e..3c2758827fb3 100644
--- a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
+++ b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
@@ -40,61 +40,61 @@
 &am33xx_pinmux {
 	nxp_hdmi_bonelt_pins: nxp-hdmi-bonelt-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr0 */
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
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)		/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)		/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)		/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)		/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)		/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)		/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)		/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)		/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)		/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)		/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)		/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)		/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)		/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)		/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)		/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)		/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
 		>;
 	};
 
 	nxp_hdmi_bonelt_off_pins: nxp-hdmi-bonelt-off-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr0 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr0 */
 		>;
 	};
 
 	mcasp0_pins: mcasp0-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLUP | MUX_MODE0) /* mcasp0_ahcklx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2*/
-			AM33XX_IOPAD(0x994, PIN_OUTPUT_PULLUP | MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x990, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpmc_a11.GPIO1_27 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKX, PIN_INPUT_PULLUP, MUX_MODE0) /* mcasp0_ahcklx.mcasp0_ahclkx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKR, PIN_OUTPUT_PULLDOWN, MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2*/
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_FSX, PIN_OUTPUT_PULLUP, MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKX, PIN_OUTPUT_PULLDOWN, MUX_MODE0) /* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_OUTPUT_PULLDOWN, MUX_MODE7) /* gpmc_a11.GPIO1_27 */
 		>;
 	};
 
 	flash_enable: flash-enable {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLDOWN | MUX_MODE7) 	/* rmii1_ref_clk.gpio0_29 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE7) 	/* rmii1_ref_clk.gpio0_29 */
 		>;
 	};
 
 	imu_interrupt: imu-interrupt {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7) 		/* mii1_rx_er.gpio3_2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE7) 		/* mii1_rx_er.gpio3_2 */
 		>;
 	};
 
 	ethernet_interrupt: ethernet-interrupt{
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7) 		/* mii1_col.gpio3_0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE7) 		/* mii1_col.gpio3_0 */
 		>;
 	};
 };
@@ -269,109 +269,109 @@
 
 	user_leds_s0: user-leds-s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
-			AM33XX_IOPAD(0x85c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a7.gpio1_23 */
-			AM33XX_IOPAD(0x860, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a7.gpio1_23 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_a8.gpio1_24 */
 		>;
 	};
 
 	i2c2_pins: pinmux-i2c2-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
-			AM33XX_IOPAD(0x97c, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
 		>;
 	};
 
 	uart0_pins: pinmux-uart0-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	clkout2_pin: pinmux-clkout2-pin {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 		>;
 	};
 
 	cpsw_default: cpsw-default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxdv.rgmii1_rctl */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_txd3 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_txd2 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_txd0 */
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_txclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxclk.rgmii1_rxclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxd3.rgmii1_rxd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxd2.rgmii1_rxd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxd1.rgmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxd0.rgmii1_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE2)		/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd3.rgmii1_txd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd2.rgmii1_txd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd1.rgmii1_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd0.rgmii1_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txclk.rgmii1_txclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE2)		/* mii1_rxclk.rgmii1_rxclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE2)		/* mii1_rxd3.rgmii1_rxd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE2)		/* mii1_rxd2.rgmii1_rxd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE2)		/* mii1_rxd1.rgmii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE2)		/* mii1_rxd0.rgmii1_rxd0 */
 		>;
 	};
 
 	cpsw_sleep: cpsw-sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci-mdio-default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci-mdio-sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	mmc1_pins: pinmux-mmc1-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* (C15) spi0_cs1.gpio0[6] */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0) /* (G16) mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0) /* (G15) mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0) /* (F18) mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0) /* (F17) mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0) /* (G18) mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0) /* (G17) mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7) /* (C15) spi0_cs1.gpio0[6] */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0) /* (G16) mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0) /* (G15) mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0) /* (F18) mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0) /* (F17) mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0) /* (G18) mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0) /* (G17) mmc0_clk.mmc0_clk */
 		>;
 	};
 
 	emmc_pins: pinmux-emmc-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2) /* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-osd335x-common.dtsi b/arch/arm/boot/dts/am335x-osd335x-common.dtsi
index f8ff473f94f0..0159a23bb95b 100644
--- a/arch/arm/boot/dts/am335x-osd335x-common.dtsi
+++ b/arch/arm/boot/dts/am335x-osd335x-common.dtsi
@@ -36,8 +36,8 @@
 &am33xx_pinmux {
 	i2c0_pins: pinmux-i2c0-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C17) I2C0_SDA.I2C0_SDA */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C16) I2C0_SCL.I2C0_SCL */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* (C17) I2C0_SDA.I2C0_SDA */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* (C16) I2C0_SCL.I2C0_SCL */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-pcm-953.dtsi b/arch/arm/boot/dts/am335x-pcm-953.dtsi
index 1ec8e0d80191..222d85081881 100644
--- a/arch/arm/boot/dts/am335x-pcm-953.dtsi
+++ b/arch/arm/boot/dts/am335x-pcm-953.dtsi
@@ -79,15 +79,15 @@
 &am33xx_pinmux {
 	user_buttons_pins: pinmux_user_buttons {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* emu0.gpio3_7 */
-			AM33XX_IOPAD(0x9e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* emu1.gpio3_8 */
+			AM33XX_IOPAD(AM335X_PIN_EMU0, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* emu0.gpio3_7 */
+			AM33XX_IOPAD(AM335X_PIN_EMU1, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* emu1.gpio3_8 */
 		>;
 	};
 
 	user_leds_pins: pinmux_user_leds {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn1.gpio1_30 */
-			AM33XX_IOPAD(0x884, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn2.gpio1_31 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_csn1.gpio1_30 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_csn2.gpio1_31 */
 		>;
 	};
 };
@@ -96,8 +96,8 @@
 &am33xx_pinmux {
 	dcan1_pins: pinmux_dcan1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_OUTPUT_PULLUP | MUX_MODE2)	/* uart1_rxd.dcan1_tx_mux2 */
-			AM33XX_IOPAD(0x984, PIN_INPUT_PULLUP | MUX_MODE2)	/* uart1_txd.dcan1_rx_mux2 */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_OUTPUT_PULLUP, MUX_MODE2)	/* uart1_rxd.dcan1_tx_mux2 */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_INPUT_PULLUP, MUX_MODE2)	/* uart1_txd.dcan1_rx_mux2 */
 		>;
 	};
 };
@@ -112,18 +112,18 @@
 &am33xx_pinmux {
 	ethernet1_pins: pinmux_ethernet1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
-			AM33XX_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
 		>;
 	};
 };
@@ -171,8 +171,8 @@
 
 	cb_gpio_pins: pinmux_cb_gpio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* uart0_ctsn.gpio1_8 */
-			AM33XX_IOPAD(0x96c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* uart0_rtsn.gpio1_9 */
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* uart0_ctsn.gpio1_8 */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* uart0_rtsn.gpio1_9 */
 		>;
 	};
 };
@@ -181,13 +181,13 @@
 &am33xx_pinmux {
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT_PULLUP, MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
 		>;
 	};
 };
@@ -205,31 +205,31 @@
 &am33xx_pinmux {
 	uart0_pins: pinmux_uart0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
-			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT, MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_tx_clk.uart2_rxd */
-			AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_rx_clk.uart2_txd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_tx_clk.uart2_rxd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_rx_clk.uart2_txd */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd2.uart3_txd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxd3.uart3_rxd */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_rxd2.uart3_txd */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-pdu001.dts b/arch/arm/boot/dts/am335x-pdu001.dts
index ae43d61f4e8b..5faa65b65c20 100644
--- a/arch/arm/boot/dts/am335x-pdu001.dts
+++ b/arch/arm/boot/dts/am335x-pdu001.dts
@@ -92,162 +92,162 @@
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_d1.i2c1_sda */
-			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_cs0.i2c1_scl */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE2)	/* spi0_d1.i2c1_sda */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE2)	/* spi0_cs0.i2c1_scl */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_clk.i2c2_sda */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_d0.i2c2_scl */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE2)	/* spi0_clk.i2c2_sda */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE2)	/* spi0_d0.i2c2_scl */
 		>;
 	};
 
 	spi1_pins: pinmux_spi1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x990, PIN_OUTPUT | MUX_MODE3)		/* mcasp0_aclkx.spi1_sclk */
-			AM33XX_IOPAD(0x994, PIN_OUTPUT | MUX_MODE3)		/* mcasp0_fsx.spi1_d0 */
-			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcasp0_axr0.spi1_d1 */
-			AM33XX_IOPAD(0x99C, PIN_OUTPUT | MUX_MODE3)		/* mcasp0_ahclkr.spi1_cs0 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKX, PIN_OUTPUT, MUX_MODE3)		/* mcasp0_aclkx.spi1_sclk */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_FSX, PIN_OUTPUT, MUX_MODE3)		/* mcasp0_fsx.spi1_d0 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AXR0, PIN_INPUT_PULLDOWN, MUX_MODE3)	/* mcasp0_axr0.spi1_d1 */
+			AM33XX_IOPAD(0x99C, PIN_OUTPUT, MUX_MODE3)		/* mcasp0_ahclkr.spi1_cs0 */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x96C, PIN_OUTPUT | MUX_MODE7)		/* uart0_rtsn.gpio1_9 */
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(0x96C, PIN_OUTPUT, MUX_MODE7)		/* uart0_rtsn.gpio1_9 */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart1_txd.uart1_txd */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE1)	/* spi0_cs1.uart3_rxd */
-			AM33XX_IOPAD(0x964, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* ecap0_in_pwm0_out.uart3_txd */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT_PULLUP, MUX_MODE1)	/* spi0_cs1.uart3_rxd */
+			AM33XX_IOPAD(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* ecap0_in_pwm0_out.uart3_txd */
 		>;
 	};
 
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr1.clkout2 */
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
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_INPUT, MUX_MODE0)		/* mii1_col.mii1_col */
+			AM33XX_IOPAD(0x90C, PIN_INPUT, MUX_MODE0)		/* mii1_crs.mii1_crs */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT, MUX_MODE0)		/* mii1_rxer.mii1_rxer */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT, MUX_MODE0)		/* mii1_txen.mii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT, MUX_MODE0)		/* mii1_rxdv.mii1_rxdv */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT, MUX_MODE0)		/* mii1_txd3.mii1_txd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT, MUX_MODE0)		/* mii1_txd2.mii1_txd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT, MUX_MODE0)		/* mii1_txd1.mii1_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT, MUX_MODE0)		/* mii1_txd0.mii1_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT, MUX_MODE0)		/* mii1_txclk.mii1_txclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT, MUX_MODE0)		/* mii1_rxclk.mii1_rxclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT, MUX_MODE0)		/* mii1_rxd3.mii1_rxd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT, MUX_MODE0)		/* mii1_rxd2.mii1_rxd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT, MUX_MODE0)		/* mii1_rxd1.mii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT, MUX_MODE0)		/* mii1_rxd0.mii1_rxd0 */
 
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
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT, MUX_MODE1)		/* mii2_txen.gpmc_a0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT, MUX_MODE1)		/* mii2_rxdv.gpmc_a1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_OUTPUT, MUX_MODE1)		/* mii2_txd3.gpmc_a2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_OUTPUT, MUX_MODE1)		/* mii2_txd2.gpmc_a3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT, MUX_MODE1)		/* mii2_txd1.gpmc_a4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE1)		/* mii2_txd0.gpmc_a5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_INPUT, MUX_MODE1)		/* mii2_txclk.gpmc_a6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_INPUT, MUX_MODE1)		/* mii2_rxclk.gpmc_a7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_INPUT, MUX_MODE1)		/* mii2_rxd3.gpmc_a8 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT, MUX_MODE1)		/* mii2_rxd2.gpmc_a9 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT, MUX_MODE1)		/* mii2_rxd1.gpmc_a10 */
+			AM33XX_IOPAD(0x86C, PIN_INPUT, MUX_MODE1)		/* mii2_rxd0.gpmc_a11 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT, MUX_MODE1)		/* mii2_crs.gpmc_wait0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT, MUX_MODE1)		/* mii2_rxer.gpmc_wpn */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN1, PIN_INPUT, MUX_MODE1)		/* mii2_col.gpmc_ben1 */
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
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
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd */
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
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
 			/* card change signal for frontpanel SD cardcage */
-			AM33XX_IOPAD(0x890, PIN_INPUT | MUX_MODE7)		/* gpmc_advn_ale.gpio2_2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_INPUT, MUX_MODE7)		/* gpmc_advn_ale.gpio2_2 */
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
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)		/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)		/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)		/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)		/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)		/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)		/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)		/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)		/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)		/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)		/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)		/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)		/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)		/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)		/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)		/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)		/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE0)		/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE0)		/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE0)		/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE0)		/* lcd_ac_bias_en.lcd_ac_bias_en */
 		>;
 	};
 
 	dcan0_pins: pinmux_dcan0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_OUTPUT | MUX_MODE2)		/* uart1_ctsn.d_can0_tx */
-			AM33XX_IOPAD(0x97c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* uart1_rtsn.d_can0_rx */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_OUTPUT, MUX_MODE2)		/* uart1_ctsn.d_can0_tx */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* uart1_rtsn.d_can0_rx */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 6be79b8349ac..3e38895132bc 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -93,14 +93,14 @@
 &am33xx_pinmux {
 	i2c0_pins: pinmux_i2c0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 	i2c1_pins: pinmux_i2c1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x90C, PIN_INPUT_PULLUP | MUX_MODE3)	/* mii1_crs,i2c1_sda */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE3)	/* mii1_rxerr,i2c1_scl */
+			AM33XX_IOPAD(0x90C, PIN_INPUT_PULLUP, MUX_MODE3)	/* mii1_crs,i2c1_sda */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE3)	/* mii1_rxerr,i2c1_scl */
 		>;
 	};
 };
@@ -130,7 +130,7 @@
 &am33xx_pinmux {
 	accel_pins: pinmux_accel {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x898, PIN_INPUT | MUX_MODE7)   /* gpmc_wen.gpio2_4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WEN, PIN_INPUT, MUX_MODE7)   /* gpmc_wen.gpio2_4 */
 		>;
 	};
 };
@@ -177,12 +177,12 @@
 &am33xx_pinmux {
 	audio_pins: pinmux_audio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
-			AM33XX_IOPAD(0x9a8, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr1.mcasp0_axr1 */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a0.gpio1_16 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKX, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_FSX, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKX, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AXR0, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AXR1, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* mcasp0_axr1.mcasp0_axr1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT, MUX_MODE7)	/* gpmc_a0.gpio1_16 */
 		>;
 	};
 };
@@ -228,36 +228,36 @@
 &am33xx_pinmux {
 	lcd_pins: pinmux_lcd {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data16 */
-			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data17 */
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data18 */
-			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data19 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data20 */
-			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data21 */
-			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data22 */
-			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data23 */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)	/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)	/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)	/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)	/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)	/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)	/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)	/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)	/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)	/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)	/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)	/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)	/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)	/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)	/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)	/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)	/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad8.lcd_data16 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad9.lcd_data17 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad10.lcd_data18 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad11.lcd_data19 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad12.lcd_data20 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad13.lcd_data21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad14.lcd_data22 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad15.lcd_data23 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE0)	/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE0)	/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE0)	/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
 			/* Display Enable */
-			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_a11.gpio1_27 */
 		>;
 	};
 };
@@ -299,29 +299,29 @@
 &am33xx_pinmux {
 	ethernet_pins: pinmux_ethernet {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd3.rgmii1_rxd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd2.rgmii1_rxd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLUP, MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLUP, MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLUP, MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE2)	/* mii1_rxd3.rgmii1_rxd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLUP, MUX_MODE2)	/* mii1_rxd2.rgmii1_rxd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd0 */
 			/* ethernet interrupt */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLUP | MUX_MODE7)	/* rmii2_refclk.gpio0_29 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLUP, MUX_MODE7)	/* rmii2_refclk.gpio0_29 */
 			/* ethernet PHY nReset */
-			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* mii1_col.gpio3_0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_COL, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* mii1_col.gpio3_0 */
 		>;
 	};
 
 	mdio_pins: pinmux_mdio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 };
@@ -364,45 +364,45 @@
 &am33xx_pinmux {
 	sd_pins: pinmux_sd_card {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* spi0_cs1.gpio0_6 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7)		/* spi0_cs1.gpio0_6 */
 		>;
 	};
 	emmc_pins: pinmux_emmc {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad5.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
 			/* EMMC nReset */
-			AM33XX_IOPAD(0x874, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_31 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_wpn.gpio0_31 */
 		>;
 	};
 	wireless_pins: pinmux_wireless {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a1.mmc2_dat0 */
-			AM33XX_IOPAD(0x848, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a2.mmc2_dat1 */
-			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a3.mmc2_dat2 */
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ben1.mmc2_dat3 */
-			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
-			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc1_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a1.mmc2_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a2.mmc2_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a3.mmc2_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ben1.mmc2_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_clk.mmc1_clk */
 			/* WLAN nReset */
-			AM33XX_IOPAD(0x860, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_a8.gpio1_24 */
 			/* WLAN nPower down */
-			AM33XX_IOPAD(0x870, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
 			/* 32kHz Clock */
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 		>;
 	};
 };
@@ -498,10 +498,10 @@
 &am33xx_pinmux {
 	spi0_pins: pinmux_spi0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE0) /* spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP, MUX_MODE0) /* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE0) /* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0) /* spi0_d1.spi0_d1 */
 		>;
 	};
 };
@@ -539,16 +539,16 @@
 &am33xx_pinmux {
 	uart0_pins: pinmux_uart0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 	uart1_pins: pinmux_uart1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart1_txd.uart1_txd */
 		>;
 	};
 };
@@ -591,9 +591,9 @@
 	usb_pins: pinmux_usb {
 		pinctrl-single,pins = <
 			/* USB0 Over-Current (active low) */
-			AM33XX_IOPAD(0x864, PIN_INPUT | MUX_MODE7)	/* gpmc_a9.gpio1_25 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT, MUX_MODE7)	/* gpmc_a9.gpio1_25 */
 			/* USB1 Over-Current (active low) */
-			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT, MUX_MODE7)	/* gpmc_a10.gpio1_26 */
 		>;
 	};
 };
@@ -649,16 +649,16 @@
 &am33xx_pinmux {
 	user_leds_pins: pinmux_user_leds {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x850, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a4.gpio1_20 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT, MUX_MODE7)	/* gpmc_a4.gpio1_20 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE7)	/* gpmc_a5.gpio1_21 */
 		>;
 	};
 
 	user_buttons_pins: pinmux_user_buttons {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x858, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
-			AM33XX_IOPAD(0x85C, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a7.gpio1_21 */
-			AM33XX_IOPAD(0x964, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio0_7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLUP, MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+			AM33XX_IOPAD(0x85C, PIN_INPUT_PULLUP, MUX_MODE7)	/* gpmc_a7.gpio1_21 */
+			AM33XX_IOPAD(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_INPUT_PULLUP, MUX_MODE7)	/* gpmc_a8.gpio0_7 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 428a25e952b0..ad146fb1bd51 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -57,22 +57,22 @@
 &am33xx_pinmux {
 	ethernet0_pins: pinmux_ethernet0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT | MUX_MODE1)		/* mii1_txen.rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT | MUX_MODE1)		/* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT | MUX_MODE1)		/* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_refclk.rmii1_refclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT, MUX_MODE1)		/* mii1_txen.rmii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT, MUX_MODE1)		/* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT, MUX_MODE1)		/* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* rmii1_refclk.rmii1_refclk */
 		>;
 	};
 
 	mdio_pins: pinmux_mdio {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 };
@@ -108,8 +108,8 @@
 &am33xx_pinmux {
 	i2c0_pins: pinmux_i2c0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 };
@@ -148,20 +148,20 @@
 &am33xx_pinmux {
 		nandflash_pins: pinmux_nandflash {
 			pinctrl-single,pins = <
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 		>;
 	};
 };
@@ -300,10 +300,10 @@
 &am33xx_pinmux {
 	spi0_pins: pinmux_spi0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* spi0_clk.spi0_clk */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_d1.spi0_d1 */
-			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* spi0_clk.spi0_clk */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0)	/* spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE0)	/* spi0_cs0.spi0_cs0 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-pocketbeagle.dts b/arch/arm/boot/dts/am335x-pocketbeagle.dts
index 62fe5cab9fae..13ec8897a636 100644
--- a/arch/arm/boot/dts/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/am335x-pocketbeagle.dts
@@ -62,74 +62,74 @@
 &am33xx_pinmux {
 	i2c2_pins: pinmux-i2c2-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x97c, PIN_INPUT_PULLUP | MUX_MODE3)	/* (D17) uart1_rtsn.I2C2_SCL */
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE3)	/* (D18) uart1_ctsn.I2C2_SDA */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* (D17) uart1_rtsn.I2C2_SCL */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* (D18) uart1_ctsn.I2C2_SDA */
 		>;
 	};
 
 	ehrpwm0_pins: pinmux-ehrpwm0-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x990, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* (A13) mcasp0_aclkx.ehrpwm0A */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKX, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* (A13) mcasp0_aclkx.ehrpwm0A */
 		>;
 	};
 
 	ehrpwm1_pins: pinmux-ehrpwm1-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE6)	/* (U14) gpmc_a2.ehrpwm1A */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_OUTPUT_PULLDOWN, MUX_MODE6)	/* (U14) gpmc_a2.ehrpwm1A */
 		>;
 	};
 
 	mmc0_pins: pinmux-mmc0-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* (C15) spi0_cs1.gpio0[6] */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G16) mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G15) mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* (F18) mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* (F17) mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G18) mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G17) mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x9a0, PIN_INPUT | MUX_MODE4)		/* (B12) mcasp0_aclkr.mmc0_sdwp */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7)		/* (C15) spi0_cs1.gpio0[6] */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* (G16) mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* (G15) mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* (F18) mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* (F17) mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* (G18) mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* (G17) mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT, MUX_MODE4)		/* (B12) mcasp0_aclkr.mmc0_sdwp */
 		>;
 	};
 
 	spi0_pins: pinmux-spi0-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0)	/* (A17) spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0)	/* (B17) spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)	/* (B16) spi0_d1.spi0_d1 */
-			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0)	/* (A16) spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* (A17) spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE0)	/* (B17) spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0)	/* (B16) spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE0)	/* (A16) spi0_cs0.spi0_cs0 */
 		>;
 	};
 
 	spi1_pins: pinmux-spi1-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x964, PIN_INPUT_PULLUP | MUX_MODE4)	/* (C18) eCAP0_in_PWM0_out.spi1_sclk */
-			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE4)	/* (E18) uart0_ctsn.spi1_d0 */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE4)	/* (E17) uart0_rtsn.spi1_d1 */
-			AM33XX_IOPAD(0x9b0, PIN_INPUT_PULLUP | MUX_MODE4)	/* (A15) xdma_event_intr0.spi1_cs1 */
+			AM33XX_IOPAD(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_INPUT_PULLUP, MUX_MODE4)	/* (C18) eCAP0_in_PWM0_out.spi1_sclk */
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLUP, MUX_MODE4)	/* (E18) uart0_ctsn.spi1_d0 */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLUP, MUX_MODE4)	/* (E17) uart0_rtsn.spi1_d1 */
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR0, PIN_INPUT_PULLUP, MUX_MODE4)	/* (A15) xdma_event_intr0.spi1_cs1 */
 		>;
 	};
 
 	usr_leds_pins: pinmux-usr-leds-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)		/* (V15) gpmc_a5.gpio1[21] - USR_LED_0 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT | MUX_MODE7)		/* (U15) gpmc_a6.gpio1[22] - USR_LED_1 */
-			AM33XX_IOPAD(0x85c, PIN_OUTPUT | MUX_MODE7)		/* (T15) gpmc_a7.gpio1[23] - USR_LED_2 */
-			AM33XX_IOPAD(0x860, PIN_OUTPUT | MUX_MODE7)		/* (V16) gpmc_a8.gpio1[24] - USR_LED_3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE7)		/* (V15) gpmc_a5.gpio1[21] - USR_LED_0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_OUTPUT, MUX_MODE7)		/* (U15) gpmc_a6.gpio1[22] - USR_LED_1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_OUTPUT, MUX_MODE7)		/* (T15) gpmc_a7.gpio1[23] - USR_LED_2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_OUTPUT, MUX_MODE7)		/* (V16) gpmc_a8.gpio1[24] - USR_LED_3 */
 		>;
 	};
 
 	uart0_pins: pinmux-uart0-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* (E15) uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* (E16) uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* (E15) uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* (E16) uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart4_pins: pinmux-uart4-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE6)	/* (T17) gpmc_wait0.uart4_rxd */
-			AM33XX_IOPAD(0x874, PIN_OUTPUT_PULLDOWN | MUX_MODE6)	/* (U17) gpmc_wpn.uart4_txd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE6)	/* (T17) gpmc_wait0.uart4_rxd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_OUTPUT_PULLDOWN, MUX_MODE6)	/* (U17) gpmc_wpn.uart4_txd */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe.dts b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
index 35527fdf56cc..1968298d4c5d 100644
--- a/arch/arm/boot/dts/am335x-sancloud-bbe.dts
+++ b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
@@ -23,70 +23,70 @@
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	usb_hub_ctrl: usb_hub_ctrl {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLUP | MUX_MODE7)     /* rmii1_refclk.gpio0_29 */
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_OUTPUT_PULLUP, MUX_MODE7)     /* rmii1_refclk.gpio0_29 */
 		>;
 	};
 
 	mpu6050_pins: pinmux_mpu6050_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_INPUT | MUX_MODE7)    /* uart0_ctsn.gpio1_8 */
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_INPUT, MUX_MODE7)    /* uart0_ctsn.gpio1_8 */
 		>;
 	};
 
 	lps3331ap_pins: pinmux_lps3331ap_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE7)     /* gpmc_a10.gpio1_26 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT, MUX_MODE7)     /* gpmc_a10.gpio1_26 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-sbc-t335.dts b/arch/arm/boot/dts/am335x-sbc-t335.dts
index 917d7ccc9109..6b21f389f6ea 100644
--- a/arch/arm/boot/dts/am335x-sbc-t335.dts
+++ b/arch/arm/boot/dts/am335x-sbc-t335.dts
@@ -70,122 +70,122 @@
 	lcd_pins_default: lcd_pins_default {
 		pinctrl-single,pins = <
 			/* gpmc_ad8.lcd_data23 */
-			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad9.lcd_data22 */
-			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad10.lcd_data21 */
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad11.lcd_data20 */
-			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad12.lcd_data19 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad13.lcd_data18 */
-			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad14.lcd_data17 */
-			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad15.lcd_data16 */
-			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_OUTPUT, MUX_MODE1)
 			/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE0)
 			/* lcd_ac_bias_en.lcd_ac_bias_en */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
 	lcd_pins_sleep: lcd_pins_sleep {
 		pinctrl-single,pins = <
 			/* gpmc_ad8.lcd_data23 */
-			AM33XX_IOPAD(0x820, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad9.lcd_data22 */
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad10.lcd_data21 */
-			AM33XX_IOPAD(0x828, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad11.lcd_data20 */
-			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad12.lcd_data19 */
-			AM33XX_IOPAD(0x830, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad13.lcd_data18 */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad14.lcd_data17 */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad15.lcd_data16 */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a0, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a4, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8a8, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8ac, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b0, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b4, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8b8, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8bc, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c0, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c4, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8c8, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8cc, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d0, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d4, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8d8, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PULL_DISABLE, MUX_MODE7)
 			/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x8dc, PULL_DISABLE | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PULL_DISABLE, MUX_MODE7)
 			/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* lcd_ac_bias_en.lcd_ac_bias_en */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 5b250060f6dd..0a8180affe70 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -384,193 +384,193 @@
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
 			/* xdma_event_intr1.clkout2 */
-			AM33XX_IOPAD(0x9b4, PIN_INPUT | MUX_MODE6)
+			AM33XX_IOPAD(AM335X_PIN_XDMA_EVENT_INTR1, PIN_INPUT, MUX_MODE6)
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE0)
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
 			/* mdio_clk.mdio_clk */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	ehrpwm1_pins: pinmux_ehrpwm1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE6) /* gpmc_a3.gpio1_19 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_OUTPUT, MUX_MODE6) /* gpmc_a3.gpio1_19 */
 		>;
 	};
 
 	emmc_pins: pinmux_emmc_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT | MUX_MODE2)
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT, MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1)
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0)
-			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT, MUX_MODE0)
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE5)
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE5)
 		>;
 	};
 
 	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x830, PIN_INPUT | MUX_MODE3)
-			AM33XX_IOPAD(0x834, PIN_INPUT | MUX_MODE3)
-			AM33XX_IOPAD(0x838, PIN_INPUT | MUX_MODE3)
-			AM33XX_IOPAD(0x83c, PIN_INPUT | MUX_MODE3)
-			AM33XX_IOPAD(0x888, PIN_INPUT | MUX_MODE3)
-			AM33XX_IOPAD(0x88c, PIN_INPUT | MUX_MODE3)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_INPUT, MUX_MODE3)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_INPUT, MUX_MODE3)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_INPUT, MUX_MODE3)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_INPUT, MUX_MODE3)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN3, PIN_INPUT, MUX_MODE3)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CLK, PIN_INPUT, MUX_MODE3)
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x96c, PIN_OUTPUT | MUX_MODE0)
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x974, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
 	uart1_pins: pinmux_uart1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)
-			AM33XX_IOPAD(0x97C, PIN_OUTPUT | MUX_MODE0)
-			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)
-			AM33XX_IOPAD(0x984, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE1)
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)
 		>;
 	};
 
 	uart4_pins: pinmux_uart4_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE6)
-			AM33XX_IOPAD(0x874, PIN_OUTPUT_PULLUP | MUX_MODE6)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE6)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_OUTPUT_PULLUP, MUX_MODE6)
 		>;
 	};
 
 	user_leds_s0: user_leds_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x844, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x858, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x85c, PIN_OUTPUT_PULLUP | MUX_MODE7)
-			AM33XX_IOPAD(0x860, PIN_INPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x864, PIN_INPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x86c, PIN_INPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x878, PIN_OUTPUT_PULLUP | MUX_MODE7)
-			AM33XX_IOPAD(0x87c, PIN_INPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x894, PIN_INPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x958, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x95c, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x964, PIN_OUTPUT_PULLUP | MUX_MODE7)
-			AM33XX_IOPAD(0x9a0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x9a4, PIN_OUTPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x9a8, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLUP | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD11, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_OUTPUT_PULLUP, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_INPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN1, PIN_OUTPUT_PULLUP, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN0, PIN_INPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_OEN_REN, PIN_INPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS0, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_OUTPUT_PULLUP, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKR, PIN_OUTPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_FSR, PIN_OUTPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AXR1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKX, PIN_INPUT_PULLUP, MUX_MODE7)
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 38d57b89f7d3..9728b2e8da03 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -218,227 +218,227 @@
 
 	audio_pins: pinmux_audio_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
-			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mcasp0_ahclkr.mcasp0_axr2 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKX, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_FSX, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKX, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AXR0, PIN_INPUT_PULLDOWN, MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AHCLKR, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mcasp0_ahclkr.mcasp0_axr2 */
 		>;
 	};
 
 	audio_pa_pins: pinmux_audio_pa_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* SoundPA_en - mcasp0_aclkr.gpio3_18 */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* SoundPA_en - mcasp0_aclkr.gpio3_18 */
 		>;
 	};
 
 	audio_mclk_pins: pinmux_audio_mclk_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a11.gpio1_27 */
 		>;
 	};
 
 	backlight0_pins: pinmux_backlight0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE7)	/* gpmc_wen.gpio2_4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE7)	/* gpmc_wen.gpio2_4 */
 		>;
 	};
 
 	backlight1_pins: pinmux_backlight1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE7)     /* gpmc_ad10.gpio0_26 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE7)     /* gpmc_ad10.gpio0_26 */
 		>;
 	};
 
 	lcd_pins: pinmux_lcd_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)	/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)	/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)	/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)	/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)	/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)	/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)	/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)	/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)	/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)	/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)	/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)	/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)	/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)	/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)	/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)	/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(AM335X_PIN_LCD_PCLK, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
 		>;
 	};
 
 	led_pins: pinmux_led_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
-			AM33XX_IOPAD(0x85c, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a7.gpio1_23 */
-			AM33XX_IOPAD(0x860, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_OUTPUT, MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_OUTPUT, MUX_MODE7)	/* gpmc_a7.gpio1_23 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_OUTPUT, MUX_MODE7)	/* gpmc_a8.gpio1_24 */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart1_txd.uart1_txd */
 		>;
 	};
 
 	uart4_pins: pinmux_uart4_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE6)	/* gpmc_wait0.uart4_rxd */
-			AM33XX_IOPAD(0x874, PIN_OUTPUT_PULLDOWN | MUX_MODE6)	/* gpmc_wpn.uart4_txd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE6)	/* gpmc_wait0.uart4_rxd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_OUTPUT_PULLDOWN, MUX_MODE6)	/* gpmc_wpn.uart4_txd */
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
-			AM33XX_IOPAD(0x97c, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxerr.mii1_rxerr */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txen.mii1_txen */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxdv.mii1_rxdv */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd3.mii1_txd3 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd2.mii1_txd2 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd1.mii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd0.mii1_txd0 */
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_txclk.mii1_txclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxclk.mii1_rxclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd3.mii1_rxd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd2.mii1_rxd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd1.mii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd0.mii1_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxerr.mii1_rxerr */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* mii1_txen.mii1_txen */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxdv.mii1_rxdv */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* mii1_txd3.mii1_txd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* mii1_txd2.mii1_txd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* mii1_txd1.mii1_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* mii1_txd0.mii1_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_txclk.mii1_txclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxclk.mii1_rxclk */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxd3.mii1_rxd3 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxd2.mii1_rxd2 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxd1.mii1_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mii1_rxd0.mii1_rxd0 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 			/* Ethernet */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE7)	/* Ethernet_nRST - gpmc_ad14.gpio1_14 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE7)	/* Ethernet_nRST - gpmc_ad14.gpio1_14 */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_IOPAD(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x96c, PIN_INPUT | MUX_MODE7)		/* uart0_rtsn.gpio1_9 */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_INPUT, MUX_MODE7)		/* uart0_rtsn.gpio1_9 */
 		>;
 	};
 
 	emmc_pwrseq_pins: pinmux_emmc_pwrseq_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a4.gpio1_20 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_a4.gpio1_20 */
 		>;
 	};
 
 	emmc_pins: pinmux_emmc_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1) 	/* gpmc_ad5.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1) 	/* gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
 		>;
 	};
 
 	ehrpwm1_pins: pinmux_ehrpwm1a_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE6)	/* gpmc_a2.ehrpwm1a */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE6)	/* gpmc_a3.ehrpwm1b */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_OUTPUT, MUX_MODE6)	/* gpmc_a2.ehrpwm1a */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_OUTPUT, MUX_MODE6)	/* gpmc_a3.ehrpwm1b */
 		>;
 	};
 
 	rtc0_irq_pins: pinmux_rtc0_irq_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE7)     /* gpmc_ad9.gpio0_23 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLUP, MUX_MODE7)     /* gpmc_ad9.gpio0_23 */
 		>;
 	};
 
 	spi0_pins: pinmux_spi0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_MOSI - spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_MISO - spi0_d1.spi0_d1 */
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_CLK  - spi0_clk.spi0_clk */
-			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_CS0 (NBATTSS) - spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_CS1 (FPGA_FLASH_NCS) - spi0_cs1.spi0_cs1 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE0)	/* SPI0_MOSI - spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0)	/* SPI0_MISO - spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* SPI0_CLK  - spi0_clk.spi0_clk */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE0)	/* SPI0_CS0 (NBATTSS) - spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT_PULLUP, MUX_MODE0)	/* SPI0_CS1 (FPGA_FLASH_NCS) - spi0_cs1.spi0_cs1 */
 		>;
 	};
 
 	lwb_pins: pinmux_lwb_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE7)	/* nKbdInt - gpmc_ad12.gpio1_12 */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE7)	/* nKbdReset - gpmc_ad13.gpio1_13 */
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE7)	/* USB1_enPower - gpmc_a1.gpio1_17 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLUP, MUX_MODE7)	/* nKbdInt - gpmc_ad12.gpio1_12 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLUP, MUX_MODE7)	/* nKbdReset - gpmc_ad13.gpio1_13 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLUP, MUX_MODE7)	/* USB1_enPower - gpmc_a1.gpio1_17 */
 			/* PDI Bus - Battery system */
-			AM33XX_IOPAD(0x840, PIN_INPUT_PULLUP | MUX_MODE7)	/* nBattReset  gpmc_a0.gpio1_16 */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE7)	/* BattPDIData gpmc_ad15.gpio1_15 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_INPUT_PULLUP, MUX_MODE7)	/* nBattReset  gpmc_a0.gpio1_16 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE7)	/* BattPDIData gpmc_ad15.gpio1_15 */
 			/* FPGA */
-			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE7)	/* FPGA_DONE - gpmc_ad8.gpio0_22 */
-			AM33XX_IOPAD(0x840, PIN_INPUT_PULLUP | MUX_MODE7)	/* FPGA_NRST - gpmc_a0.gpio1_16 */
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* FPGA_RUN - gpmc_a1.gpio1_17 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLUP | MUX_MODE7)	/* ENFPGA - gpmc_a9.gpio1_25 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* FPGA_PROGRAM - gpmc_a10.gpio1_26 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLUP, MUX_MODE7)	/* FPGA_DONE - gpmc_ad8.gpio0_22 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_INPUT_PULLUP, MUX_MODE7)	/* FPGA_NRST - gpmc_a0.gpio1_16 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* FPGA_RUN - gpmc_a1.gpio1_17 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLUP, MUX_MODE7)	/* ENFPGA - gpmc_a9.gpio1_25 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* FPGA_PROGRAM - gpmc_a10.gpio1_26 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 8ce541739b24..5f420be228f9 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -32,11 +32,11 @@
 &am33xx_pinmux {
 	mcasp0_pins: pinmux_mcasp0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9AC, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_ahclkx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_axr0.mcasp0_axr0 */
-			AM33XX_IOPAD(0x9A8, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_axr1.mcasp0_axr1 */
+			AM33XX_IOPAD(0x9AC, PIN_OUTPUT_PULLDOWN, MUX_MODE0) /* mcasp0_ahclkx.mcasp0_ahclkx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_ACLKX, PIN_INPUT_PULLDOWN, MUX_MODE0)  /* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_FSX, PIN_INPUT_PULLDOWN, MUX_MODE0)  /* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(AM335X_PIN_MCASP0_AXR0, PIN_INPUT_PULLDOWN, MUX_MODE0)  /* mcasp0_axr0.mcasp0_axr0 */
+			AM33XX_IOPAD(0x9A8, PIN_OUTPUT_PULLDOWN, MUX_MODE0) /* mcasp0_axr1.mcasp0_axr1 */
 		>;
 	};
 };
@@ -84,8 +84,8 @@
 &am33xx_pinmux {
 	dcan1_pins: pinmux_dcan1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT_PULLUP | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+			AM33XX_IOPAD(AM335X_PIN_UART0_CTSN, PIN_OUTPUT_PULLUP, MUX_MODE2) /* uart0_ctsn.d_can1_tx */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLUP, MUX_MODE2) /* uart0_rtsn.d_can1_rx */
 		>;
 	};
 };
@@ -100,20 +100,20 @@
 &am33xx_pinmux {
 	ethernet1_pins: pinmux_ethernet1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a0.mii2_txen */
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a1.mii2_rxdv */
-			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a2.mii2_txd3 */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a3.mii2_txd2 */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a4.mii2_txd1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a5.mii2_txd0 */
-			AM33XX_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a6.mii2_txclk */
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a7.mii2_rxclk */
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a8.mii2_rxd3 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a9.mii2_rxd2 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a10.mii2_rxd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a11.mii2_rxd0 */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_wpn.mii2_rxerr */
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ben1.mii2_col */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A0, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a0.mii2_txen */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a1.mii2_rxdv */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A2, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a2.mii2_txd3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A3, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a3.mii2_txd2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A4, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a4.mii2_txd1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a5.mii2_txd0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a6.mii2_txclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a7.mii2_rxclk */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a8.mii2_rxd3 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a9.mii2_rxd2 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a10.mii2_rxd1 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a11.mii2_rxd0 */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_wpn.mii2_rxerr */
+			AM33XX_IOPAD(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_ben1.mii2_col */
 		>;
 	};
 };
@@ -141,13 +141,13 @@
 &am33xx_pinmux {
 	mmc1_pins: pinmux_mmc1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(AM335X_PIN_SPI0_CS1, PIN_INPUT_PULLUP, MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
 		>;
 	};
 };
@@ -171,17 +171,17 @@
 &am33xx_pinmux {
 	uart0_pins: pinmux_uart0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)    /* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0) /* uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
-			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(AM335X_PIN_UART1_CTSN, PIN_INPUT, MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index e5c2f71a7c77..fe39c28f951c 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/am33xx.h>
+#include <dt-bindings/pinctrl/am335x.h>
 #include <dt-bindings/clock/am3.h>
 
 / {
diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
index 49b5dea2b388..d854d01bf9d4 100644
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -64,7 +64,7 @@
 #define OMAP3_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2a00) (val)
 #define DM814X_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
 #define DM816X_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
-#define AM33XX_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
+#define AM33XX_IOPAD(pa, dir, mux)	(OMAP_IOPAD_OFFSET((pa), 0x0800) ((dir)|(mux)))
 
 /*
  * Macros to allow using the offset from the padconf physical address
-- 
2.20.1
