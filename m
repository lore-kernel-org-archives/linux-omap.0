From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 38/86] [ARM] OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
Date: Thu, 12 Mar 2009 11:27:48 -0700
Message-ID: <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756647AbZCLSbf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:35 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:34 -0700 (PDT)
In-Reply-To: <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Fix sparse & checkpatch warnings in OMAP2/3 PRCM & PM code.  This mostly
consists of:

- converting pointer comparisons to integers in form similar to
  (ptr == 0) to the standard idiom (!ptr)

- labeling a few non-static private functions as static

- adding prototypes for *_init() functions in the appropriate header
  files, and getting rid of the corresponding open-coded extern
  prototypes in other C files

- renaming the variable 'sclk' in mach-omap2/clock.c:omap2_get_apll_clkin
  to avoid shadowing an earlier declaration

Clean up checkpatch issues.  This mostly involves:

- converting some asm/ includes to linux/ includes

- cleaning up some whitespace

- getting rid of braces for conditionals with single following statements

Also take care of a few odds and ends, including:

- getting rid of unlikely() and likely() - none of this code is particularly
  fast-path code, so the performance impact seems slim; and some of those
  likely() and unlikely() indicators are probably not as accurate as the
  ARM's branch predictor

- removing some superfluous casts

linux-omap source commit is 347df59f5d20fdf905afbc26b1328b0e28a8a01b.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c                   |   51 ++++++++++++-------------
 arch/arm/mach-omap2/clock.h                   |    2 +-
 arch/arm/mach-omap2/clock24xx.c               |   16 ++++---
 arch/arm/mach-omap2/pm.c                      |    2 +-
 arch/arm/plat-omap/include/mach/clock.h       |    4 +-
 arch/arm/plat-omap/include/mach/powerdomain.h |    1 +
 arch/arm/plat-omap/include/mach/prcm.h        |    5 +-
 arch/arm/plat-omap/include/mach/system.h      |    4 +-
 8 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 53fda99..886f73f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -26,7 +26,6 @@
 
 #include <mach/clock.h>
 #include <mach/clockdomain.h>
-#include <mach/sram.h>
 #include <mach/cpu.h>
 #include <asm/div64.h>
 
@@ -187,11 +186,10 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
 	 * 24xx uses 0 to indicate not ready, and 1 to indicate ready.
 	 * 34xx reverses this, just to keep us on our toes
 	 */
