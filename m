From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 10/29] ARM: omap: clk: Remove all direct dereferncing of struct clk
Date: Thu, 14 Jun 2012 18:16:59 +0530
Message-ID: <1339678038-23082-11-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48625 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab2FNMsK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 08:48:10 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

While we work on moving to COMMON clk, direct deferencing of struct
clk wouldn't be possible anymore. Hence get rid of all such instances
in the current clock code and use macros similar to the ones that
are defined with COMMON clk.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clkt2xxx_apll.c          |    2 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    4 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |   18 +++---
 arch/arm/mach-omap2/clkt_clksel.c            |   84 ++++++++++++++++++--------
 arch/arm/mach-omap2/clkt_dpll.c              |   24 ++++---
 arch/arm/mach-omap2/clock.c                  |    9 ++-
 arch/arm/mach-omap2/dpll3xxx.c               |   45 ++++++++------
 arch/arm/mach-omap2/omap_hwmod.c             |    6 +-
 arch/arm/mach-omap2/pm.c                     |    2 +-
 arch/arm/plat-omap/include/plat/clock.h      |    4 +
 10 files changed, 125 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index b19a1f7..c2d1521 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -59,7 +59,7 @@ static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 	omap2_cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
 	omap2_cm_wait_idlest(cm_idlest_pll, status_mask,
-			     OMAP24XX_CM_IDLEST_VAL, clk->name);
+			     OMAP24XX_CM_IDLEST_VAL, __clk_get_name(clk));
 
 	/*
 	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 3d9d746..3a27426 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -75,7 +75,7 @@ long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
 	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
 		if (!(ptr->flags & cpu_mask))
 			continue;
-		if (ptr->xtal_speed != sclk->rate)
+		if (ptr->xtal_speed != __clk_get_rate(sclk))
 			continue;
 
 		highest_rate = ptr->mpu_speed;
@@ -99,7 +99,7 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 		if (!(prcm->flags & cpu_mask))
 			continue;
 
-		if (prcm->xtal_speed != sclk->rate)
+		if (prcm->xtal_speed != __clk_get_rate(sclk))
 			continue;
 
 		if (prcm->mpu_speed <= rate) {
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index d6e34dd..51601db 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -56,6 +56,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	struct omap_sdrc_params *sdrc_cs0;
 	struct omap_sdrc_params *sdrc_cs1;
 	int ret;
+	unsigned long clkrate;
 
 	if (!clk || !rate)
 		return -EINVAL;
@@ -64,11 +65,12 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	if (validrate != rate)
 		return -EINVAL;
 
-	sdrcrate = sdrc_ick_p->rate;
-	if (rate > clk->rate)
-		sdrcrate <<= ((rate / clk->rate) >> 1);
+	sdrcrate = __clk_get_rate(sdrc_ick_p);
+	clkrate = __clk_get_rate(clk);
+	if (rate > clkrate)
+		sdrcrate <<= ((rate / clkrate) >> 1);
 	else
-		sdrcrate >>= ((clk->rate / rate) >> 1);
+		sdrcrate >>= ((clkrate / rate) >> 1);
 
 	ret = omap2_sdrc_get_params(sdrcrate, &sdrc_cs0, &sdrc_cs1);
 	if (ret)
@@ -82,7 +84,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	/*
 	 * XXX This only needs to be done when the CPU frequency changes
 	 */
