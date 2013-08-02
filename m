From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 03/31] CLK: TI: add DT alias clock registration mechanism
Date: Fri, 2 Aug 2013 19:25:22 +0300
Message-ID: <1375460751-23676-4-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40729 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868Ab3HBQ0i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:26:38 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Some devices require their clocks to be available with a specific
dev-id con-id mapping. With DT, the clocks can be found by default
only with their name, or alternatively through the device node of
the consumer. With drivers, that don't support DT fully yet, add
mechanism to register specific clock names.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/Makefile |    2 +-
 drivers/clk/ti/clk.c    |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h  |   23 +++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)
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
index 0000000..b6eb756
--- /dev/null
+++ b/drivers/clk/ti/clk.c
@@ -0,0 +1,37 @@
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
+
+/**
+ * omap_dt_clocks_register - register DT duplicate clocks during boot
+ * @oclks: list of clocks to register
+ *
+ * Register duplicate or non-standard DT clock entries during boot. By
+ * default, DT clocks are found based on their node name. If any
+ * additional con-id / dev-id -> clock mapping is required, use this
+ * function to list these.
+ */
+void __init omap_dt_clocks_register(struct omap_dt_clk oclks[])
+{
+	struct omap_dt_clk *c;
+
+	for (c = oclks; c->node_name != NULL; c++)
+		clk_add_alias(c->con_id, c->dev_id, c->node_name, NULL);
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 385384a..dee3234 100644
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
+ * struct omap_dt_clk - OMAP DT clock alias declarations
+ * @dev_id: alias device ID
+ * @conn_id: alias connection ID
+ * @node_name: clock DT node to map to
+ */
+struct omap_dt_clk {
+	const char			*dev_id;
+	const char			*con_id;
+	char				*node_name;
+};
+
+#define DT_CLK(dev, con, name)		\
+	{				\
+		.dev_id = dev,		\
+		.con_id = con,		\
+		.node_name = name,	\
+	}
+
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap3_noncore_dpll_enable(struct clk_hw *hw);
 void omap3_noncore_dpll_disable(struct clk_hw *hw);
@@ -158,6 +179,8 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
 
+void omap_dt_clocks_register(struct omap_dt_clk *oclks);
+
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 
-- 
1.7.9.5

