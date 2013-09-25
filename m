From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv7 17/36] ARM: dts: clk: Add apll related clocks
Date: Wed, 25 Sep 2013 11:48:23 +0300
Message-ID: <1380098922-30340-18-git-send-email-t-kristo@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

The patch adds a mux node to choose the parent of apll_pcie_ck node.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 0d83f95..c830e15 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -315,11 +315,19 @@ dpll_pcie_ref_m2ldo_ck: dpll_pcie_ref_m2ldo_ck@4a008210 {
 	ti,autoidle-low;
 };
 
+apll_pcie_in_clk_mux: apll_pcie_in_clk_mux@4ae06118 {
+	compatible = "ti,mux-clock";
+	clocks = <&dpll_pcie_ref_ck>, <&pciesref_acs_clk_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00821c 0x4>;
+	ti,bit-shift = <7>;
+};
+
 apll_pcie_ck: apll_pcie_ck@4a008200 {
 	#clock-cells = <0>;
-	compatible = "ti,omap4-dpll-clock";
-	clocks = <&dpll_pcie_ref_ck>, <&dpll_pcie_ref_ck>;
-	reg = <0x4a008200 0x4>, <0x4a008204 0x4>, <0x4a008208 0x4>, <0x4a00820c 0x4>;
+	compatible = "ti,dra7-apll-clock";
+	clocks = <&apll_pcie_in_clk_mux>, <&dpll_pcie_ref_ck>;
+	reg = <0x4a00821c 0x4>, <0x4a008220 0x4>;
 };
 
 apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
