From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/6] OMAP4: Clock: round_rate and recalc functions
 for DPLL_ABE
Date: Wed, 28 Sep 2011 00:59:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109280056570.4399@utopia.booyaka.com>
References: <1316195263-14951-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60201 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab1I1G7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 02:59:35 -0400
In-Reply-To: <1316195263-14951-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, Mike Turquette <mturquette@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon and Mike,

On Fri, 16 Sep 2011, Jon Hunter wrote:

> From: Mike Turquette <mturquette@ti.com>
> 
> OMAP4 DPLL_ABE can enable a 4X multipler on top of the normal MN multipler
> and divider. This is achieved by setting CM_CLKMODE_DPLL_ABE.DPLL_REGM4XEN
> bit in CKGEN module of CM1. From the OMAP4 TRM:
> 
> Fdpll = Fref x 2 x (4 x M/(N+1)) in case REGM4XEN bit field is set (only
> applicable to DPLL_ABE).
> 
> Add new round_rate() and recalc() functions for OMAP4, that check the
> setting of REGM4XEN bit and handle this appropriately. The new functions
> are a simple wrapper on top of the existing omap2_dpll_round_rate() and
> omap2_dpll_get_rate() functions to handle the REGM4XEN bit.
> 
> The REGM4XEN bit is only implemented for the ABE DPLL on OMAP4 and so
> only dpll_abe_ck uses omap4_dpll_regm4xen_round_rate() and
> omap4_dpll_regm4xen_recalc() functions.
> 
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> Tested-by: Jon Hunter <jon-hunter@ti.com>

Some changes have been made to this patch here, to fix a few minor bugs in 
error paths and to add documentation and Jon's Signed-off-by: (since he's 
in the submittal chain).

Care to review and send any comments?  Otherwise, I plan to queue this 
revised version for 3.2.

Thanks for the great changelogs on this, and the other patches in this 
series.

regards


- Paul

From: Mike Turquette <mturquette@ti.com>
Date: Wed, 28 Sep 2011 00:00:31 -0600
Subject: [PATCH] ARM: OMAP4: clock: round_rate and recalc functions for
 DPLL_ABE

OMAP4 DPLL_ABE can enable a 4X multipler on top of the normal MN multipler
and divider. This is achieved by setting CM_CLKMODE_DPLL_ABE.DPLL_REGM4XEN
bit in CKGEN module of CM1. From the OMAP4 TRM:

Fdpll = Fref x 2 x (4 x M/(N+1)) in case REGM4XEN bit field is set (only
applicable to DPLL_ABE).

Add new round_rate() and recalc() functions for OMAP4, that check the
setting of REGM4XEN bit and handle this appropriately. The new functions
are a simple wrapper on top of the existing omap2_dpll_round_rate() and
omap2_dpll_get_rate() functions to handle the REGM4XEN bit.

The REGM4XEN bit is only implemented for the ABE DPLL on OMAP4 and so
only dpll_abe_ck uses omap4_dpll_regm4xen_round_rate() and
omap4_dpll_regm4xen_recalc() functions.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Tested-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
[paul@pwsan.com: fixed attempt to return a negative from a fn returning
		 unsigned; pass along errors from omap2_dpll_round_rate();
		 added documentation; added Jon's S-o-b]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.h          |    2 +
 arch/arm/mach-omap2/clock44xx.h      |    7 +++
 arch/arm/mach-omap2/clock44xx_data.c |    4 +-
 arch/arm/mach-omap2/dpll44xx.c       |   69 ++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 48ac568..2311bc2 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -66,6 +66,8 @@ void omap3_noncore_dpll_disable(struct clk *clk);
 int omap4_dpllmx_gatectrl_read(struct clk *clk);
 void omap4_dpllmx_allow_gatectrl(struct clk *clk);
 void omap4_dpllmx_deny_gatectrl(struct clk *clk);
+long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate);
+unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 7ceb870..287a46f 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -8,6 +8,13 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK44XX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK44XX_H
 
