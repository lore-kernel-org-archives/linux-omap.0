From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 8/9] ARM: dts: omap3-beagle: Make USB host pin naming consistent
Date: Wed, 14 Aug 2013 16:58:12 +0300
Message-ID: <1376488693-31659-9-git-send-email-rogerq@ti.com>
References: <1376488693-31659-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56371 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759804Ab3HNN7C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 09:59:02 -0400
In-Reply-To: <1376488693-31659-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, tony@atomide.com, bcousson@baylibre.com
Cc: p.zabel@pengutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Use a common naming scheme "mode0name.modename flags" for the
USB host pins to be consistent.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index a6dcc71..30f51f4 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -90,18 +90,18 @@
 
 	hsusbb2_pins: pinmux_hsusbb2_pins {
 		pinctrl-single,pins = <
-			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* usbb2_ulpitll_clk.usbb1_ulpiphy_clk */
-			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* usbb2_ulpitll_clk.usbb1_ulpiphy_stp */
-			0x5c4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dir */
-			0x5c6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_nxt */
-			0x5c8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat0 */
-			0x5cA (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat1 */
-			0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat2 */
-			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat3 */
-			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat4 */
-			0x1aa (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat5 */
-			0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat6 */
-			0x1ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat7 */
+			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
+			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
+			0x5c4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
+			0x5c6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
+			0x5c8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
+			0x5cA (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
+			0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
+			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
+			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
+			0x1aa (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 */
+			0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 */
+			0x1ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
 		>;
 	};
 
-- 
1.7.4.1