-	if (cpu_mask & (RATE_IN_242X | RATE_IN_243X)) {
+	if (cpu_mask & (RATE_IN_242X | RATE_IN_243X))
 		ena = mask;
-	} else if (cpu_mask & RATE_IN_343X) {
+	else if (cpu_mask & RATE_IN_343X)
 		ena = 0;
-	}
 
 	/* Wait for lock */
 	while (((__raw_readl(reg) & mask) != ena) &&
@@ -267,7 +265,7 @@ static int omap2_dflt_clk_enable_wait(struct clk *clk)
 {
 	int ret;
 
-	if (unlikely(clk->enable_reg == NULL)) {
+	if (!clk->enable_reg) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
 		       clk->name);
 		return 0; /* REVISIT: -EINVAL */
@@ -283,7 +281,7 @@ static void omap2_dflt_clk_disable(struct clk *clk)
 {
 	u32 regval32;
 
-	if (clk->enable_reg == NULL) {
+	if (!clk->enable_reg) {
 		/*
 		 * 'Independent' here refers to a clock which is not
 		 * controlled by its parent.
@@ -330,7 +328,7 @@ void omap2_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {
 		_omap2_clk_disable(clk);
-		if (likely((u32)clk->parent))
+		if (clk->parent)
 			omap2_clk_disable(clk->parent);
 		if (clk->clkdm)
 			omap2_clkdm_clk_disable(clk->clkdm, clk);
@@ -343,10 +341,10 @@ int omap2_clk_enable(struct clk *clk)
 	int ret = 0;
 
 	if (clk->usecount++ == 0) {
-		if (likely((u32)clk->parent))
+		if (clk->parent)
 			ret = omap2_clk_enable(clk->parent);
 
-		if (unlikely(ret != 0)) {
+		if (ret != 0) {
 			clk->usecount--;
 			return ret;
 		}
@@ -356,7 +354,7 @@ int omap2_clk_enable(struct clk *clk)
 
 		ret = _omap2_clk_enable(clk);
 
-		if (unlikely(ret != 0)) {
+		if (ret != 0) {
 			if (clk->clkdm)
 				omap2_clkdm_clk_disable(clk->clkdm, clk);
 
@@ -384,7 +382,7 @@ void omap2_clksel_recalc(struct clk *clk)
 	if (div == 0)
 		return;
 
-	if (unlikely(clk->rate == clk->parent->rate / div))
+	if (clk->rate == (clk->parent->rate / div))
 		return;
 	clk->rate = clk->parent->rate / div;
 
@@ -400,8 +398,8 @@ void omap2_clksel_recalc(struct clk *clk)
  * the element associated with the supplied parent clock address.
  * Returns a pointer to the struct clksel on success or NULL on error.
  */
-const struct clksel *omap2_get_clksel_by_parent(struct clk *clk,
-						struct clk *src_clk)
+static const struct clksel *omap2_get_clksel_by_parent(struct clk *clk,
+						       struct clk *src_clk)
 {
 	const struct clksel *clks;
 
@@ -450,7 +448,7 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 	*new_div = 1;
 
 	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (clks == NULL)
+	if (!clks)
 		return ~0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -509,7 +507,7 @@ long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
 /* Given a clock and a rate apply a clock specific rounding function */
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	if (clk->round_rate != NULL)
+	if (clk->round_rate)
 		return clk->round_rate(clk, rate);
 
 	if (clk->flags & RATE_FIXED)
@@ -535,7 +533,7 @@ u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val)
 	const struct clksel_rate *clkr;
 
 	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (clks == NULL)
+	if (!clks)
 		return 0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -571,7 +569,7 @@ u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
 	WARN_ON(div == 0);
 
 	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (clks == NULL)
+	if (!clks)
 		return 0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -596,9 +594,9 @@ u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
  *
  * Returns the address of the clksel register upon success or NULL on error.
  */
-void __iomem *omap2_get_clksel(struct clk *clk, u32 *field_mask)
+static void __iomem *omap2_get_clksel(struct clk *clk, u32 *field_mask)
 {
-	if (unlikely((clk->clksel_reg == NULL) || (clk->clksel_mask == NULL)))
+	if (!clk->clksel_reg || (clk->clksel_mask == 0))
 		return NULL;
 
 	*field_mask = clk->clksel_mask;
@@ -618,7 +616,7 @@ u32 omap2_clksel_get_divisor(struct clk *clk)
 	void __iomem *div_addr;
 
 	div_addr = omap2_get_clksel(clk, &field_mask);
-	if (div_addr == NULL)
+	if (!div_addr)
 		return 0;
 
 	field_val = __raw_readl(div_addr) & field_mask;
@@ -637,7 +635,7 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	div_addr = omap2_get_clksel(clk, &field_mask);
-	if (div_addr == NULL)
+	if (!div_addr)
 		return -EINVAL;
 
 	field_val = omap2_divisor_to_clksel(clk, new_div);
@@ -675,7 +673,7 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	/* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
-	if (clk->set_rate != NULL)
+	if (clk->set_rate)
 		ret = clk->set_rate(clk, rate);
 
 	return ret;
@@ -696,7 +694,7 @@ static u32 omap2_clksel_get_src_field(void __iomem **src_addr,
 	*src_addr = NULL;
 
 	clks = omap2_get_clksel_by_parent(clk, src_clk);
-	if (clks == NULL)
+	if (!clks)
 		return 0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -726,7 +724,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	void __iomem *src_addr;
 	u32 field_val, field_mask, reg_val, parent_div;
 
-	if (unlikely(clk->flags & CONFIG_PARTICIPANT))
+	if (clk->flags & CONFIG_PARTICIPANT)
 		return -EINVAL;
 
 	if (!clk->clksel)
@@ -734,7 +732,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 
 	field_val = omap2_clksel_get_src_field(&src_addr, new_parent,
 					       &field_mask, clk, &parent_div);
-	if (src_addr == NULL)
+	if (!src_addr)
 		return -EINVAL;
 
 	if (clk->usecount > 0)
@@ -794,7 +792,8 @@ int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance)
 	return 0;
 }
 
-static unsigned long _dpll_compute_new_rate(unsigned long parent_rate, unsigned int m, unsigned int n)
+static unsigned long _dpll_compute_new_rate(unsigned long parent_rate,
+					    unsigned int m, unsigned int n)
 {
 	unsigned long long num;
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b0358b6..90077f0 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -27,7 +27,7 @@ void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
-int omap2_dpll_rate_tolerance_set(struct clk *clk, unsigned int tolerance);
+int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance);
 long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index bd77ef2..91ad207 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -339,7 +339,7 @@ static const struct clkops clkops_fixed = {
  * Uses the current prcm set to tell if a rate is valid.
  * You can go slower, but not faster within a given rate set.
  */
-long omap2_dpllcore_round_rate(unsigned long target_rate)
+static long omap2_dpllcore_round_rate(unsigned long target_rate)
 {
 	u32 high, low, core_clk_src;
 
@@ -550,7 +550,9 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
 		/* Major subsystem dividers */
 		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
-		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD, CM_CLKSEL1);
+		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
+				 CM_CLKSEL1);
+
 		if (cpu_is_omap2430())
 			cm_write_mod_reg(prcm->cm_clksel_mdm,
 					 OMAP2430_MDM_MOD, CM_CLKSEL);
@@ -582,20 +584,20 @@ static struct clk_functions omap2_clk_functions = {
 
 static u32 omap2_get_apll_clkin(void)
 {
-	u32 aplls, sclk = 0;
+	u32 aplls, srate = 0;
 
 	aplls = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
 	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
 	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;
 
 	if (aplls == APLLS_CLKIN_19_2MHZ)
-		sclk = 19200000;
+		srate = 19200000;
 	else if (aplls == APLLS_CLKIN_13MHZ)
-		sclk = 13000000;
+		srate = 13000000;
 	else if (aplls == APLLS_CLKIN_12MHZ)
-		sclk = 12000000;
+		srate = 12000000;
 
-	return sclk;
+	return srate;
 }
 
 static u32 omap2_get_sysclkdiv(void)
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 55361c1..ea8ceae 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -103,7 +103,7 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
-int __init omap2_pm_init(void)
+static int __init omap2_pm_init(void)
 {
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index f147aec..6f49a33 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -113,12 +113,12 @@ struct clk_functions {
 
 extern unsigned int mpurate;
 
-extern int clk_init(struct clk_functions * custom_clocks);
+extern int clk_init(struct clk_functions *custom_clocks);
 extern int clk_register(struct clk *clk);
 extern void clk_unregister(struct clk *clk);
 extern void propagate_rate(struct clk *clk);
 extern void recalculate_root_clocks(void);
-extern void followparent_recalc(struct clk * clk);
+extern void followparent_recalc(struct clk *clk);
 extern int clk_get_usecount(struct clk *clk);
 extern void clk_enable_init_clocks(void);
 
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index 2806a9c..4948cb7 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -145,6 +145,7 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
 
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
 
diff --git a/arch/arm/plat-omap/include/mach/prcm.h b/arch/arm/plat-omap/include/mach/prcm.h
index 56eba0f..24ac3c7 100644
--- a/arch/arm/plat-omap/include/mach/prcm.h
+++ b/arch/arm/plat-omap/include/mach/prcm.h
@@ -20,10 +20,11 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
-#ifndef __ASM_ARM_ARCH_DPM_PRCM_H
-#define __ASM_ARM_ARCH_DPM_PRCM_H
+#ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
+#define __ASM_ARM_ARCH_OMAP_PRCM_H
 
 u32 omap_prcm_get_reset_sources(void);
+void omap_prcm_arch_reset(char mode);
 
 #endif
 
diff --git a/arch/arm/plat-omap/include/mach/system.h b/arch/arm/plat-omap/include/mach/system.h
index 06923f2..e9b9563 100644
--- a/arch/arm/plat-omap/include/mach/system.h
+++ b/arch/arm/plat-omap/include/mach/system.h
@@ -9,12 +9,12 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
+#include <mach/prcm.h>
+
 #ifndef CONFIG_MACH_VOICEBLUE
 #define voiceblue_reset()		do {} while (0)
 #endif
 
-extern void omap_prcm_arch_reset(char mode);
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
-- 
1.6.1.2

