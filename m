From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] ARM: dts: omap54xx-clocks: Fix the l3 and l4 clock rates
Date: Tue, 26 Aug 2014 11:51:38 +0300
Message-ID: <1409043098-12510-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49508 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934028AbaHZIwG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Aug 2014 04:52:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Similarly to DRA7, OMAP5 has l3 and l4 clock rates incorrectly calculated.
Fixed by using proper divider clock types for the clock nodes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index e67a23b..58c2746 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -367,10 +367,12 @@
 
 	l3_iclk_div: l3_iclk_div {
 		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
+		compatible = "ti,divider-clock";
+		ti,max-div = <2>;
+		ti,bit-shift = <4>;
+		reg = <0x100>;
 		clocks = <&dpll_core_h12x2_ck>;
-		clock-mult = <1>;
-		clock-div = <1>;
+		ti,index-power-of-two;
 	};
 
 	gpu_l3_iclk: gpu_l3_iclk {
@@ -383,10 +385,12 @@
 
 	l4_root_clk_div: l4_root_clk_div {
 		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
+		compatible = "ti,divider-clock";
+		ti,max-div = <2>;
+		ti,bit-shift = <8>;
+		reg = <0x100>;
 		clocks = <&l3_iclk_div>;
-		clock-mult = <1>;
-		clock-div = <1>;
+		ti,index-power-of-two;
 	};
 
 	slimbus1_slimbus_clk: slimbus1_slimbus_clk {
-- 
1.7.9.5