-	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
+	_mpurate = __clk_get_rate(arm_fck_p) / CYCLES_PER_MHZ;
 	c = (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
 	c += 1;  /* for safety */
 	c *= SDRC_MPURATE_LOOPS;
@@ -90,7 +92,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	if (c == 0)
 		c = 1;
 
-	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
+	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clkrate,
 		 validrate);
 	pr_debug("clock: SDRC CS0 timing params used:"
 		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
@@ -104,14 +106,14 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 
 	if (sdrc_cs1)
 		omap3_configure_core_dpll(
-				  new_div, unlock_dll, c, rate > clk->rate,
+				  new_div, unlock_dll, c, rate > clkrate,
 				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
 				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
 				  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
 				  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
 	else
 		omap3_configure_core_dpll(
-				  new_div, unlock_dll, c, rate > clk->rate,
+				  new_div, unlock_dll, c, rate > clkrate,
 				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
 				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
 				  0, 0, 0, 0);
diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index 04d551b..1c054ba 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -72,7 +72,9 @@ static const struct clksel *_get_clksel_by_parent(struct clk *clk,
 	if (!clks->parent) {
 		/* This indicates a data problem */
 		WARN(1, "clock: Could not find parent clock %s in clksel array "
-		     "of clock %s\n", src_clk->name, clk->name);
+		     "of clock %s\n",
+		      __clk_get_name(src_clk),
+		      __clk_get_name(clk));
 		return NULL;
 	}
 
@@ -127,7 +129,8 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
 	if (max_div == 0) {
 		/* This indicates an error in the clksel data */
 		WARN(1, "clock: Could not find divisor for clock %s parent %s"
-		     "\n", clk->name, src_clk->parent->name);
+		     "\n", __clk_get_name(clk),
+		     __clk_get_name(__clk_get_parent(src_clk)));
 		return 0;
 	}
 
@@ -176,8 +179,10 @@ static u32 _clksel_to_divisor(struct clk *clk, u32 field_val)
 {
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
+	struct clk *parent;
 
-	clks = _get_clksel_by_parent(clk, clk->parent);
+	parent = __clk_get_parent(clk);
+	clks = _get_clksel_by_parent(clk, parent);
 	if (!clks)
 		return 0;
 
@@ -192,7 +197,9 @@ static u32 _clksel_to_divisor(struct clk *clk, u32 field_val)
 	if (!clkr->div) {
 		/* This indicates a data error */
 		WARN(1, "clock: Could not find fieldval %d for clock %s parent "
-		     "%s\n", field_val, clk->name, clk->parent->name);
+		     "%s\n", field_val,
+		     __clk_get_name(clk),
+		     __clk_get_name(parent));
 		return 0;
 	}
 
@@ -213,11 +220,13 @@ static u32 _divisor_to_clksel(struct clk *clk, u32 div)
 {
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
+	struct clk *parent;
 
 	/* should never happen */
 	WARN_ON(div == 0);
 
-	clks = _get_clksel_by_parent(clk, clk->parent);
+	parent = __clk_get_parent(clk);
+	clks = _get_clksel_by_parent(clk, parent);
 	if (!clks)
 		return ~0;
 
@@ -231,7 +240,9 @@ static u32 _divisor_to_clksel(struct clk *clk, u32 div)
 
 	if (!clkr->div) {
 		pr_err("clock: Could not find divisor %d for clock %s parent "
-		       "%s\n", div, clk->name, clk->parent->name);
+		       "%s\n", div,
+		       __clk_get_name(clk),
+		       __clk_get_name(parent));
 		return ~0;
 	}
 
@@ -281,16 +292,23 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
 	u32 last_div = 0;
+	struct clk *parent;
+	unsigned long parent_rate;
+	const char *clk_name;
+
+	parent = __clk_get_parent(clk);
+	parent_rate = __clk_get_rate(parent);
+	clk_name = __clk_get_name(clk);
 
 	if (!clk->clksel || !clk->clksel_mask)
 		return ~0;
 
 	pr_debug("clock: clksel_round_rate_div: %s target_rate %ld\n",
-		 clk->name, target_rate);
+		 clk_name, target_rate);
 
 	*new_div = 1;
 
-	clks = _get_clksel_by_parent(clk, clk->parent);
+	clks = _get_clksel_by_parent(clk, parent);
 	if (!clks)
 		return ~0;
 
@@ -301,11 +319,11 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 		/* Sanity check */
 		if (clkr->div <= last_div)
 			pr_err("clock: clksel_rate table not sorted "
-			       "for clock %s", clk->name);
+			       "for clock %s", clk_name);
 
 		last_div = clkr->div;
 
-		test_rate = clk->parent->rate / clkr->div;
+		test_rate = parent_rate / clkr->div;
 
 		if (test_rate <= target_rate)
 			break; /* found it */
