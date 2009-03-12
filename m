From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 82/86] [ARM] omap: add support for bypassing DPLLs
Date: Thu, 12 Mar 2009 11:28:32 -0700
Message-ID: <1236882516-29403-83-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-66-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-67-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-68-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-69-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-70-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-71-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-72-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-73-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-74-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-75-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-76-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-77-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-78-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-79-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-80-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-81-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-82-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757264AbZCLSej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:34:39 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:34:37 -0700 (PDT)
In-Reply-To: <1236882516-29403-82-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

This roughly corresponds with OMAP commits: 7d06c48, 3241b19,
88b5d9b, 18a5500, 9c909ac, 5c6497b, 8b1f0bd, 2ac1da8.

For both OMAP2 and OMAP3, we note the reference and bypass clocks in
the DPLL data structure.  Whenever we modify the DPLL rate, we first
ensure that both the reference and bypass clocks are enabled.  Then,
we decide whether to use the reference and DPLL, or the bypass clock
if the desired rate is identical to the bypass rate, and program the
DPLL appropriately.  Finally, we update the clock's parent, and then
disable the unused clocks.

This keeps the parents correctly balanced, and more importantly ensures
that the bypass clock is running whenever we reprogram the DPLL.  This
is especially important because the procedure for reprogramming the DPLL
involves switching to the bypass clock.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c             |   47 +++++++--
 arch/arm/mach-omap2/clock.h             |   15 +++
 arch/arm/mach-omap2/clock24xx.c         |   39 +++++---
 arch/arm/mach-omap2/clock24xx.h         |    4 +
 arch/arm/mach-omap2/clock34xx.c         |   90 ++++++++++++----
 arch/arm/mach-omap2/clock34xx.h         |  177 +++++--------------------------
 arch/arm/mach-omap2/sdrc2xxx.c          |    2 +-
 arch/arm/plat-omap/include/mach/clock.h |   11 +--
 8 files changed, 186 insertions(+), 199 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 5020cb1..40cb65b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -211,25 +211,52 @@ void omap2_init_clksel_parent(struct clk *clk)
 	return;
 }
 
-/* Returns the DPLL rate */
+/**
+ * omap2_get_dpll_rate - returns the current DPLL CLKOUT rate
+ * @clk: struct clk * of a DPLL
+ *
+ * DPLLs can be locked or bypassed - basically, enabled or disabled.
+ * When locked, the DPLL output depends on the M and N values.  When
+ * bypassed, on OMAP2xxx, the output rate is either the 32KiHz clock
+ * or sys_clk.  Bypass rates on OMAP3 depend on the DPLL: DPLLs 1 and
+ * 2 are bypassed with dpll1_fclk and dpll2_fclk respectively
+ * (generated by DPLL3), while DPLL 3, 4, and 5 bypass rates are sys_clk.
+ * Returns the current DPLL CLKOUT rate (*not* CLKOUTX2) if the DPLL is
+ * locked, or the appropriate bypass rate if the DPLL is bypassed, or 0
+ * if the clock @clk is not a DPLL.
+ */
 u32 omap2_get_dpll_rate(struct clk *clk)
 {
 	long long dpll_clk;
-	u32 dpll_mult, dpll_div, dpll;
+	u32 dpll_mult, dpll_div, v;
 	struct dpll_data *dd;
 
 	dd = clk->dpll_data;
-	/* REVISIT: What do we return on error? */
 	if (!dd)
 		return 0;
 
-	dpll = __raw_readl(dd->mult_div1_reg);
-	dpll_mult = dpll & dd->mult_mask;
+	/* Return bypass rate if DPLL is bypassed */
+	v = __raw_readl(dd->control_reg);
+	v &= dd->enable_mask;
+	v >>= __ffs(dd->enable_mask);
+
+	if (cpu_is_omap24xx()) {
+		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
+			return dd->clk_bypass->rate;
+	} else if (cpu_is_omap34xx()) {
+		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
+			return dd->clk_bypass->rate;
+	}
+
+	v = __raw_readl(dd->mult_div1_reg);
+	dpll_mult = v & dd->mult_mask;
 	dpll_mult >>= __ffs(dd->mult_mask);
-	dpll_div = dpll & dd->div1_mask;
+	dpll_div = v & dd->div1_mask;
 	dpll_div >>= __ffs(dd->div1_mask);
 
-	dpll_clk = (long long)clk->parent->rate * dpll_mult;
+	dpll_clk = (long long)dd->clk_ref->rate * dpll_mult;
 	do_div(dpll_clk, dpll_div + 1);
 
 	return dpll_clk;
@@ -930,7 +957,7 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 	pr_debug("clock: starting DPLL round_rate for clock %s, target rate "
 		 "%ld\n", clk->name, target_rate);
 
-	scaled_rt_rp = target_rate / (clk->parent->rate / DPLL_SCALE_FACTOR);
+	scaled_rt_rp = target_rate / (dd->clk_ref->rate / DPLL_SCALE_FACTOR);
 	scaled_max_m = dd->max_multiplier * DPLL_SCALE_FACTOR;
 
 	dd->last_rounded_rate = 0;
@@ -957,7 +984,7 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 			break;
 
 		r = _dpll_test_mult(&m, n, &new_rate, target_rate,
-				    clk->parent->rate);
+				    dd->clk_ref->rate);
 
 		/* m can't be set low enough for this n - try with a larger n */
 		if (r == DPLL_MULT_UNDERFLOW)
