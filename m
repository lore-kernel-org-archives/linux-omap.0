From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 03/11] clk: ti: gate: add support for legacy gate init
Date: Tue, 16 Dec 2014 18:20:48 +0200
Message-ID: <1418746856-17173-4-git-send-email-t-kristo@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56069 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbaLPQUH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2014 11:20:07 -0500
In-Reply-To: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Legacy clock data is initialialized slightly differently compared to
DT clocks, thus add support for this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   |    3 +
 drivers/clk/ti/clock.h |    2 +
 drivers/clk/ti/gate.c  |  158 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 133 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 215f681..676dbf1 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -222,6 +222,9 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 						0, fixed_factor->mult,
 						fixed_factor->div);
 		break;
+	case TI_CLK_GATE:
+		clk = ti_clk_register_gate(setup);
+		break;
 	default:
 		pr_err("bad type for %s!\n", setup->name);
 		clk = ERR_PTR(-EINVAL);
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index c06bbf4..d0715bc 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -153,8 +153,10 @@ struct ti_clk_dpll {
 	u8 recal_st_bit;
 };
 
+struct clk *ti_clk_register_gate(struct ti_clk *setup);
 struct clk *ti_clk_register_mux(struct ti_clk *setup);
 
+struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup);
 struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup);
 
 void ti_clk_patch_legacy_clks(struct ti_clk **patch);
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index b326d27..ff3380e 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -22,6 +22,8 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 #define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
 
 #undef pr_fmt
@@ -90,63 +92,159 @@ static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
 	return ret;
 }
 
