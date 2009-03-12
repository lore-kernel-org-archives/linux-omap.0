From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 37/86] [ARM] OMAP2/3: Add non-CORE DPLL rate set code and M, N programming
Date: Thu, 12 Mar 2009 11:27:47 -0700
Message-ID: <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415AbZCLSba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:30 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:29 -0700 (PDT)
In-Reply-To: <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Add non-CORE DPLL rate set code and M,N programming for OMAP3.
Connect it to OMAP34xx DPLLs 1, 2, 4, 5 via the clock framework.

You may see some warnings on rate sets from the freqsel code.  The
table that TI presented in the 3430 TRM Rev F does not cover Fint <
750000, which definitely occurs in practice.  However, the lack of this
freqsel case does not appear to impair the DPLL rate change.

linux-omap source commit is 689fe67c6d1ad8f52f7f7b139a3274b79bf3e784.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock34xx.c         |  137 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock34xx.h         |   11 +++
 arch/arm/plat-omap/include/mach/clock.h |    1 +
 3 files changed, 148 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 245a7b9..943ac63 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -340,6 +340,42 @@ static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
 	return ret;
 }
 
+/* From 3430 TRM ES2 4.7.6.2 */
+static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
+{
+	unsigned long fint;
+	u16 f = 0;
+
+	fint = clk->parent->rate / (n + 1);
+
+	pr_debug("clock: fint is %lu\n", fint);
+
+	if (fint >= 750000 && fint <= 1000000)
+		f = 0x3;
+	else if (fint > 1000000 && fint <= 1250000)
+		f = 0x4;
+	else if (fint > 1250000 && fint <= 1500000)
+		f = 0x5;
+	else if (fint > 1500000 && fint <= 1750000)
+		f = 0x6;
+	else if (fint > 1750000 && fint <= 2100000)
+		f = 0x7;
+	else if (fint > 7500000 && fint <= 10000000)
+		f = 0xB;
+	else if (fint > 10000000 && fint <= 12500000)
+		f = 0xC;
+	else if (fint > 12500000 && fint <= 15000000)
+		f = 0xD;
+	else if (fint > 15000000 && fint <= 17500000)
+		f = 0xE;
+	else if (fint > 17500000 && fint <= 21000000)
+		f = 0xF;
+	else
+		pr_debug("clock: unknown freqsel setting for %d\n", n);
+
+	return f;
+}
+
 /* Non-CORE DPLL (e.g., DPLLs that do not control SDRC) clock functions */
 
 /*
@@ -476,7 +512,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 	if (clk == &dpll3_ck)
 		return -EINVAL;
 
-	if (clk->parent->rate == clk_get_rate(clk))
+	if (clk->parent->rate == omap2_get_dpll_rate(clk))
 		r = _omap3_noncore_dpll_bypass(clk);
 	else
 		r = _omap3_noncore_dpll_lock(clk);
@@ -506,11 +542,110 @@ static void omap3_noncore_dpll_disable(struct clk *clk)
 	_omap3_noncore_dpll_stop(clk);
 }
 
+
+/* Non-CORE DPLL rate set code */
+
+/*
+ * omap3_noncore_dpll_program - set non-core DPLL M,N values directly
+ * @clk: struct clk * of DPLL to set
+ * @m: DPLL multiplier to set
+ * @n: DPLL divider to set
+ * @freqsel: FREQSEL value to set
+ *
+ * Program the DPLL with the supplied M, N values, and wait for the DPLL to
+ * lock..  Returns -EINVAL upon error, or 0 upon success.
+ */
+static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
+{
+	struct dpll_data *dd = clk->dpll_data;
+	u32 v;
+
+	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
+	_omap3_noncore_dpll_bypass(clk);
+
+	v = __raw_readl(dd->mult_div1_reg);
+	v &= ~(dd->mult_mask | dd->div1_mask);
+
+	/* Set mult (M), div1 (N), freqsel */
+	v |= m << __ffs(dd->mult_mask);
+	v |= n << __ffs(dd->div1_mask);
+	v |= freqsel << __ffs(dd->freqsel_mask);
+
+	__raw_writel(v, dd->mult_div1_reg);
+
+	/* We let the clock framework set the other output dividers later */
+
+	/* REVISIT: Set ramp-up delay? */
+
+	_omap3_noncore_dpll_lock(clk);
+
+	return 0;
+}
+
+/**
+ * omap3_noncore_dpll_set_rate - set non-core DPLL rate
+ * @clk: struct clk * of DPLL to set
+ * @rate: rounded target rate
+ *
+ * Program the DPLL with the rounded target rate.  Returns -EINVAL upon
+ * error, or 0 upon success.
+ */
+static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
+{
+	u16 freqsel;
+	struct dpll_data *dd;
+
+	if (!clk || !rate)
+		return -EINVAL;
+
+	dd = clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	if (rate == omap2_get_dpll_rate(clk))
+		return 0;
+
+	if (dd->last_rounded_rate != rate)
+		omap2_dpll_round_rate(clk, rate);
+
+	if (dd->last_rounded_rate == 0)
+		return -EINVAL;
+
+	freqsel = _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
+	if (!freqsel)
+		WARN_ON(1);
+
+	omap3_noncore_dpll_program(clk, dd->last_rounded_m, dd->last_rounded_n,
+				   freqsel);
+
+	omap3_dpll_recalc(clk);
+
+	return 0;
+}
+
+static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
+{
+	/*
+	 * According to the 12-5 CDP code from TI, "Limitation 2.5"
+	 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
+	 * on DPLL4.
+	 */
+	if (omap_rev() == OMAP3430_REV_ES1_0) {
+		printk(KERN_ERR "clock: DPLL4 cannot change rate due to "
+		       "silicon 'Limitation 2.5' on 3430ES1.\n");
+		return -EINVAL;
+	}
+	return omap3_noncore_dpll_set_rate(clk, rate);
+}
+
 static const struct clkops clkops_noncore_dpll_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
 };
 
