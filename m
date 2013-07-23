From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 31/33] ARM: dts: clk: Add apll related clocks
Date: Tue, 23 Jul 2013 10:20:26 +0300
Message-ID: <1374564028-11352-32-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48703 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab3GWHX0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:23:26 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Keerthy <j-keerthy@ti.com>

From: Keerthy <j-keerthy@ti.com>

The patch adds a mux node to choose the parent of apll_pcie_ck node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 8477ff9..e923311 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -328,13 +328,24 @@ dpll_pcie_ref_m2ldo_ck: dpll_pcie_ref_m2ldo_ck@4a008210 {
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

