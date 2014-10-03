From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/5] ARM: OMAP3: clock: add new rate changing logic support for noncore DPLLs
Date: Fri, 3 Oct 2014 16:57:11 +0300
Message-ID: <1412344634-2798-3-git-send-email-t-kristo@ti.com>
References: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60480 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbaJCN5w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Oct 2014 09:57:52 -0400
In-Reply-To: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Currently, DPLL code hides the re-parenting within its internals, which
is wrong. This needs to be exposed to the common clock code via
determine_rate and set_rate_and_parent APIs. This patch adds support
for these, which will be taken into use in the following patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |  147 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h         |    9 +++
 2 files changed, 156 insertions(+)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index ac3d789..cfe7c30 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -546,6 +546,153 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+/**
+ * omap3_noncore_dpll_determine_rate - determine rate for a DPLL
+ * @hw: pointer to the clock to determine rate for
+ * @rate: target rate for the DPLL
+ * @best_parent_rate: pointer for returning best parent rate
+ * @best_parent_clk: pointer for returning best parent clock
+ *
+ * Determines which DPLL mode to use for reaching a desired target rate.
+ * Checks whether the DPLL shall be in bypass or locked mode, and if
+ * locked, calculates the M,N values for the DPLL via round-rate.
+ * Returns a positive clock rate with success, negative error value
+ * in failure.
+ */
+long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *best_parent_rate,
+				       struct clk **best_parent_clk)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *dd;
+
+	if (!hw || !rate)
+		return -EINVAL;
+
+	dd = clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	if (__clk_get_rate(dd->clk_bypass) == rate &&
+	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
+		*best_parent_clk = dd->clk_bypass;
+	} else {
+		rate = omap2_dpll_round_rate(hw, rate, best_parent_rate);
+		*best_parent_clk = dd->clk_ref;
+	}
+
+	*best_parent_rate = rate;
+
+	return rate;
+}
+
+/**
+ * omap3_noncore_dpll_set_parent - set parent for a DPLL clock
+ * @hw: pointer to the clock to set parent for
+ * @index: parent index to select
+ *
+ * Sets parent for a DPLL clock. This sets the DPLL into bypass or
+ * locked mode. Returns 0 with success, negative error value otherwise.
+ */
+int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	int ret;
+
+	if (!hw)
+		return -EINVAL;
+
+	if (index)
+		ret = _omap3_noncore_dpll_bypass(clk);
+	else
+		ret = _omap3_noncore_dpll_lock(clk);
+
+	return ret;
+}
+
+/**
+ * omap3_noncore_dpll_set_rate_new - set rate for a DPLL clock
+ * @hw: pointer to the clock to set parent for
+ * @rate: target rate for the clock
+ * @parent_rate: rate of the parent clock
+ *
+ * Sets rate for a DPLL clock. First checks if the clock parent is
+ * reference clock (in bypass mode, the rate of the clock can't be
+ * changed) and proceeds with the rate change operation. Returns 0
+ * with success, negative error value otherwise.
+ */
+static int omap3_noncore_dpll_set_rate_new(struct clk_hw *hw,
+					   unsigned long rate,
+					   unsigned long parent_rate)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *dd;
+	u16 freqsel = 0;
+	int ret;
+
+	if (!hw || !rate)
+		return -EINVAL;
+
+	dd = clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	if (__clk_get_parent(hw->clk) != dd->clk_ref)
+		return -EINVAL;
+
+	if (dd->last_rounded_rate == 0)
+		return -EINVAL;
+
+	/* Freqsel is available only on OMAP343X devices */
+	if (ti_clk_features.flags & TI_CLK_DPLL_HAS_FREQSEL) {
+		freqsel = _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
+		WARN_ON(!freqsel);
+	}
+
+	pr_debug("%s: %s: set rate: locking rate to %lu.\n", __func__,
+		 __clk_get_name(hw->clk), rate);
+
+	ret = omap3_noncore_dpll_program(clk, freqsel);
+
+	return ret;
+}
+
+/**
+ * omap3_noncore_dpll_set_rate_and_parent - set rate and parent for a DPLL clock
+ * @hw: pointer to the clock to set rate and parent for
+ * @rate: target rate for the DPLL
+ * @parent_rate: clock rate of the DPLL parent
+ * @index: new parent index for the DPLL, 0 - reference, 1 - bypass
+ *
+ * Sets rate and parent for a DPLL clock. If new parent is the bypass
+ * clock, only selects the parent. Otherwise proceeds with a rate
+ * change, as this will effectively also change the parent as the
+ * DPLL is put into locked mode. Returns 0 with success, negative error
+ * value otherwise.
+ */
+int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
+					   unsigned long rate,
+					   unsigned long parent_rate,
+					   u8 index)
+{
+	int ret;
+
+	if (!hw || !rate)
+		return -EINVAL;
+
+	/*
+	 * clk-ref at index[0], in which case we only need to set rate,
+	 * the parent will be changed automatically with the lock sequence.
+	 * With clk-bypass case we only need to change parent.
+	 */
+	if (index)
+		ret = omap3_noncore_dpll_set_parent(hw, index);
+	else
+		ret = omap3_noncore_dpll_set_rate_new(hw, rate, parent_rate);
+
+	return ret;
+}
+
 /* DPLL autoidle read/set code */
 
 /**
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index e8d8a35..47d0c63 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -254,8 +254,17 @@ extern const struct clk_ops ti_clk_mux_ops;
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap3_noncore_dpll_enable(struct clk_hw *hw);
 void omap3_noncore_dpll_disable(struct clk_hw *hw);
+int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index);
 int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate);
+int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
+					   unsigned long rate,
+					   unsigned long parent_rate,
+					   u8 index);
+long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
+				       unsigned long rate,
+				       unsigned long *best_parent_rate,
+				       struct clk **best_parent_clk);
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 					 unsigned long parent_rate);
 long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
-- 
1.7.9.5

