From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 16/28] omap2 clock: remove all {src,
	rate}_offset fields from struct clk
Date: Mon, 20 Aug 2007 03:54:03 -0600
Message-ID: <20070820095531.535470729@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=nuke_src_and_rate_offset.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

src_offset and rate_offset are no longer used in OMAP2 clock framework
after the struct clksel/struct clksel_rate additions.  Remove these
fields from clock.h and #ifdef out those fields for OMAP24XX compiles.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |    4 ++--
 arch/arm/mach-omap2/clock.h       |   38 +-------------------------------------
 include/asm-arm/arch-omap/clock.h |    5 +++--
 3 files changed, 6 insertions(+), 41 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -121,7 +121,7 @@ static void omap2_sys_clk_recalc(struct 
 		div = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
 		/* Test if ext clk divided by 1 or 2 */
 		div &= OMAP_SYSCLKDIV_MASK;
-		div >>= clk->rate_offset;
+		div >>= OMAP_SYSCLKDIV_SHIFT;
 		clk->rate = (clk->parent->rate / div);
 	}
 	propagate_rate(clk);
@@ -1032,7 +1032,7 @@ static void __init omap2_get_crystal_rat
 
 	div = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
 	div &= OMAP_SYSCLKDIV_MASK;
-	div >>= sys->rate_offset;
+	div >>= OMAP_SYSCLKDIV_SHIFT;
 
 	osc->rate = sclk * div;
 	sys->rate = sclk;
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -11,7 +11,7 @@
  *
  *  Copyright (C) 2007 Texas Instruments, Inc.
  *  Copyright (C) 2007 Nokia Corporation
- *  Revised by Paul Walmsley
+ *  Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -615,7 +615,6 @@ static struct clk sys_ck = {		/* (*12, *
 	.rate		= 13000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.rate_offset	= OMAP_SYSCLKDIV_SHIFT, /* sysclkdiv 1 or 2, already handled or no boot */
 	.recalc		= &omap2_sys_clk_recalc,
 };
 
@@ -694,7 +693,6 @@ static struct clk func_54m_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_PLL_SEL1 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
-	.src_offset	= OMAP24XX_54M_SOURCE_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_54M_SOURCE,
@@ -764,7 +762,6 @@ static struct clk func_48m_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_PLL_SEL1 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
-	.src_offset	= OMAP24XX_48M_SOURCE_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_48M_SOURCE,
@@ -831,7 +828,6 @@ static struct clk sys_clkout_src = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
 				RATE_PROPAGATES,
