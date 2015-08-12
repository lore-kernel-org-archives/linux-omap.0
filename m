From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net-next PATCH 3/3] ARM: dts: am33xx: update cpsw compatible
Date: Wed, 12 Aug 2015 15:22:55 +0530
Message-ID: <1439373175-8650-4-git-send-email-mugunthanvnm@ti.com>
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
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 21fcc44..8b59c86 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -700,7 +700,7 @@
 		};
 
 		mac: ethernet@4a100000 {
-			compatible = "ti,cpsw";
+			compatible = "ti,am335x-cpsw","ti,cpsw";
 			ti,hwmods = "cpgmac0";
 			clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>;
 			clock-names = "fck", "cpts";
-- 
2.5.0.234.gefc8a62
