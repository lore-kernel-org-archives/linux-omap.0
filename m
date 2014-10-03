From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/5] ARM: OMAP4: clock: add support for determine_rate for omap4 regm4xen DPLL
Date: Fri, 3 Oct 2014 16:57:12 +0300
Message-ID: <1412344634-2798-4-git-send-email-t-kristo@ti.com>
References: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52954 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbaJCN57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2014 09:57:59 -0400
In-Reply-To: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Similarly to OMAP3 noncore DPLL, the implementation of this DPLL clock
type is wrong. This patch adds basic functionality for determine_rate
for this clock type which will be taken into use in the patches following
later.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/dpll44xx.c |   41 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h         |    4 ++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 4613f1e..535822f 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -207,3 +207,44 @@ out:
 
 	return dd->last_rounded_rate;
 }
+
+/**
+ * omap4_dpll_regm4xen_determine_rate - determine rate for a DPLL
+ * @hw: pointer to the clock to determine rate for
+ * @rate: target rate for the DPLL
+ * @best_parent_rate: pointer for returning best parent rate
+ * @best_parent_clk: pointer for returning best parent clock
+ *
+ * Determines which DPLL mode to use for reaching a desired rate.
+ * Checks whether the DPLL shall be in bypass or locked mode, and if
+ * locked, calculates the M,N values for the DPLL via round-rate.
+ * Returns a positive clock rate with success, negative error value
+ * in failure.
+ */
+long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *best_parent_rate,
+					struct clk **best_parent_clk)
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
+		rate = omap4_dpll_regm4xen_round_rate(hw, rate,
+						      best_parent_rate);
+		*best_parent_clk = dd->clk_ref;
+	}
+
+	*best_parent_rate = rate;
+
+	return rate;
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 47d0c63..541dc33 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -270,6 +270,10 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
 				    unsigned long target_rate,
 				    unsigned long *parent_rate);
+long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long *best_parent_rate,
+					struct clk **best_parent_clk);
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
 long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
-- 
1.7.9.5

