From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 07/33] CLK: omap: add support for OMAP gate clock
Date: Tue, 23 Jul 2013 10:20:02 +0300
Message-ID: <1374564028-11352-8-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48630 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753730Ab3GWHWM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:22:12 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

This node adds support for a clock node which allows control to the
clockdomain enable / disable.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/omap/Makefile |    2 +-
 drivers/clk/omap/clk.c    |    1 +
 drivers/clk/omap/gate.c   |   88 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/omap.h  |    1 +
 4 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/omap/gate.c

diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
index ca56700..3d3ca30f 100644
--- a/drivers/clk/omap/Makefile
+++ b/drivers/clk/omap/Makefile
@@ -1 +1 @@
-obj-y					+= clk.o dpll.o autoidle.o
+obj-y					+= clk.o dpll.o autoidle.o gate.o
diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
index c149097..8c89714 100644
--- a/drivers/clk/omap/clk.c
+++ b/drivers/clk/omap/clk.c
@@ -29,6 +29,7 @@ static const struct of_device_id clk_match[] = {
 	{.compatible = "divider-clock", .data = of_omap_divider_setup, },
 	{.compatible = "gate-clock", .data = of_gate_clk_setup, },
 	{.compatible = "ti,omap4-dpll-clock", .data = of_omap4_dpll_setup, },
+	{.compatible = "ti,gate-clock", .data = of_omap_gate_clk_setup, },
 	{},
 };
 
diff --git a/drivers/clk/omap/gate.c b/drivers/clk/omap/gate.c
new file mode 100644
index 0000000..7186bb2
--- /dev/null
+++ b/drivers/clk/omap/gate.c
@@ -0,0 +1,88 @@
+/*
+ * OMAP gate clock support
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
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/log2.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk/omap.h>
+
+#ifdef CONFIG_OF
+
+static const struct clk_ops omap_gate_clk_ops = {
+	.init		= &omap2_init_clk_clkdm,
+	.enable		= &omap2_clkops_enable_clkdm,
+	.disable	= &omap2_clkops_disable_clkdm,
+};
+
+void __init of_omap_gate_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	struct clk_init_data init;
+	struct clk_hw_omap *clk_hw;
+	const char *clk_name = node->name;
+	int num_parents;
+	const char **parent_names;
+	int i;
+
+	clk_hw = kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
+	if (!clk_hw) {
+		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
+		return;
+	}
+
+	clk_hw->hw.init = &init;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+	of_property_read_string(node, "ti,clkdm-name", &clk_hw->clkdm_name);
+
+	init.name = clk_name;
+	init.ops = &omap_gate_clk_ops;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: omap trace_clk %s must have parent(s)\n",
+			__func__, node->name);
+		goto cleanup;
+	}
+
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	init.num_parents = num_parents;
+	init.parent_names = parent_names;
+
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return;
+	}
+
+cleanup:
+	kfree(clk_hw);
+}
+EXPORT_SYMBOL(of_omap_gate_clk_setup);
+CLK_OF_DECLARE(omap_gate_clk, "ti,omap-gate-clock", of_omap_gate_clk_setup);
+#endif
diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
index 904bdad..58ebb80 100644
--- a/include/linux/clk/omap.h
+++ b/include/linux/clk/omap.h
@@ -194,6 +194,7 @@ extern void omap_dt_clocks_register(struct omap_dt_clk *oclks, int cnt);
 void of_omap4_dpll_setup(struct device_node *node);
 void of_omap_fixed_factor_setup(struct device_node *node);
 void of_omap_divider_setup(struct device_node *node);
+void of_omap_gate_clk_setup(struct device_node *node);
 void of_omap_clk_allow_autoidle_all(void);
 void of_omap_clk_deny_autoidle_all(void);
 
-- 
1.7.9.5

