From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/8] OMAP2/3 clock: split, rename omap2_wait_clock_ready()
Date: Fri, 24 Jul 2009 20:11:30 -0600
Message-ID: <20090725021129.29059.22956.stgit@localhost.localdomain>
References: <20090725021102.29059.94214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50660 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147AbZGYCND (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 22:13:03 -0400
In-Reply-To: <20090725021102.29059.94214.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Some OMAP2/3 hardware modules have CM_IDLEST attributes that are not
handled by the current omap2_wait_clock_ready() code.  In preparation
for patches that fix the unusual devices, rename the function
omap2_wait_clock_ready() to omap2_wait_module_ready() and split it
into three parts:

1. A clkops-specific companion clock return function (by default,
   omap2_clk_dflt_find_companion())

2. A clkops-specific CM_IDLEST register address and bit shift return
   function (by default, omap2_clk_dflt_find_idlest())

3. Code to wait for the CM to indicate that the module is ready
   (omap2_cm_wait_idlest())

Clocks can now specify their own custom find_companion() and find_idlest()
functions; used in subsequent patches.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c             |  156 ++++++++++++++++---------------
 arch/arm/mach-omap2/clock.h             |    6 +
 arch/arm/mach-omap2/prcm.c              |   43 +++++++++
 arch/arm/plat-omap/include/mach/clock.h |    2 
 arch/arm/plat-omap/include/mach/prcm.h  |    1 
 5 files changed, 131 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index b0665f1..456e2ad 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -27,6 +27,7 @@
 #include <mach/clock.h>
 #include <mach/clockdomain.h>
 #include <mach/cpu.h>
+#include <mach/prcm.h>
 #include <asm/div64.h>
 
 #include <mach/sdrc.h>
@@ -38,8 +39,6 @@
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
 
-#define MAX_CLOCK_ENABLE_WAIT		100000
-
 /* DPLL rate rounding: minimum DPLL multiplier, divider values */
 #define DPLL_MIN_MULTIPLIER		1
 #define DPLL_MIN_DIVIDER		1
@@ -274,83 +273,97 @@ unsigned long omap2_fixed_divisor_recalc(struct clk *clk)
 }
 
 /**
- * omap2_wait_clock_ready - wait for clock to enable
- * @reg: physical address of clock IDLEST register
- * @mask: value to mask against to determine if the clock is active
- * @name: name of the clock (for printk)
+ * omap2_clk_dflt_find_companion - find companion clock to @clk
+ * @clk: struct clk * to find the companion clock of
+ * @other_reg: void __iomem ** to return the companion clock CM_*CLKEN va in
+ * @other_bit: u8 ** to return the companion clock bit shift in
+ *
+ * Note: We don't need special code here for INVERT_ENABLE for the
+ * time being since INVERT_ENABLE only applies to clocks enabled by
+ * CM_CLKEN_PLL
  *
- * Returns 1 if the clock enabled in time, or 0 if it failed to enable
- * in roughly MAX_CLOCK_ENABLE_WAIT microseconds.
+ * Convert CM_ICLKEN* <-> CM_FCLKEN*.  This conversion assumes it's
+ * just a matter of XORing the bits.
+ *
+ * Some clocks don't have companion clocks.  For example, modules with
+ * only an interface clock (such as MAILBOXES) don't have a companion
+ * clock.  Right now, this code relies on the hardware exporting a bit
+ * in the correct companion register that indicates that the
+ * nonexistent 'companion clock' is active.  Future patches will
+ * associate this type of code with per-module data structures to
+ * avoid this issue, and remove the casts.  No return value.
  */
-int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
+void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
+				   u8 *other_bit)
 {
-	int i = 0;
-	int ena = 0;
+	u32 r;
 
 	/*
-	 * 24xx uses 0 to indicate not ready, and 1 to indicate ready.
-	 * 34xx reverses this, just to keep us on our toes
+	 * Convert CM_ICLKEN* <-> CM_FCLKEN*.  This conversion assumes
+	 * it's just a matter of XORing the bits.
 	 */
-	if (cpu_mask & (RATE_IN_242X | RATE_IN_243X))
-		ena = mask;
-	else if (cpu_mask & RATE_IN_343X)
-		ena = 0;
-
-	/* Wait for lock */
-	while (((__raw_readl(reg) & mask) != ena) &&
-	       (i++ < MAX_CLOCK_ENABLE_WAIT)) {
-		udelay(1);
-	}
-
-	if (i <= MAX_CLOCK_ENABLE_WAIT)
-		pr_debug("Clock %s stable after %d loops\n", name, i);
-	else
-		printk(KERN_ERR "Clock %s didn't enable in %d tries\n",
-		       name, MAX_CLOCK_ENABLE_WAIT);
-
-
-	return (i < MAX_CLOCK_ENABLE_WAIT) ? 1 : 0;
-};
+	r = ((__force u32)clk->enable_reg ^ (CM_FCLKEN ^ CM_ICLKEN));
 