-static void __init _of_ti_gate_clk_setup(struct device_node *node,
-					 const struct clk_ops *ops,
-					 const struct clk_hw_omap_ops *hw_ops)
+static struct clk *_register_gate(struct device *dev, const char *name,
+				  const char *parent_name, unsigned long flags,
+				  void __iomem *reg, u8 bit_idx,
+				  u8 clk_gate_flags, const struct clk_ops *ops,
+				  const struct clk_hw_omap_ops *hw_ops)
 {
-	struct clk *clk;
 	struct clk_init_data init = { NULL };
 	struct clk_hw_omap *clk_hw;
-	const char *clk_name = node->name;
-	const char *parent_name;
-	u32 val;
+	struct clk *clk;
 
 	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
 	if (!clk_hw)
-		return;
+		return ERR_PTR(-ENOMEM);
 
 	clk_hw->hw.init = &init;
 
-	init.name = clk_name;
+	init.name = name;
 	init.ops = ops;
 
-	if (ops != &omap_gate_clkdm_clk_ops) {
-		clk_hw->enable_reg = ti_clk_get_reg_addr(node, 0);
-		if (!clk_hw->enable_reg)
-			goto cleanup;
+	clk_hw->enable_reg = reg;
+	clk_hw->enable_bit = bit_idx;
+	clk_hw->ops = hw_ops;
 
-		if (!of_property_read_u32(node, "ti,bit-shift", &val))
-			clk_hw->enable_bit = val;
+	clk_hw->flags = MEMMAP_ADDRESSING | clk_gate_flags;
+
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	init.flags = flags;
+
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (IS_ERR(clk))
+		kfree(clk_hw);
+
+	return clk;
+}
+
+struct clk *ti_clk_register_gate(struct ti_clk *setup)
+{
+	const struct clk_ops *ops = &omap_gate_clk_ops;
+	const struct clk_hw_omap_ops *hw_ops = NULL;
+	u32 reg;
+	struct clk_omap_reg *reg_setup;
+	u32 flags = 0;
+	u8 clk_gate_flags = 0;
+	struct ti_clk_gate *gate;
+
+	gate = setup->data;
+
+	reg_setup = (struct clk_omap_reg *)&reg;
+
+	if (gate->flags & CLKF_SET_RATE_PARENT)
+		flags |= CLK_SET_RATE_PARENT;
+
+	if (gate->flags & CLKF_SET_BIT_TO_DISABLE)
+		clk_gate_flags |= INVERT_ENABLE;
+
+	if (gate->flags & CLKF_HSDIV) {
+		ops = &omap_gate_clk_hsdiv_restore_ops;
+		hw_ops = &clkhwops_wait;
 	}
 
-	clk_hw->ops = hw_ops;
+	if (gate->flags & CLKF_DSS)
+		hw_ops = &clkhwops_omap3430es2_dss_usbhost_wait;
+
+	if (gate->flags & CLKF_WAIT)
+		hw_ops = &clkhwops_wait;
+
+	if (gate->flags & CLKF_CLKDM)
+		ops = &omap_gate_clkdm_clk_ops;
+
+	if (gate->flags & CLKF_AM35XX)
+		hw_ops = &clkhwops_am35xx_ipss_module_wait;
 
-	clk_hw->flags = MEMMAP_ADDRESSING;
+	reg_setup->index = gate->module;
+	reg_setup->offset = gate->reg;
+
+	return _register_gate(NULL, setup->name, gate->parent, flags,
+			      (void __iomem *)reg, gate->bit_shift,
+			      clk_gate_flags, ops, hw_ops);
+}
+
+struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup)
+{
+	struct clk_hw_omap *gate;
+	struct clk_omap_reg *reg;
+	const struct clk_hw_omap_ops *ops = &clkhwops_wait;
+
+	if (!setup)
+		return NULL;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	reg = (struct clk_omap_reg *)&gate->enable_reg;
+	reg->index = setup->module;
+	reg->offset = setup->reg;
+
+	gate->enable_bit = setup->bit_shift;
+
+	if (setup->flags & CLKF_NO_WAIT)
+		ops = NULL;
+
+	if (setup->flags & CLKF_INTERFACE)
+		ops = &clkhwops_iclk_wait;
+
+	gate->ops = ops;
+	gate->flags = MEMMAP_ADDRESSING;
+
+	return &gate->hw;
+}
+
+static void __init _of_ti_gate_clk_setup(struct device_node *node,
+					 const struct clk_ops *ops,
+					 const struct clk_hw_omap_ops *hw_ops)
+{
+	struct clk *clk;
+	const char *parent_name;
+	void __iomem *reg = NULL;
+	u8 enable_bit = 0;
+	u32 val;
+	u32 flags = 0;
+	u8 clk_gate_flags = 0;
+
+	if (ops != &omap_gate_clkdm_clk_ops) {
+		reg = ti_clk_get_reg_addr(node, 0);
+		if (!reg)
+			return;
+
+		if (!of_property_read_u32(node, "ti,bit-shift", &val))
+			enable_bit = val;
+	}
 
 	if (of_clk_get_parent_count(node) != 1) {
-		pr_err("%s must have 1 parent\n", clk_name);
-		goto cleanup;
+		pr_err("%s must have 1 parent\n", node->name);
+		return;
 	}
 
 	parent_name = of_clk_get_parent_name(node, 0);
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
 
 	if (of_property_read_bool(node, "ti,set-rate-parent"))
-		init.flags |= CLK_SET_RATE_PARENT;
+		flags |= CLK_SET_RATE_PARENT;
 
 	if (of_property_read_bool(node, "ti,set-bit-to-disable"))
-		clk_hw->flags |= INVERT_ENABLE;
+		clk_gate_flags |= INVERT_ENABLE;
 
-	clk = clk_register(NULL, &clk_hw->hw);
+	clk = _register_gate(NULL, node->name, parent_name, flags, reg,
+			     enable_bit, clk_gate_flags, ops, hw_ops);
 
-	if (!IS_ERR(clk)) {
+	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		return;
-	}
-
-cleanup:
-	kfree(clk_hw);
 }
 
 static void __init
-- 
1.7.9.5

