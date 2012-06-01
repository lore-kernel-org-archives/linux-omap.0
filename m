From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 19/24] ARM: omap4: clk: Cleanup !CONFIG_COMMON_CLK parts
Date: Fri, 1 Jun 2012 17:38:00 +0530
Message-ID: <1338552485-31325-20-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59495 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758689Ab2FAMJI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 08:09:08 -0400
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Clean all #ifdef's added to OMAP4 clock code to make it COMMON clk
ready, now that CONFIG_COMMON_CLK is enabled.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clkt_clksel.c       |  204 ---------------------
 arch/arm/mach-omap2/clkt_dpll.c         |   50 -----
 arch/arm/mach-omap2/clkt_iclk.c         |   46 -----
 arch/arm/mach-omap2/clock.c             |  301 -------------------------------
 arch/arm/mach-omap2/clock.h             |   45 -----
 arch/arm/mach-omap2/clock_common_data.c |    7 +-
 arch/arm/mach-omap2/dpll3xxx.c          |  198 --------------------
 arch/arm/mach-omap2/dpll44xx.c          |   33 ----
 8 files changed, 1 insertions(+), 883 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index 396f7fb..8dd87e2 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -41,11 +41,7 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#ifdef CONFIG_COMMON_CLK
 #include <linux/clk-provider.h>
-#else
-#include <linux/clk.h>
-#endif
 #include <linux/io.h>
 #include <linux/bug.h>
 
@@ -62,11 +58,7 @@
  * the element associated with the supplied parent clock address.
  * Returns a pointer to the struct clksel on success or NULL on error.
  */
-#ifdef CONFIG_COMMON_CLK
 static const struct clksel *_get_clksel_by_parent(struct clk_hw_omap *clk,
-#else
-static const struct clksel *_get_clksel_by_parent(struct clk *clk,
-#endif
 						  struct clk *src_clk)
 {
 	const struct clksel *clks;
@@ -83,11 +75,7 @@ static const struct clksel *_get_clksel_by_parent(struct clk *clk,
 		WARN(1, "clock: Could not find parent clock %s in clksel array "
 		     "of clock %s\n",
 		      __clk_get_name(src_clk),
-#ifdef CONFIG_COMMON_CLK
 		      __clk_get_name(clk->hw.clk));
-#else
-		      __clk_get_name(clk));
-#endif
 		return NULL;
 	}
 
@@ -95,66 +83,6 @@ static const struct clksel *_get_clksel_by_parent(struct clk *clk,
 }
 
 /**
- * _get_div_and_fieldval() - find the new clksel divisor and field value to use
- * @src_clk: planned new parent struct clk *
- * @clk: struct clk * that is being reparented
- * @field_val: pointer to a u32 to contain the register data for the divisor
- *
- * Given an intended new parent struct clk * @src_clk, and the struct
- * clk * @clk to the clock that is being reparented, find the
- * appropriate rate divisor for the new clock (returned as the return
- * value), and the corresponding register bitfield data to program to
- * reach that divisor (returned in the u32 pointed to by @field_val).
- * Returns 0 on error, or returns the newly-selected divisor upon
- * success (in this latter case, the corresponding register bitfield
- * value is passed back in the variable pointed to by @field_val)
- */
-#ifndef CONFIG_COMMON_CLK
-static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
-				u32 *field_val)
-{
-	const struct clksel *clks;
-	const struct clksel_rate *clkr, *max_clkr = NULL;
-	u8 max_div = 0;
-
-	clks = _get_clksel_by_parent(clk, src_clk);
-	if (!clks)
-		return 0;
-
-	/*
-	 * Find the highest divisor (e.g., the one resulting in the
-	 * lowest rate) to use as the default.  This should avoid
-	 * clock rates that are too high for the device.  XXX A better
-	 * solution here would be to try to determine if there is a
-	 * divisor matching the original clock rate before the parent
-	 * switch, and if it cannot be found, to fall back to the
-	 * highest divisor.
-	 */
-	for (clkr = clks->rates; clkr->div; clkr++) {
-		if (!(clkr->flags & cpu_mask))
-			continue;
-
-		if (clkr->div > max_div) {
-			max_div = clkr->div;
-			max_clkr = clkr;
-		}
-	}
-
-	if (max_div == 0) {
-		/* This indicates an error in the clksel data */
-		WARN(1, "clock: Could not find divisor for clock %s parent %s"
-		     "\n", __clk_get_name(clk),
-		     __clk_get_name(__clk_get_parent(src_clk)));
-		return 0;
-	}
-
-	*field_val = max_clkr->val;
-
-	return max_div;
-}
-#endif
-
-/**
  * _write_clksel_reg() - program a clock's clksel register in hardware
  * @clk: struct clk * to program
  * @v: clksel bitfield value to program (with LSB at bit 0)
@@ -167,11 +95,7 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
  * take into account any time the hardware might take to switch the
  * clock source.
  */
-#ifdef CONFIG_COMMON_CLK
 static void _write_clksel_reg(struct clk_hw_omap *clk, u32 field_val)
