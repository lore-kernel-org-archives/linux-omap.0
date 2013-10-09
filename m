From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 19/36] ARM: dts: DRA7: Add PCIe related clock nodes
Date: Wed, 9 Oct 2013 18:30:50 +0300
Message-ID: <1381332668-962-20-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41896 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755324Ab3JIPeD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 11:34:03 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
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
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 75d5e1b..d83afd3 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1973,8 +1973,33 @@ vip3_gclk_mux: vip3_gclk_mux@4a009030 {
 	reg = <0x4a009030 0x4>;
 };
 
+optfclk_pciephy_div: optfclk_pciephy_div@4a00821c {
+	compatible = "ti,divider-clock";
+	clocks = <&apll_pcie_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00821c 0x4>;
+	ti,bit-shift = <8>;
+	ti,max-div = <2>;
+};
+
+optfclk_pciephy_clk: optfclk_pciephy_clk@4a0093b0 {
+	compatible = "ti,gate-clock";
+	clocks = <&apll_pcie_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0093b0 0x4>;
+	ti,bit-shift = <9>;
+};
+
+optfclk_pciephy_div_clk: optfclk_pciephy_div_clk@4a0093b0 {
+	compatible = "ti,gate-clock";
+	clocks = <&optfclk_pciephy_div>;
+	#clock-cells = <0>;
+	reg = <0x4a0093b0 0x4>;
+	ti,bit-shift = <10>;
+};
+
 dummy_ck: dummy_ck {
 	#clock-cells = <0>;
 	compatible = "fixed-clock";
 	clock-frequency = <0>;
-};
\ No newline at end of file
+};
-- 
1.7.9.5

