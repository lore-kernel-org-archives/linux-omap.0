From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv13 10/40] clk: ti: add support for basic mux clock
Date: Thu, 9 Jan 2014 16:00:21 +0200
Message-ID: <1389276051-1326-11-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37689 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126AbaAIOC3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 09:02:29 -0500
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

ti,mux-clock provides now a binding for basic mux support. This is just
using the basic clock type.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 Documentation/devicetree/bindings/clock/ti/mux.txt |   76 ++++++
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/composite.c                         |    2 +-
 drivers/clk/ti/mux.c                               |  246 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    1 +
 5 files changed, 325 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/mux.txt
 create mode 100644 drivers/clk/ti/mux.c

diff --git a/Documentation/devicetree/bindings/clock/ti/mux.txt b/Documentation/devicetree/bindings/clock/ti/mux.txt
new file mode 100644
index 0000000..2d0d170
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/mux.txt
@@ -0,0 +1,76 @@
+Binding for TI mux clock.
+
+Binding status: Unstable - ABI compatibility may be broken in the future
+
+This binding uses the common clock binding[1].  It assumes a
+register-mapped multiplexer with multiple input clock signals or
+parents, one of which can be selected as output.  This clock does not
+gate or adjust the parent rate via a divider or multiplier.
+
+By default the "clocks" property lists the parents in the same order
+as they are programmed into the regster.  E.g:
+
+	clocks = <&foo_clock>, <&bar_clock>, <&baz_clock>;
+
+results in programming the register as follows:
+
+register value		selected parent clock
+0			foo_clock
+1			bar_clock
+2			baz_clock
+
+Some clock controller IPs do not allow a value of zero to be programmed
+into the register, instead indexing begins at 1.  The optional property
+"index-starts-at-one" modified the scheme as follows:
+
+register value		selected clock parent
+1			foo_clock
+2			bar_clock
+3			baz_clock
+
+The binding must provide the register to control the mux. Optionally
+the number of bits to shift the control field in the register can be
+supplied. If the shift value is missing it is the same as supplying
+a zero shift.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be "ti,mux-clock" or "ti,composite-mux-clock".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : link phandles of parent clocks
+- reg : register offset for register controlling adjustable mux
+
+Optional properties:
+- ti,bit-shift : number of bits to shift the bit-mask, defaults to
+  0 if not present
+- ti,index-starts-at-one : valid input select programming starts at 1, not
+  zero
+- ti,set-rate-parent : clk_set_rate is propagated to parent clock,
+  not supported by the composite-mux-clock subtype
+
+Examples:
+
+sys_clkin_ck: sys_clkin_ck@4a306110 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-clock";
+	clocks = <&virt_12000000_ck>, <&virt_13000000_ck>, <&virt_16800000_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_27000000_ck>, <&virt_38400000_ck>;
+	reg = <0x0110>;
+	ti,index-starts-at-one;
+};
+
+abe_dpll_bypass_clk_mux_ck: abe_dpll_bypass_clk_mux_ck@4a306108 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-clock";
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	ti,bit-shift = <24>;
+	reg = <0x0108>;
+};
+
+mcbsp5_mux_fck: mcbsp5_mux_fck {
+	#clock-cells = <0>;
+	compatible = "ti,composite-mux-clock";
+	clocks = <&core_96m_fck>, <&mcbsp_clks>;
+	ti,bit-shift = <4>;
+	reg = <0x02d8>;
+};
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 67056fb..ef61d39 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,5 +1,5 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o divider.o \
 					   fixed-factor.o gate.o clockdomain.o \
