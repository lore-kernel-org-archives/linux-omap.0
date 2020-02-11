From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] ARM: dts: dra7xx-clocks: Fixup IPU1 mux clock parent source
Date: Tue, 11 Feb 2020 09:51:03 -0600
Message-ID: <20200211155103.23973-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52454 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgBKPvT (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 10:51:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

The IPU1 functional clock is the output of a mux clock (represented
by ipu1_gfclk_mux previously) and the clock source for this has been
updated to be sourced from dpll_core_h22x2_ck in commit 39879c7d963e
("ARM: dts: dra7xx-clocks: Source IPU1 functional clock from CORE DPLL").
ipu1_gfclk_mux is an obsolete clock now with the clkctrl conversion,
and this clock source parenting is lost during the new clkctrl layout
conversion.

Remove this stale clock and fix up the clock source for this mux
clock using the latest equivalent clkctrl clock. This restores the
previous logic and ensures that the IPU1 continues to run at the
same frequency of IPU2 and independent of the ABE DPLL.

Fixes: b5f8ffbb6fad ("ARM: dts: dra7: convert to use new clkctrl layout")
Signed-off-by: Suman Anna <s-anna@ti.com>
---
Hi Tony,

Patch on top of 5.6-rc1. Appreciate it if you can include it for the 5.6-rc
cycle.

regards
Suman

 arch/arm/boot/dts/dra7xx-clocks.dtsi | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 55cef4cac5f1..dc0a93bccbf1 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -796,16 +796,6 @@
 		clock-div = <1>;
 	};
 
-	ipu1_gfclk_mux: ipu1_gfclk_mux@520 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dpll_abe_m2x2_ck>, <&dpll_core_h22x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0520>;
-		assigned-clocks = <&ipu1_gfclk_mux>;
-		assigned-clock-parents = <&dpll_core_h22x2_ck>;
-	};
-
 	dummy_ck: dummy_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -1564,6 +1554,8 @@
 			compatible = "ti,clkctrl";
 			reg = <0x20 0x4>;
 			#clock-cells = <2>;
+			assigned-clocks = <&ipu1_clkctrl DRA7_IPU1_MMU_IPU1_CLKCTRL 24>;
+			assigned-clock-parents = <&dpll_core_h22x2_ck>;
 		};
 
 		ipu_clkctrl: ipu-clkctrl@50 {
-- 
2.23.0