-#else
-static void _write_clksel_reg(struct clk *clk, u32 field_val)
-#endif
 {
 	u32 v;
 
@@ -194,21 +118,13 @@ static void _write_clksel_reg(struct clk *clk, u32 field_val)
  * before calling.  Returns 0 on error or returns the actual integer divisor
  * upon success.
  */
-#ifdef CONFIG_COMMON_CLK
 static u32 _clksel_to_divisor(struct clk_hw_omap *clk, u32 field_val)
-#else
-static u32 _clksel_to_divisor(struct clk *clk, u32 field_val)
-#endif
 {
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
 	struct clk *parent;
 
-#ifdef CONFIG_COMMON_CLK
 	parent = __clk_get_parent(clk->hw.clk);
-#else
-	parent = __clk_get_parent(clk);
-#endif
 
 	clks = _get_clksel_by_parent(clk, parent);
 	if (!clks)
@@ -226,11 +142,7 @@ static u32 _clksel_to_divisor(struct clk *clk, u32 field_val)
 		/* This indicates a data error */
 		WARN(1, "clock: Could not find fieldval %d for clock %s parent "
 		     "%s\n", field_val,
-#ifdef CONFIG_COMMON_CLK
 		     __clk_get_name(clk->hw.clk),
-#else
-		     __clk_get_name(clk),
-#endif
 		     __clk_get_name(parent));
 		return 0;
 	}
@@ -248,11 +160,7 @@ static u32 _clksel_to_divisor(struct clk *clk, u32 field_val)
  * register field value _before_ left-shifting (i.e., LSB is at bit
  * 0); or returns 0xFFFFFFFF (~0) upon error.
  */
-#ifdef CONFIG_COMMON_CLK
 static u32 _divisor_to_clksel(struct clk_hw_omap *clk, u32 div)
-#else
-static u32 _divisor_to_clksel(struct clk *clk, u32 div)
-#endif
 {
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
@@ -261,11 +169,7 @@ static u32 _divisor_to_clksel(struct clk *clk, u32 div)
 	/* should never happen */
 	WARN_ON(div == 0);
 
-#ifdef CONFIG_COMMON_CLK
 	parent = __clk_get_parent(clk->hw.clk);
-#else
-	parent = __clk_get_parent(clk);
-#endif
 	clks = _get_clksel_by_parent(clk, parent);
 	if (!clks)
 		return ~0;
@@ -281,11 +185,7 @@ static u32 _divisor_to_clksel(struct clk *clk, u32 div)
 	if (!clkr->div) {
 		pr_err("clock: Could not find divisor %d for clock %s parent "
 		       "%s\n", div,
-#ifdef CONFIG_COMMON_CLK
 		       __clk_get_name(clk->hw.clk),
-#else
-		       __clk_get_name(clk),
-#endif
 		       __clk_get_name(parent));
 		return ~0;
 	}
@@ -301,11 +201,7 @@ static u32 _divisor_to_clksel(struct clk *clk, u32 div)
  * into the hardware, convert it into the actual divisor value, and
  * return it; or return 0 on error.
  */
-#ifdef CONFIG_COMMON_CLK
 static u32 _read_divisor(struct clk_hw_omap *clk)
-#else
-static u32 _read_divisor(struct clk *clk)
-#endif
 {
 	u32 v;
 
@@ -333,12 +229,8 @@ static u32 _read_divisor(struct clk *clk)
  *
  * Returns the rounded clock rate or returns 0xffffffff on error.
  */
-#ifdef CONFIG_COMMON_CLK
 u32 omap2_clksel_round_rate_div(struct clk_hw_omap *clk,
 						 unsigned long target_rate,
-#else
-u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
-#endif
 				u32 *new_div)
 {
 	unsigned long test_rate;
@@ -349,13 +241,8 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 	unsigned long parent_rate;
 	const char *clk_name;
 
-#ifdef CONFIG_COMMON_CLK
 	parent = __clk_get_parent(clk->hw.clk);
 	clk_name = __clk_get_name(clk->hw.clk);
-#else
-	parent = __clk_get_parent(clk);
-	clk_name = __clk_get_name(clk);
-#endif
 	parent_rate = __clk_get_rate(parent);
 
 	if (!clk->clksel || !clk->clksel_mask)
@@ -416,14 +303,9 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
  * to.  Update @clk's .parent field with the appropriate clk ptr.  No
  * return value.
  */
-#ifdef CONFIG_COMMON_CLK
 u8 omap2_init_clksel_parent(struct clk_hw *hw)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-void omap2_init_clksel_parent(struct clk *clk)
-{
-#endif
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
 	u32 r, found = 0;
@@ -431,17 +313,10 @@ void omap2_init_clksel_parent(struct clk *clk)
 	const char *clk_name;
 
 	if (!clk->clksel || !clk->clksel_mask)
-#ifdef CONFIG_COMMON_CLK
 		return -EINVAL;
 
 	parent = __clk_get_parent(hw->clk);
 	clk_name = __clk_get_name(hw->clk);
-#else
-		return;
-
-	parent = __clk_get_parent(clk);
-	clk_name = __clk_get_name(clk);
-#endif
 
 	r = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
 	r >>= __ffs(clk->clksel_mask);
@@ -460,14 +335,8 @@ void omap2_init_clksel_parent(struct clk *clk)
 						 ((parent) ?
 						  __clk_get_name(parent) :
 						 "NULL"));
-#ifdef CONFIG_COMMON_CLK
 				};
 				return r;
-#else
-					clk_reparent(clk, clks->parent);
-				};
-				found = 1;
-#endif
 			}
 		}
 	}
@@ -476,11 +345,7 @@ void omap2_init_clksel_parent(struct clk *clk)
 	WARN(!found, "clock: %s: init parent: could not find regval %0x\n",
 	     clk_name, r);
 
-#ifdef CONFIG_COMMON_CLK
 	return -ENODEV;
-#else
-	return;
-#endif
 }
 
 /**
@@ -492,7 +357,6 @@ void omap2_init_clksel_parent(struct clk *clk)
  * function.  Returns the clock's current rate, based on its parent's rate
  * and its current divisor setting in the hardware.
  */
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap2_clksel_recalc(struct clk_hw *hw, unsigned long parent_rate)
 {
 	unsigned long rate;
@@ -513,27 +377,6 @@ unsigned long omap2_clksel_recalc(struct clk_hw *hw, unsigned long parent_rate)
 
 	return rate;
 }
-#else
-unsigned long omap2_clksel_recalc(struct clk *clk)
-{
-	unsigned long rate;
-	u32 div = 0;
-	struct clk *parent;
-
-	div = _read_divisor(clk);
-	if (div == 0)
-		return __clk_get_rate(clk);
-
-	parent = __clk_get_parent(clk);
-	rate = __clk_get_rate(parent) / div;
-
-	pr_debug("clock: %s: recalc'd rate is %ld (div %d)\n",
-		 __clk_get_name(clk),
-		 rate, div);
-
-	return rate;
-}
-#endif
 
 /**
  * omap2_clksel_round_rate() - find rounded rate for the given clock and rate
@@ -546,15 +389,10 @@ unsigned long omap2_clksel_recalc(struct clk *clk)
  *
  * Returns the rounded clock rate or returns 0xffffffff on error.
  */
