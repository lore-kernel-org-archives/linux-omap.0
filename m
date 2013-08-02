From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 13/31] ARM: dts: clk: Add apll related clocks
Date: Fri, 2 Aug 2013 19:25:32 +0300
Message-ID: <1375460751-23676-14-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50363 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835Ab3HBQ07 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:26:59 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>

From: Keerthy <j-keerthy@ti.com>

The patch adds a mux node to choose the parent of apll_pcie_ck node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index e4853f8..b377526 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -326,13 +326,24 @@ dpll_pcie_ref_m2ldo_ck: dpll_pcie_ref_m2ldo_ck@4a008210 {
 	ti,autoidle-low;
 };
 
+/* APLL_PCIE */
+
+/* mux clock to select the reference clock */
+apll_pcie_in_clk_mux: apll_pcie_in_clk_mux@4ae06118 {
+	compatible = "mux-clock";
+	clocks = <&dpll_pcie_ref_ck>, <&pciesref_acs_clk_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00821c 0x4>;
+	bit-mask = <0x80>;
+};
+
 apll_pcie_ck: apll_pcie_ck@4a008200 {
 	#clock-cells = <0>;
-	compatible = "ti,omap4-dpll-clock";
-	clocks = <&dpll_pcie_ref_ck>;
-	reg = <0x4a008200 0x4>, <0x4a008204 0x4>, <0x4a008208 0x4>, <0x4a00820c 0x4>;
-	ti,clk-ref = <&dpll_pcie_ref_ck>;
+	clocks = <&apll_pcie_in_clk_mux>;
+	reg = <0x4a00821c 0x4>, <0x4a008220 0x4>;
 	ti,clk-bypass = <&dpll_pcie_ref_ck>;
+	ti,clk-ref = <&apll_pcie_in_clk_mux>;
+	compatible = "ti,dra7-apll-clock";
 };
 
 apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
-- 
1.7.9.5

