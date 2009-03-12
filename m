From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 73/86] [ARM] omap: create a proper tree of clocks
Date: Thu, 12 Mar 2009 11:28:23 -0700
Message-ID: <1236882516-29403-74-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-70-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-71-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-72-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-73-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259AbZCLSd7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:33:59 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:33:58 -0700 (PDT)
In-Reply-To: <1236882516-29403-73-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Traditionally, we've tracked the parent/child relationships between
clk structures by setting the child's parent member to point at the
upstream clock.  As a result, when decending the tree, we have had
to scan all clocks to find the children.

Avoid this wasteful scanning by keeping a list of the clock's children.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c             |    3 +
 arch/arm/mach-omap1/clock.h             |    7 +--
 arch/arm/mach-omap2/clock.c             |    4 +-
 arch/arm/mach-omap2/clock24xx.c         |    3 +
 arch/arm/mach-omap2/clock24xx.h         |   28 +++------
 arch/arm/mach-omap2/clock34xx.c         |    3 +
 arch/arm/mach-omap2/clock34xx.h         |   96 +++++--------------------------
 arch/arm/plat-omap/clock.c              |   51 ++++++++++------
 arch/arm/plat-omap/include/mach/clock.h |    7 ++-
 9 files changed, 74 insertions(+), 128 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 1e477af..ccf989f 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -782,6 +782,9 @@ int __init omap1_clk_init(void)
 	/* By default all idlect1 clocks are allowed to idle */
 	arm_idlect1_mask = ~0;
 
+	for (c = omap_clks; c < omap_clks + ARRAY_SIZE(omap_clks); c++)
+		clk_init_one(c->lk.clk);
+
 	cpu_mask = 0;
 	if (cpu_is_omap16xx())
 		cpu_mask |= CK_16XX;
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 1b4dd05..28bc74e 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -155,7 +155,6 @@ static struct clk ck_dpll1 = {
 	.name		= "ck_dpll1",
 	.ops		= &clkops_null,
 	.parent		= &ck_ref,
-	.flags		= RATE_PROPAGATES,
 };
 
 static struct arm_idlect1_clk ck_dpll1out = {
@@ -163,8 +162,7 @@ static struct arm_idlect1_clk ck_dpll1out = {
 		.name		= "ck_dpll1out",
 		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IDLE_CONTROL |
-				  ENABLE_REG_32BIT | RATE_PROPAGATES,
+		.flags		= CLOCK_IDLE_CONTROL | ENABLE_REG_32BIT,
 		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
@@ -187,7 +185,6 @@ static struct clk arm_ck = {
 	.name		= "arm_ck",
 	.ops		= &clkops_null,
 	.parent		= &ck_dpll1,
-	.flags		= RATE_PROPAGATES,
 	.rate_offset	= CKCTL_ARMDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
 	.round_rate	= omap1_clk_round_rate_ckctl_arm,
@@ -328,7 +325,7 @@ static struct arm_idlect1_clk tc_ck = {
 		.name		= "tc_ck",
 		.ops		= &clkops_null,
 		.parent		= &ck_dpll1,
-		.flags		= RATE_PROPAGATES | CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IDLE_CONTROL,
 		.rate_offset	= CKCTL_TCDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
 		.round_rate	= omap1_clk_round_rate_ckctl_arm,
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 478ca66..38a7898 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -175,7 +175,7 @@ void omap2_init_clksel_parent(struct clk *clk)
 						 clk->name, clks->parent->name,
 						 ((clk->parent) ?
 						  clk->parent->name : "NULL"));
-					clk->parent = clks->parent;
+					clk_reparent(clk, clks->parent);
 				};
 				found = 1;
 			}
@@ -780,7 +780,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	if (clk->usecount > 0)
 		_omap2_clk_enable(clk);
 
-	clk->parent = new_parent;
+	clk_reparent(clk, new_parent);
 
 	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
 	clk->rate = new_parent->rate;
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 4564ae3..1a88597 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -718,6 +718,9 @@ int __init omap2_clk_init(void)
 	omap2_sys_clk_recalc(&sys_ck);
 	propagate_rate(&sys_ck);
 
+	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
+		clk_init_one(c->lk.clk);
+
 	cpu_mask = 0;
 	if (cpu_is_omap2420())
 		cpu_mask |= CK_242X;
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 7731ab6..7594898 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -621,7 +621,7 @@ static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32000,
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 	.clkdm_name	= "wkup_clkdm",
 };
 