+	*other_reg = (__force void __iomem *)r;
+	*other_bit = clk->enable_bit;
+}
 
-/*
- * Note: We don't need special code here for INVERT_ENABLE
- * for the time being since INVERT_ENABLE only applies to clocks enabled by
- * CM_CLKEN_PLL
+/**
+ * omap2_clk_dflt_find_idlest - find CM_IDLEST reg va, bit shift for @clk
+ * @clk: struct clk * to find IDLEST info for
+ * @idlest_reg: void __iomem ** to return the CM_IDLEST va in
+ * @idlest_bit: u8 ** to return the CM_IDLEST bit shift in
+ *
+ * Return the CM_IDLEST register address and bit shift corresponding
+ * to the module that "owns" this clock.  This default code assumes
+ * that the CM_IDLEST bit shift is the CM_*CLKEN bit shift, and that
+ * the IDLEST register address ID corresponds to the CM_*CLKEN
+ * register address ID (e.g., that CM_FCLKEN2 corresponds to
+ * CM_IDLEST2).  This is not true for all modules.  No return value.
  */
-static void omap2_clk_wait_ready(struct clk *clk)
+void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
+				u8 *idlest_bit)
 {
-	void __iomem *reg, *other_reg, *st_reg;
-	u32 bit;
+	u32 r;
 
-	/*
-	 * REVISIT: This code is pretty ugly.  It would be nice to generalize
-	 * it and pull it into struct clk itself somehow.
-	 */
-	reg = clk->enable_reg;
+	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+	*idlest_reg = (__force void __iomem *)r;
+	*idlest_bit = clk->enable_bit;
+}
 
-	/*
-	 * Convert CM_ICLKEN* <-> CM_FCLKEN*.  This conversion assumes
-	 * it's just a matter of XORing the bits.
-	 */
-	other_reg = (void __iomem *)((u32)reg ^ (CM_FCLKEN ^ CM_ICLKEN));
+/**
+ * omap2_module_wait_ready - wait for an OMAP module to leave IDLE
+ * @clk: struct clk * belonging to the module
+ *
+ * If the necessary clocks for the OMAP hardware IP block that
+ * corresponds to clock @clk are enabled, then wait for the module to
+ * indicate readiness (i.e., to leave IDLE).  This code does not
+ * belong in the clock code and will be moved in the medium term to
+ * module-dependent code.  No return value.
+ */
+static void omap2_module_wait_ready(struct clk *clk)
+{
+	void __iomem *companion_reg, *idlest_reg;
+	u8 other_bit, idlest_bit;
+
+	/* Not all modules have multiple clocks that their IDLEST depends on */
+	if (clk->ops->find_companion) {
+		clk->ops->find_companion(clk, &companion_reg, &other_bit);
+		if (!(__raw_readl(companion_reg) & (1 << other_bit)))
+			return;
+	}
 
-	/* Check if both functional and interface clocks
-	 * are running. */
-	bit = 1 << clk->enable_bit;
-	if (!(__raw_readl(other_reg) & bit))
-		return;
-	st_reg = (void __iomem *)(((u32)other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
+	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit);
 
-	omap2_wait_clock_ready(st_reg, bit, clk->name);
+	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), clk->name);
 }
 
-static int omap2_dflt_clk_enable(struct clk *clk)
+int omap2_dflt_clk_enable(struct clk *clk)
 {
 	u32 v;
 
 	if (unlikely(clk->enable_reg == NULL)) {
-		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
+		pr_err("clock.c: Enable for %s without enable code\n",
 		       clk->name);
 		return 0; /* REVISIT: -EINVAL */
 	}
@@ -363,26 +376,13 @@ static int omap2_dflt_clk_enable(struct clk *clk)
 	__raw_writel(v, clk->enable_reg);
 	v = __raw_readl(clk->enable_reg); /* OCP barrier */
 
-	return 0;
-}
+	if (clk->ops->find_idlest)
+		omap2_module_wait_ready(clk);
 