-#ifdef CONFIG_COMMON_CLK
 long omap2_clksel_round_rate(struct clk_hw *hw, unsigned long target_rate,
 			unsigned long *parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
-{
-#endif
 	u32 new_div;
 
 	return omap2_clksel_round_rate_div(clk, target_rate, &new_div);
@@ -575,15 +413,10 @@ long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
  * is changed, they will all be affected without any notification.
  * Returns -EINVAL upon error, or 0 upon success.
  */
-#ifdef CONFIG_COMMON_CLK
 int omap2_clksel_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
-{
-#endif
 	u32 field_val, validrate, new_div = 0;
 
 	if (!clk->clksel || !clk->clksel_mask)
@@ -600,15 +433,8 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 	_write_clksel_reg(clk, field_val);
 
 	pr_debug("clock: %s: set rate to %ld\n",
-#ifdef CONFIG_COMMON_CLK
 				__clk_get_name(hw->clk),
 				__clk_get_rate(hw->clk));
-#else
-				__clk_get_name(clk),
-				__clk_get_rate(clk));
-
-	clk->rate = __clk_get_rate(__clk_get_parent(clk)) / new_div;
-#endif
 	return 0;
 }
 
@@ -632,7 +458,6 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
  * affected without any notification.  Returns -EINVAL upon error, or
  * 0 upon success.
  */
-#ifdef CONFIG_COMMON_CLK
 int omap2_clksel_set_parent(struct clk_hw *hw, u8 field_val)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
@@ -643,32 +468,3 @@ int omap2_clksel_set_parent(struct clk_hw *hw, u8 field_val)
 	_write_clksel_reg(clk, field_val);
 	return 0;
 }
-#else
-int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent)
-{
-	u32 field_val = 0;
-	u32 parent_div;
-
-	if (!clk->clksel || !clk->clksel_mask)
-		return -EINVAL;
-
-	parent_div = _get_div_and_fieldval(new_parent, clk, &field_val);
-	if (!parent_div)
-		return -EINVAL;
-	_write_clksel_reg(clk, field_val);
-
-	clk_reparent(clk, new_parent);
-
-	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
-	clk->rate = __clk_get_rate(new_parent);
-
-	if (parent_div > 0)
-		__clk_get_rate(clk) /= parent_div;
-	pr_debug("clock: %s: set parent to %s (new rate %ld)\n",
-		 __clk_get_name(clk),
-		 __clk_get_name(__clk_get_parent(clk)),
-		 __clk_get_rate(clk));
-
-	return 0;
-}
-#endif
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 23c677e..7f2cb6e 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -16,11 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#ifdef CONFIG_COMMON_CLK
 #include <linux/clk-provider.h>
-#else
-#include <linux/clk.h>
-#endif
 #include <linux/io.h>
 
 #include <asm/div64.h>
@@ -81,11 +77,7 @@
  * (assuming that it is counting N upwards), or -2 if the enclosing loop
  * should skip to the next iteration (again assuming N is increasing).
  */
-#ifdef CONFIG_COMMON_CLK
 static int _dpll_test_fint(struct clk_hw_omap *clk, u8 n)
-#else
-static int _dpll_test_fint(struct clk *clk, u8 n)
-#endif
 {
 	struct dpll_data *dd;
 	long fint, fint_min, fint_max;
@@ -94,11 +86,7 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
 	dd = clk->dpll_data;
 
 	/* DPLL divider must result in a valid jitter correction val */
-#ifdef CONFIG_COMMON_CLK
 	fint = __clk_get_rate(__clk_get_parent(clk->hw.clk)) / n;
-#else
-	fint = __clk_get_rate(__clk_get_parent(clk)) / n;
-#endif
 
 	if (cpu_is_omap24xx()) {
 		/* Should not be called for OMAP2, so warn if it is called */
@@ -199,24 +187,15 @@ static int _dpll_test_mult(int *m, int n, unsigned long *new_rate,
 }
 
 /* Public functions */
-#ifdef CONFIG_COMMON_CLK
 u8 omap2_init_dpll_parent(struct clk_hw *hw)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-void omap2_init_dpll_parent(struct clk *clk)
-{
-#endif
 	u32 v;
 	struct dpll_data *dd;
 
 	dd = clk->dpll_data;
 	if (!dd)
-#ifdef CONFIG_COMMON_CLK
 		return -EINVAL;
-#else
-		return;
-#endif
 
 	v = __raw_readl(dd->control_reg);
 	v &= dd->enable_mask;
@@ -226,34 +205,18 @@ void omap2_init_dpll_parent(struct clk *clk)
 	if (cpu_is_omap24xx()) {
 		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
-#ifdef CONFIG_COMMON_CLK
 			return 1;
-#else
-			clk_reparent(clk, dd->clk_bypass);
-#endif
 	} else if (cpu_is_omap34xx()) {
 		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
-#ifdef CONFIG_COMMON_CLK
 			return 1;
-#else
-			clk_reparent(clk, dd->clk_bypass);
-#endif
 	} else if (cpu_is_omap44xx()) {
 		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
 		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
-#ifdef CONFIG_COMMON_CLK
 			return 1;
-#else
-			clk_reparent(clk, dd->clk_bypass);
-#endif
 	}
-#ifdef CONFIG_COMMON_CLK
 	return 0;
-#else
-	return;
-#endif
 }
 
 /**
@@ -270,11 +233,7 @@ void omap2_init_dpll_parent(struct clk *clk)
  * locked, or the appropriate bypass rate if the DPLL is bypassed, or 0
  * if the clock @clk is not a DPLL.
  */
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
-#else
-u32 omap2_get_dpll_rate(struct clk *clk)
-#endif
 {
 	long long dpll_clk;
 	u32 dpll_mult, dpll_div, v;
@@ -330,15 +289,10 @@ u32 omap2_get_dpll_rate(struct clk *clk)
  * (expensive) function again.  Returns ~0 if the target rate cannot
  * be rounded, or the rounded rate upon success.
  */
-#ifdef CONFIG_COMMON_CLK
 long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 		unsigned long *parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
-{
-#endif
 	int m, n, r, scaled_max_m;
 	unsigned long scaled_rt_rp;
 	unsigned long new_rate = 0;
@@ -352,11 +306,7 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 	dd = clk->dpll_data;
 
 	ref_rate = __clk_get_rate(dd->clk_ref);
-#ifdef CONFIG_COMMON_CLK
 	clk_name = __clk_get_name(hw->clk);
-#else
-	clk_name = __clk_get_name(clk);
-#endif
 	pr_debug("clock: %s: starting DPLL round_rate, target rate %ld\n",
 		 clk_name, target_rate);
 
diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index 16f84fb..9fb8262 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -11,11 +11,7 @@
 #undef DEBUG
 
 #include <linux/kernel.h>
-#ifdef CONFIG_COMMON_CLK
 #include <linux/clk-provider.h>
-#else
-#include <linux/clk.h>
-#endif
 #include <linux/io.h>
 
 #include <plat/prcm.h>
@@ -28,11 +24,7 @@
 /* Private functions */
 
 /* XXX */
-#ifdef CONFIG_COMMON_CLK
 void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk)
-#else
-void omap2_clkt_iclk_allow_idle(struct clk *clk)
-#endif
 {
 	u32 v, r;
 
@@ -44,11 +36,7 @@ void omap2_clkt_iclk_allow_idle(struct clk *clk)
 }
 
 /* XXX */
-#ifdef CONFIG_COMMON_CLK
 void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk)
-#else
-void omap2_clkt_iclk_deny_idle(struct clk *clk)
-#endif
 {
 	u32 v, r;
 
@@ -59,42 +47,8 @@ void omap2_clkt_iclk_deny_idle(struct clk *clk)
 	__raw_writel(v, (__force void __iomem *)r);
 }
 
-#ifdef CONFIG_COMMON_CLK
 const struct clk_hw_omap_ops clkhwops_iclk = {
 	.allow_idle	= omap2_clkt_iclk_allow_idle,
 	.deny_idle	= omap2_clkt_iclk_deny_idle,
 };
-#else
-/* Public data */
-
-const struct clkops clkops_omap2_iclk_dflt_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_companion	= omap2_clk_dflt_find_companion,
-	.find_idlest	= omap2_clk_dflt_find_idlest,
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-};
-
-const struct clkops clkops_omap2_iclk_dflt = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-};
-
-const struct clkops clkops_omap2_iclk_idle_only = {
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-};
-
-const struct clkops clkops_omap2_mdmclk_dflt_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_companion	= omap2_clk_dflt_find_companion,
-	.find_idlest	= omap2_clk_dflt_find_idlest,
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-};
-#endif
 
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d19af9b..b29a172 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -19,11 +19,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/delay.h>
-#ifdef CONFIG_COMMON_CLK
 #include <linux/clk-provider.h>
