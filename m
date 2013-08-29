From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 14/45] ARM: dts: DRA7: Change apll_pcie_m2_ck to fixed factor clock
Date: Thu, 29 Aug 2013 16:16:06 +0300
Message-ID: <1377782197-10611-15-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50644 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754305Ab3H2NRu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:17:50 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>

From: Keerthy <j-keerthy@ti.com>

This patch changes apll_pcie_m2_ck to fixed factor
clock as there are no configurable divider associated to m2.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 17340cc..397a60a 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -358,13 +358,10 @@ apll_pcie_clkvcoldo_div: apll_pcie_clkvcoldo_div {
 
 apll_pcie_m2_ck: apll_pcie_m2_ck@4a008224 {
 	#clock-cells = <0>;
-	compatible = "ti,divider-clock";
+	compatible = "fixed-factor-clock";
 	clocks = <&apll_pcie_ck>;
-	ti,autoidle-shift = <8>;
-	reg = <0x4a008224 0x4>;
-	bit-mask = <0x7f>;
-	index-starts-at-one;
-	ti,autoidle-low;
+	clock-mult = <1>;
+	clock-div = <1>;
 };
 
 sys_clk1_dclk_div: sys_clk1_dclk_div@4ae061c8 {
-- 
1.7.9.5

