From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 06/15] ARM: dts: am335x: base0033: Replaced register offsets with defines
Date: Tue,  9 Apr 2019 18:03:37 +0200
Message-ID: <20190409160346.25599-7-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-base0033.dts | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
index 29782be07605..cbd5bd8c57de 100644
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
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT, MUX_MODE3)	/* xdma_event_intr0.clkout1 */
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
 	nxp_hdmi_off_pins: pinmux_nxp_hdmi_off_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE3)	/* xdma_event_intr0.clkout1 */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT, MUX_MODE3)	/* xdma_event_intr0.clkout1 */
 		>;
 	};
 
 	leds_base_pins: pinmux_leds_base_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
-			AM33XX_IOPAD(0x888, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
 		>;
 	};
 };
-- 
2.20.1
