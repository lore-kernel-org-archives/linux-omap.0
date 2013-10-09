From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 17/36] ARM: dts: clk: Add apll related clocks
Date: Wed, 9 Oct 2013 18:30:48 +0300
Message-ID: <1381332668-962-18-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52489 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165Ab3JIPd5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 11:33:57 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, J Keerthy <j-keerthy@ti.com>

From: J Keerthy <j-keerthy@ti.com>

The patch adds a mux node to choose the parent of apll_pcie_ck node.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 0d83f95..c830e15 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -315,11 +315,19 @@ dpll_pcie_ref_m2ldo_ck: dpll_pcie_ref_m2ldo_ck@4a008210 {
 	ti,autoidle-low;
 };
 
+apll_pcie_in_clk_mux: apll_pcie_in_clk_mux@4ae06118 {
+	compatible = "ti,mux-clock";
+	clocks = <&dpll_pcie_ref_ck>, <&pciesref_acs_clk_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00821c 0x4>;
+	ti,bit-shift = <7>;
+};
+
 apll_pcie_ck: apll_pcie_ck@4a008200 {
 	#clock-cells = <0>;
-	compatible = "ti,omap4-dpll-clock";
-	clocks = <&dpll_pcie_ref_ck>, <&dpll_pcie_ref_ck>;
-	reg = <0x4a008200 0x4>, <0x4a008204 0x4>, <0x4a008208 0x4>, <0x4a00820c 0x4>;
+	compatible = "ti,dra7-apll-clock";
+	clocks = <&apll_pcie_in_clk_mux>, <&dpll_pcie_ref_ck>;
+	reg = <0x4a00821c 0x4>, <0x4a008220 0x4>;
 };
 
 apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
-- 
1.7.9.5

