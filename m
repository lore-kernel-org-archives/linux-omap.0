From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 14/33] CLK: omap: add dra7 clock init file
Date: Tue, 23 Jul 2013 10:20:09 +0300
Message-ID: <1374564028-11352-15-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46729 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab3GWHWd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jul 2013 03:22:33 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

clk-7xx.c now contains the clock init functionality for dra7, including
DT clock registration and adding of static clkdev entries.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/omap/Makefile  |    2 +-
 drivers/clk/omap/clk-7xx.c |   67 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/omap/clk-7xx.c

diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
index 74385f2..b8dbfda 100644
--- a/drivers/clk/omap/Makefile
+++ b/drivers/clk/omap/Makefile
@@ -1,2 +1,2 @@
 obj-y					+= clk.o dpll.o autoidle.o gate.o \
-					   clk-44xx.o clk-54xx.o
+					   clk-44xx.o clk-54xx.o clk-7xx.o
diff --git a/drivers/clk/omap/clk-7xx.c b/drivers/clk/omap/clk-7xx.c
new file mode 100644
index 0000000..ddb39dd
--- /dev/null
+++ b/drivers/clk/omap/clk-7xx.c
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
+#include <linux/io.h>
+#include <linux/clk/omap.h>
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
+};
+
+int __init dra7xx_clk_init(void)
+{
+	int rc;
+	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck;
+
+	dt_omap_clk_init();
+
+	omap_dt_clocks_register(dra7xx_clks, ARRAY_SIZE(dra7xx_clks));
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

