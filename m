From: Darren Etheridge <detheridge@ti.com>
Subject: [PATCH] arm/dts: am335x-evmsk enable display and lcd panel support
Date: Tue, 22 Apr 2014 15:37:43 -0500
Message-ID: <1398199063-3026-1-git-send-email-detheridge@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54681 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758440AbaDVUj2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 16:39:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

Add the necessary nodes to enable the LCD controller and the
LCD panel that is attached to the Texas Instruments AM335x
EVMSK platform.  Also setup the necessary pin mux within the
DT file to drive the LCD connector and add the correct
pinmux settings for the lcd pins to be configured to when
the SoC goes into sleep state for the minimum power
consumption.

For the sleep mode LCD pin settings, MUX_MODE7 is chosen as
this corresponds to switching the pins into input GPIO's with
an internal pulldown.  Which has been determined to offer the
lowest power solution vs leaving the pins configured in LCD
mode.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 105 +++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index ec08f6f..a5e1ab8 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -138,12 +138,113 @@
 			"Headphone Jack",       "HPLOUT",
 			"Headphone Jack",       "HPROUT";
 	};
+
+	panel {
+		compatible = "ti,tilcdc,panel";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&lcd_pins_default>;
+		pinctrl-1 = <&lcd_pins_sleep>;
+		status = "okay";
+		panel-info {
+			ac-bias           = <255>;
+			ac-bias-intrpt    = <0>;
+			dma-burst-sz      = <16>;
+			bpp               = <32>;
+			fdd               = <0x80>;
+			sync-edge         = <0>;
+			sync-ctrl         = <1>;
+			raster-order      = <0>;
+			fifo-th           = <0>;
+		};
+		display-timings {
+			480x272 {
+				hactive         = <480>;
+				vactive         = <272>;
+				hback-porch     = <43>;
+				hfront-porch    = <8>;
+				hsync-len       = <4>;
+				vback-porch     = <12>;
+				vfront-porch    = <4>;
+				vsync-len       = <10>;
+				clock-frequency = <9000000>;
+				hsync-active    = <0>;
+				vsync-active    = <0>;
+			};
+		};
+	};
 };
 
 &am33xx_pinmux {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpio_keys_s0 &clkout2_pin>;
 
+	lcd_pins_default: lcd_pins_default {
+		pinctrl-single,pins = <
+			0x20 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data16 */
+			0x24 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data17 */
+			0x28 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data18 */
+			0x2c (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data19 */
+			0x30 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data20 */
+			0x34 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data21 */
+			0x38 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data22 */
+			0x3c (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data23 */
+			0xa0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
+			0xa4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
+			0xa8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
+			0xac (PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
+			0xb0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
+			0xb4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
+			0xb8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
+			0xbc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
+			0xc0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
+			0xc4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
+			0xc8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
+			0xcc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
+			0xd0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
+			0xd4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
+			0xd8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
+			0xdc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
+			0xe0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
+			0xe4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
+			0xe8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
+			0xec (PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+		>;
+	};
+
+	lcd_pins_sleep: lcd_pins_sleep {
+		pinctrl-single,pins = <
+			0x20 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad8.lcd_data16 */
+			0x24 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad9.lcd_data17 */
+			0x28 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad10.lcd_data18 */
+			0x2c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad11.lcd_data19 */
+			0x30 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad12.lcd_data20 */
+			0x34 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad13.lcd_data21 */
+			0x38 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad14.lcd_data22 */
+			0x3c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad15.lcd_data23 */
+			0xa0 (PULL_DISABLE | MUX_MODE7)		/* lcd_data0.lcd_data0 */
+			0xa4 (PULL_DISABLE | MUX_MODE7)		/* lcd_data1.lcd_data1 */
+			0xa8 (PULL_DISABLE | MUX_MODE7)		/* lcd_data2.lcd_data2 */
+			0xac (PULL_DISABLE | MUX_MODE7)		/* lcd_data3.lcd_data3 */
+			0xb0 (PULL_DISABLE | MUX_MODE7)		/* lcd_data4.lcd_data4 */
+			0xb4 (PULL_DISABLE | MUX_MODE7)		/* lcd_data5.lcd_data5 */
+			0xb8 (PULL_DISABLE | MUX_MODE7)		/* lcd_data6.lcd_data6 */
+			0xbc (PULL_DISABLE | MUX_MODE7)		/* lcd_data7.lcd_data7 */
+			0xc0 (PULL_DISABLE | MUX_MODE7)		/* lcd_data8.lcd_data8 */
+			0xc4 (PULL_DISABLE | MUX_MODE7)		/* lcd_data9.lcd_data9 */
+			0xc8 (PULL_DISABLE | MUX_MODE7)		/* lcd_data10.lcd_data10 */
+			0xcc (PULL_DISABLE | MUX_MODE7)		/* lcd_data11.lcd_data11 */
+			0xd0 (PULL_DISABLE | MUX_MODE7)		/* lcd_data12.lcd_data12 */
+			0xd4 (PULL_DISABLE | MUX_MODE7)		/* lcd_data13.lcd_data13 */
+			0xd8 (PULL_DISABLE | MUX_MODE7)		/* lcd_data14.lcd_data14 */
+			0xdc (PULL_DISABLE | MUX_MODE7)		/* lcd_data15.lcd_data15 */
+			0xe0 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.lcd_vsync */
+			0xe4 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.lcd_hsync */
+			0xe8 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.lcd_pclk */
+			0xec (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+		>;
+	};
+
+
 	user_leds_s0: user_leds_s0 {
 		pinctrl-single,pins = <
 			0x10 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
@@ -560,3 +661,7 @@
 		ti,wire-config = <0x00 0x11 0x22 0x33>;
 	};
 };
+
+&lcdc {
+      status = "okay";
+};
-- 
1.8.4

