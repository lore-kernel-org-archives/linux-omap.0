From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2] clk: ti: dpll: convert DPLL support code to use clk_hw instead of clk ptrs
Date: Sat, 20 Feb 2016 13:24:26 +0200
Message-ID: <1455967466-3812-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Convert DPLL support code to use clk_hw pointers for reference and bypass
clocks. This allows us to use clk_hw_* APIs for accessing any required
parameters for these clocks, avoiding some locking problems at least with
DPLL enable code; this used clk_get_rate which uses mutex but isn't
good under clk_enable / clk_disable.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
v2: rebased the patch on top of v2 of 'clk: ti: omap3+: dpll: use non-locking
    version of clk_get_rate', as that one is required already for -rc. This
    patch can follow in 4.6 merge window.

 drivers/clk/ti/apll.c      |   20 ++++++++++++++++----
 drivers/clk/ti/clkt_dpll.c |    6 +++---
 drivers/clk/ti/dpll.c      |   25 +++++++++++++++++++------
 drivers/clk/ti/dpll3xxx.c  |   17 ++++++++---------
 drivers/clk/ti/dpll44xx.c  |    8 ++++----
 include/linux/clk/ti.h     |    8 ++++----
 6 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index b336a8c..6411e13 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -140,11 +140,21 @@ static void __init omap_clk_register_apll(struct clk_hw *hw,
 	struct dpll_data *ad = clk_hw->dpll_data;
 	struct clk *clk;
 
-	ad->clk_ref = of_clk_get(node, 0);
-	ad->clk_bypass = of_clk_get(node, 1);
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		pr_debug("clk-ref for %s not ready, retry\n",
+			 node->name);
+		if (!ti_clk_retry_init(node, hw, omap_clk_register_apll))
+			return;
+
+		goto cleanup;
+	}
 
