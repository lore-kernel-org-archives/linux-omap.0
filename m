From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 09/43] CLK: ti: add support for ti divider-clock
Date: Fri, 25 Oct 2013 18:57:03 +0300
Message-ID: <1382716658-6964-10-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53320 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab3JYP6s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 11:58:48 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds support for TI divider clock binding, which simply uses
the basic clock divider to provide the features needed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/divider.txt       |   86 +++++++
 drivers/clk/ti/Makefile                            |    3 +-
 drivers/clk/ti/divider.c                           |  239 ++++++++++++++++++++
 3 files changed, 327 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/divider.txt
 create mode 100644 drivers/clk/ti/divider.c

diff --git a/Documentation/devicetree/bindings/clock/ti/divider.txt b/Documentation/devicetree/bindings/clock/ti/divider.txt
new file mode 100644
index 0000000..65e3dcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/divider.txt
@@ -0,0 +1,86 @@
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
+	dividers = <4>, <8>, <0>, <16>;
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
+Required properties:
+- compatible : shall be "ti,divider-clock".
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
+- ti,index-starts-at-one : valid divisor programming starts at 1, not zero
+- ti,index-power-of-two : valid divisor programming must be a power of two
+- ti,autoidle-shift : bit shift of the autoidle enable bit for the clock
+- ti,invert-autoidle-bit : autoidle is enabled by setting the bit to 0
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
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
new file mode 100644
index 0000000..787bc8f
--- /dev/null
+++ b/drivers/clk/ti/divider.c
@@ -0,0 +1,239 @@
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
+		pr_err("%s: no valid dividers for %s table\n", __func__,
+		       node->name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	table = kzalloc(sizeof(*table) * (valid_div + 1), GFP_KERNEL);
+
+	if (!table) {
+		pr_err("%s: unable to allocate memory for %s table\n", __func__,
+		       node->name);
+		return ERR_PTR(-ENOMEM);
+	}
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
+		if (of_property_read_u32(node, "ti,min-div", &min_div)) {
+			pr_debug("%s: no min-div for %s, default=1\n",
+				 __func__, node->name);
+			min_div = 1;
+		}
+
+		if (of_property_read_u32(node, "ti,max-div", &max_div)) {
+			pr_err("%s: no max-div for %s!\n", __func__,
+			       node->name);
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
+/**
+ * of_ti_divider_clk_setup() - Setup function for simple div rate clock
+ */
+static int __init of_ti_divider_clk_setup(struct device_node *node,
+					  struct regmap *regmap)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	void __iomem *reg;
+	const char *parent_name;
+	u8 clk_divider_flags = 0;
+	u8 width = 0;
+	u8 shift = 0;
+	struct clk_div_table *table = NULL;
+	u32 val = 0;
+	u32 flags = 0;
+	int ret = 0;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	if (of_property_read_u32(node, "reg", &val)) {
+		pr_err("%s: %s must have reg\n", __func__, clk_name);
+		return -EINVAL;
+	}
+
+	reg = (void *)val;
+
+	if (!of_property_read_u32(node, "ti,bit-shift", &val))
+		shift = val;
+
+	if (of_property_read_bool(node, "ti,index-starts-at-one"))
+		clk_divider_flags |= CLK_DIVIDER_ONE_BASED;
+
+	if (of_property_read_bool(node, "ti,index-power-of-two"))
+		clk_divider_flags |= CLK_DIVIDER_POWER_OF_TWO;
+
+	if (of_property_read_bool(node, "ti,set-rate-parent"))
+		flags |= CLK_SET_RATE_PARENT;
+
+	table = ti_clk_get_div_table(node);
+
+	if (IS_ERR(table))
+		return PTR_ERR(table);
+
+	ret = _get_divider_width(node, table, clk_divider_flags);
+	if (ret < 0)
+		goto cleanup;
+
+	width = ret;
+
+	clk = clk_register_divider_table_regmap(NULL, clk_name, parent_name,
+						flags, reg, regmap, shift,
+						width, clk_divider_flags, table,
+						NULL);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		ret = of_ti_autoidle_setup(node, regmap);
+	} else {
+		ret = PTR_ERR(clk);
+	}
+
+	if (!ret)
+		return 0;
+cleanup:
+	kfree(table);
+	return ret;
+}
+CLK_OF_DECLARE(divider_clk, "ti,divider-clock", of_ti_divider_clk_setup);
+
+static int __init of_ti_composite_divider_clk_setup(struct device_node *node,
+						     struct regmap *regmap)
+{
+	struct clk_divider *div;
+	u32 val;
+	int ret;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return -ENOMEM;
+
+	of_property_read_u32(node, "reg", &val);
+	div->reg = (void *)val;
+	div->regmap = regmap;
+
+	div->table = ti_clk_get_div_table(node);
+
+	if (of_property_read_bool(node, "ti,index-starts-at-one"))
+		div->flags |= CLK_DIVIDER_ONE_BASED;
+
+	ret = _get_divider_width(node, div->table, div->flags);
+	if (ret < 0)
+		goto cleanup;
+
+	div->width = ret;
+
+	if (of_property_read_u32(node, "ti,bit-shift", &val)) {
+		pr_debug("%s: missing bit-shift property for %s, default=0\n",
+			 __func__, node->name);
+		val = 0;
+	}
+	div->shift = val;
+
+	ret = ti_clk_add_component(node, &div->hw, CLK_COMPONENT_TYPE_DIVIDER);
+	if (!ret)
+		return 0;
+
+cleanup:
+	kfree(div);
+	return ret;
+}
+CLK_OF_DECLARE(ti_composite_divider_clk, "ti,composite-divider-clock",
+	       of_ti_composite_divider_clk_setup);
-- 
1.7.9.5

