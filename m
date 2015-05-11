From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 19/27] clk: ti: clkdm: move clkdm gate clock support code to clock driver
Date: Mon, 11 May 2015 11:54:45 +0300
Message-ID: <1431334493-24455-20-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49525 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbbEKIzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2015 04:55:35 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

With the legacy clock data gone, this is no longer needed under platform,
so move it under the clock driver itself. Remove the exported clock driver
APIs as well, as these are not needed outside clock driver anymore.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c  |   76 ------------------------------------------
 arch/arm/mach-omap2/clock.h  |    3 --
 drivers/clk/ti/clock.h       |    3 ++
 drivers/clk/ti/clockdomain.c |   76 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h       |    2 --
 5 files changed, 79 insertions(+), 81 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 38a336b..99875db 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -202,82 +202,6 @@ void omap2_init_clk_clkdm(struct clk_hw *hw)
 	}
 }
 
-/**
- * omap2_clkops_enable_clkdm - increment usecount on clkdm of @hw
- * @hw: struct clk_hw * of the clock being enabled
- *
- * Increment the usecount of the clockdomain of the clock pointed to
- * by @hw; if the usecount is 1, the clockdomain will be "enabled."
- * Only needed for clocks that don't use omap2_dflt_clk_enable() as
- * their enable function pointer.  Passes along the return value of
- * clkdm_clk_enable(), -EINVAL if @hw is not associated with a
- * clockdomain, or 0 if clock framework-based clockdomain control is
- * not implemented.
- */
-int omap2_clkops_enable_clkdm(struct clk_hw *hw)
-{
-	struct clk_hw_omap *clk;
-	int ret = 0;
-
-	clk = to_clk_hw_omap(hw);
-
-	if (unlikely(!clk->clkdm)) {
-		pr_err("%s: %s: no clkdm set ?!\n", __func__,
-		       __clk_get_name(hw->clk));
-		return -EINVAL;
-	}
-
-	if (unlikely(clk->enable_reg))
-		pr_err("%s: %s: should use dflt_clk_enable ?!\n", __func__,
-		       __clk_get_name(hw->clk));
-
-	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) {
-		pr_err("%s: %s: clkfw-based clockdomain control disabled ?!\n",
-		       __func__, __clk_get_name(hw->clk));
-		return 0;
-	}
-
-	ret = clkdm_clk_enable(clk->clkdm, hw->clk);
-	WARN(ret, "%s: could not enable %s's clockdomain %s: %d\n",
-	     __func__, __clk_get_name(hw->clk), clk->clkdm->name, ret);
-
-	return ret;
-}
-
-/**
- * omap2_clkops_disable_clkdm - decrement usecount on clkdm of @hw
- * @hw: struct clk_hw * of the clock being disabled
- *
- * Decrement the usecount of the clockdomain of the clock pointed to
- * by @hw; if the usecount is 0, the clockdomain will be "disabled."
- * Only needed for clocks that don't use omap2_dflt_clk_disable() as their
- * disable function pointer.  No return value.
- */
-void omap2_clkops_disable_clkdm(struct clk_hw *hw)
-{
-	struct clk_hw_omap *clk;
-
-	clk = to_clk_hw_omap(hw);
-
-	if (unlikely(!clk->clkdm)) {
-		pr_err("%s: %s: no clkdm set ?!\n", __func__,
-		       __clk_get_name(hw->clk));
-		return;
-	}
-
-	if (unlikely(clk->enable_reg))
-		pr_err("%s: %s: should use dflt_clk_disable ?!\n", __func__,
-		       __clk_get_name(hw->clk));
-
-	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) {
-		pr_err("%s: %s: clkfw-based clockdomain control disabled ?!\n",
-		       __func__, __clk_get_name(hw->clk));
-		return;
-	}
-
-	clkdm_clk_disable(clk->clkdm, hw->clk);
-}
-
 static int __initdata mpurate;
 
 /*
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 9480654..a7e9511 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -202,9 +202,6 @@ extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 extern const struct clk_hw_omap_ops clkhwops_apll54;
 extern const struct clk_hw_omap_ops clkhwops_apll96;
 
-extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
-extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
-
 struct regmap;
 
 int __init omap2_clk_provider_init(struct device_node *np, int index,
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 3652c26..83476d1 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -180,6 +180,9 @@ extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
 
+int omap2_clkops_enable_clkdm(struct clk_hw *hw);
+void omap2_clkops_disable_clkdm(struct clk_hw *hw);
+
 int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 35fe108..61ef87b 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -24,6 +24,82 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
+/**
+ * omap2_clkops_enable_clkdm - increment usecount on clkdm of @hw
+ * @hw: struct clk_hw * of the clock being enabled
+ *
+ * Increment the usecount of the clockdomain of the clock pointed to
+ * by @hw; if the usecount is 1, the clockdomain will be "enabled."
+ * Only needed for clocks that don't use omap2_dflt_clk_enable() as
+ * their enable function pointer.  Passes along the return value of
+ * clkdm_clk_enable(), -EINVAL if @hw is not associated with a
+ * clockdomain, or 0 if clock framework-based clockdomain control is
+ * not implemented.
+ */
+int omap2_clkops_enable_clkdm(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk;
+	int ret = 0;
+
+	clk = to_clk_hw_omap(hw);
+
+	if (unlikely(!clk->clkdm)) {
+		pr_err("%s: %s: no clkdm set ?!\n", __func__,
+		       __clk_get_name(hw->clk));
+		return -EINVAL;
+	}
+
+	if (unlikely(clk->enable_reg))
+		pr_err("%s: %s: should use dflt_clk_enable ?!\n", __func__,
+		       __clk_get_name(hw->clk));
+
+	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) {
+		pr_err("%s: %s: clkfw-based clockdomain control disabled ?!\n",
+		       __func__, __clk_get_name(hw->clk));
+		return 0;
+	}
+
+	ret = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
+	WARN(ret, "%s: could not enable %s's clockdomain %s: %d\n",
+	     __func__, __clk_get_name(hw->clk), clk->clkdm_name, ret);
+
+	return ret;
+}
+
+/**
+ * omap2_clkops_disable_clkdm - decrement usecount on clkdm of @hw
+ * @hw: struct clk_hw * of the clock being disabled
+ *
+ * Decrement the usecount of the clockdomain of the clock pointed to
+ * by @hw; if the usecount is 0, the clockdomain will be "disabled."
+ * Only needed for clocks that don't use omap2_dflt_clk_disable() as their
+ * disable function pointer.  No return value.
+ */
+void omap2_clkops_disable_clkdm(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk;
+
+	clk = to_clk_hw_omap(hw);
+
+	if (unlikely(!clk->clkdm)) {
+		pr_err("%s: %s: no clkdm set ?!\n", __func__,
+		       __clk_get_name(hw->clk));
+		return;
+	}
+
+	if (unlikely(clk->enable_reg))
+		pr_err("%s: %s: should use dflt_clk_disable ?!\n", __func__,
+		       __clk_get_name(hw->clk));
+
+	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) {
+		pr_err("%s: %s: clkfw-based clockdomain control disabled ?!\n",
+		       __func__, __clk_get_name(hw->clk));
+		return;
+	}
+
+	ti_clk_ll_ops->clkdm_clk_disable(clk->clkdm, hw->clk);
+}
+
 static void __init of_ti_clockdomain_setup(struct device_node *node)
 {
 	struct clk *clk;
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index a7728f7..6361f21 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -272,8 +272,6 @@ extern const struct clk_ops ti_clk_mux_ops;
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
 void omap2_init_clk_clkdm(struct clk_hw *clk);
-int omap2_clkops_enable_clkdm(struct clk_hw *hw);
-void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 int omap2_clk_disable_autoidle_all(void);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_allow_idle(struct clk *clk);
-- 
1.7.9.5