-#else
-#include <linux/clk.h>
-#endif
 #include <linux/io.h>
 #include <linux/bitops.h>
 #include <trace/events/power.h>
@@ -48,7 +44,6 @@ u16 cpu_mask;
  */
 static bool clkdm_control = true;
 
-#ifdef CONFIG_COMMON_CLK
 LIST_HEAD(clk_hw_omap_clocks);
 
 /*
@@ -71,7 +66,6 @@ unsigned long omap_fixed_divisor_recalc(struct clk_hw *hw,
 
 	return parent_rate / oclk->fixed_div;
 }
-#endif
 
 /*
  * OMAP2+ specific clock functions
@@ -89,11 +83,7 @@ unsigned long omap_fixed_divisor_recalc(struct clk_hw *hw,
  * belong in the clock code and will be moved in the medium term to
  * module-dependent code.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 static void _omap2_module_wait_ready(struct clk_hw_omap *clk)
-#else
-static void _omap2_module_wait_ready(struct clk *clk)
-#endif
 {
 	void __iomem *companion_reg, *idlest_reg;
 	u8 other_bit, idlest_bit, idlest_val;
@@ -107,11 +97,7 @@ static void _omap2_module_wait_ready(struct clk *clk)
 
 	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit, &idlest_val);
 	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), idlest_val,
-#ifdef CONFIG_COMMON_CLK
 			     __clk_get_name(clk->hw.clk));
-#else
-			     __clk_get_name(clk));
-#endif
 }
 
 /* Public functions */
@@ -124,25 +110,16 @@ static void _omap2_module_wait_ready(struct clk *clk)
  * clockdomain pointer, and save it into the struct clk.  Intended to be
  * called during clk_register().  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 void omap2_init_clk_clkdm(struct clk_hw *hw)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-void omap2_init_clk_clkdm(struct clk *clk)
