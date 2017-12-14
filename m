From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2] clk: ti: Drop legacy clk-3xxx-legacy code
Date: Thu, 14 Dec 2017 07:27:53 -0800
Message-ID: <20171214152753.678-1-tony@atomide.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We have now had omap3 booting in device tree only mode for a while
and all this code is unused.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Looks like the patch was too big for the lists as it removes
drivers/clk/ti/clk-3xxx-legacy.c. Here's a resend with patch
edited to leave out changes to drivers/clk/ti/clk-3xxx-legacy.c
for mailing list review.

I'll send a pull request for this if it looks OK otherwise.

---
 drivers/clk/ti/Makefile          |    4 -
 drivers/clk/ti/clk-3xxx-legacy.c | 4656 --------------------------------------
 drivers/clk/ti/clk.c             |  135 --
 drivers/clk/ti/clock.h           |   68 -
 drivers/clk/ti/composite.c       |   45 -
 drivers/clk/ti/dpll.c            |   90 -
 drivers/clk/ti/gate.c            |   48 -
 drivers/clk/ti/interface.c       |   32 -
 8 files changed, 5078 deletions(-)
 delete mode 100644 drivers/clk/ti/clk-3xxx-legacy.c

diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -19,10 +19,6 @@ obj-$(CONFIG_SOC_DRA7XX)		+= $(clk-common) clk-7xx.o \
 					   clk-dra7-atl.o dpll3xxx.o dpll44xx.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(clk-common) dpll3xxx.o clk-43xx.o
 
-ifdef CONFIG_ATAGS
-obj-$(CONFIG_ARCH_OMAP3)                += clk-3xxx-legacy.o
-endif
-
 endif	# CONFIG_ARCH_OMAP2PLUS
 
 obj-$(CONFIG_COMMON_CLK_TI_ADPLL)	+= adpll.o
