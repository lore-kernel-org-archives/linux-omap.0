From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: DTS: dra7xx-clocks: Add gate clock for CLKOUT2
Date: Thu, 26 Feb 2015 15:39:23 +0200
Message-ID: <1424957963-15418-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35323 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932120AbbBZNjw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:39:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

To be able to control the gate for the clkout2 clock output.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 4bdcbd61ce47..2a9994f73974 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1421,6 +1421,14 @@
 		ti,dividers = <1>, <8>;
 	};
 
+	clkout2_clk: clkout2_clk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&clkoutmux2_clk_mux>;
+		ti,bit-shift = <8>;
+		reg = <0x06b0>;
+	};
+
 	l3init_960m_gfclk: l3init_960m_gfclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-- 
2.3.0

