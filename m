From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 2/7] HACK: omap4: clk: convert to common struct clk
Date: Tue, 13 Dec 2011 20:11:53 -0800
Message-ID: <1323835918-2371-3-git-send-email-mturquette@ti.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55429 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754417Ab1LNEQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:16:04 -0500
Received: by mail-gy0-f180.google.com with SMTP id r1so316225ghr.25
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:16:02 -0800 (PST)
In-Reply-To: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

This is a pile of code to convert the OMAP4 clk framework over to the
common struct clk definition and it's supporting functions.

Note that this only works for OMAP4, and I have only tested it on Panda.
This patch is only for testing purposes and to kick off discussion of
how we want to reshape the OMAP clk framework for the new way of doing
things.

Again... this patch was done in a hurry to get things booting, so try
not to nitpick the gross stuff.  It's more important to focus on what
future data structures and the layout of the OMAP clk code will look
like.

Not-signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clkt_clksel.c       |  195 +++++++++--------
 arch/arm/mach-omap2/clkt_dpll.c         |   54 +++--
 arch/arm/mach-omap2/clock.c             |  363 +++++++++++--------------------
 arch/arm/mach-omap2/clock.h             |   59 +++--
 arch/arm/mach-omap2/dpll3xxx.c          |  228 +++++++++++---------
 arch/arm/mach-omap2/dpll44xx.c          |   62 ++++--
 arch/arm/plat-omap/clock.c              |  315 +++++++++-----------------
 arch/arm/plat-omap/include/plat/clock.h |   96 +++-----
 8 files changed, 618 insertions(+), 754 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index e25364d..ad3befb 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -1,12 +1,13 @@
 /*
  * clkt_clksel.c - OMAP2/3/4 clksel clock functions
  *
- * Copyright (C) 2005-2008 Texas Instruments, Inc.
+ * Copyright (C) 2005-2011 Texas Instruments, Inc.
  * Copyright (C) 2004-2010 Nokia Corporation
  *
  * Contacts:
  * Richard Woodruff <r-woodruff2@ti.com>
  * Paul Walmsley
+ * Mike Turquette <mturquette@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -43,6 +44,7 @@
 #include <linux/errno.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/err.h>
 
 #include <plat/clock.h>
 
@@ -59,19 +61,19 @@
  * the element associated with the supplied parent clock address.
  * Returns a pointer to the struct clksel on success or NULL on error.
  */
-static const struct clksel *_get_clksel_by_parent(struct clk *clk,
+static const struct clksel *_get_clksel_by_parent(struct clk_hw_omap *oclk,
 						  struct clk *src_clk)
 {
 	const struct clksel *clks;
 
-	for (clks = clk->clksel; clks->parent; clks++)
+	for (clks = oclk->clksel; clks->parent; clks++)
 		if (clks->parent == src_clk)
 			break; /* Found the requested parent */
 
 	if (!clks->parent) {
 		/* This indicates a data problem */
 		WARN(1, "clock: Could not find parent clock %s in clksel array "
-		     "of clock %s\n", src_clk->name, clk->name);
+		     "of clock %s\n", src_clk->name, oclk->clk.name);
 		return NULL;
 	}
 
@@ -93,14 +95,14 @@ static const struct clksel *_get_clksel_by_parent(struct clk *clk,
  * success (in this latter case, the corresponding register bitfield
  * value is passed back in the variable pointed to by @field_val)
  */
-static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
+static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk_hw_omap *oclk,
 				u32 *field_val)
 {
 	const struct clksel *clks;
 	const struct clksel_rate *clkr, *max_clkr = NULL;
 	u8 max_div = 0;
 
-	clks = _get_clksel_by_parent(clk, src_clk);
+	clks = _get_clksel_by_parent(oclk, src_clk);
 	if (!clks)
 		return 0;
 
@@ -126,7 +128,7 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
 	if (max_div == 0) {
 		/* This indicates an error in the clksel data */
 		WARN(1, "clock: Could not find divisor for clock %s parent %s"
-		     "\n", clk->name, src_clk->parent->name);
+		     "\n", oclk->clk.name, src_clk->parent->name);
 		return 0;
 	}
 
@@ -148,16 +150,16 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
  * take into account any time the hardware might take to switch the
  * clock source.
  */
-static void _write_clksel_reg(struct clk *clk, u32 field_val)
+static void _write_clksel_reg(struct clk_hw_omap *oclk, u32 field_val)
 {
 	u32 v;
 
-	v = __raw_readl(clk->clksel_reg);
-	v &= ~clk->clksel_mask;
-	v |= field_val << __ffs(clk->clksel_mask);
-	__raw_writel(v, clk->clksel_reg);
+	v = __raw_readl(oclk->clksel_reg);
+	v &= ~oclk->clksel_mask;
+	v |= field_val << __ffs(oclk->clksel_mask);
+	__raw_writel(v, oclk->clksel_reg);
 
-	v = __raw_readl(clk->clksel_reg); /* OCP barrier */
+	v = __raw_readl(oclk->clksel_reg); /* OCP barrier */
 }
 
 /**
@@ -171,12 +173,12 @@ static void _write_clksel_reg(struct clk *clk, u32 field_val)
  * before calling.  Returns 0 on error or returns the actual integer divisor
  * upon success.
  */
-static u32 _clksel_to_divisor(struct clk *clk, u32 field_val)
+static u32 _clksel_to_divisor(struct clk_hw_omap *oclk, u32 field_val)
 {
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
 
-	clks = _get_clksel_by_parent(clk, clk->parent);
+	clks = _get_clksel_by_parent(oclk, oclk->clk.parent);
 	if (!clks)
 		return 0;
 
@@ -190,8 +192,9 @@ static u32 _clksel_to_divisor(struct clk *clk, u32 field_val)
 
 	if (!clkr->div) {
 		/* This indicates a data error */
-		WARN(1, "clock: Could not find fieldval %d for clock %s parent "
-		     "%s\n", field_val, clk->name, clk->parent->name);
+		WARN(1, "%s: Could not find fieldval %d for clock %s parent %s\n",
+			__func__, field_val, oclk->clk.name,
+			oclk->clk.parent->name);
 		return 0;
 	}
 
@@ -208,7 +211,7 @@ static u32 _clksel_to_divisor(struct clk *clk, u32 field_val)
  * register field value _before_ left-shifting (i.e., LSB is at bit
  * 0); or returns 0xFFFFFFFF (~0) upon error.
  */
-static u32 _divisor_to_clksel(struct clk *clk, u32 div)
+static u32 _divisor_to_clksel(struct clk_hw_omap *oclk, u32 div)
 {
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
@@ -216,7 +219,7 @@ static u32 _divisor_to_clksel(struct clk *clk, u32 div)
 	/* should never happen */
 	WARN_ON(div == 0);
 
-	clks = _get_clksel_by_parent(clk, clk->parent);
+	clks = _get_clksel_by_parent(oclk, oclk->clk.parent);
 	if (!clks)
 		return ~0;
 
@@ -229,8 +232,8 @@ static u32 _divisor_to_clksel(struct clk *clk, u32 div)
 	}
 
 	if (!clkr->div) {
-		pr_err("clock: Could not find divisor %d for clock %s parent "
-		       "%s\n", div, clk->name, clk->parent->name);
+		pr_err("%s: Could not find divisor %d for clock %s parent %s\n",
+				__func__, div, oclk->clk.name, oclk->clk.parent->name);
 		return ~0;
 	}
 
@@ -245,18 +248,18 @@ static u32 _divisor_to_clksel(struct clk *clk, u32 div)
  * into the hardware, convert it into the actual divisor value, and
  * return it; or return 0 on error.
  */
-static u32 _read_divisor(struct clk *clk)
+static u32 _read_divisor(struct clk_hw_omap *oclk)
 {
 	u32 v;
 
-	if (!clk->clksel || !clk->clksel_mask)
+	if (!oclk->clksel || !oclk->clksel_mask)
 		return 0;
 
-	v = __raw_readl(clk->clksel_reg);
-	v &= clk->clksel_mask;
-	v >>= __ffs(clk->clksel_mask);
+	v = __raw_readl(oclk->clksel_reg);
+	v &= oclk->clksel_mask;
+	v >>= __ffs(oclk->clksel_mask);
 
-	return _clksel_to_divisor(clk, v);
+	return _clksel_to_divisor(oclk, v);
 }
 
 /* Public functions */
@@ -273,23 +276,26 @@ static u32 _read_divisor(struct clk *clk)
  *
  * Returns the rounded clock rate or returns 0xffffffff on error.
  */
-u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
-				u32 *new_div)
+u32 omap2_clksel_round_rate_div(struct clk_hw_omap *oclk,
+		unsigned long target_rate, u32 *new_div)
 {
 	unsigned long test_rate;
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
+	struct clk *parent;
 	u32 last_div = 0;
 
-	if (!clk->clksel || !clk->clksel_mask)
+	parent = oclk->clk.parent;
+
+	if (!oclk->clksel || !oclk->clksel_mask)
 		return ~0;
 
-	pr_debug("clock: clksel_round_rate_div: %s target_rate %ld\n",
-		 clk->name, target_rate);
+	pr_debug("%s: clksel_round_rate_div: %s target_rate %ld\n",
+		 __func__, oclk->clk.name, target_rate);
 
 	*new_div = 1;
 
-	clks = _get_clksel_by_parent(clk, clk->parent);
+	clks = _get_clksel_by_parent(oclk, parent);
 	if (!clks)
 		return ~0;
 
@@ -299,30 +305,30 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 
 		/* Sanity check */
 		if (clkr->div <= last_div)
-			pr_err("clock: clksel_rate table not sorted "
-			       "for clock %s", clk->name);
+			pr_err("%s: clksel_rate table not sorted for clock %s",
+					__func__, oclk->clk.name);
 
 		last_div = clkr->div;
 
-		test_rate = clk->parent->rate / clkr->div;
+		test_rate = parent->rate / clkr->div;
 
 		if (test_rate <= target_rate)
 			break; /* found it */
 	}
 
 	if (!clkr->div) {
-		pr_err("clock: Could not find divisor for target "
-		       "rate %ld for clock %s parent %s\n", target_rate,
-		       clk->name, clk->parent->name);
+		pr_err("%s: Could not find divisor for target rate %ld for clock %s parent %s\n",
+				__func__, target_rate, oclk->clk.name,
+				parent->name);
 		return ~0;
 	}
 
 	*new_div = clkr->div;
 
 	pr_debug("clock: new_div = %d, new_rate = %ld\n", *new_div,
-		 (clk->parent->rate / clkr->div));
+		 (parent->rate / clkr->div));
 
