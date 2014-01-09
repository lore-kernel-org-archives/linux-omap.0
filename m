From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv13 06/40] CLK: ti: add support for ti divider-clock
Date: Thu, 9 Jan 2014 16:00:17 +0200
Message-ID: <1389276051-1326-7-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38632 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351AbaAIOCQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 09:02:16 -0500
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds support for TI divider clock binding, which simply uses
the basic clock divider to provide the features needed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/divider.txt       |  114 +++++
 drivers/clk/ti/Makefile                            |    3 +-
 drivers/clk/ti/composite.c                         |    2 +-
 drivers/clk/ti/divider.c                           |  487 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    2 +
 5 files changed, 606 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/divider.txt
 create mode 100644 drivers/clk/ti/divider.c

diff --git a/Documentation/devicetree/bindings/clock/ti/divider.txt b/Documentation/devicetree/bindings/clock/ti/divider.txt
new file mode 100644
index 0000000..35a6f5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/divider.txt
@@ -0,0 +1,114 @@
+Binding for TI divider clock
+
+Binding status: Unstable - ABI compatibility may be broken in the future
+
+This binding uses the common clock binding[1].  It assumes a
+register-mapped adjustable clock rate divider that does not gate and has
+only one input clock or parent.  By default the value programmed into
+the register is one less than the actual divisor value.  E.g:
+
+register value		actual divisor value
+0			1
+1			2
+2			3
+
+This assumption may be modified by the following optional properties:
+
+ti,index-starts-at-one - valid divisor values start at 1, not the default
+of 0.  E.g:
+register value		actual divisor value
+1			1
+2			2
+3			3
+
+ti,index-power-of-two - valid divisor values are powers of two.  E.g:
+register value		actual divisor value
+0			1
+1			2
+2			4
+
+Additionally an array of valid dividers may be supplied like so:
+
+	ti,dividers = <4>, <8>, <0>, <16>;
+
+Which will map the resulting values to a divisor table by their index:
+register value		actual divisor value
+0			4
+1			8
+2			<invalid divisor, skipped>
+3			16
+
+Any zero value in this array means the corresponding bit-value is invalid
+and must not be used.
+
+The binding must also provide the register to control the divider and
+unless the divider array is provided, min and max dividers. Optionally
+the number of bits to shift that mask, if necessary. If the shift value
+is missing it is the same as supplying a zero shift.
+
+This binding can also optionally provide support to the hardware autoidle
+feature, see [2].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/clock/ti/autoidle.txt
+
+Required properties:
+- compatible : shall be "ti,divider-clock" or "ti,composite-divider-clock".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : link to phandle of parent clock
+- reg : offset for register controlling adjustable divider
+
+Optional properties:
+- clock-output-names : from common clock binding.
+- ti,dividers : array of integers defining divisors
+- ti,bit-shift : number of bits to shift the divider value, defaults to 0
+- ti,min-div : min divisor for dividing the input clock rate, only
+  needed if the first divisor is offset from the default value (1)
+- ti,max-div : max divisor for dividing the input clock rate, only needed
+  if ti,dividers is not defined.
+- ti,index-starts-at-one : valid divisor programming starts at 1, not zero,
+  only valid if ti,dividers is not defined.
+- ti,index-power-of-two : valid divisor programming must be a power of two,
+  only valid if ti,dividers is not defined.
+- ti,autoidle-shift : bit shift of the autoidle enable bit for the clock,
+  see [2]
+- ti,invert-autoidle-bit : autoidle is enabled by setting the bit to 0,
+  see [2]
+- ti,set-rate-parent : clk_set_rate is propagated to parent
+
+Examples:
+dpll_usb_m2_ck: dpll_usb_m2_ck@4a008190 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll_usb_ck>;
+	ti,max-div = <127>;
+	reg = <0x190>;
+	ti,index-starts-at-one;
+};
+
+aess_fclk: aess_fclk@4a004528 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&abe_clk>;
+	ti,bit-shift = <24>;
+	reg = <0x528>;
+	ti,max-div = <2>;
+};
+
+dpll_core_m3x2_div_ck: dpll_core_m3x2_div_ck {
+	#clock-cells = <0>;
+	compatible = "ti,composite-divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	ti,max-div = <31>;
+	reg = <0x0134>;
+	ti,index-starts-at-one;
+};
+
+ssi_ssr_div_fck_3430es2: ssi_ssr_div_fck_3430es2 {
+	#clock-cells = <0>;
+	compatible = "ti,composite-divider-clock";
+	clocks = <&corex2_fck>;
+	ti,bit-shift = <8>;
+	reg = <0x0a40>;
+	ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>;
+};
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index a4a7595..640ebf9 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,3 +1,4 @@
 ifneq ($(CONFIG_OF),)
