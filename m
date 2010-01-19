From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 03/18] OMAP2/3/4 clock: move clksel clock functions into
	mach-omap2/clkt_clksel.c
Date: Tue, 19 Jan 2010 16:35:56 -0700
Message-ID: <20100119233553.26047.24177.stgit@localhost.localdomain>
References: <20100119232900.26047.98263.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58599 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab0ASXic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 18:38:32 -0500
In-Reply-To: <20100119232900.26047.98263.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexander Shishkin <virtuoso@slind.org>

Move all clksel-related clock functions from mach-omap2/clock.c to
mach-omap2/clkt_clksel.c.  This is intended to make the clock code
easier to understand, since all of the functions needed to manage
clksel clocks are now located in their own file, rather than being
mixed with other, unrelated functions.

Clock debugging is also now more finely-grained, since the DEBUG macro
can now be defined for clksel clocks alon.  This should reduce
unnecessary console noise when debugging.

Also, if at some future point the mach-omap2/ directory is split
into OMAP2/3/4 variants, this clkt file can be moved to the plat-omap/
directory to be shared.

Thanks to Alexander Shishkin <virtuoso@slind.org> for his comments to
improve the patch description.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/mach-omap2/Makefile      |    3 
 arch/arm/mach-omap2/clkt_clksel.c |  417 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.c       |  377 ---------------------------------
 arch/arm/mach-omap2/clock.h       |    2 
 4 files changed, 424 insertions(+), 375 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt_clksel.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1a135c8..9ecc58d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -9,7 +9,8 @@ omap-2-3-common				= irq.o sdrc.o omap_hwmod.o
 omap-3-4-common				= dpll3xxx.o
 prcm-common				= prcm.o powerdomain.o
 clock-common				= clock.o clock_common_data.o \