+/* DPLL autoidle read/set code */
+
+
 /**
  * omap3_dpll_autoidle_read - read a DPLL's autoidle bits
  * @clk: struct clk * of the DPLL to read
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 6bd8c6d..f811a09 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -32,6 +32,8 @@ static void omap3_clkoutx2_recalc(struct clk *clk);
 static void omap3_dpll_allow_idle(struct clk *clk);
 static void omap3_dpll_deny_idle(struct clk *clk);
 static u32 omap3_dpll_autoidle_read(struct clk *clk);
+static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
+static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
 
 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT		2048
@@ -254,6 +256,7 @@ static struct dpll_data dpll1_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.mult_mask	= OMAP3430_MPU_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_MPU_DPLL_DIV_MASK,
+	.freqsel_mask	= OMAP3430_MPU_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKEN_PLL),
 	.enable_mask	= OMAP3430_EN_MPU_DPLL_MASK,
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
@@ -276,6 +279,7 @@ static struct clk dpll1_ck = {
 	.dpll_data	= &dpll1_dd,
 	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -321,6 +325,7 @@ static struct dpll_data dpll2_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.mult_mask	= OMAP3430_IVA2_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_IVA2_DPLL_DIV_MASK,
+	.freqsel_mask	= OMAP3430_IVA2_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN_PLL),
 	.enable_mask	= OMAP3430_EN_IVA2_DPLL_MASK,
 	.modes		= (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED) |
@@ -344,6 +349,7 @@ static struct clk dpll2_ck = {
 	.dpll_data	= &dpll2_dd,
 	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -378,6 +384,7 @@ static struct dpll_data dpll3_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.mult_mask	= OMAP3430_CORE_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_CORE_DPLL_DIV_MASK,
+	.freqsel_mask	= OMAP3430_CORE_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_mask	= OMAP3430_EN_CORE_DPLL_MASK,
 	.auto_recal_bit	= OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT,
@@ -558,6 +565,7 @@ static struct dpll_data dpll4_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
 	.mult_mask	= OMAP3430_PERIPH_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_PERIPH_DPLL_DIV_MASK,
+	.freqsel_mask	= OMAP3430_PERIPH_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_mask	= OMAP3430_EN_PERIPH_DPLL_MASK,
 	.modes		= (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
@@ -580,6 +588,7 @@ static struct clk dpll4_ck = {
 	.dpll_data	= &dpll4_dd,
 	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_dpll4_set_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -864,6 +873,7 @@ static struct dpll_data dpll5_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL4),
 	.mult_mask	= OMAP3430ES2_PERIPH2_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430ES2_PERIPH2_DPLL_DIV_MASK,
+	.freqsel_mask	= OMAP3430ES2_PERIPH2_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKEN2),
 	.enable_mask	= OMAP3430ES2_EN_PERIPH2_DPLL_MASK,
 	.modes		= (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
@@ -886,6 +896,7 @@ static struct clk dpll5_ck = {
 	.dpll_data	= &dpll5_dd,
 	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
 
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 3895ba7..f147aec 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -53,6 +53,7 @@ struct dpll_data {
 	void __iomem		*idlest_reg;
 	u32			enable_mask;
 	u32			autoidle_mask;
+	u32			freqsel_mask;
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-- 
1.6.1.2

