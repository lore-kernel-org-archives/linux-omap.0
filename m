From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH] ti/clkt_dpll: fix wrong do_div() usage
Date: Tue, 3 Nov 2015 23:09:58 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511032306560.630@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

do_div() is meant to be used with an unsigned dividend.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/drivers/clk/ti/clkt_dpll.c b/drivers/clk/ti/clkt_dpll.c
index 9023ca9caf..b5cc6f66ae 100644
--- a/drivers/clk/ti/clkt_dpll.c
+++ b/drivers/clk/ti/clkt_dpll.c
@@ -240,7 +240,7 @@ u8 omap2_init_dpll_parent(struct clk_hw *hw)
  */
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 {
-	long long dpll_clk;
+	u64 dpll_clk;
 	u32 dpll_mult, dpll_div, v;
 	struct dpll_data *dd;
 
@@ -262,7 +262,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 	dpll_div = v & dd->div1_mask;
 	dpll_div >>= __ffs(dd->div1_mask);
 
-	dpll_clk = (long long)clk_get_rate(dd->clk_ref) * dpll_mult;
+	dpll_clk = (u64)clk_get_rate(dd->clk_ref) * dpll_mult;
 	do_div(dpll_clk, dpll_div + 1);
 
 	return dpll_clk;
