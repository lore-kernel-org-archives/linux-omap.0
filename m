From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/14] ARM: OMAP: Change to use CM offsets for clocks for multi-omap
Date: Tue, 27 May 2008 21:20:17 -0700
Message-ID: <1211948418-16455-14-git-send-email-tony@atomide.com>
References: multi-omap-2008-05-27-212014
 <1211948418-16455-1-git-send-email-tony@atomide.com>
 <1211948418-16455-2-git-send-email-tony@atomide.com>
 <1211948418-16455-3-git-send-email-tony@atomide.com>
 <1211948418-16455-4-git-send-email-tony@atomide.com>
 <1211948418-16455-5-git-send-email-tony@atomide.com>
 <1211948418-16455-6-git-send-email-tony@atomide.com>
 <1211948418-16455-7-git-send-email-tony@atomide.com>
 <1211948418-16455-8-git-send-email-tony@atomide.com>
 <1211948418-16455-9-git-send-email-tony@atomide.com>
 <1211948418-16455-10-git-send-email-tony@atomide.com>
 <1211948418-16455-11-git-send-email-tony@atomide.com>
 <1211948418-16455-12-git-send-email-tony@atomide.com>
 <1211948418-16455-13-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64644 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbYE1EUl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 00:20:41 -0400
In-Reply-To: <1211948418-16455-13-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Change to use CM offsets for clocks for multi-omap

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock24xx.c |    9 +-
 arch/arm/mach-omap2/clock24xx.h |  295 ++++++++++++++++++++-------------------
 arch/arm/mach-omap2/cm.h        |   13 +--
 arch/arm/mach-omap2/prcm.c      |   14 ++
 4 files changed, 172 insertions(+), 159 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 84a0d10..9acc580 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -94,6 +94,7 @@ static void omap2_disable_osc_ck(struct clk *clk)
 static int omap2_clk_fixed_enable(struct clk *clk)
 {
 	u32 cval, apll_mask;
+	void __iomem *idlest;
 
 	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
 
@@ -111,8 +112,12 @@ static int omap2_clk_fixed_enable(struct clk *clk)
 	else if (clk == &apll54_ck)
 		cval = OMAP24XX_ST_54M_APLL;
 
-	omap2_wait_clock_ready(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), cval,
-			    clk->name);
+	if (cpu_is_omap242x())
+		idlest = OMAP2420_CM_REGADDR(PLL_MOD, CM_IDLEST);
+	else
+		idlest = OMAP2430_CM_REGADDR(PLL_MOD, CM_IDLEST);
+
+	omap2_wait_clock_ready(idlest, cval, clk->name);
 
 	/*
 	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index c9f3fcf..1327fed 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -600,6 +600,11 @@ static struct prcm_config rate_table[] = {
 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 };
 
+/*
+ * Since 2420 and 2430 have different cm_base, we use offsets only here.
+ * Clock code will rewrite the register address as needed.
+ */
+#define _CM_REG_OFFSET(module, reg)	((void __iomem *)(module) + (reg))
 #define _GR_MOD_OFFSET(reg)	((void __iomem*)(OMAP24XX_GR_MOD + (reg)))
 
 /*-------------------------------------------------------------------------
@@ -668,7 +673,7 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
  */
 
 static struct dpll_data dpll_dd = {
-	.mult_div1_reg		= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.mult_div1_reg		= _CM_REG_OFFSET(PLL_MOD, CM_CLKSEL1),
 	.mult_mask		= OMAP24XX_DPLL_MULT_MASK,
 	.div1_mask		= OMAP24XX_DPLL_DIV_MASK,
 	.max_multiplier		= 1024,
@@ -696,7 +701,7 @@ static struct clk apll96_ck = {
 	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_reg	= _CM_REG_OFFSET(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
 	.enable		= &omap2_clk_fixed_enable,
 	.disable	= &omap2_clk_fixed_disable,
@@ -709,7 +714,7 @@ static struct clk apll54_ck = {
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_reg	= _CM_REG_OFFSET(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
 	.enable		= &omap2_clk_fixed_enable,
 	.disable	= &omap2_clk_fixed_disable,
@@ -744,7 +749,7 @@ static struct clk func_54m_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_54M_SOURCE,
 	.clksel		= func_54m_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -782,7 +787,7 @@ static struct clk func_96m_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP2430_96M_SOURCE,
 	.clksel		= func_96m_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -814,7 +819,7 @@ static struct clk func_48m_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_48M_SOURCE,
 	.clksel		= func_48m_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -994,7 +999,7 @@ static struct clk mpu_ck = {	/* Control cpu */
 				ALWAYS_ENABLED | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
+	.clksel_reg	= _CM_REG_OFFSET(MPU_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
 	.clksel		= mpu_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1034,9 +1039,9 @@ static struct clk dsp_fck = {
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
 	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1066,7 +1071,7 @@ static struct clk dsp_irate_ick = {
 	.parent		= &dsp_fck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
 				CONFIG_PARTICIPANT | PARENT_CONTROLS_CLOCK,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= dsp_irate_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1079,7 +1084,7 @@ static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.parent		= &dsp_irate_ick,
 	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
+	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
 };
 
@@ -1088,7 +1093,7 @@ static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.parent		= &dsp_irate_ick,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 };
 
@@ -1097,9 +1102,9 @@ static struct clk iva1_ifck = {
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT |
 				RATE_PROPAGATES | DELAYED_APP,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
 	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1112,7 +1117,7 @@ static struct clk iva1_mpu_int_ifck = {
 	.name		= "iva1_mpu_int_ifck",
 	.parent		= &iva1_ifck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
 	.fixed_div	= 2,
 	.recalc		= &omap2_fixed_divisor_recalc,
@@ -1159,7 +1164,7 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
 	.clksel		= core_l3_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1185,9 +1190,9 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP | CONFIG_PARTICIPANT,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
 	.clksel		= usb_l4_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1224,9 +1229,9 @@ static struct clk ssi_ssr_sst_fck = {
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_sst_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1257,9 +1262,9 @@ static struct clk gfx_3d_fck = {
 	.name		= "gfx_3d_fck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
+	.enable_reg	= _CM_REG_OFFSET(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
+	.clksel_reg	= _CM_REG_OFFSET(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1271,9 +1276,9 @@ static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
+	.enable_reg	= _CM_REG_OFFSET(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
+	.clksel_reg	= _CM_REG_OFFSET(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1285,7 +1290,7 @@ static struct clk gfx_ick = {
 	.name		= "gfx_ick",		/* From l3 */
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
+	.enable_reg	= _CM_REG_OFFSET(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1314,9 +1319,9 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
+	.enable_reg	= _CM_REG_OFFSET(OMAP2430_MDM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL),
+	.clksel_reg	= _CM_REG_OFFSET(OMAP2430_MDM_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP2430_CLKSEL_MDM_MASK,
 	.clksel		= mdm_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1328,7 +1333,7 @@ static struct clk mdm_osc_ck = {
 	.name		= "mdm_osc_ck",
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_FCLKEN),
+	.enable_reg	= _CM_REG_OFFSET(OMAP2430_MDM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2430_EN_OSC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1356,7 +1361,7 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | DELAYED_APP | RATE_PROPAGATES,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
 	.clksel		= l4_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1368,7 +1373,7 @@ static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1412,7 +1417,7 @@ static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.name		= "dss_ick",
 	.parent		= &l4_ck,	/* really both l3 and l4 */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1422,10 +1427,10 @@ static struct clk dss1_fck = {
 	.parent		= &core_ck,		/* Core or sys */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS1_MASK,
 	.clksel		= dss1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1454,10 +1459,10 @@ static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS2_MASK,
 	.clksel		= dss2_fck_clksel,
 	.recalc		= &followparent_recalc,
@@ -1467,7 +1472,7 @@ static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.name		= "dss_54m_fck",	/* 54m tv clk */
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_TV_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1494,7 +1499,7 @@ static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1503,10 +1508,10 @@ static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1518,7 +1523,7 @@ static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1527,10 +1532,10 @@ static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT2_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1540,7 +1545,7 @@ static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1549,10 +1554,10 @@ static struct clk gpt3_fck = {
 	.name		= "gpt3_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT3_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1562,7 +1567,7 @@ static struct clk gpt4_ick = {
 	.name		= "gpt4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1571,10 +1576,10 @@ static struct clk gpt4_fck = {
 	.name		= "gpt4_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT4_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1584,7 +1589,7 @@ static struct clk gpt5_ick = {
 	.name		= "gpt5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1593,10 +1598,10 @@ static struct clk gpt5_fck = {
 	.name		= "gpt5_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT5_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1606,7 +1611,7 @@ static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1615,10 +1620,10 @@ static struct clk gpt6_fck = {
 	.name		= "gpt6_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT6_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1628,7 +1633,7 @@ static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1637,10 +1642,10 @@ static struct clk gpt7_fck = {
 	.name		= "gpt7_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT7_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1650,7 +1655,7 @@ static struct clk gpt8_ick = {
 	.name		= "gpt8_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1659,10 +1664,10 @@ static struct clk gpt8_fck = {
 	.name		= "gpt8_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT8_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1672,7 +1677,7 @@ static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1681,10 +1686,10 @@ static struct clk gpt9_fck = {
 	.name		= "gpt9_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT9_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1694,7 +1699,7 @@ static struct clk gpt10_ick = {
 	.name		= "gpt10_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1703,10 +1708,10 @@ static struct clk gpt10_fck = {
 	.name		= "gpt10_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT10_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1716,7 +1721,7 @@ static struct clk gpt11_ick = {
 	.name		= "gpt11_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1725,10 +1730,10 @@ static struct clk gpt11_fck = {
 	.name		= "gpt11_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT11_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1738,7 +1743,7 @@ static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1747,10 +1752,10 @@ static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT12_MASK,
 	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -1760,7 +1765,7 @@ static struct clk mcbsp1_ick = {
 	.name		= "mcbsp1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1769,7 +1774,7 @@ static struct clk mcbsp1_fck = {
 	.name		= "mcbsp1_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1778,7 +1783,7 @@ static struct clk mcbsp2_ick = {
 	.name		= "mcbsp2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1787,7 +1792,7 @@ static struct clk mcbsp2_fck = {
 	.name		= "mcbsp2_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1796,7 +1801,7 @@ static struct clk mcbsp3_ick = {
 	.name		= "mcbsp3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1805,7 +1810,7 @@ static struct clk mcbsp3_fck = {
 	.name		= "mcbsp3_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1814,7 +1819,7 @@ static struct clk mcbsp4_ick = {
 	.name		= "mcbsp4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1823,7 +1828,7 @@ static struct clk mcbsp4_fck = {
 	.name		= "mcbsp4_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1832,7 +1837,7 @@ static struct clk mcbsp5_ick = {
 	.name		= "mcbsp5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1841,7 +1846,7 @@ static struct clk mcbsp5_fck = {
 	.name		= "mcbsp5_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1851,7 +1856,7 @@ static struct clk mcspi1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1861,7 +1866,7 @@ static struct clk mcspi1_fck = {
 	.id		= 1,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1871,7 +1876,7 @@ static struct clk mcspi2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1881,7 +1886,7 @@ static struct clk mcspi2_fck = {
 	.id		= 2,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1891,7 +1896,7 @@ static struct clk mcspi3_ick = {
 	.id		= 3,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1901,7 +1906,7 @@ static struct clk mcspi3_fck = {
 	.id		= 3,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1910,7 +1915,7 @@ static struct clk uart1_ick = {
 	.name		= "uart1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1919,7 +1924,7 @@ static struct clk uart1_fck = {
 	.name		= "uart1_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1928,7 +1933,7 @@ static struct clk uart2_ick = {
 	.name		= "uart2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1937,7 +1942,7 @@ static struct clk uart2_fck = {
 	.name		= "uart2_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1946,7 +1951,7 @@ static struct clk uart3_ick = {
 	.name		= "uart3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1955,7 +1960,7 @@ static struct clk uart3_fck = {
 	.name		= "uart3_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1964,7 +1969,7 @@ static struct clk gpios_ick = {
 	.name		= "gpios_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1973,7 +1978,7 @@ static struct clk gpios_fck = {
 	.name		= "gpios_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1982,7 +1987,7 @@ static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1991,7 +1996,7 @@ static struct clk mpu_wdt_fck = {
 	.name		= "mpu_wdt_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2000,7 +2005,7 @@ static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2008,7 +2013,7 @@ static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_WDT1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2016,7 +2021,7 @@ static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_OMAPCTRL_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2024,7 +2029,7 @@ static struct clk icr_ick = {
 	.name		= "icr_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_EN_ICR_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2033,7 +2038,7 @@ static struct clk cam_ick = {
 	.name		= "cam_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2042,7 +2047,7 @@ static struct clk cam_fck = {
 	.name		= "cam_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2051,7 +2056,7 @@ static struct clk mailboxes_ick = {
 	.name		= "mailboxes_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MAILBOXES_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2060,7 +2065,7 @@ static struct clk wdt4_ick = {
 	.name		= "wdt4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2069,7 +2074,7 @@ static struct clk wdt4_fck = {
 	.name		= "wdt4_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2078,7 +2083,7 @@ static struct clk wdt3_ick = {
 	.name		= "wdt3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2087,7 +2092,7 @@ static struct clk wdt3_fck = {
 	.name		= "wdt3_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2096,7 +2101,7 @@ static struct clk mspro_ick = {
 	.name		= "mspro_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2105,7 +2110,7 @@ static struct clk mspro_fck = {
 	.name		= "mspro_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2114,7 +2119,7 @@ static struct clk mmc_ick = {
 	.name		= "mmc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2123,7 +2128,7 @@ static struct clk mmc_fck = {
 	.name		= "mmc_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2132,7 +2137,7 @@ static struct clk fac_ick = {
 	.name		= "fac_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2141,7 +2146,7 @@ static struct clk fac_fck = {
 	.name		= "fac_fck",
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2150,7 +2155,7 @@ static struct clk eac_ick = {
 	.name		= "eac_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2159,7 +2164,7 @@ static struct clk eac_fck = {
 	.name		= "eac_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2168,7 +2173,7 @@ static struct clk hdq_ick = {
 	.name		= "hdq_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2177,7 +2182,7 @@ static struct clk hdq_fck = {
 	.name		= "hdq_fck",
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2187,7 +2192,7 @@ static struct clk i2c2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2197,7 +2202,7 @@ static struct clk i2c2_fck = {
 	.id		= 2,
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2207,7 +2212,7 @@ static struct clk i2chs2_fck = {
 	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_I2CHS2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2217,7 +2222,7 @@ static struct clk i2c1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2227,7 +2232,7 @@ static struct clk i2c1_fck = {
 	.id		= 1,
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2237,7 +2242,7 @@ static struct clk i2chs1_fck = {
 	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_I2CHS1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2267,7 +2272,7 @@ static struct clk vlynq_ick = {
 	.name		= "vlynq_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2301,10 +2306,10 @@ static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_reg	= _CM_REG_OFFSET(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
 	.clksel		= vlynq_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -2316,7 +2321,7 @@ static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2325,7 +2330,7 @@ static struct clk des_ick = {
 	.name		= "des_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_DES_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2334,7 +2339,7 @@ static struct clk sha_ick = {
 	.name		= "sha_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_SHA_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2343,7 +2348,7 @@ static struct clk rng_ick = {
 	.name		= "rng_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_RNG_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2352,7 +2357,7 @@ static struct clk aes_ick = {
 	.name		= "aes_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_AES_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2361,7 +2366,7 @@ static struct clk pka_ick = {
 	.name		= "pka_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_PKA_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2370,7 +2375,7 @@ static struct clk usb_fck = {
 	.name		= "usb_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2379,7 +2384,7 @@ static struct clk usbhs_ick = {
 	.name		= "usbhs_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_USBHS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2389,7 +2394,7 @@ static struct clk mmchs1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2399,7 +2404,7 @@ static struct clk mmchs1_fck = {
 	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2409,7 +2414,7 @@ static struct clk mmchs2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2419,7 +2424,7 @@ static struct clk mmchs2_fck = {
 	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2428,7 +2433,7 @@ static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2437,7 +2442,7 @@ static struct clk gpio5_fck = {
 	.name		= "gpio5_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2446,7 +2451,7 @@ static struct clk mdm_intc_ick = {
 	.name		= "mdm_intc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MDM_INTC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2456,7 +2461,7 @@ static struct clk mmchsdb1_fck = {
 	.id		= 1,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHSDB1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2466,7 +2471,7 @@ static struct clk mmchsdb2_fck = {
 	.id		= 2,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHSDB2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 68e4971..da5e83a 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -16,11 +16,6 @@
 
 #include "prcm-common.h"
 
-#ifndef __ASSEMBLER__
-#define OMAP_CM_REGADDR(module, reg)					\
-	(__force void __iomem *)IO_ADDRESS(OMAP2_CM_BASE + (module) + (reg))
-#endif
-
 #define OMAP2420_CM_REGADDR(module, reg)				\
 			IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
 #define OMAP2430_CM_REGADDR(module, reg)				\
@@ -118,13 +113,7 @@ static __inline__ u32 __attribute__((unused)) cm_rmw_reg_bits(u32 mask,
 
 extern u32 cm_read_mod_reg(s16 module, u16 idx);
 extern void cm_write_mod_reg(u32 val, s16 module, u16 idx);
-
-/* Read-modify-write bits in a CM register (by domain) */
-static __inline__ u32 __attribute__((unused)) cm_rmw_mod_reg_bits(u32 mask,
-						u32 bits, s16 module, s16 idx)
-{
-	return cm_rmw_reg_bits(mask, bits, OMAP_CM_REGADDR(module, idx));
-}
+extern u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 
 static __inline__ u32 __attribute__((unused)) cm_set_mod_reg_bits(u32 bits,
 							s16 module, s16 idx)
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index ad17933..fd92a80 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -106,6 +106,20 @@ void cm_write_mod_reg(u32 val, s16 module, u16 idx)
 }
 EXPORT_SYMBOL(cm_write_mod_reg);
 
+/* Read-modify-write a register in a CM module. Caller must lock */
+u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+{
+	u32 v;
+
+	v = cm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= bits;
+	cm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+EXPORT_SYMBOL(cm_rmw_mod_reg_bits);
+
 void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 {
 	prm_base = omap2_globals->prm;
-- 
1.5.3.6

