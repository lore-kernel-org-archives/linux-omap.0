From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 24/39] ARM: dts: omap3-beagle-xm: Use OMAP3_*_IOPAD pinmux macros
Date: Fri, 13 Nov 2015 01:54:02 -0300
Message-ID: <1447390457-1158-25-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use the pinmux IOPAD macros to define the register absolute physical
address instead of the offset from the padconf base address. This
makes the DTS easier to read since matches the addresses listed in
the Technical Reference Manual.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-beagle-xm.dts | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 73f1e3a8f62c..5e0bf475051e 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -176,18 +176,18 @@
 &omap3_pmx_wkup {
 	gpio1_pins: pinmux_gpio1_pins {
 		pinctrl-single,pins = <
-			0x0e (PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE4) /* sys_boot2.gpio_4 */
+			OMAP3_WKUP_IOPAD(0x2a0e, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE4) /* sys_boot2.gpio_4 */
 		>;
 	};
 
 	dss_dpi_pins2: pinmux_dss_dpi_pins1 {
 		pinctrl-single,pins = <
-			0x0a (PIN_OUTPUT | MUX_MODE3)   /* sys_boot0.dss_data18 */
-			0x0c (PIN_OUTPUT | MUX_MODE3)   /* sys_boot1.dss_data19 */
-			0x10 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot3.dss_data20 */
-			0x12 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot4.dss_data21 */
-			0x14 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot5.dss_data22 */
-			0x16 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot6.dss_data23 */
+			OMAP3_WKUP_IOPAD(0x2a0a, PIN_OUTPUT | MUX_MODE3)   /* sys_boot0.dss_data18 */
+			OMAP3_WKUP_IOPAD(0x2a0c, PIN_OUTPUT | MUX_MODE3)   /* sys_boot1.dss_data19 */
+			OMAP3_WKUP_IOPAD(0x2a10, PIN_OUTPUT | MUX_MODE3)   /* sys_boot3.dss_data20 */
+			OMAP3_WKUP_IOPAD(0x2a12, PIN_OUTPUT | MUX_MODE3)   /* sys_boot4.dss_data21 */
+			OMAP3_WKUP_IOPAD(0x2a14, PIN_OUTPUT | MUX_MODE3)   /* sys_boot5.dss_data22 */
+			OMAP3_WKUP_IOPAD(0x2a16, PIN_OUTPUT | MUX_MODE3)   /* sys_boot6.dss_data23 */
 		>;
 	};
 };
@@ -200,8 +200,8 @@
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			0x16e (PIN_INPUT | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
-			0x170 (PIN_OUTPUT | MUX_MODE0)	/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)	/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */
 		>;
 	};
 
-- 
2.4.3
