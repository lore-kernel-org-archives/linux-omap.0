From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] clk: ti: dra7: fix "failed to lookup clock node gmac_gmii_ref_clk_div" boot message
Date: Tue, 29 Nov 2016 17:07:57 -0600
Message-ID: <20161129230757.29183-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Prevent creating clk alias for non existing gmac_gmii_ref_clk_div clock and,
this way, eliminate excessive error message during boot:

 "ti_dt_clocks_register: failed to lookup clock node gmac_gmii_ref_clk_div"

Fixes: c097338ebd3f ("ARM: dts: dra7: cpsw: fix clocks tree")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/clk/ti/clk-7xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index bfa17d3..9fd6043 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -201,7 +201,6 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK(NULL, "atl_dpll_clk_mux", "atl_dpll_clk_mux"),
 	DT_CLK(NULL, "atl_gfclk_mux", "atl_gfclk_mux"),
 	DT_CLK(NULL, "dcan1_sys_clk_mux", "dcan1_sys_clk_mux"),
-	DT_CLK(NULL, "gmac_gmii_ref_clk_div", "gmac_gmii_ref_clk_div"),
 	DT_CLK(NULL, "gmac_rft_clk_mux", "gmac_rft_clk_mux"),
 	DT_CLK(NULL, "gpu_core_gclk_mux", "gpu_core_gclk_mux"),
 	DT_CLK(NULL, "gpu_hyd_gclk_mux", "gpu_hyd_gclk_mux"),
-- 
2.10.1

