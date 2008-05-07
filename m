From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/5] fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
Date: Wed, 07 May 2008 11:52:01 -0600
Message-ID: <20080507175201.17732.21784.stgit@localhost.localdomain>
References: <20080507171204.17732.97601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59087 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178AbYEGTui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 15:50:38 -0400
In-Reply-To: <20080507171204.17732.97601.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fix sparse & checkpatch warnings in OMAP2/3 PRCM & PM code.  This mostly
consists of:

- converting pointer comparisons to integers in form similar to
  (ptr == 0) to the standard idiom (!ptr)

- labeling a few non-static private functions as static

- tagging appropriate integer<->pointer casts with __force

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


Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock.c             |  107 +++++++++++++++----------------
 arch/arm/mach-omap2/clock.h             |    4 +
 arch/arm/mach-omap2/clock24xx.c         |   23 +++----
 arch/arm/mach-omap2/clockdomain.c       |    5 +
 arch/arm/mach-omap2/cm.h                |    4 +
 arch/arm/mach-omap2/pm.c                |   37 ++++++-----
 arch/arm/mach-omap2/powerdomain.c       |    2 -
 arch/arm/mach-omap2/prcm.c              |   12 ++-
 arch/arm/mach-omap2/prm.h               |    6 +-
 include/asm-arm/arch-omap/clock.h       |    7 +-
 include/asm-arm/arch-omap/powerdomain.h |    1 
 include/asm-arm/arch-omap/prcm.h        |    5 +
 12 files changed, 110 insertions(+), 103 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index bdf4cad..0742359 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -21,11 +21,11 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
-#include <asm/bitops.h>
-
-#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
 
 #include <asm/arch/clock.h>
+#include <asm/arch/clockdomain.h>
 #include <asm/arch/sram.h>
 #include <asm/arch/cpu.h>
 #include <asm/div64.h>
@@ -190,11 +190,10 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
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
@@ -217,29 +216,26 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
  * Note: We don't need special code here for INVERT_ENABLE
  * for the time being since INVERT_ENABLE only applies to clocks enabled by
  * CM_CLKEN_PLL
