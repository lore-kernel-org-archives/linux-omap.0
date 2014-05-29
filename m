From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 14/18] ARM: dts: dra7: Add dt data for PCIe PHY
Date: Thu, 29 May 2014 12:08:16 +0530
Message-ID: <1401345500-20188-15-git-send-email-kishon@ti.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401345500-20188-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, tony@atomide.com, jg1.han@samsung.com, kishon@ti.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Added dt data for PCIe PHY as a child node of ocp2scp3.
The documention for this node can be found @ ../bindings/phy/ti-phy.txt.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 3c7e7f2..eaeccaf 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -912,6 +912,45 @@
 				clock-names = "sysclk";
 				#phy-cells = <0>;
 			};
+
+			pcie1_phy: pciephy@4a094000 {
+				compatible = "ti,phy-pipe3-pcie";
+				reg = <0x4A094000 0x80>, /* phy_rx */
+				      <0x4A094400 0x64>; /* phy_tx */
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
+				ti,hwmods = "pcie1-phy";
+			};
+
+			pcie2_phy: pciephy@4a095000 {
+				compatible = "ti,phy-pipe3-pcie";
+				reg = <0x4A095000 0x80>, /* phy_rx */
+				      <0x4A095400 0x64>; /* phy_tx */
+				reg-names = "phy_rx", "phy_tx";
+				ctrl-module = <&omap_control_pcie1phy>;
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
+				status = "disabled";
+			};
 		};
 
 		omap_dwc3_1@48880000 {
-- 
1.7.9.5
