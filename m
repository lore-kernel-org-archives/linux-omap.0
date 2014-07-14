From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH 7/8] ARM: dts: dra7: Add dt data for PCIe PHY
Date: Mon, 14 Jul 2014 16:12:22 +0530
Message-ID: <1405334543-25509-8-git-send-email-kishon@ti.com>
References: <1405334543-25509-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60785 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218AbaGNKng (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jul 2014 06:43:36 -0400
In-Reply-To: <1405334543-25509-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, tony@atomide.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: kishon@ti.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>

Added dt data for PCIe PHY as a child node of ocp2scp3.
The documention for this node can be found @ ../bindings/phy/ti-phy.txt.
26.3.3 PCIe Shared PHY Subsystem Integration in vE of DRA7xx ES1.0
describes the PCIe PHY subsystem-related components integrated in the device.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index e4999e4..cbaf47d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -816,6 +816,47 @@
 				clock-names = "sysclk";
 				#phy-cells = <0>;
 			};
+
+			pcie1_phy: pciephy@4a094000 {
+				compatible = "ti,phy-pipe3-pcie";
+				reg = <0x4a094000 0x80>, /* phy_rx */
+				      <0x4a094400 0x64>; /* phy_tx */
+				reg-names = "phy_rx", "phy_tx";
+				ctrl-module = <&omap_control_pcie1phy>;
+				clocks = <&dpll_pcie_ref_ck>,
+					 <&dpll_pcie_ref_m2ldo_ck>,
+					 <&optfclk_pciephy1_32khz>,
+					 <&optfclk_pciephy1_clk>,
+					 <&optfclk_pciephy1_div_clk>,
+					 <&optfclk_pciephy_div>;
+				clock-names = "dpll_ref", "dpll_ref_m2",
+					      "wkupclk", "refclk",
+					      "div-clk", "phy-div";
+				#phy-cells = <0>;
+				id = <1>;
+				ti,hwmods = "pcie1-phy";
+			};
+
+			pcie2_phy: pciephy@4a095000 {
+				compatible = "ti,phy-pipe3-pcie";
+				reg = <0x4a095000 0x80>, /* phy_rx */
+				      <0x4a095400 0x64>; /* phy_tx */
+				reg-names = "phy_rx", "phy_tx";
+				ctrl-module = <&omap_control_pcie2phy>;
+				clocks = <&dpll_pcie_ref_ck>,
+					 <&dpll_pcie_ref_m2ldo_ck>,
+					 <&optfclk_pciephy2_32khz>,
+					 <&optfclk_pciephy2_clk>,
+					 <&optfclk_pciephy2_div_clk>,
+					 <&optfclk_pciephy_div>;
+				clock-names = "dpll_ref", "dpll_ref_m2",
+					      "wkupclk", "refclk",
+					      "div-clk", "phy-div";
+				#phy-cells = <0>;
+				ti,hwmods = "pcie2-phy";
+				id = <2>;
+				status = "disabled";
+			};
 		};
 
 		sata: sata@4a141100 {
-- 
1.7.9.5

