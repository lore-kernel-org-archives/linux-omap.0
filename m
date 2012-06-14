From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 17/29] ARM: omap: clock: Get rid of unwanted clkdm assocations within clks
Date: Thu, 14 Jun 2012 18:17:06 +0530
Message-ID: <1339678038-23082-18-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48636 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958Ab2FNMsY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 08:48:24 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

clkdm assocations with clocks in the clock framework are useful
only for 'gate' clocks which have enable/disable ops populated.
Get rid of the clkdm_names populated in any other type of clocks.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |   16 ------------
 arch/arm/mach-omap2/clock2430_data.c |   15 -----------
 arch/arm/mach-omap2/clock3xxx_data.c |   44 ----------------------------------
 3 files changed, 0 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 7fe2233..5a15655 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -56,14 +56,12 @@ static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.clkdm_name	= "wkup_clkdm",
 };
 
 static struct clk secure_32k_ck = {
 	.name		= "secure_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.clkdm_name	= "wkup_clkdm",
 };
 
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
@@ -79,7 +77,6 @@ static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
 	.ops		= &clkops_null,
 	.parent		= &osc_ck,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2xxx_sys_clk_recalc,
 };
 
@@ -87,7 +84,6 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
 	.ops		= &clkops_null,
 	.rate		= 54000000,
-	.clkdm_name	= "wkup_clkdm",
 };
 
 /* Optional external clock input for McBSP CLKS */