-					  clockdomain.o clkt_dpll.o
+					  clockdomain.o clkt_dpll.o \
+					  clkt_clksel.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
new file mode 100644
index 0000000..25a2363
--- /dev/null
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -0,0 +1,417 @@
+/*
+ * clkt_clksel.c - OMAP2/3/4 clksel clock functions
+ *
+ * Copyright (C) 2005-2008 Texas Instruments, Inc.
+ * Copyright (C) 2004-2010 Nokia Corporation
+ *
+ * Contacts:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX At some point these clksel clocks should be split into
+ * "divider" clocks and "mux" clocks to better match the hardware.
+ *
+ * XXX Currently these clocks are only used in the OMAP2/3/4 code, but
+ * many of the OMAP1 clocks should be convertible to use this
+ * mechanism.
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
+#include "cm.h"
+#include "cm-regbits-24xx.h"
+#include "cm-regbits-34xx.h"
+
+/* Private functions */
+
+/**
+ * _omap2_get_clksel_by_parent - return clksel struct for a given clk & parent
+ * @clk: OMAP struct clk ptr to inspect
+ * @src_clk: OMAP struct clk ptr of the parent clk to search for
+ *
+ * Scan the struct clksel array associated with the clock to find
+ * the element associated with the supplied parent clock address.
+ * Returns a pointer to the struct clksel on success or NULL on error.
+ */
+static const struct clksel *_omap2_get_clksel_by_parent(struct clk *clk,
+							struct clk *src_clk)
+{
+	const struct clksel *clks;
+
+	if (!clk->clksel)
+		return NULL;
+
+	for (clks = clk->clksel; clks->parent; clks++) {
+		if (clks->parent == src_clk)
+			break; /* Found the requested parent */
+	}
+
+	if (!clks->parent) {
+		printk(KERN_ERR "clock: Could not find parent clock %s in "
+		       "clksel array of clock %s\n", src_clk->name,
+		       clk->name);
+		return NULL;
+	}
+
+	return clks;
+}
+
+/*
+ * Converts encoded control register address into a full address
+ * On error, the return value (parent_div) will be 0.
+ */
+static u32 _omap2_clksel_get_src_field(struct clk *src_clk, struct clk *clk,
+				       u32 *field_val)
+{
+	const struct clksel *clks;
+	const struct clksel_rate *clkr;
+
+	clks = _omap2_get_clksel_by_parent(clk, src_clk);
+	if (!clks)
+		return 0;
+
+	for (clkr = clks->rates; clkr->div; clkr++) {
+		if (clkr->flags & cpu_mask && clkr->flags & DEFAULT_RATE)
+			break; /* Found the default rate for this platform */
+	}
+
+	if (!clkr->div) {
+		printk(KERN_ERR "clock: Could not find default rate for "
+		       "clock %s parent %s\n", clk->name,
+		       src_clk->parent->name);
+		return 0;
+	}
+
+	/* Should never happen.  Add a clksel mask to the struct clk. */
+	WARN_ON(clk->clksel_mask == 0);
+
+	*field_val = clkr->val;
+
+	return clkr->div;
+}
+
+
+/* Public functions */
+
+/**
+ * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
+ * @clk: OMAP clock struct ptr to use
+ *
+ * Given a pointer to a source-selectable struct clk, read the hardware
+ * register and determine what its parent is currently set to.  Update the
+ * clk->parent field with the appropriate clk ptr.
+ */
+void omap2_init_clksel_parent(struct clk *clk)
+{
+	const struct clksel *clks;
+	const struct clksel_rate *clkr;
+	u32 r, found = 0;
+
+	if (!clk->clksel)
+		return;
+
+	r = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
+	r >>= __ffs(clk->clksel_mask);
+
+	for (clks = clk->clksel; clks->parent && !found; clks++) {
+		for (clkr = clks->rates; clkr->div && !found; clkr++) {
+			if ((clkr->flags & cpu_mask) && (clkr->val == r)) {
+				if (clk->parent != clks->parent) {
+					pr_debug("clock: inited %s parent "
+						 "to %s (was %s)\n",
+						 clk->name, clks->parent->name,
+						 ((clk->parent) ?
+						  clk->parent->name : "NULL"));
+					clk_reparent(clk, clks->parent);
+				};
+				found = 1;
+			}
+		}
+	}
+
+	if (!found)
+		printk(KERN_ERR "clock: init parent: could not find "
+		       "regval %0x for clock %s\n", r,  clk->name);
+
+	return;
+}
+
+/*
+ * Used for clocks that are part of CLKSEL_xyz governed clocks.
+ * REVISIT: Maybe change to use clk->enable() functions like on omap1?
+ */
+unsigned long omap2_clksel_recalc(struct clk *clk)
+{
+	unsigned long rate;
+	u32 div = 0;
+
+	pr_debug("clock: recalc'ing clksel clk %s\n", clk->name);
+
+	div = omap2_clksel_get_divisor(clk);
+	if (div == 0)
+		return clk->rate;
+
+	rate = clk->parent->rate / div;
+
+	pr_debug("clock: new clock rate is %ld (div %d)\n", rate, div);
+
+	return rate;
+}
+
+/**
+ * omap2_clksel_round_rate_div - find divisor for the given clock and rate
+ * @clk: OMAP struct clk to use
+ * @target_rate: desired clock rate
+ * @new_div: ptr to where we should store the divisor
+ *
+ * Finds 'best' divider value in an array based on the source and target
+ * rates.  The divider array must be sorted with smallest divider first.
+ * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
+ * they are only settable as part of virtual_prcm set.
+ *
+ * Returns the rounded clock rate or returns 0xffffffff on error.
+ */
+u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
+				u32 *new_div)
+{
+	unsigned long test_rate;
+	const struct clksel *clks;
+	const struct clksel_rate *clkr;
+	u32 last_div = 0;
+
+	pr_debug("clock: clksel_round_rate_div: %s target_rate %ld\n",
+		 clk->name, target_rate);
+
+	*new_div = 1;
+
+	clks = _omap2_get_clksel_by_parent(clk, clk->parent);
+	if (!clks)
+		return ~0;
+
+	for (clkr = clks->rates; clkr->div; clkr++) {
+		if (!(clkr->flags & cpu_mask))
+			continue;
+
+		/* Sanity check */
+		if (clkr->div <= last_div)
+			pr_err("clock: clksel_rate table not sorted "
+			       "for clock %s", clk->name);
+
+		last_div = clkr->div;
+
+		test_rate = clk->parent->rate / clkr->div;
+
+		if (test_rate <= target_rate)
+			break; /* found it */
+	}
+
+	if (!clkr->div) {
+		pr_err("clock: Could not find divisor for target "
+		       "rate %ld for clock %s parent %s\n", target_rate,
+		       clk->name, clk->parent->name);
+		return ~0;
+	}
+
+	*new_div = clkr->div;
+
+	pr_debug("clock: new_div = %d, new_rate = %ld\n", *new_div,
+		 (clk->parent->rate / clkr->div));
+
+	return clk->parent->rate / clkr->div;
+}
+
+/**
+ * omap2_clksel_round_rate - find rounded rate for the given clock and rate
+ * @clk: OMAP struct clk to use
+ * @target_rate: desired clock rate
+ *
+ * Compatibility wrapper for OMAP clock framework
+ * Finds best target rate based on the source clock and possible dividers.
+ * rates. The divider array must be sorted with smallest divider first.
+ * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
+ * they are only settable as part of virtual_prcm set.
+ *
+ * Returns the rounded clock rate or returns 0xffffffff on error.
+ */
+long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
+{
+	u32 new_div;
+
+	return omap2_clksel_round_rate_div(clk, target_rate, &new_div);
+}
+
+
+/* Given a clock and a rate apply a clock specific rounding function */
+long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (clk->round_rate)
+		return clk->round_rate(clk, rate);
+
+	if (clk->flags & RATE_FIXED)
+		printk(KERN_ERR "clock: generic omap2_clk_round_rate called "
+		       "on fixed-rate clock %s\n", clk->name);
+
+	return clk->rate;
+}
+
+/**
+ * omap2_clksel_to_divisor() - turn clksel field value into integer divider
+ * @clk: OMAP struct clk to use
+ * @field_val: register field value to find
+ *
+ * Given a struct clk of a rate-selectable clksel clock, and a register field
+ * value to search for, find the corresponding clock divisor.  The register
+ * field value should be pre-masked and shifted down so the LSB is at bit 0
+ * before calling.  Returns 0 on error
+ */
+u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val)
+{
+	const struct clksel *clks;
+	const struct clksel_rate *clkr;
+
+	clks = _omap2_get_clksel_by_parent(clk, clk->parent);
+	if (!clks)
+		return 0;
+
+	for (clkr = clks->rates; clkr->div; clkr++) {
+		if ((clkr->flags & cpu_mask) && (clkr->val == field_val))
+			break;
+	}
+
+	if (!clkr->div) {
+		printk(KERN_ERR "clock: Could not find fieldval %d for "
+		       "clock %s parent %s\n", field_val, clk->name,
+		       clk->parent->name);
+		return 0;
+	}
+
+	return clkr->div;
+}
+
+/**
+ * omap2_divisor_to_clksel() - turn clksel integer divisor into a field value
+ * @clk: OMAP struct clk to use
+ * @div: integer divisor to search for
+ *
+ * Given a struct clk of a rate-selectable clksel clock, and a clock divisor,
+ * find the corresponding register field value.  The return register value is
+ * the value before left-shifting.  Returns ~0 on error
+ */
+u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
+{
+	const struct clksel *clks;
+	const struct clksel_rate *clkr;
+
+	/* should never happen */
+	WARN_ON(div == 0);
+
+	clks = _omap2_get_clksel_by_parent(clk, clk->parent);
+	if (!clks)
+		return ~0;
+
+	for (clkr = clks->rates; clkr->div; clkr++) {
+		if ((clkr->flags & cpu_mask) && (clkr->div == div))
+			break;
+	}
+
+	if (!clkr->div) {
+		printk(KERN_ERR "clock: Could not find divisor %d for "
+		       "clock %s parent %s\n", div, clk->name,
+		       clk->parent->name);
+		return ~0;
+	}
+
+	return clkr->val;
+}
+
+/**
+ * omap2_clksel_get_divisor - get current divider applied to parent clock.
+ * @clk: OMAP struct clk to use.
+ *
+ * Returns the integer divisor upon success or 0 on error.
+ */
+u32 omap2_clksel_get_divisor(struct clk *clk)
+{
+	u32 v;
+
+	if (!clk->clksel_mask)
+		return 0;
+
+	v = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
+	v >>= __ffs(clk->clksel_mask);
+
+	return omap2_clksel_to_divisor(clk, v);
+}
+
+int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 v, field_val, validrate, new_div = 0;
+
+	if (!clk->clksel_mask)
+		return -EINVAL;
+
+	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
+	if (validrate != rate)
+		return -EINVAL;
+
+	field_val = omap2_divisor_to_clksel(clk, new_div);
+	if (field_val == ~0)
+		return -EINVAL;
+
+	v = __raw_readl(clk->clksel_reg);
+	v &= ~clk->clksel_mask;
+	v |= field_val << __ffs(clk->clksel_mask);
+	__raw_writel(v, clk->clksel_reg);
+	v = __raw_readl(clk->clksel_reg); /* OCP barrier */
+
+	clk->rate = clk->parent->rate / new_div;
+
+	omap2xxx_clk_commit(clk);
+
+	return 0;
+}
+
+int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent)
+{
+	u32 field_val, v, parent_div;
+
+	if (!clk->clksel)
+		return -EINVAL;
+
+	parent_div = _omap2_clksel_get_src_field(new_parent, clk, &field_val);
+	if (!parent_div)
+		return -EINVAL;
+
+	/* Set new source value (previous dividers if any in effect) */
+	v = __raw_readl(clk->clksel_reg);
+	v &= ~clk->clksel_mask;
+	v |= field_val << __ffs(clk->clksel_mask);
+	__raw_writel(v, clk->clksel_reg);
+	v = __raw_readl(clk->clksel_reg);    /* OCP barrier */
+
+	omap2xxx_clk_commit(clk);
+
+	clk_reparent(clk, new_parent);
+
+	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
+	clk->rate = new_parent->rate;
+
+	if (parent_div > 0)
+		clk->rate /= parent_div;
+
+	pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
+		 clk->name, clk->parent->name, clk->rate);
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 9819628..d3ebb74 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -43,14 +43,14 @@ u8 cpu_mask;
  *-------------------------------------------------------------------------*/
 
 /**
- * _omap2xxx_clk_commit - commit clock parent/rate changes in hardware
+ * omap2xxx_clk_commit - commit clock parent/rate changes in hardware
  * @clk: struct clk *
  *
  * If @clk has the DELAYED_APP flag set, meaning that parent/rate changes
  * don't take effect until the VALID_CONFIG bit is written, write the
  * VALID_CONFIG bit and wait for the write to complete.  No return value.
  */
