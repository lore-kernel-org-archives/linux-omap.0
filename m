From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 05/11] CLK: OMAP4: Add DPLL clock support
Date: Wed, 19 Jun 2013 16:18:56 +0300
Message-ID: <1371647942-4811-6-git-send-email-t-kristo@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56641 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933873Ab3FSNTy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 09:19:54 -0400
In-Reply-To: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

The OMAP clock driver now supports DPLL clock type. This patch also
adds support for DT DPLL nodes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/omap/Makefile |    2 +-
 drivers/clk/omap/clk.c    |    1 +
 drivers/clk/omap/dpll.c   |  307 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 309 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/omap/dpll.c

diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
index 8195931..4cad480 100644
--- a/drivers/clk/omap/Makefile
+++ b/drivers/clk/omap/Makefile
@@ -1 +1 @@
-obj-y					+= clk.o
+obj-y					+= clk.o dpll.o
diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
index b4533ed..c2a3f8f 100644
--- a/drivers/clk/omap/clk.c
+++ b/drivers/clk/omap/clk.c
@@ -29,6 +29,7 @@ static const struct of_device_id clk_match[] = {
 		.data = of_fixed_factor_clk_setup, },
 	{.compatible = "divider-clock", .data = of_divider_clk_setup, },
 	{.compatible = "gate-clock", .data = of_gate_clk_setup, },
+	{.compatible = "ti,omap4-dpll-clock", .data = of_omap4_dpll_setup, },
 	{},
 };
 
