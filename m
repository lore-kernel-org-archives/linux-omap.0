From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/12] ARM: OMAP2: Clock: New OMAP2/3 DPLL rate rounding algorithm
Date: Fri,  6 Jun 2008 18:35:07 -0700
Message-ID: <1212802517-17885-3-git-send-email-tony@atomide.com>
References: omap2-clocks-2008-06-06-183514
 <1212802517-17885-1-git-send-email-tony@atomide.com>
 <1212802517-17885-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54832 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbYFGBfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:35:24 -0400
In-Reply-To: <1212802517-17885-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

This patch adds a new rate rounding algorithm for DPLL clocks on the
OMAP2/3 architecture.

For a desired DPLL target rate, there may be several
multiplier/divider (M, N) values which will generate a sufficiently
close rate.  Lower N values result in greater power economy.  However,
lower N values can cause the difference between the rounded rate and
the target rate ("rate error") to be larger than it would be with a
higher N.  This can cause downstream devices to run more slowly than
they otherwise would.

This DPLL rate rounding algorithm:

- attempts to find the lowest possible N (DPLL divider) to reach the
  target_rate (since, according to Richard Woodruff <r-woodruff@ti.com>,
  lower N values save more power than higher N values).

- allows developers to set an upper bound on the error between the
  rounded rate and the desired target rate ("rate tolerance"), so an
  appropriate balance between rate fidelity and power savings can be
  set.  This maximum rate error tolerance is set via
  omap2_set_dpll_rate_tolerance().

- never returns a rounded rate higher than the target rate.

The rate rounding algorithm caches the last rounded M, N, and rate
computation to avoid rounding the rate twice for each clk_set_rate()
call.  (This patch does not yet implement set_rate for DPLLs; that
follows in a future patch.)

The algorithm trades execution speed for rate accuracy.  It will find
the (M, N) set that results in the least rate error, within a
specified rate tolerance.  It does this by evaluating each divider
setting - on OMAP3, this involves 128 steps.  Another approach to DPLL
rate rounding would be to bail out as soon as a valid rate is found
within the rate tolerance, which would trade rate accuracy for
execution speed.  Alternate implementations welcome.

This code is not yet used by the OMAP24XX DPLL clock, since it
is currently defined as a composite clock, fusing the DPLL M,N and the
M2 output divider.  This patch also renames the existing OMAP24xx DPLL
programming functions to highlight that they program both the DPLL and
the DPLL's output multiplier.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 0243480..15675bc 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -41,6 +41,24 @@
 
 #define MAX_CLOCK_ENABLE_WAIT		100000
 
+/* DPLL rate rounding: minimum DPLL multiplier, divider values */
+#define DPLL_MIN_MULTIPLIER		1
+#define DPLL_MIN_DIVIDER		1
+
+/* Possible error results from _dpll_test_mult */
+#define DPLL_MULT_UNDERFLOW		(1 << 0)
+
+/*
+ * Scale factor to mitigate roundoff errors in DPLL rate rounding.
+ * The higher the scale factor, the greater the risk of arithmetic overflow,
+ * but the closer the rounded rate to the target rate.  DPLL_SCALE_FACTOR
+ * must be a power of DPLL_SCALE_BASE.
+ */
+#define DPLL_SCALE_FACTOR		64
+#define DPLL_SCALE_BASE			2
+#define DPLL_ROUNDING_VAL		((DPLL_SCALE_BASE / 2) * \
+					 (DPLL_SCALE_FACTOR / DPLL_SCALE_BASE))
+
 u8 cpu_mask;
 
 /*-------------------------------------------------------------------------
@@ -95,7 +113,7 @@ u32 omap2_get_dpll_rate(struct clk *clk)
 {
 	long long dpll_clk;
 	u32 dpll_mult, dpll_div, dpll;
-	const struct dpll_data *dd;
+	struct dpll_data *dd;
 
 	dd = clk->dpll_data;
 	/* REVISIT: What do we return on error? */
@@ -724,6 +742,184 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	return 0;
 }
 
