From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 14/86] [ARM] omap: move propagate_rate() calls into generic omap clock code
Date: Thu, 12 Mar 2009 11:27:24 -0700
Message-ID: <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753AbZCLS3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:52 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:50 -0700 (PDT)
In-Reply-To: <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

propagate_rate() is recursive, so it makes sense to minimise the
amount of stack which is used for each recursion.  So, rather than
recursing back into it from the ->recalc functions if RATE_PROPAGATES
is set, do that test at the higher level.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c     |    6 ------
 arch/arm/mach-omap2/clock.c     |    6 ------
 arch/arm/mach-omap2/clock24xx.c |    6 ++----
 arch/arm/mach-omap2/clock24xx.h |    4 ----
 arch/arm/mach-omap2/clock34xx.c |    5 -----
 arch/arm/mach-omap2/clock34xx.h |   10 ----------
 arch/arm/plat-omap/clock.c      |   14 +++++++++-----
 7 files changed, 11 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 80a58e9..be50001 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -244,9 +244,6 @@ static void omap1_ckctl_recalc(struct clk * clk)
 	if (unlikely(clk->rate == clk->parent->rate / dsor))
 		return; /* No change, quick exit */
 	clk->rate = clk->parent->rate / dsor;
-
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
 }
 
 static void omap1_ckctl_recalc_dsp_domain(struct clk * clk)
@@ -267,9 +264,6 @@ static void omap1_ckctl_recalc_dsp_domain(struct clk * clk)
 	if (unlikely(clk->rate == clk->parent->rate / dsor))
 		return; /* No change, quick exit */
 	clk->rate = clk->parent->rate / dsor;
-
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
 }
 
 /* MPU virtual clock functions */
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 7a1d56a..53fda99 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -167,9 +167,6 @@ void omap2_fixed_divisor_recalc(struct clk *clk)
 	WARN_ON(!clk->fixed_div);
 
 	clk->rate = clk->parent->rate / clk->fixed_div;
-
-	if (clk->flags & RATE_PROPAGATES)
-		propagate_rate(clk);
 }
 
 /**
@@ -392,9 +389,6 @@ void omap2_clksel_recalc(struct clk *clk)
 	clk->rate = clk->parent->rate / div;
 
 	pr_debug("clock: new clock rate is %ld (div %d)\n", clk->rate, div);
-
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 866a618..3a0a1b8 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -199,8 +199,6 @@ long omap2_dpllcore_round_rate(unsigned long target_rate)
 static void omap2_dpllcore_recalc(struct clk *clk)
 {
 	clk->rate = omap2_get_dpll_rate_24xx(clk);
-
-	propagate_rate(clk);
 }
 
 static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
@@ -442,13 +440,11 @@ static u32 omap2_get_sysclkdiv(void)
 static void omap2_osc_clk_recalc(struct clk *clk)
 {
 	clk->rate = omap2_get_apll_clkin() * omap2_get_sysclkdiv();
-	propagate_rate(clk);
 }
 
 static void omap2_sys_clk_recalc(struct clk *clk)
 {
 	clk->rate = clk->parent->rate / omap2_get_sysclkdiv();
-	propagate_rate(clk);
 }
 
 /*
@@ -502,7 +498,9 @@ int __init omap2_clk_init(void)
 	clk_init(&omap2_clk_functions);
 
 	omap2_osc_clk_recalc(&osc_ck);
+	propagate_rate(&osc_ck);
 	omap2_sys_clk_recalc(&sys_ck);
+	propagate_rate(&sys_ck);
 
 	for (clkp = onchip_24xx_clks;
 	     clkp < onchip_24xx_clks + ARRAY_SIZE(onchip_24xx_clks);
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 486fd80..e07dcba 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -624,7 +624,6 @@ static struct clk func_32k_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &propagate_rate,
 };
 
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
@@ -655,7 +654,6 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &propagate_rate,
 };
 
 /*
@@ -702,7 +700,6 @@ static struct clk apll96_ck = {
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
-	.recalc		= &propagate_rate,
 };
 
 static struct clk apll54_ck = {
@@ -715,7 +712,6 @@ static struct clk apll54_ck = {
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
-	.recalc		= &propagate_rate,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 2f2d43d..52698fb 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -57,8 +57,6 @@ static const struct clkops clkops_noncore_dpll_ops;
 static void omap3_dpll_recalc(struct clk *clk)
 {
 	clk->rate = omap2_get_dpll_rate(clk);
-
-	propagate_rate(clk);
 }
 
 /* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable bits */