-{
-#endif
 	struct clockdomain *clkdm;
 	const char *clk_name;
 
 	if (!clk->clkdm_name)
 		return;
 
-#ifdef CONFIG_COMMON_CLK
 	clk_name = __clk_get_name(hw->clk);
-#else
-	clk_name = __clk_get_name(clk);
-#endif
 
 	clkdm = clkdm_lookup(clk->clkdm_name);
 	if (clkdm) {
@@ -189,11 +166,7 @@ void __init omap2_clk_disable_clkdm_control(void)
  * associate this type of code with per-module data structures to
  * avoid this issue, and remove the casts.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
-#else
-void omap2_clk_dflt_find_companion(struct clk *clk,
-#endif
 			void __iomem **other_reg, u8 *other_bit)
 {
 	u32 r;
@@ -222,11 +195,7 @@ void omap2_clk_dflt_find_companion(struct clk *clk,
  * register address ID (e.g., that CM_FCLKEN2 corresponds to
  * CM_IDLEST2).  This is not true for all modules.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
-#else
-void omap2_clk_dflt_find_idlest(struct clk *clk,
-#endif
 		void __iomem **idlest_reg, u8 *idlest_bit, u8 *idlest_val)
 {
 	u32 r;
@@ -249,7 +218,6 @@ void omap2_clk_dflt_find_idlest(struct clk *clk,
 
 }
 
-#ifdef CONFIG_COMMON_CLK
 int omap2_dflt_clk_enable(struct clk_hw *hw)
 {
 	struct clk_hw_omap *clk;
@@ -403,259 +371,6 @@ const struct clk_hw_omap_ops clkhwops_wait = {
 };
 late_initcall(omap2_clk_enable_autoidle_all);
 
-#else
-int omap2_dflt_clk_enable(struct clk *clk)
-{
-	u32 v;
-
-	if (unlikely(clk->enable_reg == NULL)) {
-		pr_err("clock.c: Enable for %s without enable code\n",
-		       clk->name);
-		return 0; /* REVISIT: -EINVAL */
-	}
-
-	v = __raw_readl(clk->enable_reg);
-	if (clk->flags & INVERT_ENABLE)
-		v &= ~(1 << clk->enable_bit);
-	else
-		v |= (1 << clk->enable_bit);
-	__raw_writel(v, clk->enable_reg);
-	v = __raw_readl(clk->enable_reg); /* OCP barrier */
-
-	if (clk->ops->find_idlest)
-		_omap2_module_wait_ready(clk);
-
-	return 0;
-}
-
-void omap2_dflt_clk_disable(struct clk *clk)
-{
-	u32 v;
-
-	if (!clk->enable_reg) {
-		/*
-		 * 'Independent' here refers to a clock which is not
-		 * controlled by its parent.
-		 */
-		printk(KERN_ERR "clock: clk_disable called on independent "
-		       "clock %s which has no enable_reg\n", clk->name);
-		return;
-	}
-
-	v = __raw_readl(clk->enable_reg);
-	if (clk->flags & INVERT_ENABLE)
-		v |= (1 << clk->enable_bit);
-	else
-		v &= ~(1 << clk->enable_bit);
-	__raw_writel(v, clk->enable_reg);
-	/* No OCP barrier needed here since it is a disable operation */
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
-
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
-}
-
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
-/*
- * OMAP2+ clock reset and init functions
- */
-
-#ifdef CONFIG_OMAP_RESET_CLOCKS
-void omap2_clk_disable_unused(struct clk *clk)
-{
-	u32 regval32, v;
-
-	v = (clk->flags & INVERT_ENABLE) ? (1 << clk->enable_bit) : 0;
-
-	regval32 = __raw_readl(clk->enable_reg);
-	if ((regval32 & (1 << clk->enable_bit)) == v)
-		return;
-
-	pr_debug("Disabling unused clock \"%s\"\n", clk->name);
-	if (cpu_is_omap34xx()) {
-		omap2_clk_enable(clk);
-		omap2_clk_disable(clk);
-	} else {
-		clk->ops->disable(clk);
-	}
-	if (clk->clkdm != NULL)
-		pwrdm_clkdm_state_switch(clk->clkdm);
-}
-#endif
-
-#endif /* CONFIG_COMMON_CLK */
-
 /**
  * omap2_clk_switch_mpurate_at_boot - switch ARM MPU rate by boot-time argument
  * @mpurate_ck_name: clk name of the clock to change rate
@@ -692,10 +407,6 @@ int __init omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name)
 	}
 
 	calibrate_delay();
-#ifndef CONFIG_COMMON_CLK
-	recalculate_root_clocks();
-#endif
-
 	clk_put(mpurate_ck);
 
 	return 0;
@@ -741,15 +452,3 @@ void __init omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 		(clk_get_rate(core_ck) / 1000000),
 		(clk_get_rate(mpu_ck) / 1000000));
 }
-
-#ifndef CONFIG_COMMON_CLK
-/* Common data */
-struct clk_functions omap2_clk_functions = {
-	.clk_enable		= omap2_clk_enable,
-	.clk_disable		= omap2_clk_disable,
-	.clk_round_rate		= omap2_clk_round_rate,
-	.clk_set_rate		= omap2_clk_set_rate,
-	.clk_set_parent		= omap2_clk_set_parent,
-	.clk_disable_unused	= omap2_clk_disable_unused,
-};
-#endif
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index fd022b3..b2e73aa 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -291,7 +291,6 @@ void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
-#ifdef CONFIG_COMMON_CLK
 long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 			unsigned long *parent_rate);
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
@@ -310,37 +309,16 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 				unsigned long parent_rate);
 long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw, unsigned long target_rate,
 				unsigned long *parent_rate);
-#else
-long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate);
-unsigned long omap3_dpll_recalc(struct clk *clk);
-unsigned long omap3_clkoutx2_recalc(struct clk *clk);
-void omap3_dpll_allow_idle(struct clk *clk);
-void omap3_dpll_deny_idle(struct clk *clk);
-u32 omap3_dpll_autoidle_read(struct clk *clk);
-int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
-int omap3_noncore_dpll_enable(struct clk *clk);
-void omap3_noncore_dpll_disable(struct clk *clk);
-int omap4_dpllmx_gatectrl_read(struct clk *clk);
-void omap4_dpllmx_allow_gatectrl(struct clk *clk);
-void omap4_dpllmx_deny_gatectrl(struct clk *clk);
-long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate);
-unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk);
-#endif
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk);
 #else
 #define omap2_clk_disable_unused	NULL
 #endif
-#ifdef CONFIG_COMMON_CLK
 void omap2_init_clk_clkdm(struct clk_hw *clk);
-#else
-void omap2_init_clk_clkdm(struct clk *clk);
-#endif
 void __init omap2_clk_disable_clkdm_control(void);
 
 /* clkt_clksel.c public functions */
-#ifdef CONFIG_COMMON_CLK
 u32 omap2_clksel_round_rate_div(struct clk_hw_omap *clk, unsigned long target_rate,
 				u32 *new_div);
 u8 omap2_init_clksel_parent(struct clk_hw *hw);
@@ -350,15 +328,6 @@ long omap2_clksel_round_rate(struct clk_hw *hw, unsigned long target_rate,
 int omap2_clksel_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate);
 int omap2_clksel_set_parent(struct clk_hw *hw, u8 field_val);
-#else
-u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
-				u32 *new_div);
-void omap2_init_clksel_parent(struct clk *clk);
-unsigned long omap2_clksel_recalc(struct clk *clk);
-long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
-int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
-int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent);
-#endif
 
 /* clkt_iclk.c public functions */
 #ifdef CONFIG_COMMON_CLK
@@ -369,13 +338,8 @@ extern void omap2_clkt_iclk_allow_idle(struct clk *clk);
 extern void omap2_clkt_iclk_deny_idle(struct clk *clk);
 #endif
 
-#ifdef CONFIG_COMMON_CLK
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
-#else
-u32 omap2_get_dpll_rate(struct clk *clk);
-void omap2_init_dpll_parent(struct clk *clk);
-#endif
 
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
 
@@ -404,7 +368,6 @@ static inline void omap4_clk_prepare_for_reboot(void)
 }
 #endif
 