+/* DPLL rate rounding code */
+
+/**
+ * omap2_dpll_set_rate_tolerance: set the error tolerance during rate rounding
+ * @clk: struct clk * of the DPLL
+ * @tolerance: maximum rate error tolerance
+ *
+ * Set the maximum DPLL rate error tolerance for the rate rounding
+ * algorithm.  The rate tolerance is an attempt to balance DPLL power
+ * saving (the least divider value "n") vs. rate fidelity (the least
+ * difference between the desired DPLL target rate and the rounded
+ * rate out of the algorithm).  So, increasing the tolerance is likely
+ * to decrease DPLL power consumption and increase DPLL rate error.
+ * Returns -EINVAL if provided a null clock ptr or a clk that is not a
+ * DPLL; or 0 upon success.
+ */
+int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance)
+{
+	if (!clk || !clk->dpll_data)
+		return -EINVAL;
+
+	clk->dpll_data->rate_tolerance = tolerance;
+
+	return 0;
+}
+
+static unsigned long _dpll_compute_new_rate(unsigned long parent_rate, unsigned int m, unsigned int n)
+{
+	unsigned long long num;
+
+	num = (unsigned long long)parent_rate * m;
+	do_div(num, n);
+	return num;
+}
+
+/*
+ * _dpll_test_mult - test a DPLL multiplier value
+ * @m: pointer to the DPLL m (multiplier) value under test
+ * @n: current DPLL n (divider) value under test
+ * @new_rate: pointer to storage for the resulting rounded rate
+ * @target_rate: the desired DPLL rate
+ * @parent_rate: the DPLL's parent clock rate
+ *
+ * This code tests a DPLL multiplier value, ensuring that the
+ * resulting rate will not be higher than the target_rate, and that
+ * the multiplier value itself is valid for the DPLL.  Initially, the
+ * integer pointed to by the m argument should be prescaled by
+ * multiplying by DPLL_SCALE_FACTOR.  The code will replace this with
+ * a non-scaled m upon return.  This non-scaled m will result in a
+ * new_rate as close as possible to target_rate (but not greater than
+ * target_rate) given the current (parent_rate, n, prescaled m)
+ * triple. Returns DPLL_MULT_UNDERFLOW in the event that the
+ * non-scaled m attempted to underflow, which can allow the calling
+ * function to bail out early; or 0 upon success.
+ */
+static int _dpll_test_mult(int *m, int n, unsigned long *new_rate,
+			   unsigned long target_rate,
+			   unsigned long parent_rate)
+{
+	int flags = 0, carry = 0;
+
+	/* Unscale m and round if necessary */
+	if (*m % DPLL_SCALE_FACTOR >= DPLL_ROUNDING_VAL)
+		carry = 1;
+	*m = (*m / DPLL_SCALE_FACTOR) + carry;
+
+	/*
+	 * The new rate must be <= the target rate to avoid programming
+	 * a rate that is impossible for the hardware to handle
+	 */
+	*new_rate = _dpll_compute_new_rate(parent_rate, *m, n);
+	if (*new_rate > target_rate) {
+		(*m)--;
+		*new_rate = 0;
+	}
+
+	/* Guard against m underflow */
+	if (*m < DPLL_MIN_MULTIPLIER) {
+		*m = DPLL_MIN_MULTIPLIER;
+		*new_rate = 0;
+		flags = DPLL_MULT_UNDERFLOW;
+	}
+
+	if (*new_rate == 0)
+		*new_rate = _dpll_compute_new_rate(parent_rate, *m, n);
+
+	return flags;
+}
+
+/**
+ * omap2_dpll_round_rate - round a target rate for an OMAP DPLL
+ * @clk: struct clk * for a DPLL
+ * @target_rate: desired DPLL clock rate
+ *
+ * Given a DPLL, a desired target rate, and a rate tolerance, round
+ * the target rate to a possible, programmable rate for this DPLL.
+ * Rate tolerance is assumed to be set by the caller before this
+ * function is called.  Attempts to select the minimum possible n
+ * within the tolerance to reduce power consumption.  Stores the
+ * computed (m, n) in the DPLL's dpll_data structure so set_rate()
+ * will not need to call this (expensive) function again.  Returns ~0
+ * if the target rate cannot be rounded, either because the rate is
+ * too low or because the rate tolerance is set too tightly; or the
+ * rounded rate upon success.
+ */
+long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
+{
+	int m, n, r, e, scaled_max_m;
+	unsigned long scaled_rt_rp, new_rate;
+	int min_e = -1, min_e_m = -1, min_e_n = -1;
+
+	if (!clk || !clk->dpll_data)
+		return ~0;
+
+	pr_debug("clock: starting DPLL round_rate for clock %s, target rate "
+		 "%ld\n", clk->name, target_rate);
+
+	scaled_rt_rp = target_rate / (clk->parent->rate / DPLL_SCALE_FACTOR);
+	scaled_max_m = clk->dpll_data->max_multiplier * DPLL_SCALE_FACTOR;
+
+	clk->dpll_data->last_rounded_rate = 0;
+
+	for (n = clk->dpll_data->max_divider; n >= DPLL_MIN_DIVIDER; n--) {
+
+		/* Compute the scaled DPLL multiplier, based on the divider */
+		m = scaled_rt_rp * n;
+
+		/*
+		 * Since we're counting n down, a m overflow means we can
+		 * can immediately skip to the next n
+		 */
+		if (m > scaled_max_m)
+			continue;
+
+		r = _dpll_test_mult(&m, n, &new_rate, target_rate,
+				    clk->parent->rate);
+
+		e = target_rate - new_rate;
+		pr_debug("clock: n = %d: m = %d: rate error is %d "
+			 "(new_rate = %ld)\n", n, m, e, new_rate);
+
+		if (min_e == -1 ||
+		    min_e >= (int)(abs(e) - clk->dpll_data->rate_tolerance)) {
+			min_e = e;
+			min_e_m = m;
+			min_e_n = n;
+
+			pr_debug("clock: found new least error %d\n", min_e);
+		}
+
+		/*
+		 * Since we're counting n down, a m underflow means we
+		 * can bail out completely (since as n decreases in
+		 * the next iteration, there's no way that m can
+		 * increase beyond the current m)
+		 */
+		if (r & DPLL_MULT_UNDERFLOW)
+			break;
+	}
+
+	if (min_e < 0) {
+		pr_debug("clock: error: target rate or tolerance too low\n");
+		return ~0;
+	}
+
+	clk->dpll_data->last_rounded_m = min_e_m;
+	clk->dpll_data->last_rounded_n = min_e_n;
+	clk->dpll_data->last_rounded_rate =
+		_dpll_compute_new_rate(clk->parent->rate, min_e_m,  min_e_n);
+
+	pr_debug("clock: final least error: e = %d, m = %d, n = %d\n",
+		 min_e, min_e_m, min_e_n);
+	pr_debug("clock: final rate: %ld  (target rate: %ld)\n",
+		 clk->dpll_data->last_rounded_rate, target_rate);
+
+	return clk->dpll_data->last_rounded_rate;
+}
+
 /*-------------------------------------------------------------------------
  * Omap2 clock reset and init functions
  *-------------------------------------------------------------------------*/
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index f979485..3cd37cb 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -18,11 +18,16 @@
 
 #include <asm/arch/clock.h>
 