@@ -629,7 +629,6 @@ static struct clk func_32k_ck = {
 static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 	.name		= "osc_ck",
 	.ops		= &clkops_oscck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_osc_clk_recalc,
 };
@@ -639,7 +638,6 @@ static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
 	.ops		= &clkops_null,
 	.parent		= &osc_ck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_sys_clk_recalc,
 };
@@ -648,7 +646,7 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
 	.ops		= &clkops_null,
 	.rate		= 54000000,
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 	.clkdm_name	= "wkup_clkdm",
 };
 
@@ -680,7 +678,6 @@ static struct clk dpll_ck = {
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,		/* Can be func_32k also */
 	.dpll_data	= &dpll_dd,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_dpllcore_recalc,
 	.set_rate	= &omap2_reprogram_dpllcore,
@@ -691,7 +688,7 @@ static struct clk apll96_ck = {
 	.ops		= &clkops_fixed,
 	.parent		= &sys_ck,
 	.rate		= 96000000,
-	.flags		= RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
+	.flags		= RATE_FIXED | ENABLE_ON_INIT,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
@@ -702,7 +699,7 @@ static struct clk apll54_ck = {
 	.ops		= &clkops_fixed,
 	.parent		= &sys_ck,
 	.rate		= 54000000,
-	.flags		= RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
+	.flags		= RATE_FIXED | ENABLE_ON_INIT,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
@@ -734,7 +731,6 @@ static struct clk func_54m_ck = {
 	.name		= "func_54m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll54_ck,	/* can also be alt_clk */
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
@@ -747,7 +743,6 @@ static struct clk core_ck = {
 	.name		= "core_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll_ck,		/* can also be 32k */
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -774,7 +769,6 @@ static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll96_ck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
@@ -807,7 +801,6 @@ static struct clk func_48m_ck = {
 	.name		= "func_48m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll96_ck,	 /* 96M or Alt */
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
@@ -823,7 +816,6 @@ static struct clk func_12m_ck = {
 	.ops		= &clkops_null,
 	.parent		= &func_48m_ck,
 	.fixed_div	= 4,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
@@ -876,7 +868,6 @@ static struct clk sys_clkout_src = {
 	.name		= "sys_clkout_src",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
@@ -921,7 +912,6 @@ static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
@@ -992,7 +982,7 @@ static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm_name	= "mpu_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
@@ -1034,7 +1024,7 @@ static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm_name	= "dsp_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -1102,7 +1092,7 @@ static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
+	.flags		= CONFIG_PARTICIPANT | DELAYED_APP,
 	.clkdm_name	= "iva1_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
@@ -1165,7 +1155,7 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm_name	= "core_l3_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
@@ -1227,7 +1217,7 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ck,
-	.flags		= DELAYED_APP | RATE_PROPAGATES,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l4_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 75eb254..a853b1e 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -904,6 +904,9 @@ int __init omap2_clk_init(void)
 	clk_init(&omap2_clk_functions);
 
 	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
+		clk_init_one(c->lk.clk);
+
+	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
 		if (c->cpu & cpu_clkflg) {
 			clkdev_add(&c->lk);
 			clk_register(c->lk.clk);
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 681acf0..2138a58 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -60,14 +60,14 @@ static struct clk omap_32k_fck = {
 	.name		= "omap_32k_fck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 };
 
 static struct clk secure_32k_fck = {
 	.name		= "secure_32k_fck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 };
 
 /* Virtual source clocks for osc_sys_ck */
@@ -75,42 +75,42 @@ static struct clk virt_12m_ck = {
 	.name		= "virt_12m_ck",
 	.ops		= &clkops_null,
 	.rate		= 12000000,
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 };
 
 static struct clk virt_13m_ck = {
 	.name		= "virt_13m_ck",
 	.ops		= &clkops_null,
 	.rate		= 13000000,
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 };
 
 static struct clk virt_16_8m_ck = {
 	.name		= "virt_16_8m_ck",
 	.ops		= &clkops_null,
 	.rate		= 16800000,
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 };
 
 static struct clk virt_19_2m_ck = {
 	.name		= "virt_19_2m_ck",
 	.ops		= &clkops_null,
 	.rate		= 19200000,
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 };
 
 static struct clk virt_26m_ck = {
 	.name		= "virt_26m_ck",
 	.ops		= &clkops_null,
 	.rate		= 26000000,
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 };
 
 static struct clk virt_38_4m_ck = {
 	.name		= "virt_38_4m_ck",
 	.ops		= &clkops_null,
 	.rate		= 38400000,
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 };
 
 static const struct clksel_rate osc_sys_12m_rates[] = {
@@ -163,7 +163,7 @@ static struct clk osc_sys_ck = {
 	.clksel_mask	= OMAP3430_SYS_CLKIN_SEL_MASK,
 	.clksel		= osc_sys_clksel,
 	/* REVISIT: deal with autoextclkmode? */
-	.flags		= RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -188,21 +188,18 @@ static struct clk sys_ck = {
 	.clksel_reg	= OMAP3430_PRM_CLKSRC_CTRL,
 	.clksel_mask	= OMAP_SYSCLKDIV_MASK,
 	.clksel		= sys_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk sys_altclk = {
 	.name		= "sys_altclk",
 	.ops		= &clkops_null,
-	.flags		= RATE_PROPAGATES,
 };
 
 /* Optional external clock input for some McBSPs */
 static struct clk mcbsp_clks = {
 	.name		= "mcbsp_clks",
 	.ops		= &clkops_null,
-	.flags		= RATE_PROPAGATES,
 };
 
 /* PRM EXTERNAL CLOCK OUTPUT */
@@ -279,7 +276,6 @@ static struct clk dpll1_ck = {
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll1_dd,
-	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.clkdm_name	= "dpll1_clkdm",
@@ -294,7 +290,6 @@ static struct clk dpll1_x2_ck = {
 	.name		= "dpll1_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll1_ck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll1_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -317,7 +312,6 @@ static struct clk dpll1_x2m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL),
 	.clksel_mask	= OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll1_x2m2_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll1_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -353,7 +347,6 @@ static struct clk dpll2_ck = {
 	.ops		= &clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll2_dd,
-	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.clkdm_name	= "dpll2_clkdm",
@@ -378,7 +371,6 @@ static struct clk dpll2_m2_ck = {
 					  OMAP3430_CM_CLKSEL2_PLL),
 	.clksel_mask	= OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll2_m2x2_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll2_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -413,7 +405,6 @@ static struct clk dpll3_ck = {
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll3_dd,
-	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap3_dpll_recalc,
@@ -427,7 +418,6 @@ static struct clk dpll3_x2_ck = {
 	.name		= "dpll3_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_ck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -481,7 +471,6 @@ static struct clk dpll3_m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div31_dpll3m2_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll3_clkdm",
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap3_core_dpll_m2_set_rate,
@@ -501,7 +490,6 @@ static struct clk core_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= core_ck_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -518,7 +506,6 @@ static struct clk dpll3_m2x2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= dpll3_m2x2_ck_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -538,7 +525,6 @@ static struct clk dpll3_m3_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
 	.clksel		= div16_dpll3_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -550,7 +536,7 @@ static struct clk dpll3_m3x2_ck = {
 	.parent		= &dpll3_m3_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_CORE_SHIFT,
-	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= INVERT_ENABLE,
 	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -569,7 +555,6 @@ static struct clk emu_core_alwon_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= emu_core_alwon_ck_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -603,7 +588,6 @@ static struct clk dpll4_ck = {
 	.ops		= &clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll4_dd,
-	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_dpll4_set_rate,
 	.clkdm_name	= "dpll4_clkdm",
@@ -619,7 +603,6 @@ static struct clk dpll4_x2_ck = {
 	.name		= "dpll4_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -638,7 +621,6 @@ static struct clk dpll4_m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
 	.clksel_mask	= OMAP3430_DIV_96M_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -650,7 +632,7 @@ static struct clk dpll4_m2x2_ck = {
 	.parent		= &dpll4_m2_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_96M_SHIFT,
-	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= INVERT_ENABLE,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -675,7 +657,6 @@ static struct clk omap_96m_alwon_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= omap_96m_alwon_fck_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -683,7 +664,6 @@ static struct clk cm_96m_fck = {
 	.name		= "cm_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -711,7 +691,6 @@ static struct clk omap_96m_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_SOURCE_96M_MASK,
 	.clksel		= omap_96m_fck_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -724,7 +703,6 @@ static struct clk dpll4_m3_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -737,7 +715,7 @@ static struct clk dpll4_m3x2_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_TV_SHIFT,
-	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= INVERT_ENABLE,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -756,7 +734,6 @@ static struct clk virt_omap_54m_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= virt_omap_54m_fck_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -783,7 +760,6 @@ static struct clk omap_54m_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_SOURCE_54M_MASK,
 	.clksel		= omap_54m_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -810,7 +786,6 @@ static struct clk omap_48m_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_SOURCE_48M_MASK,
 	.clksel		= omap_48m_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -819,7 +794,6 @@ static struct clk omap_12m_fck = {
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
 	.fixed_div	= 4,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
@@ -832,7 +806,6 @@ static struct clk dpll4_m4_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -846,7 +819,7 @@ static struct clk dpll4_m4x2_ck = {
 	.parent		= &dpll4_m4_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
-	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= INVERT_ENABLE,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -860,7 +833,6 @@ static struct clk dpll4_m5_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -872,7 +844,7 @@ static struct clk dpll4_m5x2_ck = {
 	.parent		= &dpll4_m5_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
-	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= INVERT_ENABLE,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -886,7 +858,6 @@ static struct clk dpll4_m6_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -899,7 +870,7 @@ static struct clk dpll4_m6x2_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
-	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= INVERT_ENABLE,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -908,7 +879,6 @@ static struct clk emu_per_alwon_ck = {
 	.name		= "emu_per_alwon_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_m6x2_ck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -943,7 +913,6 @@ static struct clk dpll5_ck = {
 	.ops		= &clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll5_dd,
-	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.clkdm_name	= "dpll5_clkdm",
@@ -963,7 +932,6 @@ static struct clk dpll5_m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL5),
 	.clksel_mask	= OMAP3430ES2_DIV_120M_MASK,
 	.clksel		= div16_dpll5_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "dpll5_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -982,7 +950,6 @@ static struct clk omap_120m_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
 	.clksel_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
 	.clksel		= omap_120m_fck_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1025,7 +992,6 @@ static struct clk clkout2_src_ck = {
 	.clksel_reg	= OMAP3430_CM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
 	.clksel		= clkout2_src_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1060,7 +1026,6 @@ static struct clk corex2_fck = {
 	.name		= "corex2_fck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_m2x2_ck,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1090,7 +1055,6 @@ static struct clk dpll1_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.clksel_mask	= OMAP3430_MPU_CLK_SRC_MASK,
 	.clksel		= div4_core_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1114,7 +1078,6 @@ static struct clk mpu_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.clksel		= mpu_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "mpu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1139,7 +1102,6 @@ static struct clk arm_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.clksel		= arm_fck_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1153,7 +1115,6 @@ static struct clk emu_mpu_alwon_ck = {
 	.name		= "emu_mpu_alwon_ck",
 	.ops		= &clkops_null,
 	.parent		= &mpu_ck,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1165,7 +1126,6 @@ static struct clk dpll2_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.clksel_mask	= OMAP3430_IVA2_CLK_SRC_MASK,
 	.clksel		= div4_core_clksel,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1193,7 +1153,6 @@ static struct clk iva2_ck = {
 					  OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_IVA2_CLK_MASK,
 	.clksel		= iva2_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "iva2_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1213,7 +1172,6 @@ static struct clk l3_ick = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_L3_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1231,7 +1189,6 @@ static struct clk l4_ick = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_L4_MASK,
 	.clksel		= div2_l3_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 
@@ -1281,7 +1238,6 @@ static struct clk gfx_l3_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_l3_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1440,7 +1396,6 @@ static struct clk core_96m_fck = {
 	.name		= "core_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_fck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1574,7 +1529,6 @@ static struct clk core_48m_fck = {
 	.name		= "core_48m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1652,7 +1606,6 @@ static struct clk core_12m_fck = {
 	.name		= "core_12m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_12m_fck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1692,7 +1645,6 @@ static struct clk ssi_ssr_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1718,7 +1670,6 @@ static struct clk core_l3_ick = {
 	.ops		= &clkops_null,
 	.parent		= &l3_ick,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1759,7 +1710,6 @@ static struct clk security_l3_ick = {
 	.name		= "security_l3_ick",
 	.ops		= &clkops_null,
 	.parent		= &l3_ick,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1779,7 +1729,6 @@ static struct clk core_l4_ick = {
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2062,7 +2011,6 @@ static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2106,7 +2054,6 @@ static struct clk security_l4_ick2 = {
 	.name		= "security_l4_ick2",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2350,7 +2297,6 @@ static struct clk wkup_32k_fck = {
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clk_clkdm,
 	.parent		= &omap_32k_fck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2379,7 +2325,6 @@ static struct clk wkup_l4_ick = {
 	.name		= "wkup_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2466,7 +2411,6 @@ static struct clk per_96m_fck = {
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2476,7 +2420,6 @@ static struct clk per_48m_fck = {
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2600,7 +2543,6 @@ static struct clk per_32k_alwon_fck = {
 	.ops		= &clkops_null,
 	.parent		= &omap_32k_fck,
 	.clkdm_name	= "per_clkdm",
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2668,7 +2610,6 @@ static struct clk per_l4_ick = {
 	.name		= "per_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2948,7 +2889,6 @@ static struct clk emu_src_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2973,7 +2913,6 @@ static struct clk pclk_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_PCLK_MASK,
 	.clksel		= pclk_emu_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2997,7 +2936,6 @@ static struct clk pclkx2_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_PCLKX2_MASK,
 	.clksel		= pclkx2_emu_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3014,7 +2952,6 @@ static struct clk atclk_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_ATCLK_MASK,
 	.clksel		= atclk_emu_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3026,7 +2963,6 @@ static struct clk traceclk_src_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_TRACE_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
-	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3063,7 +2999,6 @@ static struct clk sr1_fck = {
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -3074,7 +3009,6 @@ static struct clk sr2_fck = {
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
-	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 54da27a..6a1737a 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -143,8 +143,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (ret == 0) {
 		if (clk->recalc)
 			clk->recalc(clk);
-		if (clk->flags & RATE_PROPAGATES)
-			propagate_rate(clk);
+		propagate_rate(clk);
 	}
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
@@ -166,8 +165,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (ret == 0) {
 		if (clk->recalc)
 			clk->recalc(clk);
-		if (clk->flags & RATE_PROPAGATES)
-			propagate_rate(clk);
+		propagate_rate(clk);
 	}
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
@@ -214,24 +212,31 @@ void followparent_recalc(struct clk *clk)
 	clk->rate = clk->parent->rate;
 }
 
+void clk_reparent(struct clk *child, struct clk *parent)
+{
+	list_del_init(&child->sibling);
+	if (parent)
+		list_add(&child->sibling, &parent->children);
+	child->parent = parent;
+
+	/* now do the debugfs renaming to reattach the child
+	   to the proper parent */
+}
+
 /* Propagate rate to children */
 void propagate_rate(struct clk * tclk)
 {
 	struct clk *clkp;
 
-	if (tclk == NULL || IS_ERR(tclk))
-		return;
-
-	list_for_each_entry(clkp, &clocks, node) {
-		if (likely(clkp->parent != tclk))
-			continue;
+	list_for_each_entry(clkp, &tclk->children, sibling) {
 		if (clkp->recalc)
 			clkp->recalc(clkp);
-		if (clkp->flags & RATE_PROPAGATES)
-			propagate_rate(clkp);
+		propagate_rate(clkp);
 	}
 }
 
+static LIST_HEAD(root_clks);
+
 /**
  * recalculate_root_clocks - recalculate and propagate all root clocks
  *
@@ -243,16 +248,18 @@ void recalculate_root_clocks(void)
 {
 	struct clk *clkp;
 
-	list_for_each_entry(clkp, &clocks, node) {
-		if (!clkp->parent) {
-			if (clkp->recalc)
-				clkp->recalc(clkp);
-			if (clkp->flags & RATE_PROPAGATES)
-				propagate_rate(clkp);
-		}
+	list_for_each_entry(clkp, &root_clks, sibling) {
+		if (clkp->recalc)
+			clkp->recalc(clkp);
+		propagate_rate(clkp);
 	}
 }
 
+void clk_init_one(struct clk *clk)
+{
+	INIT_LIST_HEAD(&clk->children);
+}
+
 int clk_register(struct clk *clk)
 {
 	if (clk == NULL || IS_ERR(clk))
@@ -265,6 +272,11 @@ int clk_register(struct clk *clk)
 		return 0;
 
 	mutex_lock(&clocks_mutex);
+	if (clk->parent)
+		list_add(&clk->sibling, &clk->parent->children);
+	else
+		list_add(&clk->sibling, &root_clks);
+
 	list_add(&clk->node, &clocks);
 	if (clk->init)
 		clk->init(clk);
@@ -280,6 +292,7 @@ void clk_unregister(struct clk *clk)
 		return;
 
 	mutex_lock(&clocks_mutex);
+	list_del(&clk->sibling);
 	list_del(&clk->node);
 	mutex_unlock(&clocks_mutex);
 }
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 8705902..af6ae4f 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -70,6 +70,8 @@ struct clk {
 	const char		*name;
 	int			id;
 	struct clk		*parent;
+	struct list_head	children;
+	struct list_head	sibling;	/* node for children */
 	unsigned long		rate;
 	__u32			flags;
 	void __iomem		*enable_reg;
@@ -115,7 +117,9 @@ struct clk_functions {
 extern unsigned int mpurate;
 
 extern int clk_init(struct clk_functions *custom_clocks);
+extern void clk_init_one(struct clk *clk);
 extern int clk_register(struct clk *clk);
+extern void clk_reparent(struct clk *child, struct clk *parent);
 extern void clk_unregister(struct clk *clk);
 extern void propagate_rate(struct clk *clk);
 extern void recalculate_root_clocks(void);
@@ -131,8 +135,7 @@ extern const struct clkops clkops_null;
 /* Clock flags */
 /* bit 0 is free */
 #define RATE_FIXED		(1 << 1)	/* Fixed clock rate */
-#define RATE_PROPAGATES		(1 << 2)	/* Program children too */
-/* bits 3-4 are free */
+/* bits 2-4 are free */
 #define ENABLE_REG_32BIT	(1 << 5)	/* Use 32-bit access */
 #define CLOCK_IDLE_CONTROL	(1 << 7)
 #define CLOCK_NO_IDLE_PARENT	(1 << 8)
-- 
1.6.1.2

