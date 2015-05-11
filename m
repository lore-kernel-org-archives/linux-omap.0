From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 03/27] clk: ti: move OMAP4+ DPLL implementation under drivers/clk
Date: Mon, 11 May 2015 11:54:29 +0300
Message-ID: <1431334493-24455-4-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49456 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbbEKIyt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2015 04:54:49 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

With the legacy clock support gone, the OMAP4 specific DPLL implementations
can be moved under the clock driver. Change some of the function prototypes
to be static at the same time, and remove some exports from the global TI
clock driver header.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile   |    6 +-
 arch/arm/mach-omap2/clock.h    |    4 -
 arch/arm/mach-omap2/dpll44xx.c |  232 ---------------------------------------
 drivers/clk/ti/Makefile        |    6 +-
 drivers/clk/ti/clock.h         |   14 +++
 drivers/clk/ti/dpll44xx.c      |  233 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h         |   13 +--
 7 files changed, 254 insertions(+), 254 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/dpll44xx.c
 create mode 100644 drivers/clk/ti/dpll44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fcb5d47..5bcd282 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -193,12 +193,12 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o clock36xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common)
-obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
-obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o
 obj-$(CONFIG_SOC_DRA7XX)		+= $(clock-common)
-obj-$(CONFIG_SOC_DRA7XX)		+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_DRA7XX)		+= dpll3xxx.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(clock-common) dpll3xxx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index ac21856..d7ed244 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -183,8 +183,6 @@ struct clksel {
 u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk);
 void omap3_dpll_allow_idle(struct clk_hw_omap *clk);
 void omap3_dpll_deny_idle(struct clk_hw_omap *clk);
-void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk);
-void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk);
 
 void __init omap2_clk_disable_clkdm_control(void);
 
@@ -204,8 +202,6 @@ int omap2_clksel_set_parent(struct clk_hw *hw, u8 field_val);
 extern void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
 extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
 
-unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
-
 void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
 				   void __iomem **other_reg,
 				   u8 *other_bit);
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
deleted file mode 100644
index f231be0..0000000
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ /dev/null
@@ -1,232 +0,0 @@
-/*
- * OMAP4-specific DPLL control functions
- *
- * Copyright (C) 2011 Texas Instruments, Inc.
- * Rajendra Nayak
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/bitops.h>
-
-#include "clock.h"
-
-/*
- * Maximum DPLL input frequency (FINT) and output frequency (FOUT) that
- * can supported when using the DPLL low-power mode. Frequencies are
- * defined in OMAP4430/60 Public TRM section 3.6.3.3.2 "Enable Control,
- * Status, and Low-Power Operation Mode".
- */
-#define OMAP4_DPLL_LP_FINT_MAX	1000000
-#define OMAP4_DPLL_LP_FOUT_MAX	100000000
-
-/*
- * Bitfield declarations
- */
-#define OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK		(1 << 8)
-#define OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK		(1 << 10)
-#define OMAP4430_DPLL_REGM4XEN_MASK			(1 << 11)
-
-/* Static rate multiplier for OMAP4 REGM4XEN clocks */
-#define OMAP4430_REGM4XEN_MULT				4
-
-void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk)
-{
-	u32 v;
-	u32 mask;
-
-	if (!clk || !clk->clksel_reg)
-		return;
-
-	mask = clk->flags & CLOCK_CLKOUTX2 ?
-			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
-			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
-
-	v = omap2_clk_readl(clk, clk->clksel_reg);
-	/* Clear the bit to allow gatectrl */
-	v &= ~mask;
-	omap2_clk_writel(v, clk, clk->clksel_reg);
-}
-
-void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk)
-{
-	u32 v;
-	u32 mask;
-
-	if (!clk || !clk->clksel_reg)
-		return;
-
-	mask = clk->flags & CLOCK_CLKOUTX2 ?
-			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
-			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
-
-	v = omap2_clk_readl(clk, clk->clksel_reg);
-	/* Set the bit to deny gatectrl */
-	v |= mask;
-	omap2_clk_writel(v, clk, clk->clksel_reg);
-}
-
-const struct clk_hw_omap_ops clkhwops_omap4_dpllmx = {
-	.allow_idle	= omap4_dpllmx_allow_gatectrl,
-	.deny_idle      = omap4_dpllmx_deny_gatectrl,
-};
-
-/**
- * omap4_dpll_lpmode_recalc - compute DPLL low-power setting
- * @dd: pointer to the dpll data structure
- *
- * Calculates if low-power mode can be enabled based upon the last
- * multiplier and divider values calculated. If low-power mode can be
- * enabled, then the bit to enable low-power mode is stored in the
- * last_rounded_lpmode variable. This implementation is based upon the
- * criteria for enabling low-power mode as described in the OMAP4430/60
- * Public TRM section 3.6.3.3.2 "Enable Control, Status, and Low-Power
- * Operation Mode".
- */
-static void omap4_dpll_lpmode_recalc(struct dpll_data *dd)
-{
-	long fint, fout;
-
-	fint = __clk_get_rate(dd->clk_ref) / (dd->last_rounded_n + 1);
-	fout = fint * dd->last_rounded_m;
-
-	if ((fint < OMAP4_DPLL_LP_FINT_MAX) && (fout < OMAP4_DPLL_LP_FOUT_MAX))
-		dd->last_rounded_lpmode = 1;
-	else
-		dd->last_rounded_lpmode = 0;
-}
-
-/**
- * omap4_dpll_regm4xen_recalc - compute DPLL rate, considering REGM4XEN bit
- * @clk: struct clk * of the DPLL to compute the rate for
- *
- * Compute the output rate for the OMAP4 DPLL represented by @clk.
- * Takes the REGM4XEN bit into consideration, which is needed for the
- * OMAP4 ABE DPLL.  Returns the DPLL's output rate (before M-dividers)
- * upon success, or 0 upon error.
- */
-unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
-			unsigned long parent_rate)
-{
-	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-	u32 v;
-	unsigned long rate;
-	struct dpll_data *dd;
-
-	if (!clk || !clk->dpll_data)
-		return 0;
-
-	dd = clk->dpll_data;
-
-	rate = omap2_get_dpll_rate(clk);
-
-	/* regm4xen adds a multiplier of 4 to DPLL calculations */
-	v = omap2_clk_readl(clk, dd->control_reg);
-	if (v & OMAP4430_DPLL_REGM4XEN_MASK)
-		rate *= OMAP4430_REGM4XEN_MULT;
-
-	return rate;
-}
-
-/**
- * omap4_dpll_regm4xen_round_rate - round DPLL rate, considering REGM4XEN bit
- * @clk: struct clk * of the DPLL to round a rate for
- * @target_rate: the desired rate of the DPLL
- *
- * Compute the rate that would be programmed into the DPLL hardware
- * for @clk if set_rate() were to be provided with the rate
- * @target_rate.  Takes the REGM4XEN bit into consideration, which is
- * needed for the OMAP4 ABE DPLL.  Returns the rounded rate (before
- * M-dividers) upon success, -EINVAL if @clk is null or not a DPLL, or
- * ~0 if an error occurred in omap2_dpll_round_rate().
- */
-long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
-				    unsigned long target_rate,
-				    unsigned long *parent_rate)
-{
-	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-	struct dpll_data *dd;
-	long r;
-
-	if (!clk || !clk->dpll_data)
-		return -EINVAL;
-
-	dd = clk->dpll_data;
-
-	dd->last_rounded_m4xen = 0;
-
-	/*
-	 * First try to compute the DPLL configuration for
-	 * target rate without using the 4X multiplier.
-	 */
-	r = omap2_dpll_round_rate(hw, target_rate, NULL);
-	if (r != ~0)
-		goto out;
-
-	/*
-	 * If we did not find a valid DPLL configuration, try again, but
-	 * this time see if using the 4X multiplier can help. Enabling the
-	 * 4X multiplier is equivalent to dividing the target rate by 4.
-	 */
-	r = omap2_dpll_round_rate(hw, target_rate / OMAP4430_REGM4XEN_MULT,
-				  NULL);
-	if (r == ~0)
-		return r;
-
-	dd->last_rounded_rate *= OMAP4430_REGM4XEN_MULT;
-	dd->last_rounded_m4xen = 1;
-
-out:
-	omap4_dpll_lpmode_recalc(dd);
-
-	return dd->last_rounded_rate;
-}
-
-/**
- * omap4_dpll_regm4xen_determine_rate - determine rate for a DPLL
- * @hw: pointer to the clock to determine rate for
- * @rate: target rate for the DPLL
- * @best_parent_rate: pointer for returning best parent rate
- * @best_parent_clk: pointer for returning best parent clock
- *
- * Determines which DPLL mode to use for reaching a desired rate.
- * Checks whether the DPLL shall be in bypass or locked mode, and if
- * locked, calculates the M,N values for the DPLL via round-rate.
- * Returns a positive clock rate with success, negative error value
- * in failure.
- */
-long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
-{
-	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-	struct dpll_data *dd;
-
-	if (!hw || !rate)
-		return -EINVAL;
-
-	dd = clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
-
-	if (__clk_get_rate(dd->clk_bypass) == rate &&
-	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
-	} else {
-		rate = omap4_dpll_regm4xen_round_rate(hw, rate,
-						      best_parent_rate);
-		*best_parent_clk = __clk_get_hw(dd->clk_ref);
-	}
-
-	*best_parent_rate = rate;
-
-	return rate;
-}
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 62dae2a..c3ec301 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -7,10 +7,10 @@ obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-816x.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clk-common) interface.o clk-2xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clk-common) interface.o \
 					   clk-3xxx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(clk-common) clk-44xx.o
