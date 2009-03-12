From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 04/86] [ARM] omap: kill PARENT_CONTROLS_CLOCK
Date: Thu, 12 Mar 2009 11:27:14 -0700
Message-ID: <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490AbZCLS3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:06 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:04 -0700 (PDT)
In-Reply-To: <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

PARENT_CONTROLS_CLOCK just makes enable/disable no-op, and is
functionally an alias for ALWAYS_ENABLED.  This can be handled
in the same way, using clkops_null.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c             |    6 -
 arch/arm/mach-omap2/clock24xx.h         |   22 +++--
 arch/arm/mach-omap2/clock34xx.h         |  196 ++++++++++++++++---------------
 arch/arm/plat-omap/include/mach/clock.h |    1 -
 4 files changed, 114 insertions(+), 111 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index fa99c0b..21fbe29 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -271,9 +271,6 @@ int _omap2_clk_enable(struct clk *clk)
 {
 	u32 regval32;
 
-	if (clk->flags & PARENT_CONTROLS_CLOCK)
-		return 0;
-
 	if (clk->ops && clk->ops->enable)
 		return clk->ops->enable(clk);
 
@@ -301,9 +298,6 @@ void _omap2_clk_disable(struct clk *clk)
 {
 	u32 regval32;
 
-	if (clk->flags & PARENT_CONTROLS_CLOCK)
-		return;
-
 	if (clk->ops && clk->ops->disable) {
 		clk->ops->disable(clk);
 		return;
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index d486937..adc00e1 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -742,9 +742,10 @@ static const struct clksel func_54m_clksel[] = {
 
 static struct clk func_54m_ck = {
 	.name		= "func_54m_ck",
+	.ops		= &clkops_null,
 	.parent		= &apll54_ck,	/* can also be alt_clk */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+				RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
@@ -783,9 +784,10 @@ static const struct clksel func_96m_clksel[] = {
 /* The parent of this clock is not selectable on 2420. */
 static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
+	.ops		= &clkops_null,
 	.parent		= &apll96_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+				RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
@@ -816,9 +818,10 @@ static const struct clksel func_48m_clksel[] = {
 
 static struct clk func_48m_ck = {
 	.name		= "func_48m_ck",
+	.ops		= &clkops_null,
 	.parent		= &apll96_ck,	 /* 96M or Alt */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+				RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
@@ -831,10 +834,11 @@ static struct clk func_48m_ck = {
 
 static struct clk func_12m_ck = {
 	.name		= "func_12m_ck",
+	.ops		= &clkops_null,
 	.parent		= &func_48m_ck,
 	.fixed_div	= 4,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+				RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
@@ -917,9 +921,9 @@ static const struct clksel sys_clkout_clksel[] = {
 
 static struct clk sys_clkout = {
 	.name		= "sys_clkout",
+	.ops		= &clkops_null,
 	.parent		= &sys_clkout_src,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "wkup_clkdm",
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
@@ -954,8 +958,9 @@ static const struct clksel sys_clkout2_clksel[] = {
 /* In 2430, new in 2420 ES2 */
 static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
+	.ops		= &clkops_null,
 	.parent		= &sys_clkout2_src,
-	.flags		= CLOCK_IN_OMAP242X | PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "wkup_clkdm",
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
@@ -1076,9 +1081,10 @@ static const struct clksel dsp_irate_ick_clksel[] = {
 /* This clock does not exist as such in the TRM. */
 static struct clk dsp_irate_ick = {
 	.name		= "dsp_irate_ick",
+	.ops		= &clkops_null,
 	.parent		= &dsp_fck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
-				CONFIG_PARTICIPANT | PARENT_CONTROLS_CLOCK,
+				CONFIG_PARTICIPANT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= dsp_irate_ick_clksel,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index b56fd28..203e2bd 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -295,9 +295,9 @@ static struct clk dpll1_ck = {
  */
 static struct clk dpll1_x2_ck = {
 	.name		= "dpll1_x2_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll1_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -313,13 +313,13 @@ static const struct clksel div16_dpll1_x2m2_clksel[] = {
  */
 static struct clk dpll1_x2m2_ck = {
 	.name		= "dpll1_x2m2_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll1_x2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL),
 	.clksel_mask	= OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll1_x2m2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -368,14 +368,14 @@ static const struct clksel div16_dpll2_m2x2_clksel[] = {
  */
 static struct clk dpll2_m2_ck = {
 	.name		= "dpll2_m2_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
 					  OMAP3430_CM_CLKSEL2_PLL),
 	.clksel_mask	= OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll2_m2x2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -416,9 +416,9 @@ static struct clk dpll3_ck = {
  */
 static struct clk dpll3_x2_ck = {
 	.name		= "dpll3_x2_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll3_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -469,13 +469,13 @@ static const struct clksel div31_dpll3m2_clksel[] = {
  */
 static struct clk dpll3_m2_ck = {
 	.name		= "dpll3_m2_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll3_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div31_dpll3m2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -487,12 +487,12 @@ static const struct clksel core_ck_clksel[] = {
 
 static struct clk core_ck = {
 	.name		= "core_ck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= core_ck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -504,12 +504,12 @@ static const struct clksel dpll3_m2x2_ck_clksel[] = {
 
 static struct clk dpll3_m2x2_ck = {
 	.name		= "dpll3_m2x2_ck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= dpll3_m2x2_ck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -522,13 +522,13 @@ static const struct clksel div16_dpll3_clksel[] = {
 /* This virtual clock is the source for dpll3_m3x2_ck */
 static struct clk dpll3_m3_ck = {
 	.name		= "dpll3_m3_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll3_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
 	.clksel		= div16_dpll3_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -550,13 +550,13 @@ static const struct clksel emu_core_alwon_ck_clksel[] = {
 
 static struct clk emu_core_alwon_ck = {
 	.name		= "emu_core_alwon_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll3_m3x2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= emu_core_alwon_ck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -599,9 +599,9 @@ static struct clk dpll4_ck = {
  */
 static struct clk dpll4_x2_ck = {
 	.name		= "dpll4_x2_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -613,13 +613,13 @@ static const struct clksel div16_dpll4_clksel[] = {
 /* This virtual clock is the source for dpll4_m2x2_ck */
 static struct clk dpll4_m2_ck = {
 	.name		= "dpll4_m2_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
 	.clksel_mask	= OMAP3430_DIV_96M_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -641,21 +641,21 @@ static const struct clksel omap_96m_alwon_fck_clksel[] = {
 
 static struct clk omap_96m_alwon_fck = {
 	.name		= "omap_96m_alwon_fck",
+	.ops		= &clkops_null,
 	.parent		= &dpll4_m2x2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= omap_96m_alwon_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				 PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk omap_96m_fck = {
 	.name		= "omap_96m_fck",
+	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -667,26 +667,26 @@ static const struct clksel cm_96m_fck_clksel[] = {
 
 static struct clk cm_96m_fck = {
 	.name		= "cm_96m_fck",
+	.ops		= &clkops_null,
 	.parent		= &dpll4_m2x2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= cm_96m_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
 /* This virtual clock is the source for dpll4_m3x2_ck */
 static struct clk dpll4_m3_ck = {
 	.name		= "dpll4_m3_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -709,13 +709,13 @@ static const struct clksel virt_omap_54m_fck_clksel[] = {
 
 static struct clk virt_omap_54m_fck = {
 	.name		= "virt_omap_54m_fck",
+	.ops		= &clkops_null,
 	.parent		= &dpll4_m3x2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= virt_omap_54m_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -737,12 +737,12 @@ static const struct clksel omap_54m_clksel[] = {
 
 static struct clk omap_54m_fck = {
 	.name		= "omap_54m_fck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_SOURCE_54M,
 	.clksel		= omap_54m_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -764,34 +764,34 @@ static const struct clksel omap_48m_clksel[] = {
 
 static struct clk omap_48m_fck = {
 	.name		= "omap_48m_fck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_SOURCE_48M,
 	.clksel		= omap_48m_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk omap_12m_fck = {
 	.name		= "omap_12m_fck",
+	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
 	.fixed_div	= 4,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
 /* This virstual clock is the source for dpll4_m4x2_ck */
 static struct clk dpll4_m4_ck = {
 	.name		= "dpll4_m4_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -808,13 +808,13 @@ static struct clk dpll4_m4x2_ck = {
 /* This virtual clock is the source for dpll4_m5x2_ck */
 static struct clk dpll4_m5_ck = {
 	.name		= "dpll4_m5_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -831,13 +831,13 @@ static struct clk dpll4_m5x2_ck = {
 /* This virtual clock is the source for dpll4_m6x2_ck */
 static struct clk dpll4_m6_ck = {
 	.name		= "dpll4_m6_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -854,9 +854,9 @@ static struct clk dpll4_m6x2_ck = {
 
 static struct clk emu_per_alwon_ck = {
 	.name		= "emu_per_alwon_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll4_m6x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -900,13 +900,13 @@ static const struct clksel div16_dpll5_clksel[] = {
 
 static struct clk dpll5_m2_ck = {
 	.name		= "dpll5_m2_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll5_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL5),
 	.clksel_mask	= OMAP3430ES2_DIV_120M_MASK,
 	.clksel		= div16_dpll5_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -918,13 +918,13 @@ static const struct clksel omap_120m_fck_clksel[] = {
 
 static struct clk omap_120m_fck = {
 	.name		= "omap_120m_fck",
+	.ops		= &clkops_null,
 	.parent		= &dpll5_m2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
 	.clksel_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
 	.clksel		= omap_120m_fck_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -986,11 +986,12 @@ static const struct clksel sys_clkout2_clksel[] = {
 
 static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP3430_CM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP3430_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -998,9 +999,9 @@ static struct clk sys_clkout2 = {
 
 static struct clk corex2_fck = {
 	.name		= "corex2_fck",
+	.ops		= &clkops_null,
 	.parent		= &dpll3_m2x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1017,13 +1018,13 @@ static const struct clksel div2_core_clksel[] = {
  */
 static struct clk dpll1_fck = {
 	.name		= "dpll1_fck",
+	.ops		= &clkops_null,
 	.parent		= &core_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.clksel_mask	= OMAP3430_MPU_CLK_SRC_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1041,13 +1042,13 @@ static const struct clksel mpu_clksel[] = {
 
 static struct clk mpu_ck = {
 	.name		= "mpu_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll1_x2m2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.clksel		= mpu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "mpu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1066,13 +1067,13 @@ static const struct clksel arm_fck_clksel[] = {
 
 static struct clk arm_fck = {
 	.name		= "arm_fck",
+	.ops		= &clkops_null,
 	.parent		= &mpu_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.clksel		= arm_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1084,21 +1085,21 @@ static struct clk arm_fck = {
  */
 static struct clk emu_mpu_alwon_ck = {
 	.name		= "emu_mpu_alwon_ck",
+	.ops		= &clkops_null,
 	.parent		= &mpu_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk dpll2_fck = {
 	.name		= "dpll2_fck",
+	.ops		= &clkops_null,
 	.parent		= &core_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.clksel_mask	= OMAP3430_IVA2_CLK_SRC_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1134,13 +1135,13 @@ static struct clk iva2_ck = {
 
 static struct clk l3_ick = {
 	.name		= "l3_ick",
+	.ops		= &clkops_null,
 	.parent		= &core_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_L3_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1152,13 +1153,13 @@ static const struct clksel div2_l3_clksel[] = {
 
 static struct clk l4_ick = {
 	.name		= "l4_ick",
+	.ops		= &clkops_null,
 	.parent		= &l3_ick,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_L4_MASK,
 	.clksel		= div2_l3_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 
@@ -1171,12 +1172,13 @@ static const struct clksel div2_l4_clksel[] = {
 
 static struct clk rm_ick = {
 	.name		= "rm_ick",
+	.ops		= &clkops_null,
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_RM_MASK,
 	.clksel		= div2_l4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1202,21 +1204,22 @@ static struct clk gfx_l3_ck = {
 
 static struct clk gfx_l3_fck = {
 	.name		= "gfx_l3_fck",
+	.ops		= &clkops_null,
 	.parent		= &gfx_l3_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_l3_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES,
 	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gfx_l3_ick = {
 	.name		= "gfx_l3_ick",
+	.ops		= &clkops_null,
 	.parent		= &gfx_l3_ck,
-	.flags		= CLOCK_IN_OMAP3430ES1 | PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1365,9 +1368,9 @@ static struct clk usbtll_fck = {
 
 static struct clk core_96m_fck = {
 	.name		= "core_96m_fck",
+	.ops		= &clkops_null,
 	.parent		= &omap_96m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1499,9 +1502,9 @@ static struct clk mcbsp1_fck = {
 
 static struct clk core_48m_fck = {
 	.name		= "core_48m_fck",
+	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1577,9 +1580,9 @@ static struct clk fshostusb_fck = {
 
 static struct clk core_12m_fck = {
 	.name		= "core_12m_fck",
+	.ops		= &clkops_null,
 	.parent		= &omap_12m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1625,9 +1628,10 @@ static struct clk ssi_ssr_fck = {
 
 static struct clk ssi_sst_fck = {
 	.name		= "ssi_sst_fck",
+	.ops		= &clkops_null,
 	.parent		= &ssi_ssr_fck,
 	.fixed_div	= 2,
-	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
@@ -1641,10 +1645,10 @@ static struct clk ssi_sst_fck = {
  */
 static struct clk core_l3_ick = {
 	.name		= "core_l3_ick",
+	.ops		= &clkops_null,
 	.parent		= &l3_ick,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1671,9 +1675,9 @@ static struct clk sdrc_ick = {
 
 static struct clk gpmc_fck = {
 	.name		= "gpmc_fck",
+	.ops		= &clkops_null,
 	.parent		= &core_l3_ick,
-	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK |
-				ENABLE_ON_INIT,
+	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT, /* huh? */
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1682,9 +1686,9 @@ static struct clk gpmc_fck = {
 
 static struct clk security_l3_ick = {
 	.name		= "security_l3_ick",
+	.ops		= &clkops_null,
 	.parent		= &l3_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1701,10 +1705,10 @@ static struct clk pka_ick = {
 
 static struct clk core_l4_ick = {
 	.name		= "core_l4_ick",
+	.ops		= &clkops_null,
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1984,9 +1988,9 @@ static struct clk omapctrl_ick = {
 
 static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
+	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2028,9 +2032,9 @@ static struct clk usb_l4_ick = {
 
 static struct clk security_l4_ick2 = {
 	.name		= "security_l4_ick2",
+	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2387,20 +2391,20 @@ static struct clk gpt1_ick = {
 
 static struct clk per_96m_fck = {
 	.name		= "per_96m_fck",
+	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk per_48m_fck = {
 	.name		= "per_48m_fck",
+	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2590,9 +2594,9 @@ static struct clk wdt3_fck = {
 
 static struct clk per_l4_ick = {
 	.name		= "per_l4_ick",
+	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index c1e4844..40a2ac3 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -148,7 +148,6 @@ extern const struct clkops clkops_null;
 #define CLOCK_IN_OMAP242X	(1 << 25)
 #define CLOCK_IN_OMAP243X	(1 << 26)
 #define CLOCK_IN_OMAP343X	(1 << 27)	/* clocks common to all 343X */
-#define PARENT_CONTROLS_CLOCK	(1 << 28)
 #define CLOCK_IN_OMAP3430ES1	(1 << 29)	/* 3430ES1 clocks only */
 #define CLOCK_IN_OMAP3430ES2	(1 << 30)	/* 3430ES2 clocks only */
 
-- 
1.6.1.2

