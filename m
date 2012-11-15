From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/4] ARM: OMAP4: USB: Add pin mux configuration for panda board
Date: Thu, 15 Nov 2012 16:56:34 +0200
Message-ID: <1352991396-19589-3-git-send-email-rogerq@ti.com>
References: <1352991396-19589-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55790 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768071Ab2KOO4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 09:56:42 -0500
In-Reply-To: <1352991396-19589-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, balbi@ti.com, keshava_mgowda@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, rogerq@ti.com

From: Keshava Munegowda <keshava_mgowda@ti.com>

The port1 of omap4 panda board is used in ULPI PHY mode.
The pin mux of usbhs (usbb1) port 1 is configured accordingly.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index e8f927c..6811b37 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -65,6 +65,7 @@
 			&twl6040_pins
 			&mcpdm_pins
 			&mcbsp1_pins
+			&usbb1_pins	/* port 0 of omap usb host port pin mux configuration */
 	>;
 
 	twl6040_pins: pinmux_twl6040_pins {
@@ -92,6 +93,23 @@
 			0xc4 0x100	/* abe_mcbsp1_fsx.abe_mcbsp1_fsx INPUT | MODE0 */
 		>;
 	};
+
+	usbb1_pins: pinmux_usbb1_pins {
+		pinctrl-single,pins = <
+			0x82 0x10C  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk INPUT | PULLDOWN */
+			0x84 0x4  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT */
+			0x86 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT | PULLDOWN */
+			0x88 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT | PULLDOWN */
+			0x8a 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT | PULLDOWN */
+			0x8c 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT | PULLDOWN */
+			0x8e 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 INPUT | PULLDOWN */
+			0x90 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 INPUT | PULLDOWN */
+			0x92 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 INPUT | PULLDOWN */
+			0x94 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 INPUT | PULLDOWN */
+			0x96 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 INPUT | PULLDOWN */
+			0x98 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT | PULLDOWN */
+		>;
+	};
 };
 
 &i2c1 {
-- 
1.7.4.1