@@ -988,7 +1015,7 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 
 	dd->last_rounded_m = min_e_m;
 	dd->last_rounded_n = min_e_n;
-	dd->last_rounded_rate = _dpll_compute_new_rate(clk->parent->rate,
+	dd->last_rounded_rate = _dpll_compute_new_rate(dd->clk_ref->rate,
 						       min_e_m,  min_e_n);
 
 	pr_debug("clock: final least error: e = %d, m = %d, n = %d\n",
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index ca6bf22..2679ddf 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -21,6 +21,21 @@
 /* The maximum error between a target DPLL rate and the rounded rate in Hz */
 #define DEFAULT_DPLL_RATE_TOLERANCE	50000
 
+/* CM_CLKSEL2_PLL.CORE_CLK_SRC bits (2XXX) */
+#define CORE_CLK_SRC_32K		0x0
+#define CORE_CLK_SRC_DPLL		0x1
+#define CORE_CLK_SRC_DPLL_X2		0x2
+
+/* OMAP2xxx CM_CLKEN_PLL.EN_DPLL bits - for omap2_get_dpll_rate() */
+#define OMAP2XXX_EN_DPLL_LPBYPASS		0x1
+#define OMAP2XXX_EN_DPLL_FRBYPASS		0x2
+#define OMAP2XXX_EN_DPLL_LOCKED			0x3
+
+/* OMAP3xxx CM_CLKEN_PLL*.EN_*_DPLL bits - for omap2_get_dpll_rate() */
+#define OMAP3XXX_EN_DPLL_LPBYPASS		0x5
+#define OMAP3XXX_EN_DPLL_FRBYPASS		0x6
+#define OMAP3XXX_EN_DPLL_LOCKED			0x7
+
 int omap2_clk_init(void);
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index f2b74e9..1e839c5 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -236,19 +236,32 @@ static struct clk *sclk;
  * Omap24xx specific clock functions
  *-------------------------------------------------------------------------*/
 
-/* This actually returns the rate of core_ck, not dpll_ck. */
-static u32 omap2_get_dpll_rate_24xx(struct clk *tclk)
+/**
+ * omap2xxx_clk_get_core_rate - return the CORE_CLK rate
+ * @clk: pointer to the combined dpll_ck + core_ck (currently "dpll_ck")
+ *
+ * Returns the CORE_CLK rate.  CORE_CLK can have one of three rate
+ * sources on OMAP2xxx: the DPLL CLKOUT rate, DPLL CLKOUTX2, or 32KHz
+ * (the latter is unusual).  This currently should be called with
+ * struct clk *dpll_ck, which is a composite clock of dpll_ck and
+ * core_ck.
+ */
+static unsigned long omap2xxx_clk_get_core_rate(struct clk *clk)
 {
-	long long dpll_clk;
-	u8 amult;
+	long long core_clk;
+	u32 v;
 
-	dpll_clk = omap2_get_dpll_rate(tclk);
+	core_clk = omap2_get_dpll_rate(clk);
 
-	amult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	amult &= OMAP24XX_CORE_CLK_SRC_MASK;
-	dpll_clk *= amult;
+	v = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	v &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if (v == CORE_CLK_SRC_32K)
+		core_clk = 32768;
+	else
+		core_clk *= v;
 
-	return dpll_clk;
+	return core_clk;
 }
 
 static int omap2_enable_osc_ck(struct clk *clk)
@@ -371,7 +384,7 @@ static long omap2_dpllcore_round_rate(unsigned long target_rate)
 
 static unsigned long omap2_dpllcore_recalc(struct clk *clk)
 {
-	return omap2_get_dpll_rate_24xx(clk);
+	return omap2xxx_clk_get_core_rate(clk);
 }
 
 static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
@@ -381,7 +394,7 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 	struct prcm_config tmpset;
 	const struct dpll_data *dd;
 
-	cur_rate = omap2_get_dpll_rate_24xx(&dpll_ck);
+	cur_rate = omap2xxx_clk_get_core_rate(&dpll_ck);
 	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
@@ -516,7 +529,7 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	}
 
 	curr_prcm_set = prcm;
-	cur_rate = omap2_get_dpll_rate_24xx(&dpll_ck);
+	cur_rate = omap2xxx_clk_get_core_rate(&dpll_ck);
 
 	if (prcm->dpll_speed == cur_rate / 2) {
 		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
@@ -728,7 +741,7 @@ int __init omap2_clk_init(void)
 		}
 
 	/* Check the MPU rate set by bootloader */
-	clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
+	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 11da621..33c3e5b 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -663,6 +663,10 @@ static struct dpll_data dpll_dd = {
 	.mult_div1_reg		= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.mult_mask		= OMAP24XX_DPLL_MULT_MASK,
 	.div1_mask		= OMAP24XX_DPLL_DIV_MASK,
+	.clk_bypass		= &sys_ck,
+	.clk_ref		= &sys_ck,
+	.control_reg		= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_mask		= OMAP24XX_EN_DPLL_MASK,
 	.max_multiplier		= 1024,
 	.min_divider		= 1,
 	.max_divider		= 16,
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index fb0f53b..0a14dca 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -93,7 +93,6 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_343X),
 	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck,	CK_343X),
 	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck,	CK_343X),
