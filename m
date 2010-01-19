From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 06/18] OMAP2xxx clock: move the DPLL+CORE composite clock
	code into mach-omap2/clkt2xxx_dpllcore.c
Date: Tue, 19 Jan 2010 16:36:06 -0700
Message-ID: <20100119233603.26047.97676.stgit@localhost.localdomain>
References: <20100119232900.26047.98263.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58609 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab0ASXid (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 18:38:33 -0500
In-Reply-To: <20100119232900.26047.98263.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexander Shishkin <virtuoso@slind.org>, Richard Woodruff <r-woodruff2@ti.com>

Move the DPLL+CORE composite clock functions from clock2xxx.c to
mach-omap2/clkt2xxx_dpllcore.c.  This is intended to make the clock
code easier to understand, since all of the functions needed to manage
the OMAP2 DPLL+CORE clock are now located in their own file, rather
than being mixed with other, unrelated functions.

Clock debugging is also now more finely-grained, since the DEBUG
macro can now be defined for the DPLL+CORE clock alone.  This
should reduce unnecessary console noise when debugging.

Also, if at some future point the mach-omap2/ directory is split
into OMAP2/3/4 variants, this clkt file can be placed in the mach-omap2xxx/
directory, rather than shared with other chip types that don't use this
clock type.

Thanks to Alexander Shishkin <virtuoso@slind.org> for his comments to
improve the patch description.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/mach-omap2/Makefile            |    4 +
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c |  173 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock2xxx.c         |  136 ------------------------
 3 files changed, 176 insertions(+), 137 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_dpllcore.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9ecc58d..04ce372 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,8 +11,10 @@ prcm-common				= prcm.o powerdomain.o
 clock-common				= clock.o clock_common_data.o \
 					  clockdomain.o clkt_dpll.o \
 					  clkt_clksel.o
+clock-omap2xxx				= clkt2xxx_dpllcore.o
 
-obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
+obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
+			    $(clock-omap2xxx)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
 			    $(omap-3-4-common)
 obj-$(CONFIG_ARCH_OMAP4) += $(omap-3-4-common) $(prcm-common) $(clock-common)
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
new file mode 100644
index 0000000..0190484
--- /dev/null
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -0,0 +1,173 @@
+/*
+ * DPLL + CORE_CLK composite clock functions
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
+ *
+ * XXX The DPLL and CORE clocks should be split into two separate clock
+ * types.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+#include <plat/sram.h>
+#include <plat/sdrc.h>
+
+#include "clock.h"
+#include "clock2xxx.h"
+#include "opp2xxx.h"
+#include "cm.h"
+#include "cm-regbits-24xx.h"
+
+/* #define DOWN_VARIABLE_DPLL 1 */		/* Experimental */
+
+/**
+ * omap2xxx_clk_get_core_rate - return the CORE_CLK rate
+ * @clk: pointer to the combined dpll_ck + core_ck (currently "dpll_ck")
+ *
+ * Returns the CORE_CLK rate.  CORE_CLK can have one of three rate
+ * sources on OMAP2xxx: the DPLL CLKOUT rate, DPLL CLKOUTX2, or 32KHz
+ * (the latter is unusual).  This currently should be called with
+ * struct clk *dpll_ck, which is a composite clock of dpll_ck and
+ * core_ck.
+ */
+unsigned long omap2xxx_clk_get_core_rate(struct clk *clk)
+{
+	long long core_clk;
+	u32 v;
+
+	core_clk = omap2_get_dpll_rate(clk);
+
+	v = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	v &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if (v == CORE_CLK_SRC_32K)
+		core_clk = 32768;
+	else
+		core_clk *= v;
+
+	return core_clk;
+}
+
+/*
+ * Uses the current prcm set to tell if a rate is valid.
+ * You can go slower, but not faster within a given rate set.
+ */
+static long omap2_dpllcore_round_rate(unsigned long target_rate)
+{
+	u32 high, low, core_clk_src;
+
+	core_clk_src = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	core_clk_src &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if (core_clk_src == CORE_CLK_SRC_DPLL) {	/* DPLL clockout */
+		high = curr_prcm_set->dpll_speed * 2;
+		low = curr_prcm_set->dpll_speed;
+	} else {				/* DPLL clockout x 2 */
+		high = curr_prcm_set->dpll_speed;
+		low = curr_prcm_set->dpll_speed / 2;
+	}
+
+#ifdef DOWN_VARIABLE_DPLL
+	if (target_rate > high)
+		return high;
+	else
+		return target_rate;
+#else
+	if (target_rate > low)
+		return high;
+	else
+		return low;
+#endif
+
+}
+
+unsigned long omap2_dpllcore_recalc(struct clk *clk)
+{
+	return omap2xxx_clk_get_core_rate(clk);
+}
+
+int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
+{
+	u32 cur_rate, low, mult, div, valid_rate, done_rate;
+	u32 bypass = 0;
+	struct prcm_config tmpset;
+	const struct dpll_data *dd;
+
+	cur_rate = omap2xxx_clk_get_core_rate(dclk);
+	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if ((rate == (cur_rate / 2)) && (mult == 2)) {
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
+	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
+	} else if (rate != cur_rate) {
+		valid_rate = omap2_dpllcore_round_rate(rate);
+		if (valid_rate != rate)
+			return -EINVAL;
+
+		if (mult == 1)
+			low = curr_prcm_set->dpll_speed;
+		else
+			low = curr_prcm_set->dpll_speed / 2;
+
+		dd = clk->dpll_data;
+		if (!dd)
+			return -EINVAL;
+
+		tmpset.cm_clksel1_pll = __raw_readl(dd->mult_div1_reg);
+		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
+					   dd->div1_mask);
+		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
+		tmpset.cm_clksel2_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
+		if (rate > low) {
+			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL_X2;
+			mult = ((rate / 2) / 1000000);
+			done_rate = CORE_CLK_SRC_DPLL_X2;
+		} else {
+			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL;
+			mult = (rate / 1000000);
+			done_rate = CORE_CLK_SRC_DPLL;
+		}
+		tmpset.cm_clksel1_pll |= (div << __ffs(dd->mult_mask));
+		tmpset.cm_clksel1_pll |= (mult << __ffs(dd->div1_mask));
+
+		/* Worst case */
+		tmpset.base_sdrc_rfr = SDRC_RFR_CTRL_BYPASS;
+
+		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
+			bypass = 1;
+
+		/* For omap2xxx_sdrc_init_params() */
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
+
+		/* Force dll lock mode */
+		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
+			       bypass);
+
+		/* Errata: ret dll entry state */
+		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
+		omap2xxx_sdrc_reprogram(done_rate, 0);
+	}
+
+	return 0;
+}
+
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index bef5574..419ae80 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -54,8 +54,6 @@
 #define APLLS_CLKIN_13MHZ		2
 #define APLLS_CLKIN_12MHZ		3
 
