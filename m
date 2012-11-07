From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/3] ARM: OMAP4: Enhance support for DPLLs with 4X multiplier
Date: Wed, 7 Nov 2012 12:43:01 -0600
Message-ID: <1352313782-21602-3-git-send-email-jon-hunter@ti.com>
References: <1352313782-21602-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56186 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388Ab2KGSnO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 13:43:14 -0500
In-Reply-To: <1352313782-21602-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

On OMAP4 devices, the ABE DPLL has an internal 4X multiplier that can
be enabled or disabled in addition to the standard configurable
multiplier (M) for OMAP DPLLs. When configuring the ABE DPLL the 4X
multiplier is accounted for by checking to see whether it is enabled or
not. However, when calculating a new rate we only check to see if the
rate can be achieved with the current setting for the 4X multiplier.
Enhance the round_rate() function for such DPLLs to see if the rate
can be achieved with the 4X multiplier if it cannot be achieved without
the 4X multiplier.

This change is necessary, because when using the 32kHz clock as the
source clock for the ABE DPLL, the default DPLL frequency for the ABE
DPLL cannot be achieved without enabling the 4X multiplier.

When using the 32kHz clock as the source clock for the ABE DPLL and
attempting to lock the DPLL to 98.304MHz (default frequency), it was
found that the DPLL would fail to lock if the low-power mode for the DPLL
was not enabled. From reviewing boot-loader settings that configure the
ABE DPLL it was found that the low-power mode is enabled when using the
32kHz clock source, however, the documentation for OMAP does not state
that this is a requirement. Therefore, introduce a new function for
OMAP4 devices to see if low-power mode can be enabled when calculating a
new rate to ensure the DPLL will lock.

New variables for the last calculated 4X multiplier and low-power
setting have been added to the dpll data structure as well as variables
defining the bit mask for enabling these features via the DPLL's
control_reg. It is possible that we could eliminate these bit masks from
the dpll data structure as these bit masks are not unique to OMAP4, if
it is preferred.