-obj-y					+= clk.o dpll.o autoidle.o composite.o
+obj-y					+= clk.o dpll.o autoidle.o divider.o \
+					   composite.o
 endif
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 6539b65..ffb8db4 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -31,7 +31,7 @@
 static unsigned long ti_composite_recalc_rate(struct clk_hw *hw,
 					      unsigned long parent_rate)
 {
-	return clk_divider_ops.recalc_rate(hw, parent_rate);
+	return ti_clk_divider_ops.recalc_rate(hw, parent_rate);
 }
 
 static long ti_composite_round_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
new file mode 100644
index 0000000..a15e445
--- /dev/null
+++ b/drivers/clk/ti/divider.c
@@ -0,0 +1,487 @@
+/*
+ * TI Divider Clock
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
+#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
+
+#define div_mask(d)	((1 << ((d)->width)) - 1)
+
+static unsigned int _get_table_maxdiv(const struct clk_div_table *table)
+{
+	unsigned int maxdiv = 0;
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->div > maxdiv)
+			maxdiv = clkt->div;
+	return maxdiv;
+}
+
+static unsigned int _get_maxdiv(struct clk_divider *divider)
+{
+	if (divider->flags & CLK_DIVIDER_ONE_BASED)
+		return div_mask(divider);
+	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+		return 1 << div_mask(divider);
+	if (divider->table)
+		return _get_table_maxdiv(divider->table);
+	return div_mask(divider) + 1;
+}
+
+static unsigned int _get_table_div(const struct clk_div_table *table,
+				   unsigned int val)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->val == val)
+			return clkt->div;
+	return 0;
+}
+
+static unsigned int _get_div(struct clk_divider *divider, unsigned int val)
+{
+	if (divider->flags & CLK_DIVIDER_ONE_BASED)
+		return val;
+	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+		return 1 << val;
+	if (divider->table)
+		return _get_table_div(divider->table, val);
+	return val + 1;
+}
+
+static unsigned int _get_table_val(const struct clk_div_table *table,
+				   unsigned int div)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->div == div)
+			return clkt->val;
+	return 0;
+}
+
+static unsigned int _get_val(struct clk_divider *divider, u8 div)
+{
+	if (divider->flags & CLK_DIVIDER_ONE_BASED)
+		return div;
+	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+		return __ffs(div);
+	if (divider->table)
+		return  _get_table_val(divider->table, div);
+	return div - 1;
+}
+
+static unsigned long ti_clk_divider_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned int div, val;
+
+	val = ti_clk_ll_ops->clk_readl(divider->reg) >> divider->shift;
+	val &= div_mask(divider);
+
+	div = _get_div(divider, val);
+	if (!div) {
+		WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
+		     "%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
+		     __clk_get_name(hw->clk));
+		return parent_rate;
+	}
+
+	return parent_rate / div;
+}
+
+/*
+ * The reverse of DIV_ROUND_UP: The maximum number which
+ * divided by m is r
+ */
+#define MULT_ROUND_UP(r, m) ((r) * (m) + (m) - 1)
+
+static bool _is_valid_table_div(const struct clk_div_table *table,
+				unsigned int div)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->div == div)
+			return true;
+	return false;
+}
+
+static bool _is_valid_div(struct clk_divider *divider, unsigned int div)
+{
+	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+		return is_power_of_2(div);
+	if (divider->table)
+		return _is_valid_table_div(divider->table, div);
+	return true;
+}
+
+static int ti_clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *best_parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	int i, bestdiv = 0;
+	unsigned long parent_rate, best = 0, now, maxdiv;
+	unsigned long parent_rate_saved = *best_parent_rate;
+
+	if (!rate)
+		rate = 1;
+
+	maxdiv = _get_maxdiv(divider);
+
+	if (!(__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT)) {
+		parent_rate = *best_parent_rate;
+		bestdiv = DIV_ROUND_UP(parent_rate, rate);
+		bestdiv = bestdiv == 0 ? 1 : bestdiv;
+		bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
+		return bestdiv;
+	}
+
+	/*
+	 * The maximum divider we can use without overflowing
+	 * unsigned long in rate * i below
+	 */
+	maxdiv = min(ULONG_MAX / rate, maxdiv);
+
+	for (i = 1; i <= maxdiv; i++) {
+		if (!_is_valid_div(divider, i))
+			continue;
+		if (rate * i == parent_rate_saved) {
+			/*
+			 * It's the most ideal case if the requested rate can be
+			 * divided from parent clock without needing to change
+			 * parent rate, so return the divider immediately.
+			 */
+			*best_parent_rate = parent_rate_saved;
+			return i;
+		}
+		parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
+				MULT_ROUND_UP(rate, i));
+		now = parent_rate / i;
+		if (now <= rate && now > best) {
+			bestdiv = i;
+			best = now;
+			*best_parent_rate = parent_rate;
+		}
+	}
+
+	if (!bestdiv) {
+		bestdiv = _get_maxdiv(divider);
+		*best_parent_rate =
+			__clk_round_rate(__clk_get_parent(hw->clk), 1);
+	}
+
+	return bestdiv;
+}
+
+static long ti_clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *prate)
+{
+	int div;
+	div = ti_clk_divider_bestdiv(hw, rate, prate);
+
+	return *prate / div;
+}
+
+static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned int div, value;
+	unsigned long flags = 0;
+	u32 val;
+
+	div = parent_rate / rate;
+	value = _get_val(divider, div);
+
+	if (value > div_mask(divider))
+		value = div_mask(divider);
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+
+	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
+		val = div_mask(divider) << (divider->shift + 16);
+	} else {
+		val = ti_clk_ll_ops->clk_readl(divider->reg);
+		val &= ~(div_mask(divider) << divider->shift);
+	}
+	val |= value << divider->shift;
+	ti_clk_ll_ops->clk_writel(val, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+
+	return 0;
+}
+
+const struct clk_ops ti_clk_divider_ops = {
+	.recalc_rate = ti_clk_divider_recalc_rate,
+	.round_rate = ti_clk_divider_round_rate,
+	.set_rate = ti_clk_divider_set_rate,
+};
+
+static struct clk *_register_divider(struct device *dev, const char *name,
+				     const char *parent_name,
+				     unsigned long flags, void __iomem *reg,
+				     u8 shift, u8 width, u8 clk_divider_flags,
+				     const struct clk_div_table *table,
+				     spinlock_t *lock)
+{
+	struct clk_divider *div;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
+		if (width + shift > 16) {
+			pr_warn("divider value exceeds LOWORD field\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	/* allocate the divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div) {
+		pr_err("%s: could not allocate divider clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &ti_clk_divider_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* struct clk_divider assignments */
+	div->reg = reg;
+	div->shift = shift;
+	div->width = width;
+	div->flags = clk_divider_flags;
+	div->lock = lock;
+	div->hw.init = &init;
+	div->table = table;
+
+	/* register the clock */
+	clk = clk_register(dev, &div->hw);
+
+	if (IS_ERR(clk))
+		kfree(div);
+
+	return clk;
+}
+
+static struct clk_div_table
+__init *ti_clk_get_div_table(struct device_node *node)
+{
+	struct clk_div_table *table;
+	const __be32 *divspec;
+	u32 val;
+	u32 num_div;
+	u32 valid_div;
+	int i;
+
+	divspec = of_get_property(node, "ti,dividers", &num_div);
+
+	if (!divspec)
+		return NULL;
+
+	num_div /= 4;
+
+	valid_div = 0;
+
+	/* Determine required size for divider table */
+	for (i = 0; i < num_div; i++) {
+		of_property_read_u32_index(node, "ti,dividers", i, &val);
+		if (val)
+			valid_div++;
+	}
+
+	if (!valid_div) {
+		pr_err("no valid dividers for %s table\n", node->name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	table = kzalloc(sizeof(*table) * (valid_div + 1), GFP_KERNEL);
+
+	if (!table)
+		return ERR_PTR(-ENOMEM);
+
+	valid_div = 0;
+
+	for (i = 0; i < num_div; i++) {
+		of_property_read_u32_index(node, "ti,dividers", i, &val);
+		if (val) {
+			table[valid_div].div = val;
+			table[valid_div].val = i;
+			valid_div++;
+		}
+	}
+
+	return table;
+}
+
+static int _get_divider_width(struct device_node *node,
+			      const struct clk_div_table *table,
+			      u8 flags)
+{
+	u32 min_div;
+	u32 max_div;
+	u32 val = 0;
+	u32 div;
+
+	if (!table) {
+		/* Clk divider table not provided, determine min/max divs */
+		if (of_property_read_u32(node, "ti,min-div", &min_div))
+			min_div = 1;
+
+		if (of_property_read_u32(node, "ti,max-div", &max_div)) {
+			pr_err("no max-div for %s!\n", node->name);
+			return -EINVAL;
+		}
+
+		/* Determine bit width for the field */
+		if (flags & CLK_DIVIDER_ONE_BASED)
+			val = 1;
+
+		div = min_div;
+
+		while (div < max_div) {
+			if (flags & CLK_DIVIDER_POWER_OF_TWO)
+				div <<= 1;
+			else
+				div++;
+			val++;
+		}
+	} else {
+		div = 0;
+
+		while (table[div].div) {
+			val = table[div].val;
+			div++;
+		}
+	}
+
+	return fls(val);
+}
+
+static int __init ti_clk_divider_populate(struct device_node *node,
+	void __iomem **reg, const struct clk_div_table **table,
+	u32 *flags, u8 *div_flags, u8 *width, u8 *shift)
+{
+	u32 val;
+
+	*reg = ti_clk_get_reg_addr(node, 0);
+	if (!*reg)
+		return -EINVAL;
+
+	if (!of_property_read_u32(node, "ti,bit-shift", &val))
+		*shift = val;
+	else
+		*shift = 0;
+
+	*flags = 0;
+	*div_flags = 0;
+
+	if (of_property_read_bool(node, "ti,index-starts-at-one"))
+		*div_flags |= CLK_DIVIDER_ONE_BASED;
+
+	if (of_property_read_bool(node, "ti,index-power-of-two"))
+		*div_flags |= CLK_DIVIDER_POWER_OF_TWO;
+
+	if (of_property_read_bool(node, "ti,set-rate-parent"))
+		*flags |= CLK_SET_RATE_PARENT;
+
+	*table = ti_clk_get_div_table(node);
+
+	if (IS_ERR(*table))
+		return PTR_ERR(*table);
+
+	*width = _get_divider_width(node, *table, *div_flags);
+
+	return 0;
+}
+
+/**
+ * of_ti_divider_clk_setup - Setup function for simple div rate clock
+ * @node: device node for this clock
+ *
+ * Sets up a basic divider clock.
+ */
+static void __init of_ti_divider_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *parent_name;
+	void __iomem *reg;
+	u8 clk_divider_flags = 0;
+	u8 width = 0;
+	u8 shift = 0;
+	const struct clk_div_table *table = NULL;
+	u32 flags = 0;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	if (ti_clk_divider_populate(node, &reg, &table, &flags,
+				    &clk_divider_flags, &width, &shift))
+		goto cleanup;
+
+	clk = _register_divider(NULL, node->name, parent_name, flags, reg,
+				shift, width, clk_divider_flags, table, NULL);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		of_ti_clk_autoidle_setup(node);
+		return;
+	}
+
+cleanup:
+	kfree(table);
+}
+CLK_OF_DECLARE(divider_clk, "ti,divider-clock", of_ti_divider_clk_setup);
+
+static void __init of_ti_composite_divider_clk_setup(struct device_node *node)
+{
+	struct clk_divider *div;
+	u32 val;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return;
+
+	if (ti_clk_divider_populate(node, &div->reg, &div->table, &val,
+				    &div->flags, &div->width, &div->shift) < 0)
+		goto cleanup;
+
+	if (!ti_clk_add_component(node, &div->hw, CLK_COMPONENT_TYPE_DIVIDER))
+		return;
+
+cleanup:
+	kfree(div->table);
+	kfree(div);
+}
+CLK_OF_DECLARE(ti_composite_divider_clk, "ti,composite-divider-clock",
+	       of_ti_composite_divider_clk_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index c8c591d..17fb49e 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -223,6 +223,8 @@ struct ti_clk_ll_ops {
 
 extern struct ti_clk_ll_ops *ti_clk_ll_ops;
 
+extern const struct clk_ops ti_clk_divider_ops;
+
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
-- 
1.7.9.5

