From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 3/3] ARM: dts: AM33XX: Add pinmux configuration for CPSW to am335x EVM
Date: Fri, 7 Jun 2013 17:02:54 +0530
Message-ID: <1370604775-21264-4-git-send-email-mugunthanvnm@ti.com>
References: <1370604775-21264-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50626 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052Ab3FGLcO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 07:32:14 -0400
In-Reply-To: <1370604775-21264-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: benoit.cousson@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>

Add pinmux configurations for RGMII based CPSW ethernet to am335x-evm.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Sleep mode is nothing but the values required for the module during
inactive state. The pins are configured to its reset state to optimize
energy usage for the pins for the suspend/resume cycle

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   64 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 2c53247..a1a0880 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -91,6 +91,58 @@
 				0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
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
@@ -378,6 +430,18 @@
 	};
 };
 
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
+
 &cpsw_emac0 {
 	phy_id = <&davinci_mdio>, <0>;
 };
-- 
1.7.9.5