-static int omap2_dflt_clk_enable_wait(struct clk *clk)
-{
-	int ret;
-
-	if (!clk->enable_reg) {
-		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
-		       clk->name);
-		return 0; /* REVISIT: -EINVAL */
-	}
-
-	ret = omap2_dflt_clk_enable(clk);
-	if (ret == 0)
-		omap2_clk_wait_ready(clk);
-	return ret;
+	return 0;
 }
 
-static void omap2_dflt_clk_disable(struct clk *clk)
+void omap2_dflt_clk_disable(struct clk *clk)
 {
 	u32 v;
 
@@ -406,8 +406,10 @@ static void omap2_dflt_clk_disable(struct clk *clk)
 }
 
 const struct clkops clkops_omap2_dflt_wait = {
-	.enable		= omap2_dflt_clk_enable_wait,
+	.enable		= omap2_dflt_clk_enable,
 	.disable	= omap2_dflt_clk_disable,
+	.find_companion	= omap2_clk_dflt_find_companion,
+	.find_idlest	= omap2_clk_dflt_find_idlest,
 };
 
 const struct clkops clkops_omap2_dflt = {
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 2679ddf..9ae7540 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -65,6 +65,12 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 u32 omap2_get_dpll_rate(struct clk *clk);
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
 void omap2_clk_prepare_for_reboot(void);
+int omap2_dflt_clk_enable(struct clk *clk);
+void omap2_dflt_clk_disable(struct clk *clk);
+void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
+				   u8 *other_bit);
+void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
+				u8 *idlest_bit);
 
 extern const struct clkops clkops_omap2_dflt_wait;
 extern const struct clkops clkops_omap2_dflt;
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index f945156..ced555a 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include <mach/common.h>
 #include <mach/prcm.h>
@@ -28,6 +29,8 @@
 static void __iomem *prm_base;
 static void __iomem *cm_base;
 
+#define MAX_MODULE_ENABLE_WAIT		100000
+
 u32 omap_prcm_get_reset_sources(void)
 {
 	/* XXX This presumably needs modification for 34XX */
@@ -120,6 +123,46 @@ u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
 }
 EXPORT_SYMBOL(cm_rmw_mod_reg_bits);
 
+/**
+ * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module readiness
+ * @reg: physical address of module IDLEST register
+ * @mask: value to mask against to determine if the module is active
+ * @name: name of the clock (for printk)
+ *
+ * Returns 1 if the module indicated readiness in time, or 0 if it
+ * failed to enable in roughly MAX_MODULE_ENABLE_WAIT microseconds.
+ */
+int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name)
+{
+	int i = 0;
+	int ena = 0;
+
+	/*
+	 * 24xx uses 0 to indicate not ready, and 1 to indicate ready.
+	 * 34xx reverses this, just to keep us on our toes
+	 */
+	if (cpu_is_omap24xx())
+		ena = mask;
+	else if (cpu_is_omap34xx())
+		ena = 0;
+	else
+		BUG();
+
+	/* Wait for lock */
+	while (((__raw_readl(reg) & mask) != ena) &&
+	       (i++ < MAX_MODULE_ENABLE_WAIT))
+		udelay(1);
+
+	if (i < MAX_MODULE_ENABLE_WAIT)
+		pr_debug("cm: Module associated with clock %s ready after %d "
+			 "loops\n", name, i);
+	else
+		pr_err("cm: Module associated with clock %s didn't enable in "
+		       "%d tries\n", name, MAX_MODULE_ENABLE_WAIT);
+
+	return (i < MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
+};
+
 void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 {
 	prm_base = omap2_globals->prm;
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index f9f65e1..4b8b0d6 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -20,6 +20,8 @@ struct clockdomain;
 struct clkops {
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
+	void			(*find_idlest)(struct clk *, void __iomem **, u8 *);
+	void			(*find_companion)(struct clk *, void __iomem **, u8 *);
 };
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
diff --git a/arch/arm/plat-omap/include/mach/prcm.h b/arch/arm/plat-omap/include/mach/prcm.h
index 24ac3c7..cda2a70 100644
--- a/arch/arm/plat-omap/include/mach/prcm.h
+++ b/arch/arm/plat-omap/include/mach/prcm.h
@@ -25,6 +25,7 @@
 
 u32 omap_prcm_get_reset_sources(void);
 void omap_prcm_arch_reset(char mode);
+int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name);
 
 #endif
 


