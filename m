From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 19/49] clk: ti: add support for basic mux clock
Date: Thu, 19 Dec 2013 13:23:50 +0200
Message-ID: <1387452260-23276-20-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49977 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590Ab3LSL0B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 06:26:01 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

ti,mux-clock provides now a binding for basic mux support. This is just
using the basic clock type.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 Documentation/devicetree/bindings/clock/ti/mux.txt |   76 +++++++++++
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/mux.c                               |  137 ++++++++++++++++++++
 3 files changed, 214 insertions(+), 1 deletion(-)
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
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
new file mode 100644
index 0000000..8d0d18a
--- /dev/null
+++ b/drivers/clk/ti/mux.c
@@ -0,0 +1,137 @@
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
+/**
+ * of_mux_clk_setup - Setup function for simple mux rate clock
+ * @node: DT node for the clock
+ *
+ * Sets up a basic clock multiplexer.
+ */
+static void of_mux_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char **parent_names;
+	int i;
+	struct clk_mux_desc *desc;
+	u32 val;
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return;
+
+	desc->desc.num_parents = of_clk_get_parent_count(node);
+	if (desc->desc.num_parents < 2) {
+		pr_err("mux-clock %s must have parents\n", node->name);
+		goto cleanup;
+	}
+	parent_names = kzalloc((sizeof(char *) * desc->desc.num_parents),
+			       GFP_KERNEL);
+	if (!parent_names)
+		goto cleanup;
+
+	for (i = 0; i < desc->desc.num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	desc->desc.parent_names = parent_names;
+	desc->desc.name = node->name;
+	desc->desc.register_func = clk_register_mux_desc;
+
+	desc->reg = ti_clk_get_reg_addr(node, 0);
+
+	if (!desc->reg)
+		goto cleanup;
+
+	desc->ll_ops = ti_clk_ll_ops;
+
+	if (!of_property_read_u32(node, "ti,bit-shift", &val))
+		desc->shift = val;
+
+	if (of_property_read_bool(node, "ti,index-starts-at-one"))
+		desc->flags |= CLK_MUX_INDEX_ONE;
+
+	if (of_property_read_bool(node, "ti,set-rate-parent"))
+		desc->desc.flags |= CLK_SET_RATE_PARENT;
+
+	/* Generate bit-mask based on parent info */
+	desc->mask = desc->desc.num_parents;
+	if (!(desc->flags & CLK_MUX_INDEX_ONE))
+		desc->mask--;
+
+	desc->mask = (1 << fls(desc->mask)) - 1;
+
+	clk = clk_register_desc(NULL, &desc->desc);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+cleanup:
+	kfree(desc->desc.parent_names);
+	kfree(desc);
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
+	mux->ll_ops = ti_clk_ll_ops;
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
-- 
1.7.9.5