+ *
+ * REVISIT: This code is ugly and does not belong here.
  */
 static void omap2_clk_wait_ready(struct clk *clk)
 {
-	void __iomem *reg, *other_reg, *st_reg;
-	u32 bit;
-
-	/*
-	 * REVISIT: This code is pretty ugly.  It would be nice to generalize
-	 * it and pull it into struct clk itself somehow.
-	 */
-	reg = clk->enable_reg;
-	if ((((u32)reg & 0xff) >= CM_FCLKEN1) &&
-	    (((u32)reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
-		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
-	else if ((((u32)reg & 0xff) >= CM_ICLKEN1) &&
-		 (((u32)reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
-		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
+	u32 bit, reg, other_reg, st_reg;
+
+	reg = (__force u32)clk->enable_reg;
+	if (((reg & 0xff) >= CM_FCLKEN1) &&
+	    ((reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
+		other_reg = ((reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
+	else if (((reg & 0xff) >= CM_ICLKEN1) &&
+		 ((reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
+		other_reg = ((reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
 	else
 		return;
 
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	/* No check for DSS or cam clocks */
-	if (cpu_is_omap24xx() && ((u32)reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
+	if (cpu_is_omap24xx() && (reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
 		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
 		    clk->enable_bit == OMAP24XX_EN_DSS1_SHIFT ||
 		    clk->enable_bit == OMAP24XX_EN_CAM_SHIFT)
@@ -249,25 +245,25 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	/* OMAP3: ignore DSS-mod clocks */
 	if (cpu_is_omap34xx() &&
-	    (((u32)reg & ~0xff) == (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
-	     ((((u32)reg & ~0xff) == (u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &&
-	     clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
+	    ((reg & ~0xff) == (__force u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
+	     (((reg & ~0xff) == (__force u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &&
+	      clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
 		return;
 
 	/* Check if both functional and interface clocks
 	 * are running. */
 	bit = 1 << clk->enable_bit;
-	if (!(__raw_readl(other_reg) & bit))
+	if (!(__raw_readl((__force void __iomem *)other_reg) & bit))
 		return;
-	st_reg = (void __iomem *)(((u32)other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
+	st_reg = ((other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
 
-	omap2_wait_clock_ready(st_reg, bit, clk->name);
+	omap2_wait_clock_ready((__force void __iomem *)st_reg, bit, clk->name);
 }
 
 /* Enables clock without considering parent dependencies or use count
  * REVISIT: Maybe change this to use clk->enable like on omap1?
  */
-int _omap2_clk_enable(struct clk *clk)
+static int _omap2_clk_enable(struct clk *clk)
 {
 	u32 regval32;
 
@@ -277,7 +273,7 @@ int _omap2_clk_enable(struct clk *clk)
 	if (clk->enable)
 		return clk->enable(clk);
 
-	if (unlikely(clk->enable_reg == 0)) {
+	if (!clk->enable_reg) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
 		       clk->name);
 		return 0; /* REVISIT: -EINVAL */
@@ -297,7 +293,7 @@ int _omap2_clk_enable(struct clk *clk)
 }
 
 /* Disables clock without considering parent dependencies or use count */
-void _omap2_clk_disable(struct clk *clk)
+static void _omap2_clk_disable(struct clk *clk)
 {
 	u32 regval32;
 
@@ -309,7 +305,7 @@ void _omap2_clk_disable(struct clk *clk)
 		return;
 	}
 
-	if (clk->enable_reg == 0) {
+	if (!clk->enable_reg) {
 		/*
 		 * 'Independent' here refers to a clock which is not
 		 * controlled by its parent.
@@ -332,7 +328,7 @@ void omap2_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {
 		_omap2_clk_disable(clk);
-		if (likely((u32)clk->parent))
+		if (clk->parent)
 			omap2_clk_disable(clk->parent);
 		if (clk->clkdm)
 			omap2_clkdm_clk_disable(clk->clkdm, clk);
@@ -345,10 +341,10 @@ int omap2_clk_enable(struct clk *clk)
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
@@ -358,7 +354,7 @@ int omap2_clk_enable(struct clk *clk)
 
 		ret = _omap2_clk_enable(clk);
 
-		if (unlikely(ret != 0)) {
+		if (ret != 0) {
 			if (clk->clkdm)
 				omap2_clkdm_clk_disable(clk->clkdm, clk);
 
@@ -386,13 +382,13 @@ void omap2_clksel_recalc(struct clk *clk)
 	if (div == 0)
 		return;
 
-	if (unlikely(clk->rate == clk->parent->rate / div))
+	if (clk->rate == (clk->parent->rate / div))
 		return;
 	clk->rate = clk->parent->rate / div;
 
 	pr_debug("clock: new clock rate is %ld (div %d)\n", clk->rate, div);
 
-	if (unlikely(clk->flags & RATE_PROPAGATES))
+	if (clk->flags & RATE_PROPAGATES)
 		propagate_rate(clk);
 }
 
@@ -405,8 +401,8 @@ void omap2_clksel_recalc(struct clk *clk)
  * the element associated with the supplied parent clock address.
  * Returns a pointer to the struct clksel on success or NULL on error.
  */
-const struct clksel *omap2_get_clksel_by_parent(struct clk *clk,
-						struct clk *src_clk)
+static const struct clksel *omap2_get_clksel_by_parent(struct clk *clk,
+						       struct clk *src_clk)
 {
 	const struct clksel *clks;
 
@@ -455,7 +451,7 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 	*new_div = 1;
 
 	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (clks == NULL)
+	if (!clks)
 		return ~0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -514,7 +510,7 @@ long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
 /* Given a clock and a rate apply a clock specific rounding function */
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	if (clk->round_rate != 0)
+	if (clk->round_rate)
 		return clk->round_rate(clk, rate);
 
 	if (clk->flags & RATE_FIXED)
@@ -540,7 +536,7 @@ u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val)
 	const struct clksel_rate *clkr;
 
 	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (clks == NULL)
+	if (!clks)
 		return 0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -576,7 +572,7 @@ u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
 	WARN_ON(div == 0);
 
 	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (clks == NULL)
+	if (!clks)
 		return 0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -601,9 +597,9 @@ u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
  *
  * Returns the address of the clksel register upon success or NULL on error.
  */
-void __iomem *omap2_get_clksel(struct clk *clk, u32 *field_mask)
+static void __iomem *omap2_get_clksel(struct clk *clk, u32 *field_mask)
 {
-	if (unlikely((clk->clksel_reg == 0) || (clk->clksel_mask == 0)))
+	if (!clk->clksel_reg || (clk->clksel_mask == 0))
 		return NULL;
 
 	*field_mask = clk->clksel_mask;
@@ -623,7 +619,7 @@ u32 omap2_clksel_get_divisor(struct clk *clk)
 	void __iomem *div_addr;
 
 	div_addr = omap2_get_clksel(clk, &field_mask);
-	if (div_addr == 0)
+	if (!div_addr)
 		return 0;
 
 	field_val = __raw_readl(div_addr) & field_mask;
@@ -642,7 +638,7 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	div_addr = omap2_get_clksel(clk, &field_mask);
-	if (div_addr == 0)
+	if (!div_addr)
 		return -EINVAL;
 
 	field_val = omap2_divisor_to_clksel(clk, new_div);
@@ -677,10 +673,10 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	/* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
-	if (clk->set_rate != 0)
+	if (clk->set_rate)
 		ret = clk->set_rate(clk, rate);
 
-	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
+	if (ret == 0 && (clk->flags & RATE_PROPAGATES))
 		propagate_rate(clk);
 
 	return ret;
@@ -698,10 +694,10 @@ static u32 omap2_clksel_get_src_field(void __iomem **src_addr,
 	const struct clksel_rate *clkr;
 
 	*parent_div = 0;
-	*src_addr = 0;
+	*src_addr = NULL;
 
 	clks = omap2_get_clksel_by_parent(clk, src_clk);
-	if (clks == NULL)
+	if (!clks)
 		return 0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -731,7 +727,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	void __iomem *src_addr;
 	u32 field_val, field_mask, reg_val, parent_div;
 
-	if (unlikely(clk->flags & CONFIG_PARTICIPANT))
+	if (clk->flags & CONFIG_PARTICIPANT)
 		return -EINVAL;
 
 	if (!clk->clksel)
@@ -739,7 +735,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 
 	field_val = omap2_clksel_get_src_field(&src_addr, new_parent,
 					       &field_mask, clk, &parent_div);
-	if (src_addr == 0)
+	if (!src_addr)
 		return -EINVAL;
 
 	if (clk->usecount > 0)
@@ -771,7 +767,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
 		 clk->name, clk->parent->name, clk->rate);
 
-	if (unlikely(clk->flags & RATE_PROPAGATES))
+	if (clk->flags & RATE_PROPAGATES)
 		propagate_rate(clk);
 
 	return 0;
@@ -803,7 +799,8 @@ int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance)
 	return 0;
 }
 
-static unsigned long _dpll_compute_new_rate(unsigned long parent_rate, unsigned int m, unsigned int n)
+static unsigned long _dpll_compute_new_rate(unsigned long parent_rate,
+					    unsigned int m, unsigned int n)
 {
 	unsigned long long num;
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 8f3d019..49245f7 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -21,12 +21,13 @@
 /* The maximum error between a target DPLL rate and the rounded rate in Hz */
 #define DEFAULT_DPLL_RATE_TOLERANCE	50000
 
+int omap2_clk_init(void);
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
-int omap2_dpll_rate_tolerance_set(struct clk *clk, unsigned int tolerance);
+int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance);
 long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
@@ -48,6 +49,7 @@ long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 u32 omap2_get_dpll_rate(struct clk *clk);
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
+void omap2_clk_prepare_for_reboot(void);
 
 extern u8 cpu_mask;
 
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index e7968e7..efe4436 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -24,14 +24,13 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
-
+#include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/cpufreq.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
 #include <asm/div64.h>
-#include <asm/bitops.h>
 
 #include "memory.h"
 #include "clock.h"
@@ -135,7 +134,7 @@ static void omap2_clk_fixed_disable(struct clk *clk)
  * Uses the current prcm set to tell if a rate is valid.
  * You can go slower, but not faster within a given rate set.
  */
-long omap2_dpllcore_round_rate(unsigned long target_rate)
+static long omap2_dpllcore_round_rate(unsigned long target_rate)
 {
 	u32 high, low, core_clk_src;
 
@@ -348,7 +347,9 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
 		/* Major subsystem dividers */
 		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
-		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD, CM_CLKSEL1);
+		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
+				 CM_CLKSEL1);
+
 		if (cpu_is_omap2430())
 			cm_write_mod_reg(prcm->cm_clksel_mdm,
 					 OMAP2430_MDM_MOD, CM_CLKSEL);
@@ -396,8 +397,8 @@ void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 	}
 
 	if (i == 0) {
-		printk(KERN_WARNING "%s: failed to initialize frequency table\n",
-		       __FUNCTION__);
+		printk(KERN_WARNING "%s: failed to initialize frequency "
+		       "table\n", __func__);
 		return;
 	}
 
@@ -422,20 +423,20 @@ static struct clk_functions omap2_clk_functions = {
 
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
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 401abc9..ca944ec 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -134,7 +134,7 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 }
 
 
-struct clockdomain *_clkdm_lookup(const char *name)
+static struct clockdomain *_clkdm_lookup(const char *name)
 {
 	struct clockdomain *clkdm, *temp_clkdm;
 
@@ -167,7 +167,8 @@ struct clockdomain *_clkdm_lookup(const char *name)
  * pointer to an array of clockdomain-powerdomain autodependencies was
  * provided, register those.  No return value.
  */
-void clkdm_init(struct clockdomain **clkdms, struct clkdm_pwrdm_autodep *init_autodeps)
+void clkdm_init(struct clockdomain **clkdms,
+		struct clkdm_pwrdm_autodep *init_autodeps)
 {
 	struct clockdomain **c = NULL;
 	struct clkdm_pwrdm_autodep *autodep = NULL;
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index dc9cf85..040ec8e 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -14,13 +14,13 @@
  * published by the Free Software Foundation.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "prcm-common.h"
 
 #ifndef __ASSEMBLER__
 #define OMAP_CM_REGADDR(module, reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP2_CM_BASE + (module) + (reg))
+	(__force void __iomem *)IO_ADDRESS(OMAP2_CM_BASE + (module) + (reg))
 #else
 #define OMAP2420_CM_REGADDR(module, reg)				\
 			IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d0d7ac1..b627fe5 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -28,9 +28,9 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/irq.h>
 
-#include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/atomic.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
@@ -62,7 +62,7 @@ static void (*saved_idle)(void);
 
 static u32 omap2_read_32k_sync_counter(void)
 {
-        return omap_readl(OMAP2_32KSYNCT_BASE + 0x0010);
+	return omap_readl(OMAP2_32KSYNCT_BASE + 0x0010);
 }
 
 #ifdef CONFIG_PM_DEBUG
@@ -121,7 +121,8 @@ static void serial_console_sleep(int enable)
 		BUG_ON(serial_console_clock_disabled);
 		if (clk_get_usecount(console_fclk) == 0)
 			return;
-		if ((int) serial_console_next_disable - (int) omap2_read_32k_sync_counter() >= 0)
+		if ((int) serial_console_next_disable -
+		    (int) omap2_read_32k_sync_counter() >= 0)
 			return;
 		serial_wait_tx();
 		clk_disable(console_iclk);
@@ -190,7 +191,8 @@ static void pm_init_serial_console(void)
 		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1);
 		break;
 	case 3:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD, OMAP24XX_PM_WKEN2);
+		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD,
+				     OMAP24XX_PM_WKEN2);
 		break;
 	}
 }
@@ -290,16 +292,19 @@ static void omap2_pm_dump(int mode, int resume, unsigned int us)
 
 	if (!resume)
 #if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
-		printk("--- Going to %s %s (next timer after %u ms)\n", s1, s2,
-		       jiffies_to_msecs(get_next_timer_interrupt(jiffies) - 
-					jiffies));
+		pr_debug("--- Going to %s %s (next timer after %u ms)\n", s1,
+			 s2,
+			 jiffies_to_msecs(get_next_timer_interrupt(jiffies) -
+					  jiffies));
 #else
-		printk("--- Going to %s %s\n", s1, s2);
+		pr_debug("--- Going to %s %s\n", s1, s2);
 #endif
 	else
-		printk("--- Woke up (slept for %u.%03u ms)\n", us / 1000, us % 1000);
+		pr_debug("--- Woke up (slept for %u.%03u ms)\n", us / 1000,
+			 us % 1000);
+
 	for (i = 0; i < reg_count; i++)
-		printk("%-20s: 0x%08x\n", regs[i].name, regs[i].val);
+		pr_debug("%-20s: 0x%08x\n", regs[i].name, regs[i].val);
 }
 
 #else
@@ -321,7 +326,7 @@ static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 }
 
 static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
-			  const char * buf, size_t n)
+			  const char *buf, size_t n)
 {
 	unsigned short value;
 	if (sscanf(buf, "%hu", &value) != 1 ||
@@ -352,11 +357,11 @@ static int omap2_fclks_active(void)
 
 static int omap2_irq_pending(void)
 {
-	u32 pending_reg = IO_ADDRESS(0x480fe098);
+	u32 pending_reg = 0x480fe098;
 	int i;
 
 	for (i = 0; i < 4; i++) {
-		if (__raw_readl(pending_reg))
+		if (omap_readl(pending_reg))
 			return 1;
 		pending_reg += 0x20;
 	}
@@ -498,7 +503,7 @@ static void omap2_enter_mpu_retention(void)
 	/* The peripherals seem not to be able to wake up the MPU when
 	 * it is in retention mode. */
 	if (omap2_allow_mpu_retention()) {
-	        /* REVISIT: These write to reserved bits? */
+		/* REVISIT: These write to reserved bits? */
 		prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
 		prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
 		prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
@@ -770,7 +775,7 @@ static void __init prcm_setup_regs(void)
 			  WKUP_MOD, PM_WKEN);
 }
 
-int __init omap2_pm_init(void)
+static int __init omap2_pm_init(void)
 {
 	u32 l;
 	int error;
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 6ae7292..dd9f40e 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -53,7 +53,7 @@ static u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
 	return v;
 }
 
-struct powerdomain *_pwrdm_lookup(const char *name)
+static struct powerdomain *_pwrdm_lookup(const char *name)
 {
 	struct powerdomain *pwrdm, *temp_pwrdm;
 
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index c1b4cc5..0d2a99a 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -18,11 +18,12 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <asm/arch/prcm.h>
+
+#include "clock.h"
 #include "prm.h"
 #include "prm-regbits-24xx.h"
 
-extern void omap2_clk_prepare_for_reboot(void);
-
 u32 omap_prcm_get_reset_sources(void)
 {
 	/* XXX This presumably needs modification for 34XX */
@@ -36,13 +37,12 @@ void omap_prcm_arch_reset(char mode)
 	s16 prcm_offs;
 	omap2_clk_prepare_for_reboot();
 
-	if (cpu_is_omap24xx()) {
+	if (cpu_is_omap24xx())
 		prcm_offs = WKUP_MOD;
-	} else if (cpu_is_omap34xx()) {
+	else if (cpu_is_omap34xx())
 		prcm_offs = OMAP3430_GR_MOD;
-	} else {
+	else
 		WARN_ON(1);
-	}
 
 	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
 }
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index dd4791a..e1ce33e 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -14,14 +14,14 @@
  * published by the Free Software Foundation.
  */
 
-#include <asm/io.h>
-#include <asm/bitops.h>
+#include <linux/io.h>
+#include <linux/bitops.h>
 
 #include "prcm-common.h"
 
 #ifndef __ASSEMBLER__
 #define OMAP_PRM_REGADDR(module, reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP2_PRM_BASE + (module) + (reg))
+	(__force void __iomem *)IO_ADDRESS(OMAP2_PRM_BASE + (module) + (reg))
 #else
 #define OMAP2420_PRM_REGADDR(module, reg)				\
 			IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index 241193d..75afd81 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -15,10 +15,9 @@
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
-#include <asm/arch/clockdomain.h>
-
 struct module;
 struct clk;
+struct clockdomain;
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 
@@ -112,12 +111,12 @@ struct clk_functions {
 
 extern unsigned int mpurate;
 
-extern int clk_init(struct clk_functions * custom_clocks);
+extern int clk_init(struct clk_functions *custom_clocks);
 extern int clk_register(struct clk *clk);
 extern void clk_unregister(struct clk *clk);
 extern void propagate_rate(struct clk *clk);
 extern void recalculate_root_clocks(void);
-extern void followparent_recalc(struct clk * clk);
+extern void followparent_recalc(struct clk *clk);
 extern void clk_allow_idle(struct clk *clk);
 extern void clk_deny_idle(struct clk *clk);
 extern int clk_get_usecount(struct clk *clk);
diff --git a/include/asm-arm/arch-omap/powerdomain.h b/include/asm-arm/arch-omap/powerdomain.h
index 7fe63b4..40a054d 100644
--- a/include/asm-arm/arch-omap/powerdomain.h
+++ b/include/asm-arm/arch-omap/powerdomain.h
@@ -136,6 +136,7 @@ int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
 
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
 
diff --git a/include/asm-arm/arch-omap/prcm.h b/include/asm-arm/arch-omap/prcm.h
index 7bcaf94..b707af7 100644
--- a/include/asm-arm/arch-omap/prcm.h
+++ b/include/asm-arm/arch-omap/prcm.h
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
 