The function omap3_noncore_program_dpll() has been updated to avoid
passing the calculated values for the multiplier (M) and divider (N) as
these are stored in the clk structure.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c    |    2 +
 arch/arm/mach-omap2/dpll3xxx.c          |   46 +++++++++++++++-------
 arch/arm/mach-omap2/dpll44xx.c          |   63 ++++++++++++++++++++++++++-----
 arch/arm/plat-omap/include/plat/clock.h |   10 +++++
 4 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 8f197eb..8a9cbad 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -226,6 +226,8 @@ static struct dpll_data dpll_abe_dd = {
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
 	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
 	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
+	.m4xen_mask	= OMAP4430_DPLL_REGM4XEN_MASK,
+	.lpmode_mask	= OMAP4430_DPLL_LPMODE_EN_MASK,
 	.max_multiplier	= 2047,
 	.max_divider	= 128,
 	.min_divider	= 1,
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 814e180..8a0259e 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -17,7 +17,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/list.h>
@@ -292,15 +291,13 @@ static void _lookup_sddiv(struct clk *clk, u8 *sd_div, u16 m, u8 n)
 
 /*
  * _omap3_noncore_dpll_program - set non-core DPLL M,N values directly
- * @clk: struct clk * of DPLL to set
- * @m: DPLL multiplier to set
- * @n: DPLL divider to set
- * @freqsel: FREQSEL value to set
+ * @clk:	struct clk * of DPLL to set
+ * @freqsel:	FREQSEL value to set
  *
- * Program the DPLL with the supplied M, N values, and wait for the DPLL to
- * lock..  Returns -EINVAL upon error, or 0 upon success.
+ * Program the DPLL with the last M, N values calculated, and wait for
+ * the DPLL to lock. Returns -EINVAL upon error, or 0 upon success.
  */
-static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
+static int omap3_noncore_dpll_program(struct clk *clk, u16 freqsel)
 {
 	struct dpll_data *dd = clk->dpll_data;
 	u8 dco, sd_div;
@@ -323,23 +320,45 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 	/* Set DPLL multiplier, divider */
 	v = __raw_readl(dd->mult_div1_reg);
 	v &= ~(dd->mult_mask | dd->div1_mask);
-	v |= m << __ffs(dd->mult_mask);
-	v |= (n - 1) << __ffs(dd->div1_mask);
+	v |= dd->last_rounded_m << __ffs(dd->mult_mask);
+	v |= (dd->last_rounded_n - 1) << __ffs(dd->div1_mask);
 
 	/* Configure dco and sd_div for dplls that have these fields */
 	if (dd->dco_mask) {
-		_lookup_dco(clk, &dco, m, n);
+		_lookup_dco(clk, &dco, dd->last_rounded_m, dd->last_rounded_n);
 		v &= ~(dd->dco_mask);
 		v |= dco << __ffs(dd->dco_mask);
 	}
 	if (dd->sddiv_mask) {
-		_lookup_sddiv(clk, &sd_div, m, n);
+		_lookup_sddiv(clk, &sd_div, dd->last_rounded_m,
+			      dd->last_rounded_n);
 		v &= ~(dd->sddiv_mask);
 		v |= sd_div << __ffs(dd->sddiv_mask);
 	}
 
 	__raw_writel(v, dd->mult_div1_reg);
 
+	/* Set 4X multiplier and low-power mode */
+	if (dd->m4xen_mask || dd->lpmode_mask) {
+		v = __raw_readl(dd->control_reg);
+
+		if (dd->m4xen_mask) {
+			if (dd->last_rounded_m4xen)
+				v |= dd->m4xen_mask;
+			else
+				v &= ~dd->m4xen_mask;
+		}
+
+		if (dd->lpmode_mask) {
+			if (dd->last_rounded_lpmode)
+				v |= dd->lpmode_mask;
+			else
+				v &= ~dd->lpmode_mask;
+		}
+
+		__raw_writel(v, dd->control_reg);
+	}
+
 	/* We let the clock framework set the other output dividers later */
 
 	/* REVISIT: Set ramp-up delay? */
@@ -487,8 +506,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		pr_debug("clock: %s: set rate: locking rate to %lu.\n",
 			 __clk_get_name(clk), rate);
 
-		ret = omap3_noncore_dpll_program(clk, dd->last_rounded_m,
-						 dd->last_rounded_n, freqsel);
+		ret = omap3_noncore_dpll_program(clk, freqsel);
 		if (!ret)
 			new_parent = dd->clk_ref;
 	}
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 09d0ccc..8c40780 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -22,6 +22,15 @@
 #include "clock44xx.h"
 #include "cm-regbits-44xx.h"
 
+/*
+ * Maximum DPLL input frequency (FINT) and output frequency (FOUT) that
+ * can supported when using the DPLL low-power mode. Frequencies are
+ * defined in OMAP4430/60 Public TRM section 3.6.3.3.2 "Enable Control,
+ * Status, and Low-Power Operation Mode".
+ */
+#define OMAP4_DPLL_LP_FINT_MAX	1000000
+#define OMAP4_DPLL_LP_FOUT_MAX	100000000
+
 /* Supported only on OMAP4 */
 int omap4_dpllmx_gatectrl_read(struct clk *clk)
 {
@@ -84,6 +93,31 @@ const struct clkops clkops_omap4_dpllmx_ops = {
 };
 
 /**
+ * omap4_dpll_lpmode_recalc - compute DPLL low-power setting
+ * @dd: pointer to the dpll data structure
+ *
+ * Calculates if low-power mode can be enabled based upon the last
+ * multiplier and divider values calculated. If low-power mode can be
+ * enabled, then the bit to enable low-power mode is stored in the
+ * last_rounded_lpmode variable. This implementation is based upon the
+ * criteria for enabling low-power mode as described in the OMAP4430/60
+ * Public TRM section 3.6.3.3.2 "Enable Control, Status, and Low-Power
+ * Operation Mode".
+ */
+static void omap4_dpll_lpmode_recalc(struct dpll_data *dd)
+{
+	long fint, fout;
+
+	fint = __clk_get_rate(dd->clk_ref) / (dd->last_rounded_n + 1);
+	fout = fint * dd->last_rounded_m;
+
+	if ((fint < OMAP4_DPLL_LP_FINT_MAX) && (fout < OMAP4_DPLL_LP_FOUT_MAX))
+		dd->last_rounded_lpmode = 1;
+	else
+		dd->last_rounded_lpmode = 0;
+}
+
+/**
  * omap4_dpll_regm4xen_recalc - compute DPLL rate, considering REGM4XEN bit
  * @clk: struct clk * of the DPLL to compute the rate for
  *
@@ -127,7 +161,6 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk)
  */
 long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
 {
-	u32 v;
 	struct dpll_data *dd;
 	long r;
 
@@ -136,18 +169,30 @@ long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
 
 	dd = clk->dpll_data;
 
-	/* regm4xen adds a multiplier of 4 to DPLL calculations */
-	v = __raw_readl(dd->control_reg) & OMAP4430_DPLL_REGM4XEN_MASK;
-
-	if (v)
-		target_rate = target_rate / OMAP4430_REGM4XEN_MULT;
+	dd->last_rounded_m4xen = 0;
 
+	/*
+	 * First try to compute the DPLL configuration for
+	 * target rate without using the 4X multiplier.
+	 */
 	r = omap2_dpll_round_rate(clk, target_rate);
+	if (r != ~0)
+		goto out;
+
+	/*
+	 * If we did not find a valid DPLL configuration, try again, but
+	 * this time see if using the 4X multiplier can help. Enabling the
+	 * 4X multiplier is equivalent to dividing the target rate by 4.
+	 */
+	r = omap2_dpll_round_rate(clk, target_rate / OMAP4430_REGM4XEN_MULT);
 	if (r == ~0)
 		return r;
 
-	if (v)
-		clk->dpll_data->last_rounded_rate *= OMAP4430_REGM4XEN_MULT;
+	dd->last_rounded_rate *= OMAP4430_REGM4XEN_MULT;
+	dd->last_rounded_m4xen = 1;
+
+out:
+	omap4_dpll_lpmode_recalc(dd);
 
-	return clk->dpll_data->last_rounded_rate;
+	return dd->last_rounded_rate;
 }
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index e2e2d04..16654a3 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -118,6 +118,10 @@ struct clksel {
  * @enable_mask: mask of the DPLL mode bitfield in @control_reg
  * @last_rounded_rate: cache of the last rate result of omap2_dpll_round_rate()
  * @last_rounded_m: cache of the last M result of omap2_dpll_round_rate()
+ * @last_rounded_m4xen: cache of the last M4X result of
+ *			omap4_dpll_regm4xen_round_rate()
+ * @last_rounded_lpmode: cache of the last lpmode result of
+ *			 omap4_dpll_lpmode_recalc()
  * @max_multiplier: maximum valid non-bypass multiplier value (actual)
  * @last_rounded_n: cache of the last N result of omap2_dpll_round_rate()
  * @min_divider: minimum valid non-bypass divider value (actual)
@@ -128,6 +132,8 @@ struct clksel {
  * @autoidle_mask: mask of the DPLL autoidle mode bitfield in @autoidle_reg
  * @freqsel_mask: mask of the DPLL jitter correction bitfield in @control_reg
  * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
+ * @lpmode_mask: mask of the DPLL low-power mode bitfield in @control_reg
+ * @m4xen_mask: mask of the DPLL M4X multiplier bitfield in @control_reg
  * @auto_recal_bit: bitshift of the driftguard enable bit in @control_reg
  * @recal_en_bit: bitshift of the PRM_IRQENABLE_* bit for recalibration IRQs
  * @recal_st_bit: bitshift of the PRM_IRQSTATUS_* bit for recalibration IRQs
@@ -156,6 +162,8 @@ struct dpll_data {
 	u32			enable_mask;
 	unsigned long		last_rounded_rate;
 	u16			last_rounded_m;
+	u8			last_rounded_m4xen;
+	u8			last_rounded_lpmode;
 	u16			max_multiplier;
 	u8			last_rounded_n;
 	u8			min_divider;
@@ -168,6 +176,8 @@ struct dpll_data {
 	u32			idlest_mask;
 	u32			dco_mask;
 	u32			sddiv_mask;
+	u32			lpmode_mask;
+	u32			m4xen_mask;
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-- 
1.7.9.5

