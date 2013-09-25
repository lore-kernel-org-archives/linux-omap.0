From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv7 02/36] CLK: TI: add DT alias clock registration mechanism
Date: Wed, 25 Sep 2013 11:48:08 +0300
Message-ID: <1380098922-30340-3-git-send-email-t-kristo@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Some devices require their clocks to be available with a specific
dev-id con-id mapping. With DT, the clocks can be found by default
only with their name, or alternatively through the device node of
the consumer. With drivers, that don't support DT fully yet, add
mechanism to register specific clock names.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
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
+ * Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
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
index 385384a..c89574e 100644
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
@@ -138,6 +140,25 @@ struct clk_hw_omap {
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
@@ -158,6 +179,8 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
 
+void ti_dt_clocks_register(struct ti_dt_clk *oclks);
+
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
