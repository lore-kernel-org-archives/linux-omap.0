From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 03/36] CLK: TI: add autoidle support
Date: Wed, 9 Oct 2013 18:30:34 +0300
Message-ID: <1381332668-962-4-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41773 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074Ab3JIPcg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 11:32:36 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

TI clk driver now routes some of the basic clocks through own
registration routine to allow autoidle support. This routine just
checks a couple of device node properties and adds autoidle support
if required, and just passes the registration forward to basic clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c |    6 +++
 drivers/clk/ti/Makefile     |    2 +-
 drivers/clk/ti/autoidle.c   |  107 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h      |    9 ++++
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/ti/autoidle.c

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 0c38ca9..223f432b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -520,6 +520,9 @@ int omap2_clk_enable_autoidle_all(void)
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
 		if (c->ops && c->ops->allow_idle)
 			c->ops->allow_idle(c);
+
+	of_ti_clk_allow_autoidle_all();
+
 	return 0;
 }
 
@@ -539,6 +542,9 @@ int omap2_clk_disable_autoidle_all(void)
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
 		if (c->ops && c->ops->deny_idle)
 			c->ops->deny_idle(c);
+
+	of_ti_clk_deny_autoidle_all();
+
 	return 0;
 }
 
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 05af5d8..533efb4 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y					+= clk.o dpll.o
+obj-y					+= clk.o dpll.o autoidle.o
 endif
diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
new file mode 100644
index 0000000..ccac33c
--- /dev/null
+++ b/drivers/clk/ti/autoidle.c
@@ -0,0 +1,107 @@
+/*
+ * TI clock autoidle support
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
+struct clk_ti_autoidle {
+	void __iomem		*reg;
+	u8			shift;
+	u8			flags;
+	const char		*name;
+	struct list_head	node;
+};
+
+#define AUTOIDLE_LOW		0x1
+
+static LIST_HEAD(autoidle_clks);
+
+static void ti_allow_autoidle(struct clk_ti_autoidle *clk)
+{
+	u32 val;
+
+	val = readl(clk->reg);
+
+	if (clk->flags & AUTOIDLE_LOW)
+		val &= ~(1 << clk->shift);
+	else
+		val |= (1 << clk->shift);
+
+	writel(val, clk->reg);
+}
+
+static void ti_deny_autoidle(struct clk_ti_autoidle *clk)
+{
+	u32 val;
+
+	val = readl(clk->reg);
+
+	if (clk->flags & AUTOIDLE_LOW)
+		val |= (1 << clk->shift);
+	else
+		val &= ~(1 << clk->shift);
+
+	writel(val, clk->reg);
+}
+
+void of_ti_clk_allow_autoidle_all(void)
+{
+	struct clk_ti_autoidle *c;
+
+	list_for_each_entry(c, &autoidle_clks, node)
+		ti_allow_autoidle(c);
+}
+
+void of_ti_clk_deny_autoidle_all(void)
+{
+	struct clk_ti_autoidle *c;
+
+	list_for_each_entry(c, &autoidle_clks, node)
+		ti_deny_autoidle(c);
+}
+
+void __init of_ti_autoidle_setup(struct device_node *node)
+{
+	u32 shift;
+	void __iomem *reg;
+	struct clk_ti_autoidle *clk;
+
+	if (of_property_read_u32(node, "ti,autoidle-shift", &shift))
+		return;
+
+	reg = of_iomap(node, 0);
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+
+	if (!clk) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		return;
+	}
+
+	clk->shift = shift;
+	clk->name = node->name;
+	clk->reg = reg;
+
+	if (of_property_read_bool(node, "ti,autoidle-low"))
+		clk->flags |= AUTOIDLE_LOW;
+
+	list_add(&clk->node, &autoidle_clks);
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index c89574e..6d552c1 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -180,6 +180,15 @@ int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
 
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
+void of_ti_autoidle_setup(struct device_node *node);
+
+#ifdef CONFIG_OF
+void of_ti_clk_allow_autoidle_all(void);
+void of_ti_clk_deny_autoidle_all(void);
+#else
+static inline void of_ti_clk_allow_autoidle_all(void) { }
+static inline void of_ti_clk_deny_autoidle_all(void) { }
+#endif
 
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
-- 
1.7.9.5

