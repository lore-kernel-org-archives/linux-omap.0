From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 5/5] ARM: OMAP3+: DPLL: use determine_rate() and set_rate_and_parent()
Date: Fri, 3 Oct 2014 16:57:14 +0300
Message-ID: <1412344634-2798-6-git-send-email-t-kristo@ti.com>
References: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52955 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbaJCN6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2014 09:58:00 -0400
In-Reply-To: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Currently, DPLLs are hiding the gory details of switching parent
within set_rate, which confuses the common clock code and is wrong.
Fixed by applying the new determine_rate() and set_rate_and_parent()
functionality to any clock-ops previously using the broken approach.
This patch also removes the broken legacy code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c |    6 +++
 arch/arm/mach-omap2/dpll3xxx.c        |   96 ++-------------------------------
 drivers/clk/ti/dpll.c                 |   15 ++++++
 3 files changed, 25 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index eb8c75e..5c5ebb4 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -257,6 +257,9 @@ static const struct clk_ops dpll1_ck_ops = {
 	.get_parent	= &omap2_init_dpll_parent,
 	.recalc_rate	= &omap3_dpll_recalc,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.set_parent	= &omap3_noncore_dpll_set_parent,
+	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
+	.determine_rate	= &omap3_noncore_dpll_determine_rate,
 	.round_rate	= &omap2_dpll_round_rate,
 };
 
@@ -367,6 +370,9 @@ static const struct clk_ops dpll4_ck_ops = {
 	.get_parent	= &omap2_init_dpll_parent,
 	.recalc_rate	= &omap3_dpll_recalc,
 	.set_rate	= &omap3_dpll4_set_rate,
+	.set_parent	= &omap3_noncore_dpll_set_parent,
+	.set_rate_and_parent	= &omap3_dpll4_set_rate_and_parent,
+	.determine_rate	= &omap3_noncore_dpll_determine_rate,
 	.round_rate	= &omap2_dpll_round_rate,
 };
 
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index cfe7c30..20e120d 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -460,93 +460,6 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw)
 /* Non-CORE DPLL rate set code */
 
 /**
- * omap3_noncore_dpll_set_rate - set non-core DPLL rate
- * @clk: struct clk * of DPLL to set
- * @rate: rounded target rate
- *
- * Set the DPLL CLKOUT to the target rate.  If the DPLL can enter
- * low-power bypass, and the target rate is the bypass source clock
- * rate, then configure the DPLL for bypass.  Otherwise, round the
- * target rate if it hasn't been done already, then program and lock
- * the DPLL.  Returns -EINVAL upon error, or 0 upon success.
- */
-int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long parent_rate)
-{
-	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-	struct clk *new_parent = NULL;
-	unsigned long rrate;
-	u16 freqsel = 0;
-	struct dpll_data *dd;
-	int ret;
-
-	if (!hw || !rate)
-		return -EINVAL;
-
-	dd = clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
-
-	if (__clk_get_rate(dd->clk_bypass) == rate &&
-	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		pr_debug("%s: %s: set rate: entering bypass.\n",
-			 __func__, __clk_get_name(hw->clk));
-
-		__clk_prepare(dd->clk_bypass);
-		clk_enable(dd->clk_bypass);
-		ret = _omap3_noncore_dpll_bypass(clk);
-		if (!ret)
-			new_parent = dd->clk_bypass;
-		clk_disable(dd->clk_bypass);
-		__clk_unprepare(dd->clk_bypass);
-	} else {
-		__clk_prepare(dd->clk_ref);
-		clk_enable(dd->clk_ref);
-
-		/* XXX this check is probably pointless in the CCF context */
-		if (dd->last_rounded_rate != rate) {
-			rrate = __clk_round_rate(hw->clk, rate);
-			if (rrate != rate) {
-				pr_warn("%s: %s: final rate %lu does not match desired rate %lu\n",
-					__func__, __clk_get_name(hw->clk),
-					rrate, rate);
-				rate = rrate;
-			}
-		}
-
-		if (dd->last_rounded_rate == 0)
-			return -EINVAL;
-
-		/* Freqsel is available only on OMAP343X devices */
-		if (ti_clk_features.flags & TI_CLK_DPLL_HAS_FREQSEL) {
-			freqsel = _omap3_dpll_compute_freqsel(clk,
-						dd->last_rounded_n);
-			WARN_ON(!freqsel);
-		}
-
-		pr_debug("%s: %s: set rate: locking rate to %lu.\n",
-			 __func__, __clk_get_name(hw->clk), rate);
-
-		ret = omap3_noncore_dpll_program(clk, freqsel);
-		if (!ret)
-			new_parent = dd->clk_ref;
-		clk_disable(dd->clk_ref);
-		__clk_unprepare(dd->clk_ref);
-	}
-	/*
-	* FIXME - this is all wrong.  common code handles reparenting and
-	* migrating prepare/enable counts.  dplls should be a multiplexer
-	* clock and this should be a set_parent operation so that all of that
-	* stuff is inherited for free
-	*/
-
-	if (!ret && clk_get_parent(hw->clk) != new_parent)
-		__clk_reparent(hw->clk, new_parent);
-
-	return 0;
-}
-
-/**
  * omap3_noncore_dpll_determine_rate - determine rate for a DPLL
  * @hw: pointer to the clock to determine rate for
  * @rate: target rate for the DPLL
@@ -611,7 +524,7 @@ int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index)
 }
 
 /**
- * omap3_noncore_dpll_set_rate_new - set rate for a DPLL clock
+ * omap3_noncore_dpll_set_rate - set rate for a DPLL clock
  * @hw: pointer to the clock to set parent for
  * @rate: target rate for the clock
  * @parent_rate: rate of the parent clock
@@ -621,9 +534,8 @@ int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index)
  * changed) and proceeds with the rate change operation. Returns 0
  * with success, negative error value otherwise.
  */
