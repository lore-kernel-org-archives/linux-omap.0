From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 2/3] ARM: dts: AM33XX: Add pinmux configuration for CPSW to EVMsk
Date: Fri, 7 Jun 2013 17:02:53 +0530
Message-ID: <1370604775-21264-3-git-send-email-mugunthanvnm@ti.com>
References: <1370604775-21264-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50620 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052Ab3FGLcJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 07:32:09 -0400
In-Reply-To: <1370604775-21264-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: benoit.cousson@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>

Add pinmux configurations for RGMII based CPSW ethernet to AM335x EVMsk.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Sleep mode is nothing but the values required for the module during
inactive state. The pins are configured to its reset state to optimize
energy usage for the pins for the suspend/resume cycle

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |   92 ++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 338b681..a0c201d 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -71,6 +71,86 @@
 				0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)		/* xdma_event_intr1.clkout2 */
 			>;
 		};
+
+		cpsw_default: cpsw_default {
+			pinctrl-single,pins = <
+				/* Slave 1 */
+				0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+				0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
+				0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
+				0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+				0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+				0x12c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
+				0x130 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
+				0x134 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
+				0x138 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
+				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
+				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
+
+				/* Slave 2 */
+				0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
+				0x44 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
+				0x48 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
+				0x4c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
+				0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
+				0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
+				0x58 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
+				0x5c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
+				0x60 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
+				0x64 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
+				0x68 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
+				0x6c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
+			>;
+		};
+
+		cpsw_sleep: cpsw_sleep {
+			pinctrl-single,pins = <
+				/* Slave 1 reset value */
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
+
+				/* Slave 2 reset value*/
+				0x40 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x44 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x48 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x4c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x50 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x54 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x58 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x5c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x60 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)
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
@@ -277,3 +357,15 @@
 		};
 	};
 };
+
+&mac {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_default>;
+	pinctrl-1 = <&cpsw_sleep>;
+};
+
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_default>;
+	pinctrl-1 = <&davinci_mdio_sleep>;
+};
-- 
1.7.9.5