-	return clk->parent->rate / clkr->div;
+	return parent->rate / clkr->div;
 }
 
 /*
@@ -339,42 +345,45 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
  * to.  Update @clk's .parent field with the appropriate clk ptr.  No
  * return value.
  */
-void omap2_init_clksel_parent(struct clk *clk)
+struct clk *omap2_init_clksel_parent(struct clk *clk)
 {
+	struct clk_hw_omap *oclk;
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
-	u32 r, found = 0;
+	u32 r;
+
+	oclk = to_clk_hw_omap(clk);
 
-	if (!clk->clksel || !clk->clksel_mask)
-		return;
+	if (!oclk->clksel || !oclk->clksel_mask)
+		return ERR_PTR(-EINVAL);
 
-	r = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
-	r >>= __ffs(clk->clksel_mask);
+	r = __raw_readl(oclk->clksel_reg) & oclk->clksel_mask;
+	r >>= __ffs(oclk->clksel_mask);
 
-	for (clks = clk->clksel; clks->parent && !found; clks++) {
-		for (clkr = clks->rates; clkr->div && !found; clkr++) {
+	for (clks = oclk->clksel; clks->parent; clks++) {
+		for (clkr = clks->rates; clkr->div; clkr++) {
 			if (!(clkr->flags & cpu_mask))
 				continue;
 
 			if (clkr->val == r) {
-				if (clk->parent != clks->parent) {
-					pr_debug("clock: inited %s parent "
-						 "to %s (was %s)\n",
-						 clk->name, clks->parent->name,
-						 ((clk->parent) ?
-						  clk->parent->name : "NULL"));
-					clk_reparent(clk, clks->parent);
+				if (oclk->clk.parent != clks->parent) {
+					pr_debug("clock: inited %s parent to %s (was %s)\n",
+							oclk->clk.name,
+							clks->parent->name,
+							((oclk->clk.parent) ?
+							 oclk->clk.parent->name :
+							 "NULL"));
 				};
-				found = 1;
+				return clks->parent;
 			}
 		}
 	}
 
 	/* This indicates a data error */
-	WARN(!found, "clock: %s: init parent: could not find regval %0x\n",
-	     clk->name, r);
+	WARN(1, "clock: %s: init parent: could not find regval %0x\n",
+	     oclk->clk.name, r);
 
-	return;
+	return ERR_PTR(-ENODEV);
 }
 
 /**
@@ -388,17 +397,21 @@ void omap2_init_clksel_parent(struct clk *clk)
  */
 unsigned long omap2_clksel_recalc(struct clk *clk)
 {
+	struct clk_hw_omap *oclk;
 	unsigned long rate;
 	u32 div = 0;
 
-	div = _read_divisor(clk);
-	if (div == 0)
-		return clk->rate;
+	oclk = to_clk_hw_omap(clk);
+
+	div = _read_divisor(oclk);
 
-	rate = clk->parent->rate / div;
+	if (!div)
+		rate = oclk->clk.parent->rate;
+	else
+		rate = oclk->clk.parent->rate / div;
 
-	pr_debug("clock: %s: recalc'd rate is %ld (div %d)\n", clk->name,
-		 rate, div);
+	pr_debug("%s: recalc'd %s's rate to %lu (div %d)\n", __func__,
+			oclk->clk.name, rate, div);
 
 	return rate;
 }
@@ -414,11 +427,15 @@ unsigned long omap2_clksel_recalc(struct clk *clk)
  *
  * Returns the rounded clock rate or returns 0xffffffff on error.
  */
-long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
+long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate,
+		unsigned long *parent_rate)
 {
+	struct clk_hw_omap *oclk;
 	u32 new_div;
 
-	return omap2_clksel_round_rate_div(clk, target_rate, &new_div);
+	oclk = to_clk_hw_omap(clk);
+
+	return omap2_clksel_round_rate_div(oclk, target_rate, &new_div);
 }
 
 /**
@@ -438,24 +455,31 @@ long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
  */
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 {
+	struct clk_hw_omap *oclk;
 	u32 field_val, validrate, new_div = 0;
 
-	if (!clk->clksel || !clk->clksel_mask)
+	if (clk->rate == rate)
+		return 0;
+
+	oclk = to_clk_hw_omap(clk);
+
+	if (!oclk->clksel || !oclk->clksel_mask)
 		return -EINVAL;
 
-	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
+	validrate = omap2_clksel_round_rate_div(oclk, rate, &new_div);
 	if (validrate != rate)
 		return -EINVAL;
 
-	field_val = _divisor_to_clksel(clk, new_div);
+	field_val = _divisor_to_clksel(oclk, new_div);
 	if (field_val == ~0)
 		return -EINVAL;
 
-	_write_clksel_reg(clk, field_val);
-
-	clk->rate = clk->parent->rate / new_div;
+	_write_clksel_reg(oclk, field_val);
 
-	pr_debug("clock: %s: set rate to %ld\n", clk->name, clk->rate);
+	pr_debug("%s: parent->rate is %lu, new_div is %lu, new rate is %lu\n",
+			__func__, oclk->clk.parent->rate,
+			(unsigned long) new_div,
+			(oclk->clk.parent->rate / new_div));
 
 	return 0;
 }
@@ -482,28 +506,23 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
  */
 int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent)
 {
+	struct clk_hw_omap *oclk;
 	u32 field_val = 0;
 	u32 parent_div;
 
-	if (!clk->clksel || !clk->clksel_mask)
+	oclk = to_clk_hw_omap(clk);
+
+	if (!oclk->clksel || !oclk->clksel_mask)
 		return -EINVAL;
 
-	parent_div = _get_div_and_fieldval(new_parent, clk, &field_val);
+	parent_div = _get_div_and_fieldval(new_parent, oclk, &field_val);
 	if (!parent_div)
 		return -EINVAL;
 
-	_write_clksel_reg(clk, field_val);
-
-	clk_reparent(clk, new_parent);
-
-	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
-	clk->rate = new_parent->rate;
-
-	if (parent_div > 0)
-		clk->rate /= parent_div;
+	_write_clksel_reg(oclk, field_val);
 
-	pr_debug("clock: %s: set parent to %s (new rate %ld)\n",
-		 clk->name, clk->parent->name, clk->rate);
+	pr_debug("%s: re-parented %s to %s (new rate %lu)\n", __func__,
+			oclk->clk.name, oclk->clk.parent->name, oclk->clk.rate);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index e069a9b..929e9d7 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -1,12 +1,13 @@
 /*
  * OMAP2/3/4 DPLL clock functions
  *
- * Copyright (C) 2005-2008 Texas Instruments, Inc.
+ * Copyright (C) 2005-2011 Texas Instruments, Inc.
  * Copyright (C) 2004-2010 Nokia Corporation
  *
  * Contacts:
  * Richard Woodruff <r-woodruff2@ti.com>
  * Paul Walmsley
+ * Mike Turquette <mturquette@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -16,6 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 
@@ -77,16 +79,16 @@
  * (assuming that it is counting N upwards), or -2 if the enclosing loop
  * should skip to the next iteration (again assuming N is increasing).
  */
-static int _dpll_test_fint(struct clk *clk, u8 n)
+static int _dpll_test_fint(struct clk_hw_omap *oclk, u8 n)
 {
 	struct dpll_data *dd;
 	long fint, fint_min, fint_max;
 	int ret = 0;
 
-	dd = clk->dpll_data;
+	dd = oclk->dpll_data;
 
 	/* DPLL divider must result in a valid jitter correction val */
-	fint = clk->parent->rate / n;
+	fint = oclk->clk.parent->rate / n;
 
 	if (cpu_is_omap24xx()) {
 		/* Should not be called for OMAP2, so warn if it is called */
@@ -188,14 +190,17 @@ static int _dpll_test_mult(int *m, int n, unsigned long *new_rate,
 
 /* Public functions */
 
-void omap2_init_dpll_parent(struct clk *clk)
+struct clk *omap2_init_dpll_parent(struct clk *clk)
 {
 	u32 v;
 	struct dpll_data *dd;
+	struct clk_hw_omap *oclk;
 
-	dd = clk->dpll_data;
+	oclk = to_clk_hw_omap(clk);
+
+	dd = oclk->dpll_data;
 	if (!dd)
-		return;
+		return ERR_PTR(-EINVAL);
 
 	v = __raw_readl(dd->control_reg);
 	v &= dd->enable_mask;
@@ -205,18 +210,18 @@ void omap2_init_dpll_parent(struct clk *clk)
 	if (cpu_is_omap24xx()) {
 		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
-			clk_reparent(clk, dd->clk_bypass);
+			return dd->clk_bypass;
 	} else if (cpu_is_omap34xx()) {
 		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
-			clk_reparent(clk, dd->clk_bypass);
+			return dd->clk_bypass;
 	} else if (cpu_is_omap44xx()) {
 		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
 		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
-			clk_reparent(clk, dd->clk_bypass);
+			return dd->clk_bypass;
 	}
-	return;
+	return dd->clk_ref;
 }
 
 /**
@@ -233,13 +238,13 @@ void omap2_init_dpll_parent(struct clk *clk)
  * locked, or the appropriate bypass rate if the DPLL is bypassed, or 0
  * if the clock @clk is not a DPLL.
  */
-u32 omap2_get_dpll_rate(struct clk *clk)
+unsigned long omap2_get_dpll_rate(struct clk_hw_omap *oclk)
 {
 	long long dpll_clk;
 	u32 dpll_mult, dpll_div, v;
 	struct dpll_data *dd;
 
-	dd = clk->dpll_data;
+	dd = oclk->dpll_data;
 	if (!dd)
 		return 0;
 
@@ -289,20 +294,24 @@ u32 omap2_get_dpll_rate(struct clk *clk)
  * (expensive) function again.  Returns ~0 if the target rate cannot
  * be rounded, or the rounded rate upon success.
  */
-long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
+long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate,
+		unsigned long *parent_rate)
 {
 	int m, n, r, scaled_max_m;
 	unsigned long scaled_rt_rp;
 	unsigned long new_rate = 0;
 	struct dpll_data *dd;
+	struct clk_hw_omap *oclk;
+
+	oclk = to_clk_hw_omap(clk);
 
-	if (!clk || !clk->dpll_data)
+	if (!oclk->dpll_data)
 		return ~0;
 
-	dd = clk->dpll_data;
+	dd = oclk->dpll_data;
 
-	pr_debug("clock: %s: starting DPLL round_rate, target rate %ld\n",
-		 clk->name, target_rate);
+	pr_debug("%s: starting DPLL round_rate for %s, target rate %ld\n",
+			__func__, oclk->clk.name, target_rate);
 
 	scaled_rt_rp = target_rate / (dd->clk_ref->rate / DPLL_SCALE_FACTOR);
 	scaled_max_m = dd->max_multiplier * DPLL_SCALE_FACTOR;
@@ -312,7 +321,7 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 	for (n = dd->min_divider; n <= dd->max_divider; n++) {
 
 		/* Is the (input clk, divider) pair valid for the DPLL? */
-		r = _dpll_test_fint(clk, n);
+		r = _dpll_test_fint(oclk, n);
 		if (r == DPLL_FINT_UNDERFLOW)
 			break;
 		else if (r == DPLL_FINT_INVALID)
@@ -338,7 +347,7 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 			continue;
 
 		pr_debug("clock: %s: m = %d: n = %d: new_rate = %ld\n",
-			 clk->name, m, n, new_rate);
+			 oclk->clk.name, m, n, new_rate);
 
 		if (target_rate == new_rate) {
 			dd->last_rounded_m = m;
@@ -349,11 +358,10 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 	}
 
 	if (target_rate != new_rate) {
-		pr_debug("clock: %s: cannot round to rate %ld\n", clk->name,
-			 target_rate);
+		pr_debug("%s: cannot round %s's rate to %ld\n", __func__,
+				oclk->clk.name, target_rate);
 		return ~0;
 	}
 
 	return target_rate;
 }
-
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 1f3481f..24fd97e 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -37,6 +37,19 @@
 
 u8 cpu_mask;
 
+struct clk_hw_ops dummy_ck_ops = {
+	.get_parent	= &omap2_get_parent_fixed,
+};
+
+struct clk_hw_omap dummy_ck_hw = {
+	.clk = {
+		.name	= "dummy_clk",
+		.ops	= &dummy_ck_ops,
+	},
+};
+
+//struct clk *dummy_ck = &dummy_ck_hw.clk;
+
 /*
  * clkdm_control: if true, then when a clock is enabled in the
  * hardware, its clockdomain will first be enabled; and when a clock
@@ -61,22 +74,22 @@ static bool clkdm_control = true;
  * belong in the clock code and will be moved in the medium term to
  * module-dependent code.  No return value.
  */
-static void _omap2_module_wait_ready(struct clk *clk)
+static void _omap2_module_wait_ready(struct clk_hw_omap *oclk)
 {
 	void __iomem *companion_reg, *idlest_reg;
 	u8 other_bit, idlest_bit, idlest_val;
 
 	/* Not all modules have multiple clocks that their IDLEST depends on */
-	if (clk->ops->find_companion) {
-		clk->ops->find_companion(clk, &companion_reg, &other_bit);
+	if (oclk->find_companion) {
+		oclk->find_companion(oclk, &companion_reg, &other_bit);
 		if (!(__raw_readl(companion_reg) & (1 << other_bit)))
 			return;
 	}
 
-	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit, &idlest_val);
+	oclk->find_idlest(oclk, &idlest_reg, &idlest_bit, &idlest_val);
 
 	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), idlest_val,
-			     clk->name);
+			oclk->clk.name);
 }
 
 /* Public functions */
@@ -89,21 +102,27 @@ static void _omap2_module_wait_ready(struct clk *clk)
  * clockdomain pointer, and save it into the struct clk.  Intended to be
  * called during clk_register().  No return value.
  */
+/* FIXME should this get folded into clk-specific "clk_hw_init"? */
 void omap2_init_clk_clkdm(struct clk *clk)
 {
+	struct clk_hw_omap *oclk;
 	struct clockdomain *clkdm;
 
-	if (!clk->clkdm_name)
+	oclk = to_clk_hw_omap(clk);
+
+	//pr_err("%s: %s is here0\n", __func__, clk->name);
+	if (!oclk->clkdm_name)
 		return;
+	//pr_err("%s: %s is here1, oclk->clkdm_name is %s\n", __func__, clk->name, oclk->clkdm_name);
 
-	clkdm = clkdm_lookup(clk->clkdm_name);
+	clkdm = clkdm_lookup(oclk->clkdm_name);
 	if (clkdm) {
-		pr_debug("clock: associated clk %s to clkdm %s\n",
-			 clk->name, clk->clkdm_name);
-		clk->clkdm = clkdm;
+		pr_debug("%s: associated clk %s to clkdm %s\n",
+			 __func__, clk->name, oclk->clkdm_name);
+		oclk->clkdm = clkdm;
 	} else {
-		pr_debug("clock: could not associate clk %s to "
-			 "clkdm %s\n", clk->name, clk->clkdm_name);
+		pr_debug("%s: could not associate clk %s to clkdm %s\n",
+				__func__, clk->name, oclk->clkdm_name);
 	}
 }
 
@@ -141,8 +160,14 @@ void __init omap2_clk_disable_clkdm_control(void)
  * associate this type of code with per-module data structures to
  * avoid this issue, and remove the casts.  No return value.
  */
-void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
-				   u8 *other_bit)
+/*
+ * FIXME should "internal" functions like this be renamed to
+ * __omap2_clk_dflt_find_companion, and also accept struct clk_hw_omap instead
+ * struct clk?  Makes sense to me since this function pointer is *in* struct
+ * clk_hw_omap anyways...
+ */
+void omap2_clk_dflt_find_companion(struct clk_hw_omap *oclk, void __iomem **other_reg,
+		u8 *other_bit)
 {
 	u32 r;
 
@@ -150,10 +175,10 @@ void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
 	 * Convert CM_ICLKEN* <-> CM_FCLKEN*.  This conversion assumes
 	 * it's just a matter of XORing the bits.
 	 */
-	r = ((__force u32)clk->enable_reg ^ (CM_FCLKEN ^ CM_ICLKEN));
+	r = ((__force u32)oclk->enable_reg ^ (CM_FCLKEN ^ CM_ICLKEN));
 
 	*other_reg = (__force void __iomem *)r;
-	*other_bit = clk->enable_bit;
+	*other_bit = oclk->enable_bit;
 }
 
 /**
@@ -170,14 +195,14 @@ void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
  * register address ID (e.g., that CM_FCLKEN2 corresponds to
  * CM_IDLEST2).  This is not true for all modules.  No return value.
  */
-void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
-				u8 *idlest_bit, u8 *idlest_val)
+void omap2_clk_dflt_find_idlest(struct clk_hw_omap *oclk,
+		void __iomem **idlest_reg, u8 *idlest_bit, u8 *idlest_val)
 {
 	u32 r;
 
-	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+	r = (((__force u32)oclk->enable_reg & ~0xf0) | 0x20);
 	*idlest_reg = (__force void __iomem *)r;
-	*idlest_bit = clk->enable_bit;
+	*idlest_bit = oclk->enable_bit;
 
 	/*
 	 * 24xx uses 0 to indicate not ready, and 1 to indicate ready.
@@ -195,231 +220,82 @@ void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
 
 int omap2_dflt_clk_enable(struct clk *clk)
 {
+	struct clk_hw_omap *oclk;
 	u32 v;
+	int ret = 0;
+
+	oclk = to_clk_hw_omap(clk);
 
-	if (unlikely(clk->enable_reg == NULL)) {
-		pr_err("clock.c: Enable for %s without enable code\n",
-		       clk->name);
-		return 0; /* REVISIT: -EINVAL */
+	if (clkdm_control && oclk->clkdm) {
+		ret = clkdm_clk_enable(oclk->clkdm, &oclk->clk);
+		if (ret) {
+			WARN(1, "%s: could not enable %s's clockdomain %s: %d\n",
+					__func__, oclk->clk.name,
+					oclk->clkdm->name, ret);
+			goto out;
+		}
 	}
 
-	v = __raw_readl(clk->enable_reg);
-	if (clk->flags & INVERT_ENABLE)
-		v &= ~(1 << clk->enable_bit);
+	if (unlikely(oclk->enable_reg == NULL)) {
+		pr_err("%s: %s missing enable_reg\n", __func__, oclk->clk.name);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* FIXME should not have INVERT_ENABLE bit here */
+	v = __raw_readl(oclk->enable_reg);
+	if (oclk->flags & INVERT_ENABLE)
+		v &= ~(1 << oclk->enable_bit);
 	else
-		v |= (1 << clk->enable_bit);
-	__raw_writel(v, clk->enable_reg);
-	v = __raw_readl(clk->enable_reg); /* OCP barrier */
+		v |= (1 << oclk->enable_bit);
+	__raw_writel(v, oclk->enable_reg);
+	v = __raw_readl(oclk->enable_reg); /* OCP barrier */
 
-	if (clk->ops->find_idlest)
-		_omap2_module_wait_ready(clk);
+	if (oclk->find_idlest)
+		_omap2_module_wait_ready(oclk);
 
-	return 0;
+err:
+	if (clkdm_control && oclk->clkdm)
+		clkdm_clk_disable(oclk->clkdm, &oclk->clk);
+out:
+	return ret;
 }
 
 void omap2_dflt_clk_disable(struct clk *clk)
 {
+	struct clk_hw_omap *oclk;
 	u32 v;
 
-	if (!clk->enable_reg) {
+	oclk = to_clk_hw_omap(clk);
+
+	if (!oclk->enable_reg) {
 		/*
-		 * 'Independent' here refers to a clock which is not
+		 * 'independent' here refers to a clock which is not
 		 * controlled by its parent.
 		 */
-		printk(KERN_ERR "clock: clk_disable called on independent "
-		       "clock %s which has no enable_reg\n", clk->name);
+		pr_err("%s: independent clock %s has no enable_reg\n",
+				__func__, oclk->clk.name);
 		return;
 	}
 
-	v = __raw_readl(clk->enable_reg);
-	if (clk->flags & INVERT_ENABLE)
-		v |= (1 << clk->enable_bit);
+	v = __raw_readl(oclk->enable_reg);
+	if (oclk->flags & INVERT_ENABLE)
+		v |= (1 << oclk->enable_bit);
 	else
-		v &= ~(1 << clk->enable_bit);
-	__raw_writel(v, clk->enable_reg);
+		v &= ~(1 << oclk->enable_bit);
+	__raw_writel(v, oclk->enable_reg);
 	/* No OCP barrier needed here since it is a disable operation */
-}
-
-const struct clkops clkops_omap2_dflt_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_companion	= omap2_clk_dflt_find_companion,
-	.find_idlest	= omap2_clk_dflt_find_idlest,
-};
-
-const struct clkops clkops_omap2_dflt = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-};
-
-/**
- * omap2_clk_disable - disable a clock, if the system is not using it
- * @clk: struct clk * to disable
- *
- * Decrements the usecount on struct clk @clk.  If there are no users
- * left, call the clkops-specific clock disable function to disable it
- * in hardware.  If the clock is part of a clockdomain (which they all
- * should be), request that the clockdomain be disabled.  (It too has
- * a usecount, and so will not be disabled in the hardware until it no
- * longer has any users.)  If the clock has a parent clock (most of
- * them do), then call ourselves, recursing on the parent clock.  This
- * can cause an entire branch of the clock tree to be powered off by
- * simply disabling one clock.  Intended to be called with the clockfw_lock
- * spinlock held.  No return value.
- */
-void omap2_clk_disable(struct clk *clk)
-{
-	if (clk->usecount == 0) {
-		WARN(1, "clock: %s: omap2_clk_disable() called, but usecount "
-		     "already 0?", clk->name);
-		return;
-	}
 
-	pr_debug("clock: %s: decrementing usecount\n", clk->name);
-
-	clk->usecount--;
-
-	if (clk->usecount > 0)
-		return;
-
-	pr_debug("clock: %s: disabling in hardware\n", clk->name);
-
-	if (clk->ops && clk->ops->disable) {
-		trace_clock_disable(clk->name, 0, smp_processor_id());
-		clk->ops->disable(clk);
-	}
-
-	if (clkdm_control && clk->clkdm)
-		clkdm_clk_disable(clk->clkdm, clk);
-
-	if (clk->parent)
-		omap2_clk_disable(clk->parent);
+	if (clkdm_control && oclk->clkdm)
+		clkdm_clk_disable(oclk->clkdm, &oclk->clk);
 }
 
