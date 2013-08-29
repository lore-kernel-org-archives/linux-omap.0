From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 15/45] ARM: dts: DRA7: Add PCIe related clock nodes
Date: Thu, 29 Aug 2013 16:16:07 +0300
Message-ID: <1377782197-10611-16-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47989 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403Ab3H2NR7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:17:59 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>

From: Keerthy <j-keerthy@ti.com>

This patch adds optfclk_pciephy_clk and optfclk_pciephy_div_clk
which are used by PCIe phy. It also adds a mux clock to choose
the source of optfclk_pciephy_div_clk clock.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 397a60a..6a53d3b 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2061,3 +2061,27 @@ vip3_gclk_mux: vip3_gclk_mux@4a009030 {
 	reg = <0x4a009030 0x4>;
 	bit-mask = <0x1>;
 };
+
+optfclk_pciephy_div: optfclk_pciephy_div@4a00821c {
+	compatible = "divider-clock";
+	clocks = <&apll_pcie_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00821c 0x4>;
+	bit-mask = <0x100>;
+};
+
+optfclk_pciephy_clk: optfclk_pciephy_clk@4a0093b0 {
+	compatible = "gate-clock";
+	clocks = <&apll_pcie_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0093b0 0x4>;
+	bit-shift = <9>;
+};
+
+optfclk_pciephy_div_clk: optfclk_pciephy_div_clk@4a0093b0 {
+	compatible = "gate-clock";
+	clocks = <&optfclk_pciephy_div>;
+	#clock-cells = <0>;
+	reg = <0x4a0093b0 0x4>;
+	bit-shift = <10>;
+};
-- 
1.7.9.5