@@ -180,7 +176,6 @@ static struct clk func_54m_ck = {
 	.name		= "func_54m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll54_ck,	/* can also be alt_clk */
-	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_54M_SOURCE_MASK,
@@ -192,7 +187,6 @@ static struct clk core_ck = {
 	.name		= "core_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll_ck,		/* can also be 32k */
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -200,7 +194,6 @@ static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll96_ck,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -226,7 +219,6 @@ static struct clk func_48m_ck = {
 	.name		= "func_48m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll96_ck,	 /* 96M or Alt */
-	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_48M_SOURCE_MASK,
@@ -241,7 +233,6 @@ static struct clk func_12m_ck = {
 	.ops		= &clkops_null,
 	.parent		= &func_48m_ck,
 	.fixed_div	= 4,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap_fixed_divisor_recalc,
 };
 
@@ -323,7 +314,6 @@ static struct clk sys_clkout = {
 	.name		= "sys_clkout",
 	.ops		= &clkops_null,
 	.parent		= &sys_clkout_src,
-	.clkdm_name	= "wkup_clkdm",
 	.clksel_reg	= OMAP2420_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
@@ -359,7 +349,6 @@ static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
 	.ops		= &clkops_null,
 	.parent		= &sys_clkout2_src,
-	.clkdm_name	= "wkup_clkdm",
 	.clksel_reg	= OMAP2420_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
@@ -407,7 +396,6 @@ static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.clkdm_name	= "mpu_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
@@ -541,7 +529,6 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.clkdm_name	= "core_l3_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
 	.clksel		= core_l3_clksel,
@@ -597,7 +584,6 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ck,
-	.clkdm_name	= "core_l4_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
 	.clksel		= l4_clksel,
@@ -815,7 +801,6 @@ static struct clk wu_l4_ick = {
 	.name		= "wu_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1597,7 +1582,6 @@ static struct clk sdma_fck = {
 	.name		= "sdma_fck",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &core_l3_ck,
-	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 21e69ab..f9e2bc7 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -55,14 +55,12 @@ static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.clkdm_name	= "wkup_clkdm",
 };
 
 static struct clk secure_32k_ck = {
 	.name		= "secure_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.clkdm_name	= "wkup_clkdm",
 };
 
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
@@ -78,7 +76,6 @@ static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
 	.ops		= &clkops_null,
 	.parent		= &osc_ck,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2xxx_sys_clk_recalc,
 };
 
@@ -86,7 +83,6 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
 	.ops		= &clkops_null,
 	.rate		= 54000000,
-	.clkdm_name	= "wkup_clkdm",
 };
 
 /* Optional external clock input for McBSP CLKS */
@@ -179,7 +175,6 @@ static struct clk func_54m_ck = {
 	.name		= "func_54m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll54_ck,	/* can also be alt_clk */
-	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_54M_SOURCE_MASK,
@@ -191,7 +186,6 @@ static struct clk core_ck = {
 	.name		= "core_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll_ck,		/* can also be 32k */
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -216,7 +210,6 @@ static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll96_ck,
-	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP2430_96M_SOURCE_MASK,
@@ -246,7 +239,6 @@ static struct clk func_48m_ck = {
 	.name		= "func_48m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll96_ck,	 /* 96M or Alt */
-	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_48M_SOURCE_MASK,
@@ -261,7 +253,6 @@ static struct clk func_12m_ck = {
 	.ops		= &clkops_null,
 	.parent		= &func_48m_ck,
 	.fixed_div	= 4,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap_fixed_divisor_recalc,
 };
 
@@ -343,7 +334,6 @@ static struct clk sys_clkout = {
 	.name		= "sys_clkout",
 	.ops		= &clkops_null,
 	.parent		= &sys_clkout_src,
-	.clkdm_name	= "wkup_clkdm",
 	.clksel_reg	= OMAP2430_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
@@ -388,7 +378,6 @@ static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.clkdm_name	= "mpu_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
@@ -486,7 +475,6 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.clkdm_name	= "core_l3_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
 	.clksel		= core_l3_clksel,
@@ -542,7 +530,6 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ck,
-	.clkdm_name	= "core_l4_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
 	.clksel		= l4_clksel,
@@ -802,7 +789,6 @@ static struct clk wu_l4_ick = {
 	.name		= "wu_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1634,7 +1620,6 @@ static struct clk sdma_fck = {
 	.name		= "sdma_fck",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &core_l3_ck,
-	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 4c826e0..1ef8260 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -314,7 +314,6 @@ static struct clk dpll1_x2_ck = {
 	.name		= "dpll1_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll1_ck,
-	.clkdm_name	= "dpll1_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -336,7 +335,6 @@ static struct clk dpll1_x2m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL),
 	.clksel_mask	= OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll1_x2m2_clksel,
-	.clkdm_name	= "dpll1_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -396,7 +394,6 @@ static struct clk dpll2_m2_ck = {
 					  OMAP3430_CM_CLKSEL2_PLL),
 	.clksel_mask	= OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll2_m2x2_clksel,
-	.clkdm_name	= "dpll2_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -444,7 +441,6 @@ static struct clk dpll3_x2_ck = {
 	.name		= "dpll3_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_ck,
-	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -497,7 +493,6 @@ static struct clk dpll3_m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div31_dpll3m2_clksel,
-	.clkdm_name	= "dpll3_clkdm",
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap3_core_dpll_m2_set_rate,
 	.recalc		= &omap2_clksel_recalc,
@@ -514,7 +509,6 @@ static struct clk dpll3_m2x2_ck = {
 	.name		= "dpll3_m2x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_m2_ck,
-	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -533,7 +527,6 @@ static struct clk dpll3_m3_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
 	.clksel		= div16_dpll3_clksel,
-	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -553,7 +546,6 @@ static struct clk emu_core_alwon_ck = {
 	.name		= "emu_core_alwon_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_m3x2_ck,
-	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -628,7 +620,6 @@ static struct clk dpll4_x2_ck = {
 	.name		= "dpll4_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
-	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -646,7 +637,6 @@ static struct clk dpll4_m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
 	.clksel_mask	= OMAP3630_DIV_96M_MASK,
 	.clksel		= dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -749,7 +739,6 @@ static struct clk dpll4_m3_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3630_CLKSEL_TV_MASK,
 	.clksel		= dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -834,7 +823,6 @@ static struct clk dpll4_m4_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3630_CLKSEL_DSS1_MASK,
 	.clksel		= dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 	.set_rate	= &omap2_clksel_set_rate,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -861,7 +849,6 @@ static struct clk dpll4_m5_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3630_CLKSEL_CAM_MASK,
 	.clksel		= dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
 	.set_rate	= &omap2_clksel_set_rate,
 	.round_rate	= &omap2_clksel_round_rate,
 	.recalc		= &omap2_clksel_recalc,
@@ -888,7 +875,6 @@ static struct clk dpll4_m6_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3630_DIV_DPLL4_MASK,
 	.clksel		= dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -908,7 +894,6 @@ static struct clk emu_per_alwon_ck = {
 	.name		= "emu_per_alwon_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_m6x2_ck,
-	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -962,7 +947,6 @@ static struct clk dpll5_m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL5),
 	.clksel_mask	= OMAP3430ES2_DIV_120M_MASK,
 	.clksel		= div16_dpll5_clksel,
-	.clkdm_name	= "dpll5_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1077,7 +1061,6 @@ static struct clk mpu_ck = {
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll1_x2m2_ck,
-	.clkdm_name	= "mpu_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1101,7 +1084,6 @@ static struct clk arm_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.clksel		= arm_fck_clksel,
-	.clkdm_name	= "mpu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1154,7 +1136,6 @@ static struct clk l3_ick = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_L3_MASK,
 	.clksel		= div2_core_clksel,
-	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1171,7 +1152,6 @@ static struct clk l4_ick = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_L4_MASK,
 	.clksel		= div2_l3_clksel,
-	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 
 };
@@ -1222,7 +1202,6 @@ static struct clk gfx_l3_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_l3_clksel,
-	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1230,7 +1209,6 @@ static struct clk gfx_l3_ick = {
 	.name		= "gfx_l3_ick",
 	.ops		= &clkops_null,
 	.parent		= &gfx_l3_ck,
-	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1426,7 +1404,6 @@ static struct clk core_96m_fck = {
 	.name		= "core_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_fck,
-	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1552,7 +1529,6 @@ static struct clk core_48m_fck = {
 	.name		= "core_48m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
-	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1632,7 +1608,6 @@ static struct clk core_12m_fck = {
 	.name		= "core_12m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_12m_fck,
-	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1717,7 +1692,6 @@ static struct clk core_l3_ick = {
 	.name		= "core_l3_ick",
 	.ops		= &clkops_null,
 	.parent		= &l3_ick,
-	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1758,7 +1732,6 @@ static struct clk gpmc_fck = {
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ick,
 	.flags		= ENABLE_ON_INIT, /* huh? */
-	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1786,7 +1759,6 @@ static struct clk core_l4_ick = {
 	.name		= "core_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2058,7 +2030,6 @@ static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2344,7 +2315,6 @@ static struct clk wkup_32k_fck = {
 	.name		= "wkup_32k_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_32k_fck,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2372,7 +2342,6 @@ static struct clk wkup_l4_ick = {
 	.name		= "wkup_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2457,7 +2426,6 @@ static struct clk per_96m_fck = {
 	.name		= "per_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
-	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2465,7 +2433,6 @@ static struct clk per_48m_fck = {
 	.name		= "per_48m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
-	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2607,7 +2574,6 @@ static struct clk per_32k_alwon_fck = {
 	.name		= "per_32k_alwon_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_32k_fck,
-	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2675,7 +2641,6 @@ static struct clk per_l4_ick = {
 	.name		= "per_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2958,7 +2923,6 @@ static struct clk emu_src_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
-	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2982,7 +2946,6 @@ static struct clk pclk_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_PCLK_MASK,
 	.clksel		= pclk_emu_clksel,
-	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -3005,7 +2968,6 @@ static struct clk pclkx2_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_PCLKX2_MASK,
 	.clksel		= pclkx2_emu_clksel,
-	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -3021,7 +2983,6 @@ static struct clk atclk_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_ATCLK_MASK,
 	.clksel		= atclk_emu_clksel,
-	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -3032,7 +2993,6 @@ static struct clk traceclk_src_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_TRACE_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
-	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -3055,7 +3015,6 @@ static struct clk traceclk_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_TRACECLK_MASK,
 	.clksel		= traceclk_clksel,
-	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -3087,7 +3046,6 @@ static struct clk sr_l4_ick = {
 	.name		= "sr_l4_ick",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &l4_ick,
-	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -3097,7 +3055,6 @@ static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -3105,7 +3062,6 @@ static struct clk wdt1_fck = {
 	.name		= "wdt1_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
-	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
-- 
1.7.1

