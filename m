From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/6] arm: boot: dts: am437x-sk: remove ethernet pulls
Date: Thu, 4 Dec 2014 11:01:56 -0600
Message-ID: <1417712519-4615-4-git-send-email-balbi@ti.com>
References: <1417712519-4615-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48412 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932477AbaLDRCZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 12:02:25 -0500
In-Reply-To: <1417712519-4615-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

AM437x Starter Kit already has discrete pulls
where they are necessary. It's safe (and actually
better) to remove internal pulls.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 52 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 5d872f6..68b9529 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -193,32 +193,32 @@
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			0x12c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rmii1_tclk */
-			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td2 */
-			0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td3 */
-			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
-			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
-			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
-			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd2 */
-			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd3 */
+			0x12c (PIN_OUTPUT | MUX_MODE2)	/* mii1_txclk.rmii1_tclk */
+			0x114 (PIN_OUTPUT | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			0x128 (PIN_OUTPUT | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			0x124 (PIN_OUTPUT | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			0x120 (PIN_OUTPUT | MUX_MODE2)	/* mii1_txd0.rgmii1_td2 */
+			0x11c (PIN_OUTPUT | MUX_MODE2)	/* mii1_txd1.rgmii1_td3 */
+			0x130 (PIN_INPUT | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
+			0x118 (PIN_INPUT | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			0x140 (PIN_INPUT | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
+			0x13c (PIN_INPUT | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
+			0x138 (PIN_INPUT | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd2 */
+			0x134 (PIN_INPUT | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd3 */
 
 			/* Slave 2 */
-			0x58 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
-			0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
-			0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
-			0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
-			0x4c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
-			0x48 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
-			0x5c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
-			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rtcl */
-			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
-			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
-			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
-			0x60 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
+			0x58 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
+			0x40 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
+			0x54 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
+			0x50 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
+			0x4c (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
+			0x48 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
+			0x5c (PIN_INPUT | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
+			0x44 (PIN_INPUT | MUX_MODE2)	/* gpmc_a1.rgmii2_rtcl */
+			0x6c (PIN_INPUT | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
+			0x68 (PIN_INPUT | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
+			0x64 (PIN_INPUT | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
+			0x60 (PIN_INPUT | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
 		>;
 	};
 
@@ -257,8 +257,8 @@
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			0x148 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			0x14c (PIN_OUTPUT | MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
-- 
2.1.0.GIT