+/* The maximum error between a target DPLL rate and the rounded rate in Hz */
+#define DEFAULT_DPLL_RATE_TOLERANCE	50000
+
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
+int omap2_dpll_rate_tolerance_set(struct clk *clk, unsigned int tolerance);
+long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index ece32d8..aa56787 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -154,7 +154,7 @@ static void omap2_clk_fixed_disable(struct clk *clk)
  * Uses the current prcm set to tell if a rate is valid.
  * You can go slower, but not faster within a given rate set.
  */
-static u32 omap2_dpll_round_rate(unsigned long target_rate)
+long omap2_dpllcore_round_rate(unsigned long target_rate)
 {
 	u32 high, low, core_clk_src;
 
@@ -183,14 +183,14 @@ static u32 omap2_dpll_round_rate(unsigned long target_rate)
 
 }
 
-static void omap2_dpll_recalc(struct clk *clk)
+static void omap2_dpllcore_recalc(struct clk *clk)
 {
 	clk->rate = omap2_get_dpll_rate_24xx(clk);
 
 	propagate_rate(clk);
 }
 
-static int omap2_reprogram_dpll(struct clk *clk, unsigned long rate)
+static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 {
 	u32 cur_rate, low, mult, div, valid_rate, done_rate;
 	u32 bypass = 0;
@@ -209,7 +209,7 @@ static int omap2_reprogram_dpll(struct clk *clk, unsigned long rate)
 	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
 		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1);
 	} else if (rate != cur_rate) {
-		valid_rate = omap2_dpll_round_rate(rate);
+		valid_rate = omap2_dpllcore_round_rate(rate);
 		if (valid_rate != rate)
 			goto dpll_exit;
 
@@ -256,7 +256,7 @@ static int omap2_reprogram_dpll(struct clk *clk, unsigned long rate)
 		omap2_init_memory_params(omap2_dll_force_needed());
 		omap2_reprogram_sdrc(done_rate, 0);
 	}