-static void _omap2xxx_clk_commit(struct clk *clk)
+void omap2xxx_clk_commit(struct clk *clk)
 {
 	if (!cpu_is_omap24xx())
 		return;
@@ -91,49 +91,6 @@ void omap2_init_clk_clkdm(struct clk *clk)
 }
 
 /**
- * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
- * @clk: OMAP clock struct ptr to use
- *
- * Given a pointer to a source-selectable struct clk, read the hardware
- * register and determine what its parent is currently set to.  Update the
- * clk->parent field with the appropriate clk ptr.
- */
-void omap2_init_clksel_parent(struct clk *clk)
-{
-	const struct clksel *clks;
-	const struct clksel_rate *clkr;
-	u32 r, found = 0;
-
-	if (!clk->clksel)
-		return;
-
-	r = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
-	r >>= __ffs(clk->clksel_mask);
-
-	for (clks = clk->clksel; clks->parent && !found; clks++) {
-		for (clkr = clks->rates; clkr->div && !found; clkr++) {
-			if ((clkr->flags & cpu_mask) && (clkr->val == r)) {
-				if (clk->parent != clks->parent) {
-					pr_debug("clock: inited %s parent "
-						 "to %s (was %s)\n",
-						 clk->name, clks->parent->name,
-						 ((clk->parent) ?
-						  clk->parent->name : "NULL"));
-					clk_reparent(clk, clks->parent);
-				};
-				found = 1;
-			}
-		}
-	}
-
-	if (!found)
-		printk(KERN_ERR "clock: init parent: could not find "
-		       "regval %0x for clock %s\n", r,  clk->name);
-
-	return;
-}
-
-/**
  * omap2_clk_dflt_find_companion - find companion clock to @clk
  * @clk: struct clk * to find the companion clock of
  * @other_reg: void __iomem ** to return the companion clock CM_*CLKEN va in
@@ -335,274 +292,6 @@ err:
 	return ret;
 }
 
-/*
- * Used for clocks that are part of CLKSEL_xyz governed clocks.
- * REVISIT: Maybe change to use clk->enable() functions like on omap1?
- */
-unsigned long omap2_clksel_recalc(struct clk *clk)
-{
-	unsigned long rate;
-	u32 div = 0;
-
-	pr_debug("clock: recalc'ing clksel clk %s\n", clk->name);
-
-	div = omap2_clksel_get_divisor(clk);
-	if (div == 0)
-		return clk->rate;
-
-	rate = clk->parent->rate / div;
-
-	pr_debug("clock: new clock rate is %ld (div %d)\n", rate, div);
-
-	return rate;
-}
-
-/**
- * omap2_get_clksel_by_parent - return clksel struct for a given clk & parent
- * @clk: OMAP struct clk ptr to inspect
- * @src_clk: OMAP struct clk ptr of the parent clk to search for
- *
- * Scan the struct clksel array associated with the clock to find
- * the element associated with the supplied parent clock address.
- * Returns a pointer to the struct clksel on success or NULL on error.
- */
-static const struct clksel *omap2_get_clksel_by_parent(struct clk *clk,
-						       struct clk *src_clk)
-{
-	const struct clksel *clks;
-
-	if (!clk->clksel)
-		return NULL;
-
-	for (clks = clk->clksel; clks->parent; clks++) {
-		if (clks->parent == src_clk)
-			break; /* Found the requested parent */
-	}
-
-	if (!clks->parent) {
-		printk(KERN_ERR "clock: Could not find parent clock %s in "
-		       "clksel array of clock %s\n", src_clk->name,
-		       clk->name);
-		return NULL;
-	}
-
-	return clks;
-}
-
-/**
- * omap2_clksel_round_rate_div - find divisor for the given clock and rate
- * @clk: OMAP struct clk to use
- * @target_rate: desired clock rate
- * @new_div: ptr to where we should store the divisor
- *
- * Finds 'best' divider value in an array based on the source and target
- * rates.  The divider array must be sorted with smallest divider first.
- * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
- * they are only settable as part of virtual_prcm set.
- *
- * Returns the rounded clock rate or returns 0xffffffff on error.
- */
-u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
-				u32 *new_div)
-{
-	unsigned long test_rate;
-	const struct clksel *clks;
-	const struct clksel_rate *clkr;
-	u32 last_div = 0;
-
-	pr_debug("clock: clksel_round_rate_div: %s target_rate %ld\n",
-		 clk->name, target_rate);
-
-	*new_div = 1;
-
-	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (!clks)
-		return ~0;
-
-	for (clkr = clks->rates; clkr->div; clkr++) {
-		if (!(clkr->flags & cpu_mask))
-		    continue;
-
-		/* Sanity check */
-		if (clkr->div <= last_div)
-			pr_err("clock: clksel_rate table not sorted "
-			       "for clock %s", clk->name);
-
-		last_div = clkr->div;
-
-		test_rate = clk->parent->rate / clkr->div;
-
-		if (test_rate <= target_rate)
-			break; /* found it */
-	}
-
-	if (!clkr->div) {
-		pr_err("clock: Could not find divisor for target "
-		       "rate %ld for clock %s parent %s\n", target_rate,
-		       clk->name, clk->parent->name);
-		return ~0;
-	}
-
-	*new_div = clkr->div;
-
-	pr_debug("clock: new_div = %d, new_rate = %ld\n", *new_div,
-		 (clk->parent->rate / clkr->div));
-
-	return (clk->parent->rate / clkr->div);
-}
-
-/**
- * omap2_clksel_round_rate - find rounded rate for the given clock and rate
- * @clk: OMAP struct clk to use
- * @target_rate: desired clock rate
- *
- * Compatibility wrapper for OMAP clock framework
- * Finds best target rate based on the source clock and possible dividers.
- * rates. The divider array must be sorted with smallest divider first.
- * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
- * they are only settable as part of virtual_prcm set.
- *
- * Returns the rounded clock rate or returns 0xffffffff on error.
- */
-long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
-{
-	u32 new_div;
-
-	return omap2_clksel_round_rate_div(clk, target_rate, &new_div);
-}
-
-
-/* Given a clock and a rate apply a clock specific rounding function */
-long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	if (clk->round_rate)
-		return clk->round_rate(clk, rate);
-
-	if (clk->flags & RATE_FIXED)
-		printk(KERN_ERR "clock: generic omap2_clk_round_rate called "
-		       "on fixed-rate clock %s\n", clk->name);
-
-	return clk->rate;
-}
-
-/**
- * omap2_clksel_to_divisor() - turn clksel field value into integer divider
- * @clk: OMAP struct clk to use
- * @field_val: register field value to find
- *
- * Given a struct clk of a rate-selectable clksel clock, and a register field
- * value to search for, find the corresponding clock divisor.  The register
- * field value should be pre-masked and shifted down so the LSB is at bit 0
- * before calling.  Returns 0 on error
- */
-u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val)
-{
-	const struct clksel *clks;
-	const struct clksel_rate *clkr;
-
-	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (!clks)
-		return 0;
-
-	for (clkr = clks->rates; clkr->div; clkr++) {
-		if ((clkr->flags & cpu_mask) && (clkr->val == field_val))
-			break;
-	}
-
-	if (!clkr->div) {
-		printk(KERN_ERR "clock: Could not find fieldval %d for "
-		       "clock %s parent %s\n", field_val, clk->name,
-		       clk->parent->name);
-		return 0;
-	}
-
-	return clkr->div;
-}
-
-/**
- * omap2_divisor_to_clksel() - turn clksel integer divisor into a field value
- * @clk: OMAP struct clk to use
- * @div: integer divisor to search for
- *
- * Given a struct clk of a rate-selectable clksel clock, and a clock divisor,
- * find the corresponding register field value.  The return register value is
- * the value before left-shifting.  Returns ~0 on error
- */
-u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
-{
-	const struct clksel *clks;
-	const struct clksel_rate *clkr;
-
-	/* should never happen */
-	WARN_ON(div == 0);
-
-	clks = omap2_get_clksel_by_parent(clk, clk->parent);
-	if (!clks)
-		return ~0;
-
-	for (clkr = clks->rates; clkr->div; clkr++) {
-		if ((clkr->flags & cpu_mask) && (clkr->div == div))
-			break;
-	}
-
-	if (!clkr->div) {
-		printk(KERN_ERR "clock: Could not find divisor %d for "
-		       "clock %s parent %s\n", div, clk->name,
-		       clk->parent->name);
-		return ~0;
-	}
-
-	return clkr->val;
-}
-
-/**
- * omap2_clksel_get_divisor - get current divider applied to parent clock.
- * @clk: OMAP struct clk to use.
- *
- * Returns the integer divisor upon success or 0 on error.
- */
-u32 omap2_clksel_get_divisor(struct clk *clk)
-{
-	u32 v;
-
-	if (!clk->clksel_mask)
-		return 0;
-
-	v = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
-	v >>= __ffs(clk->clksel_mask);
-
-	return omap2_clksel_to_divisor(clk, v);
-}
-
-int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
-{
-	u32 v, field_val, validrate, new_div = 0;
-
-	if (!clk->clksel_mask)
-		return -EINVAL;
-
-	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
-	if (validrate != rate)
-		return -EINVAL;
-
-	field_val = omap2_divisor_to_clksel(clk, new_div);
-	if (field_val == ~0)
-		return -EINVAL;
-
-	v = __raw_readl(clk->clksel_reg);
-	v &= ~clk->clksel_mask;
-	v |= field_val << __ffs(clk->clksel_mask);
-	__raw_writel(v, clk->clksel_reg);
-	v = __raw_readl(clk->clksel_reg); /* OCP barrier */
-
-	clk->rate = clk->parent->rate / new_div;
-
-	_omap2xxx_clk_commit(clk);
-
-	return 0;
-}
-
-
 /* Set the clock rate for a clock source */
 int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 {
@@ -622,75 +311,15 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 	return ret;
 }
 