-	CLK(NULL,	"virt_omap_54m_fck", &virt_omap_54m_fck, CK_343X),
 	CLK(NULL,	"omap_54m_fck",	&omap_54m_fck,	CK_343X),
 	CLK(NULL,	"omap_48m_fck",	&omap_48m_fck,	CK_343X),
 	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck,	CK_343X),
@@ -110,7 +109,6 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
 	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2),
 	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2),
-	CLK(NULL,	"omap_120m_fck", &omap_120m_fck, CK_3430ES2),
 	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_343X),
 	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_343X),
 	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_343X),
@@ -344,7 +342,7 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
 	unsigned long fint;
 	u16 f = 0;
 
-	fint = clk->parent->rate / (n + 1);
+	fint = clk->dpll_data->clk_ref->rate / (n + 1);
 
 	pr_debug("clock: fint is %lu\n", fint);
 
@@ -411,7 +409,7 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
 }
 
 /*
- * omap3_noncore_dpll_bypass - instruct a DPLL to bypass and wait for readiness
+ * _omap3_noncore_dpll_bypass - instruct a DPLL to bypass and wait for readiness
  * @clk: pointer to a DPLL struct clk
  *
  * Instructs a non-CORE DPLL to enter low-power bypass mode.  In
@@ -501,14 +499,25 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 static int omap3_noncore_dpll_enable(struct clk *clk)
 {
 	int r;
+	struct dpll_data *dd;
 
 	if (clk == &dpll3_ck)
 		return -EINVAL;
 
-	if (clk->parent->rate == omap2_get_dpll_rate(clk))
+	dd = clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	if (clk->rate == dd->clk_bypass->rate) {
+		WARN_ON(clk->parent != dd->clk_bypass);
 		r = _omap3_noncore_dpll_bypass(clk);
-	else
+	} else {
+		WARN_ON(clk->parent != dd->clk_ref);
 		r = _omap3_noncore_dpll_lock(clk);
+	}
+	/* FIXME: this is dubious - if clk->rate has changed, what about propagating? */
+	if (!r)
+		clk->rate = omap2_get_dpll_rate(clk);
 
 	return r;
 }