-	if (IS_ERR(ad->clk_ref) || IS_ERR(ad->clk_bypass)) {
-		pr_debug("clk-ref or clk-bypass for %s not ready, retry\n",
+	ad->clk_ref = __clk_get_hw(clk);
+
+	clk = of_clk_get(node, 1);
+	if (IS_ERR(clk)) {
+		pr_debug("clk-bypass for %s not ready, retry\n",
 			 node->name);
 		if (!ti_clk_retry_init(node, hw, omap_clk_register_apll))
 			return;
@@ -152,6 +162,8 @@ static void __init omap_clk_register_apll(struct clk_hw *hw,
 		goto cleanup;
 	}
 
+	ad->clk_bypass = __clk_get_hw(clk);
+
 	clk = clk_register(NULL, &clk_hw->hw);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
diff --git a/drivers/clk/ti/clkt_dpll.c b/drivers/clk/ti/clkt_dpll.c
index b5cc6f6..032c658 100644
--- a/drivers/clk/ti/clkt_dpll.c
+++ b/drivers/clk/ti/clkt_dpll.c
@@ -254,7 +254,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 	v >>= __ffs(dd->enable_mask);
 
 	if (_omap2_dpll_is_in_bypass(v))
-		return clk_get_rate(dd->clk_bypass);
+		return clk_hw_get_rate(dd->clk_bypass);
 
 	v = ti_clk_ll_ops->clk_readl(dd->mult_div1_reg);
 	dpll_mult = v & dd->mult_mask;
@@ -262,7 +262,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 	dpll_div = v & dd->div1_mask;
 	dpll_div >>= __ffs(dd->div1_mask);
 
-	dpll_clk = (u64)clk_get_rate(dd->clk_ref) * dpll_mult;
+	dpll_clk = (u64)clk_hw_get_rate(dd->clk_ref) * dpll_mult;
 	do_div(dpll_clk, dpll_div + 1);
 
 	return dpll_clk;
@@ -301,7 +301,7 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 
 	dd = clk->dpll_data;
 
-	ref_rate = clk_get_rate(dd->clk_ref);
+	ref_rate = clk_hw_get_rate(dd->clk_ref);
 	clk_name = clk_hw_get_name(hw);
 	pr_debug("clock: %s: starting DPLL round_rate, target rate %lu\n",
 		 clk_name, target_rate);
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 5519b38..f8306f1 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -147,11 +147,22 @@ static void __init _register_dpll(struct clk_hw *hw,
 	struct dpll_data *dd = clk_hw->dpll_data;
 	struct clk *clk;
 
-	dd->clk_ref = of_clk_get(node, 0);
-	dd->clk_bypass = of_clk_get(node, 1);
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		pr_debug("clk-ref missing for %s, retry later\n",
+			 node->name);
+		if (!ti_clk_retry_init(node, hw, _register_dpll))
+			return;
 
-	if (IS_ERR(dd->clk_ref) || IS_ERR(dd->clk_bypass)) {
-		pr_debug("clk-ref or clk-bypass missing for %s, retry later\n",
+		goto cleanup;
+	}
+
+	dd->clk_ref = __clk_get_hw(clk);
+
+	clk = of_clk_get(node, 1);
+
+	if (IS_ERR(clk)) {
+		pr_debug("clk-bypass missing for %s, retry later\n",
 			 node->name);
 		if (!ti_clk_retry_init(node, hw, _register_dpll))
 			return;
@@ -159,6 +170,8 @@ static void __init _register_dpll(struct clk_hw *hw,
 		goto cleanup;
 	}
 
+	dd->clk_bypass = __clk_get_hw(clk);
+
 	/* register the clock */
 	clk = clk_register(NULL, &clk_hw->hw);
 
@@ -251,8 +264,8 @@ struct clk *ti_clk_register_dpll(struct ti_clk *setup)
 	dd->recal_en_bit = dpll->recal_en_bit;
 	dd->recal_st_bit = dpll->recal_st_bit;
 
-	dd->clk_ref = clk_ref;
-	dd->clk_bypass = clk_bypass;
+	dd->clk_ref = __clk_get_hw(clk_ref);
+	dd->clk_bypass = __clk_get_hw(clk_bypass);
 
 	if (dpll->flags & CLKF_CORE)
 		ops = &omap3_dpll_core_ck_ops;
diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index cc73929..88f2ce8 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -98,7 +98,7 @@ static u16 _omap3_dpll_compute_freqsel(struct clk_hw_omap *clk, u8 n)
 	unsigned long fint;
 	u16 f = 0;
 
-	fint = clk_get_rate(clk->dpll_data->clk_ref) / n;
+	fint = clk_hw_get_rate(clk->dpll_data->clk_ref) / n;
 
 	pr_debug("clock: fint is %lu\n", fint);
 
@@ -460,12 +460,11 @@ int omap3_noncore_dpll_enable(struct clk_hw *hw)
 
 	parent = clk_hw_get_parent(hw);
 
-	if (clk_hw_get_rate(hw) ==
-	    clk_hw_get_rate(__clk_get_hw(dd->clk_bypass))) {
-		WARN_ON(parent != __clk_get_hw(dd->clk_bypass));
+	if (clk_hw_get_rate(hw) == clk_hw_get_rate(dd->clk_bypass)) {
+		WARN_ON(parent != dd->clk_bypass);
 		r = _omap3_noncore_dpll_bypass(clk);
 	} else {
-		WARN_ON(parent != __clk_get_hw(dd->clk_ref));
+		WARN_ON(parent != dd->clk_ref);
 		r = _omap3_noncore_dpll_lock(clk);
 	}
 
@@ -513,13 +512,13 @@ int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
 	if (!dd)
 		return -EINVAL;
 
-	if (clk_get_rate(dd->clk_bypass) == req->rate &&
+	if (clk_hw_get_rate(dd->clk_bypass) == req->rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		req->best_parent_hw = __clk_get_hw(dd->clk_bypass);
+		req->best_parent_hw = dd->clk_bypass;
 	} else {
 		req->rate = omap2_dpll_round_rate(hw, req->rate,
 					  &req->best_parent_rate);
-		req->best_parent_hw = __clk_get_hw(dd->clk_ref);
+		req->best_parent_hw = dd->clk_ref;
 	}
 
 	req->best_parent_rate = req->rate;
@@ -577,7 +576,7 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!dd)
 		return -EINVAL;
 
-	if (clk_hw_get_parent(hw) != __clk_get_hw(dd->clk_ref))
+	if (clk_hw_get_parent(hw) != dd->clk_ref)
 		return -EINVAL;
 
 	if (dd->last_rounded_rate == 0)
diff --git a/drivers/clk/ti/dpll44xx.c b/drivers/clk/ti/dpll44xx.c
index 660d743..82c05b5 100644
--- a/drivers/clk/ti/dpll44xx.c
+++ b/drivers/clk/ti/dpll44xx.c
@@ -94,7 +94,7 @@ static void omap4_dpll_lpmode_recalc(struct dpll_data *dd)
 {
 	long fint, fout;
 
-	fint = clk_get_rate(dd->clk_ref) / (dd->last_rounded_n + 1);
+	fint = clk_hw_get_rate(dd->clk_ref) / (dd->last_rounded_n + 1);
 	fout = fint * dd->last_rounded_m;
 
 	if ((fint < OMAP4_DPLL_LP_FINT_MAX) && (fout < OMAP4_DPLL_LP_FOUT_MAX))
@@ -212,13 +212,13 @@ int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
 	if (!dd)
 		return -EINVAL;
 
-	if (clk_get_rate(dd->clk_bypass) == req->rate &&
+	if (clk_hw_get_rate(dd->clk_bypass) == req->rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		req->best_parent_hw = __clk_get_hw(dd->clk_bypass);
+		req->best_parent_hw = dd->clk_bypass;
 	} else {
 		req->rate = omap4_dpll_regm4xen_round_rate(hw, req->rate,
 						&req->best_parent_rate);
-		req->best_parent_hw = __clk_get_hw(dd->clk_ref);
+		req->best_parent_hw = dd->clk_ref;
 	}
 
 	req->best_parent_rate = req->rate;
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 9a63860..dc5164a 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -23,8 +23,8 @@
  * @mult_div1_reg: register containing the DPLL M and N bitfields
  * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
  * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
- * @clk_bypass: struct clk pointer to the clock's bypass clock input
- * @clk_ref: struct clk pointer to the clock's reference clock input
+ * @clk_bypass: struct clk_hw pointer to the clock's bypass clock input
+ * @clk_ref: struct clk_hw pointer to the clock's reference clock input
  * @control_reg: register containing the DPLL mode bitfield
  * @enable_mask: mask of the DPLL mode bitfield in @control_reg
  * @last_rounded_rate: cache of the last rate result of omap2_dpll_round_rate()
@@ -69,8 +69,8 @@ struct dpll_data {
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
 	u32			div1_mask;
-	struct clk		*clk_bypass;
-	struct clk		*clk_ref;
+	struct clk_hw		*clk_bypass;
+	struct clk_hw		*clk_ref;
 	void __iomem		*control_reg;
 	u32			enable_mask;
 	unsigned long		last_rounded_rate;
-- 
1.7.9.5

