From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 28/39] ARM: dts: omap3-n9: Use OMAP3_CORE1_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:06 -0300
Message-ID: <1447390457-1158-29-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/omap3-n950-n9.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index e9ee1df0e467..a2c2b8d8dd2c 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -36,12 +36,12 @@
 &omap3_pmx_core {
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			0x128 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_clk */
-			0x12a (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_cmd */
-			0x12c (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat0 */
-			0x12e (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1 */
-			0x130 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat2 */
-			0x132 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat3 */
+			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_clk */
+			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_cmd */
+			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat0 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat2 */
+			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat3 */
 		>;
 	};
 };
-- 
2.4.3