-obj-$(CONFIG_SOC_OMAP5)			+= $(clk-common) clk-54xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(clk-common) clk-44xx.o dpll44xx.o
+obj-$(CONFIG_SOC_OMAP5)			+= $(clk-common) clk-54xx.o dpll44xx.o
 obj-$(CONFIG_SOC_DRA7XX)		+= $(clk-common) clk-7xx.o \
-					   clk-dra7-atl.o
+					   clk-dra7-atl.o dpll44xx.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(clk-common) clk-43xx.o
 
 ifdef CONFIG_ATAGS
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 05ed10a..c75d4b4 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -169,6 +169,20 @@ void ti_clk_patch_legacy_clks(struct ti_clk **patch);
 struct clk *ti_clk_register_clk(struct ti_clk *setup);
 int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
 
+extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
+
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 
+unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
+					 unsigned long parent_rate);
+long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
+				    unsigned long target_rate,
+				    unsigned long *parent_rate);
+long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
+					unsigned long *best_parent_rate,
+					struct clk_hw **best_parent_clk);
+
 #endif
diff --git a/drivers/clk/ti/dpll44xx.c b/drivers/clk/ti/dpll44xx.c
new file mode 100644
index 0000000..ef1a5b4
--- /dev/null
+++ b/drivers/clk/ti/dpll44xx.c
@@ -0,0 +1,233 @@
+/*
+ * OMAP4-specific DPLL control functions
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Rajendra Nayak
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/bitops.h>
+#include <linux/clk/ti.h>
+
+#include "clock.h"
+
+/*
+ * Maximum DPLL input frequency (FINT) and output frequency (FOUT) that
+ * can supported when using the DPLL low-power mode. Frequencies are
+ * defined in OMAP4430/60 Public TRM section 3.6.3.3.2 "Enable Control,
+ * Status, and Low-Power Operation Mode".
+ */
+#define OMAP4_DPLL_LP_FINT_MAX	1000000
+#define OMAP4_DPLL_LP_FOUT_MAX	100000000
+
+/*
+ * Bitfield declarations
+ */
+#define OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK		BIT(8)
+#define OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK		BIT(10)
+#define OMAP4430_DPLL_REGM4XEN_MASK			BIT(11)
+
+/* Static rate multiplier for OMAP4 REGM4XEN clocks */
+#define OMAP4430_REGM4XEN_MULT				4
+
+static void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk)
+{
+	u32 v;
+	u32 mask;
+
+	if (!clk || !clk->clksel_reg)
+		return;
+
+	mask = clk->flags & CLOCK_CLKOUTX2 ?
+			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
+			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+
+	v = ti_clk_ll_ops->clk_readl(clk->clksel_reg);
+	/* Clear the bit to allow gatectrl */
+	v &= ~mask;
+	ti_clk_ll_ops->clk_writel(v, clk->clksel_reg);
+}
+
+static void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk)
+{
+	u32 v;
+	u32 mask;
+
+	if (!clk || !clk->clksel_reg)
+		return;
+
+	mask = clk->flags & CLOCK_CLKOUTX2 ?
+			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
+			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+
+	v = ti_clk_ll_ops->clk_readl(clk->clksel_reg);
+	/* Set the bit to deny gatectrl */
+	v |= mask;
+	ti_clk_ll_ops->clk_writel(v, clk->clksel_reg);
+}
+
+const struct clk_hw_omap_ops clkhwops_omap4_dpllmx = {
+	.allow_idle	= omap4_dpllmx_allow_gatectrl,
+	.deny_idle      = omap4_dpllmx_deny_gatectrl,
+};
+
+/**
+ * omap4_dpll_lpmode_recalc - compute DPLL low-power setting
+ * @dd: pointer to the dpll data structure
+ *
+ * Calculates if low-power mode can be enabled based upon the last
+ * multiplier and divider values calculated. If low-power mode can be
+ * enabled, then the bit to enable low-power mode is stored in the
+ * last_rounded_lpmode variable. This implementation is based upon the
+ * criteria for enabling low-power mode as described in the OMAP4430/60
+ * Public TRM section 3.6.3.3.2 "Enable Control, Status, and Low-Power
+ * Operation Mode".
+ */
+static void omap4_dpll_lpmode_recalc(struct dpll_data *dd)
+{
+	long fint, fout;
+
+	fint = __clk_get_rate(dd->clk_ref) / (dd->last_rounded_n + 1);
+	fout = fint * dd->last_rounded_m;
+
+	if ((fint < OMAP4_DPLL_LP_FINT_MAX) && (fout < OMAP4_DPLL_LP_FOUT_MAX))
+		dd->last_rounded_lpmode = 1;
+	else
+		dd->last_rounded_lpmode = 0;
+}
+
+/**
+ * omap4_dpll_regm4xen_recalc - compute DPLL rate, considering REGM4XEN bit
+ * @clk: struct clk * of the DPLL to compute the rate for
+ *
+ * Compute the output rate for the OMAP4 DPLL represented by @clk.
+ * Takes the REGM4XEN bit into consideration, which is needed for the
+ * OMAP4 ABE DPLL.  Returns the DPLL's output rate (before M-dividers)
+ * upon success, or 0 upon error.
+ */
+unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	u32 v;
+	unsigned long rate;
+	struct dpll_data *dd;
+
+	if (!clk || !clk->dpll_data)
+		return 0;
+
+	dd = clk->dpll_data;
+
+	rate = omap2_get_dpll_rate(clk);
+
+	/* regm4xen adds a multiplier of 4 to DPLL calculations */
+	v = ti_clk_ll_ops->clk_readl(dd->control_reg);
+	if (v & OMAP4430_DPLL_REGM4XEN_MASK)
+		rate *= OMAP4430_REGM4XEN_MULT;
+
+	return rate;
+}
+
+/**
+ * omap4_dpll_regm4xen_round_rate - round DPLL rate, considering REGM4XEN bit
+ * @clk: struct clk * of the DPLL to round a rate for
+ * @target_rate: the desired rate of the DPLL
+ *
+ * Compute the rate that would be programmed into the DPLL hardware
+ * for @clk if set_rate() were to be provided with the rate
+ * @target_rate.  Takes the REGM4XEN bit into consideration, which is
+ * needed for the OMAP4 ABE DPLL.  Returns the rounded rate (before
+ * M-dividers) upon success, -EINVAL if @clk is null or not a DPLL, or
+ * ~0 if an error occurred in omap2_dpll_round_rate().
+ */
+long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
+				    unsigned long target_rate,
+				    unsigned long *parent_rate)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *dd;
+	long r;
+
+	if (!clk || !clk->dpll_data)
+		return -EINVAL;
+
+	dd = clk->dpll_data;
+
+	dd->last_rounded_m4xen = 0;
+
+	/*
+	 * First try to compute the DPLL configuration for
+	 * target rate without using the 4X multiplier.
+	 */
+	r = omap2_dpll_round_rate(hw, target_rate, NULL);
+	if (r != ~0)
+		goto out;
+
+	/*
+	 * If we did not find a valid DPLL configuration, try again, but
+	 * this time see if using the 4X multiplier can help. Enabling the
+	 * 4X multiplier is equivalent to dividing the target rate by 4.
+	 */
+	r = omap2_dpll_round_rate(hw, target_rate / OMAP4430_REGM4XEN_MULT,
+				  NULL);
+	if (r == ~0)
+		return r;
+
+	dd->last_rounded_rate *= OMAP4430_REGM4XEN_MULT;
+	dd->last_rounded_m4xen = 1;
+
+out:
+	omap4_dpll_lpmode_recalc(dd);
+
+	return dd->last_rounded_rate;
+}
+
+/**
+ * omap4_dpll_regm4xen_determine_rate - determine rate for a DPLL
+ * @hw: pointer to the clock to determine rate for
+ * @rate: target rate for the DPLL
+ * @best_parent_rate: pointer for returning best parent rate
+ * @best_parent_clk: pointer for returning best parent clock
+ *
+ * Determines which DPLL mode to use for reaching a desired rate.
+ * Checks whether the DPLL shall be in bypass or locked mode, and if
+ * locked, calculates the M,N values for the DPLL via round-rate.
+ * Returns a positive clock rate with success, negative error value
+ * in failure.
+ */
+long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
+					unsigned long *best_parent_rate,
+					struct clk_hw **best_parent_clk)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *dd;
+
+	if (!hw || !rate)
+		return -EINVAL;
+
+	dd = clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	if (__clk_get_rate(dd->clk_bypass) == rate &&
+	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
+		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
+	} else {
+		rate = omap4_dpll_regm4xen_round_rate(hw, rate,
+						      best_parent_rate);
+		*best_parent_clk = __clk_get_hw(dd->clk_ref);
+	}
+
+	*best_parent_rate = rate;
+
+	return rate;
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index f2436b2..89deddf 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -275,17 +275,6 @@ long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
 				       unsigned long max_rate,
 				       unsigned long *best_parent_rate,
 				       struct clk_hw **best_parent_clk);
-unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
-					 unsigned long parent_rate);
-long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
-				    unsigned long target_rate,
-				    unsigned long *parent_rate);
-long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
-					unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk);
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
 long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 			   unsigned long *parent_rate);
@@ -314,6 +303,7 @@ int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate,
 			     unsigned long parent_rate);
 void omap2xxx_clkt_dpllcore_init(struct clk_hw *hw);
 void omap2xxx_clkt_vps_init(void);
+unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
 
 void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
@@ -364,7 +354,6 @@ static inline void of_ti_clk_deny_autoidle_all(void) { }
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
-extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
-- 
1.7.9.5

