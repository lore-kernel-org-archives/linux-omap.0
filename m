From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 10/31] CLK: TI: add omap5 clock init file
Date: Fri, 2 Aug 2013 19:25:29 +0300
Message-ID: <1375460751-23676-11-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56718 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835Ab3HBQ0z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:26:55 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

clk-54xx.c now contains the clock init functionality for omap5, including
DT clock registration and adding of static clkdev entries.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c  |    1 +
 drivers/clk/ti/Makefile   |    2 +-
 drivers/clk/ti/clk-54xx.c |   59 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h    |    2 ++
 4 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/ti/clk-54xx.c

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4a3f06f..e8d5d75 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -650,6 +650,7 @@ void __init omap5_init_early(void)
 	omap54xx_clockdomains_init();
 	omap54xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_clk_init = omap5xxx_clk_init;
 }
 #endif
 
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index c2b6a44..e54f6f7 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,4 +1,4 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o gate.o \
-					   clk-44xx.o
+					   clk-44xx.o clk-54xx.o
 endif
diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
new file mode 100644
index 0000000..52133e7
--- /dev/null
+++ b/drivers/clk/ti/clk-54xx.c
@@ -0,0 +1,59 @@
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
+#include <linux/clk/ti.h>
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
+	{ NULL },
+};
+
+int __init omap5xxx_clk_init(void)
+{
+	int rc;
+	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck;
+
+	of_clk_init(NULL);
+
+	omap_dt_clocks_register(omap54xx_clks);
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
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index c4f0c1b..59df9f6 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -194,6 +194,8 @@ static inline void of_omap_clk_allow_autoidle_all(void) { }
 static inline void of_omap_clk_deny_autoidle_all(void) { }
 #endif
 
+int omap5xxx_clk_init(void);
+
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_wait;
-- 
1.7.9.5

