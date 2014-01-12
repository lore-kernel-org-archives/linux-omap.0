From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 01/12] ARM: dts: sbc-t3x: use omap specific pinctrl defines
Date: Sun, 12 Jan 2014 15:22:44 +0200
Message-ID: <1389532975-28281-2-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:41314 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbaALNXE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:04 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Use omap specific pinctrl defines (OMAP3_CORE1_IOPAD) to configure
the padconf register offset.

This simplify further support of CompuLab's boards based on omap36xx,
omap34xx and am35x.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3730.dts  |   36 ++++++++++++++++----------------
 arch/arm/boot/dts/omap3-sbc-t3730.dts |    6 ++--
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/omap3-cm-t3730.dts
index 486f4d6..508cd9b 100644
--- a/arch/arm/boot/dts/omap3-cm-t3730.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3730.dts
@@ -34,44 +34,44 @@
 &omap3_pmx_core {
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
-			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
-			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
-			0x11a (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat1.sdmmc1_dat1 */
-			0x11c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat2.sdmmc1_dat2 */
-			0x11e (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat3.sdmmc1_dat3 */
+			OMAP3_CORE1_IOPAD(0x2144, PIN_OUTPUT_PULLUP | MUX_MODE0)/* sdmmc1_clk.sdmmc1_clk */
+			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
+			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc1_dat0.sdmmc1_dat0 */
+			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc1_dat1.sdmmc1_dat1 */
+			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc1_dat2.sdmmc1_dat2 */
+			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc1_dat3.sdmmc1_dat3 */
 		>;
 	};
 
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
-			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
-			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
-			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1.sdmmc2_dat1 */
-			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
-			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
+			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
+			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
+			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1.sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
+			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
 		>;
 	};
 
 	smsc1_pins: pinmux_smsc1_pins {
 		pinctrl-single,pins = <
-			0x88 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_ncs5.gpmc_ncs5 */
-			0x16a (PIN_INPUT_PULLUP | MUX_MODE4)	/* uart3_cts_rctx.gpio_163 */
+			OMAP3_CORE1_IOPAD(0x20b8, PIN_OUTPUT | MUX_MODE0)	/* gpmc_ncs5.gpmc_ncs5 */
+			OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLUP | MUX_MODE4)	/* uart3_cts_rctx.gpio_163 */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			0x16e (PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
-			0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)	/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
 
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			0xb2 (PIN_OUTPUT | MUX_MODE4)		/* dss_data3.gpio_73 */
-			0x134 (PIN_INPUT | MUX_MODE4)		/* sdmmc2_dat4.gpio_136 */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE4)	/* dss_data3.gpio_73 */
+			OMAP3_CORE1_IOPAD(0x2164, PIN_INPUT | MUX_MODE4)	/* sdmmc2_dat4.gpio_136 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
index c119bd5..0a8849f 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
@@ -23,8 +23,8 @@
 &omap3_pmx_core {
 	smsc2_pins: pinmux_smsc2_pins {
 		pinctrl-single,pins = <
-			0x86 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_ncs4.gpmc_ncs4 */
-			0xa2 (PIN_INPUT_PULLUP | MUX_MODE4)	/* gpmc_wait3.gpio_65 */
+			OMAP3_CORE1_IOPAD(0x20b6, PIN_OUTPUT | MUX_MODE0)	/* gpmc_ncs4.gpmc_ncs4 */
+			OMAP3_CORE1_IOPAD(0x20d2, PIN_INPUT_PULLUP | MUX_MODE4)	/* gpmc_wait3.gpio_65 */
 		>;
 	};
-};
\ No newline at end of file
+};
-- 
1.7.5.4