-static int omap3_noncore_dpll_set_rate_new(struct clk_hw *hw,
-					   unsigned long rate,
-					   unsigned long parent_rate)
+int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct dpll_data *dd;
@@ -688,7 +600,7 @@ int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
 	if (index)
 		ret = omap3_noncore_dpll_set_parent(hw, index);
 	else
-		ret = omap3_noncore_dpll_set_rate_new(hw, rate, parent_rate);
+		ret = omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
 
 	return ret;
 }
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 79791e1..85ac0dd 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -33,6 +33,9 @@ static const struct clk_ops dpll_m4xen_ck_ops = {
 	.recalc_rate	= &omap4_dpll_regm4xen_recalc,
 	.round_rate	= &omap4_dpll_regm4xen_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.set_parent	= &omap3_noncore_dpll_set_parent,
+	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
+	.determine_rate	= &omap4_dpll_regm4xen_determine_rate,
 	.get_parent	= &omap2_init_dpll_parent,
 };
 #else
@@ -53,6 +56,9 @@ static const struct clk_ops dpll_ck_ops = {
 	.recalc_rate	= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.set_parent	= &omap3_noncore_dpll_set_parent,
+	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
+	.determine_rate	= &omap3_noncore_dpll_determine_rate,
 	.get_parent	= &omap2_init_dpll_parent,
 };
 
@@ -61,6 +67,9 @@ static const struct clk_ops dpll_no_gate_ck_ops = {
 	.get_parent	= &omap2_init_dpll_parent,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.set_parent	= &omap3_noncore_dpll_set_parent,
+	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
+	.determine_rate	= &omap3_noncore_dpll_determine_rate,
 };
 #else
 static const struct clk_ops dpll_core_ck_ops = {};
@@ -97,6 +106,9 @@ static const struct clk_ops omap3_dpll_ck_ops = {
 	.get_parent	= &omap2_init_dpll_parent,
 	.recalc_rate	= &omap3_dpll_recalc,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.set_parent	= &omap3_noncore_dpll_set_parent,
+	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
+	.determine_rate	= &omap3_noncore_dpll_determine_rate,
 	.round_rate	= &omap2_dpll_round_rate,
 };
 
@@ -106,6 +118,9 @@ static const struct clk_ops omap3_dpll_per_ck_ops = {
 	.get_parent	= &omap2_init_dpll_parent,
 	.recalc_rate	= &omap3_dpll_recalc,
 	.set_rate	= &omap3_dpll4_set_rate,
+	.set_parent	= &omap3_noncore_dpll_set_parent,
+	.set_rate_and_parent	= &omap3_dpll4_set_rate_and_parent,
+	.determine_rate	= &omap3_noncore_dpll_determine_rate,
 	.round_rate	= &omap2_dpll_round_rate,
 };
 #endif
-- 
1.7.9.5

