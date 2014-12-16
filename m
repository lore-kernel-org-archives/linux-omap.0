From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/11] clk: ti: dpll: add support for legacy DPLL init
Date: Tue, 16 Dec 2014 18:20:51 +0200
Message-ID: <1418746856-17173-7-git-send-email-t-kristo@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42239 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaLPQUL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2014 11:20:11 -0500
In-Reply-To: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Legacy clock data is initialized slightly differently compared to
DT clocks, thus add support for this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   |    3 ++
 drivers/clk/ti/clock.h |    1 +
 drivers/clk/ti/dpll.c  |  118 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index a0475e2..f41a757 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -228,6 +228,9 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 	case TI_CLK_GATE:
 		clk = ti_clk_register_gate(setup);
 		break;
+	case TI_CLK_DPLL:
+		clk = ti_clk_register_dpll(setup);
+		break;
 	default:
 		pr_err("bad type for %s!\n", setup->name);
 		clk = ERR_PTR(-EINVAL);
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index fe70941..f4e8eb2 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -157,6 +157,7 @@ struct clk *ti_clk_register_gate(struct ti_clk *setup);
 struct clk *ti_clk_register_interface(struct ti_clk *setup);
 struct clk *ti_clk_register_mux(struct ti_clk *setup);
 struct clk *ti_clk_register_divider(struct ti_clk *setup);
+struct clk *ti_clk_register_dpll(struct ti_clk *setup);
 
 struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup);
 struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup);
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 79791e1..0693b8b 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
+#include "clock.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
@@ -115,7 +116,7 @@ static const struct clk_ops dpll_x2_ck_ops = {
 };
 
 /**
- * ti_clk_register_dpll - low level registration of a DPLL clock
+ * _register_dpll - low level registration of a DPLL clock
  * @hw: hardware clock definition for the clock
  * @node: device node for the clock
  *
@@ -123,8 +124,8 @@ static const struct clk_ops dpll_x2_ck_ops = {
  * clk-bypass is missing), the clock is added to retry list and
  * the initialization is retried on later stage.
  */
