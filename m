From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] OMAP3 clock: avoid invalid FREQSEL values during DPLL
	rate rounding
Date: Wed, 12 Nov 2008 11:52:31 -0700
Message-ID: <20081112185101.31228.30241.stgit@localhost.localdomain>
References: <20081112183754.31228.73844.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56926 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYKLSxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 13:53:17 -0500
In-Reply-To: <20081112183754.31228.73844.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Peter de Schrijver <peter.de-schrijver@nokia.com>

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

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Peter de Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clock.c             |   66 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock24xx.h         |    1 
 arch/arm/mach-omap2/clock34xx.h         |    5 ++
 arch/arm/plat-omap/include/mach/clock.h |    1 
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index bd3be45..42af286 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -61,6 +61,16 @@
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
 /* Some OMAP2xxx CM_CLKSEL_PLL.ST_CORE_CLK bits - for omap2_get_dpll_rate() */
 #define ST_CORE_CLK_REF			0x1
 #define ST_CORE_CLK_32K			0x3
@@ -114,6 +124,51 @@ static void _omap2_clk_write_reg(u32 v, u16 reg_offset, struct clk *clk)
 		cm_write_mod_reg(v, clk->prcm_mod, reg_offset);
 }
 
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
 
 /**
  * omap2_init_clk_clkdm - look up a clockdomain name, store pointer in clk
@@ -943,7 +998,14 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 
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
@@ -977,7 +1039,7 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 			pr_debug("clock: found new least error %d\n", min_e);
 
 			/* We found good settings -- bail out now */
-			if (min_e <= clk->dpll_data->rate_tolerance)
+			if (min_e <= dd->rate_tolerance)
 				break;
 		}
 	}
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 8bf70cf..1fc1249 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -676,6 +676,7 @@ static struct dpll_data dpll_dd = {
 	.idlest_reg		= CM_IDLEST,
 	.idlest_mask		= OMAP24XX_ST_CORE_CLK_MASK,
 	.max_multiplier		= 1024,
+	.min_divider		= 1,
 	.max_divider		= 16,
 	.rate_tolerance		= DEFAULT_DPLL_RATE_TOLERANCE
 };
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 08789c8..0b95fcb 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -292,6 +292,7 @@ static struct dpll_data dpll1_dd = {
 	.idlest_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.bypass_clk	= &dpll1_fck,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
@@ -367,6 +368,7 @@ static struct dpll_data dpll2_dd = {
 	.idlest_mask	= OMAP3430_ST_IVA2_CLK_MASK,
 	.bypass_clk	= &dpll2_fck,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
@@ -429,6 +431,7 @@ static struct dpll_data dpll3_dd = {
 	.idlest_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.bypass_clk	= &sys_ck,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
@@ -594,6 +597,7 @@ static struct dpll_data dpll4_dd = {
 	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.bypass_clk	= &sys_ck,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
@@ -920,6 +924,7 @@ static struct dpll_data dpll5_dd = {
 	.idlest_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
 	.bypass_clk	= &sys_ck,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 9088925..4eef580 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -39,6 +39,7 @@ struct dpll_data {
 	unsigned long		last_rounded_rate;
 	unsigned int		rate_tolerance;
 	u16			max_multiplier;
+	u8			min_divider;
 	u8			max_divider;
 	u32			max_tolerance;
 	u16			idlest_reg;


