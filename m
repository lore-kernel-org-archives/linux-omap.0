From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 10/36] clk: ti: add support for basic mux clock
Date: Wed, 9 Oct 2013 18:30:41 +0300
Message-ID: <1381332668-962-11-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60185 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838Ab3JIPdR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 11:33:17 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

ti,mux-clock provides now a binding for basic mux support. This is just
using the basic clock type.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/clock/ti/mux.txt |   67 ++++++++++++++++
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/mux.c                               |   83 ++++++++++++++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/mux.txt
 create mode 100644 drivers/clk/ti/mux.c

diff --git a/Documentation/devicetree/bindings/clock/ti/mux.txt b/Documentation/devicetree/bindings/clock/ti/mux.txt
new file mode 100644
index 0000000..97e09c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/mux.txt
@@ -0,0 +1,67 @@
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
+- compatible : shall be "mux-clock".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : link phandles of parent clocks
+- reg : base address for register controlling adjustable mux
+
+Optional properties:
+- ti,bit-shift : number of bits to shift the bit-mask, defaults to
+  0 if not present
+- ti,index-starts-at-one : valid input select programming starts at 1, not
+  zero
+- ti,set-rate-parent : clk_set_rate is propagated to parent clock
+
+Examples:
+
+sys_clkin_ck: sys_clkin_ck@4a306110 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-clock";
+	clocks = <&virt_12000000_ck>, <&virt_13000000_ck>, <&virt_16800000_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_27000000_ck>, <&virt_38400000_ck>;
+	reg = <0x4a306110 0x4>;
+	ti,index-starts-at-one;
+};
+
+abe_dpll_bypass_clk_mux_ck: abe_dpll_bypass_clk_mux_ck@4a306108 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-clock";
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	ti,bit-shift = <24>;
+	reg = <0x4a306108 0x4>;
+};
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 68d55c9..f0986a5 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,5 +1,5 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o divider.o \
 					   fixed-factor.o gate.o clockdomain.o \
-					   mux-gate.o
+					   mux-gate.o mux.o
 endif
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
new file mode 100644
index 0000000..ed2aa36
--- /dev/null
+++ b/drivers/clk/ti/mux.c
@@ -0,0 +1,83 @@
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
+/**
+ * of_mux_clk_setup() - Setup function for simple mux rate clock
+ */
+static void of_mux_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
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
+	if (num_parents < 1) {
+		pr_err("%s: mux-clock %s must have parent(s)\n",
+		       __func__, node->name);
+		return;
+	}
+	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	reg = of_iomap(node, 0);
+	if (!reg) {
+		pr_err("%s: no memory mapped for property reg\n", __func__);
+		return;
+	}
+
+	if (of_property_read_u32(node, "ti,bit-shift", &shift)) {
+		pr_debug("%s: bit-shift property defaults to 0x%x for %s\n",
+			 __func__, shift, node->name);
+	}
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
+	clk = clk_register_mux_table(NULL, clk_name, parent_names, num_parents,
+				     flags, reg, shift, mask, clk_mux_flags,
+				     NULL, NULL);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(mux_clk, "ti,mux-clock", of_mux_clk_setup);
-- 
1.7.9.5

