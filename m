From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 26/39] ARM: dts: omap3-ldp: Use OMAP3_CORE1_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:04 -0300
Message-ID: <1447390457-1158-27-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/omap3-ldp.dts | 42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index d2fab8c0d4f8..0d0f1a7444f7 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -224,32 +224,32 @@
 &omap3_pmx_core {
 	gpio_key_pins: pinmux_gpio_key_pins {
 		pinctrl-single,pins = <
-			0xea (PIN_INPUT | MUX_MODE4)	/* cam_d2.gpio_101 */
-			0xec (PIN_INPUT | MUX_MODE4)	/* cam_d3.gpio_102 */
-			0xee (PIN_INPUT | MUX_MODE4)	/* cam_d4.gpio_103 */
-			0xf0 (PIN_INPUT | MUX_MODE4)	/* cam_d5.gpio_104 */
-			0xf2 (PIN_INPUT | MUX_MODE4)	/* cam_d6.gpio_105 */
-			0xf4 (PIN_INPUT | MUX_MODE4)	/* cam_d7.gpio_106 */
-			0xf6 (PIN_INPUT | MUX_MODE4)	/* cam_d8.gpio_107 */
-			0xf8 (PIN_INPUT | MUX_MODE4)	/* cam_d9.gpio_108 */
-			0xfa (PIN_INPUT | MUX_MODE4)	/* cam_d10.gpio_109 */
+			OMAP3_CORE1_IOPAD(0x211a, PIN_INPUT | MUX_MODE4)	/* cam_d2.gpio_101 */
+			OMAP3_CORE1_IOPAD(0x211c, PIN_INPUT | MUX_MODE4)	/* cam_d3.gpio_102 */
+			OMAP3_CORE1_IOPAD(0x211e, PIN_INPUT | MUX_MODE4)	/* cam_d4.gpio_103 */
+			OMAP3_CORE1_IOPAD(0x2120, PIN_INPUT | MUX_MODE4)	/* cam_d5.gpio_104 */
+			OMAP3_CORE1_IOPAD(0x2122, PIN_INPUT | MUX_MODE4)	/* cam_d6.gpio_105 */
+			OMAP3_CORE1_IOPAD(0x2124, PIN_INPUT | MUX_MODE4)	/* cam_d7.gpio_106 */
+			OMAP3_CORE1_IOPAD(0x2126, PIN_INPUT | MUX_MODE4)	/* cam_d8.gpio_107 */
+			OMAP3_CORE1_IOPAD(0x2128, PIN_INPUT | MUX_MODE4)	/* cam_d9.gpio_108 */
+			OMAP3_CORE1_IOPAD(0x212a, PIN_INPUT | MUX_MODE4)	/* cam_d10.gpio_109 */
 		>;
 	};
 
 	musb_pins: pinmux_musb_pins {
 		pinctrl-single,pins = <
-			0x172 (PIN_INPUT | MUX_MODE0)	/* hsusb0_clk.hsusb0_clk */
-			0x17a (PIN_INPUT | MUX_MODE0)	/* hsusb0_data0.hsusb0_data0 */
-			0x17c (PIN_INPUT | MUX_MODE0)	/* hsusb0_data1.hsusb0_data1 */
-			0x17e (PIN_INPUT | MUX_MODE0)	/* hsusb0_data2.hsusb0_data2 */
-			0x180 (PIN_INPUT | MUX_MODE0)	/* hsusb0_data3.hsusb0_data3 */
-			0x182 (PIN_INPUT | MUX_MODE0)	/* hsusb0_data4.hsusb0_data4 */
-			0x184 (PIN_INPUT | MUX_MODE0)	/* hsusb0_data5.hsusb0_data5 */
-			0x186 (PIN_INPUT | MUX_MODE0)	/* hsusb0_data6.hsusb0_data6 */
-			0x188 (PIN_INPUT | MUX_MODE0)	/* hsusb0_data7.hsusb0_data7 */
-			0x176 (PIN_INPUT | MUX_MODE0)	/* hsusb0_dir.hsusb0_dir */
-			0x178 (PIN_INPUT | MUX_MODE0)	/* hsusb0_nxt.hsusb0_nxt */
-			0x174 (PIN_OUTPUT | MUX_MODE0)	/* hsusb0_stp.hsusb0_stp */
+			OMAP3_CORE1_IOPAD(0x21a2, PIN_INPUT | MUX_MODE0)	/* hsusb0_clk.hsusb0_clk */
+			OMAP3_CORE1_IOPAD(0x21aa, PIN_INPUT | MUX_MODE0)	/* hsusb0_data0.hsusb0_data0 */
+			OMAP3_CORE1_IOPAD(0x21ac, PIN_INPUT | MUX_MODE0)	/* hsusb0_data1.hsusb0_data1 */
+			OMAP3_CORE1_IOPAD(0x21ae, PIN_INPUT | MUX_MODE0)	/* hsusb0_data2.hsusb0_data2 */
+			OMAP3_CORE1_IOPAD(0x21b0, PIN_INPUT | MUX_MODE0)	/* hsusb0_data3.hsusb0_data3 */
+			OMAP3_CORE1_IOPAD(0x21b2, PIN_INPUT | MUX_MODE0)	/* hsusb0_data4.hsusb0_data4 */
+			OMAP3_CORE1_IOPAD(0x21b4, PIN_INPUT | MUX_MODE0)	/* hsusb0_data5.hsusb0_data5 */
+			OMAP3_CORE1_IOPAD(0x21b6, PIN_INPUT | MUX_MODE0)	/* hsusb0_data6.hsusb0_data6 */
+			OMAP3_CORE1_IOPAD(0x21b8, PIN_INPUT | MUX_MODE0)	/* hsusb0_data7.hsusb0_data7 */
+			OMAP3_CORE1_IOPAD(0x21a6, PIN_INPUT | MUX_MODE0)	/* hsusb0_dir.hsusb0_dir */
+			OMAP3_CORE1_IOPAD(0x21a8, PIN_INPUT | MUX_MODE0)	/* hsusb0_nxt.hsusb0_nxt */
+			OMAP3_CORE1_IOPAD(0x21a4, PIN_OUTPUT | MUX_MODE0)	/* hsusb0_stp.hsusb0_stp */
 		>;
 	};
 
-- 
2.4.3
