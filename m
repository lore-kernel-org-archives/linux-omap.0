From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 04/36] CLK: ti: add support for ti divider-clock
Date: Wed, 9 Oct 2013 18:30:35 +0300
Message-ID: <1381332668-962-5-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41781 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074Ab3JIPcm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 11:32:42 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds support for TI divider clock binding, which simply uses
the basic clock divider to provide the features needed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/clock/ti/divider.txt       |   87 +++++++++++
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/divider.c                           |  164 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    2 +
 4 files changed, 254 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/divider.txt
 create mode 100644 drivers/clk/ti/divider.c

diff --git a/Documentation/devicetree/bindings/clock/ti/divider.txt b/Documentation/devicetree/bindings/clock/ti/divider.txt
new file mode 100644
index 0000000..a4e96a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/divider.txt
@@ -0,0 +1,87 @@
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
+- compatible : shall be "divider-clock".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : link to phandle of parent clock
+- reg : base address for register controlling adjustable divider
+- ti,bit-mask : arbitrary bitmask for programming the adjustable divider
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
+- ti,autoidle-low : autoidle is enabled by setting the bit to 0
+- ti,set-rate-parent : clk_set_rate is propagated to parent
+
+Examples:
+dpll_usb_m2_ck: dpll_usb_m2_ck@4a008190 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll_usb_ck>;
+	ti,max-div = <127>;
+	reg = <0x4a008190 0x4>;
+	ti,index-starts-at-one;
+};
+
+aess_fclk: aess_fclk@4a004528 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&abe_clk>;
+	ti,bit-shift = <24>;
+	reg = <0x4a004528 0x4>;
+	ti,max-div = <2>;
+};
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 533efb4..72a410b 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y					+= clk.o dpll.o autoidle.o
+obj-y					+= clk.o dpll.o autoidle.o divider.o
 endif
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
new file mode 100644
index 0000000..a97a5d6
--- /dev/null
+++ b/drivers/clk/ti/divider.c
@@ -0,0 +1,164 @@
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
+struct clk_div_table __init *ti_clk_get_div_table(struct device_node *node)
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
+		of_property_read_u32_index(node, "dividers", i, &val);
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
+/**
+ * of_ti_divider_clk_setup() - Setup function for simple div rate clock
+ */
+static void __init of_ti_divider_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	void __iomem *reg;
+	const char *parent_name;
+	u8 clk_divider_flags = 0;
+	u32 width = 0;
+	u32 shift = 0;
+	struct clk_div_table *table;
+	int min_div, max_div, div;
+	u32 val = 0;
+	u32 flags = 0;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	reg = of_iomap(node, 0);
+	if (!reg) {
+		pr_err("%s: no memory mapped for property reg\n", __func__);
+		return;
+	}
+
+	of_property_read_u32(node, "ti,bit-shift", &shift);
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
+		return;
+
+	if (!table) {
+		/* Clk divider table not provided, determine min/max divs */
+		if (of_property_read_u32(node, "ti,min-div", &min_div)) {
+			pr_debug("%s: ti,min-div not declared for %s, defaulting to 1\n", __func__,
+				 node->name);
+			min_div = 1;
+		}
+
+		if (of_property_read_u32(node, "ti,max-div", &max_div)) {
+			pr_err("%s: ti,max-div not declared for %s\n", __func__,
+			       node->name);
+			return;
+		}
+
+		/* Determine bit width for the field */
+		if (clk_divider_flags & CLK_DIVIDER_ONE_BASED)
+			val = 1;
+
+		div = min_div;
+
+		while (div < max_div) {
+			if (clk_divider_flags & CLK_DIVIDER_POWER_OF_TWO)
+				div <<= 1;
+			else
+				div++;
+			val++;
+		}
+	} else {
+		div = 0;
+
+		while (table[div].val) {
+			val = table[div].val;
+			div++;
+		}
+	}
+
+	width = fls(val);
+
+	clk = clk_register_divider_table(NULL, clk_name, parent_name, flags,
+					 reg, shift, width, clk_divider_flags,
+					 table, NULL);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		of_ti_autoidle_setup(node);
+	}
+}
+CLK_OF_DECLARE(divider_clk, "ti,divider-clock", of_ti_divider_clk_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 6d552c1..7f58f11 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -182,6 +182,8 @@ int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
 void of_ti_autoidle_setup(struct device_node *node);
 
+struct clk_div_table *ti_clk_get_div_table(struct device_node *node);
+
 #ifdef CONFIG_OF
 void of_ti_clk_allow_autoidle_all(void);
 void of_ti_clk_deny_autoidle_all(void);
-- 
1.7.9.5

