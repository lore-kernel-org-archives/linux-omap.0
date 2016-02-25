From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 09/11] ARM: clk: dra7xx: Correct mcasp8_ahclkx_mux name
Date: Thu, 25 Feb 2016 16:50:25 +0200
Message-ID: <1456411827-23962-10-git-send-email-peter.ujfalusi@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

rename the mcasp8_ahclk_mux to mcasp8_ahclkx_mux.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 +-
 drivers/clk/ti/clk-7xx.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 357bedeebfac..8be2cbe0e7e4 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1856,7 +1856,7 @@
 		reg = <0x1908>;
 	};
 
-	mcasp8_ahclk_mux: mcasp8_ahclk_mux {
+	mcasp8_ahclkx_mux: mcasp8_ahclkx_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index a911d7de3377..6b5a309d9939 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -223,7 +223,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK(NULL, "mcasp6_aux_gfclk_mux", "mcasp6_aux_gfclk_mux"),
 	DT_CLK(NULL, "mcasp7_ahclkx_mux", "mcasp7_ahclkx_mux"),
 	DT_CLK(NULL, "mcasp7_aux_gfclk_mux", "mcasp7_aux_gfclk_mux"),
-	DT_CLK(NULL, "mcasp8_ahclk_mux", "mcasp8_ahclk_mux"),
+	DT_CLK(NULL, "mcasp8_ahclkx_mux", "mcasp8_ahclkx_mux"),
 	DT_CLK(NULL, "mcasp8_aux_gfclk_mux", "mcasp8_aux_gfclk_mux"),
 	DT_CLK(NULL, "mmc1_fclk_mux", "mmc1_fclk_mux"),
 	DT_CLK(NULL, "mmc1_fclk_div", "mmc1_fclk_div"),
-- 
2.7.1