@@ -314,16 +332,16 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 	if (!clkr->div) {
 		pr_err("clock: Could not find divisor for target "
 		       "rate %ld for clock %s parent %s\n", target_rate,
-		       clk->name, clk->parent->name);
+		       clk_name, __clk_get_name(parent));
 		return ~0;
 	}
 
 	*new_div = clkr->div;
 
 	pr_debug("clock: new_div = %d, new_rate = %ld\n", *new_div,
-		 (clk->parent->rate / clkr->div));
+		 (parent_rate / clkr->div));
 
-	return clk->parent->rate / clkr->div;
+	return parent_rate / clkr->div;
 }
 
 /*
@@ -345,10 +363,15 @@ void omap2_init_clksel_parent(struct clk *clk)
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
 	u32 r, found = 0;
+	struct clk *parent;
+	const char *clk_name;
 
 	if (!clk->clksel || !clk->clksel_mask)
 		return;
 
+	parent = __clk_get_parent(clk);
+	clk_name = __clk_get_name(clk);
+
 	r = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
 	r >>= __ffs(clk->clksel_mask);
 
@@ -358,12 +381,14 @@ void omap2_init_clksel_parent(struct clk *clk)
 				continue;
 
 			if (clkr->val == r) {
-				if (clk->parent != clks->parent) {
+				if (parent != clks->parent) {
 					pr_debug("clock: inited %s parent "
 						 "to %s (was %s)\n",
-						 clk->name, clks->parent->name,
-						 ((clk->parent) ?
-						  clk->parent->name : "NULL"));
+						 clk_name,
+						 __clk_get_name(clks->parent),
+						 ((parent) ?
+						  __clk_get_name(parent) :
+						 "NULL"));
 					clk_reparent(clk, clks->parent);
 				};
 				found = 1;
@@ -373,7 +398,7 @@ void omap2_init_clksel_parent(struct clk *clk)
 
 	/* This indicates a data error */
 	WARN(!found, "clock: %s: init parent: could not find regval %0x\n",
-	     clk->name, r);
+	     clk_name, r);
 
 	return;
 }
@@ -391,14 +416,17 @@ unsigned long omap2_clksel_recalc(struct clk *clk)
 {
 	unsigned long rate;
 	u32 div = 0;
+	struct clk *parent;
 
 	div = _read_divisor(clk);
 	if (div == 0)
-		return clk->rate;
+		return __clk_get_rate(clk);
 
-	rate = clk->parent->rate / div;
+	parent = __clk_get_parent(clk);
+	rate = __clk_get_rate(parent) / div;
 
-	pr_debug("clock: %s: recalc'd rate is %ld (div %d)\n", clk->name,
+	pr_debug("clock: %s: recalc'd rate is %ld (div %d)\n",
+		 __clk_get_name(clk),
 		 rate, div);
 
 	return rate;
@@ -454,9 +482,11 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 
 	_write_clksel_reg(clk, field_val);
 
-	clk->rate = clk->parent->rate / new_div;
+	clk->rate = __clk_get_rate(__clk_get_parent(clk)) / new_div;
 
-	pr_debug("clock: %s: set rate to %ld\n", clk->name, clk->rate);
+	pr_debug("clock: %s: set rate to %ld\n",
+				__clk_get_name(clk),
+				__clk_get_rate(clk));
 
 	return 0;
 }
@@ -498,13 +528,15 @@ int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent)
 	clk_reparent(clk, new_parent);
 
 	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
-	clk->rate = new_parent->rate;
+	clk->rate = __clk_get_rate(new_parent);
 
 	if (parent_div > 0)
-		clk->rate /= parent_div;
+		__clk_get_rate(clk) /= parent_div;
 
 	pr_debug("clock: %s: set parent to %s (new rate %ld)\n",
-		 clk->name, clk->parent->name, clk->rate);
+		 __clk_get_name(clk),
+		 __clk_get_name(__clk_get_parent(clk)),
+		 __clk_get_rate(clk));
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index cd7fd0f..6a8a012 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -87,7 +87,7 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
 	dd = clk->dpll_data;
 
 	/* DPLL divider must result in a valid jitter correction val */
