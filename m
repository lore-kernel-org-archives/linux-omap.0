From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv13 05/40] clk: ti: add composite clock support
Date: Thu, 9 Jan 2014 16:00:16 +0200
Message-ID: <1389276051-1326-6-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46847 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbaAIOBt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 09:01:49 -0500
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This is a multipurpose clock node, which contains support for multiple
sub-clocks. Uses basic composite clock type to implement the actual
functionality, and TI specific gate, mux and divider clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/composite.txt     |   54 ++++
 arch/arm/mach-omap2/clock.h                        |    3 -
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/composite.c                         |  269 ++++++++++++++++++++
 include/linux/clk/ti.h                             |   12 +
 5 files changed, 336 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/composite.txt
 create mode 100644 drivers/clk/ti/composite.c

diff --git a/Documentation/devicetree/bindings/clock/ti/composite.txt b/Documentation/devicetree/bindings/clock/ti/composite.txt
new file mode 100644
index 0000000..5f43c47
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/composite.txt
@@ -0,0 +1,54 @@
+Binding for TI composite clock.
+
+Binding status: Unstable - ABI compatibility may be broken in the future
+
+This binding uses the common clock binding[1]. It assumes a
+register-mapped composite clock with multiple different sub-types;
+
+a multiplexer clock with multiple input clock signals or parents, one
+of which can be selected as output, this behaves exactly as [2]
+
+an adjustable clock rate divider, this behaves exactly as [3]
+
+a gating function which can be used to enable and disable the output
+clock, this behaves exactly as [4]
+
+The binding must provide a list of the component clocks that shall be
+merged to this clock. The component clocks shall be of one of the
+"ti,*composite*-clock" types.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/clock/ti/mux.txt
+[3] Documentation/devicetree/bindings/clock/ti/divider.txt
+[4] Documentation/devicetree/bindings/clock/ti/gate.txt
+
+Required properties:
+- compatible : shall be: "ti,composite-clock"
+- clocks : link phandles of component clocks
+- #clock-cells : from common clock binding; shall be set to 0.
+
+Examples:
+
+usb_l4_gate_ick: usb_l4_gate_ick {
+	#clock-cells = <0>;
+	compatible = "ti,composite-interface-clock";
+	clocks = <&l4_ick>;
+	ti,bit-shift = <5>;
+	reg = <0x0a10>;
+};
+
+usb_l4_div_ick: usb_l4_div_ick {
+	#clock-cells = <0>;
+	compatible = "ti,composite-divider-clock";
+	clocks = <&l4_ick>;
+	ti,bit-shift = <4>;
+	ti,max-div = <1>;
+	reg = <0x0a40>;
+	ti,index-starts-at-one;
+};
+
+usb_l4_ick: usb_l4_ick {
+	#clock-cells = <0>;
+	compatible = "ti,composite-clock";
+	clocks = <&usb_l4_gate_ick>, <&usb_l4_div_ick>;
+};
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b345f3e..6bd72b5 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -240,9 +240,6 @@ extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
 
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
 
