From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/2] ARM: dts: omap4-panda-common: Fix pin muxing for wl12xx
Date: Thu, 21 Nov 2013 19:20:03 +0530
Message-ID: <1385041804-19115-2-git-send-email-balajitk@ti.com>
References: <1385041804-19115-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55015 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab3KUNuf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Nov 2013 08:50:35 -0500
In-Reply-To: <1385041804-19115-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Balaji T K <balajitk@ti.com>

pin mux wl12xx_gpio and wl12xx_pins should be part of omap4_pmx_core
and not omap4_pmx_wkup. So, move wl12xx_* to omap4_pmx_core.

Fix the following error message:
pinctrl-single 4a31e040.pinmux: mux offset out of range: 0x38 (0x38)
pinctrl-single 4a31e040.pinmux: could not add functions for pinmux_wl12xx_pins 56x

SDIO card is not detected after moving pin mux to omap4_pmx_core since
sdmmc5_clk pull is disabled. Enable Pull up on sdmmc5_clk to detect SDIO card.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 298e850..88c6a05 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -246,15 +246,6 @@
 			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
 		>;
 	};
-};
-
-&omap4_pmx_wkup {
-	led_wkgpio_pins: pinmux_leds_wkpins {
-		pinctrl-single,pins = <
-			0x1a (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk7 */
-			0x1c (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
-		>;
-	};
 
 	/*
 	 * wl12xx GPIO outputs for WLAN_EN, BT_EN, FM_EN, BT_WAKEUP
@@ -274,7 +265,7 @@
 		pinctrl-single,pins = <
 			0x38 (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs2.gpio_52 */
 			0x3a (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
-			0x108 (PIN_OUTPUT | MUX_MODE0)		/* sdmmc5_clk.sdmmc5_clk */
+			0x108 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_clk.sdmmc5_clk */
 			0x10a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_cmd.sdmmc5_cmd */
 			0x10c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat0.sdmmc5_dat0 */
 			0x10e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1.sdmmc5_dat1 */
@@ -284,6 +275,15 @@
 	};
 };
 
+&omap4_pmx_wkup {
+	led_wkgpio_pins: pinmux_leds_wkpins {
+		pinctrl-single,pins = <
+			0x1a (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk7 */
+			0x1c (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
+		>;
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
-- 
1.7.5.4