diff --git a/drivers/clk/ti/clk-3xxx-legacy.c b/drivers/clk/ti/clk-3xxx-legacy.c
deleted file mode 100644
--- a/drivers/clk/ti/clk-3xxx-legacy.c
+++ /dev/null
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -336,141 +336,6 @@ void ti_dt_clk_init_retry_clks(void)
 	}
 }
 
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
-void __init ti_clk_patch_legacy_clks(struct ti_clk **patch)
-{
-	while (*patch) {
-		memcpy((*patch)->patch, *patch, sizeof(**patch));
-		patch++;
-	}
-}
-
-struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
-{
-	struct clk *clk;
-	struct ti_clk_fixed *fixed;
-	struct ti_clk_fixed_factor *fixed_factor;
-	struct clk_hw *clk_hw;
-	int ret;
-
-	if (setup->clk)
-		return setup->clk;
-
-	switch (setup->type) {
-	case TI_CLK_FIXED:
-		fixed = setup->data;
-
-		clk = clk_register_fixed_rate(NULL, setup->name, NULL, 0,
-					      fixed->frequency);
-		if (!IS_ERR(clk)) {
-			ret = ti_clk_add_alias(NULL, clk, setup->name);
-			if (ret) {
-				clk_unregister(clk);
-				clk = ERR_PTR(ret);
-			}
-		}
-		break;
-	case TI_CLK_MUX:
-		clk = ti_clk_register_mux(setup);
-		break;
-	case TI_CLK_DIVIDER:
-		clk = ti_clk_register_divider(setup);
-		break;
-	case TI_CLK_COMPOSITE:
-		clk = ti_clk_register_composite(setup);
-		break;
-	case TI_CLK_FIXED_FACTOR:
-		fixed_factor = setup->data;
-
-		clk = clk_register_fixed_factor(NULL, setup->name,
-						fixed_factor->parent,
-						0, fixed_factor->mult,
-						fixed_factor->div);
-		if (!IS_ERR(clk)) {
-			ret = ti_clk_add_alias(NULL, clk, setup->name);
-			if (ret) {
-				clk_unregister(clk);
-				clk = ERR_PTR(ret);
-			}
-		}
-		break;
-	case TI_CLK_GATE:
-		clk = ti_clk_register_gate(setup);
-		break;
-	case TI_CLK_DPLL:
-		clk = ti_clk_register_dpll(setup);
-		break;
-	default:
-		pr_err("bad type for %s!\n", setup->name);
-		clk = ERR_PTR(-EINVAL);
-	}
-
-	if (!IS_ERR(clk)) {
-		setup->clk = clk;
-		if (setup->clkdm_name) {
-			clk_hw = __clk_get_hw(clk);
-			if (clk_hw_get_flags(clk_hw) & CLK_IS_BASIC) {
-				pr_warn("can't setup clkdm for basic clk %s\n",
-					setup->name);
-			} else {
-				to_clk_hw_omap(clk_hw)->clkdm_name =
-					setup->clkdm_name;
-				omap2_init_clk_clkdm(clk_hw);
-			}
-		}
-	}
-
-	return clk;
-}
-
-int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
-{
-	struct clk *clk;
-	bool retry;
-	struct ti_clk_alias *retry_clk;
-	struct ti_clk_alias *tmp;
-
-	while (clks->clk) {
-		clk = ti_clk_register_clk(clks->clk);
-		if (IS_ERR(clk)) {
-			if (PTR_ERR(clk) == -EAGAIN) {
-				list_add(&clks->link, &retry_list);
-			} else {
-				pr_err("register for %s failed: %ld\n",
-				       clks->clk->name, PTR_ERR(clk));
-				return PTR_ERR(clk);
-			}
-		}
-		clks++;
-	}
-
-	retry = true;
-
-	while (!list_empty(&retry_list) && retry) {
-		retry = false;
-		list_for_each_entry_safe(retry_clk, tmp, &retry_list, link) {
-			pr_debug("retry-init: %s\n", retry_clk->clk->name);
-			clk = ti_clk_register_clk(retry_clk->clk);
-			if (IS_ERR(clk)) {
-				if (PTR_ERR(clk) == -EAGAIN) {
-					continue;
-				} else {
-					pr_err("register for %s failed: %ld\n",
-					       retry_clk->clk->name,
-					       PTR_ERR(clk));
-					return PTR_ERR(clk);
-				}
-			} else {
-				retry = true;
-				list_del(&retry_clk->link);
-			}
-		}
-	}
-
-	return 0;
-}
-#endif
-
 static const struct of_device_id simple_clk_match_table[] __initconst = {
 	{ .compatible = "fixed-clock" },
 	{ .compatible = "fixed-factor-clock" },
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -92,17 +92,6 @@ struct ti_clk {
 	struct clk *clk;
 };
 
-struct ti_clk_alias {
-	struct ti_clk *clk;
-	struct clk_lookup lk;
-	struct list_head link;
-};
-
-struct ti_clk_fixed {
-	u32 frequency;
-	u16 flags;
-};
-
 struct ti_clk_mux {
 	u8 bit_shift;
 	int num_parents;
@@ -123,13 +112,6 @@ struct ti_clk_divider {
 	u16 flags;
 };
 
-struct ti_clk_fixed_factor {
-	const char *parent;
-	u16 div;
-	u16 mult;
-	u16 flags;
-};
-
 struct ti_clk_gate {
 	const char *parent;
 	u8 bit_shift;
@@ -138,44 +120,6 @@ struct ti_clk_gate {
 	u16 flags;
 };
 
-struct ti_clk_composite {
-	struct ti_clk_divider *divider;
-	struct ti_clk_mux *mux;
-	struct ti_clk_gate *gate;
-	u16 flags;
-};
-
-struct ti_clk_clkdm_gate {
-	const char *parent;
-	u16 flags;
-};
-
-struct ti_clk_dpll {
-	int num_parents;
-	u16 control_reg;
-	u16 idlest_reg;
-	u16 autoidle_reg;
-	u16 mult_div1_reg;
-	u8 module;
-	const char **parents;
-	u16 flags;
-	u8 modes;
-	u32 mult_mask;
-	u32 div1_mask;
-	u32 enable_mask;
-	u32 autoidle_mask;
-	u32 freqsel_mask;
-	u32 idlest_mask;
-	u32 dco_mask;
-	u32 sddiv_mask;
-	u16 max_multiplier;
-	u16 max_divider;
-	u8 min_divider;
-	u8 auto_recal_bit;
-	u8 recal_en_bit;
-	u8 recal_st_bit;
-};
-
 /* Composite clock component types */
 enum {
 	CLK_COMPONENT_TYPE_GATE = 0,
@@ -245,29 +189,17 @@ extern const struct omap_clkctrl_data dm816_clkctrl_data[];
 
 typedef void (*ti_of_clk_init_cb_t)(void *, struct device_node *);
 
-struct clk *ti_clk_register_gate(struct ti_clk *setup);
-struct clk *ti_clk_register_interface(struct ti_clk *setup);
-struct clk *ti_clk_register_mux(struct ti_clk *setup);
-struct clk *ti_clk_register_divider(struct ti_clk *setup);
-struct clk *ti_clk_register_composite(struct ti_clk *setup);
-struct clk *ti_clk_register_dpll(struct ti_clk *setup);
 struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 			    const char *con);
 int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con);
 void ti_clk_add_aliases(void);
 
-struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup);
-struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup);
 struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup);
 
 int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
 			      u8 flags, u8 *width,
 			      const struct clk_div_table **table);
 
