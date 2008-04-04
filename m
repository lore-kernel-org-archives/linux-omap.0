From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] OMAP3 clock: add OMAP3 DPLL autoidle functions
Date: Thu, 03 Apr 2008 19:09:43 -0600
Message-ID: <20080404012634.210820854@pwsan.com>
References: <20080404010941.510844152@pwsan.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49317 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946AbYDDB2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 21:28:01 -0400
Content-Disposition: inline; filename=add_3430_dpll_autoidle.patch
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds support for DPLL autoidle control to the OMAP3 clock
framework.  These functions will be used by the noncore DPLL enable
and disable code - this is because, according to the CDP code, the
DPLL autoidle status must be saved and restored across DPLL
lock/bypass/off transitions.

N.B.: the CORE DPLL (DPLL3) has three autoidle mode options, rather
than just two.  This code currently does not support the third option,
low-power bypass autoidle.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock34xx.c       |   79 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock34xx.h       |   14 ++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h |    4 +
 arch/arm/mach-omap2/cm.h              |    1 
 include/asm-arm/arch-omap/clock.h     |    2 
 5 files changed, 100 insertions(+)

Index: linux-omap/arch/arm/mach-omap2/clock34xx.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.c	2008-03-28 00:40:23.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock34xx.c	2008-03-28 00:42:11.000000000 -0600
@@ -37,6 +37,10 @@
 #include "cm.h"
 #include "cm-regbits-34xx.h"
 
+/* CM_AUTOIDLE_PLL*.AUTO_* bit values */
+#define DPLL_AUTOIDLE_DISABLE			0x0
+#define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
+
 /* CM_CLKEN_PLL*.EN* bit values */
 #define DPLL_LOCKED		0x7
 
