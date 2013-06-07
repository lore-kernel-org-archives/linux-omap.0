From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 1/3] ARM: dts: AM33XX: Add pinmux configuration for CPSW to beaglebone
Date: Fri, 7 Jun 2013 17:02:52 +0530
Message-ID: <1370604775-21264-2-git-send-email-mugunthanvnm@ti.com>
References: <1370604775-21264-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50624 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358Ab3FGLcL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 07:32:11 -0400
In-Reply-To: <1370604775-21264-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: benoit.cousson@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>

Add pinmux configurations for MII based CPSW ethernet to am335x-bone.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Sleep mode is nothing but the values required for the module during
inactive state. The pins are configured to its reset state to optimize
energy usage for the pins for the suspend/resume cycle

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   67 +++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index fd48173..04feaf8 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -56,6 +56,60 @@
 				0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 			>;
 		};
+
+		cpsw_default: cpsw_default {
+			pinctrl-single,pins = <
+				/* Slave 1 */
+				0x110 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxerr.mii1_rxerr */
+				0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txen.mii1_txen */
+				0x118 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxdv.mii1_rxdv */
+				0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd3.mii1_txd3 */
+				0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd2.mii1_txd2 */
+				0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd1.mii1_txd1 */
+				0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd0.mii1_txd0 */
+				0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_txclk.mii1_txclk */
+				0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxclk.mii1_rxclk */
+				0x134 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd3.mii1_rxd3 */
+				0x138 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd2.mii1_rxd2 */
+				0x13c (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd1.mii1_rxd1 */
+				0x140 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd0.mii1_rxd0 */
+			>;
+		};
+
+		cpsw_sleep: cpsw_sleep {
+			pinctrl-single,pins = <
+				/* Slave 1 reset value */
+				0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			>;
+		};
+
+		davinci_mdio_default: davinci_mdio_default {
+			pinctrl-single,pins = <
+				/* MDIO */
+				0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+				0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			>;
+		};
+
+		davinci_mdio_sleep: davinci_mdio_sleep {
+			pinctrl-single,pins = <
+				/* MDIO reset value */
+				0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			>;
+		};
 	};
 
 	ocp {
@@ -165,3 +219,16 @@
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
 };
+
+&mac {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_default>;
+	pinctrl-1 = <&cpsw_sleep>;
+
+};
+
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_default>;
+	pinctrl-1 = <&davinci_mdio_sleep>;
+};
-- 
1.7.9.5