-	fint = clk->parent->rate / n;
+	fint = __clk_get_rate(__clk_get_parent(clk)) / n;
 
 	if (cpu_is_omap24xx()) {
 		/* Should not be called for OMAP2, so warn if it is called */
@@ -252,16 +252,16 @@ u32 omap2_get_dpll_rate(struct clk *clk)
 	if (cpu_is_omap24xx()) {
 		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
-			return dd->clk_bypass->rate;
+			return __clk_get_rate(dd->clk_bypass);
 	} else if (cpu_is_omap34xx()) {
 		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
-			return dd->clk_bypass->rate;
+			return __clk_get_rate(dd->clk_bypass);
 	} else if (cpu_is_omap44xx()) {
 		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
 		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
-			return dd->clk_bypass->rate;
+			return __clk_get_rate(dd->clk_bypass);
 	}
 
 	v = __raw_readl(dd->mult_div1_reg);
@@ -270,7 +270,7 @@ u32 omap2_get_dpll_rate(struct clk *clk)
 	dpll_div = v & dd->div1_mask;
 	dpll_div >>= __ffs(dd->div1_mask);
 
-	dpll_clk = (long long)dd->clk_ref->rate * dpll_mult;
+	dpll_clk = (long long) __clk_get_rate(dd->clk_ref) * dpll_mult;
 	do_div(dpll_clk, dpll_div + 1);
 
 	return dpll_clk;
@@ -296,16 +296,20 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 	unsigned long scaled_rt_rp;
 	unsigned long new_rate = 0;
 	struct dpll_data *dd;
+	unsigned long ref_rate;
+	const char *clk_name;
 
 	if (!clk || !clk->dpll_data)
 		return ~0;
 
 	dd = clk->dpll_data;
 
+	ref_rate = __clk_get_rate(dd->clk_ref);
+	clk_name = __clk_get_name(clk);
 	pr_debug("clock: %s: starting DPLL round_rate, target rate %ld\n",
-		 clk->name, target_rate);
+		 clk_name, target_rate);
 
-	scaled_rt_rp = target_rate / (dd->clk_ref->rate / DPLL_SCALE_FACTOR);
+	scaled_rt_rp = target_rate / (ref_rate / DPLL_SCALE_FACTOR);
 	scaled_max_m = dd->max_multiplier * DPLL_SCALE_FACTOR;
 
 	dd->last_rounded_rate = 0;
@@ -332,14 +336,14 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 			break;
 
 		r = _dpll_test_mult(&m, n, &new_rate, target_rate,
-				    dd->clk_ref->rate);
+				    ref_rate);
 
 		/* m can't be set low enough for this n - try with a larger n */
 		if (r == DPLL_MULT_UNDERFLOW)
 			continue;
 
 		pr_debug("clock: %s: m = %d: n = %d: new_rate = %ld\n",
-			 clk->name, m, n, new_rate);
+			 clk_name, m, n, new_rate);
 
 		if (target_rate == new_rate) {
 			dd->last_rounded_m = m;
@@ -350,7 +354,7 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 	}
 
 	if (target_rate != new_rate) {
-		pr_debug("clock: %s: cannot round to rate %ld\n", clk->name,
+		pr_debug("clock: %s: cannot round to rate %ld\n", clk_name,
 			 target_rate);
 		return ~0;
 	}
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 5c4e665..aa00f72 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -76,7 +76,7 @@ static void _omap2_module_wait_ready(struct clk *clk)
 	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit, &idlest_val);
 
 	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), idlest_val,
-			     clk->name);
+			     __clk_get_name(clk));
 }
 
 /* Public functions */
