From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 4/5] ARM: OMAP3: clock: add support for dpll4_set_rate_and_parent
Date: Fri, 3 Oct 2014 16:57:13 +0300
Message-ID: <1412344634-2798-5-git-send-email-t-kristo@ti.com>
References: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52952 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbaJCN55 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2014 09:57:57 -0400
In-Reply-To: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Expand the support of omap4 per-dpll to provide set_rate_and_parent.
This is required for proper behavior of clk_change_rate with
determine_rate support.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock3xxx.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h          |    2 ++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 9a25601..a9e86db 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -38,6 +38,18 @@
 
 /* needed by omap3_core_dpll_m2_set_rate() */
 struct clk *sdrc_ick_p, *arm_fck_p;
+
+/**
+ * omap3_dpll4_set_rate - set rate for omap3 per-dpll
+ * @hw: clock to change
+ * @rate: target rate for clock
+ * @parent_rate: rate of the parent clock
+ *
+ * Check if the current SoC supports the per-dpll reprogram operation
+ * or not, and then do the rate change if supported. Returns -EINVAL
+ * if not supported, 0 for success, and potential error codes from the
+ * clock rate change.
+ */
 int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
@@ -54,6 +66,30 @@ int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
 	return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
 }
 
+/**
+ * omap3_dpll4_set_rate_and_parent - set rate and parent for omap3 per-dpll
+ * @hw: clock to change
+ * @rate: target rate for clock
+ * @parent_rate: rate of the parent clock
+ * @index: parent index, 0 - reference clock, 1 - bypass clock
+ *
+ * Check if the current SoC support the per-dpll reprogram operation
+ * or not, and then do the rate + parent change if supported. Returns
+ * -EINVAL if not supported, 0 for success, and potential error codes
+ * from the clock rate change.
+ */
+int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate, u8 index)
+{
+	if (ti_clk_features.flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
+		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2.5' on 3430ES1.\n");
+		return -EINVAL;
+	}
+
+	return omap3_noncore_dpll_set_rate_and_parent(hw, rate, parent_rate,
+						      index);
+}
+
 void __init omap3_clk_lock_dpll5(void)
 {
 	struct clk *dpll5_clk;
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 541dc33..57242ba 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -291,6 +291,8 @@ int omap2_clk_disable_autoidle_all(void);
 void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
+int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate, u8 index);
 int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
-- 
1.7.9.5

