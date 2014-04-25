From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH] arm: dts: am33xx-clock: Fix ehrpwm tbclk data.
Date: Fri, 25 Apr 2014 14:25:25 +0530
Message-ID: <1398416125-7139-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39486 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbaDYIz5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Apr 2014 04:55:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com, mturquette@linaro.org, tony@atomide.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, balbi@ti.com
Cc: Sourav Poddar <sourav.poddar@ti.com>

tbclk does not need to be a composite clock, we can simply
use gate clock for this purpose.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am33xx-clocks.dtsi |   42 ++++++++++------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
index 9ccfe50..a45d27f 100644
--- a/arch/arm/boot/dts/am33xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
@@ -96,46 +96,28 @@
 		clock-div = <1>;
 	};
 
-	ehrpwm0_gate_tbclk: ehrpwm0_gate_tbclk {
+	ehrpwm0_tbclk: ehrpwm0_tbclk@44e10664 {
 		#clock-cells = <0>;
-		compatible = "ti,composite-no-wait-gate-clock";
+		compatible = "gate-clock";
 		clocks = <&dpll_per_m2_ck>;
-		ti,bit-shift = <0>;
-		reg = <0x0664>;
+		bit-shift = <0>;
+		reg = <0x44e10664 0x4>;
 	};
 
-	ehrpwm0_tbclk: ehrpwm0_tbclk {
+	ehrpwm1_tbclk: ehrpwm1_tbclk@44e10664 {
 		#clock-cells = <0>;
-		compatible = "ti,composite-clock";
-		clocks = <&ehrpwm0_gate_tbclk>;
-	};
-
-	ehrpwm1_gate_tbclk: ehrpwm1_gate_tbclk {
-		#clock-cells = <0>;
-		compatible = "ti,composite-no-wait-gate-clock";
+		compatible = "gate-clock";
 		clocks = <&dpll_per_m2_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0664>;
-	};
-
-	ehrpwm1_tbclk: ehrpwm1_tbclk {
-		#clock-cells = <0>;
-		compatible = "ti,composite-clock";
-		clocks = <&ehrpwm1_gate_tbclk>;
+		bit-shift = <1>;
+		reg = <0x44e10664 0x4>;
 	};
 
-	ehrpwm2_gate_tbclk: ehrpwm2_gate_tbclk {
+	ehrpwm2_tbclk: ehrpwm2_tbclk@44e10664 {
 		#clock-cells = <0>;
-		compatible = "ti,composite-no-wait-gate-clock";
+		compatible = "gate-clock";
 		clocks = <&dpll_per_m2_ck>;
-		ti,bit-shift = <2>;
-		reg = <0x0664>;
-	};
-
-	ehrpwm2_tbclk: ehrpwm2_tbclk {
-		#clock-cells = <0>;
-		compatible = "ti,composite-clock";
-		clocks = <&ehrpwm2_gate_tbclk>;
+		bit-shift = <2>;
+		reg = <0x44e10664 0x4>;
 	};
 };
 &prcm_clocks {
-- 
1.7.9.5