@@ -54,6 +58,81 @@
 }
 
 /**
+ * omap3_dpll_autoidle_read - read a DPLL's autoidle bits
+ * @clk: struct clk * of the DPLL to read
+ *
+ * Return the DPLL's autoidle bits, shifted down to bit 0.  Returns
+ * -EINVAL if passed a null pointer or if the struct clk does not
+ * appear to refer to a DPLL.
+ */
+static u32 omap3_dpll_autoidle_read(struct clk *clk)
+{
+	const struct dpll_data *dd;
+	u32 v;
+
+	if (!clk || !clk->dpll_data)
+		return -EINVAL;
+
+	dd = clk->dpll_data;
+
+	v = cm_read_reg(dd->autoidle_reg);
+	v &= dd->autoidle_mask;
+	v >>= __ffs(dd->autoidle_mask);
+
+	return v;
+}
+
+/**
+ * omap3_dpll_allow_idle - enable DPLL autoidle bits
+ * @clk: struct clk * of the DPLL to operate on
+ *
+ * Enable DPLL automatic idle control.  This automatic idle mode
+ * switching takes effect only when the DPLL is locked, at least on
+ * OMAP3430.  The DPLL will enter low-power stop when its downstream
+ * clocks are gated.  No return value.
+ */
+static void omap3_dpll_allow_idle(struct clk *clk)
+{
+	const struct dpll_data *dd;
+
+	if (!clk || !clk->dpll_data)
+		return;
+
+	dd = clk->dpll_data;
+
+	/*
+	 * REVISIT: CORE DPLL can optionally enter low-power bypass
+	 * by writing 0x5 instead of 0x1.  Add some mechanism to
+	 * optionally enter this mode.
+	 */
+	cm_rmw_reg_bits(dd->autoidle_mask,
+			DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask),
+			dd->autoidle_reg);
+}
+
+/**
+ * omap3_dpll_deny_idle - prevent DPLL from automatically idling
+ * @clk: struct clk * of the DPLL to operate on
+ *
+ * Disable DPLL automatic idle control.  No return value.
+ */
+static void omap3_dpll_deny_idle(struct clk *clk)
+{
+	const struct dpll_data *dd;
+
+	if (!clk || !clk->dpll_data)
+		return;
+
+	dd = clk->dpll_data;
+
+	cm_rmw_reg_bits(dd->autoidle_mask,
+ 			DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask),
+			dd->autoidle_reg);
+}
+
+
+
+/**
  * omap3_clkoutx2_recalc - recalculate DPLL X2 output virtual clock rate
  * @clk: DPLL output struct clk
  *
Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2008-03-28 00:42:08.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2008-03-28 00:42:11.000000000 -0600
@@ -29,6 +29,9 @@
 
 static void omap3_dpll_recalc(struct clk *clk);
 static void omap3_clkoutx2_recalc(struct clk *clk);
+static void omap3_dpll_allow_idle(struct clk *clk);
+static void omap3_dpll_deny_idle(struct clk *clk);
+static u32 omap3_dpll_autoidle_read(struct clk *clk);
 
 /*
  * DPLL1 supplies clock to the MPU.
@@ -254,6 +257,8 @@
 	.auto_recal_bit	= OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	= OMAP3430_MPU_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	= OMAP3430_MPU_DPLL_ST_SHIFT,
+	.autoidle_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL),
+	.autoidle_mask	= OMAP3430_AUTO_MPU_DPLL_MASK,
 };
 
 static struct clk dpll1_ck = {
@@ -311,6 +316,9 @@
 	.auto_recal_bit	= OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	= OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	= OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_SHIFT,
+	.autoidle_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_AUTOIDLE_PLL),
+	.autoidle_mask	= OMAP3430_AUTO_IVA2_DPLL_MASK,
+
 };
 
 static struct clk dpll2_ck = {
@@ -355,6 +363,8 @@
 	.auto_recal_bit	= OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	= OMAP3430_CORE_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	= OMAP3430_CORE_DPLL_ST_SHIFT,
+	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+	.autoidle_mask	= OMAP3430_AUTO_CORE_DPLL_MASK,
 };
 
 static struct clk dpll3_ck = {
@@ -527,6 +537,8 @@
 	.auto_recal_bit	= OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	= OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	= OMAP3430_PERIPH_DPLL_ST_SHIFT,
+	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
 };
 
 static struct clk dpll4_ck = {
@@ -818,6 +830,8 @@
 	.auto_recal_bit	= OMAP3430ES2_EN_PERIPH2_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	= OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	= OMAP3430ES2_SND_PERIPH_DPLL_ST_SHIFT,
+	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_AUTOIDLE2_PLL),
+	.autoidle_mask	= OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK,
 };
 
 static struct clk dpll5_ck = {
Index: linux-omap/arch/arm/mach-omap2/cm-regbits-34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-03-28 00:40:23.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-03-28 00:42:11.000000000 -0600
@@ -422,6 +422,10 @@
 #define OMAP3430_AUTO_CORE_DPLL_SHIFT			0
 #define OMAP3430_AUTO_CORE_DPLL_MASK			(0x7 << 0)
 
+/* CM_AUTOIDLE2_PLL */
+#define OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT		0
+#define OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK		(0x7 << 0)
+
 /* CM_CLKSEL1_PLL */
 /* Note that OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK was (0x3 << 27) on 3430ES1 */
 #define OMAP3430_CORE_DPLL_CLKOUT_DIV_SHIFT		27
Index: linux-omap/arch/arm/mach-omap2/cm.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/cm.h	2008-03-28 00:40:23.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/cm.h	2008-03-28 00:42:11.000000000 -0600
@@ -112,6 +112,7 @@
 #define OMAP3430ES2_CM_FCLKEN3				0x0008
 #define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
 #define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
+#define OMAP3430ES2_CM_AUTOIDLE2_PLL			CM_AUTOIDLE2
 #define OMAP3430_CM_CLKSEL1				CM_CLKSEL
 #define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
 #define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h	2008-03-28 00:40:23.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/clock.h	2008-03-28 00:42:11.000000000 -0600
@@ -41,6 +41,8 @@
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
+	void __iomem		*autoidle_reg;
+	u32			autoidle_mask;
 #  endif
 };
 

-- 

