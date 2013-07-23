From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 12/33] CLK: omap: add omap5 clock init file
Date: Tue, 23 Jul 2013 10:20:07 +0300
Message-ID: <1374564028-11352-13-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33483 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061Ab3GWHWb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:22:31 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

clk-54xx.c now contains the clock init functionality for omap5, including
DT clock registration and adding of static clkdev entries.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/omap/Makefile   |    2 +-
 drivers/clk/omap/clk-54xx.c |   58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/omap/clk-54xx.c

diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
index 9ad10be..74385f2 100644
--- a/drivers/clk/omap/Makefile
+++ b/drivers/clk/omap/Makefile
@@ -1,2 +1,2 @@
 obj-y					+= clk.o dpll.o autoidle.o gate.o \
-					   clk-44xx.o
+					   clk-44xx.o clk-54xx.o
diff --git a/drivers/clk/omap/clk-54xx.c b/drivers/clk/omap/clk-54xx.c
new file mode 100644
index 0000000..ade0481
--- /dev/null
+++ b/drivers/clk/omap/clk-54xx.c
@@ -0,0 +1,58 @@
+/*
+ * OMAP5 Clock init
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
+#define OMAP5_DPLL_ABE_DEFFREQ				98304000
+
+static struct omap_dt_clk omap54xx_clks[] = {
+	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
+	DT_CLK("omap_timer.1", "sys_ck", "sys_clkin"),
+	DT_CLK("omap_timer.2", "sys_ck", "sys_clkin"),
+	DT_CLK("omap_timer.3", "sys_ck", "sys_clkin"),
+	DT_CLK("omap_timer.4", "sys_ck", "sys_clkin"),
+	DT_CLK("omap_timer.9", "sys_ck", "sys_clkin"),
+	DT_CLK("omap_timer.10", "sys_ck", "sys_clkin"),
+	DT_CLK("omap_timer.11", "sys_ck", "sys_clkin"),
+	DT_CLK("omap_timer.5", "sys_ck", "dss_syc_gfclk_div"),
+	DT_CLK("omap_timer.6", "sys_ck", "dss_syc_gfclk_div"),
+	DT_CLK("omap_timer.7", "sys_ck", "dss_syc_gfclk_div"),
+	DT_CLK("omap_timer.8", "sys_ck", "dss_syc_gfclk_div"),
+};
+
+int __init omap5xxx_clk_init(void)
+{
+	int rc;
+	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck;
+
+	dt_omap_clk_init();
+
+	omap_dt_clocks_register(omap54xx_clks, ARRAY_SIZE(omap54xx_clks));
+
+	omap2_clk_disable_autoidle_all();
+
+	abe_dpll_ref = clk_get_sys(NULL, "abe_dpll_clk_mux");
+	sys_32k_ck = clk_get_sys(NULL, "sys_32k_ck");
+	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
+	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
+	if (!rc)
+		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
+
+	return 0;
+}
-- 
1.7.9.5

