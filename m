From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv13 23/40] ARM: dts: clk: Add apll related clocks
Date: Thu, 9 Jan 2014 16:00:34 +0200
Message-ID: <1389276051-1326-24-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46915 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850AbaAIOCv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 09:02:51 -0500
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
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
index 32df847..d4e7410 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1150,11 +1150,19 @@
 		ti,invert-autoidle-bit;
 	};
 
+	apll_pcie_in_clk_mux: apll_pcie_in_clk_mux@4ae06118 {
+		compatible = "ti,mux-clock";
+		clocks = <&dpll_pcie_ref_ck>, <&pciesref_acs_clk_ck>;
+		#clock-cells = <0>;
+		reg = <0x021c 0x4>;
+		ti,bit-shift = <7>;
+	};
+
 	apll_pcie_ck: apll_pcie_ck {
 		#clock-cells = <0>;
-		compatible = "ti,omap4-dpll-clock";
-		clocks = <&dpll_pcie_ref_ck>, <&dpll_pcie_ref_ck>;
-		reg = <0x0200>, <0x0204>, <0x020c>, <0x0208>;
+		compatible = "ti,dra7-apll-clock";
+		clocks = <&apll_pcie_in_clk_mux>, <&dpll_pcie_ref_ck>;
+		reg = <0x021c>, <0x0220>;
 	};
 
 	apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
-- 
1.7.9.5