diff --git a/drivers/clk/omap/dpll.c b/drivers/clk/omap/dpll.c
new file mode 100644
index 0000000..183ec60
--- /dev/null
+++ b/drivers/clk/omap/dpll.c
@@ -0,0 +1,307 @@
+/*
+ * OMAP DPLL clock support
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * Tero Kristo <t-kristo@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/log2.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk/omap.h>
+
+/*
+ * DOC: basic adjustable divider clock that cannot gate
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable only ensures that parents are enabled
+ * rate - rate is adjustable.  clk->rate = parent->rate / divisor
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
+
+#define div_mask(d)	((1 << ((d)->width)) - 1)
+
+static const struct clk_ops dpll_m4xen_ck_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+	.recalc_rate	= &omap4_dpll_regm4xen_recalc,
+	.round_rate	= &omap4_dpll_regm4xen_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.get_parent	= &omap2_init_dpll_parent,
+};
+
+static const struct clk_ops dpll_core_ck_ops = {
+	.recalc_rate	= &omap3_dpll_recalc,
+	.get_parent	= &omap2_init_dpll_parent,
+};
+
+static const struct clk_ops dpll_ck_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+	.recalc_rate	= &omap3_dpll_recalc,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.get_parent	= &omap2_init_dpll_parent,
+	.init		= &omap2_init_clk_clkdm,
+};
+
+static const struct clk_ops dpll_x2_ck_ops = {
+	.recalc_rate	= &omap3_clkoutx2_recalc,
+};
+
+struct clk *omap_clk_register_dpll(struct device *dev, const char *name,
+		const char **parent_names, int num_parents, unsigned long flags,
+		struct dpll_data *dpll_data, const char *clkdm_name,
+		const struct clk_ops *ops)
+{
+	struct clk *clk;
+	struct clk_init_data init;
+	struct clk_hw_omap *clk_hw;
+
+	/* allocate the divider */
+	clk_hw = kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
+	if (!clk_hw) {
+		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	clk_hw->dpll_data = dpll_data;
+	clk_hw->ops = &clkhwops_omap3_dpll;
+	clk_hw->clkdm_name = clkdm_name;
+	clk_hw->hw.init = &init;
+
+	init.name = name;
+	init.ops = ops;
+	init.flags = flags;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	/* register the clock */
+	clk = clk_register(dev, &clk_hw->hw);
+
+	if (IS_ERR(clk))
+		kfree(clk_hw);
+	else
+		omap2_init_clk_hw_omap_clocks(clk);
+
+	return clk;
+}
+
+struct clk *omap_clk_register_dpll_x2(struct device *dev, const char *name,
+		const char *parent_name, void __iomem *reg,
+		const struct clk_ops *ops)
+{
+	struct clk *clk;
+	struct clk_init_data init;
+	struct clk_hw_omap *clk_hw;
+
+	if (!parent_name) {
+		pr_err("%s: dpll_x2 must have parent\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	clk_hw = kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
+	if (!clk_hw) {
+		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	clk_hw->ops = &clkhwops_omap4_dpllmx;
+	clk_hw->clksel_reg = reg;
+	clk_hw->hw.init = &init;
+
+	init.name = name;
+	init.ops = ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	/* register the clock */
+	clk = clk_register(dev, &clk_hw->hw);
+
+	if (IS_ERR(clk))
+		kfree(clk_hw);
+	else
+		omap2_init_clk_hw_omap_clocks(clk);
+
+	return clk;
+}
+
+#ifdef CONFIG_OF
+
+/**
+ * of_omap_dpll_setup() - Setup function for OMAP DPLL clocks
+ */
+static void __init of_omap_dpll_setup(struct device_node *node,
+					const struct clk_ops *ops)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	int num_parents;
+	const char **parent_names;
+	const char *clkdm_name = NULL;
+	struct of_phandle_args clkspec;
+	u8 dpll_flags = 0;
+	struct dpll_data *dd;
+	u32 idlest_mask = 0x1;
+	u32 enable_mask = 0x7;
+	u32 autoidle_mask = 0x7;
+	u32 mult_mask = 0x7ff << 8;
+	u32 div1_mask = 0x7f;
+	u32 max_multiplier = 2047;
+	u32 max_divider = 128;
+	u32 min_divider = 1;
+	int i;
+
+	dd = kzalloc(sizeof(struct dpll_data), GFP_KERNEL);
+	if (!dd) {
+		pr_err("%s: could not allocate dpll_data\n", __func__);
+		return;
+	}
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: omap dpll %s must have parent(s)\n",
+			__func__, node->name);
+		goto cleanup;
+	}
+
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	of_property_read_u32(node, "ti,idlest-mask", &idlest_mask);
+
+	of_property_read_u32(node, "ti,enable-mask", &enable_mask);
+
+	of_property_read_u32(node, "ti,autoidle-mask", &autoidle_mask);
+
+	clkspec.np = of_parse_phandle(node, "ti,clk-ref", 0);
+	dd->clk_ref = of_clk_get_from_provider(&clkspec);
+	if (!dd->clk_ref) {
+		pr_err("%s: ti,clk-ref for %s not found\n", __func__,
+			clk_name);
+		goto cleanup;
+	}
+
+	clkspec.np = of_parse_phandle(node, "ti,clk-bypass", 0);
+	dd->clk_bypass = of_clk_get_from_provider(&clkspec);
+	if (!dd->clk_bypass) {
+		pr_err("%s: ti,clk-bypass for %s not found\n", __func__,
+			clk_name);
+		goto cleanup;
+	}
+
+	of_property_read_string(node, "ti,clkdm-name", &clkdm_name);
+
+	dd->control_reg = of_iomap(node, 0);
+	dd->idlest_reg = of_iomap(node, 1);
+	dd->autoidle_reg = of_iomap(node, 2);
+	dd->mult_div1_reg = of_iomap(node, 3);
+
+	dd->idlest_mask = idlest_mask;
+	dd->enable_mask = enable_mask;
+	dd->autoidle_mask = autoidle_mask;
+
+	if (of_property_read_bool(node, "ti,dpll-j-type")) {
+		dd->sddiv_mask = 0xff000000;
+		mult_mask = 0xfff << 8;
+		div1_mask = 0xff;
+		max_multiplier = 4095;
+		max_divider = 256;
+	}
+
+	if (of_property_read_bool(node, "ti,dpll-regm4xen")) {
+		dd->m4xen_mask = 0x800;
+		dd->lpmode_mask = 1 << 10;
+	}
+
+	dd->mult_mask = mult_mask;
+	dd->div1_mask = div1_mask;
+	dd->max_multiplier = max_multiplier;
+	dd->max_divider = max_divider;
+	dd->min_divider = min_divider;
+
+	clk = omap_clk_register_dpll(NULL, clk_name, parent_names,
+				num_parents, dpll_flags, dd,
+				clkdm_name, ops);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return;
+
+cleanup:
+	kfree(dd);
+	return;
+}
+
+static void __init of_omap_dpll_x2_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	void __iomem *reg;
+	const char *parent_name;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	reg = of_iomap(node, 0);
+
+	clk = omap_clk_register_dpll_x2(NULL, clk_name, parent_name,
+				reg, &dpll_x2_ck_ops);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+
+__init void of_omap3_dpll_setup(struct device_node *node)
+{
+	/* XXX: to be done */
+}
+EXPORT_SYMBOL_GPL(of_omap3_dpll_setup);
+CLK_OF_DECLARE(omap3_dpll_clock, "ti,omap3-dpll-clock", of_omap3_dpll_setup);
+
+__init void of_omap4_dpll_setup(struct device_node *node)
+{
+	const struct clk_ops *ops;
+
+	ops = &dpll_ck_ops;
+
+	if (of_property_read_bool(node, "ti,dpll-regm4xen"))
+		ops = &dpll_m4xen_ck_ops;
+
+	if (of_property_read_bool(node, "ti,dpll-core"))
+		ops = &dpll_core_ck_ops;
+
+	if (of_property_read_bool(node, "ti,dpll-clk-x2")) {
+		of_omap_dpll_x2_setup(node);
+		return;
+	}
+
+	of_omap_dpll_setup(node, ops);
+}
+EXPORT_SYMBOL_GPL(of_omap4_dpll_setup);
+CLK_OF_DECLARE(omap4_dpll_clock, "ti,omap4-dpll-clock", of_omap4_dpll_setup);
+#endif
-- 
1.7.9.5