-int omap2_dflt_clk_enable(struct clk_hw *hw);
-void omap2_dflt_clk_disable(struct clk_hw *hw);
-int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
 void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
 				   void __iomem **other_reg,
 				   u8 *other_bit);
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 533efb4..a4a7595 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y					+= clk.o dpll.o autoidle.o
+obj-y					+= clk.o dpll.o autoidle.o composite.o
 endif
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
new file mode 100644
index 0000000..6539b65
--- /dev/null
+++ b/drivers/clk/ti/composite.c
@@ -0,0 +1,269 @@
+/*
+ * TI composite clock support
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
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk/ti.h>
+#include <linux/list.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
+
+static unsigned long ti_composite_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	return clk_divider_ops.recalc_rate(hw, parent_rate);
+}
+
+static long ti_composite_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *prate)
+{
+	return -EINVAL;
+}
+
+static int ti_composite_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	return -EINVAL;
+}
+
+static const struct clk_ops ti_composite_divider_ops = {
+	.recalc_rate	= &ti_composite_recalc_rate,
+	.round_rate	= &ti_composite_round_rate,
+	.set_rate	= &ti_composite_set_rate,
+};
+
+static const struct clk_ops ti_composite_gate_ops = {
+	.enable		= &omap2_dflt_clk_enable,
+	.disable	= &omap2_dflt_clk_disable,
+	.is_enabled	= &omap2_dflt_clk_is_enabled,
+};
+
+struct component_clk {
+	int num_parents;
+	const char **parent_names;
+	struct device_node *node;
+	int type;
+	struct clk_hw *hw;
+	struct list_head link;
+};
+
+static const char * __initconst component_clk_types[] = {
+	"gate", "divider", "mux"
+};
+
+static LIST_HEAD(component_clks);
+
+static struct device_node *_get_component_node(struct device_node *node, int i)
+{
+	int rc;
+	struct of_phandle_args clkspec;
+
+	rc = of_parse_phandle_with_args(node, "clocks", "#clock-cells", i,
+					&clkspec);
+	if (rc)
+		return NULL;
+
+	return clkspec.np;
+}
+
+static struct component_clk *_lookup_component(struct device_node *node)
+{
+	struct component_clk *comp;
+
+	list_for_each_entry(comp, &component_clks, link) {
+		if (comp->node == node)
+			return comp;
+	}
+	return NULL;
+}
+
+struct clk_hw_omap_comp {
+	struct clk_hw hw;
+	struct device_node *comp_nodes[CLK_COMPONENT_TYPE_MAX];
+	struct component_clk *comp_clks[CLK_COMPONENT_TYPE_MAX];
+};
+
+static inline struct clk_hw *_get_hw(struct clk_hw_omap_comp *clk, int idx)
+{
+	if (!clk)
+		return NULL;
+
+	if (!clk->comp_clks[idx])
+		return NULL;
+
+	return clk->comp_clks[idx]->hw;
+}
+
+#define to_clk_hw_comp(_hw) container_of(_hw, struct clk_hw_omap_comp, hw)
+
+static void __init ti_clk_register_composite(struct clk_hw *hw,
+					     struct device_node *node)
+{
+	struct clk *clk;
+	struct clk_hw_omap_comp *cclk = to_clk_hw_comp(hw);
+	struct component_clk *comp;
+	int num_parents = 0;
+	const char **parent_names = NULL;
+	int i;
+
+	/* Check for presence of each component clock */
+	for (i = 0; i < CLK_COMPONENT_TYPE_MAX; i++) {
+		if (!cclk->comp_nodes[i])
+			continue;
+
+		comp = _lookup_component(cclk->comp_nodes[i]);
+		if (!comp) {
+			pr_debug("component %s not ready for %s, retry\n",
+				 cclk->comp_nodes[i]->name, node->name);
+			if (!ti_clk_retry_init(node, hw,
+					       ti_clk_register_composite))
+				return;
+
+			goto cleanup;
+		}
+		if (cclk->comp_clks[comp->type] != NULL) {
+			pr_err("duplicate component types for %s (%s)!\n",
+			       node->name, component_clk_types[comp->type]);
+			goto cleanup;
+		}
+
+		cclk->comp_clks[comp->type] = comp;
+
+		/* Mark this node as found */
+		cclk->comp_nodes[i] = NULL;
+	}
+
+	/* All components exists, proceed with registration */
+	for (i = CLK_COMPONENT_TYPE_MAX - 1; i >= 0; i--) {
+		comp = cclk->comp_clks[i];
+		if (!comp)
+			continue;
+		if (comp->num_parents) {
+			num_parents = comp->num_parents;
+			parent_names = comp->parent_names;
+			break;
+		}
+	}
+
+	if (!num_parents) {
+		pr_err("%s: no parents found for %s!\n", __func__, node->name);
+		goto cleanup;
+	}
+
+	clk = clk_register_composite(NULL, node->name,
+				     parent_names, num_parents,
+				     _get_hw(cclk, CLK_COMPONENT_TYPE_MUX),
+				     &clk_mux_ops,
+				     _get_hw(cclk, CLK_COMPONENT_TYPE_DIVIDER),
+				     &ti_composite_divider_ops,
+				     _get_hw(cclk, CLK_COMPONENT_TYPE_GATE),
+				     &ti_composite_gate_ops, 0);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+cleanup:
+	/* Free component clock list entries */
+	for (i = 0; i < CLK_COMPONENT_TYPE_MAX; i++) {
+		if (!cclk->comp_clks[i])
+			continue;
+		list_del(&cclk->comp_clks[i]->link);
+		kfree(cclk->comp_clks[i]);
+	}
+
+	kfree(cclk);
+}
+
+static void __init of_ti_composite_clk_setup(struct device_node *node)
+{
+	int num_clks;
+	int i;
+	struct clk_hw_omap_comp *cclk;
+
+	/* Number of component clocks to be put inside this clock */
+	num_clks = of_clk_get_parent_count(node);
+
+	if (num_clks < 1) {
+		pr_err("composite clk %s must have component(s)\n", node->name);
+		return;
+	}
+
+	cclk = kzalloc(sizeof(*cclk), GFP_KERNEL);
+	if (!cclk)
+		return;
+
+	/* Get device node pointers for each component clock */
+	for (i = 0; i < num_clks; i++)
+		cclk->comp_nodes[i] = _get_component_node(node, i);
+
+	ti_clk_register_composite(&cclk->hw, node);
+}
+CLK_OF_DECLARE(ti_composite_clock, "ti,composite-clock",
+	       of_ti_composite_clk_setup);
+
+/**
+ * ti_clk_add_component - add a component clock to the pool
+ * @node: device node of the component clock
+ * @hw: hardware clock definition for the component clock
+ * @type: type of the component clock
+ *
+ * Adds a component clock to the list of available components, so that
+ * it can be registered by a composite clock.
+ */
+int __init ti_clk_add_component(struct device_node *node, struct clk_hw *hw,
+				int type)
+{
+	int num_parents;
+	const char **parent_names;
+	struct component_clk *clk;
+	int i;
+
+	num_parents = of_clk_get_parent_count(node);
+
+	if (num_parents < 1) {
+		pr_err("component-clock %s must have parent(s)\n", node->name);
+		return -EINVAL;
+	}
+
+	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
+	if (!parent_names)
+		return -ENOMEM;
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk) {
+		kfree(parent_names);
+		return -ENOMEM;
+	}
+
+	clk->num_parents = num_parents;
+	clk->parent_names = parent_names;
+	clk->hw = hw;
+	clk->node = node;
+	clk->type = type;
+	list_add(&clk->link, &component_clks);
+
+	return 0;
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index ca38ee3..c8c591d 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -164,6 +164,14 @@ struct clk_hw_omap {
 /* DPLL Type and DCO Selection Flags */
 #define DPLL_J_TYPE		0x1
 
+/* Composite clock component types */
+enum {
+	CLK_COMPONENT_TYPE_GATE = 0,
+	CLK_COMPONENT_TYPE_DIVIDER,
+	CLK_COMPONENT_TYPE_MUX,
+	CLK_COMPONENT_TYPE_MAX,
+};
+
 /**
  * struct ti_dt_clk - OMAP DT clock alias declarations
  * @lk: clock lookup definition
@@ -236,6 +244,9 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
+int omap2_dflt_clk_enable(struct clk_hw *hw);
+void omap2_dflt_clk_disable(struct clk_hw *hw);
+int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
 
 void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
@@ -243,6 +254,7 @@ void ti_dt_clk_init_provider(struct device_node *np, int index);
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 		      ti_of_clk_init_cb_t func);
 int of_ti_clk_autoidle_setup(struct device_node *node);
+int ti_clk_add_component(struct device_node *node, struct clk_hw *hw, int type);
 
 #ifdef CONFIG_OF
 void of_ti_clk_allow_autoidle_all(void);
-- 
1.7.9.5

