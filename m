From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 06/23] OMAP clock: drop the RATE_PROPAGATES flag
Date: Sun, 04 Jan 2009 19:34:50 -0700
Message-ID: <20090105023449.12661.72272.stgit@localhost.localdomain>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42881 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbZAEDWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 22:22:45 -0500
In-Reply-To: <20090105022953.12661.57701.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Now that clocks keep track of their children, the RATE_PROPAGATES flag
is no longer necessary.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.h             |    9 +
 arch/arm/mach-omap2/clock24xx.h         |   41 +++---
 arch/arm/mach-omap2/clock34xx.h         |  216 +++++++++++--------------------
 arch/arm/plat-omap/include/mach/clock.h |    2 
 4 files changed, 104 insertions(+), 164 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index c69f265..d9f34d3 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -169,7 +169,7 @@ static struct clk ck_dpll1 = {
 	.name		= "ck_dpll1",
 	.parent		= &ck_ref,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_PROPAGATES | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -179,7 +179,7 @@ static struct arm_idlect1_clk ck_dpll1out = {
 		.name		= "ck_dpll1out",
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP16XX | CLOCK_IDLE_CONTROL |
-				  ENABLE_REG_32BIT | RATE_PROPAGATES,
+				  ENABLE_REG_32BIT,
 		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
@@ -206,8 +206,7 @@ static struct clk arm_ck = {
 	.name		= "arm_ck",
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_CKCTL | RATE_PROPAGATES |
-			  ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | RATE_CKCTL | ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_ARMDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -368,7 +367,7 @@ static struct arm_idlect1_clk tc_ck = {
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
-				  RATE_CKCTL | RATE_PROPAGATES |
+				  RATE_CKCTL |
 				  ALWAYS_ENABLED | CLOCK_IDLE_CONTROL,
 		.rate_offset	= CKCTL_TCDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index cd9feda..88ba9cf 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -628,15 +628,14 @@ static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.rate		= 32000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+				RATE_FIXED | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
 static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 	.name		= "osc_ck",
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable		= &omap2_enable_osc_ck,
 	.disable	= &omap2_disable_osc_ck,
@@ -648,7 +647,7 @@ static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | RATE_PROPAGATES,
+				ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_sys_clk_recalc,
 };
@@ -657,7 +656,7 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+				RATE_FIXED | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
@@ -692,7 +691,7 @@ static struct clk dpll_ck = {
 	.prcm_mod	= PLL_MOD,
 	.dpll_data	= &dpll_dd,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | ALWAYS_ENABLED,
+				ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_dpllcore_recalc,
 	.set_rate	= &omap2_reprogram_dpllcore,
@@ -704,7 +703,7 @@ static struct clk apll96_ck = {
 	.prcm_mod	= PLL_MOD,
 	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
+				RATE_FIXED | ENABLE_ON_INIT,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= CM_CLKEN,
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
@@ -718,7 +717,7 @@ static struct clk apll54_ck = {
 	.prcm_mod	= PLL_MOD,
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
+				RATE_FIXED | ENABLE_ON_INIT,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= CM_CLKEN,
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
@@ -753,7 +752,7 @@ static struct clk func_54m_ck = {
 	.parent		= &apll54_ck,	/* can also be alt_clk */
 	.prcm_mod	= PLL_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= CM_CLKSEL1,
@@ -766,7 +765,7 @@ static struct clk core_ck = {
 	.name		= "core_ck",
 	.parent		= &dpll_ck,		/* can also be 32k */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | RATE_PROPAGATES,
+				ALWAYS_ENABLED,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -794,7 +793,7 @@ static struct clk func_96m_ck = {
 	.parent		= &apll96_ck,
 	.prcm_mod	= PLL_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= CM_CLKSEL1,
@@ -828,7 +827,7 @@ static struct clk func_48m_ck = {
 	.parent		= &apll96_ck,	 /* 96M or Alt */
 	.prcm_mod	= PLL_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= CM_CLKSEL1,
@@ -844,7 +843,7 @@ static struct clk func_12m_ck = {
 	.parent		= &func_48m_ck,
 	.fixed_div	= 4,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
@@ -898,8 +897,7 @@ static struct clk sys_clkout_src = {
 	.name		= "sys_clkout_src",
 	.parent		= &func_54m_ck,
 	.prcm_mod	= OMAP24XX_GR_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
@@ -946,7 +944,7 @@ static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
 	.parent		= &func_54m_ck,
 	.prcm_mod	= OMAP24XX_GR_MOD,
-	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "cm_clkdm" },
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET,
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
@@ -1021,7 +1019,7 @@ static struct clk mpu_ck = {	/* Control cpu */
 	.prcm_mod	= MPU_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | DELAYED_APP |
-				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+				CONFIG_PARTICIPANT,
 	.clkdm		= { .name = "mpu_clkdm" },
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= CM_CLKSEL,
@@ -1064,7 +1062,7 @@ static struct clk dsp_fck = {
 	.parent		= &core_ck,
 	.prcm_mod	= OMAP24XX_DSP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
-				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+				CONFIG_PARTICIPANT,
 	.clkdm		= { .name = "dsp_clkdm" },
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -1136,8 +1134,7 @@ static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.parent		= &core_ck,
 	.prcm_mod	= OMAP24XX_DSP_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT |
-				RATE_PROPAGATES | DELAYED_APP,
+	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT | DELAYED_APP,
 	.clkdm		= { .name = "iva1_clkdm" },
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
@@ -1203,7 +1200,7 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | DELAYED_APP |
-				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+				CONFIG_PARTICIPANT,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
@@ -1268,7 +1265,7 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
 	.parent		= &core_l3_ck,
 	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | DELAYED_APP | RATE_PROPAGATES,
+				ALWAYS_ENABLED | DELAYED_APP,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 283c386..2fde89e 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -66,16 +66,14 @@ static struct clk dpll2_fck;
 static struct clk omap_32k_fck = {
 	.name		= "omap_32k_fck",
 	.rate		= 32768,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk secure_32k_fck = {
 	.name		= "secure_32k_fck",
 	.rate		= 32768,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
@@ -83,48 +81,42 @@ static struct clk secure_32k_fck = {
 static struct clk virt_12m_ck = {
 	.name		= "virt_12m_ck",
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk virt_13m_ck = {
 	.name		= "virt_13m_ck",
 	.rate		= 13000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk virt_16_8m_ck = {
 	.name		= "virt_16_8m_ck",
 	.rate		= 16800000,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_FIXED | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk virt_19_2m_ck = {
 	.name		= "virt_19_2m_ck",
 	.rate		= 19200000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk virt_26m_ck = {
 	.name		= "virt_26m_ck",
 	.rate		= 26000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk virt_38_4m_ck = {
 	.name		= "virt_38_4m_ck",
 	.rate		= 38400000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
@@ -178,7 +170,7 @@ static struct clk osc_sys_ck = {
 	.clksel_mask	= OMAP3430_SYS_CLKIN_SEL_MASK,
 	.clksel		= osc_sys_clksel,
 	/* REVISIT: deal with autoextclkmode? */
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED |
 				ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
@@ -205,14 +197,14 @@ static struct clk sys_ck = {
 	.clksel_reg	= OMAP3_PRM_CLKSRC_CTRL_OFFSET,
 	.clksel_mask	= OMAP_SYSCLKDIV_MASK,
 	.clksel		= sys_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk sys_altclk = {
 	.name		= "sys_altclk",
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "cm_clkdm" },
 };
 
@@ -223,7 +215,7 @@ static struct clk sys_altclk = {
  */
 static struct clk mcbsp_clks = {
 	.name		= "mcbsp_clks",
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
@@ -294,8 +286,7 @@ static struct clk dpll1_ck = {
 	.parent		= &sys_ck,
 	.prcm_mod	= MPU_MOD,
 	.dpll_data	= &dpll1_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-			  ALWAYS_ENABLED | RECALC_ON_ENABLE,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED | RECALC_ON_ENABLE,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.clkdm		= { .name = "dpll1_clkdm" },
@@ -309,8 +300,7 @@ static struct clk dpll1_ck = {
 static struct clk dpll1_x2_ck = {
 	.name		= "dpll1_x2_ck",
 	.parent		= &dpll1_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll1_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -333,8 +323,7 @@ static struct clk dpll1_x2m2_ck = {
 	.clksel_reg	= OMAP3430_CM_CLKSEL2_PLL,
 	.clksel_mask	= OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll1_x2m2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll1_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -371,8 +360,7 @@ static struct clk dpll2_ck = {
 	.parent		= &sys_ck,
 	.prcm_mod	= OMAP3430_IVA2_MOD,
 	.dpll_data	= &dpll2_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-			  RECALC_ON_ENABLE,
+	.flags		= CLOCK_IN_OMAP343X | RECALC_ON_ENABLE,
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
@@ -398,8 +386,7 @@ static struct clk dpll2_m2_ck = {
 	.clksel_reg	= OMAP3430_CM_CLKSEL2_PLL,
 	.clksel_mask	= OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll2_m2x2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll2_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -435,8 +422,7 @@ static struct clk dpll3_ck = {
 	.parent		= &sys_ck,
 	.prcm_mod	= PLL_MOD,
 	.dpll_data	= &dpll3_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-			  ALWAYS_ENABLED | RECALC_ON_ENABLE,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED | RECALC_ON_ENABLE,
 	.round_rate	= &omap2_dpll_round_rate,
 	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
@@ -449,8 +435,7 @@ static struct clk dpll3_ck = {
 static struct clk dpll3_x2_ck = {
 	.name		= "dpll3_x2_ck",
 	.parent		= &dpll3_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -504,8 +489,7 @@ static struct clk dpll3_m2_ck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div31_dpll3m2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll3_clkdm" },
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap3_core_dpll_m2_set_rate,
@@ -515,8 +499,7 @@ static struct clk dpll3_m2_ck = {
 static struct clk core_ck = {
 	.name		= "core_ck",
 	.parent		= &dpll3_m2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -524,8 +507,7 @@ static struct clk core_ck = {
 static struct clk dpll3_m2x2_ck = {
 	.name		= "dpll3_m2x2_ck",
 	.parent		= &dpll3_x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -545,8 +527,7 @@ static struct clk dpll3_m3_ck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
 	.clksel		= div16_dpll3_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -558,7 +539,7 @@ static struct clk dpll3_m3x2_ck = {
 	.prcm_mod	= PLL_MOD,
 	.enable_reg	= CM_CLKEN,
 	.enable_bit	= OMAP3430_PWRDN_EMU_CORE_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= CLOCK_IN_OMAP343X | INVERT_ENABLE,
 	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -566,8 +547,7 @@ static struct clk dpll3_m3x2_ck = {
 static struct clk emu_core_alwon_ck = {
 	.name		= "emu_core_alwon_ck",
 	.parent		= &dpll3_m3x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -602,8 +582,7 @@ static struct clk dpll4_ck = {
 	.parent		= &sys_ck,
 	.prcm_mod	= PLL_MOD,
 	.dpll_data	= &dpll4_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-			  RECALC_ON_ENABLE,
+	.flags		= CLOCK_IN_OMAP343X | RECALC_ON_ENABLE,
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
@@ -620,8 +599,7 @@ static struct clk dpll4_ck = {
 static struct clk dpll4_x2_ck = {
 	.name		= "dpll4_x2_ck",
 	.parent		= &dpll4_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -640,8 +618,7 @@ static struct clk dpll4_m2_ck = {
 	.clksel_reg	= OMAP3430_CM_CLKSEL3,
 	.clksel_mask	= OMAP3430_DIV_96M_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -653,7 +630,7 @@ static struct clk dpll4_m2x2_ck = {
 	.prcm_mod	= PLL_MOD,
 	.enable_reg	= CM_CLKEN,
 	.enable_bit	= OMAP3430_PWRDN_96M_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= CLOCK_IN_OMAP343X | INVERT_ENABLE,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -667,8 +644,7 @@ static struct clk dpll4_m2x2_ck = {
 static struct clk omap_96m_alwon_fck = {
 	.name		= "omap_96m_alwon_fck",
 	.parent		= &dpll4_m2x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -676,8 +652,7 @@ static struct clk omap_96m_alwon_fck = {
 static struct clk cm_96m_fck = {
 	.name		= "cm_96m_fck",
 	.parent		= &omap_96m_alwon_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -706,8 +681,7 @@ static struct clk omap_96m_fck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_SOURCE_96M_MASK,
 	.clksel		= omap_96m_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -721,8 +695,7 @@ static struct clk dpll4_m3_ck = {
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -735,7 +708,7 @@ static struct clk dpll4_m3x2_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= CM_CLKEN,
 	.enable_bit	= OMAP3430_PWRDN_TV_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= CLOCK_IN_OMAP343X | INVERT_ENABLE,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -763,8 +736,7 @@ static struct clk omap_54m_fck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_SOURCE_54M_MASK,
 	.clksel		= omap_54m_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -792,8 +764,7 @@ static struct clk omap_48m_fck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_SOURCE_48M_MASK,
 	.clksel		= omap_48m_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -802,8 +773,7 @@ static struct clk omap_12m_fck = {
 	.name		= "omap_12m_fck",
 	.parent		= &omap_48m_fck,
 	.fixed_div	= 4,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
@@ -817,8 +787,7 @@ static struct clk dpll4_m4_ck = {
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -832,7 +801,7 @@ static struct clk dpll4_m4x2_ck = {
 	.prcm_mod	= PLL_MOD,
 	.enable_reg	= CM_CLKEN,
 	.enable_bit	= OMAP3430_PWRDN_DSS1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= CLOCK_IN_OMAP343X | INVERT_ENABLE,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -846,8 +815,7 @@ static struct clk dpll4_m5_ck = {
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -859,7 +827,7 @@ static struct clk dpll4_m5x2_ck = {
 	.prcm_mod	= PLL_MOD,
 	.enable_reg	= CM_CLKEN,
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= CLOCK_IN_OMAP343X | INVERT_ENABLE,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -873,8 +841,7 @@ static struct clk dpll4_m6_ck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -887,7 +854,7 @@ static struct clk dpll4_m6x2_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= CM_CLKEN,
 	.enable_bit	= OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= CLOCK_IN_OMAP343X | INVERT_ENABLE,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -895,8 +862,7 @@ static struct clk dpll4_m6x2_ck = {
 static struct clk emu_per_alwon_ck = {
 	.name		= "emu_per_alwon_ck",
 	.parent		= &dpll4_m6x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -932,8 +898,7 @@ static struct clk dpll5_ck = {
 	.parent		= &sys_ck,
 	.prcm_mod	= PLL_MOD,
 	.dpll_data	= &dpll5_dd,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
-			  RECALC_ON_ENABLE,
+	.flags		= CLOCK_IN_OMAP3430ES2 | RECALC_ON_ENABLE,
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
@@ -955,8 +920,7 @@ static struct clk dpll5_m2_ck = {
 	.clksel_reg	= OMAP3430ES2_CM_CLKSEL5,
 	.clksel_mask	= OMAP3430ES2_DIV_120M_MASK,
 	.clksel		= div16_dpll5_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP3430ES2 | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll5_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1000,7 +964,7 @@ static struct clk clkout2_src_ck = {
 	.clksel_reg	= OMAP3430_CM_CLKOUT_CTRL_OFFSET,
 	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
 	.clksel		= clkout2_src_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1036,8 +1000,7 @@ static struct clk sys_clkout2 = {
 static struct clk corex2_fck = {
 	.name		= "corex2_fck",
 	.parent		= &dpll3_m2x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1064,8 +1027,7 @@ static struct clk dpll1_fck = {
 	.clksel_reg	= OMAP3430_CM_CLKSEL1_PLL,
 	.clksel_mask	= OMAP3430_MPU_CLK_SRC_MASK,
 	.clksel		= div4_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1073,8 +1035,7 @@ static struct clk dpll1_fck = {
 static struct clk mpu_ck = {
 	.name		= "mpu_ck",
 	.parent		= &dpll1_x2m2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "mpu_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1099,8 +1060,7 @@ static struct clk arm_fck = {
 	.clksel_reg	= OMAP3430_CM_IDLEST_PLL,
 	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.clksel		= arm_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "mpu_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1114,8 +1074,7 @@ static struct clk arm_fck = {
 static struct clk emu_mpu_alwon_ck = {
 	.name		= "emu_mpu_alwon_ck",
 	.parent		= &mpu_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "mpu_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1128,8 +1087,7 @@ static struct clk dpll2_fck = {
 	.clksel_reg	= OMAP3430_CM_CLKSEL1_PLL,
 	.clksel_mask	= OMAP3430_IVA2_CLK_SRC_MASK,
 	.clksel		= div4_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1141,7 +1099,7 @@ static struct clk iva2_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm		= { .name = "iva2_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1161,8 +1119,7 @@ static struct clk l3_ick = {
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_L3_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1180,8 +1137,7 @@ static struct clk l4_ick = {
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_L4_MASK,
 	.clksel		= div2_l3_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 
@@ -1235,8 +1191,7 @@ static struct clk gfx_l3_fck = {
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_l3_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP3430ES1 | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "gfx_3430es1_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1407,8 +1362,7 @@ static struct clk usbtll_fck = {
 static struct clk core_96m_fck = {
 	.name		= "core_96m_fck",
 	.parent		= &omap_96m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1579,8 +1533,7 @@ static struct clk mcbsp1_fck = {
 static struct clk core_48m_fck = {
 	.name		= "core_48m_fck",
 	.parent		= &omap_48m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1679,8 +1632,7 @@ static struct clk fshostusb_fck = {
 static struct clk core_12m_fck = {
 	.name		= "core_12m_fck",
 	.parent		= &omap_12m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1723,7 +1675,7 @@ static struct clk ssi_ssr_fck_3430es1 = {
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1738,7 +1690,7 @@ static struct clk ssi_ssr_fck_3430es2 = {
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES | WAIT_READY,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1773,8 +1725,7 @@ static struct clk ssi_sst_fck_3430es2 = {
 static struct clk core_l3_ick = {
 	.name		= "core_l3_ick",
 	.parent		= &l3_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1828,8 +1779,7 @@ static struct clk gpmc_fck = {
 static struct clk security_l3_ick = {
 	.name		= "security_l3_ick",
 	.parent		= &l3_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1851,8 +1801,7 @@ static struct clk pka_ick = {
 static struct clk core_l4_ick = {
 	.name		= "core_l4_ick",
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2186,8 +2135,7 @@ static struct clk omapctrl_ick = {
 static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2247,8 +2195,7 @@ static struct clk usb_l4_ick = {
 static struct clk security_l4_ick2 = {
 	.name		= "security_l4_ick2",
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2518,7 +2465,7 @@ static struct clk gpt1_fck = {
 static struct clk wkup_32k_fck = {
 	.name		= "wkup_32k_fck",
 	.parent		= &omap_32k_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2550,7 +2497,7 @@ static struct clk wdt2_fck = {
 static struct clk wkup_l4_ick = {
 	.name		= "wkup_l4_ick",
 	.parent		= &sys_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2646,8 +2593,7 @@ static struct clk gpt1_ick = {
 static struct clk per_96m_fck = {
 	.name		= "per_96m_fck",
 	.parent		= &omap_96m_alwon_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2655,8 +2601,7 @@ static struct clk per_96m_fck = {
 static struct clk per_48m_fck = {
 	.name		= "per_48m_fck",
 	.parent		= &omap_48m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2797,7 +2742,7 @@ static struct clk per_32k_alwon_fck = {
 	.name		= "per_32k_alwon_fck",
 	.parent		= &omap_32k_fck,
 	.clkdm		= { .name = "per_clkdm" },
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2876,8 +2821,7 @@ static struct clk wdt3_fck = {
 static struct clk per_l4_ick = {
 	.name		= "per_l4_ick",
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -3229,7 +3173,7 @@ static struct clk emu_src_ck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "emu_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3254,7 +3198,7 @@ static struct clk pclk_fck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_CLKSEL_PCLK_MASK,
 	.clksel		= pclk_emu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "emu_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3278,7 +3222,7 @@ static struct clk pclkx2_fck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_CLKSEL_PCLKX2_MASK,
 	.clksel		= pclkx2_emu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "emu_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3295,7 +3239,7 @@ static struct clk atclk_fck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_CLKSEL_ATCLK_MASK,
 	.clksel		= atclk_emu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "emu_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3307,7 +3251,7 @@ static struct clk traceclk_src_fck = {
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP3430_TRACE_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "emu_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3346,7 +3290,7 @@ static struct clk sr1_fck = {
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
 	.idlest_bit	= OMAP3430_ST_SR1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | WAIT_READY,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -3359,7 +3303,7 @@ static struct clk sr2_fck = {
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
 	.idlest_bit	= OMAP3430_ST_SR2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | WAIT_READY,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 358bf9e..f01f59d 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -154,7 +154,7 @@ void omap_clk_del_child(struct clk *clk, struct clk *clk2);
 /* Clock flags */
 #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
 #define RATE_FIXED		(1 << 1)	/* Fixed clock rate */
-#define RATE_PROPAGATES		(1 << 2)	/* Program children too */
+
 #define VIRTUAL_CLOCK		(1 << 3)	/* Composite clock from table */
 #define ALWAYS_ENABLED		(1 << 4)	/* Clock cannot be disabled */
 #define ENABLE_REG_32BIT	(1 << 5)	/* Use 32-bit access */


