From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/18] OMAP2xxx clock: move osc_clk code into clkt2xxx_osc.c
Date: Fri, 15 Jan 2010 02:07:01 -0700
Message-ID: <20100115090700.30690.1593.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48735 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab0AOJIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:08:14 -0500
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move the osc_clk clock functions from clock2xxx.c to clkt2xxx_osc.c to
improve maintainability.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile       |    2 +
 arch/arm/mach-omap2/clkt2xxx_osc.c |   62 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock2xxx.c    |   34 +-------------------
 arch/arm/mach-omap2/clock2xxx.h    |    1 +
 4 files changed, 66 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_osc.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 825c303..51178bf 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -13,7 +13,7 @@ clock-common				= clock.o clock_common_data.o \
 					  clkt_clksel.o
 clock-omap2xxx				= clkt2xxx_dpllcore.o \
 					  clkt2xxx_virt_prcm_set.o \
-					  clkt2xxx_apll.o
+					  clkt2xxx_apll.o clkt2xxx_osc.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
 			    $(clock-omap2xxx)
diff --git a/arch/arm/mach-omap2/clkt2xxx_osc.c b/arch/arm/mach-omap2/clkt2xxx_osc.c
new file mode 100644
index 0000000..1b31e02
--- /dev/null
+++ b/arch/arm/mach-omap2/clkt2xxx_osc.c
@@ -0,0 +1,62 @@
+/*
+ * clkt2xxx_osc.c - OMAP2xxx osc_clk-specific clock code
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
+#include <linux/module.h>
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
+static int omap2_enable_osc_ck(struct clk *clk)
+{
+	u32 pcc;
+
+	pcc = __raw_readl(prcm_clksrc_ctrl);
+
+	__raw_writel(pcc & ~OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
+
+	return 0;
+}
+
+static void omap2_disable_osc_ck(struct clk *clk)
+{
+	u32 pcc;
+
+	pcc = __raw_readl(prcm_clksrc_ctrl);
+
+	__raw_writel(pcc | OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
+}
+
+const struct clkops clkops_oscck = {
+	.enable		= omap2_enable_osc_ck,
+	.disable	= omap2_disable_osc_ck,
+};
+
+unsigned long omap2_osc_clk_recalc(struct clk *clk)
+{
+	return omap2xxx_get_apll_clkin() * omap2xxx_get_sysclkdiv();
+}
+
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 88077e7..62c3b02 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -79,31 +79,6 @@ const struct clkops clkops_omap2430_i2chs_wait = {
 	.find_companion = omap2_clk_dflt_find_companion,
 };
 
-static int omap2_enable_osc_ck(struct clk *clk)
-{
-	u32 pcc;
-
-	pcc = __raw_readl(prcm_clksrc_ctrl);
-
-	__raw_writel(pcc & ~OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
-
-	return 0;
-}
-
-static void omap2_disable_osc_ck(struct clk *clk)
-{
-	u32 pcc;
-
-	pcc = __raw_readl(prcm_clksrc_ctrl);
-
-	__raw_writel(pcc | OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
-}
-
-const struct clkops clkops_oscck = {
-	.enable		= omap2_enable_osc_ck,
-	.disable	= omap2_disable_osc_ck,
-};
-
 #ifdef OLD_CK
 /* Recalculate SYST_CLK */
 static void omap2_sys_clk_recalc(struct clk *clk)
@@ -116,7 +91,7 @@ static void omap2_sys_clk_recalc(struct clk *clk)
 }
 #endif	/* OLD_CK */
 
-static u32 omap2_get_sysclkdiv(void)
+u32 omap2xxx_get_sysclkdiv(void)
 {
 	u32 div;
 
@@ -127,14 +102,9 @@ static u32 omap2_get_sysclkdiv(void)
 	return div;
 }
 
-unsigned long omap2_osc_clk_recalc(struct clk *clk)
-{
-	return omap2xxx_get_apll_clkin() * omap2_get_sysclkdiv();
-}
-
 unsigned long omap2_sys_clk_recalc(struct clk *clk)
 {
-	return clk->parent->rate / omap2_get_sysclkdiv();
+	return clk->parent->rate / omap2xxx_get_sysclkdiv();
 }
 
 /*
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index 3f1672e..3b0610d 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -18,6 +18,7 @@ unsigned long omap2_dpllcore_recalc(struct clk *clk);
 int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
 unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
 u32 omap2xxx_get_apll_clkin(void);
+u32 omap2xxx_get_sysclkdiv(void);
 
 /* REVISIT: These should be set dynamically for CONFIG_MULTI_OMAP2 */
 #ifdef CONFIG_ARCH_OMAP2420


