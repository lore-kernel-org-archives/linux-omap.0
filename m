From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/3] ARM: dts: am335x-base0033: Use IOPAD pinmux macro
Date: Mon, 19 Oct 2015 17:34:21 +0200
Message-ID: <1445268861-11857-4-git-send-email-javier@osg.samsung.com>
References: <1445268861-11857-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445268861-11857-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use the AM33XX pinmux IOPAD macro to define the physical address instead
of the offset from the padconf address. It makes the DTS easier to read
since matches the addresses listed in the Technical Reference Manual.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/am335x-base0033.dts | 48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
index 72a9b3fc4251..58a05f7d0b7c 100644
--- a/arch/arm/boot/dts/am335x-base0033.dts
+++ b/arch/arm/boot/dts/am335x-base0033.dts
@@ -46,39 +46,39 @@
 &am33xx_pinmux {
 	nxp_hdmi_pins: pinmux_nxp_hdmi_pins {
 		pinctrl-single,pins = <
-			0x1b0 (PIN_OUTPUT | MUX_MODE3)	/* xdma_event_intr0.clkout1 */
-			0xa0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data0 */
-			0xa4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data1 */
-			0xa8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data2 */
-			0xac (PIN_OUTPUT | MUX_MODE0)	/* lcd_data3 */
-			0xb0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data4 */
-			0xb4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data5 */
-			0xb8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data6 */
-			0xbc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data7 */
-			0xc0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data8 */
-			0xc4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data9 */
-			0xc8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data10 */
-			0xcc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data11 */
-			0xd0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data12 */
-			0xd4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data13 */
-			0xd8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data14 */
-			0xdc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data15 */
-			0xe0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync */
-			0xe4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync */
-			0xe8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk */
-			0xec (PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en */
+			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE3)	/* xdma_event_intr0.clkout1 */
+			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0 */
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1 */
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2 */
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3 */
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4 */
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5 */
+			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6 */
+			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7 */
+			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8 */
+			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9 */
+			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10 */
+			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11 */
+			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12 */
+			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13 */
+			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14 */
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15 */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync */
+			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync */
+			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk */
+			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en */
 		>;
 	};
 	nxp_hdmi_off_pins: pinmux_nxp_hdmi_off_pins {
 		pinctrl-single,pins = <
-			0x1b0 (PIN_OUTPUT | MUX_MODE3)	/* xdma_event_intr0.clkout1 */
+			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE3)	/* xdma_event_intr0.clkout1 */
 		>;
 	};
 
 	leds_base_pins: pinmux_leds_base_pins {
 		pinctrl-single,pins = <
-			0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
-			0x88 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_IOPAD(0x888, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
 		>;
 	};
 };
-- 
2.4.3
