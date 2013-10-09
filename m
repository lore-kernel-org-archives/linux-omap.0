From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 09/36] clk: ti: add mux-gate clock support
Date: Wed, 9 Oct 2013 18:30:40 +0300
Message-ID: <1381332668-962-10-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40021 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab3JIPdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 11:33:11 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This is a multipurpose clock node, which contains support for multiple
sub-clocks. Uses composite clock type to implement the actual functionality.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/clock/ti/mux-gate.txt      |  100 +++++++++
 drivers/clk/ti/Makefile                            |    3 +-
 drivers/clk/ti/mux-gate.c                          |  214 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    1 +
 4 files changed, 317 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/mux-gate.txt
 create mode 100644 drivers/clk/ti/mux-gate.c

diff --git a/Documentation/devicetree/bindings/clock/ti/mux-gate.txt b/Documentation/devicetree/bindings/clock/ti/mux-gate.txt
new file mode 100644
index 0000000..dca04db
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/mux-gate.txt
@@ -0,0 +1,100 @@
+Binding for TI mux-gate clock.
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
+The binding must provide the register mapping to control the mux-gate.
+"reg-names" property is used to specify which sub-function are used
+for this composite clock, and to specify the corresponding control
+register addresses. Optional parameters are specified according to
+the sub-types used.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/clock/ti/mux.txt
+[3] Documentation/devicetree/bindings/clock/ti/divider.txt
+[4] Documentation/devicetree/bindings/clock/ti/gate.txt
+
+Required properties:
+- compatible : shall be one of:
+  "ti,mux-gate-clock" : mux-gate clock which waits until clock is active
+			before returning from clk_enable()
+  "ti,no-wait-mux-gate-clock" : mux-gate clock which does not wait for
+				clock activity
+  "ti,interface-mux-gate-clock" : mux-gate interface clock which waits until
+				  clock is active before returning from
+				  clk_enable()
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : link phandles of parent clocks
+- reg : base address array for registers controlling the mux-gate
+  sub-functions. Ordered according to "reg-names" property.
+- reg-names : register names property, can have following values:
+	"gate-reg" : base address for gate function control register
+	"mux-reg" : base address for mux function control register
+	"div-reg" : base address for divider function control register
+  Any of these values can be left out, and the corresponding function
+  will not be present in the composite clock either.
+
+Optional properties:
+- ti,gate-bit-shift : number of bits to shift the enable bit for gating
+  function, defaults to 0 if not present
+- ti,mux-bit-shift : number of bits to shift the bit-field for mux
+  function, defaults to 0 if not present
+- ti,div-index-starts-at-one : min-div is mapped to bit-value 1, default 0
+- ti,max-div : maximum divider value for the divider function
+- ti,min-div : minimum divider value for the divider function, defaults to
+  1 if not present
+- ti,dividers : array of valid divider values for the clock
+
+Examples:
+
+dpll_core_m3x2_ck: dpll_core_m3x2_ck@4a004134 {
+	#clock-cells = <0>;
+	compatible = "ti,no-wait-mux-gate-clock";
+	clocks = <&dpll_core_x2_ck>;
+	ti,max-div = <31>;
+	reg-names = "gate-reg", "div-reg";
+	reg = <0x4a004134 0x4>, <0x4a004134 0x4>;
+	ti,gate-bit-shift = <8>;
+	ti,div-index-starts-at-one;
+};
+
+auxclk2_src_ck: auxclk2_src_ck@4a30a318 {
+	#clock-cells = <0>;
+	compatible = "ti,no-wait-mux-gate-clock";
+	clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	reg-names = "gate-reg", "mux-reg";
+	reg = <0x4a30a318 0x4>, <0x4a30a318 0x4>;
+	ti,gate-bit-shift = <8>;
+	ti,mux-bit-shift = <1>;
+};
+
+gpt10_fck: gpt10_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	reg-names = "gate-reg", "mux-reg";
+	reg = <0x48004a00 0x4>, <0x48004a40 0x4>;
+	ti,gate-bit-shift = <11>;
+	ti,mux-bit-shift = <6>;
+};
+
+ssi_ssr_fck_3430es1: ssi_ssr_fck_3430es1@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,no-wait-mux-gate-clock";
+	clocks = <&corex2_fck>;
+	ti,div-bit-shift = <8>;
+	ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>;
+	reg-names = "gate-reg", "div-reg";
+	reg = <0x48004a00 0x4>, <0x48004a40 0x4>;
+	ti,gate-bit-shift = <0>;
+};
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index ce8bd06..68d55c9 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,4 +1,5 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o divider.o \
-					   fixed-factor.o gate.o clockdomain.o
+					   fixed-factor.o gate.o clockdomain.o \
+					   mux-gate.o
 endif