-	omap2_dpll_recalc(&dpll_ck);
+	omap2_dpllcore_recalc(&dpll_ck);
 	ret = 0;
 
 dpll_exit:
@@ -383,7 +383,7 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
 		local_irq_restore(flags);
 	}
-	omap2_dpll_recalc(&dpll_ck);
+	omap2_dpllcore_recalc(&dpll_ck);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 06e1118..be4e255 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -30,12 +30,12 @@ static long omap2_round_to_table_rate(struct clk *clk, unsigned long rate);
 static void omap2_sys_clk_recalc(struct clk *clk);
 static void omap2_osc_clk_recalc(struct clk *clk);
 static void omap2_sys_clk_recalc(struct clk *clk);
-static void omap2_dpll_recalc(struct clk *clk);
+static void omap2_dpllcore_recalc(struct clk *clk);
 static int omap2_clk_fixed_enable(struct clk *clk);
 static void omap2_clk_fixed_disable(struct clk *clk);
 static int omap2_enable_osc_ck(struct clk *clk);
 static void omap2_disable_osc_ck(struct clk *clk);
-static int omap2_reprogram_dpll(struct clk *clk, unsigned long rate);
+static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
 
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
@@ -665,20 +665,27 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
  * deal with this
  */
 
-static const struct dpll_data dpll_dd = {
+static struct dpll_data dpll_dd = {
 	.mult_div1_reg		= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.mult_mask		= OMAP24XX_DPLL_MULT_MASK,
 	.div1_mask		= OMAP24XX_DPLL_DIV_MASK,
+	.max_multiplier		= 1024,
+	.max_divider		= 16,
+	.rate_tolerance		= DEFAULT_DPLL_RATE_TOLERANCE
 };
 
+/*
+ * XXX Cannot add round_rate here yet, as this is still a composite clock,
+ * not just a DPLL
+ */
 static struct clk dpll_ck = {
 	.name		= "dpll_ck",
 	.parent		= &sys_ck,		/* Can be func_32k also */
 	.dpll_data	= &dpll_dd,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | ALWAYS_ENABLED,
-	.recalc		= &omap2_dpll_recalc,
-	.set_rate	= &omap2_reprogram_dpll,
+	.recalc		= &omap2_dpllcore_recalc,
+	.set_rate	= &omap2_reprogram_dpllcore,
 };
 
 static struct clk apll96_ck = {
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index e349d48..05757eb 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -35,6 +35,10 @@ static u32 omap3_dpll_autoidle_read(struct clk *clk);
 static int omap3_noncore_dpll_enable(struct clk *clk);
 static void omap3_noncore_dpll_disable(struct clk *clk);
 
+/* Maximum DPLL multiplier, divider values for OMAP3 */
+#define OMAP3_MAX_DPLL_MULT		2048
+#define OMAP3_MAX_DPLL_DIV		128
+
 /*
  * DPLL1 supplies clock to the MPU.
  * DPLL2 supplies clock to the IVA2.
@@ -255,7 +259,7 @@ static const struct clksel_rate div16_dpll_rates[] = {
 /* DPLL1 */
 /* MPU clock source */
 /* Type: DPLL */
-static const struct dpll_data dpll1_dd = {
+static struct dpll_data dpll1_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.mult_mask	= OMAP3430_MPU_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_MPU_DPLL_DIV_MASK,
@@ -269,6 +273,9 @@ static const struct dpll_data dpll1_dd = {
 	.autoidle_mask	= OMAP3430_AUTO_MPU_DPLL_MASK,
 	.idlest_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.idlest_bit	= OMAP3430_ST_MPU_CLK_SHIFT,
+	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.max_divider	= OMAP3_MAX_DPLL_DIV,
+	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
 static struct clk dpll1_ck = {
@@ -276,6 +283,7 @@ static struct clk dpll1_ck = {
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll1_dd,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -317,7 +325,7 @@ static struct clk dpll1_x2m2_ck = {
 /* IVA2 clock source */
 /* Type: DPLL */
 
-static const struct dpll_data dpll2_dd = {
+static struct dpll_data dpll2_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.mult_mask	= OMAP3430_IVA2_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_IVA2_DPLL_DIV_MASK,
@@ -331,7 +339,10 @@ static const struct dpll_data dpll2_dd = {
 	.autoidle_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_AUTOIDLE_PLL),
 	.autoidle_mask	= OMAP3430_AUTO_IVA2_DPLL_MASK,
 	.idlest_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_IDLEST_PLL),
-	.idlest_bit	= OMAP3430_ST_IVA2_CLK_SHIFT
+	.idlest_bit	= OMAP3430_ST_IVA2_CLK_SHIFT,
+	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.max_divider	= OMAP3_MAX_DPLL_DIV,
+	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
 static struct clk dpll2_ck = {
@@ -341,6 +352,7 @@ static struct clk dpll2_ck = {
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
+	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -371,7 +383,7 @@ static struct clk dpll2_m2_ck = {
  * Source clock for all interfaces and for some device fclks
  * REVISIT: Also supports fast relock bypass - not included below
  */
-static const struct dpll_data dpll3_dd = {
+static struct dpll_data dpll3_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.mult_mask	= OMAP3430_CORE_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_CORE_DPLL_DIV_MASK,
@@ -382,6 +394,9 @@ static const struct dpll_data dpll3_dd = {
 	.recal_st_bit	= OMAP3430_CORE_DPLL_ST_SHIFT,
 	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
 	.autoidle_mask	= OMAP3430_AUTO_CORE_DPLL_MASK,
+	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.max_divider	= OMAP3_MAX_DPLL_DIV,
+	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
 static struct clk dpll3_ck = {
@@ -389,6 +404,7 @@ static struct clk dpll3_ck = {
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll3_dd,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -545,7 +561,7 @@ static struct clk emu_core_alwon_ck = {
 /* DPLL4 */
 /* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace clk */
 /* Type: DPLL */
-static const struct dpll_data dpll4_dd = {
+static struct dpll_data dpll4_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
 	.mult_mask	= OMAP3430_PERIPH_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_PERIPH_DPLL_DIV_MASK,
@@ -559,6 +575,9 @@ static const struct dpll_data dpll4_dd = {
 	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
 	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.idlest_bit	= OMAP3430_ST_PERIPH_CLK_SHIFT,
+	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.max_divider	= OMAP3_MAX_DPLL_DIV,
+	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
 static struct clk dpll4_ck = {
@@ -568,6 +587,7 @@ static struct clk dpll4_ck = {
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
+	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -843,7 +863,7 @@ static struct clk emu_per_alwon_ck = {
 /* Supplies 120MHz clock, USIM source clock */
 /* Type: DPLL */
 /* 3430ES2 only */
-static const struct dpll_data dpll5_dd = {
+static struct dpll_data dpll5_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL4),
 	.mult_mask	= OMAP3430ES2_PERIPH2_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430ES2_PERIPH2_DPLL_DIV_MASK,
@@ -857,6 +877,9 @@ static const struct dpll_data dpll5_dd = {
 	.autoidle_mask	= OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK,
 	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
 	.idlest_bit	= OMAP3430ES2_ST_PERIPH2_CLK_SHIFT,
+	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.max_divider	= OMAP3_MAX_DPLL_DIV,
+	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
 static struct clk dpll5_ck = {
@@ -866,6 +889,7 @@ static struct clk dpll5_ck = {
 	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
+	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
 
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index 22daa5d..4c7b351 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -33,6 +33,13 @@ struct dpll_data {
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
 	u32			div1_mask;
+	u16			last_rounded_m;
+	u8			last_rounded_n;
+	unsigned long		last_rounded_rate;
+	unsigned int		rate_tolerance;
+	u16			max_multiplier;
+	u8			max_divider;
+	u32			max_tolerance;
 #  if defined(CONFIG_ARCH_OMAP3)
 	u8			modes;
 	void __iomem		*control_reg;
@@ -71,7 +78,7 @@ struct clk {
 	void __iomem		*clksel_reg;
 	u32			clksel_mask;
 	const struct clksel	*clksel;
-	const struct dpll_data	*dpll_data;
+	struct dpll_data	*dpll_data;
 #else
 	__u8			rate_offset;
 	__u8			src_offset;
