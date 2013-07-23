From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 30/33] clk: OMAP: DRA7: Add APLL support
Date: Tue, 23 Jul 2013 10:20:25 +0300
Message-ID: <1374564028-11352-31-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33560 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754726Ab3GWHX2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:23:28 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Keerthy <j-keerthy@ti.com>

From: Keerthy <j-keerthy@ti.com>

The patch adds support for DRA7 PCIe APLL. The APLL
sources the optional functional clocks for PCIe module.

APLL stands for Analog PLL. This is different when comapred
with DPLL meaning Digital PLL, the phase detection is done
using an analog circuit.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/clock.h |    1 -
 drivers/clk/omap/Makefile   |    3 +-
 drivers/clk/omap/apll.c     |  213 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/omap/clk.c      |    1 +
 include/linux/clk/omap.h    |    3 +
 5 files changed, 219 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/omap/apll.c

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 949d293..5f1c7d4 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -38,7 +38,6 @@ struct omap_clk {
 	}
 
 struct clockdomain;
-#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
 #define DEFINE_STRUCT_CLK(_name, _parent_array_name, _clkops_name)	\
 	static struct clk _name = {				\
diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
index 85b0dc7..6bceb27 100644
--- a/drivers/clk/omap/Makefile
+++ b/drivers/clk/omap/Makefile
@@ -1,3 +1,4 @@
 obj-y					+= clk.o dpll.o autoidle.o gate.o \
 					   clk-44xx.o clk-54xx.o clk-7xx.o \
-					   clk-33xx.o interface.o clk-3xxx.o
+					   clk-33xx.o interface.o clk-3xxx.o \
+					   apll.o
diff --git a/drivers/clk/omap/apll.c b/drivers/clk/omap/apll.c
new file mode 100644
index 0000000..3a216b8
--- /dev/null
+++ b/drivers/clk/omap/apll.c
@@ -0,0 +1,213 @@
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
+#include <linux/clk/omap.h>
+#include <linux/delay.h>
+
+#define APLL_FORCE_LOCK 0x1
+#define APLL_AUTO_IDLE	0x2
+#define MAX_APLL_WAIT_TRIES		1000000
+
+int dra7_apll_enable(struct clk_hw *hw)
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
+	if ((__raw_readl(ad->idlest_reg) & ad->idlest_mask) == state)
+		return r;
+
+	v = __raw_readl(ad->control_reg);
+	v &= ~ad->enable_mask;
+	v |= APLL_FORCE_LOCK << __ffs(ad->enable_mask);
+	__raw_writel(v, ad->control_reg);
+
+	state <<= __ffs(ad->idlest_mask);
+
+	while (((__raw_readl(ad->idlest_reg) & ad->idlest_mask) != state) &&
+	       i < MAX_APLL_WAIT_TRIES) {
+		i++;
+		udelay(1);
+	}
+
+	if (i == MAX_APLL_WAIT_TRIES) {
+		pr_warn("clock: %s failed transition to '%s'\n",
+		       clk_name, (state) ? "locked" : "bypassed");
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
+void dra7_apll_disable(struct clk_hw *hw)
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
+	v = __raw_readl(ad->control_reg);
+	v &= ~ad->enable_mask;
+	v |= APLL_AUTO_IDLE << __ffs(ad->enable_mask);
+	__raw_writel(v, ad->control_reg);
+}
+
+u8 dra7_init_apll_parent(struct clk_hw *hw)
+{
+	return 0;
+}
+
+static const struct clk_ops apll_ck_ops = {
+	.enable		= &dra7_apll_enable,
+	.disable	= &dra7_apll_disable,
+	.get_parent	= &dra7_init_apll_parent,
+};
+
+struct clk *omap_clk_register_apll(struct device *dev, const char *name,
+		const char **parent_names, int num_parents, unsigned long flags,
+		struct dpll_data *dpll_data, const char *clkdm_name,
+		const struct clk_ops *ops)
+{
+	struct clk *clk;
+	struct clk_init_data init;
+	struct clk_hw_omap *clk_hw;
+
+	clk_hw = kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
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
+#ifdef CONFIG_OF
+
+__init void of_dra7_apll_setup(struct device_node *node)
+{
+	const struct clk_ops *ops;
+	struct clk *clk;
+	const char *clk_name = node->name;
+	int num_parents;
+	const char **parent_names;
+	struct of_phandle_args clkspec;
+	u8 apll_flags = 0;
+	struct dpll_data *ad;
+	u32 idlest_mask = 0x1;
+	u32 autoidle_mask = 0x3;
+	int i;
+
+	ops = &apll_ck_ops;
+	ad = kzalloc(sizeof(struct dpll_data), GFP_KERNEL);
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
+			__func__, node->name);
+		goto cleanup;
+	}
+
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	clkspec.np = of_parse_phandle(node, "ti,clk-ref", 0);
+	ad->clk_ref = of_clk_get_from_provider(&clkspec);
+	if (!ad->clk_ref) {
+		pr_err("%s: ti,clk-ref for %s not found\n", __func__,
+			clk_name);
+		goto cleanup;
+	}
+
+	clkspec.np = of_parse_phandle(node, "ti,clk-bypass", 0);
+	ad->clk_bypass = of_clk_get_from_provider(&clkspec);
+	if (!ad->clk_bypass) {
+		pr_err("%s: ti,clk-bypass for %s not found\n", __func__,
+			clk_name);
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
+	kfree(ad);
+	return;
+
+}
+EXPORT_SYMBOL_GPL(of_dra7_apll_setup);
+CLK_OF_DECLARE(dra7_apll_clock, "ti,dra7-apll-clock", of_dra7_apll_setup);
+#endif
diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
index 5cbefde..476f6cb 100644
--- a/drivers/clk/omap/clk.c
+++ b/drivers/clk/omap/clk.c
@@ -29,6 +29,7 @@ static const struct of_device_id clk_match[] = {
 	{.compatible = "divider-clock", .data = of_omap_divider_setup, },
 	{.compatible = "gate-clock", .data = of_gate_clk_setup, },
 	{.compatible = "ti,omap4-dpll-clock", .data = of_omap4_dpll_setup, },
+	{.compatible = "ti,dra7-apll-clock", .data = of_dra7_apll_setup, },
 	{.compatible = "ti,gate-clock", .data = of_omap_gate_clk_setup, },
 	{.compatible = "ti,interface-clock",
 		.data = of_omap_interface_clk_setup, },
diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
index 35008d9..0d70cd1 100644
--- a/include/linux/clk/omap.h
+++ b/include/linux/clk/omap.h
@@ -162,6 +162,8 @@ struct omap_dt_clk {
 		.node_name = name,	\
 	}
 
+#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
+
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap3_noncore_dpll_enable(struct clk_hw *hw);
 void omap3_noncore_dpll_disable(struct clk_hw *hw);
@@ -209,6 +211,7 @@ extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 int dt_omap_clk_init(void);
 extern void omap_dt_clocks_register(struct omap_dt_clk *oclks, int cnt);
 void of_omap4_dpll_setup(struct device_node *node);
+void of_dra7_apll_setup(struct device_node *node);
 void of_omap3_dpll_setup(struct device_node *node);
 void of_omap_fixed_factor_setup(struct device_node *node);
 void of_omap_divider_setup(struct device_node *node);
-- 
1.7.9.5

