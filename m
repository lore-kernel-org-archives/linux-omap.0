From: Tero Kristo <t-kristo@TI.COM>
Subject: [PATCHv5 17/31] CLK: TI: add dra7 clock init file
Date: Fri, 2 Aug 2013 19:25:36 +0300
Message-ID: <1375460751-23676-18-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56737 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab3HBQ1P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:27:15 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@TI.COM, rnayak@TI.COM, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

clk-7xx.c now contains the clock init functionality for dra7, including
DT clock registration and adding of static clkdev entries.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/Makefile  |    3 ++-
 drivers/clk/ti/clk-7xx.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/ti/clk-7xx.c

diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index a75b9da..54969b9 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,4 +1,5 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o gate.o \
-					   apll.o clk-44xx.o clk-54xx.o
+					   apll.o clk-44xx.o clk-54xx.o \
+					   clk-7xx.o
 endif
diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
new file mode 100644
index 0000000..a00a9d7
--- /dev/null
+++ b/drivers/clk/ti/clk-7xx.c
@@ -0,0 +1,67 @@
+/*
+ * DRA7 Clock init
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * Tero Kristo (t-kristo@ti.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/clk-private.h>
+#include <linux/clkdev.h>
+#include <linux/clk/ti.h>
+
+#define DRA7_DPLL_ABE_DEFFREQ				361267200
+#define DRA7_DPLL_GMAC_DEFFREQ				1000000000
+
+
+static struct omap_dt_clk dra7xx_clks[] = {
+	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
+	DT_CLK("4ae18000.timer", "timer_sys_ck", "sys_clkin2"),
+	DT_CLK("48032000.timer", "timer_sys_ck", "sys_clkin2"),
+	DT_CLK("48034000.timer", "timer_sys_ck", "sys_clkin2"),
+	DT_CLK("48036000.timer", "timer_sys_ck", "sys_clkin2"),
+	DT_CLK("4803e000.timer", "timer_sys_ck", "sys_clkin2"),
+	DT_CLK("48086000.timer", "timer_sys_ck", "sys_clkin2"),
+	DT_CLK("48088000.timer", "timer_sys_ck", "sys_clkin2"),
+	DT_CLK("48820000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("48822000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("48824000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("48826000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK(NULL, "sys_clkin", "sys_clkin1"),
+	{ NULL },
+};
+
+int __init dra7xx_clk_init(void)
+{
+	int rc;
+	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck;
+
+	of_clk_init(NULL);
+
+	omap_dt_clocks_register(dra7xx_clks);
+
+	omap2_clk_disable_autoidle_all();
+
+	abe_dpll_mux = clk_get_sys(NULL, "abe_dpll_sys_clk_mux");
+	sys_clkin2 = clk_get_sys(NULL, "sys_clkin2");
+	dpll_ck = clk_get_sys(NULL, "dpll_abe_ck");
+
+	rc = clk_set_parent(abe_dpll_mux, sys_clkin2);
+	if (!rc)
+		rc = clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
+
+	dpll_ck = clk_get_sys(NULL, "dpll_gmac_ck");
+	rc = clk_set_rate(dpll_ck, DRA7_DPLL_GMAC_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure GMAC DPLL!\n", __func__);
+
+	return rc;
+}
-- 
1.7.9.5

