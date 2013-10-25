From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 07/43] CLK: TI: add autoidle support
Date: Fri, 25 Oct 2013 18:57:01 +0300
Message-ID: <1382716658-6964-8-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37558 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753434Ab3JYP6o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 11:58:44 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

TI clk driver now routes some of the basic clocks through own
registration routine to allow autoidle support. This routine just
checks a couple of device node properties and adds autoidle support
if required, and just passes the registration forward to basic clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |    6 +++
 drivers/clk/ti/Makefile     |    2 +-
 drivers/clk/ti/autoidle.c   |  109 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h      |    9 ++++
 4 files changed, 125 insertions(+), 1 deletion(-)
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
index 0000000..efa2a3e
--- /dev/null
+++ b/drivers/clk/ti/autoidle.c
@@ -0,0 +1,109 @@
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
+	u32			reg;
+	struct regmap		*regmap;
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
+	regmap_read(clk->regmap, clk->reg, &val);
+
+	if (clk->flags & AUTOIDLE_LOW)
+		val &= ~(1 << clk->shift);
+	else
+		val |= (1 << clk->shift);
+
+	regmap_write(clk->regmap, clk->reg, val);
+}
+
+static void ti_deny_autoidle(struct clk_ti_autoidle *clk)
+{
+	u32 val;
+
+	regmap_read(clk->regmap, clk->reg, &val);
+
+	if (clk->flags & AUTOIDLE_LOW)
+		val |= (1 << clk->shift);
+	else
+		val &= ~(1 << clk->shift);
+
+	regmap_write(clk->regmap, clk->reg, val);
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
+int __init of_ti_autoidle_setup(struct device_node *node,
+				struct regmap *regmap)
+{
+	u32 shift;
+	struct clk_ti_autoidle *clk;
+
+	if (of_property_read_u32(node, "ti,autoidle-shift", &shift))
+		return 0;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+
+	if (!clk) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	clk->shift = shift;
+	clk->name = node->name;
+	of_property_read_u32(node, "reg", &clk->reg);
+	clk->regmap = regmap;
+
+	if (of_property_read_bool(node, "ti,invert-autoidle-bit"))
+		clk->flags |= AUTOIDLE_LOW;
+
+	list_add(&clk->node, &autoidle_clks);
+
+	return 0;
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 7ab02fa..e45005c 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -178,6 +178,15 @@ int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
 void ti_dt_clk_init_provider(struct device_node *np, struct regmap *regmap);
+int of_ti_autoidle_setup(struct device_node *node, struct regmap *regmap);
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

