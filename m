From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 02/39] ARM: dts: am335x-baltos-ir5221: Remove leftover pinctrl lines
Date: Fri, 13 Nov 2015 01:53:40 -0300
Message-ID: <1447390457-1158-3-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

When the Device Tree source file got merged, some commented pinctrl lines
were left in the file. These are already defined so seems to be a cleanup
that was missed. Delete the unneeded lines from the file.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 7d36601697da..3b42635bc995 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -109,8 +109,6 @@
 		pinctrl-single,pins = <
 			0x180 0x28      /* uart1_rxd, INPUT | MODE0 */
 			0x184 0x28      /* uart1_txd, INPUT | MODE0 */
-			/*0x178 0x28*/      /* uart1_ctsn, INPUT | MODE0 */
-			/*0x17c 0x08*/      /* uart1_rtsn, OUTPUT | MODE0 */
 			0x178 (PIN_INPUT_PULLDOWN | MUX_MODE7)      /* uart1_ctsn, INPUT | MODE0 */
 			0x17c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* uart1_rtsn, OUTPUT | MODE0 */
 			0x0e0 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
@@ -124,8 +122,6 @@
 		pinctrl-single,pins = <
 			0x150 0x29      /* spi0_sclk.uart2_rxd_mux3, INPUT | MODE1 */
 			0x154 0x09      /* spi0_d0.uart2_txd_mux3, OUTPUT | MODE1 */
-			/*0x188 0x2a*/      /* i2c0_sda.uart2_ctsn_mux0, INPUT | MODE2 */
-			/*0x18c 0x2a*/      /* i2c0_scl.uart2_rtsn_mux0, INPUT | MODE2 */
 			0x188 (PIN_INPUT_PULLDOWN | MUX_MODE7)      /* i2c0_sda.uart2_ctsn_mux0 */
 			0x18c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* i2c0_scl.uart2_rtsn_mux0 */
 			0x030 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad12.gpio1[12] DTR */
-- 
2.4.3
