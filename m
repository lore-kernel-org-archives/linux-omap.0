From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 1/3] ARM: dts: AM33XX: Add pinmux configuration for CPSW to beaglebone
Date: Mon, 25 Mar 2013 12:57:56 +0530
Message-ID: <1364196478-16688-2-git-send-email-mugunthanvnm@ti.com>
References: <1364196478-16688-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56859 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab3CYH2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Mar 2013 03:28:13 -0400
In-Reply-To: <1364196478-16688-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, benoit.cousson@linaro.org, tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>

Add pinmux configurations for MII based CPSW ethernet to am335x-bone.
In this patch, only single named mode/state is added and these pins
are configured during pinctrl driver initialization.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 11b240c..f90e665 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -26,7 +26,7 @@
 
 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0>;
+		pinctrl-0 = <&user_leds_s0 &cpsw_s0>;
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -36,6 +36,29 @@
 				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
 			>;
 		};
+
+		cpsw_s0: cpsw_s0 {
+			pinctrl-single,pins = <
+				/* Slave 1 */
+				0x110 0x20	/* mii1_rxerr.mii1_rxerr, MODE0 | INPUT */
+				0x114 0x0	/* mii1_txen.mii1_txen, MODE0 | OUTPUT */
+				0x118 0x20	/* mii1_rxdv.mii1_rxdv, MODE0 | INPUT_PULLDOWN */
+				0x11c 0x0	/* mii1_txd3.mii1_txd3, MODE0 | OUTPUT */
+				0x120 0x0	/* mii1_txd2.mii1_txd2, MODE0 | OUTPUT */
+				0x124 0x0	/* mii1_txd1.mii1_txd1, MODE0 | OUTPUT */
+				0x128 0x0	/* mii1_txd0.mii1_txd0, MODE0 | OUTPUT */
+				0x12c 0x20	/* mii1_txclk.mii1_txclk, MODE0 | INPUT_PULLDOWN */
+				0x130 0x20	/* mii1_rxclk.mii1_rxclk, MODE0 | INPUT_PULLDOWN */
+				0x134 0x20	/* mii1_rxd3.mii1_rxd3, MODE0 | INPUT_PULLDOWN */
+				0x138 0x20	/* mii1_rxd2.mii1_rxd2, MODE0 | INPUT_PULLDOWN */
+				0x13c 0x20	/* mii1_rxd1.mii1_rxd1, MODE0 | INPUT_PULLDOWN */
+				0x140 0x20	/* mii1_rxd0.mii1_rxd0, MODE0 | INPUT_PULLDOWN */
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

