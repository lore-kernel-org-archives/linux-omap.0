From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] ARM: dts: dra7: fix DSS PLL clock mux registers
Date: Mon, 13 Oct 2014 11:50:41 +0300
Message-ID: <1413190241-13527-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35863 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931AbaJMIvM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Oct 2014 04:51:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, paul@pwsan.com
Cc: Somnath Mukherjee <somnath@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The clock nodes for DSS VIDEO1/2 and HDMI have wrong register addresses.
This patch fixes the addresses so that they point to
CM_CLKSEL_VIDEO1_PLL_SYS, CM_CLKSEL_VIDEO2_PLL_SYS and
CM_CLKSEL_HDMI_PLL_SYS.

Reported-by: Somnath Mukherjee <somnath@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 2c05b3f017fa..4bdcbd61ce47 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1042,7 +1042,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&sys_clkin2>;
-		reg = <0x01a4>;
+		reg = <0x0164>;
 	};
 
 	mlb_clk: mlb_clk {
@@ -1084,14 +1084,14 @@
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&sys_clkin2>;
-		reg = <0x01d0>;
+		reg = <0x0168>;
 	};
 
 	video2_dpll_clk_mux: video2_dpll_clk_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&sys_clkin2>;
-		reg = <0x01d4>;
+		reg = <0x016c>;
 	};
 
 	wkupaon_iclk_mux: wkupaon_iclk_mux {
-- 
2.1.1