diff --git a/drivers/clk/ti/mux-gate.c b/drivers/clk/ti/mux-gate.c
new file mode 100644
index 0000000..e7b5bd8
--- /dev/null
+++ b/drivers/clk/ti/mux-gate.c
@@ -0,0 +1,214 @@
+/*
+ * OMAP mux-gate clock support
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
+
+#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
+
+static unsigned long omap_mux_gate_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	return clk_divider_ops.recalc_rate(hw, parent_rate);
+}
+
+static long omap_mux_gate_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	return -EINVAL;
+}
+
+static int omap_mux_gate_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	return -EINVAL;
+}
+
+static const struct clk_ops omap_mux_gate_divider_ops = {
+	.recalc_rate	= &omap_mux_gate_recalc_rate,
+	.round_rate	= &omap_mux_gate_round_rate,
+	.set_rate	= &omap_mux_gate_set_rate,
+};
+
+static const struct clk_ops omap_mux_gate_gate_ops = {
+	.enable		= &omap2_dflt_clk_enable,
+	.disable	= &omap2_dflt_clk_disable,
+	.is_enabled	= &omap2_dflt_clk_is_enabled,
+};
+
+static void __init
+_of_ti_mux_gate_clk_setup(struct device_node *node,
+			  const struct clk_hw_omap_ops *hw_ops)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char **parent_names = NULL;
+	int num_parents;
+	struct clk_hw_omap *gate = NULL;
+	struct clk_divider *div = NULL;
+	struct clk_mux *mux = NULL;
+	const struct clk_ops *mux_ops, *div_ops, *gate_ops;
+	u32 val;
+	int i;
+	u32 min_div, max_div, divider;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	num_parents = of_clk_get_parent_count(node);
+
+	if (num_parents < 1) {
+		pr_err("%s: omap-mux-clock %s must have parent(s)\n", __func__,
+		       node->name);
+		return;
+	}
+
+	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	i = of_property_match_string(node, "reg-names", "gate-reg");
+	if (i >= 0) {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		gate->enable_reg = of_iomap(node, i);
+		if (of_property_read_u32(node, "ti,gate-bit-shift", &val)) {
+			pr_err("%s: missing gate-bit-shift property for %s\n",
+			       __func__, node->name);
+			goto cleanup;
+		}
+		gate->enable_bit = val;
+		gate->ops = hw_ops;
+
+		gate_ops = &omap_mux_gate_gate_ops;
+	}
+
+	i = of_property_match_string(node, "reg-names", "mux-reg");
+	if (i >= 0) {
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		mux->reg = of_iomap(node, i);
+		mux_ops = &clk_mux_ops;
+		if (of_property_read_u32(node, "ti,mux-bit-shift", &val)) {
+			pr_debug("%s: missing mux-bit-shift property for %s, defaulting to 0\n",
+				 __func__, node->name);
+			val = 0;
+		}
+		mux->shift = val;
+
+		mux->mask = num_parents - 1;
+		mux->mask = (1 << fls(mux->mask)) - 1;
+
+		mux_ops = &clk_mux_ops;
+	}
+
+	i = of_property_match_string(node, "reg-names", "div-reg");
+	if (i >= 0) {
+		div = kzalloc(sizeof(*div), GFP_KERNEL);
+		div->reg = of_iomap(node, i);
+
+		div->table = ti_clk_get_div_table(node);
+
+		if (of_property_read_bool(node, "ti,div-index-starts-at-one"))
+			div->flags |= CLK_DIVIDER_ONE_BASED;
+
+		if (!div->table) {
+			if (of_property_read_u32(node, "ti,min-div",
+						 &min_div)) {
+				pr_debug("%s: ti,min-div not declared for %s, defaulting to 1\n",
+					 __func__, node->name);
+				min_div = 1;
+			}
+
+			if (of_property_read_u32(node, "ti,max-div",
+						 &max_div)) {
+				pr_err("%s: ti,max-div not declared for %s\n",
+				       __func__, node->name);
+				goto cleanup;
+			}
+
+			val = 0;
+
+			if (div->flags & CLK_DIVIDER_ONE_BASED)
+				val = 1;
+
+			divider = min_div;
+
+			while (divider < max_div) {
+				divider++;
+				val++;
+			}
+		} else {
+			divider = 0;
+			while (div->table[divider].val) {
+				val = div->table[divider].val;
+				divider++;
+			}
+		}
+
+		div->width = fls(val);
+
+		if (of_property_read_u32(node, "ti,div-bit-shift", &val)) {
+			pr_debug("%s: missing div-bit-shift property for %s, defaulting to 0\n",
+				 __func__, node->name);
+			val = 0;
+		}
+		div->shift = val;
+
+		div->table = ti_clk_get_div_table(node);
+
+		div_ops = &omap_mux_gate_divider_ops;
+	}
+
+	clk = clk_register_composite(NULL, clk_name,
+			parent_names, num_parents,
+			mux ? &mux->hw : NULL, mux_ops,
+			div ? &div->hw : NULL, div_ops,
+			gate ? &gate->hw : NULL, gate_ops, 0);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return;
+cleanup:
+	kfree(mux);
+	kfree(div);
+	kfree(gate);
+	kfree(parent_names);
+}
+
+static void __init of_ti_no_wait_mux_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_mux_gate_clk_setup(node, NULL);
+}
+CLK_OF_DECLARE(ti_no_wait_mux_gate_clk, "ti,no-wait-mux-gate-clock",
+	       of_ti_no_wait_mux_gate_clk_setup);
+
+static void __init of_ti_interface_mux_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_mux_gate_clk_setup(node, &clkhwops_iclk_wait);
+}
+CLK_OF_DECLARE(ti_interface_mux_gate_clk, "ti,interface-mux-gate-clock",
+	       of_ti_interface_mux_gate_clk_setup);
+
+static void __init of_ti_mux_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_mux_gate_clk_setup(node, &clkhwops_wait);
+}
+CLK_OF_DECLARE(ti_mux_gate_clk, "ti,mux-gate-clock",
+	       of_ti_mux_gate_clk_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index e70a2eb..ed4b36e 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -229,6 +229,7 @@ static inline void of_ti_clk_deny_autoidle_all(void) { }
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_wait;
+extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 
-- 
1.7.9.5