-#ifdef CONFIG_COMMON_CLK
 int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk, void __iomem **other_reg,
@@ -415,14 +378,6 @@ void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_disable_autoidle_all(void);
 void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
-#else
-int omap2_dflt_clk_enable(struct clk *clk);
-void omap2_dflt_clk_disable(struct clk *clk);
-void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
-				   u8 *other_bit);
-void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
-				u8 *idlest_bit, u8 *idlest_val);
-#endif
 int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
diff --git a/arch/arm/mach-omap2/clock_common_data.c b/arch/arm/mach-omap2/clock_common_data.c
index 5838c99..022df5f 100644
--- a/arch/arm/mach-omap2/clock_common_data.c
+++ b/arch/arm/mach-omap2/clock_common_data.c
@@ -16,6 +16,7 @@
  * OMAP3xxx clock definition files.
  */
 
+#include <linux/clk-private.h>
 #include "clock.h"
 
 /* clksel_rate data common to 24xx/343x */
@@ -44,10 +45,6 @@ const struct clksel_rate dsp_ick_rates[] = {
 	{ .div = 0 },
 };
 
-#ifdef CONFIG_COMMON_CLK
-
-#include <linux/clk-private.h>
-
 static struct clk_ops dummy_ck_ops = {};
 
 struct clk dummy_ck = {
@@ -55,5 +52,3 @@ struct clk dummy_ck = {
 	.ops = &dummy_ck_ops,
 	.flags = CLK_IS_BASIC,
 };
-
-#endif
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index aadc8c1..94f8682 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -43,11 +43,7 @@
 /* Private functions */
 
 /* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable bits */
-#ifdef CONFIG_COMMON_CLK
 static void _omap3_dpll_write_clken(struct clk_hw_omap *clk, u8 clken_bits)
-#else
-static void _omap3_dpll_write_clken(struct clk *clk, u8 clken_bits)
-#endif
 {
 	const struct dpll_data *dd;
 	u32 v;
@@ -61,11 +57,7 @@ static void _omap3_dpll_write_clken(struct clk *clk, u8 clken_bits)
 }
 
 /* _omap3_wait_dpll_status: wait for a DPLL to enter a specific state */
-#ifdef CONFIG_COMMON_CLK
 static int _omap3_wait_dpll_status(struct clk_hw_omap *clk, u8 state)
-#else
-static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
-#endif
 {
 	const struct dpll_data *dd;
 	int i = 0;
@@ -73,11 +65,7 @@ static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
 	const char *clk_name;
 
 	dd = clk->dpll_data;
-#ifdef CONFIG_COMMON_CLK
 	clk_name = __clk_get_name(clk->hw.clk);
-#else
-	clk_name = __clk_get_name(clk);
-#endif
 
 	state <<= __ffs(dd->idlest_mask);
 
@@ -101,11 +89,7 @@ static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
 }
 
 /* From 3430 TRM ES2 4.7.6.2 */
-#ifdef CONFIG_COMMON_CLK
 static u16 _omap3_dpll_compute_freqsel(struct clk_hw_omap *clk, u8 n)
-#else
-static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
-#endif
 {
 	unsigned long fint;
 	u16 f = 0;
@@ -150,20 +134,12 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
  * locked successfully, return 0; if the DPLL did not lock in the time
  * allotted, or DPLL3 was passed in, return -EINVAL.
  */
-#ifdef CONFIG_COMMON_CLK
 static int _omap3_noncore_dpll_lock(struct clk_hw_omap *clk)
-#else
-static int _omap3_noncore_dpll_lock(struct clk *clk)
-#endif
 {
 	u8 ai;
 	int r;
 
-#ifdef CONFIG_COMMON_CLK
 	pr_debug("clock: locking DPLL %s\n", __clk_get_name(clk->hw.clk));
-#else
-	pr_debug("clock: locking DPLL %s\n", __clk_get_name(clk));
-#endif
 
 	ai = omap3_dpll_autoidle_read(clk);
 
@@ -192,11 +168,7 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
  * DPLL3 was passed in, or the DPLL does not support low-power bypass,
  * return -EINVAL.
  */
-#ifdef CONFIG_COMMON_CLK
 static int _omap3_noncore_dpll_bypass(struct clk_hw_omap *clk)
-#else
-static int _omap3_noncore_dpll_bypass(struct clk *clk)
-#endif
 {
 	int r;
 	u8 ai;
@@ -205,11 +177,7 @@ static int _omap3_noncore_dpll_bypass(struct clk *clk)
 		return -EINVAL;
 
 	pr_debug("clock: configuring DPLL %s for low-power bypass\n",
-#ifdef CONFIG_COMMON_CLK
 		 __clk_get_name(clk->hw.clk));
-#else
-		 __clk_get_name(clk));
-#endif
 
 	ai = omap3_dpll_autoidle_read(clk);
 
@@ -234,22 +202,14 @@ static int _omap3_noncore_dpll_bypass(struct clk *clk)
  * code.  If DPLL3 was passed in, or the DPLL does not support
  * low-power stop, return -EINVAL; otherwise, return 0.
  */
-#ifdef CONFIG_COMMON_CLK
 static int _omap3_noncore_dpll_stop(struct clk_hw_omap *clk)
-#else
-static int _omap3_noncore_dpll_stop(struct clk *clk)
-#endif
 {
 	u8 ai;
 
 	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_STOP)))
 		return -EINVAL;
 
-#ifdef CONFIG_COMMON_CLK
 	pr_debug("clock: stopping DPLL %s\n", __clk_get_name(clk->hw.clk));
-#else
-	pr_debug("clock: stopping DPLL %s\n", __clk_get_name(clk));
-#endif
 
 	ai = omap3_dpll_autoidle_read(clk);
 
@@ -275,19 +235,11 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
  * XXX This code is not needed for 3430/AM35xx; can it be optimized
  * out in non-multi-OMAP builds for those chips?
  */
-#ifdef CONFIG_COMMON_CLK
 static void _lookup_dco(struct clk_hw_omap *clk, u8 *dco, u16 m, u8 n)
-#else
-static void _lookup_dco(struct clk *clk, u8 *dco, u16 m, u8 n)
-#endif
 {
 	unsigned long fint, clkinp; /* watch out for overflow */
 
-#ifdef CONFIG_COMMON_CLK
 	clkinp = __clk_get_rate(__clk_get_parent(clk->hw.clk));
-#else
-	clkinp = __clk_get_rate(__clk_get_parent(clk));
-#endif
 	fint = (clkinp / n) * m;
 
 	if (fint < 1000000000)
@@ -308,20 +260,12 @@ static void _lookup_dco(struct clk *clk, u8 *dco, u16 m, u8 n)
  * XXX This code is not needed for 3430/AM35xx; can it be optimized
  * out in non-multi-OMAP builds for those chips?
  */
-#ifdef CONFIG_COMMON_CLK
 static void _lookup_sddiv(struct clk_hw_omap *clk, u8 *sd_div, u16 m, u8 n)
-#else
-static void _lookup_sddiv(struct clk *clk, u8 *sd_div, u16 m, u8 n)
-#endif
 {
 	unsigned long clkinp, sd; /* watch out for overflow */
 	int mod1, mod2;
 
-#ifdef CONFIG_COMMON_CLK
 	clkinp = __clk_get_rate(__clk_get_parent(clk->hw.clk));
-#else
-	clkinp = __clk_get_rate(__clk_get_parent(clk));
-#endif
 
 	/*
 	 * target sigma-delta to near 250MHz
@@ -348,11 +292,7 @@ static void _lookup_sddiv(struct clk *clk, u8 *sd_div, u16 m, u8 n)
  * Program the DPLL with the supplied M, N values, and wait for the DPLL to
  * lock..  Returns -EINVAL upon error, or 0 upon success.
  */
-#ifdef CONFIG_COMMON_CLK
 static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 m, u8 n, u16 freqsel)
-#else
-static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
-#endif
 {
 	struct dpll_data *dd = clk->dpll_data;
 	u8 dco, sd_div;
@@ -409,14 +349,9 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
  *
  * Recalculate and propagate the DPLL rate.
  */
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-unsigned long omap3_dpll_recalc(struct clk *clk)
-{
-#endif
 	return omap2_get_dpll_rate(clk);
 }
 
@@ -436,14 +371,9 @@ unsigned long omap3_dpll_recalc(struct clk *clk)
  * support low-power stop, or if the DPLL took too long to enter
  * bypass or lock, return -EINVAL; otherwise, return 0.
  */
-#ifdef CONFIG_COMMON_CLK
 int omap3_noncore_dpll_enable(struct clk_hw *hw)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-int omap3_noncore_dpll_enable(struct clk *clk)
-{
-#endif
 	int r;
 	struct dpll_data *dd;
 	struct clk *parent;
@@ -452,15 +382,9 @@ int omap3_noncore_dpll_enable(struct clk *clk)
 	if (!dd)
 		return -EINVAL;
 
-#ifdef CONFIG_COMMON_CLK
 	parent = __clk_get_parent(hw->clk);
 
 	if (__clk_get_rate(hw->clk) == __clk_get_rate(dd->clk_bypass)) {
-#else
-	parent = __clk_get_parent(clk);
-
-	if (__clk_get_rate(clk) == __clk_get_rate(dd->clk_bypass)) {
-#endif
 		WARN_ON(parent != dd->clk_bypass);
 		r = _omap3_noncore_dpll_bypass(clk);
 	} else {
@@ -468,16 +392,6 @@ int omap3_noncore_dpll_enable(struct clk *clk)
 		r = _omap3_noncore_dpll_lock(clk);
 	}
 
-#ifndef CONFIG_COMMON_CLK
-	/*
-	 *FIXME: this is dubious - if clk->rate has changed, what about
-	 * propagating?
-	 */
-	if (!r)
-		clk->rate = (clk->recalc) ? clk->recalc(clk) :
-			omap2_get_dpll_rate(clk);
-#endif
-
 	return r;
 }
 
@@ -488,14 +402,9 @@ int omap3_noncore_dpll_enable(struct clk *clk)
  * Instructs a non-CORE DPLL to enter low-power stop.  This function is
  * intended for use in struct clkops.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 void omap3_noncore_dpll_disable(struct clk_hw *hw)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-void omap3_noncore_dpll_disable(struct clk *clk)
-{
-#endif
 	_omap3_noncore_dpll_stop(clk);
 }
 
@@ -513,7 +422,6 @@ void omap3_noncore_dpll_disable(struct clk *clk)
  * target rate if it hasn't been done already, then program and lock
  * the DPLL.  Returns -EINVAL upon error, or 0 upon success.
  */
-#ifdef CONFIG_COMMON_CLK
 int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long parent_rate)
 {
@@ -583,84 +491,6 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	return 0;
 }
-#else
-int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
-{
-	struct clk *new_parent = NULL;
-	unsigned long hw_rate;
-	u16 freqsel = 0;
-	struct dpll_data *dd;
-	int ret;
-
-	if (!clk || !rate)
-		return -EINVAL;
-
-	dd = clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
-
-	hw_rate = (clk->recalc) ? clk->recalc(clk) : omap2_get_dpll_rate(clk);
-	if (rate == hw_rate)
-		return 0;
-
-	/*
-	 * Ensure both the bypass and ref clocks are enabled prior to
-	 * doing anything; we need the bypass clock running to reprogram
-	 * the DPLL.
-	 */
-	omap2_clk_enable(dd->clk_bypass);
-	omap2_clk_enable(dd->clk_ref);
-
-	if (__clk_get_rate(dd->clk_bypass) == rate &&
-	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		pr_debug("clock: %s: set rate: entering bypass.\n", clk->name);
-
-		ret = _omap3_noncore_dpll_bypass(clk);
-		if (!ret)
-			new_parent = dd->clk_bypass;
-	} else {
-		if (dd->last_rounded_rate != rate)
-			rate = clk->round_rate(clk, rate);
-
-		if (dd->last_rounded_rate == 0)
-			return -EINVAL;
-
-		/* No freqsel on OMAP4 and OMAP3630 */
-		if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
-			freqsel = _omap3_dpll_compute_freqsel(clk,
-						dd->last_rounded_n);
-			if (!freqsel)
-				WARN_ON(1);
-		}
-
-		pr_debug("clock: %s: set rate: locking rate to %lu.\n",
-			 __clk_get_name(clk), rate);
-
-		ret = omap3_noncore_dpll_program(clk, dd->last_rounded_m,
-						 dd->last_rounded_n, freqsel);
-		if (!ret)
-			new_parent = dd->clk_ref;
-	}
-	if (!ret) {
-		/*
-		 * Switch the parent clock in the hierarchy, and make sure
-		 * that the new parent's usecount is correct.  Note: we
-		 * enable the new parent before disabling the old to avoid
-		 * any unnecessary hardware disable->enable transitions.
-		 */
-		if (clk->usecount) {
-			omap2_clk_enable(new_parent);
-			omap2_clk_disable(clk->parent);
-		}
-		clk_reparent(clk, new_parent);
-		clk->rate = rate;
-	}
-	omap2_clk_disable(dd->clk_ref);
-	omap2_clk_disable(dd->clk_bypass);
-
-	return 0;
-}
-#endif
 
 /* DPLL autoidle read/set code */
 
@@ -672,11 +502,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
  * -EINVAL if passed a null pointer or if the struct clk does not
  * appear to refer to a DPLL.
  */
-#ifdef CONFIG_COMMON_CLK
 u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
-#else
-u32 omap3_dpll_autoidle_read(struct clk *clk)
-#endif
 {
 	const struct dpll_data *dd;
 	u32 v;
@@ -702,11 +528,7 @@ u32 omap3_dpll_autoidle_read(struct clk *clk)
  * OMAP3430.  The DPLL will enter low-power stop when its downstream
  * clocks are gated.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
-#else
-void omap3_dpll_allow_idle(struct clk *clk)
-#endif
 {
 	const struct dpll_data *dd;
 	u32 v;
@@ -733,11 +555,7 @@ void omap3_dpll_allow_idle(struct clk *clk)
  *
  * Disable DPLL automatic idle control.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
-#else
-void omap3_dpll_deny_idle(struct clk *clk)
-#endif
 {
 	const struct dpll_data *dd;
 	u32 v;
@@ -763,7 +581,6 @@ void omap3_dpll_deny_idle(struct clk *clk)
  * Using parent clock DPLL data, look up DPLL state.  If locked, set our
  * rate to the dpll_clk * 2; otherwise, just use dpll_clk.
  */
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw, unsigned long parent_rate)
 {
 	const struct dpll_data *dd;
@@ -782,22 +599,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw, unsigned long parent_rate
 			break;
 		pclk = to_clk_hw_omap(hw);
 	} while (pclk && !pclk->dpll_data);
-#else
-unsigned long omap3_clkoutx2_recalc(struct clk *clk)
-{
-	const struct dpll_data *dd;
-	unsigned long rate;
-	u32 v;
-	struct clk *pclk;
-	unsigned long parent_rate;
-
-	/* Walk up the parents of clk, looking for a DPLL */
-	pclk = __clk_get_parent(clk);
-	while (pclk && !pclk->dpll_data)
-		pclk = __clk_get_parent(pclk);
 
-	parent_rate = __clk_get_rate(__clk_get_parent(clk));
-#endif
 	/* clk does not have a DPLL as a parent? */
 	WARN_ON(!pclk);
 
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 529c79d..fe2a505 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -22,11 +22,7 @@
 #include "cm-regbits-44xx.h"
 
 /* Supported only on OMAP4 */
-#ifdef CONFIG_COMMON_CLK
 int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *clk)
-#else
-int omap4_dpllmx_gatectrl_read(struct clk *clk)
-#endif
 {
 	u32 v;
 	u32 mask;
@@ -45,11 +41,7 @@ int omap4_dpllmx_gatectrl_read(struct clk *clk)
 	return v;
 }
 
-#ifdef CONFIG_COMMON_CLK
 void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk)
-#else
-void omap4_dpllmx_allow_gatectrl(struct clk *clk)
-#endif
 {
 	u32 v;
 	u32 mask;
@@ -67,11 +59,7 @@ void omap4_dpllmx_allow_gatectrl(struct clk *clk)
 	__raw_writel(v, clk->clksel_reg);
 }
 
-#ifdef CONFIG_COMMON_CLK
 void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk)
-#else
-void omap4_dpllmx_deny_gatectrl(struct clk *clk)
-#endif
 {
 	u32 v;
 	u32 mask;
@@ -89,17 +77,10 @@ void omap4_dpllmx_deny_gatectrl(struct clk *clk)
 	__raw_writel(v, clk->clksel_reg);
 }
 
-#ifdef CONFIG_COMMON_CLK
 const struct clk_hw_omap_ops clkhwops_omap4_dpllmx = {
 	.allow_idle	= omap4_dpllmx_allow_gatectrl,
 	.deny_idle      = omap4_dpllmx_deny_gatectrl,
 };
-#else
-const struct clkops clkops_omap4_dpllmx_ops = {
-	.allow_idle	= omap4_dpllmx_allow_gatectrl,
-	.deny_idle	= omap4_dpllmx_deny_gatectrl,
-};
-#endif
 
 /**
  * omap4_dpll_regm4xen_recalc - compute DPLL rate, considering REGM4XEN bit
@@ -110,15 +91,10 @@ const struct clkops clkops_omap4_dpllmx_ops = {
  * OMAP4 ABE DPLL.  Returns the DPLL's output rate (before M-dividers)
  * upon success, or 0 upon error.
  */
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 			unsigned long parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk)
-{
-#endif
 	u32 v;
 	unsigned long rate;
 	struct dpll_data *dd;
@@ -150,15 +126,10 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk)
  * M-dividers) upon success, -EINVAL if @clk is null or not a DPLL, or
  * ~0 if an error occurred in omap2_dpll_round_rate().
  */
-#ifdef CONFIG_COMMON_CLK
 long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw, unsigned long target_rate,
 			unsigned long *parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
-{
-#endif
 	u32 v;
 	struct dpll_data *dd;
 	long r;
@@ -174,11 +145,7 @@ long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
 	if (v)
 		target_rate = target_rate / OMAP4430_REGM4XEN_MULT;
 
-#ifdef CONFIG_COMMON_CLK
 	r = omap2_dpll_round_rate(hw, target_rate, NULL);
-#else
-	r = omap2_dpll_round_rate(clk, target_rate);
-#endif
 	if (r == ~0)
 		return r;
 
-- 
1.7.1

