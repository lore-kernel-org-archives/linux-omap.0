From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 9/9] OMAP3 clock: add omap3_core_dpll_m2_set_rate()
Date: Mon, 07 Jul 2008 20:55:13 -0600
Message-ID: <20080708025511.11646.13749.stgit@localhost.localdomain>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40865 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921AbYGHC4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2008 22:56:38 -0400
In-Reply-To: <20080708025225.11646.55912.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add the omap3_core_dpll_m2_set_rate() function to the OMAP3 clock code,
which calls into the SRAM function omap3_sram_configure_core_dpll() to
change the CORE DPLL M2 divider.  (SRAM code is necessary since rate changes
on clocks upstream from the SDRC can glitch SDRAM accesses.)

Use this function for the set_rate function pointer in the dpll3_m2_ck
struct clk.  With this function in place, PM/OPP code should be able to
alter SDRAM speed via code similar to:

      clk_set_rate(&dpll3_m2_ck, target_rate).

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock34xx.c |   66 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock34xx.h |    9 ++---
 2 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 482f05c..0caa4dd 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -15,7 +15,6 @@
  * published by the Free Software Foundation.
  */
 #undef DEBUG
-#define DEBUG
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -410,6 +409,71 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
+
+/*
+ * CORE DPLL (DPLL3) rate programming functions
+ *
+ * These call into SRAM code to do the actual CM writes, since the SDRAM
+ * is clocked from DPLL3.
+ */
+
+/**
+ * omap3_core_dpll_m2_set_rate - set CORE DPLL M2 divider
+ * @clk: struct clk * of DPLL to set
+ * @rate: rounded target rate
+ *
+ * Program the DPLL M2 divider with the rounded target rate.  Returns
+ * -EINVAL upon error, or 0 upon success.
+ */
+static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 new_div = 0;
+	unsigned long validrate, sdrcrate;
+	struct omap_sdrc_params *sp;
+
+	if (!clk || !rate)
+		return -EINVAL;
+
+	if (clk != &dpll3_m2_ck)
+		return -EINVAL;
+
+	if (rate == clk->rate)
+		return 0;
+
+	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
+	if (validrate != rate)
+		return -EINVAL;
+
+	sdrcrate = sdrc_ick.rate;
+	if (rate > clk->rate)
+		sdrcrate <<= ((rate / clk->rate) - 1);
+	else
+		sdrcrate >>= ((clk->rate / rate) - 1);
+
+	sp = omap2_sdrc_get_params(sdrcrate);
+	if (!sp)
+		return -EINVAL;
+
+	pr_info("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
+		validrate);
+	pr_info("clock: SDRC timing params used: %08x %08x %08x\n",
+		sp->rfr_ctrl, sp->actim_ctrla, sp->actim_ctrlb);
+
+	/* REVISIT: SRAM code doesn't support other M2 divisors yet */
+	WARN_ON(new_div != 1 && new_div != 2);
+
+	/* REVISIT: Add SDRC_MR changing to this code also */
+	local_irq_disable();
+	omap3_configure_core_dpll(sp->rfr_ctrl, sp->actim_ctrla,
+				  sp->actim_ctrlb, new_div);
+	local_irq_enable();
+
+	omap2_clksel_recalc(clk);
+
+	return 0;
+}
+
+
 /* DPLL autoidle read/set code */
 
 
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 161da12..74a7e98 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -35,6 +35,7 @@ static u32 omap3_dpll_autoidle_read(struct clk *clk);
 static int omap3_noncore_dpll_enable(struct clk *clk);
 static void omap3_noncore_dpll_disable(struct clk *clk);
 static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
+static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
 
 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT		2048
@@ -481,11 +482,7 @@ static const struct clksel div31_dpll3m2_clksel[] = {
 	{ .parent = NULL }
 };
 
-/*
- * DPLL3 output M2
- * REVISIT: This DPLL output divider must be changed in SRAM, so until
- * that code is ready, this should remain a 'read-only' clksel clock.
- */
+/* DPLL3 output M2 - primary control point for CORE speed */
 static struct clk dpll3_m2_ck = {
 	.name		= "dpll3_m2_ck",
 	.parent		= &dpll3_ck,
@@ -495,6 +492,8 @@ static struct clk dpll3_m2_ck = {
 	.clksel		= div31_dpll3m2_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap3_core_dpll_m2_set_rate,
 	.recalc		= &omap2_clksel_recalc,
 };
 


