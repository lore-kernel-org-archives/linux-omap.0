From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 05/43] CLK: TI: add DT alias clock registration mechanism
Date: Fri, 25 Oct 2013 18:56:59 +0300
Message-ID: <1382716658-6964-6-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37550 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313Ab3JYP6f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 11:58:35 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Some devices require their clocks to be available with a specific
dev-id con-id mapping. With DT, the clocks can be found by default
only with their name, or alternatively through the device node of
the consumer. With drivers, that don't support DT fully yet, add
mechanism to register specific clock names.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/Makefile |    2 +-
 drivers/clk/ti/clk.c    |   52 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h  |   23 +++++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/ti/clk.c

diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 93177987..05af5d8 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y					+= dpll.o
+obj-y					+= clk.o dpll.o
 endif
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
new file mode 100644
index 0000000..ad58b01
--- /dev/null
+++ b/drivers/clk/ti/clk.c
@@ -0,0 +1,52 @@
+/*
+ * TI clock support
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
+#include <linux/clkdev.h>
+#include <linux/clk/ti.h>
+#include <linux/of.h>
+
+/**
+ * ti_dt_clocks_register - register DT duplicate clocks during boot
+ * @oclks: list of clocks to register
+ *
+ * Register duplicate or non-standard DT clock entries during boot. By
+ * default, DT clocks are found based on their node name. If any
+ * additional con-id / dev-id -> clock mapping is required, use this
+ * function to list these.
+ */
+void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
+{
+	struct ti_dt_clk *c;
+	struct device_node *node;
+	struct clk *clk;
+	struct of_phandle_args clkspec;
+
+	for (c = oclks; c->node_name != NULL; c++) {
+		node = of_find_node_by_name(NULL, c->node_name);
+		clkspec.np = node;
+		clk = of_clk_get_from_provider(&clkspec);
+
+		if (!IS_ERR(clk)) {
+			c->lk.clk = clk;
+			clkdev_add(&c->lk);
+		} else {
+			pr_warn("%s: failed to lookup clock node %s\n",
+				__func__, c->node_name);
+		}
+	}
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index c187023..9786752 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -15,6 +15,8 @@
 #ifndef __LINUX_CLK_TI_H__
 #define __LINUX_CLK_TI_H__
 
+#include <linux/clkdev.h>
+
 /**
  * struct dpll_data - DPLL registers and integration data
  * @mult_div1_reg: register containing the DPLL M and N bitfields
@@ -135,6 +137,25 @@ struct clk_hw_omap {
 /* DPLL Type and DCO Selection Flags */
 #define DPLL_J_TYPE		0x1
 
+/**
+ * struct ti_dt_clk - OMAP DT clock alias declarations
+ * @lk: clock lookup definition
+ * @node_name: clock DT node to map to
+ */
+struct ti_dt_clk {
+	struct clk_lookup		lk;
+	char				*node_name;
+};
+
+#define DT_CLK(dev, con, name)		\
+	{				\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+		},			\
+		.node_name = name,	\
+	}
+
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap3_noncore_dpll_enable(struct clk_hw *hw);
 void omap3_noncore_dpll_disable(struct clk_hw *hw);
@@ -155,6 +176,8 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
 
+void ti_dt_clocks_register(struct ti_dt_clk *oclks);
+
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 
-- 
1.7.9.5