@@ -583,13 +592,18 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
  * @clk: struct clk * of DPLL to set
  * @rate: rounded target rate
  *
- * Program the DPLL with the rounded target rate.  Returns -EINVAL upon
- * error, or 0 upon success.
+ * Set the DPLL CLKOUT to the target rate.  If the DPLL can enter
+ * low-power bypass, and the target rate is the bypass source clock
+ * rate, then configure the DPLL for bypass.  Otherwise, round the
+ * target rate if it hasn't been done already, then program and lock
+ * the DPLL.  Returns -EINVAL upon error, or 0 upon success.
  */
 static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 {
+	struct clk *new_parent = NULL;
 	u16 freqsel;
 	struct dpll_data *dd;
+	int ret;
 
 	if (!clk || !rate)
 		return -EINVAL;
@@ -601,18 +615,56 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	if (rate == omap2_get_dpll_rate(clk))
 		return 0;
 
-	if (dd->last_rounded_rate != rate)
-		omap2_dpll_round_rate(clk, rate);
+	/*
+	 * Ensure both the bypass and ref clocks are enabled prior to
+	 * doing anything; we need the bypass clock running to reprogram
+	 * the DPLL.
+	 */
+	omap2_clk_enable(dd->clk_bypass);
+	omap2_clk_enable(dd->clk_ref);
+
+	if (dd->clk_bypass->rate == rate &&
+	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
+		pr_debug("clock: %s: set rate: entering bypass.\n", clk->name);
 
-	if (dd->last_rounded_rate == 0)
-		return -EINVAL;
+		ret = _omap3_noncore_dpll_bypass(clk);
+		if (!ret)
+			new_parent = dd->clk_bypass;
+	} else {
+		if (dd->last_rounded_rate != rate)
+			omap2_dpll_round_rate(clk, rate);
+
+		if (dd->last_rounded_rate == 0)
+			return -EINVAL;
+
+		freqsel = _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
+		if (!freqsel)
+			WARN_ON(1);
 
-	freqsel = _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
-	if (!freqsel)
-		WARN_ON(1);
+		pr_debug("clock: %s: set rate: locking rate to %lu.\n",
+			 clk->name, rate);
 
-	omap3_noncore_dpll_program(clk, dd->last_rounded_m, dd->last_rounded_n,
-				   freqsel);
+		ret = omap3_noncore_dpll_program(clk, dd->last_rounded_m,
+						 dd->last_rounded_n, freqsel);
+		if (!ret)
+			new_parent = dd->clk_ref;
+	}
+	if (!ret) {
+		/*
+		 * Switch the parent clock in the heirarchy, and make sure
+		 * that the new parent's usecount is correct.  Note: we
+		 * enable the new parent before disabling the old to avoid
+		 * any unnecessary hardware disable->enable transitions.
+		 */
+		if (clk->usecount) {
+			omap2_clk_enable(new_parent);
+			omap2_clk_disable(clk->parent);
+		}
+		clk_reparent(clk, new_parent);
+		clk->rate = rate;
+	}
+	omap2_clk_disable(dd->clk_ref);
+	omap2_clk_disable(dd->clk_bypass);
 
 	return 0;
 }
@@ -804,11 +856,11 @@ static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 
 	dd = pclk->dpll_data;
 
-	WARN_ON(!dd->control_reg || !dd->enable_mask);
+	WARN_ON(!dd->enable_mask);
 
 	v = __raw_readl(dd->control_reg) & dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
-	if (v != DPLL_LOCKED)
+	if (v != OMAP3XXX_EN_DPLL_LOCKED)
 		rate = clk->parent->rate;
 	else
 		rate = clk->parent->rate * 2;
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 764c7cd..70ec10d 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -48,6 +48,10 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
  * DPLL5 supplies other peripheral clocks (USBHOST, USIM).
  */
 
