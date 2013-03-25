From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 2/3] ARM: dts: AM33XX: Add pinmux configuration for CPSW to EVMsk
Date: Mon, 25 Mar 2013 12:57:57 +0530
Message-ID: <1364196478-16688-3-git-send-email-mugunthanvnm@ti.com>
References: <1364196478-16688-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56856 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab3CYH2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Mar 2013 03:28:13 -0400
In-Reply-To: <1364196478-16688-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, benoit.cousson@linaro.org, tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>

Add pinmux configurations for RGMII based CPSW ethernet to am335x-evmsk.
In this patch, only single named mode/state is added and these pins
are configured during pinctrl driver initialization.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |   38 +++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index f297b85..9b29ad4 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -32,7 +32,7 @@
 
 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0 &gpio_keys_s0>;
+		pinctrl-0 = <&user_leds_s0 &gpio_keys_s0 &cpsw_s0>;
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -51,6 +51,42 @@
 				0x9c 0x27	/* gpmc_ben0_cle.gpio2_5, INPUT | MODE7 */
 			>;
 		};
+
+		cpsw_s0: cpsw_s0 {
+			pinctrl-single,pins = <
+				/* Slave 1 */
+				0x114 0x2	/* mii1_txen.rgmii1_tctl, MODE2 | OUTPUT */
+				0x118 0x22	/* mii1_rxdv.rgmii1_rctl, MODE2 | INPUT_PULLDOWN */
+				0x11c 0x2	/* mii1_txd3.rgmii1_td3, MODE2 | OUTPUT */
+				0x120 0x2	/* mii1_txd2.rgmii1_td2, MODE2 | OUTPUT */
+				0x124 0x2	/* mii1_txd1.rgmii1_td1, MODE2 | OUTPUT */
+				0x128 0x2	/* mii1_txd0.rgmii1_td0, MODE2 | OUTPUT */
+				0x12c 0x2	/* mii1_txclk.rgmii1_tclk, MODE2 | OUTPUT */
+				0x130 0x22	/* mii1_rxclk.rgmii1_rclk, MODE2 | INPUT_PULLDOWN */
+				0x134 0x22	/* mii1_rxd3.rgmii1_rd3, MODE2 | INPUT_PULLDOWN */
+				0x138 0x22	/* mii1_rxd2.rgmii1_rd2, MODE2 | INPUT_PULLDOWN */
+				0x13c 0x22	/* mii1_rxd1.rgmii1_rd1, MODE2 | INPUT_PULLDOWN */
+				0x140 0x22	/* mii1_rxd0.rgmii1_rd0, MODE2 | INPUT_PULLDOWN */
+
+				/* Slave 2 */
+				0x40 0x2	/* gpmc_a0.rgmii2_tctl", MODE2 | OUTPUT */
+				0x44 0x22	/* gpmc_a1.rgmii2_rctl", MODE2 | INPUT_PULLDOWN */
+				0x48 0x2	/* gpmc_a2.rgmii2_td3", MODE2 | OUTPUT */
+				0x4c 0x2	/* gpmc_a3.rgmii2_td2", MODE2 | OUTPUT */
+				0x50 0x2	/* gpmc_a4.rgmii2_td1", MODE2 | OUTPUT */
+				0x54 0x2	/* gpmc_a5.rgmii2_td0", MODE2 | OUTPUT */
+				0x58 0x2	/* gpmc_a6.rgmii2_tclk", MODE2 | OUTPUT */
+				0x5c 0x22	/* gpmc_a7.rgmii2_rclk", MODE2 | INPUT_PULLDOWN */
+				0x60 0x22	/* gpmc_a8.rgmii2_rd3", MODE2 | INPUT_PULLDOWN */
+				0x64 0x22	/* gpmc_a9.rgmii2_rd2", MODE2 | INPUT_PULLDOWN */
+				0x68 0x22	/* gpmc_a10.rgmii2_rd1", MODE2 | INPUT_PULLDOWN */
+				0x6c 0x22	/* gpmc_a11.rgmii2_rd0", MODE2 | INPUT_PULLDOWN */
+
+				/* MDIO */
+				0x148 0x30	/* mdio_data.mdio_data, MODE0 | INPUT_PULLUP */
+				0x14c 0x10	/* mdio_clk.mdio_clk, MODE0 | OUTPUT_PULLUP */
+			>;
+		};
 	};
 
 	ocp {
-- 
1.7.9.5

