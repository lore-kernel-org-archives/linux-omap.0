From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 69/86] [ARM] OMAP3 clock: add omap3_core_dpll_m2_set_rate()
Date: Thu, 12 Mar 2009 11:28:19 -0700
Message-ID: <1236882516-29403-70-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757212AbZCLSdl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:33:41 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:33:39 -0700 (PDT)
In-Reply-To: <1236882516-29403-69-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Add the omap3_core_dpll_m2_set_rate() function to the OMAP3 clock code,
which calls into the SRAM function omap3_sram_configure_core_dpll() to
change the CORE DPLL M2 divider.  (SRAM code is necessary since rate changes
on clocks upstream from the SDRC can glitch SDRAM accesses.)

Use this function for the set_rate function pointer in the dpll3_m2_ck
struct clk.  With this function in place, PM/OPP code should be able to
alter SDRAM speed via code similar to:

      clk_set_rate(&dpll3_m2_ck, target_rate).

linux-omap source commit is 7f8b2b0f4fe52238c67d79dedcd2794dcef4dddd.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock34xx.c |   65 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock34xx.h |    9 ++---
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 52385b1..1ad0a13 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -634,6 +634,71 @@ static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 	return omap3_noncore_dpll_set_rate(clk, rate);
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
 static const struct clkops clkops_noncore_dpll_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index aadd296..681acf0 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -34,6 +34,7 @@ static void omap3_dpll_deny_idle(struct clk *clk);
 static u32 omap3_dpll_autoidle_read(struct clk *clk);
 static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
 static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
+static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
 
 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT		2048
@@ -471,11 +472,7 @@ static const struct clksel div31_dpll3m2_clksel[] = {
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
 	.ops		= &clkops_null,
@@ -486,6 +483,8 @@ static struct clk dpll3_m2_ck = {
 	.clksel		= div31_dpll3m2_clksel,
 	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll3_clkdm",
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap3_core_dpll_m2_set_rate,
 	.recalc		= &omap2_clksel_recalc,
 };
 
-- 
1.6.1.2

