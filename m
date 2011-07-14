From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/6] OMAP4: Clock: round_rate and recalc functions for DPLL_ABE
Date: Thu, 14 Jul 2011 18:24:33 -0500
Message-ID: <1310685873-3286-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58799 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932558Ab1GNXYh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 19:24:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Mike Turquette <mturquette@ti.com>

From: Mike Turquette <mturquette@ti.com>

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
---
 arch/arm/mach-omap2/clock.h          |    2 +
 arch/arm/mach-omap2/clock44xx.h      |    1 +
 arch/arm/mach-omap2/clock44xx_data.c |    4 +-
 arch/arm/mach-omap2/dpll44xx.c       |   45 ++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index e10ff2b..1e505fe 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -64,6 +64,8 @@ void omap3_noncore_dpll_disable(struct clk *clk);
 int omap4_dpllmx_gatectrl_read(struct clk *clk);
 void omap4_dpllmx_allow_gatectrl(struct clk *clk);
 void omap4_dpllmx_deny_gatectrl(struct clk *clk);
+long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate);
+unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 6be1095..a1cdaa9 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -14,6 +14,7 @@
  */
 #define OMAP4430_MAX_DPLL_MULT	2047
 #define OMAP4430_MAX_DPLL_DIV	128
+#define OMAP4430_REGM4XEN_MULT	4
 
 int omap4xxx_clk_init(void);
 
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 6e158ce..9b58d93 100644
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
index 4e4da61..4f31530 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -19,6 +19,7 @@
 #include <plat/clock.h>
 
 #include "clock.h"
+#include "clock44xx.h"
 #include "cm-regbits-44xx.h"
 
 /* Supported only on OMAP4 */
@@ -82,3 +83,47 @@ const struct clkops clkops_omap4_dpllmx_ops = {
 	.deny_idle	= omap4_dpllmx_deny_gatectrl,
 };
 
+unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk)
+{
+	u32 v;
+	unsigned long rate;
+	struct dpll_data *dd;
+
+	if (!clk || !clk->dpll_data)
+		return -EINVAL;
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
+long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
+{
+	u32 v;
+	struct dpll_data *dd;
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
+	omap2_dpll_round_rate(clk, target_rate);
+
+	if (v)
+		clk->dpll_data->last_rounded_rate *= OMAP4430_REGM4XEN_MULT;
+
+	return clk->dpll_data->last_rounded_rate;
+}
-- 
1.7.4.1