+/* Forward declarations for DPLL bypass clocks */
+static struct clk dpll1_fck;
+static struct clk dpll2_fck;
+
 /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
 #define DPLL_LOW_POWER_STOP		0x1
 #define DPLL_LOW_POWER_BYPASS		0x5
@@ -217,16 +221,6 @@ static struct clk sys_clkout1 = {
 
 /* CM CLOCKS */
 
-static const struct clksel_rate dpll_bypass_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate dpll_locked_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
 static const struct clksel_rate div16_dpll_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
 	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
@@ -254,6 +248,8 @@ static struct dpll_data dpll1_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.mult_mask	= OMAP3430_MPU_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_MPU_DPLL_DIV_MASK,
+	.clk_bypass	= &dpll1_fck,
+	.clk_ref	= &sys_ck,
 	.freqsel_mask	= OMAP3430_MPU_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKEN_PLL),
 	.enable_mask	= OMAP3430_EN_MPU_DPLL_MASK,
@@ -324,6 +320,8 @@ static struct dpll_data dpll2_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.mult_mask	= OMAP3430_IVA2_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_IVA2_DPLL_DIV_MASK,
+	.clk_bypass	= &dpll2_fck,
+	.clk_ref	= &sys_ck,
 	.freqsel_mask	= OMAP3430_IVA2_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN_PLL),
 	.enable_mask	= OMAP3430_EN_IVA2_DPLL_MASK,
@@ -384,6 +382,8 @@ static struct dpll_data dpll3_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.mult_mask	= OMAP3430_CORE_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_CORE_DPLL_DIV_MASK,
+	.clk_bypass	= &sys_ck,
+	.clk_ref	= &sys_ck,
 	.freqsel_mask	= OMAP3430_CORE_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_mask	= OMAP3430_EN_CORE_DPLL_MASK,