-/* #define DOWN_VARIABLE_DPLL 1 */		/* Experimental */
-
 const struct prcm_config *curr_prcm_set;
 const struct prcm_config *rate_table;
 
@@ -94,34 +92,6 @@ const struct clkops clkops_omap2430_i2chs_wait = {
 	.find_companion = omap2_clk_dflt_find_companion,
 };
 
-/**
- * omap2xxx_clk_get_core_rate - return the CORE_CLK rate
- * @clk: pointer to the combined dpll_ck + core_ck (currently "dpll_ck")
- *
- * Returns the CORE_CLK rate.  CORE_CLK can have one of three rate
- * sources on OMAP2xxx: the DPLL CLKOUT rate, DPLL CLKOUTX2, or 32KHz
- * (the latter is unusual).  This currently should be called with
- * struct clk *dpll_ck, which is a composite clock of dpll_ck and
- * core_ck.
- */
-unsigned long omap2xxx_clk_get_core_rate(struct clk *clk)
-{
-	long long core_clk;
-	u32 v;
-
-	core_clk = omap2_get_dpll_rate(clk);
-
-	v = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	v &= OMAP24XX_CORE_CLK_SRC_MASK;
-
-	if (v == CORE_CLK_SRC_32K)
-		core_clk = 32768;
-	else
-		core_clk *= v;
-
-	return core_clk;
-}
-
 static int omap2_enable_osc_ck(struct clk *clk)
 {
 	u32 pcc;
@@ -215,112 +185,6 @@ const struct clkops clkops_apll54 = {
 	.disable	= omap2_clk_apll_disable,
 };
 
-/*
- * Uses the current prcm set to tell if a rate is valid.
- * You can go slower, but not faster within a given rate set.
- */
-long omap2_dpllcore_round_rate(unsigned long target_rate)
-{
-	u32 high, low, core_clk_src;
-
-	core_clk_src = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	core_clk_src &= OMAP24XX_CORE_CLK_SRC_MASK;
-
-	if (core_clk_src == CORE_CLK_SRC_DPLL) {	/* DPLL clockout */
-		high = curr_prcm_set->dpll_speed * 2;
-		low = curr_prcm_set->dpll_speed;
-	} else {				/* DPLL clockout x 2 */
-		high = curr_prcm_set->dpll_speed;
-		low = curr_prcm_set->dpll_speed / 2;
-	}
-
-#ifdef DOWN_VARIABLE_DPLL
-	if (target_rate > high)
-		return high;
-	else
-		return target_rate;
-#else
-	if (target_rate > low)
-		return high;
-	else
-		return low;
-#endif
-
-}
-
-unsigned long omap2_dpllcore_recalc(struct clk *clk)
-{
-	return omap2xxx_clk_get_core_rate(clk);
-}
-
-int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
-{
-	u32 cur_rate, low, mult, div, valid_rate, done_rate;
-	u32 bypass = 0;
-	struct prcm_config tmpset;
-	const struct dpll_data *dd;
-
-	cur_rate = omap2xxx_clk_get_core_rate(dclk);
-	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
-
-	if ((rate == (cur_rate / 2)) && (mult == 2)) {
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
-	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
-	} else if (rate != cur_rate) {
-		valid_rate = omap2_dpllcore_round_rate(rate);
-		if (valid_rate != rate)
-			return -EINVAL;
-
-		if (mult == 1)
-			low = curr_prcm_set->dpll_speed;
-		else
-			low = curr_prcm_set->dpll_speed / 2;
-
-		dd = clk->dpll_data;
-		if (!dd)
-			return -EINVAL;
-
-		tmpset.cm_clksel1_pll = __raw_readl(dd->mult_div1_reg);
-		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
-					   dd->div1_mask);
-		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
-		tmpset.cm_clksel2_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
-		if (rate > low) {
-			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL_X2;
-			mult = ((rate / 2) / 1000000);
-			done_rate = CORE_CLK_SRC_DPLL_X2;
-		} else {
-			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL;
-			mult = (rate / 1000000);
-			done_rate = CORE_CLK_SRC_DPLL;
-		}
-		tmpset.cm_clksel1_pll |= (div << __ffs(dd->mult_mask));
-		tmpset.cm_clksel1_pll |= (mult << __ffs(dd->div1_mask));
-
-		/* Worst case */
-		tmpset.base_sdrc_rfr = SDRC_RFR_CTRL_BYPASS;
-
-		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
-			bypass = 1;
-
-		/* For omap2xxx_sdrc_init_params() */
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
-
-		/* Force dll lock mode */
-		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
-			       bypass);
-
-		/* Errata: ret dll entry state */
-		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
-		omap2xxx_sdrc_reprogram(done_rate, 0);
-	}
-
-	return 0;
-}
-
 /**
  * omap2_table_mpu_recalc - just return the MPU speed
  * @clk: virt_prcm_set struct clk