-/**
- * omap2_clk_enable - request that the system enable a clock
- * @clk: struct clk * to enable
- *
- * Increments the usecount on struct clk @clk.  If there were no users
- * previously, then recurse up the clock tree, enabling all of the
- * clock's parents and all of the parent clockdomains, and finally,
- * enabling @clk's clockdomain, and @clk itself.  Intended to be
- * called with the clockfw_lock spinlock held.  Returns 0 upon success
- * or a negative error code upon failure.
- */
-int omap2_clk_enable(struct clk *clk)
-{
-	int ret;
-
-	pr_debug("clock: %s: incrementing usecount\n", clk->name);
-
-	clk->usecount++;
-
-	if (clk->usecount > 1)
-		return 0;
-
-	pr_debug("clock: %s: enabling in hardware\n", clk->name);
-
-	if (clk->parent) {
-		ret = omap2_clk_enable(clk->parent);
-		if (ret) {
-			WARN(1, "clock: %s: could not enable parent %s: %d\n",
-			     clk->name, clk->parent->name, ret);
-			goto oce_err1;
-		}
-	}
-
-	if (clkdm_control && clk->clkdm) {
-		ret = clkdm_clk_enable(clk->clkdm, clk);
-		if (ret) {
-			WARN(1, "clock: %s: could not enable clockdomain %s: "
-			     "%d\n", clk->name, clk->clkdm->name, ret);
-			goto oce_err2;
-		}
-	}
-
-	if (clk->ops && clk->ops->enable) {
-		trace_clock_enable(clk->name, 1, smp_processor_id());
-		ret = clk->ops->enable(clk);
-		if (ret) {
-			WARN(1, "clock: %s: could not enable: %d\n",
-			     clk->name, ret);
-			goto oce_err3;
-		}
-	}
-
-	return 0;
-
-oce_err3:
-	if (clkdm_control && clk->clkdm)
-		clkdm_clk_disable(clk->clkdm, clk);
-oce_err2:
-	if (clk->parent)
-		omap2_clk_disable(clk->parent);
-oce_err1:
-	clk->usecount--;
-
-	return ret;
-}
-
-/* Given a clock and a rate apply a clock specific rounding function */
-long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	if (clk->round_rate)
-		return clk->round_rate(clk, rate);
-
-	return clk->rate;
-}
-
-/* Set the clock rate for a clock source */
-int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	int ret = -EINVAL;
-
-	pr_debug("clock: set_rate for clock %s to rate %ld\n", clk->name, rate);
-
-	/* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
-	if (clk->set_rate) {
-		trace_clock_set_rate(clk->name, rate, smp_processor_id());
-		ret = clk->set_rate(clk, rate);
-	}
-
-	return ret;
-}
-
-int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
-{
-	if (!clk->clksel)
-		return -EINVAL;
-
-	if (clk->parent == new_parent)
-		return 0;
-
-	return omap2_clksel_set_parent(clk, new_parent);
-}
-
-/* OMAP3/4 non-CORE DPLL clkops */
-
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-
-const struct clkops clkops_omap3_noncore_dpll_ops = {
-	.enable		= omap3_noncore_dpll_enable,
-	.disable	= omap3_noncore_dpll_disable,
-	.allow_idle	= omap3_dpll_allow_idle,
-	.deny_idle	= omap3_dpll_deny_idle,
-};
-
-const struct clkops clkops_omap3_core_dpll_ops = {
-	.allow_idle	= omap3_dpll_allow_idle,
-	.deny_idle	= omap3_dpll_deny_idle,
-};
-
-#endif
-
 /*
  * OMAP2+ clock reset and init functions
  */
 
