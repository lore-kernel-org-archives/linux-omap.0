From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv13 01/40] CLK: TI: add DT alias clock registration mechanism
Date: Thu, 9 Jan 2014 16:00:12 +0200
Message-ID: <1389276051-1326-2-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46834 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbaAIOBl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 09:01:41 -0500
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Some devices require their clocks to be available with a specific
dev-id con-id mapping. With DT, the clocks can be found by default
only with their name, or alternatively through the device node of
the consumer. With drivers, that don't support DT fully yet, add
mechanism to register specific clock names.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/Makefile    |    1 +
 drivers/clk/ti/Makefile |    3 +++
 drivers/clk/ti/clk.c    |   55 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h  |   42 ++++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+)
 create mode 100644 drivers/clk/ti/Makefile
 create mode 100644 drivers/clk/ti/clk.c
 create mode 100644 include/linux/clk/ti.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7a10bc9..c61f768 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
 obj-$(CONFIG_COMMON_CLK_XGENE)  += clk-xgene.o
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
+obj-$(CONFIG_ARCH_OMAP)		+= ti/
 
 obj-$(CONFIG_X86)		+= x86/
 
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
new file mode 100644
index 0000000..1825f7f
--- /dev/null
+++ b/drivers/clk/ti/Makefile
@@ -0,0 +1,3 @@
+ifneq ($(CONFIG_OF),)
+obj-y					+= clk.o
+endif
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
new file mode 100644
index 0000000..ef1a7cd
--- /dev/null
+++ b/drivers/clk/ti/clk.c
@@ -0,0 +1,55 @@
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
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+/**
+ * ti_dt_clocks_register - register DT alias clocks during boot
+ * @oclks: list of clocks to register
+ *
+ * Register alias or non-standard DT clock entries during boot. By
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
+			pr_warn("failed to lookup clock node %s\n",
+				c->node_name);
+		}
+	}
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
new file mode 100644
index 0000000..df94c24
--- /dev/null
+++ b/include/linux/clk/ti.h
@@ -0,0 +1,42 @@
+/*
+ * TI clock drivers support
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
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
+#ifndef __LINUX_CLK_TI_H__
+#define __LINUX_CLK_TI_H__
+
+#include <linux/clkdev.h>
+
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
+
+void ti_dt_clocks_register(struct ti_dt_clk *oclks);
+
+#endif
-- 
1.7.9.5