@@ -388,9 +386,6 @@ static void omap3_clkoutx2_recalc(struct clk *clk)
 		clk->rate = clk->parent->rate;
 	else
 		clk->rate = clk->parent->rate * 2;
-
-	if (clk->flags & RATE_PROPAGATES)
-		propagate_rate(clk);
 }
 
 /* Common clock code */
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 335ef88..dcacec8 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -58,7 +58,6 @@ static struct clk omap_32k_fck = {
 	.ops		= &clkops_null,
 	.rate		= 32768,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &propagate_rate,
 };
 
 static struct clk secure_32k_fck = {
@@ -66,7 +65,6 @@ static struct clk secure_32k_fck = {
 	.ops		= &clkops_null,
 	.rate		= 32768,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &propagate_rate,
 };
 
 /* Virtual source clocks for osc_sys_ck */
@@ -75,7 +73,6 @@ static struct clk virt_12m_ck = {
 	.ops		= &clkops_null,
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &propagate_rate,
 };
 
 static struct clk virt_13m_ck = {
@@ -83,7 +80,6 @@ static struct clk virt_13m_ck = {
 	.ops		= &clkops_null,
 	.rate		= 13000000,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &propagate_rate,
 };
 
 static struct clk virt_16_8m_ck = {
@@ -91,7 +87,6 @@ static struct clk virt_16_8m_ck = {
 	.ops		= &clkops_null,
 	.rate		= 16800000,
 	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &propagate_rate,
 };
 
 static struct clk virt_19_2m_ck = {
@@ -99,7 +94,6 @@ static struct clk virt_19_2m_ck = {
 	.ops		= &clkops_null,
 	.rate		= 19200000,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &propagate_rate,
 };
 
 static struct clk virt_26m_ck = {
@@ -107,7 +101,6 @@ static struct clk virt_26m_ck = {
 	.ops		= &clkops_null,
 	.rate		= 26000000,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &propagate_rate,
 };
 
 static struct clk virt_38_4m_ck = {
@@ -115,7 +108,6 @@ static struct clk virt_38_4m_ck = {
 	.ops		= &clkops_null,
 	.rate		= 38400000,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &propagate_rate,
 };
 
 static const struct clksel_rate osc_sys_12m_rates[] = {
@@ -201,7 +193,6 @@ static struct clk sys_altclk = {
 	.name		= "sys_altclk",
 	.ops		= &clkops_null,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
-	.recalc		= &propagate_rate,
 };
 
 /* Optional external clock input for some McBSPs */
@@ -209,7 +200,6 @@ static struct clk mcbsp_clks = {
 	.name		= "mcbsp_clks",
 	.ops		= &clkops_null,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
-	.recalc		= &propagate_rate,
 };
 
 /* PRM EXTERNAL CLOCK OUTPUT */
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index b7137c5..df58f5d 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -246,8 +246,6 @@ void followparent_recalc(struct clk *clk)
 		return;
 
 	clk->rate = clk->parent->rate;
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
 }
 
 /* Propagate rate to children */
@@ -261,8 +259,10 @@ void propagate_rate(struct clk * tclk)
 	list_for_each_entry(clkp, &clocks, node) {
 		if (likely(clkp->parent != tclk))
 			continue;
-		if (likely((u32)clkp->recalc))
+		if (clkp->recalc)
 			clkp->recalc(clkp);
+		if (clkp->flags & RATE_PROPAGATES)
+			propagate_rate(clkp);
 	}
 }
 
@@ -278,8 +278,12 @@ void recalculate_root_clocks(void)
 	struct clk *clkp;
 
 	list_for_each_entry(clkp, &clocks, node) {
-		if (unlikely(!clkp->parent) && likely((u32)clkp->recalc))
-			clkp->recalc(clkp);
+		if (!clkp->parent) {
+			if (clkp->recalc)
+				clkp->recalc(clkp);
+			if (clkp->flags & RATE_PROPAGATES)
+				propagate_rate(clkp);
+		}
 	}
 }
 
-- 
1.6.1.2