-static void __init ti_clk_register_dpll(struct clk_hw *hw,
-					struct device_node *node)
+static void __init _register_dpll(struct clk_hw *hw,
+				  struct device_node *node)
 {
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *dd = clk_hw->dpll_data;
@@ -136,7 +137,7 @@ static void __init ti_clk_register_dpll(struct clk_hw *hw,
 	if (IS_ERR(dd->clk_ref) || IS_ERR(dd->clk_bypass)) {
 		pr_debug("clk-ref or clk-bypass missing for %s, retry later\n",
 			 node->name);
-		if (!ti_clk_retry_init(node, hw, ti_clk_register_dpll))
+		if (!ti_clk_retry_init(node, hw, _register_dpll))
 			return;
 
 		goto cleanup;
@@ -160,20 +161,115 @@ cleanup:
 	kfree(clk_hw);
 }
 
+void __iomem *_get_reg(u8 module, u16 offset)
+{
+	u32 reg;
+	struct clk_omap_reg *reg_setup;
+
+	reg_setup = (struct clk_omap_reg *)&reg;
+
+	reg_setup->index = module;
+	reg_setup->offset = offset;
+
+	return (void __iomem *)reg;
+}
+
+struct clk *ti_clk_register_dpll(struct ti_clk *setup)
+{
+	struct clk_hw_omap *clk_hw;
+	struct clk_init_data init = { NULL };
+	struct dpll_data *dd;
+	struct clk *clk;
+	struct ti_clk_dpll *dpll;
+	const struct clk_ops *ops = &omap3_dpll_ck_ops;
+	struct clk *clk_ref;
+	struct clk *clk_bypass;
+
+	dpll = setup->data;
+
+	if (dpll->num_parents < 2)
+		return ERR_PTR(-EINVAL);
+
+	clk_ref = clk_get_sys(NULL, dpll->parents[0]);
+	clk_bypass = clk_get_sys(NULL, dpll->parents[1]);
+
+	if (IS_ERR_OR_NULL(clk_ref) || IS_ERR_OR_NULL(clk_bypass))
+		return ERR_PTR(-EAGAIN);
+
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	if (!dd || !clk_hw) {
+		clk = ERR_PTR(-ENOMEM);
+		goto cleanup;
+	}
+
+	clk_hw->dpll_data = dd;
+	clk_hw->ops = &clkhwops_omap3_dpll;
+	clk_hw->hw.init = &init;
+	clk_hw->flags = MEMMAP_ADDRESSING;
+
+	init.name = setup->name;
+	init.ops = ops;
+
+	init.num_parents = dpll->num_parents;
+	init.parent_names = dpll->parents;
+
+	dd->control_reg = _get_reg(dpll->module, dpll->control_reg);
+	dd->idlest_reg = _get_reg(dpll->module, dpll->idlest_reg);
+	dd->mult_div1_reg = _get_reg(dpll->module, dpll->mult_div1_reg);
+	dd->autoidle_reg = _get_reg(dpll->module, dpll->autoidle_reg);
+
+	dd->modes = dpll->modes;
+	dd->div1_mask = dpll->div1_mask;
+	dd->idlest_mask = dpll->idlest_mask;
+	dd->mult_mask = dpll->mult_mask;
+	dd->autoidle_mask = dpll->autoidle_mask;
+	dd->enable_mask = dpll->enable_mask;
+	dd->sddiv_mask = dpll->sddiv_mask;
+	dd->dco_mask = dpll->dco_mask;
+	dd->max_divider = dpll->max_divider;
+	dd->max_multiplier = dpll->max_multiplier;
+	dd->auto_recal_bit = dpll->auto_recal_bit;
+	dd->recal_en_bit = dpll->recal_en_bit;
+	dd->recal_st_bit = dpll->recal_st_bit;
+
+	dd->clk_ref = clk_ref;
+	dd->clk_bypass = clk_bypass;
+
+	if (dpll->flags & CLKF_CORE)
+		ops = &omap3_dpll_core_ck_ops;
+
+	if (dpll->flags & CLKF_PER)
+		ops = &omap3_dpll_per_ck_ops;
+
+	if (dpll->flags & CLKF_J_TYPE)
+		dd->flags |= DPLL_J_TYPE;
+
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (!IS_ERR(clk))
+		return clk;
+
+cleanup:
+	kfree(dd);
+	kfree(clk_hw);
+	return clk;
+}
+
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
 	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM33XX) || \
 	defined(CONFIG_SOC_AM43XX)
 /**
- * ti_clk_register_dpll_x2 - Registers a DPLLx2 clock
+ * _register_dpll_x2 - Registers a DPLLx2 clock
  * @node: device node for this clock
  * @ops: clk_ops for this clock
  * @hw_ops: clk_hw_ops for this clock
  *
  * Initializes a DPLL x 2 clock from device tree data.
  */
-static void ti_clk_register_dpll_x2(struct device_node *node,
-				    const struct clk_ops *ops,
-				    const struct clk_hw_omap_ops *hw_ops)
+static void _register_dpll_x2(struct device_node *node,
+			      const struct clk_ops *ops,
+			      const struct clk_hw_omap_ops *hw_ops)
 {
 	struct clk *clk;
 	struct clk_init_data init = { NULL };
@@ -303,7 +399,7 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	if (dpll_mode)
 		dd->modes = dpll_mode;
 
-	ti_clk_register_dpll(&clk_hw->hw, node);
+	_register_dpll(&clk_hw->hw, node);
 	return;
 
 cleanup:
@@ -317,7 +413,7 @@ cleanup:
 	defined(CONFIG_SOC_DRA7XX)
 static void __init of_ti_omap4_dpll_x2_setup(struct device_node *node)
 {
-	ti_clk_register_dpll_x2(node, &dpll_x2_ck_ops, &clkhwops_omap4_dpllmx);
+	_register_dpll_x2(node, &dpll_x2_ck_ops, &clkhwops_omap4_dpllmx);
 }
 CLK_OF_DECLARE(ti_omap4_dpll_x2_clock, "ti,omap4-dpll-x2-clock",
 	       of_ti_omap4_dpll_x2_setup);
@@ -326,7 +422,7 @@ CLK_OF_DECLARE(ti_omap4_dpll_x2_clock, "ti,omap4-dpll-x2-clock",
 #if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
 static void __init of_ti_am3_dpll_x2_setup(struct device_node *node)
 {
-	ti_clk_register_dpll_x2(node, &dpll_x2_ck_ops, NULL);
+	_register_dpll_x2(node, &dpll_x2_ck_ops, NULL);
 }
 CLK_OF_DECLARE(ti_am3_dpll_x2_clock, "ti,am3-dpll-x2-clock",
 	       of_ti_am3_dpll_x2_setup);
-- 
1.7.9.5