+/* FIXME revisit to figure out how common clk should do this */
+#if 0
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk)
 {
@@ -442,6 +318,7 @@ void omap2_clk_disable_unused(struct clk *clk)
 		pwrdm_clkdm_state_switch(clk->clkdm);
 }
 #endif
+#endif
 
 /**
  * omap2_clk_switch_mpurate_at_boot - switch ARM MPU rate by boot-time argument
@@ -479,7 +356,14 @@ int __init omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name)
 	}
 
 	calibrate_delay();
+	/*
+	 * FIXME
+	 * 1) this code shouldn't be here
+	 * 2) common clk should provide recalculate_root_clks
+	 */
+#if 0
 	recalculate_root_clocks();
+#endif
 
 	clk_put(mpurate_ck);
 
@@ -527,19 +411,36 @@ void __init omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 		(clk_get_rate(mpu_ck) / 1000000));
 }
 
-/* Common data */
-
-struct clk_functions omap2_clk_functions = {
-	.clk_enable		= omap2_clk_enable,
-	.clk_disable		= omap2_clk_disable,
-	.clk_round_rate		= omap2_clk_round_rate,
-	.clk_set_rate		= omap2_clk_set_rate,
-	.clk_set_parent		= omap2_clk_set_parent,
-	.clk_disable_unused	= omap2_clk_disable_unused,
-#ifdef CONFIG_CPU_FREQ
-	/* These will be removed when the OPP code is integrated */
-	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
-	.clk_exit_cpufreq_table	= omap2_clk_exit_cpufreq_table,
-#endif
+/**
+ * omap2_get_parent_fixed - helper function to return fixed parent
+ * @hw - pointer to struct clk_hw
+ *
+ * Returns struct clk_hw_omap->parent (whether or not it exists).
+ */
+struct clk *omap2_get_parent_fixed(struct clk *clk)
+{
+	struct clk_hw_omap *oclk;
+
+	if (!clk)
+		return ERR_PTR(-EINVAL);
+
+	oclk = to_clk_hw_omap(clk);
+
+	/* may be NULL.  Up to the caller to handle */
+	if (!oclk->fixed_parent)
+		pr_debug("%s: oclk->parent is NULL for %s\n", __func__, oclk->clk.name);
+
+	return oclk->fixed_parent;
 };
 
+unsigned long omap2_recalc_rate_fixed(struct clk *clk)
+{
+	struct clk_hw_omap *oclk;
+
+	if (!clk)
+		return -EINVAL;
+
+	oclk = to_clk_hw_omap(clk);
+
+	return oclk->fixed_rate;
+}
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 2311bc2..b1e13ce 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -1,12 +1,13 @@
 /*
  *  linux/arch/arm/mach-omap2/clock.h
  *
- *  Copyright (C) 2005-2009 Texas Instruments, Inc.
+ *  Copyright (C) 2005-2011 Texas Instruments, Inc.
  *  Copyright (C) 2004-2011 Nokia Corporation
  *
  *  Contacts:
  *  Richard Woodruff <r-woodruff2@ti.com>
  *  Paul Walmsley
+ *  Mike Turquette <mturquette@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -49,24 +50,21 @@
 /* DPLL Type and DCO Selection Flags */
 #define DPLL_J_TYPE		0x1
 
-int omap2_clk_enable(struct clk *clk);
-void omap2_clk_disable(struct clk *clk);
-long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
-int omap2_clk_set_rate(struct clk *clk, unsigned long rate);
-int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
-long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate);
+long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate,
+		unsigned long *parent_rate);
 unsigned long omap3_dpll_recalc(struct clk *clk);
 unsigned long omap3_clkoutx2_recalc(struct clk *clk);
-void omap3_dpll_allow_idle(struct clk *clk);
-void omap3_dpll_deny_idle(struct clk *clk);
-u32 omap3_dpll_autoidle_read(struct clk *clk);
+void omap3_dpll_allow_idle(struct clk_hw_omap *oclk);
+void omap3_dpll_deny_idle(struct clk_hw_omap *oclk);
+u32 omap3_dpll_autoidle_read(struct clk_hw_omap *oclk);
 int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
 int omap3_noncore_dpll_enable(struct clk *clk);
 void omap3_noncore_dpll_disable(struct clk *clk);
-int omap4_dpllmx_gatectrl_read(struct clk *clk);
-void omap4_dpllmx_allow_gatectrl(struct clk *clk);
-void omap4_dpllmx_deny_gatectrl(struct clk *clk);
-long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate);
+int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *oclk);
+void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *oclk);
+void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *oclk);
+long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate,
+		unsigned long *parent_rate);
 unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
@@ -78,12 +76,16 @@ void omap2_clk_disable_unused(struct clk *clk);
 void omap2_init_clk_clkdm(struct clk *clk);
 void __init omap2_clk_disable_clkdm_control(void);
 
+struct clk *omap2_get_parent_fixed(struct clk *clk);
+unsigned long omap2_recalc_rate_fixed(struct clk *clk);
+
 /* clkt_clksel.c public functions */
-u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
+u32 omap2_clksel_round_rate_div(struct clk_hw_omap *oclk, unsigned long target_rate,
 				u32 *new_div);