-	.src_offset	= OMAP24XX_CLKOUT_SOURCE_SHIFT,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -864,7 +860,6 @@ static struct clk sys_clkout = {
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
-	.rate_offset	= OMAP24XX_CLKOUT_DIV_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -872,7 +867,6 @@ static struct clk sys_clkout = {
 static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
 	.parent		= &func_54m_ck,
-	.src_offset	= OMAP2420_CLKOUT2_SOURCE_SHIFT,
 	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
 				RATE_PROPAGATES,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
@@ -898,7 +892,6 @@ static struct clk sys_clkout2 = {
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
-	.rate_offset	= OMAP2420_CLKOUT2_DIV_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -942,7 +935,6 @@ static struct clk mpu_ck = {	/* Control 
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL |
 				ALWAYS_ENABLED | CM_MPU_SEL1 | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.rate_offset	= OMAP24XX_CLKSEL_MPU_SHIFT,	/* bits 0-4 */
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
@@ -983,7 +975,6 @@ static struct clk iva2_1_fck = {
 	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
 				DELAYED_APP | RATE_PROPAGATES |
 				CONFIG_PARTICIPANT,
-	.rate_offset	= OMAP24XX_CLKSEL_DSP_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
@@ -1010,7 +1001,6 @@ static struct clk iva2_1_ick = {
 	.parent		= &iva2_1_fck,
 	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= OMAP24XX_CLKSEL_DSP_IF_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= iva2_1_ick_clksel,
@@ -1044,7 +1034,6 @@ static struct clk dsp_fck = {
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
 			DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.rate_offset	= OMAP24XX_CLKSEL_DSP_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
@@ -1070,7 +1059,6 @@ static struct clk dsp_ick = {
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= OMAP24XX_CLKSEL_DSP_IF_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,		/* for ipi */
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
@@ -1100,7 +1088,6 @@ static struct clk iva1_ifck = {
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 | RATE_CKCTL |
 			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
-	.rate_offset	= OMAP2420_CLKSEL_IVA_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
@@ -1162,7 +1149,6 @@ static struct clk core_l3_ck = {	/* Used
 				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT |
 				RATE_PROPAGATES,
-	.rate_offset	= OMAP24XX_CLKSEL_L3_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
 	.clksel		= core_l3_clksel,
@@ -1190,7 +1176,6 @@ static struct clk usb_l4_ick = {	/* FS-U
 				CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
-	.rate_offset	= OMAP24XX_CLKSEL_USB_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
 	.clksel		= usb_l4_ick_clksel,
@@ -1231,7 +1216,6 @@ static struct clk ssi_ssr_sst_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_sst_fck_clksel,
-	.rate_offset	= OMAP24XX_CLKSEL_SSI_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1272,7 +1256,6 @@ static struct clk gfx_3d_fck = {
 				RATE_CKCTL | CM_GFX_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
-	.rate_offset	= OMAP_CLKSEL_GFX_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_fck_clksel,
@@ -1286,7 +1269,6 @@ static struct clk gfx_2d_fck = {
 				RATE_CKCTL | CM_GFX_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
-	.rate_offset	= OMAP_CLKSEL_GFX_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_fck_clksel,
@@ -1327,7 +1309,6 @@ static struct clk mdm_ick = {		/* used b
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_MODEM_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= OMAP2430_CLKSEL_MDM_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL),
@@ -1369,7 +1350,6 @@ static struct clk l4_ck = {		/* used bot
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
 				DELAYED_APP | RATE_PROPAGATES,
-	.rate_offset	= OMAP24XX_CLKSEL_L4_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
 	.clksel		= l4_clksel,
@@ -1436,8 +1416,6 @@ static struct clk dss1_fck = {
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
-	.rate_offset	= OMAP24XX_CLKSEL_DSS1_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_DSS1_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS1_MASK,
@@ -1468,7 +1446,6 @@ static struct clk dss2_fck = {		/* Alt c
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_DSS2_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS2_MASK,
@@ -1529,7 +1506,6 @@ static struct clk gpt1_fck = {
 				CM_WKUP_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),	/* Bit0 */
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT1_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
@@ -1553,7 +1529,6 @@ static struct clk gpt2_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT2_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT2_MASK,
@@ -1577,7 +1552,6 @@ static struct clk gpt3_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT3_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT3_MASK,
@@ -1601,7 +1575,6 @@ static struct clk gpt4_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT4_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT4_MASK,
@@ -1625,7 +1598,6 @@ static struct clk gpt5_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT5_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT5_MASK,
@@ -1649,7 +1621,6 @@ static struct clk gpt6_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT6_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT6_MASK,
@@ -1673,7 +1644,6 @@ static struct clk gpt7_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT7_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT7_MASK,
@@ -1697,7 +1667,6 @@ static struct clk gpt8_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT8_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT8_MASK,
@@ -1721,7 +1690,6 @@ static struct clk gpt9_fck = {
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT9_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT9_MASK,
@@ -1745,7 +1713,6 @@ static struct clk gpt10_fck = {
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT10_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT10_MASK,
@@ -1769,7 +1736,6 @@ static struct clk gpt11_fck = {
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT11_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT11_MASK,
@@ -1793,7 +1759,6 @@ static struct clk gpt12_fck = {
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
-	.src_offset	= OMAP24XX_CLKSEL_GPT12_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT12_MASK,
@@ -2327,7 +2292,6 @@ static struct clk vlynq_fck = {
 	.flags		= CLOCK_IN_OMAP242X  | RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
-	.src_offset	= OMAP2420_CLKSEL_VLYNQ_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h
+++ linux-omap/include/asm-arm/arch-omap/clock.h
@@ -41,8 +41,6 @@ struct clk {
 	__u32			flags;
 	void __iomem		*enable_reg;
 	__u8			enable_bit;
-	__u8			rate_offset;
-	__u8			src_offset;
 	__s8			usecount;
 	void			(*recalc)(struct clk *);
 	int			(*set_rate)(struct clk *, unsigned long);
@@ -55,6 +53,9 @@ struct clk {
 	void __iomem		*clksel_reg;
 	u32			clksel_mask;
 	const struct clksel	*clksel;
+#else
+	__u8			rate_offset;
+	__u8			src_offset;
 #endif
 };
 

-- 