-					   composite.o
+					   composite.o mux.o
 endif
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index ffb8db4..19d8980 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -173,7 +173,7 @@ static void __init ti_clk_register_composite(struct clk_hw *hw,
 	clk = clk_register_composite(NULL, node->name,
 				     parent_names, num_parents,
 				     _get_hw(cclk, CLK_COMPONENT_TYPE_MUX),
-				     &clk_mux_ops,
+				     &ti_clk_mux_ops,
 				     _get_hw(cclk, CLK_COMPONENT_TYPE_DIVIDER),
 				     &ti_composite_divider_ops,
 				     _get_hw(cclk, CLK_COMPONENT_TYPE_GATE),
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
new file mode 100644
index 0000000..0197a47
--- /dev/null
+++ b/drivers/clk/ti/mux.c
@@ -0,0 +1,246 @@
+/*
+ * TI Multiplexer Clock
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
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk/ti.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#define to_clk_mux(_hw) container_of(_hw, struct clk_mux, hw)
+
+static u8 ti_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	int num_parents = __clk_get_num_parents(hw->clk);
+	u32 val;
+
+	/*
+	 * FIXME need a mux-specific flag to determine if val is bitwise or
+	 * numeric. e.g. sys_clkin_ck's clksel field is 3 bits wide, but ranges
+	 * from 0x1 to 0x7 (index starts at one)
+	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
+	 * val = 0x4 really means "bit 2, index starts at bit 0"
+	 */
+	val = ti_clk_ll_ops->clk_readl(mux->reg) >> mux->shift;
+	val &= mux->mask;
+
+	if (mux->table) {
+		int i;
+
+		for (i = 0; i < num_parents; i++)
+			if (mux->table[i] == val)
+				return i;
+		return -EINVAL;
+	}
+
+	if (val && (mux->flags & CLK_MUX_INDEX_BIT))
+		val = ffs(val) - 1;
+
+	if (val && (mux->flags & CLK_MUX_INDEX_ONE))
+		val--;
+
+	if (val >= num_parents)
+		return -EINVAL;
+
+	return val;
+}
+
+static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	u32 val;
+	unsigned long flags = 0;
+
+	if (mux->table) {
+		index = mux->table[index];
+	} else {
+		if (mux->flags & CLK_MUX_INDEX_BIT)
+			index = (1 << ffs(index));
+
+		if (mux->flags & CLK_MUX_INDEX_ONE)
+			index++;
+	}
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+
+	if (mux->flags & CLK_MUX_HIWORD_MASK) {
+		val = mux->mask << (mux->shift + 16);
+	} else {
+		val = ti_clk_ll_ops->clk_readl(mux->reg);
+		val &= ~(mux->mask << mux->shift);
+	}
+	val |= index << mux->shift;
+	ti_clk_ll_ops->clk_writel(val, mux->reg);
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+
+	return 0;
+}
+
+const struct clk_ops ti_clk_mux_ops = {
+	.get_parent = ti_clk_mux_get_parent,
+	.set_parent = ti_clk_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+
+static struct clk *_register_mux(struct device *dev, const char *name,
+				 const char **parent_names, u8 num_parents,
+				 unsigned long flags, void __iomem *reg,
+				 u8 shift, u32 mask, u8 clk_mux_flags,
+				 u32 *table, spinlock_t *lock)
+{
+	struct clk_mux *mux;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the mux */
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux) {
+		pr_err("%s: could not allocate mux clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &ti_clk_mux_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	/* struct clk_mux assignments */
+	mux->reg = reg;
+	mux->shift = shift;
+	mux->mask = mask;
+	mux->flags = clk_mux_flags;
+	mux->lock = lock;
+	mux->table = table;
+	mux->hw.init = &init;
+
+	clk = clk_register(dev, &mux->hw);
+
+	if (IS_ERR(clk))
+		kfree(mux);
+
+	return clk;
+}
+
+/**
+ * of_mux_clk_setup - Setup function for simple mux rate clock
+ * @node: DT node for the clock
+ *
+ * Sets up a basic clock multiplexer.
+ */
+static void of_mux_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	void __iomem *reg;
+	int num_parents;
+	const char **parent_names;
+	int i;
+	u8 clk_mux_flags = 0;
+	u32 mask = 0;
+	u32 shift = 0;
+	u32 flags = 0;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 2) {
+		pr_err("mux-clock %s must have parents\n", node->name);
+		return;
+	}
+	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
+	if (!parent_names)
+		goto cleanup;
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	reg = ti_clk_get_reg_addr(node, 0);
+
+	if (!reg)
+		goto cleanup;
+
+	of_property_read_u32(node, "ti,bit-shift", &shift);
+
+	if (of_property_read_bool(node, "ti,index-starts-at-one"))
+		clk_mux_flags |= CLK_MUX_INDEX_ONE;
+
+	if (of_property_read_bool(node, "ti,set-rate-parent"))
+		flags |= CLK_SET_RATE_PARENT;
+
+	/* Generate bit-mask based on parent info */
+	mask = num_parents;
+	if (!(clk_mux_flags & CLK_MUX_INDEX_ONE))
+		mask--;
+
+	mask = (1 << fls(mask)) - 1;
+
+	clk = _register_mux(NULL, node->name, parent_names, num_parents, flags,
+			    reg, shift, mask, clk_mux_flags, NULL, NULL);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+cleanup:
+	kfree(parent_names);
+}
+CLK_OF_DECLARE(mux_clk, "ti,mux-clock", of_mux_clk_setup);
+
+static void __init of_ti_composite_mux_clk_setup(struct device_node *node)
+{
+	struct clk_mux *mux;
+	int num_parents;
+	u32 val;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return;
+
+	mux->reg = ti_clk_get_reg_addr(node, 0);
+
+	if (!mux->reg)
+		goto cleanup;
+
+	if (!of_property_read_u32(node, "ti,bit-shift", &val))
+		mux->shift = val;
+
+	if (of_property_read_bool(node, "ti,index-starts-at-one"))
+		mux->flags |= CLK_MUX_INDEX_ONE;
+
+	num_parents = of_clk_get_parent_count(node);
+
+	if (num_parents < 2) {
+		pr_err("%s must have parents\n", node->name);
+		goto cleanup;
+	}
+
+	mux->mask = num_parents - 1;
+	mux->mask = (1 << fls(mux->mask)) - 1;
+
+	if (!ti_clk_add_component(node, &mux->hw, CLK_COMPONENT_TYPE_MUX))
+		return;
+
+cleanup:
+	kfree(mux);
+}
+CLK_OF_DECLARE(ti_composite_mux_clk_setup, "ti,composite-mux-clock",
+	       of_ti_composite_mux_clk_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index a3f89a6..6e205b1 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -224,6 +224,7 @@ struct ti_clk_ll_ops {
 extern struct ti_clk_ll_ops *ti_clk_ll_ops;
 
 extern const struct clk_ops ti_clk_divider_ops;
+extern const struct clk_ops ti_clk_mux_ops;
 
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
-- 
1.7.9.5

