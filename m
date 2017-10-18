From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v0] clk: ti: omap3+: dpll: remove extra checks for NULL
Date: Wed, 18 Oct 2017 12:20:54 +0200
Message-ID: <20171018102054.ntuo4nyosdtlydi2@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

As clk and clk->dpll_data are never NULL, there is no point
to check them before dereferencing.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Note: This is v0 patch as it could be probably extended/improved.
       It was done after Tero's remark here:
       http://www.spinics.net/lists/linux-omap/msg126812.html
       and I have it in my tree since then. Perhaps it's time to
       mainline it.

 drivers/clk/ti/dpll3xxx.c | 42 ++++++++++--------------------------------
 drivers/clk/ti/dpll44xx.c |  8 --------
 2 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 63f70e829f2b..e09cd2786b51 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -438,14 +438,10 @@ unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate)
  */
 int omap3_noncore_dpll_enable(struct clk_hw *hw)
 {
-	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	int r;
-	struct dpll_data *dd;
 	struct clk_hw *parent;
-
-	dd = clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *dd = clk->dpll_data;
 
 	if (clk->clkdm) {
 		r = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
@@ -509,9 +505,6 @@ int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
 		return -EINVAL;
 
 	dd = clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
-
 	if (clk_hw_get_rate(dd->clk_bypass) == req->rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
 		req->best_parent_hw = dd->clk_bypass;
@@ -537,17 +530,11 @@ int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
 int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-	int ret;
-
-	if (!hw)
-		return -EINVAL;
 
 	if (index)
-		ret = _omap3_noncore_dpll_bypass(clk);
-	else
-		ret = _omap3_noncore_dpll_lock(clk);
+		return _omap3_noncore_dpll_bypass(clk);
 
-	return ret;
+	return _omap3_noncore_dpll_lock(clk);
 }
 
 /**
@@ -569,12 +556,10 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	u16 freqsel = 0;
 	int ret;
 
-	if (!hw || !rate)
+	if (!rate)
 		return -EINVAL;
 
 	dd = clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
 
 	if (clk_hw_get_parent(hw) != dd->clk_ref)
 		return -EINVAL;
@@ -614,22 +599,15 @@ int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
 					   unsigned long parent_rate,
 					   u8 index)
 {
-	int ret;
-
-	if (!hw || !rate)
-		return -EINVAL;
-
 	/*
 	 * clk-ref at index[0], in which case we only need to set rate,
 	 * the parent will be changed automatically with the lock sequence.
 	 * With clk-bypass case we only need to change parent.
 	 */
 	if (index)
-		ret = omap3_noncore_dpll_set_parent(hw, index);
-	else
-		ret = omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
+		return omap3_noncore_dpll_set_parent(hw, index);
 
-	return ret;
+	return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
 }
 
 /* DPLL autoidle read/set code */
@@ -647,7 +625,7 @@ static u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
 	const struct dpll_data *dd;
 	u32 v;
 
-	if (!clk || !clk->dpll_data)
+	if (!clk)
 		return -EINVAL;
 
 	dd = clk->dpll_data;
@@ -676,7 +654,7 @@ static void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
 	const struct dpll_data *dd;
 	u32 v;
 
-	if (!clk || !clk->dpll_data)
+	if (!clk)
 		return;
 
 	dd = clk->dpll_data;
@@ -706,7 +684,7 @@ static void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
 	const struct dpll_data *dd;
 	u32 v;
 
-	if (!clk || !clk->dpll_data)
+	if (!clk)
 		return;
 
 	dd = clk->dpll_data;
diff --git a/drivers/clk/ti/dpll44xx.c b/drivers/clk/ti/dpll44xx.c
index d7a3f7ec8d77..5d048fd90036 100644
--- a/drivers/clk/ti/dpll44xx.c
+++ b/drivers/clk/ti/dpll44xx.c
@@ -120,9 +120,6 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 	unsigned long rate;
 	struct dpll_data *dd;
 
-	if (!clk || !clk->dpll_data)
-		return 0;
-
 	dd = clk->dpll_data;
 
 	rate = omap2_get_dpll_rate(clk);
@@ -155,9 +152,6 @@ long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
 	struct dpll_data *dd;
 	long r;
 
-	if (!clk || !clk->dpll_data)
-		return -EINVAL;
-
 	dd = clk->dpll_data;
 
 	dd->last_rounded_m4xen = 0;
@@ -209,8 +203,6 @@ int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
 		return -EINVAL;
 
 	dd = clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
 
 	if (clk_hw_get_rate(dd->clk_bypass) == req->rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-- 
2.11.0