@@ -92,18 +92,21 @@ static void _omap2_module_wait_ready(struct clk *clk)
 void omap2_init_clk_clkdm(struct clk *clk)
 {
 	struct clockdomain *clkdm;
+	const char *clk_name;
 
 	if (!clk->clkdm_name)
 		return;
 
+	clk_name = __clk_get_name(clk);
+
 	clkdm = clkdm_lookup(clk->clkdm_name);
 	if (clkdm) {
 		pr_debug("clock: associated clk %s to clkdm %s\n",
-			 clk->name, clk->clkdm_name);
+			 clk_name, clk->clkdm_name);
 		clk->clkdm = clkdm;
 	} else {
 		pr_debug("clock: could not associate clk %s to "
-			 "clkdm %s\n", clk->name, clk->clkdm_name);
+			 "clkdm %s\n", clk_name, clk->clkdm_name);
 	}
 }
 
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f0f10be..d390f40 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -63,8 +63,10 @@ static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
 	const struct dpll_data *dd;
 	int i = 0;
 	int ret = -EINVAL;
+	const char *clk_name;
 
 	dd = clk->dpll_data;
+	clk_name = __clk_get_name(clk);
 
 	state <<= __ffs(dd->idlest_mask);
 
@@ -76,10 +78,10 @@ static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
 
 	if (i == MAX_DPLL_WAIT_TRIES) {
 		printk(KERN_ERR "clock: %s failed transition to '%s'\n",
-		       clk->name, (state) ? "locked" : "bypassed");
+		       clk_name, (state) ? "locked" : "bypassed");
 	} else {
 		pr_debug("clock: %s transition to '%s' in %d loops\n",
-			 clk->name, (state) ? "locked" : "bypassed", i);
+			 clk_name, (state) ? "locked" : "bypassed", i);
 
 		ret = 0;
 	}
@@ -93,7 +95,7 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
 	unsigned long fint;
 	u16 f = 0;
 
-	fint = clk->dpll_data->clk_ref->rate / n;
+	fint = __clk_get_rate(clk->dpll_data->clk_ref) / n;
 
 	pr_debug("clock: fint is %lu\n", fint);
 
@@ -138,7 +140,7 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
 	u8 ai;
 	int r;
 
-	pr_debug("clock: locking DPLL %s\n", clk->name);
+	pr_debug("clock: locking DPLL %s\n", __clk_get_name(clk));
 
 	ai = omap3_dpll_autoidle_read(clk);
 
@@ -177,7 +179,7 @@ static int _omap3_noncore_dpll_bypass(struct clk *clk)
 		return -EINVAL;
 
 	pr_debug("clock: configuring DPLL %s for low-power bypass\n",
-		 clk->name);
+		 __clk_get_name(clk));
 
 	ai = omap3_dpll_autoidle_read(clk);
 
@@ -207,7 +209,7 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_STOP)))
 		return -EINVAL;
 
-	pr_debug("clock: stopping DPLL %s\n", clk->name);
+	pr_debug("clock: stopping DPLL %s\n", __clk_get_name(clk));
 
 	ai = omap3_dpll_autoidle_read(clk);
 