-void omap2_init_clksel_parent(struct clk *clk);
+struct clk *omap2_init_clksel_parent(struct clk *clk);
 unsigned long omap2_clksel_recalc(struct clk *clk);
-long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
+long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate,
+		unsigned long *parent_rate);
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent);
 
@@ -91,8 +93,8 @@ int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent);
 extern void omap2_clkt_iclk_allow_idle(struct clk *clk);
 extern void omap2_clkt_iclk_deny_idle(struct clk *clk);
 
-u32 omap2_get_dpll_rate(struct clk *clk);
-void omap2_init_dpll_parent(struct clk *clk);
+unsigned long omap2_get_dpll_rate(struct clk_hw_omap *oclk);
+struct clk *omap2_init_dpll_parent(struct clk *clk);
 
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
 
@@ -123,22 +125,27 @@ static inline void omap4_clk_prepare_for_reboot(void)
 
 int omap2_dflt_clk_enable(struct clk *clk);
 void omap2_dflt_clk_disable(struct clk *clk);
-void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
-				   u8 *other_bit);
-void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
-				u8 *idlest_bit, u8 *idlest_val);
+
+void omap2_clk_dflt_find_companion(struct clk_hw_omap *oclk,
+				void __iomem **other_reg, u8 *other_bit);
+void omap2_clk_dflt_find_idlest(struct clk_hw_omap *oclk,
+				void __iomem **idlest_reg, u8 *idlest_bit,
+				u8 *idlest_val);
 int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
-			       const char *core_ck_name,
-			       const char *mpu_ck_name);
+				const char *core_ck_name,
+				const char *mpu_ck_name);
 
+extern struct clk_hw_omap dummy_ck_hw;
 extern u8 cpu_mask;
 
+#if 0
 extern const struct clkops clkops_omap2_dflt_wait;
 extern const struct clkops clkops_dummy;
 extern const struct clkops clkops_omap2_dflt;
 
 extern struct clk_functions omap2_clk_functions;
+#endif
 extern struct clk *vclk, *sclk;
 
 extern const struct clksel_rate gpt_32k_rates[];
@@ -154,6 +161,7 @@ extern void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
 #define omap2_clk_exit_cpufreq_table	0
 #endif
 
+#if 0
 extern const struct clkops clkops_omap2_iclk_dflt_wait;
 extern const struct clkops clkops_omap2_iclk_dflt;
 extern const struct clkops clkops_omap2_iclk_idle_only;
@@ -162,5 +170,6 @@ extern const struct clkops clkops_omap2xxx_dpll_ops;
 extern const struct clkops clkops_omap3_noncore_dpll_ops;
 extern const struct clkops clkops_omap3_core_dpll_ops;
 extern const struct clkops clkops_omap4_dpllmx_ops;
+#endif
 
 #endif
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index fc56745..b241257 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -44,12 +44,12 @@
 /* Private functions */
 
 /* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable bits */
-static void _omap3_dpll_write_clken(struct clk *clk, u8 clken_bits)
+static void _omap3_dpll_write_clken(struct clk_hw_omap *oclk, u8 clken_bits)
 {
 	const struct dpll_data *dd;
 	u32 v;
 
-	dd = clk->dpll_data;
+	dd = oclk->dpll_data;
 
 	v = __raw_readl(dd->control_reg);
 	v &= ~dd->enable_mask;
@@ -58,13 +58,13 @@ static void _omap3_dpll_write_clken(struct clk *clk, u8 clken_bits)
 }
 
 /* _omap3_wait_dpll_status: wait for a DPLL to enter a specific state */
-static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
+static int _omap3_wait_dpll_status(struct clk_hw_omap *oclk, u8 state)
 {
 	const struct dpll_data *dd;
 	int i = 0;
 	int ret = -EINVAL;
 
-	dd = clk->dpll_data;
+	dd = oclk->dpll_data;
 
 	state <<= __ffs(dd->idlest_mask);
 
@@ -75,11 +75,11 @@ static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
 	}
 
 	if (i == MAX_DPLL_WAIT_TRIES) {
-		printk(KERN_ERR "clock: %s failed transition to '%s'\n",
-		       clk->name, (state) ? "locked" : "bypassed");
+		pr_err("%s: %s failed transition to '%s'\n", __func__,
+		       oclk->clk.name, (state) ? "locked" : "bypassed");
 	} else {
-		pr_debug("clock: %s transition to '%s' in %d loops\n",
-			 clk->name, (state) ? "locked" : "bypassed", i);
+		pr_debug("%s: %s transition to '%s' in %d loops\n", __func__,
+			 oclk->clk.name, (state) ? "locked" : "bypassed", i);
 
 		ret = 0;
 	}
@@ -88,12 +88,12 @@ static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
 }
 
 /* From 3430 TRM ES2 4.7.6.2 */
-static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
+static u16 _omap3_dpll_compute_freqsel(struct clk_hw_omap *oclk, u8 n)
 {
 	unsigned long fint;
 	u16 f = 0;
 
-	fint = clk->dpll_data->clk_ref->rate / n;
+	fint = oclk->dpll_data->clk_ref->rate / n;
 
 	pr_debug("clock: fint is %lu\n", fint);
 
@@ -133,23 +133,23 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
  * locked successfully, return 0; if the DPLL did not lock in the time
  * allotted, or DPLL3 was passed in, return -EINVAL.
  */
-static int _omap3_noncore_dpll_lock(struct clk *clk)
+static int _omap3_noncore_dpll_lock(struct clk_hw_omap *oclk)
 {
 	u8 ai;
 	int r;
 
-	pr_debug("clock: locking DPLL %s\n", clk->name);
+	pr_debug("%s: locking DPLL %s\n", __func__, oclk->clk.name);
 
-	ai = omap3_dpll_autoidle_read(clk);
+	ai = omap3_dpll_autoidle_read(oclk);
 
-	omap3_dpll_deny_idle(clk);
+	omap3_dpll_deny_idle(oclk);
 
-	_omap3_dpll_write_clken(clk, DPLL_LOCKED);
+	_omap3_dpll_write_clken(oclk, DPLL_LOCKED);
 
-	r = _omap3_wait_dpll_status(clk, 1);
+	r = _omap3_wait_dpll_status(oclk, 1);
 
 	if (ai)
-		omap3_dpll_allow_idle(clk);
+		omap3_dpll_allow_idle(oclk);
 
 	return r;
 }
@@ -167,27 +167,30 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
  * DPLL3 was passed in, or the DPLL does not support low-power bypass,
  * return -EINVAL.
  */
-static int _omap3_noncore_dpll_bypass(struct clk *clk)
+static int _omap3_noncore_dpll_bypass(struct clk_hw_omap *oclk)
 {
+	const struct dpll_data *dd;
 	int r;
 	u8 ai;
 
-	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS)))
+	dd = oclk->dpll_data;
+
+	if (!(dd->modes & (1 << DPLL_LOW_POWER_BYPASS)))
 		return -EINVAL;
 
-	pr_debug("clock: configuring DPLL %s for low-power bypass\n",
-		 clk->name);
+	pr_debug("%s: configuring DPLL %s for low-power bypass\n",
+		 __func__, oclk->clk.name);
 
-	ai = omap3_dpll_autoidle_read(clk);
+	ai = omap3_dpll_autoidle_read(oclk);
 
-	_omap3_dpll_write_clken(clk, DPLL_LOW_POWER_BYPASS);
+	_omap3_dpll_write_clken(oclk, DPLL_LOW_POWER_BYPASS);
 
-	r = _omap3_wait_dpll_status(clk, 0);
+	r = _omap3_wait_dpll_status(oclk, 0);
 
 	if (ai)
-		omap3_dpll_allow_idle(clk);
+		omap3_dpll_allow_idle(oclk);
 	else
-		omap3_dpll_deny_idle(clk);
+		omap3_dpll_deny_idle(oclk);
 
 	return r;
 }
@@ -201,23 +204,26 @@ static int _omap3_noncore_dpll_bypass(struct clk *clk)
  * code.  If DPLL3 was passed in, or the DPLL does not support
  * low-power stop, return -EINVAL; otherwise, return 0.
  */
-static int _omap3_noncore_dpll_stop(struct clk *clk)
+static int _omap3_noncore_dpll_stop(struct clk_hw_omap *oclk)
 {
+	const struct dpll_data *dd;
 	u8 ai;
 
-	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_STOP)))
+	dd = oclk->dpll_data;
+
+	if (!(dd->modes & (1 << DPLL_LOW_POWER_STOP)))
 		return -EINVAL;
 
-	pr_debug("clock: stopping DPLL %s\n", clk->name);
+	pr_debug("%s: stopping DPLL %s\n", __func__, oclk->clk.name);
 
-	ai = omap3_dpll_autoidle_read(clk);
+	ai = omap3_dpll_autoidle_read(oclk);
 
-	_omap3_dpll_write_clken(clk, DPLL_LOW_POWER_STOP);
+	_omap3_dpll_write_clken(oclk, DPLL_LOW_POWER_STOP);
 
 	if (ai)
-		omap3_dpll_allow_idle(clk);
+		omap3_dpll_allow_idle(oclk);
 	else
-		omap3_dpll_deny_idle(clk);
+		omap3_dpll_deny_idle(oclk);
 
 	return 0;
 }
@@ -234,11 +240,11 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
  * XXX This code is not needed for 3430/AM35xx; can it be optimized
  * out in non-multi-OMAP builds for those chips?
  */
