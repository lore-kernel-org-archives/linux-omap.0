From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 27/43] ARM: dts: DRA7: Change apll_pcie_m2_ck to fixed factor clock
Date: Fri, 25 Oct 2013 18:57:21 +0300
Message-ID: <1382716658-6964-28-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36404 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754738Ab3JYQAA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 12:00:00 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, J Keerthy <j-keerthy@ti.com>

From: J Keerthy <j-keerthy@ti.com>

This patch changes apll_pcie_m2_ck to fixed factor
clock as there are no configurable divider associated to m2.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 1226921..76955c1 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1198,13 +1198,10 @@ cm_core: cm_core@4a008000 {
 
 	apll_pcie_m2_ck: apll_pcie_m2_ck {
 		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
+		compatible = "fixed-factor-clock";
 		clocks = <&apll_pcie_ck>;
-		ti,max-div = <127>;
-		ti,autoidle-shift = <8>;
-		reg = <0x0224>;
-		ti,index-starts-at-one;
-		ti,invert-autoidle-bit;
+		clock-mult = <1>;
+		clock-div = <1>;
 	};
 
 	dpll_per_ck: dpll_per_ck {
-- 
1.7.9.5