-void ti_clk_patch_legacy_clks(struct ti_clk **patch);
-struct clk *ti_clk_register_clk(struct ti_clk *setup);
-int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
-
 int ti_clk_get_reg_addr(struct device_node *node, int index,
 			struct clk_omap_reg *reg);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -116,51 +116,6 @@ static inline struct clk_hw *_get_hw(struct clk_hw_omap_comp *clk, int idx)
 
 #define to_clk_hw_comp(_hw) container_of(_hw, struct clk_hw_omap_comp, hw)
 
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
-struct clk *ti_clk_register_composite(struct ti_clk *setup)
-{
-	struct ti_clk_composite *comp;
-	struct clk_hw *gate;
-	struct clk_hw *mux;
-	struct clk_hw *div;
-	int num_parents = 1;
-	const char * const *parent_names = NULL;
-	struct clk *clk;
-	int ret;
-
-	comp = setup->data;
-
-	div = ti_clk_build_component_div(comp->divider);
-	gate = ti_clk_build_component_gate(comp->gate);
-	mux = ti_clk_build_component_mux(comp->mux);
-
-	if (div)
-		parent_names = &comp->divider->parent;
-
-	if (gate)
-		parent_names = &comp->gate->parent;
-
-	if (mux) {
-		num_parents = comp->mux->num_parents;
-		parent_names = comp->mux->parents;
-	}
-
-	clk = clk_register_composite(NULL, setup->name,
-				     parent_names, num_parents, mux,
-				     &ti_clk_mux_ops, div,
-				     &ti_composite_divider_ops, gate,
-				     &ti_composite_gate_ops, 0);
-
-	ret = ti_clk_add_alias(NULL, clk, setup->name);
-	if (ret) {
-		clk_unregister(clk);
-		return ERR_PTR(ret);
-	}
-
-	return clk;
-}
-#endif
-
 static void __init _register_composite(void *user,
 				       struct device_node *node)
 {
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -203,96 +203,6 @@ static void __init _register_dpll(void *user,
 	kfree(clk_hw);
 }
 
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
-void _get_reg(u8 module, u16 offset, struct clk_omap_reg *reg)
-{
-	reg->index = module;
-	reg->offset = offset;
-}
-
-struct clk *ti_clk_register_dpll(struct ti_clk *setup)
-{
-	struct clk_hw_omap *clk_hw;
-	struct clk_init_data init = { NULL };
-	struct dpll_data *dd;
-	struct clk *clk;
-	struct ti_clk_dpll *dpll;
-	const struct clk_ops *ops = &omap3_dpll_ck_ops;
-	struct clk *clk_ref;
-	struct clk *clk_bypass;
-
-	dpll = setup->data;
-
-	if (dpll->num_parents < 2)
-		return ERR_PTR(-EINVAL);
-
-	clk_ref = clk_get_sys(NULL, dpll->parents[0]);
-	clk_bypass = clk_get_sys(NULL, dpll->parents[1]);
-
-	if (IS_ERR_OR_NULL(clk_ref) || IS_ERR_OR_NULL(clk_bypass))
-		return ERR_PTR(-EAGAIN);
-
-	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
-	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
-	if (!dd || !clk_hw) {
-		clk = ERR_PTR(-ENOMEM);
-		goto cleanup;
-	}
-
-	clk_hw->dpll_data = dd;
-	clk_hw->ops = &clkhwops_omap3_dpll;
-	clk_hw->hw.init = &init;
-
-	init.name = setup->name;
-	init.ops = ops;
-
-	init.num_parents = dpll->num_parents;
-	init.parent_names = dpll->parents;
-
-	_get_reg(dpll->module, dpll->control_reg, &dd->control_reg);
-	_get_reg(dpll->module, dpll->idlest_reg, &dd->idlest_reg);
-	_get_reg(dpll->module, dpll->mult_div1_reg, &dd->mult_div1_reg);
-	_get_reg(dpll->module, dpll->autoidle_reg, &dd->autoidle_reg);
-
-	dd->modes = dpll->modes;
-	dd->div1_mask = dpll->div1_mask;
-	dd->idlest_mask = dpll->idlest_mask;
-	dd->mult_mask = dpll->mult_mask;
-	dd->autoidle_mask = dpll->autoidle_mask;
-	dd->enable_mask = dpll->enable_mask;
-	dd->sddiv_mask = dpll->sddiv_mask;
-	dd->dco_mask = dpll->dco_mask;
-	dd->max_divider = dpll->max_divider;
-	dd->min_divider = dpll->min_divider;
-	dd->max_multiplier = dpll->max_multiplier;
-	dd->auto_recal_bit = dpll->auto_recal_bit;
-	dd->recal_en_bit = dpll->recal_en_bit;
-	dd->recal_st_bit = dpll->recal_st_bit;
-
-	dd->clk_ref = __clk_get_hw(clk_ref);
-	dd->clk_bypass = __clk_get_hw(clk_bypass);
-
-	if (dpll->flags & CLKF_CORE)
-		ops = &omap3_dpll_core_ck_ops;
-
-	if (dpll->flags & CLKF_PER)
-		ops = &omap3_dpll_per_ck_ops;
-
-	if (dpll->flags & CLKF_J_TYPE)
-		dd->flags |= DPLL_J_TYPE;
-
-	clk = ti_clk_register(NULL, &clk_hw->hw, setup->name);
-
-	if (!IS_ERR(clk))
-		return clk;
-
-cleanup:
-	kfree(dd);
-	kfree(clk_hw);
-	return clk;
-}
-#endif
-
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
 	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM33XX) || \
 	defined(CONFIG_SOC_AM43XX)
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -128,53 +128,6 @@ static struct clk *_register_gate(struct device *dev, const char *name,
 	return clk;
 }
 
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
-struct clk *ti_clk_register_gate(struct ti_clk *setup)
-{
-	const struct clk_ops *ops = &omap_gate_clk_ops;
-	const struct clk_hw_omap_ops *hw_ops = NULL;
-	struct clk_omap_reg reg;
-	u32 flags = 0;
-	u8 clk_gate_flags = 0;
-	struct ti_clk_gate *gate;
-
-	gate = setup->data;
-
-	if (gate->flags & CLKF_INTERFACE)
-		return ti_clk_register_interface(setup);
-
-	if (gate->flags & CLKF_SET_RATE_PARENT)
-		flags |= CLK_SET_RATE_PARENT;
-
-	if (gate->flags & CLKF_SET_BIT_TO_DISABLE)
-		clk_gate_flags |= INVERT_ENABLE;
-
-	if (gate->flags & CLKF_HSDIV) {
-		ops = &omap_gate_clk_hsdiv_restore_ops;
-		hw_ops = &clkhwops_wait;
-	}
-
-	if (gate->flags & CLKF_DSS)
-		hw_ops = &clkhwops_omap3430es2_dss_usbhost_wait;
-
-	if (gate->flags & CLKF_WAIT)
-		hw_ops = &clkhwops_wait;
-
-	if (gate->flags & CLKF_CLKDM)
-		ops = &omap_gate_clkdm_clk_ops;
-
-	if (gate->flags & CLKF_AM35XX)
-		hw_ops = &clkhwops_am35xx_ipss_module_wait;
-
-	reg.index = gate->module;
-	reg.offset = gate->reg;
-	reg.ptr = NULL;
-
-	return _register_gate(NULL, setup->name, gate->parent, flags,
-			      &reg, gate->bit_shift,
-			      clk_gate_flags, ops, hw_ops);
-}
-
 struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup)
 {
 	struct clk_hw_omap *gate;
@@ -204,7 +157,6 @@ struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup)
 
 	return &gate->hw;
 }
