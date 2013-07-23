From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 23/33] CLK: OMAP: add interface clock support for OMAP3
Date: Tue, 23 Jul 2013 10:20:18 +0300
Message-ID: <1374564028-11352-24-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33543 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586Ab3GWHXK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:23:10 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

OMAP3 has interface clocks in addition to functional clocks, which
require special handling for the autoidle and idle status register
offsets mainly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/omap/Makefile    |    2 +-
 drivers/clk/omap/clk.c       |    3 ++
 drivers/clk/omap/interface.c |  110 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/omap/interface.c

diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
index c4e8825..faaeb62 100644
--- a/drivers/clk/omap/Makefile
+++ b/drivers/clk/omap/Makefile
@@ -1,3 +1,3 @@
 obj-y					+= clk.o dpll.o autoidle.o gate.o \
 					   clk-44xx.o clk-54xx.o clk-7xx.o \
-					   clk-33xx.o
+					   clk-33xx.o interface.o
diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
index 8c89714..5cbefde 100644
--- a/drivers/clk/omap/clk.c
+++ b/drivers/clk/omap/clk.c
@@ -30,6 +30,9 @@ static const struct of_device_id clk_match[] = {
 	{.compatible = "gate-clock", .data = of_gate_clk_setup, },
 	{.compatible = "ti,omap4-dpll-clock", .data = of_omap4_dpll_setup, },
 	{.compatible = "ti,gate-clock", .data = of_omap_gate_clk_setup, },
+	{.compatible = "ti,interface-clock",
+		.data = of_omap_interface_clk_setup, },
+	{.compatible = "ti,omap3-dpll-clock", .data = of_omap3_dpll_setup, },
 	{},
 };
 
diff --git a/drivers/clk/omap/interface.c b/drivers/clk/omap/interface.c
new file mode 100644
index 0000000..f1f1a1a
--- /dev/null
+++ b/drivers/clk/omap/interface.c
@@ -0,0 +1,110 @@
+/*
+ * OMAP interface clock support
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
+static const struct clk_ops omap_interface_clk_ops = {
+	.init		= &omap2_init_clk_clkdm,
+	.enable		= &omap2_dflt_clk_enable,
+	.disable	= &omap2_dflt_clk_disable,
+	.is_enabled	= &omap2_dflt_clk_is_enabled,
+};
+
+void __init of_omap_interface_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	struct clk_init_data init;
+	struct clk_hw_omap *clk_hw;
+	const char *clk_name = node->name;
+	int num_parents;
+	const char **parent_names;
+	int i;
+	u32 val;
+
+	clk_hw = kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
+	if (!clk_hw) {
+		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
+		return;
+	}
+
+	clk_hw->hw.init = &init;
+	clk_hw->ops = &clkhwops_iclk_wait;
+	clk_hw->enable_reg = of_iomap(node, 0);
+
+	if (!of_property_read_u32(node, "ti,enable-bit", &val))
+		clk_hw->enable_bit = val;
+
+	if (of_property_read_bool(node, "ti,iclk-no-wait"))
+		clk_hw->ops = &clkhwops_iclk;
+
+	if (of_property_read_bool(node, "ti,iclk-hsotgusb"))
+		clk_hw->ops = &clkhwops_omap3430es2_iclk_hsotgusb_wait;
+
+	if (of_property_read_bool(node, "ti,iclk-dss"))
+		clk_hw->ops = &clkhwops_omap3430es2_iclk_dss_usbhost_wait;
+
+	if (of_property_read_bool(node, "ti,iclk-ssi"))
+		clk_hw->ops = &clkhwops_omap3430es2_iclk_ssi_wait;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+	of_property_read_string(node, "ti,clkdm-name", &clk_hw->clkdm_name);
+
+	init.name = clk_name;
+	init.ops = &omap_interface_clk_ops;
+	init.flags = 0;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: omap interface_clk %s must have parent(s)\n",
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
+		omap2_init_clk_hw_omap_clocks(clk);
+		return;
+	}
+
+cleanup:
+	kfree(clk_hw);
+}
+EXPORT_SYMBOL(of_omap_interface_clk_setup);
+CLK_OF_DECLARE(omap_interface_clk, "ti,omap-interface-clock",
+		of_omap_interface_clk_setup);
+#endif
-- 
1.7.9.5

