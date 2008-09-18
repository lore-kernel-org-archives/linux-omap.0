From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 03/11] OMAP2 clock: add clk.prcm_mod field;
	annotate OMAP2xxx clocks
Date: Thu, 18 Sep 2008 11:47:00 -0600
Message-ID: <20080918174657.7146.762.stgit@localhost.localdomain>
References: <20080918174432.7146.21366.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55106 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbYIRRsI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 13:48:08 -0400
In-Reply-To: <20080918174432.7146.21366.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Add a "prcm_mod" field to the struct clk in OMAP2/3, and annotate each
OMAP2xxx real hardware clock controlled by the PRCM with the PRCM
module offset.  (A subsequent patch will annotate OMAP3 clocks.)

Add flags for this field that allow the registers to
be marked as existing in the PRM, CM, or System Control Module.

A subsequent patch will use this to simplify register addressing in the
struct clk.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.h         |  128 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/clock.h |    8 ++
 2 files changed, 136 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 775d08b..e4630e5 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -696,6 +696,7 @@ static struct dpll_data dpll_dd = {
 static struct clk dpll_ck = {
 	.name		= "dpll_ck",
 	.parent		= &sys_ck,		/* Can be func_32k also */
+	.prcm_mod	= PLL_MOD,
 	.dpll_data	= &dpll_dd,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | ALWAYS_ENABLED,
@@ -707,6 +708,7 @@ static struct clk dpll_ck = {
 static struct clk apll96_ck = {
 	.name		= "apll96_ck",
 	.parent		= &sys_ck,
+	.prcm_mod	= PLL_MOD,
 	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
@@ -721,6 +723,7 @@ static struct clk apll96_ck = {
 static struct clk apll54_ck = {
 	.name		= "apll54_ck",
 	.parent		= &sys_ck,
+	.prcm_mod	= PLL_MOD,
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
@@ -757,6 +760,7 @@ static const struct clksel func_54m_clksel[] = {
 static struct clk func_54m_ck = {
 	.name		= "func_54m_ck",
 	.parent		= &apll54_ck,	/* can also be alt_clk */
+	.prcm_mod	= PLL_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
@@ -797,6 +801,7 @@ static const struct clksel func_96m_clksel[] = {
 static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.parent		= &apll96_ck,
+	.prcm_mod	= PLL_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
@@ -830,6 +835,7 @@ static const struct clksel func_48m_clksel[] = {
 static struct clk func_48m_ck = {
 	.name		= "func_48m_ck",
 	.parent		= &apll96_ck,	 /* 96M or Alt */
+	.prcm_mod	= PLL_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "cm_clkdm" },
@@ -900,6 +906,7 @@ static const struct clksel common_clkout_src_clksel[] = {
 static struct clk sys_clkout_src = {
 	.name		= "sys_clkout_src",
 	.parent		= &func_54m_ck,
+	.prcm_mod	= OMAP24XX_GR_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | OFFSET_GR_MOD,
 	.clkdm		= { .name = "prm_clkdm" },
@@ -931,6 +938,7 @@ static const struct clksel sys_clkout_clksel[] = {
 static struct clk sys_clkout = {
 	.name		= "sys_clkout",
 	.parent		= &sys_clkout_src,
+	.prcm_mod	= OMAP24XX_GR_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				PARENT_CONTROLS_CLOCK | OFFSET_GR_MOD,
 	.clkdm		= { .name = "prm_clkdm" },
@@ -946,6 +954,7 @@ static struct clk sys_clkout = {
 static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
 	.parent		= &func_54m_ck,
+	.prcm_mod	= OMAP24XX_GR_MOD,
 	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES | OFFSET_GR_MOD,
 	.clkdm		= { .name = "cm_clkdm" },
 	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
@@ -968,6 +977,7 @@ static const struct clksel sys_clkout2_clksel[] = {
 static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
 	.parent		= &sys_clkout2_src,
+	.prcm_mod	= OMAP24XX_GR_MOD,
 	.flags		= CLOCK_IN_OMAP242X | PARENT_CONTROLS_CLOCK |
 				OFFSET_GR_MOD,
 	.clkdm		= { .name = "cm_clkdm" },
@@ -982,6 +992,7 @@ static struct clk sys_clkout2 = {
 static struct clk emul_ck = {
 	.name		= "emul_ck",
 	.parent		= &func_54m_ck,
+	.prcm_mod	= OMAP24XX_GR_MOD,
 	.flags		= CLOCK_IN_OMAP242X | OFFSET_GR_MOD,
 	.clkdm		= { .name = "cm_clkdm" },
 	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKEMUL_CTRL_OFFSET),
@@ -1017,6 +1028,7 @@ static const struct clksel mpu_clksel[] = {
 static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.parent		= &core_ck,
+	.prcm_mod	= MPU_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
@@ -1060,6 +1072,7 @@ static const struct clksel dsp_fck_clksel[] = {
 static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.parent		= &core_ck,
+	.prcm_mod	= OMAP24XX_DSP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.clkdm		= { .name = "dsp_clkdm" },
@@ -1090,6 +1103,7 @@ static const struct clksel dsp_irate_ick_clksel[] = {
 static struct clk dsp_irate_ick = {
 	.name		= "dsp_irate_ick",
 	.parent		= &dsp_fck,
+	.prcm_mod	= OMAP24XX_DSP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
 				CONFIG_PARTICIPANT | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dsp_clkdm" },
@@ -1105,6 +1119,7 @@ static struct clk dsp_irate_ick = {
 static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.parent		= &dsp_irate_ick,
+	.prcm_mod	= OMAP24XX_DSP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm		= { .name = "dsp_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_ICLKEN),
@@ -1115,6 +1130,7 @@ static struct clk dsp_ick = {
 static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.parent		= &dsp_irate_ick,
+	.prcm_mod	= OMAP24XX_DSP_MOD,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm		= { .name = "dsp_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_FCLKEN),
@@ -1129,6 +1145,7 @@ static struct clk iva2_1_ick = {
 static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.parent		= &core_ck,
+	.prcm_mod	= OMAP24XX_DSP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT |
 				RATE_PROPAGATES | DELAYED_APP,
 	.clkdm		= { .name = "iva1_clkdm" },
@@ -1146,6 +1163,7 @@ static struct clk iva1_ifck = {
 static struct clk iva1_mpu_int_ifck = {
 	.name		= "iva1_mpu_int_ifck",
 	.parent		= &iva1_ifck,
+	.prcm_mod	= OMAP24XX_DSP_MOD,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "iva1_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_FCLKEN),
@@ -1192,6 +1210,7 @@ static const struct clksel core_l3_clksel[] = {
 static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.parent		= &core_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
@@ -1221,6 +1240,7 @@ static const struct clksel usb_l4_ick_clksel[] = {
 static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.name		= "usb_l4_ick",
 	.parent		= &core_l3_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm		= { .name = "core_l4_clkdm" },
@@ -1255,6 +1275,7 @@ static const struct clksel l4_clksel[] = {
 static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
 	.parent		= &core_l3_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | DELAYED_APP | RATE_PROPAGATES,
 	.clkdm		= { .name = "core_l4_clkdm" },
@@ -1293,6 +1314,7 @@ static const struct clksel ssi_ssr_sst_fck_clksel[] = {
 static struct clk ssi_ssr_sst_fck = {
 	.name		= "ssi_fck",
 	.parent		= &core_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
 	.clkdm		= { .name = "core_l3_clkdm" },
@@ -1313,6 +1335,7 @@ static struct clk ssi_ssr_sst_fck = {
 static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -1343,6 +1366,7 @@ static const struct clksel gfx_fck_clksel[] = {
 static struct clk gfx_3d_fck = {
 	.name		= "gfx_3d_fck",
 	.parent		= &core_l3_ck,
+	.prcm_mod	= GFX_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "gfx_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(GFX_MOD, CM_FCLKEN),
@@ -1358,6 +1382,7 @@ static struct clk gfx_3d_fck = {
 static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
 	.parent		= &core_l3_ck,
+	.prcm_mod	= GFX_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "gfx_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(GFX_MOD, CM_FCLKEN),
@@ -1373,6 +1398,7 @@ static struct clk gfx_2d_fck = {
 static struct clk gfx_ick = {
 	.name		= "gfx_ick",		/* From l3 */
 	.parent		= &core_l3_ck,
+	.prcm_mod	= GFX_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "gfx_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(GFX_MOD, CM_ICLKEN),
@@ -1403,6 +1429,7 @@ static const struct clksel mdm_ick_clksel[] = {
 static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
 	.parent		= &core_ck,
+	.prcm_mod	= OMAP2430_MDM_MOD,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm		= { .name = "mdm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(OMAP2430_MDM_MOD, CM_ICLKEN),
@@ -1418,6 +1445,7 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 static struct clk mdm_osc_ck = {
 	.name		= "mdm_osc_ck",
 	.parent		= &osc_ck,
+	.prcm_mod	= OMAP2430_MDM_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "mdm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(OMAP2430_MDM_MOD, CM_FCLKEN),
@@ -1463,6 +1491,7 @@ static const struct clksel dss1_fck_clksel[] = {
 static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.name		= "dss_ick",
 	.parent		= &l4_ck,	/* really both l3 and l4 */
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "dss_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1473,6 +1502,7 @@ static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 static struct clk dss1_fck = {
 	.name		= "dss1_fck",
 	.parent		= &core_ck,		/* Core or sys */
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
 	.clkdm		= { .name = "dss_clkdm" },
@@ -1506,6 +1536,7 @@ static const struct clksel dss2_fck_clksel[] = {
 static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.name		= "dss2_fck",
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
 	.clkdm		= { .name = "dss_clkdm" },
@@ -1521,6 +1552,7 @@ static struct clk dss2_fck = {		/* Alt clk used in power management */
 static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.name		= "dss_54m_fck",	/* 54m tv clk */
 	.parent		= &func_54m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "dss_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1549,6 +1581,7 @@ static const struct clksel omap24xx_gpt_clksel[] = {
 static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
@@ -1559,6 +1592,7 @@ static struct clk gpt1_ick = {
 static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_FCLKEN),
@@ -1575,6 +1609,7 @@ static struct clk gpt1_fck = {
 static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1585,6 +1620,7 @@ static struct clk gpt2_ick = {
 static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1599,6 +1635,7 @@ static struct clk gpt2_fck = {
 static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1609,6 +1646,7 @@ static struct clk gpt3_ick = {
 static struct clk gpt3_fck = {
 	.name		= "gpt3_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1623,6 +1661,7 @@ static struct clk gpt3_fck = {
 static struct clk gpt4_ick = {
 	.name		= "gpt4_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1633,6 +1672,7 @@ static struct clk gpt4_ick = {
 static struct clk gpt4_fck = {
 	.name		= "gpt4_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1647,6 +1687,7 @@ static struct clk gpt4_fck = {
 static struct clk gpt5_ick = {
 	.name		= "gpt5_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1657,6 +1698,7 @@ static struct clk gpt5_ick = {
 static struct clk gpt5_fck = {
 	.name		= "gpt5_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1671,6 +1713,7 @@ static struct clk gpt5_fck = {
 static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1681,6 +1724,7 @@ static struct clk gpt6_ick = {
 static struct clk gpt6_fck = {
 	.name		= "gpt6_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1695,6 +1739,7 @@ static struct clk gpt6_fck = {
 static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1705,6 +1750,7 @@ static struct clk gpt7_ick = {
 static struct clk gpt7_fck = {
 	.name		= "gpt7_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1719,6 +1765,7 @@ static struct clk gpt7_fck = {
 static struct clk gpt8_ick = {
 	.name		= "gpt8_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1729,6 +1776,7 @@ static struct clk gpt8_ick = {
 static struct clk gpt8_fck = {
 	.name		= "gpt8_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1743,6 +1791,7 @@ static struct clk gpt8_fck = {
 static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1753,6 +1802,7 @@ static struct clk gpt9_ick = {
 static struct clk gpt9_fck = {
 	.name		= "gpt9_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1767,6 +1817,7 @@ static struct clk gpt9_fck = {
 static struct clk gpt10_ick = {
 	.name		= "gpt10_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1777,6 +1828,7 @@ static struct clk gpt10_ick = {
 static struct clk gpt10_fck = {
 	.name		= "gpt10_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1791,6 +1843,7 @@ static struct clk gpt10_fck = {
 static struct clk gpt11_ick = {
 	.name		= "gpt11_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1801,6 +1854,7 @@ static struct clk gpt11_ick = {
 static struct clk gpt11_fck = {
 	.name		= "gpt11_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1815,6 +1869,7 @@ static struct clk gpt11_fck = {
 static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1825,6 +1880,7 @@ static struct clk gpt12_ick = {
 static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1840,6 +1896,7 @@ static struct clk mcbsp1_ick = {
 	.name		= "mcbsp_ick",
 	.id		= 1,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1851,6 +1908,7 @@ static struct clk mcbsp1_fck = {
 	.name		= "mcbsp_fck",
 	.id		= 1,
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1862,6 +1920,7 @@ static struct clk mcbsp2_ick = {
 	.name		= "mcbsp_ick",
 	.id		= 2,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1873,6 +1932,7 @@ static struct clk mcbsp2_fck = {
 	.name		= "mcbsp_fck",
 	.id		= 2,
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1884,6 +1944,7 @@ static struct clk mcbsp3_ick = {
 	.name		= "mcbsp_ick",
 	.id		= 3,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -1895,6 +1956,7 @@ static struct clk mcbsp3_fck = {
 	.name		= "mcbsp_fck",
 	.id		= 3,
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1906,6 +1968,7 @@ static struct clk mcbsp4_ick = {
 	.name		= "mcbsp_ick",
 	.id		= 4,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -1917,6 +1980,7 @@ static struct clk mcbsp4_fck = {
 	.name		= "mcbsp_fck",
 	.id		= 4,
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1928,6 +1992,7 @@ static struct clk mcbsp5_ick = {
 	.name		= "mcbsp_ick",
 	.id		= 5,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -1939,6 +2004,7 @@ static struct clk mcbsp5_fck = {
 	.name		= "mcbsp_fck",
 	.id		= 5,
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1950,6 +2016,7 @@ static struct clk mcspi1_ick = {
 	.name		= "mcspi_ick",
 	.id		= 1,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1961,6 +2028,7 @@ static struct clk mcspi1_fck = {
 	.name		= "mcspi_fck",
 	.id		= 1,
 	.parent		= &func_48m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1972,6 +2040,7 @@ static struct clk mcspi2_ick = {
 	.name		= "mcspi_ick",
 	.id		= 2,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -1983,6 +2052,7 @@ static struct clk mcspi2_fck = {
 	.name		= "mcspi_fck",
 	.id		= 2,
 	.parent		= &func_48m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -1994,6 +2064,7 @@ static struct clk mcspi3_ick = {
 	.name		= "mcspi_ick",
 	.id		= 3,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -2005,6 +2076,7 @@ static struct clk mcspi3_fck = {
 	.name		= "mcspi_fck",
 	.id		= 3,
 	.parent		= &func_48m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2015,6 +2087,7 @@ static struct clk mcspi3_fck = {
 static struct clk uart1_ick = {
 	.name		= "uart1_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2025,6 +2098,7 @@ static struct clk uart1_ick = {
 static struct clk uart1_fck = {
 	.name		= "uart1_fck",
 	.parent		= &func_48m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2035,6 +2109,7 @@ static struct clk uart1_fck = {
 static struct clk uart2_ick = {
 	.name		= "uart2_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2045,6 +2120,7 @@ static struct clk uart2_ick = {
 static struct clk uart2_fck = {
 	.name		= "uart2_fck",
 	.parent		= &func_48m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2055,6 +2131,7 @@ static struct clk uart2_fck = {
 static struct clk uart3_ick = {
 	.name		= "uart3_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -2065,6 +2142,7 @@ static struct clk uart3_ick = {
 static struct clk uart3_fck = {
 	.name		= "uart3_fck",
 	.parent		= &func_48m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2075,6 +2153,7 @@ static struct clk uart3_fck = {
 static struct clk gpios_ick = {
 	.name		= "gpios_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
@@ -2085,6 +2164,7 @@ static struct clk gpios_ick = {
 static struct clk gpios_fck = {
 	.name		= "gpios_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_FCLKEN),
@@ -2096,6 +2176,7 @@ static struct clk gpios_fck = {
 static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
@@ -2107,6 +2188,7 @@ static struct clk mpu_wdt_ick = {
 static struct clk mpu_wdt_fck = {
 	.name		= "mpu_wdt_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_FCLKEN),
@@ -2117,6 +2199,7 @@ static struct clk mpu_wdt_fck = {
 static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ENABLE_ON_INIT,
 	.clkdm		= { .name = "core_l4_clkdm" },
@@ -2129,6 +2212,7 @@ static struct clk sync_32k_ick = {
 static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
@@ -2139,6 +2223,7 @@ static struct clk wdt1_ick = {
 static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ENABLE_ON_INIT,
 	.clkdm		= { .name = "core_l4_clkdm" },
@@ -2150,6 +2235,7 @@ static struct clk omapctrl_ick = {
 static struct clk icr_ick = {
 	.name		= "icr_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
@@ -2160,6 +2246,7 @@ static struct clk icr_ick = {
 static struct clk cam_ick = {
 	.name		= "cam_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2175,6 +2262,7 @@ static struct clk cam_ick = {
 static struct clk cam_fck = {
 	.name		= "cam_fck",
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2185,6 +2273,7 @@ static struct clk cam_fck = {
 static struct clk mailboxes_ick = {
 	.name		= "mailboxes_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2195,6 +2284,7 @@ static struct clk mailboxes_ick = {
 static struct clk wdt4_ick = {
 	.name		= "wdt4_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2205,6 +2295,7 @@ static struct clk wdt4_ick = {
 static struct clk wdt4_fck = {
 	.name		= "wdt4_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2215,6 +2306,7 @@ static struct clk wdt4_fck = {
 static struct clk wdt3_ick = {
 	.name		= "wdt3_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2225,6 +2317,7 @@ static struct clk wdt3_ick = {
 static struct clk wdt3_fck = {
 	.name		= "wdt3_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2235,6 +2328,7 @@ static struct clk wdt3_fck = {
 static struct clk mspro_ick = {
 	.name		= "mspro_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2245,6 +2339,7 @@ static struct clk mspro_ick = {
 static struct clk mspro_fck = {
 	.name		= "mspro_fck",
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2255,6 +2350,7 @@ static struct clk mspro_fck = {
 static struct clk mmc_ick = {
 	.name		= "mmc_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2265,6 +2361,7 @@ static struct clk mmc_ick = {
 static struct clk mmc_fck = {
 	.name		= "mmc_fck",
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2275,6 +2372,7 @@ static struct clk mmc_fck = {
 static struct clk fac_ick = {
 	.name		= "fac_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2285,6 +2383,7 @@ static struct clk fac_ick = {
 static struct clk fac_fck = {
 	.name		= "fac_fck",
 	.parent		= &func_12m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2295,6 +2394,7 @@ static struct clk fac_fck = {
 static struct clk eac_ick = {
 	.name		= "eac_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2305,6 +2405,7 @@ static struct clk eac_ick = {
 static struct clk eac_fck = {
 	.name		= "eac_fck",
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2315,6 +2416,7 @@ static struct clk eac_fck = {
 static struct clk hdq_ick = {
 	.name		= "hdq_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2325,6 +2427,7 @@ static struct clk hdq_ick = {
 static struct clk hdq_fck = {
 	.name		= "hdq_fck",
 	.parent		= &func_12m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2336,6 +2439,7 @@ static struct clk i2c2_ick = {
 	.name		= "i2c_ick",
 	.id		= 2,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2347,6 +2451,7 @@ static struct clk i2c2_fck = {
 	.name		= "i2c_fck",
 	.id		= 2,
 	.parent		= &func_12m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2358,6 +2463,7 @@ static struct clk i2chs2_fck = {
 	.name		= "i2chs_fck",
 	.id		= 2,
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2369,6 +2475,7 @@ static struct clk i2c1_ick = {
 	.name		= "i2c_ick",
 	.id		= 1,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2380,6 +2487,7 @@ static struct clk i2c1_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
 	.parent		= &func_12m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2391,6 +2499,7 @@ static struct clk i2chs1_fck = {
 	.name		= "i2chs_fck",
 	.id		= 1,
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2426,6 +2535,7 @@ static struct clk sdma_ick = {
 static struct clk vlynq_ick = {
 	.name		= "vlynq_ick",
 	.parent		= &core_l3_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
@@ -2461,6 +2571,7 @@ static const struct clksel vlynq_fck_clksel[] = {
 static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_FCLKEN1),
@@ -2477,6 +2588,7 @@ static struct clk vlynq_fck = {
 static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN3),
@@ -2487,6 +2599,7 @@ static struct clk sdrc_ick = {
 static struct clk des_ick = {
 	.name		= "des_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_ICLKEN4),
@@ -2497,6 +2610,7 @@ static struct clk des_ick = {
 static struct clk sha_ick = {
 	.name		= "sha_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_ICLKEN4),
@@ -2507,6 +2621,7 @@ static struct clk sha_ick = {
 static struct clk rng_ick = {
 	.name		= "rng_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_ICLKEN4),
@@ -2517,6 +2632,7 @@ static struct clk rng_ick = {
 static struct clk aes_ick = {
 	.name		= "aes_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_ICLKEN4),
@@ -2527,6 +2643,7 @@ static struct clk aes_ick = {
 static struct clk pka_ick = {
 	.name		= "pka_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_ICLKEN4),
@@ -2537,6 +2654,7 @@ static struct clk pka_ick = {
 static struct clk usb_fck = {
 	.name		= "usb_fck",
 	.parent		= &func_48m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2547,6 +2665,7 @@ static struct clk usb_fck = {
 static struct clk usbhs_ick = {
 	.name		= "usbhs_ick",
 	.parent		= &core_l3_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -2558,6 +2677,7 @@ static struct clk mmchs1_ick = {
 	.name		= "mmchs_ick",
 	.id		= 1,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -2569,6 +2689,7 @@ static struct clk mmchs1_fck = {
 	.name		= "mmchs_fck",
 	.id		= 1,
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2580,6 +2701,7 @@ static struct clk mmchs2_ick = {
 	.name		= "mmchs_ick",
 	.id		= 2,
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -2591,6 +2713,7 @@ static struct clk mmchs2_fck = {
 	.name		= "mmchs_fck",
 	.id		= 2,
 	.parent		= &func_96m_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2601,6 +2724,7 @@ static struct clk mmchs2_fck = {
 static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -2611,6 +2735,7 @@ static struct clk gpio5_ick = {
 static struct clk gpio5_fck = {
 	.name		= "gpio5_fck",
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2621,6 +2746,7 @@ static struct clk gpio5_fck = {
 static struct clk mdm_intc_ick = {
 	.name		= "mdm_intc_ick",
 	.parent		= &l4_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN2),
@@ -2632,6 +2758,7 @@ static struct clk mmchsdb1_fck = {
 	.name		= "mmchsdb_fck",
 	.id		= 1,
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2643,6 +2770,7 @@ static struct clk mmchsdb2_fck = {
 	.name		= "mmchsdb_fck",
 	.id		= 2,
 	.parent		= &func_32k_ck,
+	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 0fb4271..c428cdf 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -86,6 +86,7 @@ struct clk {
 		const char		*name;
 		struct clockdomain	*ptr;
 	} clkdm;
+	s16			prcm_mod;
 #else
 	__u8			rate_offset;
 	__u8			src_offset;
@@ -164,6 +165,13 @@ extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 
+/*
+ * clk.prcm_mod flags (possible since only the top byte in clk.prcm_mod
+ * is significant)
+ */
+#define PRCM_MOD_ADDR_MASK	0xff00
+#define CLK_REG_IN_PRM		(1 << 0)
+#define CLK_REG_IN_SCM		(1 << 1)
 
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC options (24XX) */
 #define CORE_CLK_SRC_32K		0


