From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv10 25/41] ARM: dts: DRA7: Change apll_pcie_m2_ck to fixed factor clock
Date: Tue, 26 Nov 2013 10:06:06 +0200
Message-ID: <1385453182-24421-26-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385453182-24421-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

This patch changes apll_pcie_m2_ck to fixed factor
clock as there are no configurable divider associated to m2.

Signed-off-by: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 2fdb904..7708d84 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1183,13 +1183,10 @@
 
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
