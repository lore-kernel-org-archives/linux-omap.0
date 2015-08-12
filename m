From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net-next PATCH 2/3] ARM: dts: dra7: update cpsw compatible
Date: Wed, 12 Aug 2015 15:22:54 +0530
Message-ID: <1439373175-8650-3-git-send-email-mugunthanvnm@ti.com>
References: <1439373175-8650-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1439373175-8650-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Tony Lindgren <tony@atomide.com>, alex.aring@gmail.com, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

CPSW driver has been updated with compatibles for enabling errata
workarounds. So updating cpsw compatibles.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8f1e25b..b4fdd10 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1398,7 +1398,7 @@
 		};
 
 		mac: ethernet@4a100000 {
-			compatible = "ti,cpsw";
+			compatible = "ti,dra7-cpsw","ti,cpsw";
 			ti,hwmods = "gmac";
 			clocks = <&dpll_gmac_ck>, <&gmac_gmii_ref_clk_div>;
 			clock-names = "fck", "cpts";
-- 
2.5.0.234.gefc8a62