-#endif
 
 static void __init _of_ti_gate_clk_setup(struct device_node *node,
 					 const struct clk_ops *ops,
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -67,38 +67,6 @@ static struct clk *_register_interface(struct device *dev, const char *name,
 	return clk;
 }
 
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
-struct clk *ti_clk_register_interface(struct ti_clk *setup)
-{
-	const struct clk_hw_omap_ops *ops = &clkhwops_iclk_wait;
-	struct clk_omap_reg reg;
-	struct ti_clk_gate *gate;
-
-	gate = setup->data;
-	reg.index = gate->module;
-	reg.offset = gate->reg;
-	reg.ptr = NULL;
-
-	if (gate->flags & CLKF_NO_WAIT)
-		ops = &clkhwops_iclk;
-
-	if (gate->flags & CLKF_HSOTGUSB)
-		ops = &clkhwops_omap3430es2_iclk_hsotgusb_wait;
-
-	if (gate->flags & CLKF_DSS)
-		ops = &clkhwops_omap3430es2_iclk_dss_usbhost_wait;
-
-	if (gate->flags & CLKF_SSI)
-		ops = &clkhwops_omap3430es2_iclk_ssi_wait;
-
-	if (gate->flags & CLKF_AM35XX)
-		ops = &clkhwops_am35xx_ipss_wait;
-
-	return _register_interface(NULL, setup->name, gate->parent,
-				   &reg, gate->bit_shift, ops);
-}
-#endif
-
 static void __init _of_ti_interface_clk_setup(struct device_node *node,
 					      const struct clk_hw_omap_ops *ops)
 {
-- 
2.15.0
