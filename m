From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 20/36] CLK: TI: DRA7: Add APLL support
Date: Wed, 9 Oct 2013 18:30:51 +0300
Message-ID: <1381332668-962-21-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40111 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3JIPeV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 11:34:21 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, J Keerthy <j-keerthy@ti.com>

From: J Keerthy <j-keerthy@ti.com>

The patch adds support for DRA7 PCIe APLL. The APLL
sources the optional functional clocks for PCIe module.

APLL stands for Analog PLL. This is different when comapred
with DPLL meaning Digital PLL, the phase detection is done
using an analog circuit.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/apll.txt          |   31 +++
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/apll.c                              |  224 ++++++++++++++++++++
 3 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/apll.txt
 create mode 100644 drivers/clk/ti/apll.c

diff --git a/Documentation/devicetree/bindings/clock/ti/apll.txt b/Documentation/devicetree/bindings/clock/ti/apll.txt
new file mode 100644
index 0000000..7faf5a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/apll.txt
@@ -0,0 +1,31 @@
+Binding for Texas Instruments APLL clock.
+
+Binding status: Unstable - ABI compatibility may be broken in the future
+
+This binding uses the common clock binding[1].  It assumes a
+register-mapped APLL with usually two selectable input clocks
+(reference clock and bypass clock), with analog phase locked
+loop logic for multiplying the input clock to a desired output
+clock. This clock also typically supports different operation
+modes (locked, low power stop etc.) APLL mostly behaves like
+a subtype of a DPLL [2], although a simplified one at that.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/clock/ti/dpll.txt
+
+Required properties:
+- compatible : shall be "ti,dra7-apll-clock"
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : link phandles of parent clocks (clk-ref and clk-bypass)
+- reg : address and length of the register set for controlling the APLL.
+  It contains the information of registers in the following order:
+	"control" - contains the control register base address
+	"idlest" - contains the idlest register base address
+
+Examples:
+	apll_pcie_ck: apll_pcie_ck@4a008200 {
+		#clock-cells = <0>;
+		clocks = <&apll_pcie_in_clk_mux>, <&dpll_pcie_ref_ck>;
+		reg = <0x4a00821c 0x4>, <0x4a008220 0x4>;
+		compatible = "ti,dra7-apll-clock";
+	};
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 9d785e5..dba8b3e 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,7 +1,7 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o divider.o \
 					   fixed-factor.o gate.o clockdomain.o \
-					   mux-gate.o mux.o
+					   mux-gate.o mux.o apll.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clk-44xx.o
 obj-$(CONFIG_SOC_OMAP5)			+= clk-54xx.o
 endif
diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
new file mode 100644
index 0000000..85558f1
--- /dev/null
+++ b/drivers/clk/ti/apll.c
@@ -0,0 +1,224 @@
+/*
+ * OMAP APLL clock support
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * J Keerthy <j-keerthy@ti.com>
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
+#include <linux/clk/ti.h>
+#include <linux/delay.h>
+
+#define APLL_FORCE_LOCK 0x1
+#define APLL_AUTO_IDLE	0x2
+#define MAX_APLL_WAIT_TRIES		1000000
+
+static int dra7_apll_enable(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	int r = 0, i = 0;
+	struct dpll_data *ad;
+	const char *clk_name;
+	u8 state = 1;
+	u32 v;
+
+	ad = clk->dpll_data;
+	if (!ad)
+		return -EINVAL;
+
+	clk_name = __clk_get_name(clk->hw.clk);
+
+	state <<= __ffs(ad->idlest_mask);
+
+	/* Check is already locked */
+	if ((readl(ad->idlest_reg) & ad->idlest_mask) == state)
+		return r;
+
+	v = readl(ad->control_reg);
+	v &= ~ad->enable_mask;
+	v |= APLL_FORCE_LOCK << __ffs(ad->enable_mask);
+	writel(v, ad->control_reg);
+
+	state <<= __ffs(ad->idlest_mask);
+
+	while (((readl(ad->idlest_reg) & ad->idlest_mask) != state) &&
+	       i < MAX_APLL_WAIT_TRIES) {
+		i++;
+		udelay(1);
+	}
+
+	if (i == MAX_APLL_WAIT_TRIES) {
+		pr_warn("clock: %s failed transition to '%s'\n",
+			clk_name, (state) ? "locked" : "bypassed");
+	} else {
+		pr_debug("clock: %s transition to '%s' in %d loops\n",
+			 clk_name, (state) ? "locked" : "bypassed", i);
+
+		r = 0;
+	}
+
+	return r;
+}
+
+static void dra7_apll_disable(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *ad;
+	u8 state = 1;
+	u32 v;
+
+	ad = clk->dpll_data;
+
+	state <<= __ffs(ad->idlest_mask);
+
+	v = readl(ad->control_reg);
+	v &= ~ad->enable_mask;
+	v |= APLL_AUTO_IDLE << __ffs(ad->enable_mask);
+	writel(v, ad->control_reg);
+}
+
+static int dra7_apll_is_enabled(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *ad;
+	u32 v;
+
+	ad = clk->dpll_data;
+
+	v = readl(ad->control_reg);
+	v &= ad->enable_mask;
+
+	v >>= __ffs(ad->enable_mask);
+
+	return v == APLL_AUTO_IDLE ? 0 : 1;
+}
+
+static u8 dra7_init_apll_parent(struct clk_hw *hw)
+{
+	return 0;
+}
+
+static const struct clk_ops apll_ck_ops = {
+	.enable		= &dra7_apll_enable,
+	.disable	= &dra7_apll_disable,
+	.is_enabled	= &dra7_apll_is_enabled,
+	.get_parent	= &dra7_init_apll_parent,
+};
+
+static struct clk *omap_clk_register_apll(struct device *dev, const char *name,
+		const char **parent_names, int num_parents, unsigned long flags,
+		struct dpll_data *dpll_data, const char *clkdm_name,
+		const struct clk_ops *ops)
+{
+	struct clk *clk;
+	struct clk_init_data init = { NULL };
+	struct clk_hw_omap *clk_hw;
+
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	if (!clk_hw) {
+		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	clk_hw->dpll_data = dpll_data;
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
+	return clk;
+}
+
+static void __init of_dra7_apll_setup(struct device_node *node)
+{
+	const struct clk_ops *ops;
+	struct clk *clk;
+	const char *clk_name = node->name;
+	int num_parents;
+	const char **parent_names = NULL;
+	u8 apll_flags = 0;
+	struct dpll_data *ad;
+	u32 idlest_mask = 0x1;
+	u32 autoidle_mask = 0x3;
+	int i;
+
+	ops = &apll_ck_ops;
+	ad = kzalloc(sizeof(*ad), GFP_KERNEL);
+	if (!ad) {
+		pr_err("%s: could not allocate dpll_data\n", __func__);
+		return;
+	}
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: omap dpll %s must have parent(s)\n",
+		       __func__, node->name);
+		goto cleanup;
+	}
+
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	ad->clk_ref = of_clk_get(node, 0);
+	ad->clk_bypass = of_clk_get(node, 1);
+
+	if (IS_ERR(ad->clk_ref)) {
+		pr_err("%s: ti,clk-ref for %s not found\n", __func__,
+		       clk_name);
+		goto cleanup;
+	}
+
+	if (IS_ERR(ad->clk_bypass)) {
+		pr_err("%s: ti,clk-bypass for %s not found\n", __func__,
+		       clk_name);
+		goto cleanup;
+	}
+
+	ad->control_reg = of_iomap(node, 0);
+	ad->idlest_reg = of_iomap(node, 1);
+
+	ad->idlest_mask = idlest_mask;
+	ad->enable_mask = autoidle_mask;
+
+	clk = omap_clk_register_apll(NULL, clk_name, parent_names,
+				num_parents, apll_flags, ad,
+				NULL, ops);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return;
+
+cleanup:
+	kfree(parent_names);
+	kfree(ad);
+	return;
+}
+CLK_OF_DECLARE(dra7_apll_clock, "ti,dra7-apll-clock", of_dra7_apll_setup);
-- 
1.7.9.5

