From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 09/27] clk: ti: autoidle: move generic autoidle handling code to clock driver
Date: Mon, 25 May 2015 18:00:14 +0300
Message-ID: <1432566032-10860-10-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48960 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbbEYPBR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 May 2015 11:01:17 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This is no longer needed in platform directory, as the legacy clock data
is gone, so move it under TI clock driver. Some static functions are
renamed also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c   |  104 -----------------------------------
 arch/arm/mach-omap2/clock.h   |    3 --
 drivers/clk/ti/autoidle.c     |  119 ++++++++++++++++++++++++++++++++++++++---
 drivers/clk/ti/clock.h        |    3 ++
 drivers/clk/ti/fixed-factor.c |    2 +
 include/linux/clk/ti.h        |   13 ++---
 6 files changed, 119 insertions(+), 125 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index cbc65b3..42ce860 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -69,8 +69,6 @@ u16 cpu_mask;
  */
 static bool clkdm_control = true;
 
-static LIST_HEAD(clk_hw_omap_clocks);
-
 struct clk_iomap {
 	struct regmap *regmap;
 	void __iomem *mem;
@@ -579,108 +577,6 @@ static int __init omap_clk_setup(char *str)
 __setup("mpurate=", omap_clk_setup);
 
 /**
- * omap2_init_clk_hw_omap_clocks - initialize an OMAP clock
- * @clk: struct clk * to initialize
- *
- * Add an OMAP clock @clk to the internal list of OMAP clocks.  Used
- * temporarily for autoidle handling, until this support can be
- * integrated into the common clock framework code in some way.  No
- * return value.
- */
-void omap2_init_clk_hw_omap_clocks(struct clk *clk)
-{
-	struct clk_hw_omap *c;
-
-	if (__clk_get_flags(clk) & CLK_IS_BASIC)
-		return;
-
-	c = to_clk_hw_omap(__clk_get_hw(clk));
-	list_add(&c->node, &clk_hw_omap_clocks);
-}
-
-/**
- * omap2_clk_enable_autoidle_all - enable autoidle on all OMAP clocks that
- * support it
- *
- * Enable clock autoidle on all OMAP clocks that have allow_idle
- * function pointers associated with them.  This function is intended
- * to be temporary until support for this is added to the common clock
- * code.  Returns 0.
- */
-int omap2_clk_enable_autoidle_all(void)
-{
-	struct clk_hw_omap *c;
-
-	list_for_each_entry(c, &clk_hw_omap_clocks, node)
-		if (c->ops && c->ops->allow_idle)
-			c->ops->allow_idle(c);
-
-	of_ti_clk_allow_autoidle_all();
-
-	return 0;
-}
-
-/**
- * omap2_clk_disable_autoidle_all - disable autoidle on all OMAP clocks that
- * support it
- *
- * Disable clock autoidle on all OMAP clocks that have allow_idle
- * function pointers associated with them.  This function is intended
- * to be temporary until support for this is added to the common clock
- * code.  Returns 0.
- */
-int omap2_clk_disable_autoidle_all(void)
-{
-	struct clk_hw_omap *c;
-
-	list_for_each_entry(c, &clk_hw_omap_clocks, node)
-		if (c->ops && c->ops->deny_idle)
-			c->ops->deny_idle(c);
-
-	of_ti_clk_deny_autoidle_all();
-
-	return 0;
-}
-
-/**
- * omap2_clk_deny_idle - disable autoidle on an OMAP clock
- * @clk: struct clk * to disable autoidle for
- *
- * Disable autoidle on an OMAP clock.
- */
-int omap2_clk_deny_idle(struct clk *clk)
-{
-	struct clk_hw_omap *c;
-
-	if (__clk_get_flags(clk) & CLK_IS_BASIC)
-		return -EINVAL;
-
-	c = to_clk_hw_omap(__clk_get_hw(clk));
-	if (c->ops && c->ops->deny_idle)
-		c->ops->deny_idle(c);
-	return 0;
-}
-
-/**
- * omap2_clk_allow_idle - enable autoidle on an OMAP clock
- * @clk: struct clk * to enable autoidle for
- *
- * Enable autoidle on an OMAP clock.
- */
-int omap2_clk_allow_idle(struct clk *clk)
-{
-	struct clk_hw_omap *c;
-
-	if (__clk_get_flags(clk) & CLK_IS_BASIC)
-		return -EINVAL;
-
-	c = to_clk_hw_omap(__clk_get_hw(clk));
-	if (c->ops && c->ops->allow_idle)
-		c->ops->allow_idle(c);
-	return 0;
-}
-
-/**
  * omap2_clk_enable_init_clocks - prepare & enable a list of clocks
  * @clk_names: ptr to an array of strings of clock names to enable
  * @num_clocks: number of clock names in @clk_names
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b71d430..950a17a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -186,9 +186,6 @@ void omap3_dpll_deny_idle(struct clk_hw_omap *clk);
 
 void __init omap2_clk_disable_clkdm_control(void);
 
-int omap2_clk_enable_autoidle_all(void);
-int omap2_clk_allow_idle(struct clk *clk);
-int omap2_clk_deny_idle(struct clk *clk);
 int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index e75c64c..3dbcc36 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -33,8 +33,47 @@ struct clk_ti_autoidle {
 #define AUTOIDLE_LOW		0x1
 
 static LIST_HEAD(autoidle_clks);
+static LIST_HEAD(clk_hw_omap_clocks);
 
-static void ti_allow_autoidle(struct clk_ti_autoidle *clk)
+/**
+ * omap2_clk_deny_idle - disable autoidle on an OMAP clock
+ * @clk: struct clk * to disable autoidle for
+ *
+ * Disable autoidle on an OMAP clock.
+ */
+int omap2_clk_deny_idle(struct clk *clk)
+{
+	struct clk_hw_omap *c;
+
+	if (__clk_get_flags(clk) & CLK_IS_BASIC)
+		return -EINVAL;
+
+	c = to_clk_hw_omap(__clk_get_hw(clk));
+	if (c->ops && c->ops->deny_idle)
+		c->ops->deny_idle(c);
+	return 0;
+}
+
+/**
+ * omap2_clk_allow_idle - enable autoidle on an OMAP clock
+ * @clk: struct clk * to enable autoidle for
+ *
+ * Enable autoidle on an OMAP clock.
+ */
+int omap2_clk_allow_idle(struct clk *clk)
+{
+	struct clk_hw_omap *c;
+
+	if (__clk_get_flags(clk) & CLK_IS_BASIC)
+		return -EINVAL;
+
+	c = to_clk_hw_omap(__clk_get_hw(clk));
+	if (c->ops && c->ops->allow_idle)
+		c->ops->allow_idle(c);
+	return 0;
+}
+
+static void _allow_autoidle(struct clk_ti_autoidle *clk)
 {
 	u32 val;
 
@@ -48,7 +87,7 @@ static void ti_allow_autoidle(struct clk_ti_autoidle *clk)
 	ti_clk_ll_ops->clk_writel(val, clk->reg);
 }
 
-static void ti_deny_autoidle(struct clk_ti_autoidle *clk)
+static void _deny_autoidle(struct clk_ti_autoidle *clk)
 {
 	u32 val;
 
@@ -63,31 +102,31 @@ static void ti_deny_autoidle(struct clk_ti_autoidle *clk)
 }
 
 /**
- * of_ti_clk_allow_autoidle_all - enable autoidle for all clocks
+ * _clk_generic_allow_autoidle_all - enable autoidle for all clocks
  *
  * Enables hardware autoidle for all registered DT clocks, which have
  * the feature.
  */
-void of_ti_clk_allow_autoidle_all(void)
+static void _clk_generic_allow_autoidle_all(void)
 {
 	struct clk_ti_autoidle *c;
 
 	list_for_each_entry(c, &autoidle_clks, node)
-		ti_allow_autoidle(c);
+		_allow_autoidle(c);
 }
 
 /**
- * of_ti_clk_deny_autoidle_all - disable autoidle for all clocks
+ * _clk_generic_deny_autoidle_all - disable autoidle for all clocks
  *
  * Disables hardware autoidle for all registered DT clocks, which have
  * the feature.
  */
-void of_ti_clk_deny_autoidle_all(void)
+static void _clk_generic_deny_autoidle_all(void)
 {
 	struct clk_ti_autoidle *c;
 
 	list_for_each_entry(c, &autoidle_clks, node)
-		ti_deny_autoidle(c);
+		_deny_autoidle(c);
 }
 
 /**
@@ -131,3 +170,67 @@ int __init of_ti_clk_autoidle_setup(struct device_node *node)
 
 	return 0;
 }
+
+/**
+ * omap2_init_clk_hw_omap_clocks - initialize an OMAP clock
+ * @clk: struct clk * to initialize
+ *
+ * Add an OMAP clock @clk to the internal list of OMAP clocks.  Used
+ * temporarily for autoidle handling, until this support can be
+ * integrated into the common clock framework code in some way.  No
+ * return value.
+ */
+void omap2_init_clk_hw_omap_clocks(struct clk *clk)
+{
+	struct clk_hw_omap *c;
+
+	if (__clk_get_flags(clk) & CLK_IS_BASIC)
+		return;
+
+	c = to_clk_hw_omap(__clk_get_hw(clk));
+	list_add(&c->node, &clk_hw_omap_clocks);
+}
+
+/**
+ * omap2_clk_enable_autoidle_all - enable autoidle on all OMAP clocks that
+ * support it
+ *
+ * Enable clock autoidle on all OMAP clocks that have allow_idle
+ * function pointers associated with them.  This function is intended
+ * to be temporary until support for this is added to the common clock
+ * code.  Returns 0.
+ */
+int omap2_clk_enable_autoidle_all(void)
+{
+	struct clk_hw_omap *c;
+
+	list_for_each_entry(c, &clk_hw_omap_clocks, node)
+		if (c->ops && c->ops->allow_idle)
+			c->ops->allow_idle(c);
+
+	_clk_generic_allow_autoidle_all();
+
+	return 0;
+}
+
+/**
+ * omap2_clk_disable_autoidle_all - disable autoidle on all OMAP clocks that
+ * support it
+ *
+ * Disable clock autoidle on all OMAP clocks that have allow_idle
+ * function pointers associated with them.  This function is intended
+ * to be temporary until support for this is added to the common clock
+ * code.  Returns 0.
+ */
+int omap2_clk_disable_autoidle_all(void)
+{
+	struct clk_hw_omap *c;
+
+	list_for_each_entry(c, &clk_hw_omap_clocks, node)
+		if (c->ops && c->ops->deny_idle)
+			c->ops->deny_idle(c);
+
+	_clk_generic_deny_autoidle_all();
+
+	return 0;
+}
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index a7256a9..9b51021 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -169,6 +169,9 @@ void ti_clk_patch_legacy_clks(struct ti_clk **patch);
 struct clk *ti_clk_register_clk(struct ti_clk *setup);
 int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
 
+void omap2_init_clk_hw_omap_clocks(struct clk *clk);
+int of_ti_clk_autoidle_setup(struct device_node *node);
+
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
diff --git a/drivers/clk/ti/fixed-factor.c b/drivers/clk/ti/fixed-factor.c
index c2c8a28..3cd4067 100644
--- a/drivers/clk/ti/fixed-factor.c
+++ b/drivers/clk/ti/fixed-factor.c
@@ -22,6 +22,8 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 63f2945..2e4b4fb 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -259,7 +259,6 @@ extern const struct clk_ops ti_clk_mux_ops;
 
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
-void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap3_noncore_dpll_enable(struct clk_hw *hw);
 void omap3_noncore_dpll_disable(struct clk_hw *hw);
 int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index);
@@ -288,6 +287,9 @@ long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 int omap2_clk_disable_autoidle_all(void);
+int omap2_clk_enable_autoidle_all(void);
+int omap2_clk_allow_idle(struct clk *clk);
+int omap2_clk_deny_idle(struct clk *clk);
 void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
@@ -320,7 +322,6 @@ void ti_dt_clk_init_retry_clks(void);
 void ti_dt_clockdomains_setup(void);
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 		      ti_of_clk_init_cb_t func);
-int of_ti_clk_autoidle_setup(struct device_node *node);
 int ti_clk_add_component(struct device_node *node, struct clk_hw *hw, int type);
 
 int omap3430_dt_clk_init(void);
@@ -351,14 +352,6 @@ struct ti_clk_features {
 void ti_clk_setup_features(struct ti_clk_features *features);
 struct ti_clk_features *ti_clk_get_features(void);
 
-#ifdef CONFIG_OF
-void of_ti_clk_allow_autoidle_all(void);
-void of_ti_clk_deny_autoidle_all(void);
-#else
-static inline void of_ti_clk_allow_autoidle_all(void) { }
-static inline void of_ti_clk_deny_autoidle_all(void) { }
-#endif
-
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
-- 
1.7.9.5

