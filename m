From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 3/3] ARM: dts: AM33XX: Add pinmux configuration for CPSW to am335x EVM
Date: Mon, 25 Mar 2013 12:57:58 +0530
Message-ID: <1364196478-16688-4-git-send-email-mugunthanvnm@ti.com>
References: <1364196478-16688-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56858 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab3CYH2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Mar 2013 03:28:13 -0400
In-Reply-To: <1364196478-16688-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, benoit.cousson@linaro.org, tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>

Add pinmux configurations for RGMII based CPSW ethernet to am335x-evm.
In this patch, only single named mode/state is added and these pins
are configured during pinctrl driver initialization.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d649644..9327d7d 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -26,7 +26,7 @@
 
 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0>;
+		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0 &cpsw_s0>;
 
 		matrix_keypad_s0: matrix_keypad_s0 {
 			pinctrl-single,pins = <
@@ -44,6 +44,28 @@
 				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
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
+				/* MDIO */
+				0x148 0x30	/* mdio_data.mdio_data, MODE0 | INPUT_PULLUP */
+				0x14c 0x10	/* mdio_clk.mdio_clk, MODE0 | OUTPUT_PULLUP */
+			>;
+		};
 	};
 
 	ocp {
-- 
1.7.9.5

