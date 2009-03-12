From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 59/86] [ARM] OMAP3 clock: avoid invalid FREQSEL values during DPLL rate rounding
Date: Thu, 12 Mar 2009 11:28:09 -0700
Message-ID: <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbZCLScx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:32:53 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:32:52 -0700 (PDT)
In-Reply-To: <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

The DPLL FREQSEL jitter correction bits are set based on a table in
the 34xx TRM, Table 4-38, according to the DPLL's internal clock
frequency "Fint."  Several Fint frequency ranges are missing from this
table.  Previously, we allowed these Fint frequency ranges to be
selected in the rate rounding code, but did not change the FREQSEL bits.
Correspondence with the OMAP hardware team indicates that Fint values
not in the table should not be used.  So, prevent them from being
selected during DPLL rate rounding.  This removes warnings and also
can prevent the chip from locking up.

The first pass through the rate rounding code will update the DPLL max
and min dividers appropriately, so later rate rounding passes will run
faster than the first.

Peter de Schrijver <peter.de-schrijver@nokia.com> put up with several
test cycles of this patch - thanks Peter.

linux-omap source commit is f9c1b82f55b60fc39eaa6e7aa1fbe380c0ffe2e9.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Peter de Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c             |   67 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock24xx.h         |    1 +
 arch/arm/mach-omap2/clock34xx.h         |    5 ++
 arch/arm/plat-omap/include/mach/clock.h |    1 +
 4 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 76e20bc..752e347 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -58,12 +58,68 @@
 #define DPLL_ROUNDING_VAL		((DPLL_SCALE_BASE / 2) * \
 					 (DPLL_SCALE_FACTOR / DPLL_SCALE_BASE))
 
+/* DPLL valid Fint frequency band limits - from 34xx TRM Section 4.7.6.2 */
+#define DPLL_FINT_BAND1_MIN		750000
+#define DPLL_FINT_BAND1_MAX		2100000
+#define DPLL_FINT_BAND2_MIN		7500000
+#define DPLL_FINT_BAND2_MAX		21000000
+
+/* _dpll_test_fint() return codes */
+#define DPLL_FINT_UNDERFLOW		-1
+#define DPLL_FINT_INVALID		-2
+
 u8 cpu_mask;
 
 /*-------------------------------------------------------------------------
  * OMAP2/3 specific clock functions
  *-------------------------------------------------------------------------*/
 
+/*
+ * _dpll_test_fint - test whether an Fint value is valid for the DPLL
+ * @clk: DPLL struct clk to test
+ * @n: divider value (N) to test
+ *
+ * Tests whether a particular divider @n will result in a valid DPLL
+ * internal clock frequency Fint. See the 34xx TRM 4.7.6.2 "DPLL Jitter
+ * Correction".  Returns 0 if OK, -1 if the enclosing loop can terminate
+ * (assuming that it is counting N upwards), or -2 if the enclosing loop
+ * should skip to the next iteration (again assuming N is increasing).
+ */
+static int _dpll_test_fint(struct clk *clk, u8 n)
+{
+	struct dpll_data *dd;
+	long fint;
+	int ret = 0;
+
+	dd = clk->dpll_data;
+
+	/* DPLL divider must result in a valid jitter correction val */
+	fint = clk->parent->rate / (n + 1);
+	if (fint < DPLL_FINT_BAND1_MIN) {
+
+		pr_debug("rejecting n=%d due to Fint failure, "
+			 "lowering max_divider\n", n);
+		dd->max_divider = n;
+		ret = DPLL_FINT_UNDERFLOW;
+
+	} else if (fint > DPLL_FINT_BAND1_MAX &&
+		   fint < DPLL_FINT_BAND2_MIN) {
+
+		pr_debug("rejecting n=%d due to Fint failure\n", n);
+		ret = DPLL_FINT_INVALID;
+
+	} else if (fint > DPLL_FINT_BAND2_MAX) {
+
+		pr_debug("rejecting n=%d due to Fint failure, "
+			 "boosting min_divider\n", n);
+		dd->min_divider = n;
+		ret = DPLL_FINT_INVALID;
+
+	}
+
+	return ret;
+}
+
 /**
  * omap2_init_clk_clkdm - look up a clockdomain name, store pointer in clk
  * @clk: OMAP clock struct ptr to use
@@ -892,7 +948,14 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 
 	dd->last_rounded_rate = 0;
 
-	for (n = DPLL_MIN_DIVIDER; n <= dd->max_divider; n++) {
+	for (n = dd->min_divider; n <= dd->max_divider; n++) {
+
+		/* Is the (input clk, divider) pair valid for the DPLL? */
+		r = _dpll_test_fint(clk, n);
+		if (r == DPLL_FINT_UNDERFLOW)
+			break;
+		else if (r == DPLL_FINT_INVALID)
+			continue;
 
 		/* Compute the scaled DPLL multiplier, based on the divider */
 		m = scaled_rt_rp * n;
@@ -926,7 +989,7 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 			pr_debug("clock: found new least error %d\n", min_e);
 
 			/* We found good settings -- bail out now */
-			if (min_e <= clk->dpll_data->rate_tolerance)
+			if (min_e <= dd->rate_tolerance)
 				break;
 		}
 	}
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 32dd857..7731ab6 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -666,6 +666,7 @@ static struct dpll_data dpll_dd = {
 	.mult_mask		= OMAP24XX_DPLL_MULT_MASK,
 	.div1_mask		= OMAP24XX_DPLL_DIV_MASK,
 	.max_multiplier		= 1024,
+	.min_divider		= 1,
 	.max_divider		= 16,
 	.rate_tolerance		= DEFAULT_DPLL_RATE_TOLERANCE
 };
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 7ee1312..aadd296 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -268,6 +268,7 @@ static struct dpll_data dpll1_dd = {
 	.idlest_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.idlest_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
@@ -341,6 +342,7 @@ static struct dpll_data dpll2_dd = {
 	.idlest_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_IDLEST_PLL),
 	.idlest_mask	= OMAP3430_ST_IVA2_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
@@ -400,6 +402,7 @@ static struct dpll_data dpll3_dd = {
 	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.idlest_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
@@ -591,6 +594,7 @@ static struct dpll_data dpll4_dd = {
 	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
@@ -930,6 +934,7 @@ static struct dpll_data dpll5_dd = {
 	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
 	.idlest_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 611df52..cd69111 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -43,6 +43,7 @@ struct dpll_data {
 	unsigned long		last_rounded_rate;
 	u16			last_rounded_m;
 	u8			last_rounded_n;
+	u8			min_divider;
 	u8			max_divider;
 	u32			max_tolerance;
 	u16			max_multiplier;
-- 
1.6.1.2

