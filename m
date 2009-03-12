From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 41/86] [ARM] OMAP3 clock: fix 96MHz clocks
Date: Thu, 12 Mar 2009 11:27:51 -0700
Message-ID: <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:2971 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685AbZCLSbp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:45 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1247397wfa.4
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:43 -0700 (PDT)
In-Reply-To: <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Fix some bugs in the OMAP3 clock tree pertaining to the 96MHz clocks.
The 96MHz portion of the clock tree should now have reasonable
fidelity to the 34xx TRM Rev I.

One remaining question mark: it's not clear exactly which 96MHz source
clock the USIM uses.  This patch sticks with the previous setting, which
seems reasonable.

linux-omap source commit is 15c706e8179ce238c3ba70a25846a36b73bd2359.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock34xx.h       |   58 +++++++++++++++++++++------------
 arch/arm/mach-omap2/cm-regbits-34xx.h |    8 +++-
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index a2dcf57..2c84717 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -640,6 +640,12 @@ static const struct clksel omap_96m_alwon_fck_clksel[] = {
 	{ .parent = NULL }
 };
 
+/*
+ * DPLL4 generates DPLL4_M2X2_CLK which is then routed into the PRM as
+ * PRM_96M_ALWON_(F)CLK.  Two clocks then emerge from the PRM:
+ * 96M_ALWON_FCLK (called "omap_96m_alwon_fck" below) and
+ * CM_96K_(F)CLK.
+ */
 static struct clk omap_96m_alwon_fck = {
 	.name		= "omap_96m_alwon_fck",
 	.ops		= &clkops_null,
@@ -652,28 +658,38 @@ static struct clk omap_96m_alwon_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk omap_96m_fck = {
-	.name		= "omap_96m_fck",
+static struct clk cm_96m_fck = {
+	.name		= "cm_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
 	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
-static const struct clksel cm_96m_fck_clksel[] = {
-	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
-	{ .parent = &dpll4_m2x2_ck, .rates = dpll_locked_rates },
+static const struct clksel_rate omap_96m_dpll_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate omap_96m_sys_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel omap_96m_fck_clksel[] = {
+	{ .parent = &cm_96m_fck, .rates = omap_96m_dpll_rates },
+	{ .parent = &sys_ck,	 .rates = omap_96m_sys_rates },
 	{ .parent = NULL }
 };
 
-static struct clk cm_96m_fck = {
-	.name		= "cm_96m_fck",
+static struct clk omap_96m_fck = {
+	.name		= "omap_96m_fck",
 	.ops		= &clkops_null,
-	.parent		= &dpll4_m2x2_ck,
+	.parent		= &sys_ck,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
-	.clksel		= cm_96m_fck_clksel,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_SOURCE_96M_MASK,
+	.clksel		= omap_96m_fck_clksel,
 	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -742,13 +758,13 @@ static struct clk omap_54m_fck = {
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_SOURCE_54M,
+	.clksel_mask	= OMAP3430_SOURCE_54M_MASK,
 	.clksel		= omap_54m_clksel,
 	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static const struct clksel_rate omap_48m_96md2_rates[] = {
+static const struct clksel_rate omap_48m_cm96m_rates[] = {
 	{ .div = 2, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
 	{ .div = 0 }
 };
@@ -759,7 +775,7 @@ static const struct clksel_rate omap_48m_alt_rates[] = {
 };
 
 static const struct clksel omap_48m_clksel[] = {
-	{ .parent = &cm_96m_fck, .rates = omap_48m_96md2_rates },
+	{ .parent = &cm_96m_fck, .rates = omap_48m_cm96m_rates },
 	{ .parent = &sys_altclk, .rates = omap_48m_alt_rates },
 	{ .parent = NULL }
 };
@@ -769,7 +785,7 @@ static struct clk omap_48m_fck = {
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_SOURCE_48M,
+	.clksel_mask	= OMAP3430_SOURCE_48M_MASK,
 	.clksel		= omap_48m_clksel,
 	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
@@ -958,10 +974,10 @@ static const struct clksel_rate clkout2_src_54m_rates[] = {
 };
 
 static const struct clksel clkout2_src_clksel[] = {
-	{ .parent = &core_ck,		  .rates = clkout2_src_core_rates },
-	{ .parent = &sys_ck,		  .rates = clkout2_src_sys_rates },
-	{ .parent = &omap_96m_alwon_fck,  .rates = clkout2_src_96m_rates },
-	{ .parent = &omap_54m_fck,	  .rates = clkout2_src_54m_rates },
+	{ .parent = &core_ck,		.rates = clkout2_src_core_rates },
+	{ .parent = &sys_ck,		.rates = clkout2_src_sys_rates },
+	{ .parent = &cm_96m_fck,	.rates = clkout2_src_96m_rates },
+	{ .parent = &omap_54m_fck,	.rates = clkout2_src_54m_rates },
 	{ .parent = NULL }
 };
 
@@ -2782,8 +2798,8 @@ static struct clk mcbsp4_ick = {
 };
 
 static const struct clksel mcbsp_234_clksel[] = {
-	{ .parent = &per_96m_fck, .rates = common_mcbsp_96m_rates },
-	{ .parent = &mcbsp_clks,  .rates = common_mcbsp_mcbsp_rates },
+	{ .parent = &core_96m_fck, .rates = common_mcbsp_96m_rates },
+	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
 	{ .parent = NULL }
 };
 
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 219f5c8..a46f93c 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -449,8 +449,12 @@
 #define OMAP3430_CORE_DPLL_MULT_MASK			(0x7ff << 16)
 #define OMAP3430_CORE_DPLL_DIV_SHIFT			8
 #define OMAP3430_CORE_DPLL_DIV_MASK			(0x7f << 8)
-#define OMAP3430_SOURCE_54M				(1 << 5)
-#define OMAP3430_SOURCE_48M				(1 << 3)
+#define OMAP3430_SOURCE_96M_SHIFT			6
+#define OMAP3430_SOURCE_96M_MASK			(1 << 6)
+#define OMAP3430_SOURCE_54M_SHIFT			5
+#define OMAP3430_SOURCE_54M_MASK			(1 << 5)
+#define OMAP3430_SOURCE_48M_SHIFT			3
+#define OMAP3430_SOURCE_48M_MASK			(1 << 3)
 
 /* CM_CLKSEL2_PLL */
 #define OMAP3430_PERIPH_DPLL_MULT_SHIFT			8
-- 
1.6.1.2