-/*
- * Converts encoded control register address into a full address
- * On error, the return value (parent_div) will be 0.
- */
-static u32 _omap2_clksel_get_src_field(struct clk *src_clk, struct clk *clk,
-				       u32 *field_val)
-{
-	const struct clksel *clks;
-	const struct clksel_rate *clkr;
-
-	clks = omap2_get_clksel_by_parent(clk, src_clk);
-	if (!clks)
-		return 0;
-
-	for (clkr = clks->rates; clkr->div; clkr++) {
-		if (clkr->flags & cpu_mask && clkr->flags & DEFAULT_RATE)
-			break; /* Found the default rate for this platform */
-	}
-
-	if (!clkr->div) {
-		printk(KERN_ERR "clock: Could not find default rate for "
-		       "clock %s parent %s\n", clk->name,
-		       src_clk->parent->name);
-		return 0;
-	}
-
-	/* Should never happen.  Add a clksel mask to the struct clk. */
-	WARN_ON(clk->clksel_mask == 0);
-
-	*field_val = clkr->val;
-
-	return clkr->div;
-}
-
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
-	u32 field_val, v, parent_div;
-
 	if (clk->flags & CONFIG_PARTICIPANT)
 		return -EINVAL;
 
 	if (!clk->clksel)
 		return -EINVAL;
 
