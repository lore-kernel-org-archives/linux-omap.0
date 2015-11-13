From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 06/39] ARM: dts: am335x-chiliboard: Use AM33XX_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:44 -0300
Message-ID: <1447390457-1158-7-git-send-email-javier@osg.samsung.com>
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

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am335x-chiliboard.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/am335x-chiliboard.dts
index 310da20a8aa7..15d47ab28865 100644
--- a/arch/arm/boot/dts/am335x-chiliboard.dts
+++ b/arch/arm/boot/dts/am335x-chiliboard.dts
@@ -37,26 +37,26 @@
 &am33xx_pinmux {
 	usb1_drvvbus: usb1_drvvbus {
 		pinctrl-single,pins = <
-			0x234 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* usb1_drvvbus.usb1_drvvbus */
+			AM33XX_IOPAD(0xa34, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* usb1_drvvbus.usb1_drvvbus */
 		>;
 	};
 
 	sd_pins: pinmux_sd_card {
 		pinctrl-single,pins = <
-			0xf0 (PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
-			0xf4 (PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
-			0xf8 (PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
-			0xfc (PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
-			0x100 (PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
-			0x104 (PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
-			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			AM33XX_IOPAD(0x8f0, PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x900, PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 		>;
 	};
 
 	led_gpio_pins: led_gpio_pins {
 		pinctrl-single,pins = <
-			0x1e4 (PIN_OUTPUT | MUX_MODE7) /* emu0.gpio3_7 */
-			0x1e8 (PIN_OUTPUT | MUX_MODE7) /* emu1.gpio3_8 */
+			AM33XX_IOPAD(0x9e4, PIN_OUTPUT | MUX_MODE7) /* emu0.gpio3_7 */
+			AM33XX_IOPAD(0x9e8, PIN_OUTPUT | MUX_MODE7) /* emu1.gpio3_8 */
 		>;
 	};
 };
-- 
2.4.3
