From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv13 25/40] ARM: dts: DRA7: Add PCIe related clock nodes
Date: Thu, 9 Jan 2014 16:00:36 +0200
Message-ID: <1389276051-1326-26-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36721 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbaAIOC5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jan 2014 09:02:57 -0500
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, J Keerthy <j-keerthy@ti.com>

From: J Keerthy <j-keerthy@ti.com>

This patch adds optfclk_pciephy_clk and optfclk_pciephy_div_clk
which are used by PCIe phy. It also adds a mux clock to choose
the source of optfclk_pciephy_div_clk clock.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index d616359..e96da9a 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1165,6 +1165,31 @@
 		reg = <0x021c>, <0x0220>;
 	};
 
+	optfclk_pciephy_div: optfclk_pciephy_div@4a00821c {
+		compatible = "ti,divider-clock";
+		clocks = <&apll_pcie_ck>;
+		#clock-cells = <0>;
+		reg = <0x021c>;
+		ti,bit-shift = <8>;
+		ti,max-div = <2>;
+	};
+
+	optfclk_pciephy_clk: optfclk_pciephy_clk@4a0093b0 {
+		compatible = "ti,gate-clock";
+		clocks = <&apll_pcie_ck>;
+		#clock-cells = <0>;
+		reg = <0x13b0>;
+		ti,bit-shift = <9>;
+	};
+
+	optfclk_pciephy_div_clk: optfclk_pciephy_div_clk@4a0093b0 {
+		compatible = "ti,gate-clock";
+		clocks = <&optfclk_pciephy_div>;
+		#clock-cells = <0>;
+		reg = <0x13b0>;
+		ti,bit-shift = <10>;
+	};
+
 	apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
-- 
1.7.9.5

