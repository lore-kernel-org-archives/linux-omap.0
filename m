From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 07/41] CLK: ti: add support for ti divider-clock
Date: Tue, 26 Nov 2013 10:05:48 +0200
Message-ID: <1385453182-24421-8-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53594 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067Ab3KZII7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 03:08:59 -0500
In-Reply-To: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds support for TI divider clock binding, which simply uses
the basic clock divider to provide the features needed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/divider.txt       |  114 ++++++++++
 drivers/clk/ti/Makefile                            |    3 +-
 drivers/clk/ti/divider.c                           |  228 ++++++++++++++++++++
 3 files changed, 344 insertions(+), 1 deletion(-)
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
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
new file mode 100644
index 0000000..818549f
--- /dev/null
+++ b/drivers/clk/ti/divider.c
@@ -0,0 +1,228 @@
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
+	void __iomem **reg, const struct clk_div_table **table, u32 *flags,
+	u8 *div_flags, u8 *width, u8 *shift)
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
+	kfree(*table);
+	*table = NULL;
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
+static int __init of_ti_divider_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	void __iomem *reg;
+	const char *parent_name;
+	u8 clk_divider_flags = 0;
+	u8 width = 0;
+	u8 shift = 0;
+	const struct clk_div_table *table = NULL;
+	u32 flags = 0;
+	int ret = 0;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	ret = ti_clk_divider_populate(node, &reg, &table, &flags,
+				      &clk_divider_flags, &width, &shift);
+	if (ret < 0)
+		return ret;
+
+	clk = clk_register_divider_table(NULL, clk_name, parent_name,
+					 flags, reg, shift, width,
+					 clk_divider_flags, table, NULL);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		of_ti_clk_autoidle_setup(node);
+		return 0;
+	}
+
+	kfree(table);
+	return PTR_ERR(clk);
+}
+CLK_OF_DECLARE(divider_clk, "ti,divider-clock", of_ti_divider_clk_setup);
+
+static int __init of_ti_composite_divider_clk_setup(struct device_node *node)
+{
+	struct clk_divider *div;
+	u32 val;
+	int ret;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return -ENOMEM;
+
+	ret = ti_clk_divider_populate(node, &div->reg, &div->table, &val,
+				      &div->flags, &div->width, &div->shift);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ti_clk_add_component(node, &div->hw, CLK_COMPONENT_TYPE_DIVIDER);
+	if (!ret)
+		return 0;
+
+cleanup:
+	kfree(div->table);
+	kfree(div);
+	return ret;
+}
+CLK_OF_DECLARE(ti_composite_divider_clk, "ti,composite-divider-clock",
+	       of_ti_composite_divider_clk_setup);
-- 
1.7.9.5

