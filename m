From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/2] ARM: dts: omap4-sdp: Fix pin muxing for wl12xx
Date: Thu, 21 Nov 2013 19:20:04 +0530
Message-ID: <1385041804-19115-3-git-send-email-balajitk@ti.com>
References: <1385041804-19115-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55021 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab3KUNup (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Nov 2013 08:50:45 -0500
In-Reply-To: <1385041804-19115-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Balaji T K <balajitk@ti.com>

Mux mode for wlan/sdmmc5 should be MODE0 in pinmux_wl12xx_pins and
Enable Pull up on sdmmc5_clk to detect SDIO card.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 5fc3f43..dbc81fb 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -300,12 +300,12 @@
 	wl12xx_pins: pinmux_wl12xx_pins {
 		pinctrl-single,pins = <
 			0x3a (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
-			0x108 (PIN_OUTPUT | MUX_MODE3)		/* sdmmc5_clk.sdmmc5_clk */
-			0x10a (PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc5_cmd.sdmmc5_cmd */
-			0x10c (PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc5_dat0.sdmmc5_dat0 */
-			0x10e (PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc5_dat1.sdmmc5_dat1 */
-			0x110 (PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc5_dat2.sdmmc5_dat2 */
-			0x112 (PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc5_dat3.sdmmc5_dat3 */
+			0x108 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_clk.sdmmc5_clk */
+			0x10a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_cmd.sdmmc5_cmd */
+			0x10c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat0.sdmmc5_dat0 */
+			0x10e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1.sdmmc5_dat1 */
+			0x110 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat2.sdmmc5_dat2 */
+			0x112 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3.sdmmc5_dat3 */
 		>;
 	};
 };
-- 
1.7.5.4