+/*
+ * OMAP4430_REGM4XEN_MULT: If the CM_CLKMODE_DPLL_ABE.DPLL_REGM4XEN bit is
+ *    set, then the DPLL's lock frequency is multiplied by 4 (OMAP4430 TRM
+ *    vV Section 3.6.3.3.1 "DPLLs Output Clocks Parameters")
+ */
+#define OMAP4430_REGM4XEN_MULT	4
+
 int omap4xxx_clk_init(void);
 
 #endif
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index c0b6fbd..c98c0a2 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -270,8 +270,8 @@ static struct clk dpll_abe_ck = {
 	.dpll_data	= &dpll_abe_dd,
 	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_omap3_noncore_dpll_ops,
-	.recalc		= &omap3_dpll_recalc,
-	.round_rate	= &omap2_dpll_round_rate,
+	.recalc		= &omap4_dpll_regm4xen_recalc,
+	.round_rate	= &omap4_dpll_regm4xen_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 };
 
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 4e4da61..9c6a296 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -19,6 +19,7 @@
 #include <plat/clock.h>
 
 #include "clock.h"
+#include "clock44xx.h"
 #include "cm-regbits-44xx.h"
 
 /* Supported only on OMAP4 */
@@ -82,3 +83,71 @@ const struct clkops clkops_omap4_dpllmx_ops = {
 	.deny_idle	= omap4_dpllmx_deny_gatectrl,
 };
 
+/**
+ * omap4_dpll_regm4xen_recalc - compute DPLL rate, considering REGM4XEN bit
+ * @clk: struct clk * of the DPLL to compute the rate for
+ *
+ * Compute the output rate for the OMAP4 DPLL represented by @clk.
+ * Takes the REGM4XEN bit into consideration, which is needed for the
+ * OMAP4 ABE DPLL.  Returns the DPLL's output rate (before M-dividers)
+ * upon success, or 0 upon error.
+ */
+unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk)
+{
+	u32 v;
+	unsigned long rate;
+	struct dpll_data *dd;
+
+	if (!clk || !clk->dpll_data)
+		return 0;
+
+	dd = clk->dpll_data;
+
+	rate = omap2_get_dpll_rate(clk);
+
+	/* regm4xen adds a multiplier of 4 to DPLL calculations */
+	v = __raw_readl(dd->control_reg);
+	if (v & OMAP4430_DPLL_REGM4XEN_MASK)
+		rate *= OMAP4430_REGM4XEN_MULT;
+
+	return rate;
+}
+
+/**
+ * omap4_dpll_regm4xen_round_rate - round DPLL rate, considering REGM4XEN bit
+ * @clk: struct clk * of the DPLL to round a rate for
+ * @target_rate: the desired rate of the DPLL
+ *
+ * Compute the rate that would be programmed into the DPLL hardware
+ * for @clk if set_rate() were to be provided with the rate
+ * @target_rate.  Takes the REGM4XEN bit into consideration, which is
+ * needed for the OMAP4 ABE DPLL.  Returns the rounded rate (before
+ * M-dividers) upon success, -EINVAL if @clk is null or not a DPLL, or
+ * ~0 if an error occurred in omap2_dpll_round_rate().
+ */
+long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
+{
+	u32 v;
+	struct dpll_data *dd;
+	long r;
+
+	if (!clk || !clk->dpll_data)
+		return -EINVAL;
+
+	dd = clk->dpll_data;
+
+	/* regm4xen adds a multiplier of 4 to DPLL calculations */
+	v = __raw_readl(dd->control_reg) & OMAP4430_DPLL_REGM4XEN_MASK;
+
+	if (v)
+		target_rate = target_rate / OMAP4430_REGM4XEN_MULT;
+
+	r = omap2_dpll_round_rate(clk, target_rate);
+	if (r == ~0)
+		return r;
+
+	if (v)
+		clk->dpll_data->last_rounded_rate *= OMAP4430_REGM4XEN_MULT;
+
+	return clk->dpll_data->last_rounded_rate;
+}
-- 
1.7.6.3