@@ -235,7 +237,7 @@ static void _lookup_dco(struct clk *clk, u8 *dco, u16 m, u8 n)
 {
 	unsigned long fint, clkinp; /* watch out for overflow */
 
-	clkinp = clk->parent->rate;
+	clkinp = __clk_get_rate(__clk_get_parent(clk));
 	fint = (clkinp / n) * m;
 
 	if (fint < 1000000000)
@@ -261,7 +263,7 @@ static void _lookup_sddiv(struct clk *clk, u8 *sd_div, u16 m, u8 n)
 	unsigned long clkinp, sd; /* watch out for overflow */
 	int mod1, mod2;
 
-	clkinp = clk->parent->rate;
+	clkinp = __clk_get_rate(__clk_get_parent(clk));
 
 	/*
 	 * target sigma-delta to near 250MHz
@@ -370,16 +372,19 @@ int omap3_noncore_dpll_enable(struct clk *clk)
 {
 	int r;
 	struct dpll_data *dd;
+	struct clk *parent;
 
 	dd = clk->dpll_data;
 	if (!dd)
 		return -EINVAL;
 
-	if (clk->rate == dd->clk_bypass->rate) {
-		WARN_ON(clk->parent != dd->clk_bypass);
+	parent = __clk_get_parent(clk);
+
+	if (__clk_get_rate(clk) == __clk_get_rate(dd->clk_bypass)) {
+		WARN_ON(parent != dd->clk_bypass);
 		r = _omap3_noncore_dpll_bypass(clk);
 	} else {
-		WARN_ON(clk->parent != dd->clk_ref);
+		WARN_ON(parent != dd->clk_ref);
 		r = _omap3_noncore_dpll_lock(clk);
 	}
 	/*
@@ -446,7 +451,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	omap2_clk_enable(dd->clk_bypass);
 	omap2_clk_enable(dd->clk_ref);
 
-	if (dd->clk_bypass->rate == rate &&
+	if (__clk_get_rate(dd->clk_bypass) == rate &&
 	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
 		pr_debug("clock: %s: set rate: entering bypass.\n", clk->name);
 
@@ -469,7 +474,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		}
 
 		pr_debug("clock: %s: set rate: locking rate to %lu.\n",
-			 clk->name, rate);
+			 __clk_get_name(clk), rate);
 
 		ret = omap3_noncore_dpll_program(clk, dd->last_rounded_m,
 						 dd->last_rounded_n, freqsel);
@@ -547,7 +552,7 @@ void omap3_dpll_allow_idle(struct clk *clk)
 
 	if (!dd->autoidle_reg) {
 		pr_debug("clock: DPLL %s: autoidle not supported\n",
-			clk->name);
+			__clk_get_name(clk));
 		return;
 	}
 
@@ -581,7 +586,7 @@ void omap3_dpll_deny_idle(struct clk *clk)
 
 	if (!dd->autoidle_reg) {
 		pr_debug("clock: DPLL %s: autoidle not supported\n",
-			clk->name);
+			__clk_get_name(clk));
 		return;
 	}
 
@@ -607,11 +612,12 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 	unsigned long rate;
 	u32 v;
 	struct clk *pclk;
+	unsigned long parent_rate;
 
 	/* Walk up the parents of clk, looking for a DPLL */
-	pclk = clk->parent;
+	pclk = __clk_get_parent(clk);
 	while (pclk && !pclk->dpll_data)
-		pclk = pclk->parent;
+		pclk = __clk_get_parent(pclk);
 
 	/* clk does not have a DPLL as a parent? */
 	WARN_ON(!pclk);
@@ -620,11 +626,12 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 
 	WARN_ON(!dd->enable_mask);
 
+	parent_rate = __clk_get_rate(__clk_get_parent(clk));
 	v = __raw_readl(dd->control_reg) & dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
-		rate = clk->parent->rate;
+		rate = parent_rate;
 	else
-		rate = clk->parent->rate * 2;
+		rate = parent_rate * 2;
 	return rate;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3f3ae15..2ebcacf 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -611,7 +611,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 
 	if (!oh->_clk->clkdm)
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
-			   oh->main_clk, oh->_clk->name);
+			   oh->name, oh->main_clk);
 
 	return ret;
 }
@@ -750,7 +750,7 @@ static void _enable_optional_clocks(struct omap_hwmod *oh)
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
 		if (oc->_clk) {
 			pr_debug("omap_hwmod: enable %s:%s\n", oc->role,
-				 oc->_clk->name);
+				 __clk_get_name(oc->_clk));
 			clk_prepare_enable(oc->_clk);
 		}
 }
@@ -765,7 +765,7 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
 		if (oc->_clk) {
 			pr_debug("omap_hwmod: disable %s:%s\n", oc->role,
-				 oc->_clk->name);
+				 __clk_get_name(oc->_clk));
 			clk_disable_unprepare(oc->_clk);
 		}
 }
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 9cb5ced..40012e3 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -188,7 +188,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 		goto exit;
 	}
 
-	freq = clk->rate;
+	freq = clk_get_rate(clk);
 	clk_put(clk);
 
 	rcu_read_lock();
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 741275d..68321b9 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -27,6 +27,10 @@ struct module;
 struct clk;
 struct clockdomain;
 
+#define __clk_get_name(clk) clk->name
+#define __clk_get_parent(clk) clk->parent
+#define __clk_get_rate(clk) clk->rate
+
 /**
  * struct clkops - some clock function pointers
  * @enable: fn ptr that enables the current clock in hardware
-- 
1.7.1

