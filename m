From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/18] OMAP2xxx clock: move sys_clk code into clkt2xxx_sys.c
Date: Fri, 15 Jan 2010 02:07:02 -0700
Message-ID: <20100115090701.30690.27321.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48737 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756510Ab0AOJIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:08:15 -0500
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move the sys_clk clock functions from clock2xxx.c to clkt2xxx_sys.c to
improve maintainability.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile         |    3 +-
 arch/arm/mach-omap2/clkt2xxx_sys.c   |   50 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock2xxx.c      |   30 --------------------
 arch/arm/mach-omap2/clock2xxx.h      |    3 +-
 arch/arm/mach-omap2/clock2xxx_data.c |    4 +--
 5 files changed, 55 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_sys.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 51178bf..7ce5fea 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -13,7 +13,8 @@ clock-common				= clock.o clock_common_data.o \
 					  clkt_clksel.o
 clock-omap2xxx				= clkt2xxx_dpllcore.o \
 					  clkt2xxx_virt_prcm_set.o \
-					  clkt2xxx_apll.o clkt2xxx_osc.o
+					  clkt2xxx_apll.o clkt2xxx_osc.o \
+					  clkt2xxx_sys.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
 			    $(clock-omap2xxx)
diff --git a/arch/arm/mach-omap2/clkt2xxx_sys.c b/arch/arm/mach-omap2/clkt2xxx_sys.c
new file mode 100644
index 0000000..4abd2ab
--- /dev/null
+++ b/arch/arm/mach-omap2/clkt2xxx_sys.c
@@ -0,0 +1,50 @@
+/*
+ * clkt2xxx_sys.c - OMAP2xxx sys_clk-specific clock code
+ *
+ * Copyright (C) 2005-2008 Texas Instruments, Inc.
+ * Copyright (C) 2004-2010 Nokia Corporation
+ *
+ * Contacts:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Paul Walmsley
+ *
+ * Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
+ * Gordon McNutt and RidgeRun, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+
+#include "clock.h"
+#include "clock2xxx.h"
+#include "prm.h"
+#include "prm-regbits-24xx.h"
+
+void __iomem *prcm_clksrc_ctrl;
+
+u32 omap2xxx_get_sysclkdiv(void)
+{
+	u32 div;
+
+	div = __raw_readl(prcm_clksrc_ctrl);
+	div &= OMAP_SYSCLKDIV_MASK;
+	div >>= OMAP_SYSCLKDIV_SHIFT;
+
+	return div;
+}
+
+unsigned long omap2xxx_sys_clk_recalc(struct clk *clk)
+{
+	return clk->parent->rate / omap2xxx_get_sysclkdiv();
+}
+
+
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 62c3b02..b59cb1d 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -46,8 +46,6 @@
 
 struct clk *vclk, *sclk, *dclk;
 
-void __iomem *prcm_clksrc_ctrl;
-
 /*-------------------------------------------------------------------------
  * Omap24xx specific clock functions
  *-------------------------------------------------------------------------*/
@@ -79,34 +77,6 @@ const struct clkops clkops_omap2430_i2chs_wait = {
 	.find_companion = omap2_clk_dflt_find_companion,
 };
 
-#ifdef OLD_CK
-/* Recalculate SYST_CLK */
-static void omap2_sys_clk_recalc(struct clk *clk)
-{
-	u32 div = PRCM_CLKSRC_CTRL;
-	div &= (1 << 7) | (1 << 6);	/* Test if ext clk divided by 1 or 2 */
-	div >>= clk->rate_offset;
-	clk->rate = (clk->parent->rate / div);
-	propagate_rate(clk);
-}
-#endif	/* OLD_CK */
-
-u32 omap2xxx_get_sysclkdiv(void)
-{
-	u32 div;
-
-	div = __raw_readl(prcm_clksrc_ctrl);
-	div &= OMAP_SYSCLKDIV_MASK;
-	div >>= OMAP_SYSCLKDIV_SHIFT;
-
-	return div;
-}
-
-unsigned long omap2_sys_clk_recalc(struct clk *clk)
-{
-	return clk->parent->rate / omap2xxx_get_sysclkdiv();
-}
-
 /*
  * Set clocks for bypass mode for reboot to work.
  */
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index 3b0610d..c14061b 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -11,9 +11,8 @@
 unsigned long omap2_table_mpu_recalc(struct clk *clk);
 int omap2_select_table_rate(struct clk *clk, unsigned long rate);
 long omap2_round_to_table_rate(struct clk *clk, unsigned long rate);
-unsigned long omap2_sys_clk_recalc(struct clk *clk);
+unsigned long omap2xxx_sys_clk_recalc(struct clk *clk);
 unsigned long omap2_osc_clk_recalc(struct clk *clk);
-unsigned long omap2_sys_clk_recalc(struct clk *clk);
 unsigned long omap2_dpllcore_recalc(struct clk *clk);
 int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
 unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
index 402115f..3a435bb 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -79,7 +79,7 @@ static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.ops		= &clkops_null,
 	.parent		= &osc_ck,
 	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &omap2_sys_clk_recalc,
+	.recalc		= &omap2xxx_sys_clk_recalc,
 };
 
 static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
@@ -2264,7 +2264,7 @@ int __init omap2_clk_init(void)
 
 	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
 	propagate_rate(&osc_ck);
-	sys_ck.rate = omap2_sys_clk_recalc(&sys_ck);
+	sys_ck.rate = omap2xxx_sys_clk_recalc(&sys_ck);
 	propagate_rate(&sys_ck);
 
 	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)


