From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 160/205] ARM: dts: dra7: fix cpsw mdio fck clock
Date: Thu, 16 Jan 2020 11:42:15 -0500
Message-ID: <20200116164300.6705-160-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 6af0a549c25e0d02366aa95507bfe3cad2f7b68b ]

The DRA7 CPSW MDIO functional clock (gmac_clkctrl DRA7_GMAC_GMAC_CLKCTRL 0)
is specified incorrectly, which is caused incorrect MDIO bus clock
configuration MDCLK. The correct CPSW MDIO functional clock is
gmac_main_clk (125MHz), which is the same as CPSW fck. Hence fix it.

Fixes: 1faa415c9c6e ("ARM: dts: Add fck for cpsw mdio for omap variants")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 5cac2dd58241..c3954e34835b 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -3059,7 +3059,7 @@
 
 				davinci_mdio: mdio@1000 {
 					compatible = "ti,cpsw-mdio","ti,davinci_mdio";
-					clocks = <&gmac_clkctrl DRA7_GMAC_GMAC_CLKCTRL 0>;
+					clocks = <&gmac_main_clk>;
 					clock-names = "fck";
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.20.1
