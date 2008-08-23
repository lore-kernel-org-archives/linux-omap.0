From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/16] ARM: OMAP: Fix sparse, checkpatch warnings in
	OMAP2/3 PRCM/PM code
Date: Sat, 23 Aug 2008 15:36:54 -0700
Message-ID: <20080823223653.GD4713@atomide.com>
References: <1212804762-18413-1-git-send-email-tony@atomide.com> <1212804762-18413-2-git-send-email-tony@atomide.com> <1212804762-18413-3-git-send-email-tony@atomide.com> <20080819172138.GC17034@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5gxpn/Q6ypwruk0T"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65095 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbYHWWhB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2008 18:37:01 -0400
Content-Disposition: inline
In-Reply-To: <20080819172138.GC17034@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080819 10:21]:
> On Fri, Jun 06, 2008 at 07:12:30PM -0700, Tony Lindgren wrote:
> >  static void omap2_clk_wait_ready(struct clk *clk)
> >  {
> > -	void __iomem *reg, *other_reg, *st_reg;
> > -	u32 bit;
> > -
> > -	/*
> > -	 * REVISIT: This code is pretty ugly.  It would be nice to generalize
> > -	 * it and pull it into struct clk itself somehow.
> > -	 */
> > -	reg = clk->enable_reg;
> > -	if ((((u32)reg & 0xff) >= CM_FCLKEN1) &&
> > -	    (((u32)reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
> > -		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
> > -	else if ((((u32)reg & 0xff) >= CM_ICLKEN1) &&
> > -		 (((u32)reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
> > -		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
> > +	u32 bit, reg, other_reg, st_reg;
> > +
> > +	reg = (__force u32)clk->enable_reg;
> > +	if (((reg & 0xff) >= CM_FCLKEN1) &&
> > +	    ((reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
> > +		other_reg = ((reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
> > +	else if (((reg & 0xff) >= CM_ICLKEN1) &&
> > +		 ((reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
> > +		other_reg = ((reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
> 
> 	unsigned long reg = (unsigned long)clk->enable_reg;
> 
> IIRC is a permitted cast, doesn't require __force.  And you can convert
> back to void __iomem * without using __force either.
> 
> > diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> > index aad781d..598f2d2 100644
> > --- a/arch/arm/mach-omap2/pm.c
> > +++ b/arch/arm/mach-omap2/pm.c
> > @@ -24,9 +24,9 @@
> >  #include <linux/module.h>
> >  #include <linux/delay.h>
> >  #include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> >  
> > -#include <asm/io.h>
> > -#include <asm/irq.h>
> 
> As I keep saying to people, not every warning that checkpatch spits
> out is valid.  asm/irq.h -> linux/irq.h is not a valid warning.

Here's this one updated.

Tony

--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=0004-omap2-checkpatch

>From ae64ad23f9a2c3a954feaeda7f1736eafcd1e9a3 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Sat, 23 Aug 2008 15:35:58 -0700
Subject: [PATCH] ARM: OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code

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

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index aa9b373..1058516 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -21,13 +21,11 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
-#include <asm/bitops.h>
-
-#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
 
 #include <mach/clock.h>
 #include <mach/clockdomain.h>
-#include <mach/sram.h>
 #include <mach/cpu.h>
 #include <asm/div64.h>
 
@@ -191,11 +189,10 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
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
@@ -218,29 +215,27 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
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
+	u32 bit, other_reg, st_reg;
+	unsigned long reg;
+
+	reg = (unsigned long)clk->enable_reg;
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
@@ -250,25 +245,25 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	/* OMAP3: ignore DSS-mod clocks */
 	if (cpu_is_omap34xx() &&
-	    (((u32)reg & ~0xff) == (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
-	     ((((u32)reg & ~0xff) == (u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &&
-	     clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
+	    ((reg & ~0xff) == (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
+	     (((reg & ~0xff) == (u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &&
+	      clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
 		return;
 
 	/* Check if both functional and interface clocks
 	 * are running. */
 	bit = 1 << clk->enable_bit;
-	if (!(__raw_readl(other_reg) & bit))
+	if (!(__raw_readl((void __iomem *)other_reg) & bit))
 		return;
-	st_reg = (void __iomem *)(((u32)other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
+	st_reg = ((other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
 
-	omap2_wait_clock_ready(st_reg, bit, clk->name);
+	omap2_wait_clock_ready((void __iomem *)st_reg, bit, clk->name);
 }
 
 /* Enables clock without considering parent dependencies or use count
  * REVISIT: Maybe change this to use clk->enable like on omap1?
  */
-int _omap2_clk_enable(struct clk *clk)
+static int _omap2_clk_enable(struct clk *clk)
 {
 	u32 regval32;
 
@@ -278,7 +273,7 @@ int _omap2_clk_enable(struct clk *clk)
 	if (clk->enable)
 		return clk->enable(clk);
 
-	if (unlikely(clk->enable_reg == 0)) {
+	if (!clk->enable_reg) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
 		       clk->name);
 		return 0; /* REVISIT: -EINVAL */
@@ -298,7 +293,7 @@ int _omap2_clk_enable(struct clk *clk)
 }
 
 /* Disables clock without considering parent dependencies or use count */
-void _omap2_clk_disable(struct clk *clk)
+static void _omap2_clk_disable(struct clk *clk)
 {
 	u32 regval32;
 
@@ -310,7 +305,7 @@ void _omap2_clk_disable(struct clk *clk)
 		return;
 	}
 
-	if (clk->enable_reg == 0) {
+	if (!clk->enable_reg) {
 		/*
 		 * 'Independent' here refers to a clock which is not
 		 * controlled by its parent.
@@ -333,7 +328,7 @@ void omap2_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {
 		_omap2_clk_disable(clk);
-		if (likely((u32)clk->parent))
+		if (clk->parent)
 			omap2_clk_disable(clk->parent);
 		if (clk->clkdm)
 			omap2_clkdm_clk_disable(clk->clkdm, clk);
@@ -346,10 +341,10 @@ int omap2_clk_enable(struct clk *clk)
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
@@ -359,7 +354,7 @@ int omap2_clk_enable(struct clk *clk)
 
 		ret = _omap2_clk_enable(clk);
 
-		if (unlikely(ret != 0)) {
+		if (ret != 0) {
 			if (clk->clkdm)
 				omap2_clkdm_clk_disable(clk->clkdm, clk);
 
@@ -387,13 +382,13 @@ void omap2_clksel_recalc(struct clk *clk)
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
 
@@ -406,8 +401,8 @@ void omap2_clksel_recalc(struct clk *clk)
  * the element associated with the supplied parent clock address.
  * Returns a pointer to the struct clksel on success or NULL on error.
  */
-const struct clksel *omap2_get_clksel_by_parent(struct clk *clk,
-						struct clk *src_clk)
+static const struct clksel *omap2_get_clksel_by_parent(struct clk *clk,
+						       struct clk *src_clk)
 {
 	const struct clksel *clks;
 
@@ -456,7 +451,7 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 	*new_div = 1;
 
 	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (clks == NULL)
+	if (!clks)
 		return ~0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -515,7 +510,7 @@ long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
 /* Given a clock and a rate apply a clock specific rounding function */
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	if (clk->round_rate != 0)
+	if (clk->round_rate)
 		return clk->round_rate(clk, rate);
 
 	if (clk->flags & RATE_FIXED)
@@ -541,7 +536,7 @@ u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val)
 	const struct clksel_rate *clkr;
 
 	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (clks == NULL)
+	if (!clks)
 		return 0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -577,7 +572,7 @@ u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
 	WARN_ON(div == 0);
 
 	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (clks == NULL)
+	if (!clks)
 		return 0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -602,9 +597,9 @@ u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
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
@@ -624,7 +619,7 @@ u32 omap2_clksel_get_divisor(struct clk *clk)
 	void __iomem *div_addr;
 
 	div_addr = omap2_get_clksel(clk, &field_mask);
-	if (div_addr == 0)
+	if (!div_addr)
 		return 0;
 
 	field_val = __raw_readl(div_addr) & field_mask;
@@ -643,7 +638,7 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	div_addr = omap2_get_clksel(clk, &field_mask);
-	if (div_addr == 0)
+	if (!div_addr)
 		return -EINVAL;
 
 	field_val = omap2_divisor_to_clksel(clk, new_div);
@@ -681,10 +676,10 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	/* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
-	if (clk->set_rate != 0)
+	if (clk->set_rate)
 		ret = clk->set_rate(clk, rate);
 
-	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
+	if (ret == 0 && (clk->flags & RATE_PROPAGATES))
 		propagate_rate(clk);
 
 	return ret;
@@ -702,10 +697,10 @@ static u32 omap2_clksel_get_src_field(void __iomem **src_addr,
 	const struct clksel_rate *clkr;
 
 	*parent_div = 0;
-	*src_addr = 0;
+	*src_addr = NULL;
 
 	clks = omap2_get_clksel_by_parent(clk, src_clk);
-	if (clks == NULL)
+	if (!clks)
 		return 0;
 
 	for (clkr = clks->rates; clkr->div; clkr++) {
@@ -735,7 +730,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	void __iomem *src_addr;
 	u32 field_val, field_mask, reg_val, parent_div;
 
-	if (unlikely(clk->flags & CONFIG_PARTICIPANT))
+	if (clk->flags & CONFIG_PARTICIPANT)
 		return -EINVAL;
 
 	if (!clk->clksel)
@@ -743,7 +738,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 
 	field_val = omap2_clksel_get_src_field(&src_addr, new_parent,
 					       &field_mask, clk, &parent_div);
-	if (src_addr == 0)
+	if (!src_addr)
 		return -EINVAL;
 
 	if (clk->usecount > 0)
@@ -774,7 +769,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
 		 clk->name, clk->parent->name, clk->rate);
 
-	if (unlikely(clk->flags & RATE_PROPAGATES))
+	if (clk->flags & RATE_PROPAGATES)
 		propagate_rate(clk);
 
 	return 0;
@@ -806,7 +801,8 @@ int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance)
 	return 0;
 }
 
-static unsigned long _dpll_compute_new_rate(unsigned long parent_rate, unsigned int m, unsigned int n)
+static unsigned long _dpll_compute_new_rate(unsigned long parent_rate,
+					    unsigned int m, unsigned int n)
 {
 	unsigned long long num;
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index ea55f28..3fa2e26 100644
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
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 295e671..735f7c0 100644
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
 
 #include <mach/clock.h>
 #include <mach/sram.h>
 #include <asm/div64.h>
-#include <asm/bitops.h>
 
 #include "memory.h"
 #include "clock.h"
@@ -154,7 +153,7 @@ static void omap2_clk_fixed_disable(struct clk *clk)
  * Uses the current prcm set to tell if a rate is valid.
  * You can go slower, but not faster within a given rate set.
  */
-long omap2_dpllcore_round_rate(unsigned long target_rate)
+static long omap2_dpllcore_round_rate(unsigned long target_rate)
 {
 	u32 high, low, core_clk_src;
 
@@ -367,7 +366,9 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
 		/* Major subsystem dividers */
 		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
-		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD, CM_CLKSEL1);
+		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
+				 CM_CLKSEL1);
+
 		if (cpu_is_omap2430())
 			cm_write_mod_reg(prcm->cm_clksel_mdm,
 					 OMAP2430_MDM_MOD, CM_CLKSEL);
@@ -399,20 +400,20 @@ static struct clk_functions omap2_clk_functions = {
 
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
index 8671e10..ea8ceae 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -24,8 +24,8 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/atomic.h>
 #include <asm/mach/time.h>
@@ -103,7 +103,7 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
-int __init omap2_pm_init(void)
+static int __init omap2_pm_init(void)
 {
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 85a88ad..5f37735 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -111,12 +111,12 @@ struct clk_functions {
 
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
 

--5gxpn/Q6ypwruk0T--