@@ -477,37 +477,19 @@ static struct clk dpll3_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static const struct clksel core_ck_clksel[] = {
-	{ .parent = &sys_ck,	  .rates = dpll_bypass_rates },
-	{ .parent = &dpll3_m2_ck, .rates = dpll_locked_rates },
-	{ .parent = NULL }
-};
-
 static struct clk core_ck = {
 	.name		= "core_ck",
 	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
-	.clksel		= core_ck_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel dpll3_m2x2_ck_clksel[] = {
-	{ .parent = &sys_ck,	  .rates = dpll_bypass_rates },
-	{ .parent = &dpll3_x2_ck, .rates = dpll_locked_rates },
-	{ .parent = NULL }
+	.parent		= &dpll3_m2_ck,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk dpll3_m2x2_ck = {
 	.name		= "dpll3_m2x2_ck",
 	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
-	.clksel		= dpll3_m2x2_ck_clksel,
+	.parent		= &dpll3_x2_ck,
 	.clkdm_name	= "dpll3_clkdm",
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
@@ -541,22 +523,12 @@ static struct clk dpll3_m3x2_ck = {
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
-static const struct clksel emu_core_alwon_ck_clksel[] = {
-	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
-	{ .parent = &dpll3_m3x2_ck, .rates = dpll_locked_rates },
-	{ .parent = NULL }
-};
-
 static struct clk emu_core_alwon_ck = {
 	.name		= "emu_core_alwon_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_m3x2_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
-	.clksel		= emu_core_alwon_ck_clksel,
 	.clkdm_name	= "dpll3_clkdm",
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 /* DPLL4 */
@@ -566,6 +538,8 @@ static struct dpll_data dpll4_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
 	.mult_mask	= OMAP3430_PERIPH_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_PERIPH_DPLL_DIV_MASK,
+	.clk_bypass	= &sys_ck,
+	.clk_ref	= &sys_ck,
 	.freqsel_mask	= OMAP3430_PERIPH_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_mask	= OMAP3430_EN_PERIPH_DPLL_MASK,
@@ -637,12 +611,6 @@ static struct clk dpll4_m2x2_ck = {
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
-static const struct clksel omap_96m_alwon_fck_clksel[] = {
-	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
-	{ .parent = &dpll4_m2x2_ck, .rates = dpll_locked_rates },
-	{ .parent = NULL }
-};
-
 /*
  * DPLL4 generates DPLL4_M2X2_CLK which is then routed into the PRM as
  * PRM_96M_ALWON_(F)CLK.  Two clocks then emerge from the PRM:
@@ -653,11 +621,7 @@ static struct clk omap_96m_alwon_fck = {
 	.name		= "omap_96m_alwon_fck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_m2x2_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
-	.clksel		= omap_96m_alwon_fck_clksel,
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk cm_96m_fck = {
@@ -720,23 +684,6 @@ static struct clk dpll4_m3x2_ck = {
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
-static const struct clksel virt_omap_54m_fck_clksel[] = {
-	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
-	{ .parent = &dpll4_m3x2_ck, .rates = dpll_locked_rates },
-	{ .parent = NULL }
-};
-
-static struct clk virt_omap_54m_fck = {
-	.name		= "virt_omap_54m_fck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_m3x2_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
-	.clksel		= virt_omap_54m_fck_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
 static const struct clksel_rate omap_54m_d4m3x2_rates[] = {
 	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
 	{ .div = 0 }
@@ -748,7 +695,7 @@ static const struct clksel_rate omap_54m_alt_rates[] = {
 };
 
 static const struct clksel omap_54m_clksel[] = {
-	{ .parent = &virt_omap_54m_fck, .rates = omap_54m_d4m3x2_rates },
+	{ .parent = &dpll4_m3x2_ck, .rates = omap_54m_d4m3x2_rates },
 	{ .parent = &sys_altclk,    .rates = omap_54m_alt_rates },
 	{ .parent = NULL }
 };
@@ -891,6 +838,8 @@ static struct dpll_data dpll5_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL4),
 	.mult_mask	= OMAP3430ES2_PERIPH2_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430ES2_PERIPH2_DPLL_DIV_MASK,
+	.clk_bypass	= &sys_ck,
+	.clk_ref	= &sys_ck,
 	.freqsel_mask	= OMAP3430ES2_PERIPH2_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKEN2),
 	.enable_mask	= OMAP3430ES2_EN_PERIPH2_DPLL_MASK,
@@ -936,23 +885,6 @@ static struct clk dpll5_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static const struct clksel omap_120m_fck_clksel[] = {
-	{ .parent = &sys_ck,	  .rates = dpll_bypass_rates },
-	{ .parent = &dpll5_m2_ck, .rates = dpll_locked_rates },
-	{ .parent = NULL }
-};
-
-static struct clk omap_120m_fck = {
-	.name		= "omap_120m_fck",
-	.ops		= &clkops_null,
-	.parent		= &dpll5_m2_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
-	.clksel_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
-	.clksel		= omap_120m_fck_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
 /* CM EXTERNAL CLOCK OUTPUTS */
 
 static const struct clksel_rate clkout2_src_core_rates[] = {
@@ -1058,28 +990,12 @@ static struct clk dpll1_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-/*
- * MPU clksel:
- * If DPLL1 is locked, mpu_ck derives from DPLL1; otherwise, mpu_ck
- * derives from the high-frequency bypass clock originating from DPLL3,
- * called 'dpll1_fck'
- */
-static const struct clksel mpu_clksel[] = {
-	{ .parent = &dpll1_fck,	    .rates = dpll_bypass_rates },
-	{ .parent = &dpll1_x2m2_ck, .rates = dpll_locked_rates },
-	{ .parent = NULL }
-};
-
 static struct clk mpu_ck = {
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll1_x2m2_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
-	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
-	.clksel		= mpu_clksel,
 	.clkdm_name	= "mpu_clkdm",
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 /* arm_fck is divided by two when DPLL1 locked; otherwise, passthrough mpu_ck */
@@ -1129,19 +1045,6 @@ static struct clk dpll2_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-/*
- * IVA2 clksel:
- * If DPLL2 is locked, iva2_ck derives from DPLL2; otherwise, iva2_ck
- * derives from the high-frequency bypass clock originating from DPLL3,
- * called 'dpll2_fck'
- */
-
-static const struct clksel iva2_clksel[] = {
-	{ .parent = &dpll2_fck,	  .rates = dpll_bypass_rates },
-	{ .parent = &dpll2_m2_ck, .rates = dpll_locked_rates },
-	{ .parent = NULL }
-};
-
 static struct clk iva2_ck = {
 	.name		= "iva2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1149,12 +1052,8 @@ static struct clk iva2_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
-					  OMAP3430_CM_IDLEST_PLL),
-	.clksel_mask	= OMAP3430_ST_IVA2_CLK_MASK,
-	.clksel		= iva2_clksel,
 	.clkdm_name	= "iva2_clkdm",
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 /* Common interface clocks */
@@ -1384,7 +1283,7 @@ static struct clk ts_fck = {
 static struct clk usbtll_fck = {
 	.name		= "usbtll_fck",
 	.ops		= &clkops_omap2_dflt,
-	.parent		= &omap_120m_fck,
+	.parent		= &dpll5_m2_ck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -2094,24 +1993,14 @@ static struct clk des1_ick = {
 };
 
 /* DSS */
-static const struct clksel dss1_alwon_fck_clksel[] = {
-	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
-	{ .parent = &dpll4_m4x2_ck, .rates = dpll_locked_rates },
-	{ .parent = NULL }
-};
-
 static struct clk dss1_alwon_fck = {
 	.name		= "dss1_alwon_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &dpll4_m4x2_ck,
-	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_DSS1_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
-	.clksel		= dss1_alwon_fck_clksel,
 	.clkdm_name	= "dss_clkdm",
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk dss_tv_fck = {
@@ -2161,24 +2050,14 @@ static struct clk dss_ick = {
 
 /* CAM */
 
-static const struct clksel cam_mclk_clksel[] = {
-	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
-	{ .parent = &dpll4_m5x2_ck, .rates = dpll_locked_rates },
-	{ .parent = NULL }
-};
-
 static struct clk cam_mclk = {
 	.name		= "cam_mclk",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m5x2_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
-	.clksel		= cam_mclk_clksel,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
 	.clkdm_name	= "cam_clkdm",
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk cam_ick = {
@@ -2209,7 +2088,7 @@ static struct clk csi2_96m_fck = {
 static struct clk usbhost_120m_fck = {
 	.name		= "usbhost_120m_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &omap_120m_fck,
+	.parent		= &dpll5_m2_ck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST2_SHIFT,
@@ -2260,7 +2139,7 @@ static const struct clksel_rate usim_120m_rates[] = {
 
 static const struct clksel usim_clksel[] = {
 	{ .parent = &omap_96m_fck,	.rates = usim_96m_rates },
-	{ .parent = &omap_120m_fck,	.rates = usim_120m_rates },
+	{ .parent = &dpll5_m2_ck,	.rates = usim_120m_rates },
 	{ .parent = &sys_ck,		.rates = div2_rates },
 	{ .parent = NULL },
 };
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 3a47aba..0afdad5 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -29,7 +29,7 @@
 #include <mach/sram.h>
 
 #include "prm.h"
-
+#include "clock.h"
 #include <mach/sdrc.h>
 #include "sdrc.h"
 
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 7b6f6bc..073a2c5 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -39,6 +39,10 @@ struct dpll_data {
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
 	u32			div1_mask;
+	struct clk		*clk_bypass;
+	struct clk		*clk_ref;
+	void __iomem		*control_reg;
+	u32			enable_mask;
 	unsigned int		rate_tolerance;
 	unsigned long		last_rounded_rate;
 	u16			last_rounded_m;
@@ -49,10 +53,8 @@ struct dpll_data {
 	u16			max_multiplier;
 #  if defined(CONFIG_ARCH_OMAP3)
 	u8			modes;
-	void __iomem		*control_reg;
 	void __iomem		*autoidle_reg;
 	void __iomem		*idlest_reg;
-	u32			enable_mask;
 	u32			autoidle_mask;
 	u32			freqsel_mask;
 	u32			idlest_mask;
@@ -154,9 +156,4 @@ extern const struct clkops clkops_null;
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 
 
-/* CM_CLKSEL2_PLL.CORE_CLK_SRC options (24XX) */
-#define CORE_CLK_SRC_32K		0
-#define CORE_CLK_SRC_DPLL		1
-#define CORE_CLK_SRC_DPLL_X2		2
-
 #endif
-- 
1.6.1.2