-	parent_div = _omap2_clksel_get_src_field(new_parent, clk, &field_val);
-	if (!parent_div)
-		return -EINVAL;
-
-	/* Set new source value (previous dividers if any in effect) */
-	v = __raw_readl(clk->clksel_reg);
-	v &= ~clk->clksel_mask;
-	v |= field_val << __ffs(clk->clksel_mask);
-	__raw_writel(v, clk->clksel_reg);
-	v = __raw_readl(clk->clksel_reg);    /* OCP barrier */
-
-	_omap2xxx_clk_commit(clk);
-
-	clk_reparent(clk, new_parent);
-
-	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
-	clk->rate = new_parent->rate;
-
-	if (parent_div > 0)
-		clk->rate /= parent_div;
-
-	pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
-		 clk->name, clk->parent->name, clk->rate);
-
-	return 0;
+	return omap2_clksel_set_parent(clk, new_parent);
 }
 
 /*-------------------------------------------------------------------------
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 0d70dc0..0d21702 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -80,6 +80,7 @@ u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val);
 u32 omap2_divisor_to_clksel(struct clk *clk, u32 div);
 long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
+int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent);
 u32 omap2_get_dpll_rate(struct clk *clk);
 void omap2_init_dpll_parent(struct clk *clk);
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
@@ -90,6 +91,7 @@ void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
 				   u8 *other_bit);
 void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
 				u8 *idlest_bit);
+void omap2xxx_clk_commit(struct clk *clk);
 
 extern u8 cpu_mask;
 