-static void _lookup_dco(struct clk *clk, u8 *dco, u16 m, u8 n)
+static void _lookup_dco(struct clk_hw_omap *oclk, u8 *dco, u16 m, u8 n)
 {
 	unsigned long fint, clkinp; /* watch out for overflow */
 
-	clkinp = clk->parent->rate;
+	clkinp = oclk->clk.parent->rate;
 	fint = (clkinp / n) * m;
 
 	if (fint < 1000000000)
@@ -259,12 +265,12 @@ static void _lookup_dco(struct clk *clk, u8 *dco, u16 m, u8 n)
  * XXX This code is not needed for 3430/AM35xx; can it be optimized
  * out in non-multi-OMAP builds for those chips?
  */
-static void _lookup_sddiv(struct clk *clk, u8 *sd_div, u16 m, u8 n)
+static void _lookup_sddiv(struct clk_hw_omap *oclk, u8 *sd_div, u16 m, u8 n)
 {
 	unsigned long clkinp, sd; /* watch out for overflow */
 	int mod1, mod2;
 
-	clkinp = clk->parent->rate;
+	clkinp = oclk->clk.parent->rate;
 
 	/*
 	 * target sigma-delta to near 250MHz
@@ -291,14 +297,16 @@ static void _lookup_sddiv(struct clk *clk, u8 *sd_div, u16 m, u8 n)
  * Program the DPLL with the supplied M, N values, and wait for the DPLL to
  * lock..  Returns -EINVAL upon error, or 0 upon success.
  */
-static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
+static int omap3_noncore_dpll_program(struct clk_hw_omap *oclk, u16 m, u8 n, u16 freqsel)
 {
-	struct dpll_data *dd = clk->dpll_data;
+	struct dpll_data *dd;
 	u8 dco, sd_div;
 	u32 v;
 
+	dd = oclk->dpll_data;
+
 	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
-	_omap3_noncore_dpll_bypass(clk);
+	_omap3_noncore_dpll_bypass(oclk);
 
 	/*
 	 * Set jitter correction. No jitter correction for OMAP4 and 3630
@@ -319,12 +327,12 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 
 	/* Configure dco and sd_div for dplls that have these fields */
 	if (dd->dco_mask) {
-		_lookup_dco(clk, &dco, m, n);
+		_lookup_dco(oclk, &dco, m, n);
 		v &= ~(dd->dco_mask);
 		v |= dco << __ffs(dd->dco_mask);
 	}
 	if (dd->sddiv_mask) {
-		_lookup_sddiv(clk, &sd_div, m, n);
+		_lookup_sddiv(oclk, &sd_div, m, n);
 		v &= ~(dd->sddiv_mask);
 		v |= sd_div << __ffs(dd->sddiv_mask);
 	}
@@ -335,7 +343,7 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 
 	/* REVISIT: Set ramp-up delay? */
 
-	_omap3_noncore_dpll_lock(clk);
+	_omap3_noncore_dpll_lock(oclk);
 
 	return 0;
 }
@@ -350,7 +358,11 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
  */
 unsigned long omap3_dpll_recalc(struct clk *clk)
 {
-	return omap2_get_dpll_rate(clk);
+	struct clk_hw_omap *oclk;
+
+	oclk = to_clk_hw_omap(clk);
+
+	return omap2_get_dpll_rate(oclk);
 }
 
 /* Non-CORE DPLL (e.g., DPLLs that do not control SDRC) clock functions */
@@ -371,27 +383,22 @@ unsigned long omap3_dpll_recalc(struct clk *clk)
  */
 int omap3_noncore_dpll_enable(struct clk *clk)
 {
-	int r;
+	struct clk_hw_omap *oclk;
 	struct dpll_data *dd;
+	int r;
 
-	dd = clk->dpll_data;
+	oclk = to_clk_hw_omap(clk);
+	dd = oclk->dpll_data;
 	if (!dd)
 		return -EINVAL;
 
-	if (clk->rate == dd->clk_bypass->rate) {
-		WARN_ON(clk->parent != dd->clk_bypass);
-		r = _omap3_noncore_dpll_bypass(clk);
+	if (oclk->clk.rate == dd->clk_bypass->rate) {
+		WARN_ON(oclk->clk.parent != dd->clk_bypass);
+		r = _omap3_noncore_dpll_bypass(oclk);
 	} else {
-		WARN_ON(clk->parent != dd->clk_ref);
-		r = _omap3_noncore_dpll_lock(clk);
+		WARN_ON(oclk->clk.parent != dd->clk_ref);
+		r = _omap3_noncore_dpll_lock(oclk);
 	}
-	/*
-	 *FIXME: this is dubious - if clk->rate has changed, what about
-	 * propagating?
-	 */
-	if (!r)
-		clk->rate = (clk->recalc) ? clk->recalc(clk) :
-			omap2_get_dpll_rate(clk);
 
 	return r;
 }
@@ -405,7 +412,11 @@ int omap3_noncore_dpll_enable(struct clk *clk)
  */
 void omap3_noncore_dpll_disable(struct clk *clk)
 {
-	_omap3_noncore_dpll_stop(clk);
+	struct clk_hw_omap *oclk;
+
+	oclk = to_clk_hw_omap(clk);
+
+	_omap3_noncore_dpll_stop(oclk);
 }
 
 
@@ -424,8 +435,9 @@ void omap3_noncore_dpll_disable(struct clk *clk)
  */
 int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 {
+	struct clk_hw_omap *oclk;
 	struct clk *new_parent = NULL;
-	unsigned long hw_rate;
+	//unsigned long hw_rate;
 	u16 freqsel = 0;
 	struct dpll_data *dd;
 	int ret;
@@ -433,48 +445,56 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	if (!clk || !rate)
 		return -EINVAL;
 
-	dd = clk->dpll_data;
+	oclk = to_clk_hw_omap(clk);
+	dd = oclk->dpll_data;
+
 	if (!dd)
 		return -EINVAL;
 
+	/* FIXME revisit - not sure this makes sense any more */
+#if 0
 	hw_rate = (clk->recalc) ? clk->recalc(clk) : omap2_get_dpll_rate(clk);
 	if (rate == hw_rate)
 		return 0;
+#endif
 
 	/*
 	 * Ensure both the bypass and ref clocks are enabled prior to
 	 * doing anything; we need the bypass clock running to reprogram
 	 * the DPLL.
 	 */
-	omap2_clk_enable(dd->clk_bypass);
-	omap2_clk_enable(dd->clk_ref);
+	__clk_prepare(dd->clk_bypass);
+	clk_enable(dd->clk_bypass);
+	__clk_prepare(dd->clk_ref);
+	clk_enable(dd->clk_ref);
 
 	if (dd->clk_bypass->rate == rate &&
-	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		pr_debug("clock: %s: set rate: entering bypass.\n", clk->name);
+			(dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
+		pr_debug("%s: %s: set rate: entering bypass.\n",
+				__func__, oclk->clk.name);
 
-		ret = _omap3_noncore_dpll_bypass(clk);
+		ret = _omap3_noncore_dpll_bypass(oclk);
 		if (!ret)
 			new_parent = dd->clk_bypass;
 	} else {
 		if (dd->last_rounded_rate != rate)
-			rate = clk->round_rate(clk, rate);
+			rate = clk_round_rate(&oclk->clk, rate);
 
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
 
 		/* No freqsel on OMAP4 and OMAP3630 */
 		if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
-			freqsel = _omap3_dpll_compute_freqsel(clk,
+			freqsel = _omap3_dpll_compute_freqsel(oclk,
 						dd->last_rounded_n);
 			if (!freqsel)
 				WARN_ON(1);
 		}
 
-		pr_debug("clock: %s: set rate: locking rate to %lu.\n",
-			 clk->name, rate);
+		pr_debug("%s: %s: set rate: locking rate to %lu.\n",
+			 __func__, oclk->clk.name, rate);
 
-		ret = omap3_noncore_dpll_program(clk, dd->last_rounded_m,
+		ret = omap3_noncore_dpll_program(oclk, dd->last_rounded_m,
 						 dd->last_rounded_n, freqsel);
 		if (!ret)
 			new_parent = dd->clk_ref;
@@ -486,15 +506,16 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		 * enable the new parent before disabling the old to avoid
 		 * any unnecessary hardware disable->enable transitions.
 		 */
-		if (clk->usecount) {
-			omap2_clk_enable(new_parent);
-			omap2_clk_disable(clk->parent);
+		if (oclk->clk.enable_count) {
+			clk_enable(new_parent);
+			clk_disable(oclk->clk.parent);
 		}
-		clk_reparent(clk, new_parent);
-		clk->rate = rate;
+		__clk_reparent(&oclk->clk, new_parent);
 	}
-	omap2_clk_disable(dd->clk_ref);
-	omap2_clk_disable(dd->clk_bypass);
+	clk_disable(dd->clk_ref);
+	__clk_unprepare(dd->clk_ref);
+	clk_disable(dd->clk_bypass);
+	__clk_unprepare(dd->clk_bypass);
 
 	return 0;
 }
@@ -509,15 +530,15 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
  * -EINVAL if passed a null pointer or if the struct clk does not
  * appear to refer to a DPLL.
  */
-u32 omap3_dpll_autoidle_read(struct clk *clk)
+u32 omap3_dpll_autoidle_read(struct clk_hw_omap *oclk)
 {
 	const struct dpll_data *dd;
 	u32 v;
 
-	if (!clk || !clk->dpll_data)
+	if (!oclk || !oclk->dpll_data)
 		return -EINVAL;
 
-	dd = clk->dpll_data;
+	dd = oclk->dpll_data;
 
 	v = __raw_readl(dd->autoidle_reg);
 	v &= dd->autoidle_mask;
@@ -535,15 +556,15 @@ u32 omap3_dpll_autoidle_read(struct clk *clk)
  * OMAP3430.  The DPLL will enter low-power stop when its downstream
  * clocks are gated.  No return value.
  */
-void omap3_dpll_allow_idle(struct clk *clk)
+void omap3_dpll_allow_idle(struct clk_hw_omap *oclk)
 {
 	const struct dpll_data *dd;
 	u32 v;
 
-	if (!clk || !clk->dpll_data)
+	if (!oclk || !oclk->dpll_data)
 		return;
 
-	dd = clk->dpll_data;
+	dd = oclk->dpll_data;
 
 	/*
 	 * REVISIT: CORE DPLL can optionally enter low-power bypass
@@ -562,15 +583,15 @@ void omap3_dpll_allow_idle(struct clk *clk)
  *
  * Disable DPLL automatic idle control.  No return value.
  */
-void omap3_dpll_deny_idle(struct clk *clk)
+void omap3_dpll_deny_idle(struct clk_hw_omap *oclk)
 {
 	const struct dpll_data *dd;
 	u32 v;
 
-	if (!clk || !clk->dpll_data)
+	if (!oclk || !oclk->dpll_data)
 		return;
 
-	dd = clk->dpll_data;
+	dd = oclk->dpll_data;
 
 	v = __raw_readl(dd->autoidle_reg);
 	v &= ~dd->autoidle_mask;
@@ -590,28 +611,39 @@ void omap3_dpll_deny_idle(struct clk *clk)
  */
 unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 {
+	struct clk_hw_omap *oclk;
+	struct clk_hw_omap *poclk;
+	struct clk *parent;
 	const struct dpll_data *dd;
 	unsigned long rate;
 	u32 v;
-	struct clk *pclk;
 
-	/* Walk up the parents of clk, looking for a DPLL */
-	pclk = clk->parent;
-	while (pclk && !pclk->dpll_data)
-		pclk = pclk->parent;
+	parent = clk->parent;
+	if (!parent) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
 
-	/* clk does not have a DPLL as a parent? */
-	WARN_ON(!pclk);
+	oclk = to_clk_hw_omap(clk);
+	poclk = to_clk_hw_omap(parent);
 
-	dd = pclk->dpll_data;
+	if (!poclk->dpll_data) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	dd = poclk->dpll_data;
 
-	WARN_ON(!dd->enable_mask);
+	if (!dd->enable_mask) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
 
 	v = __raw_readl(dd->control_reg) & dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
-		rate = clk->parent->rate;
+		rate = parent->rate;
 	else
-		rate = clk->parent->rate * 2;
+		rate = parent->rate * 2;
 	return rate;
 }
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 9c6a296..210a87c 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -23,65 +23,68 @@
 #include "cm-regbits-44xx.h"
 
 /* Supported only on OMAP4 */
-int omap4_dpllmx_gatectrl_read(struct clk *clk)
+int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *oclk)
 {
 	u32 v;
 	u32 mask;
 
-	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+	if (!oclk->clksel_reg || !cpu_is_omap44xx())
 		return -EINVAL;
 
-	mask = clk->flags & CLOCK_CLKOUTX2 ?
+	mask = oclk->flags & CLOCK_CLKOUTX2 ?
 			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
 			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
 
-	v = __raw_readl(clk->clksel_reg);
+	v = __raw_readl(oclk->clksel_reg);
 	v &= mask;
 	v >>= __ffs(mask);
 
 	return v;
 }
 
-void omap4_dpllmx_allow_gatectrl(struct clk *clk)
+void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *oclk)
 {
 	u32 v;
 	u32 mask;
 
-	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+	if (!oclk->clksel_reg || !cpu_is_omap44xx())
 		return;
 
-	mask = clk->flags & CLOCK_CLKOUTX2 ?
+	mask = oclk->flags & CLOCK_CLKOUTX2 ?
 			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
 			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
 
-	v = __raw_readl(clk->clksel_reg);
+	v = __raw_readl(oclk->clksel_reg);
 	/* Clear the bit to allow gatectrl */
 	v &= ~mask;
-	__raw_writel(v, clk->clksel_reg);
+	__raw_writel(v, oclk->clksel_reg);
 }
 
-void omap4_dpllmx_deny_gatectrl(struct clk *clk)
+void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *oclk)
 {
 	u32 v;
 	u32 mask;
 
-	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+	if (!oclk->clksel_reg || !cpu_is_omap44xx())
 		return;
 
-	mask = clk->flags & CLOCK_CLKOUTX2 ?
+	mask = oclk->flags & CLOCK_CLKOUTX2 ?
 			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
 			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
 
-	v = __raw_readl(clk->clksel_reg);
+	v = __raw_readl(oclk->clksel_reg);
 	/* Set the bit to deny gatectrl */
 	v |= mask;
-	__raw_writel(v, clk->clksel_reg);
+	__raw_writel(v, oclk->clksel_reg);
 }
 
+/* XXX moved directly into struct clk_hw_omap */
+#if 0
 const struct clkops clkops_omap4_dpllmx_ops = {
 	.allow_idle	= omap4_dpllmx_allow_gatectrl,
 	.deny_idle	= omap4_dpllmx_deny_gatectrl,
 };
+#endif
 
 /**
  * omap4_dpll_regm4xen_recalc - compute DPLL rate, considering REGM4XEN bit
@@ -96,14 +99,20 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk)
 {
 	u32 v;
 	unsigned long rate;
+	struct clk_hw_omap *oclk;
 	struct dpll_data *dd;
 
-	if (!clk || !clk->dpll_data)
+	if (!clk)
 		return 0;
 
-	dd = clk->dpll_data;
+	oclk = to_clk_hw_omap(clk);
 
-	rate = omap2_get_dpll_rate(clk);
+	if (!oclk->dpll_data)
+		return 0;
+
+	dd = oclk->dpll_data;
+
+	rate = omap2_get_dpll_rate(oclk);
 
 	/* regm4xen adds a multiplier of 4 to DPLL calculations */
 	v = __raw_readl(dd->control_reg);
@@ -125,16 +134,23 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk)
  * M-dividers) upon success, -EINVAL if @clk is null or not a DPLL, or
  * ~0 if an error occurred in omap2_dpll_round_rate().
  */
-long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
+long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate,
+		unsigned long *parent_rate)
 {
 	u32 v;
+	struct clk_hw_omap *oclk;
 	struct dpll_data *dd;
 	long r;
 
-	if (!clk || !clk->dpll_data)
+	if (!clk)
+	       return -EINVAL;
+
+	oclk = to_clk_hw_omap(clk);
+
+	if (!oclk->dpll_data)
 		return -EINVAL;
 
-	dd = clk->dpll_data;
+	dd = oclk->dpll_data;
 
 	/* regm4xen adds a multiplier of 4 to DPLL calculations */
 	v = __raw_readl(dd->control_reg) & OMAP4430_DPLL_REGM4XEN_MASK;
@@ -142,12 +158,12 @@ long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
 	if (v)
 		target_rate = target_rate / OMAP4430_REGM4XEN_MULT;
 
-	r = omap2_dpll_round_rate(clk, target_rate);
+	r = omap2_dpll_round_rate(clk, target_rate, NULL);
 	if (r == ~0)
 		return r;
 
 	if (v)
-		clk->dpll_data->last_rounded_rate *= OMAP4430_REGM4XEN_MULT;
+		dd->last_rounded_rate *= OMAP4430_REGM4XEN_MULT;
 
-	return clk->dpll_data->last_rounded_rate;
+	return dd->last_rounded_rate;
 }
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 567e4b5..670ab2c 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -25,153 +25,8 @@
 
 #include <plat/clock.h>
 
-static LIST_HEAD(clocks);
-static DEFINE_MUTEX(clocks_mutex);
-static DEFINE_SPINLOCK(clockfw_lock);
-
-static struct clk_functions *arch_clock;
-
-/*
- * Standard clock functions defined in include/linux/clk.h
- */
-
-int clk_enable(struct clk *clk)
-{
-	unsigned long flags;
-	int ret;
-
-	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
-
-	if (!arch_clock || !arch_clock->clk_enable)
-		return -EINVAL;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	ret = arch_clock->clk_enable(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-	unsigned long flags;
-
-	if (clk == NULL || IS_ERR(clk))
-		return;
-
-	if (!arch_clock || !arch_clock->clk_disable)
-		return;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (clk->usecount == 0) {
-		pr_err("Trying disable clock %s with 0 usecount\n",
-		       clk->name);
-		WARN_ON(1);
-		goto out;
-	}
-
-	arch_clock->clk_disable(clk);
-
-out:
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	unsigned long flags;
-	unsigned long ret;
-
-	if (clk == NULL || IS_ERR(clk))
-		return 0;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	ret = clk->rate;
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-/*
- * Optional clock functions defined in include/linux/clk.h
- */
-
-long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long flags;
-	long ret;
-
-	if (clk == NULL || IS_ERR(clk))
-		return 0;
-
-	if (!arch_clock || !arch_clock->clk_round_rate)
-		return 0;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	ret = arch_clock->clk_round_rate(clk, rate);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_round_rate);
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long flags;
-	int ret = -EINVAL;
-
-	if (clk == NULL || IS_ERR(clk))
-		return ret;
-
-	if (!arch_clock || !arch_clock->clk_set_rate)
-		return ret;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	ret = arch_clock->clk_set_rate(clk, rate);
-	if (ret == 0)
-		propagate_rate(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_set_rate);
-
-int clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	unsigned long flags;
-	int ret = -EINVAL;
-
-	if (clk == NULL || IS_ERR(clk) || parent == NULL || IS_ERR(parent))
-		return ret;
-
-	if (!arch_clock || !arch_clock->clk_set_parent)
-		return ret;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (clk->usecount == 0) {
-		ret = arch_clock->clk_set_parent(clk, parent);
-		if (ret == 0)
-			propagate_rate(clk);
-	} else
-		ret = -EBUSY;
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_set_parent);
-
-struct clk *clk_get_parent(struct clk *clk)
-{
-	return clk->parent;
-}
-EXPORT_SYMBOL(clk_get_parent);
-
-/*
- * OMAP specific clock functions shared between omap1 and omap2
- */
+LIST_HEAD(omap_clocks);
+DEFINE_MUTEX(omap_clocks_mutex);
 
 int __initdata mpurate;
 
@@ -193,78 +48,27 @@ static int __init omap_clk_setup(char *str)
 }
 __setup("mpurate=", omap_clk_setup);
 
-/* Used for clocks that always have same value as the parent clock */
-unsigned long followparent_recalc(struct clk *clk)
-{
-	return clk->parent->rate;
-}
-
 /*
  * Used for clocks that have the same value as the parent clock,
  * divided by some factor
  */
 unsigned long omap_fixed_divisor_recalc(struct clk *clk)
 {
-	WARN_ON(!clk->fixed_div);
+	struct clk_hw_omap *oclk;
 
-	return clk->parent->rate / clk->fixed_div;
-}
-
-void clk_reparent(struct clk *child, struct clk *parent)
-{
-	list_del_init(&child->sibling);
-	if (parent)
-		list_add(&child->sibling, &parent->children);
-	child->parent = parent;
-
-	/* now do the debugfs renaming to reattach the child
-	   to the proper parent */
-}
-
-/* Propagate rate to children */
-void propagate_rate(struct clk *tclk)
-{
-	struct clk *clkp;
-
-	list_for_each_entry(clkp, &tclk->children, sibling) {
-		if (clkp->recalc)
-			clkp->rate = clkp->recalc(clkp);
-		propagate_rate(clkp);
+	if (!clk) {
+		pr_warning("%s: clk is NULL\n", __func__);
+		return -EINVAL;
 	}
-}
 
-static LIST_HEAD(root_clks);
+	oclk = to_clk_hw_omap(clk);
 
-/**
- * recalculate_root_clocks - recalculate and propagate all root clocks
- *
- * Recalculates all root clocks (clocks with no parent), which if the
- * clock's .recalc is set correctly, should also propagate their rates.
- * Called at init.
- */
-void recalculate_root_clocks(void)
-{
-	struct clk *clkp;
+	WARN_ON(!oclk->fixed_div);
 
-	list_for_each_entry(clkp, &root_clks, sibling) {
-		if (clkp->recalc)
-			clkp->rate = clkp->recalc(clkp);
-		propagate_rate(clkp);
-	}
-}
-
-/**
- * clk_preinit - initialize any fields in the struct clk before clk init
- * @clk: struct clk * to initialize
- *
- * Initialize any struct clk fields needed before normal clk initialization
- * can run.  No return value.
- */
-void clk_preinit(struct clk *clk)
-{
-	INIT_LIST_HEAD(&clk->children);
+	return oclk->clk.parent->rate / oclk->fixed_div;
 }
 
+#if 0
 int clk_register(struct clk *clk)
 {
 	if (clk == NULL || IS_ERR(clk))
@@ -302,7 +106,10 @@ void clk_unregister(struct clk *clk)
 	mutex_unlock(&clocks_mutex);
 }
 EXPORT_SYMBOL(clk_unregister);
+#endif
 
+/* FIXME useful!  migrate to common clk */
+#if 0
 void clk_enable_init_clocks(void)
 {
 	struct clk *clkp;
@@ -340,6 +147,58 @@ struct clk *omap_clk_get_by_name(const char *name)
 	return ret;
 }
 
+/**
+ * recalculate_root_clocks - recalculate and propagate all root clocks
+ *
+ * Recalculates all root clocks (clocks with no parent), which if the
+ * clock's .recalc is set correctly, should also propagate their rates.
+ * Called at init.
+ */
+void recalculate_root_clocks(void)
+{
+	struct clk *clkp;
+
+	list_for_each_entry(clkp, &root_clks, sibling) {
+		if (clkp->recalc)
+			clkp->rate = clkp->recalc(clkp);
+		propagate_rate(clkp);
+	}
+}
+#endif
+
+/**
+ * omap_clk_get_by_name - locate OMAP struct clk by its name
+ * @name: name of the struct clk to locate
+ *
+ * Locate an OMAP struct clk by its name.  Assumes that struct clk
+ * names are unique.  Returns NULL if not found or a pointer to the
+ * struct clk if found.
+ */
+struct clk *omap_clk_get_by_name(const char *name)
+{
+	//struct clk_hw_omap *hw;
+	struct clk_hw_omap *oclk;
+	struct clk *ret = NULL;
+
+	mutex_lock(&omap_clocks_mutex);
+
+	list_for_each_entry(oclk, &omap_clocks, node) {
+		//oclk = to_clk_hw_omap(hw);
+		/*pr_err("%s: name is %s, oclk->hw.clk->name is %s, pointer is %p\n",
+				__func__, name, oclk->hw.clk->name, oclk);*/
+		if (!strcmp(oclk->clk.name, name)) {
+			ret = &oclk->clk;
+			break;
+		}
+	}
+
+	mutex_unlock(&omap_clocks_mutex);
+
+	return ret;
+}
+
+/* FIXME not sure if I can migrate these.  Probably refactor clk tree walk */
+#if 0
 int omap_clk_enable_autoidle_all(void)
 {
 	struct clk *c;
@@ -371,7 +230,10 @@ int omap_clk_disable_autoidle_all(void)
 
 	return 0;
 }
+#endif
 
+/* can probably live without entirely */
+#if 0
 /*
  * Low level helpers
  */
@@ -398,7 +260,42 @@ struct clk dummy_ck = {
 	.name	= "dummy",
 	.ops	= &clkops_null,
 };
+#endif
+
+/* FIXME rethink the way I'm doing this... */
+#if 0
+struct clk dummy_ck;
+
+struct clk_dummy dummy_ck_hw = {
+	.hw = {
+		.clk	= &dummy_ck,
+	},
+};
 
+struct clk dummy_ck = {
+	.name	= "dummy_clk",
+	.ops	= &clk_dummy_ops,
+	.hw	= &dummy_ck_hw.hw,
+};
+#endif
+
+/* MOVED to mach-omap2/clock.h */
+#if 0
+struct clk_hw_ops dummy_ck_ops = {
+	.get_parent	= &omap2_get_parent_fixed,
+};
+
+struct clk_hw_omap dummy_ck_hw = {
+	.clk = {
+		.name	= "dummy_clk",
+		.ops	= &dummy_ck_ops,
+	},
+};
+
+struct clk *dummy_ck = &dummy_ck_hw.clk;
+#endif
+
+#if 0
 #ifdef CONFIG_CPU_FREQ
 void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
@@ -424,11 +321,14 @@ void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
 #endif
+#endif
 
 /*
  *
  */
 
+/* FIXME should probably keep this, but in some other form */
+#if 0
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 /*
  * Disable any unused clocks left on by the bootloader
@@ -459,7 +359,9 @@ static int __init clk_disable_unused(void)
 late_initcall(clk_disable_unused);
 late_initcall(omap_clk_enable_autoidle_all);
 #endif
+#endif
 
+#if 0
 int __init clk_init(struct clk_functions * custom_clocks)
 {
 	if (!custom_clocks) {
@@ -593,3 +495,4 @@ err_out:
 late_initcall(clk_debugfs_init);
 
 #endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
+#endif
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index eb73ab4..f0245be 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -13,40 +13,17 @@
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
+#include <linux/clk.h>
 #include <linux/list.h>
 
+#define to_clk_hw_omap(ck) container_of(ck, struct clk_hw_omap, clk)
+
 struct module;
 struct clk;
 struct clockdomain;
 
-/**
- * struct clkops - some clock function pointers
- * @enable: fn ptr that enables the current clock in hardware
- * @disable: fn ptr that enables the current clock in hardware
- * @find_idlest: function returning the IDLEST register for the clock's IP blk
- * @find_companion: function returning the "companion" clk reg for the clock
- * @allow_idle: fn ptr that enables autoidle for the current clock in hardware
- * @deny_idle: fn ptr that disables autoidle for the current clock in hardware
- *
- * A "companion" clk is an accompanying clock to the one being queried
- * that must be enabled for the IP module connected to the clock to
- * become accessible by the hardware.  Neither @find_idlest nor
- * @find_companion should be needed; that information is IP
- * block-specific; the hwmod code has been created to handle this, but
- * until hwmod data is ready and drivers have been converted to use PM
- * runtime calls in place of clk_enable()/clk_disable(), @find_idlest and
- * @find_companion must, unfortunately, remain.
- */
-struct clkops {
-	int			(*enable)(struct clk *);
-	void			(*disable)(struct clk *);
-	void			(*find_idlest)(struct clk *, void __iomem **,
-					       u8 *, u8 *);
-	void			(*find_companion)(struct clk *, void __iomem **,
-						  u8 *);
-	void			(*allow_idle)(struct clk *);
-	void			(*deny_idle)(struct clk *);
-};
+extern struct list_head omap_clocks;
+extern struct mutex omap_clocks_mutex;
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
@@ -237,22 +214,14 @@ struct dpll_data {
  * XXX The notion of the clock's current rate probably needs to be
  * separated from the clock's target rate.
  */
-struct clk {
+struct clk_hw_omap {
+	struct clk		clk;
 	struct list_head	node;
-	const struct clkops	*ops;
-	const char		*name;
-	struct clk		*parent;
-	struct list_head	children;
-	struct list_head	sibling;	/* node for children */
-	unsigned long		rate;
+	unsigned long		fixed_rate;
+	struct clk		*fixed_parent;
+	u8			fixed_div;
 	void __iomem		*enable_reg;
-	unsigned long		(*recalc)(struct clk *);
-	int			(*set_rate)(struct clk *, unsigned long);
-	long			(*round_rate)(struct clk *, unsigned long);
-	void			(*init)(struct clk *);
 	u8			enable_bit;
-	s8			usecount;
-	u8			fixed_div;
 	u8			flags;
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	void __iomem		*clksel_reg;
@@ -268,35 +237,40 @@ struct clk {
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 	struct dentry		*dent;	/* For visible tree hierarchy */
 #endif
+	void			(*find_idlest)(struct clk_hw_omap *oclk,
+					void __iomem **idlest_reg,
+					u8 *idlest_bit, u8 *idlest_val);
+	void			(*find_companion)(struct clk_hw_omap *oclk,
+					void __iomem **other_reg, u8 *other_bit);
+	void			(*allow_idle)(struct clk_hw_omap *oclk);
+	void			(*deny_idle)(struct clk_hw_omap *oclk);
 };
 
 struct cpufreq_frequency_table;
 
-struct clk_functions {
-	int		(*clk_enable)(struct clk *clk);
-	void		(*clk_disable)(struct clk *clk);
-	long		(*clk_round_rate)(struct clk *clk, unsigned long rate);
-	int		(*clk_set_rate)(struct clk *clk, unsigned long rate);
-	int		(*clk_set_parent)(struct clk *clk, struct clk *parent);
-	void		(*clk_allow_idle)(struct clk *clk);
-	void		(*clk_deny_idle)(struct clk *clk);
-	void		(*clk_disable_unused)(struct clk *clk);
-#ifdef CONFIG_CPU_FREQ
-	void		(*clk_init_cpufreq_table)(struct cpufreq_frequency_table **);
-	void		(*clk_exit_cpufreq_table)(struct cpufreq_frequency_table **);
-#endif
-};
-
 extern int mpurate;
 
+#if 0
 extern int clk_init(struct clk_functions *custom_clocks);
 extern void clk_preinit(struct clk *clk);
-extern int clk_register(struct clk *clk);
+/* XXX defined in drivers/clk/clk.h
+extern int clk_register(struct clk *clk); */
 extern void clk_reparent(struct clk *child, struct clk *parent);
-extern void clk_unregister(struct clk *clk);
+/* XXX defined in drivers/clk/clk.h
+extern void clk_unregister(struct clk *clk);*/
 extern void propagate_rate(struct clk *clk);
 extern void recalculate_root_clocks(void);
 extern unsigned long followparent_recalc(struct clk *clk);
+#endif
+
+/*
+ * FIXME add this stuff someday (probably used by DT)
+ *
+ * extern int omap_clk_init(struct device *dev, struct clk_hw_omap *oclk);
+ * extern struct clk_hw_omap *omap_clk_register(struct device *dev,
+ * 							const char *name);
+ */
+
 extern void clk_enable_init_clocks(void);
 unsigned long omap_fixed_divisor_recalc(struct clk *clk);
 #ifdef CONFIG_CPU_FREQ
@@ -307,8 +281,10 @@ extern struct clk *omap_clk_get_by_name(const char *name);
 extern int omap_clk_enable_autoidle_all(void);
 extern int omap_clk_disable_autoidle_all(void);
 
-extern const struct clkops clkops_null;
+extern struct clk *omap2_get_parent_fixed(struct clk *clk);
+
+//extern const struct clkops clkops_null;
 
-extern struct clk dummy_ck;
+//extern struct clk *dummy_ck;
 
 #endif
-- 
1.7.5.4

