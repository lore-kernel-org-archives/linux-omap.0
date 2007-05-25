From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 14/18] omap2: convert clock.h to use symbolic register
	defines
Date: Fri, 25 May 2007 02:23:36 -0600
Message-ID: <20070525082502.467532857@pwsan.com>
References: <20070525082322.168056647@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0014-omap2-convert-clock.h-to-use-symbolic-register-defi.patch
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

Convert the symbolic constants in the enable_reg member of the struct
clk definitions in clock.h to use the new-style register defines from
{prm,cm}.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.h |  247 ++++++++++++++++++++++---------------------
 1 files changed, 125 insertions(+), 122 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index ba26e16..e6616b9 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -17,6 +17,9 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK_H
 
+#include "prm.h"
+#include "cm.h"
+
 static void omap2_sys_clk_recalc(struct clk * clk);
 static void omap2_clksel_recalc(struct clk * clk);
 static void omap2_followparent_recalc(struct clk * clk);
@@ -639,7 +642,7 @@ static struct clk apll96_ck = {
 	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X |CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= 0x2,
 	.recalc		= &omap2_propagate_rate,
 };
@@ -650,7 +653,7 @@ static struct clk apll54_ck = {
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= 0x6,
 	.recalc		= &omap2_propagate_rate,
 };
@@ -665,7 +668,7 @@ static struct clk func_54m_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
 	.src_offset	= 5,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_propagate_rate,
 };
@@ -692,7 +695,7 @@ static struct clk func_96m_ck = {
 	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_propagate_rate,
 };
@@ -704,7 +707,7 @@ static struct clk func_48m_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
 	.src_offset	= 3,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_propagate_rate,
 };
@@ -716,7 +719,7 @@ static struct clk func_12m_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &omap2_propagate_rate,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= PARENT_CONTROLS_CLOCK,
 };
 
@@ -735,7 +738,7 @@ static struct clk sys_clkout = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
 	.src_offset	= 0,
-	.enable_reg	= (void __iomem *)&PRCM_CLKOUT_CTRL,
+	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= 7,
 	.rate_offset	= 3,
 	.recalc		= &omap2_clksel_recalc,
@@ -749,7 +752,7 @@ static struct clk sys_clkout2 = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
 	.src_offset	= 8,
-	.enable_reg	= (void __iomem *)&PRCM_CLKOUT_CTRL,
+	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= 15,
 	.rate_offset	= 11,
 	.recalc		= &omap2_clksel_recalc,
@@ -759,7 +762,7 @@ static struct clk emul_ck = {
 	.name		= "emul_ck",
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&PRCM_CLKEMUL_CTRL,
+	.enable_reg	= OMAP24XX_PRCM_CLKEMUL_CTRL,
 	.enable_bit	= 0,
 	.recalc		= &omap2_propagate_rate,
 
@@ -798,7 +801,7 @@ static struct clk iva2_1_fck = {
 				DELAYED_APP | RATE_PROPAGATES |
 				CONFIG_PARTICIPANT,
 	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= 0,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -824,7 +827,7 @@ static struct clk dsp_fck = {
 	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
 			DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= 0,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -835,7 +838,7 @@ static struct clk dsp_ick = {
 	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
 	.rate_offset	= 5,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_DSP,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= 1,		/* for ipi */
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -846,7 +849,7 @@ static struct clk iva1_ifck = {
 	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 | RATE_CKCTL |
 			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
 	.rate_offset	= 8,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= 10,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -856,7 +859,7 @@ static struct clk iva1_mpu_int_ifck = {
 	.name		= "iva1_mpu_int_ifck",
 	.parent		= &iva1_ifck,
 	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= 8,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -897,7 +900,7 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP |
 				CONFIG_PARTICIPANT,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 0,
 	.rate_offset	= 25,
 	.recalc		= &omap2_clksel_recalc,
@@ -916,7 +919,7 @@ static struct clk ssi_ssr_sst_fck = {
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,	/* bit 1 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),	/* bit 1 */
 	.enable_bit	= 1,
 	.rate_offset	= 20,
 	.recalc		= &omap2_clksel_recalc,
@@ -938,7 +941,7 @@ static struct clk gfx_3d_fck = {
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | CM_GFX_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= 2,
 	.rate_offset	= 0,
 	.recalc		= &omap2_clksel_recalc,
@@ -949,7 +952,7 @@ static struct clk gfx_2d_fck = {
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | CM_GFX_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= 1,
 	.rate_offset	= 0,
 	.recalc		= &omap2_clksel_recalc,
@@ -960,7 +963,7 @@ static struct clk gfx_ick = {
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_GFX,	/* bit 0 */
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),	/* bit 0 */
 	.enable_bit	= 0,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -977,7 +980,7 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_MODEM_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
 	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_MDM,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
 	.enable_bit	= 0,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -987,7 +990,7 @@ static struct clk mdm_osc_ck = {
 	.rate		= 26000000,
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP243X | RATE_FIXED,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_MDM,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= 1,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1013,7 +1016,7 @@ static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,	/* bit 1 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),	/* bit 1 */
 	.enable_bit	= 1,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1030,7 +1033,7 @@ static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.name		= "dss_ick",
 	.parent		= &l4_ck,	/* really both l3 and l4 */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 0,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1040,7 +1043,7 @@ static struct clk dss1_fck = {
 	.parent		= &core_ck,		/* Core or sys */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 0,
 	.rate_offset	= 8,
 	.src_offset	= 8,
@@ -1053,7 +1056,7 @@ static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | CM_CORE_SEL1 | RATE_FIXED |
 				DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 1,
 	.src_offset	= 13,
 	.recalc		= &omap2_followparent_recalc,
@@ -1065,7 +1068,7 @@ static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 2,
 	.recalc		= &omap2_propagate_rate,
 };
@@ -1080,7 +1083,7 @@ static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,	/* Bit0 */
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),	/* Bit0 */
 	.enable_bit	= 0,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1090,7 +1093,7 @@ static struct clk gpt1_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_WKUP_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,	/* Bit0 */
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),	/* Bit0 */
 	.enable_bit	= 0,
 	.src_offset	= 0,
 	.recalc		= &omap2_followparent_recalc,
@@ -1100,7 +1103,7 @@ static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit4 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit4 */
 	.enable_bit	= 4,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1110,7 +1113,7 @@ static struct clk gpt2_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 4,
 	.src_offset	= 2,
 	.recalc		= &omap2_followparent_recalc,
@@ -1120,7 +1123,7 @@ static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit5 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit5 */
 	.enable_bit	= 5,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1130,7 +1133,7 @@ static struct clk gpt3_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 5,
 	.src_offset	= 4,
 	.recalc		= &omap2_followparent_recalc,
@@ -1140,7 +1143,7 @@ static struct clk gpt4_ick = {
 	.name		= "gpt4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit6 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit6 */
 	.enable_bit	= 6,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1150,7 +1153,7 @@ static struct clk gpt4_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 6,
 	.src_offset	= 6,
 	.recalc		= &omap2_followparent_recalc,
@@ -1160,7 +1163,7 @@ static struct clk gpt5_ick = {
 	.name		= "gpt5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* Bit7 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* Bit7 */
 	.enable_bit	= 7,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1170,7 +1173,7 @@ static struct clk gpt5_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 7,
 	.src_offset	= 8,
 	.recalc		= &omap2_followparent_recalc,
@@ -1181,7 +1184,7 @@ static struct clk gpt6_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_bit	= 8,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit8 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit8 */
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1190,7 +1193,7 @@ static struct clk gpt6_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 8,
 	.src_offset	= 10,
 	.recalc		= &omap2_followparent_recalc,
@@ -1200,7 +1203,7 @@ static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit9 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit9 */
 	.enable_bit	= 9,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1210,7 +1213,7 @@ static struct clk gpt7_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 9,
 	.src_offset	= 12,
 	.recalc		= &omap2_followparent_recalc,
@@ -1220,7 +1223,7 @@ static struct clk gpt8_ick = {
 	.name		= "gpt8_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit10 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit10 */
 	.enable_bit	= 10,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1230,7 +1233,7 @@ static struct clk gpt8_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 10,
 	.src_offset	= 14,
 	.recalc		= &omap2_followparent_recalc,
@@ -1240,7 +1243,7 @@ static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 11,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1250,7 +1253,7 @@ static struct clk gpt9_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 11,
 	.src_offset	= 16,
 	.recalc		= &omap2_followparent_recalc,
@@ -1260,7 +1263,7 @@ static struct clk gpt10_ick = {
 	.name		= "gpt10_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 12,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1270,7 +1273,7 @@ static struct clk gpt10_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 12,
 	.src_offset	= 18,
 	.recalc		= &omap2_followparent_recalc,
@@ -1280,7 +1283,7 @@ static struct clk gpt11_ick = {
 	.name		= "gpt11_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 13,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1290,7 +1293,7 @@ static struct clk gpt11_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 13,
 	.src_offset	= 20,
 	.recalc		= &omap2_followparent_recalc,
@@ -1300,7 +1303,7 @@ static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit14 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit14 */
 	.enable_bit	= 14,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1310,7 +1313,7 @@ static struct clk gpt12_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 14,
 	.src_offset	= 22,
 	.recalc		= &omap2_followparent_recalc,
@@ -1320,7 +1323,7 @@ static struct clk mcbsp1_ick = {
 	.name		= "mcbsp1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit16 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit16 */
 	.enable_bit	= 15,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1329,7 +1332,7 @@ static struct clk mcbsp1_fck = {
 	.name		= "mcbsp1_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 15,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1338,7 +1341,7 @@ static struct clk mcbsp2_ick = {
 	.name		= "mcbsp2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 16,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1347,7 +1350,7 @@ static struct clk mcbsp2_fck = {
 	.name		= "mcbsp2_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 16,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1356,7 +1359,7 @@ static struct clk mcbsp3_ick = {
 	.name		= "mcbsp3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 3,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1365,7 +1368,7 @@ static struct clk mcbsp3_fck = {
 	.name		= "mcbsp3_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 3,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1374,7 +1377,7 @@ static struct clk mcbsp4_ick = {
 	.name		= "mcbsp4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 4,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1383,7 +1386,7 @@ static struct clk mcbsp4_fck = {
 	.name		= "mcbsp4_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 4,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1392,7 +1395,7 @@ static struct clk mcbsp5_ick = {
 	.name		= "mcbsp5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 5,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1401,7 +1404,7 @@ static struct clk mcbsp5_fck = {
 	.name		= "mcbsp5_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 5,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1411,7 +1414,7 @@ static struct clk mcspi1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 17,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1421,7 +1424,7 @@ static struct clk mcspi1_fck = {
 	.id		= 1,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 17,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1431,7 +1434,7 @@ static struct clk mcspi2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 18,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1441,7 +1444,7 @@ static struct clk mcspi2_fck = {
 	.id		= 2,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 18,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1451,7 +1454,7 @@ static struct clk mcspi3_ick = {
 	.id		= 3,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 9,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1461,7 +1464,7 @@ static struct clk mcspi3_fck = {
 	.id		= 3,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 9,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1470,7 +1473,7 @@ static struct clk uart1_ick = {
 	.name		= "uart1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 21,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1479,7 +1482,7 @@ static struct clk uart1_fck = {
 	.name		= "uart1_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 21,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1488,7 +1491,7 @@ static struct clk uart2_ick = {
 	.name		= "uart2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 22,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1497,7 +1500,7 @@ static struct clk uart2_fck = {
 	.name		= "uart2_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 22,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1506,7 +1509,7 @@ static struct clk uart3_ick = {
 	.name		= "uart3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 2,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1515,7 +1518,7 @@ static struct clk uart3_fck = {
 	.name		= "uart3_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 2,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1524,7 +1527,7 @@ static struct clk gpios_ick = {
 	.name		= "gpios_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= 2,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1533,7 +1536,7 @@ static struct clk gpios_fck = {
 	.name		= "gpios_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= 2,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1542,7 +1545,7 @@ static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= 3,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1551,7 +1554,7 @@ static struct clk mpu_wdt_fck = {
 	.name		= "mpu_wdt_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= 3,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1560,7 +1563,7 @@ static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= 1,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1568,7 +1571,7 @@ static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= 4,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1576,7 +1579,7 @@ static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= 5,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1584,7 +1587,7 @@ static struct clk icr_ick = {
 	.name		= "icr_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= 6,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1593,7 +1596,7 @@ static struct clk cam_ick = {
 	.name		= "cam_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 31,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1602,7 +1605,7 @@ static struct clk cam_fck = {
 	.name		= "cam_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 31,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1611,7 +1614,7 @@ static struct clk mailboxes_ick = {
 	.name		= "mailboxes_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 30,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1620,7 +1623,7 @@ static struct clk wdt4_ick = {
 	.name		= "wdt4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 29,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1629,7 +1632,7 @@ static struct clk wdt4_fck = {
 	.name		= "wdt4_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 29,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1638,7 +1641,7 @@ static struct clk wdt3_ick = {
 	.name		= "wdt3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 28,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1647,7 +1650,7 @@ static struct clk wdt3_fck = {
 	.name		= "wdt3_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 28,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1656,7 +1659,7 @@ static struct clk mspro_ick = {
 	.name		= "mspro_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 27,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1665,7 +1668,7 @@ static struct clk mspro_fck = {
 	.name		= "mspro_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 27,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1674,7 +1677,7 @@ static struct clk mmc_ick = {
 	.name		= "mmc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 26,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1683,7 +1686,7 @@ static struct clk mmc_fck = {
 	.name		= "mmc_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 26,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1692,7 +1695,7 @@ static struct clk fac_ick = {
 	.name		= "fac_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 25,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1701,7 +1704,7 @@ static struct clk fac_fck = {
 	.name		= "fac_fck",
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 25,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1710,7 +1713,7 @@ static struct clk eac_ick = {
 	.name		= "eac_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 24,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1719,7 +1722,7 @@ static struct clk eac_fck = {
 	.name		= "eac_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 24,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1728,7 +1731,7 @@ static struct clk hdq_ick = {
 	.name		= "hdq_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 23,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1737,7 +1740,7 @@ static struct clk hdq_fck = {
 	.name		= "hdq_fck",
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 23,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1747,7 +1750,7 @@ static struct clk i2c2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 20,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1757,7 +1760,7 @@ static struct clk i2c2_fck = {
 	.id		= 2,
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 20,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1767,7 +1770,7 @@ static struct clk i2chs2_fck = {
 	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 20,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1777,7 +1780,7 @@ static struct clk i2c1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 19,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1787,7 +1790,7 @@ static struct clk i2c1_fck = {
 	.id		= 1,
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 19,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1797,7 +1800,7 @@ static struct clk i2chs1_fck = {
 	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 19,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1806,7 +1809,7 @@ static struct clk vlynq_ick = {
 	.name		= "vlynq_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= 3,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1815,7 +1818,7 @@ static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X  | RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= 3,
 	.src_offset	= 15,
 	.recalc		= &omap2_followparent_recalc,
@@ -1825,7 +1828,7 @@ static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN3_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP2430_CM_ICLKEN3),
 	.enable_bit	= 2,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1834,7 +1837,7 @@ static struct clk des_ick = {
 	.name		= "des_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= 0,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1843,7 +1846,7 @@ static struct clk sha_ick = {
 	.name		= "sha_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= 1,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1852,7 +1855,7 @@ static struct clk rng_ick = {
 	.name		= "rng_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= 2,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1861,7 +1864,7 @@ static struct clk aes_ick = {
 	.name		= "aes_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= 3,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1870,7 +1873,7 @@ static struct clk pka_ick = {
 	.name		= "pka_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= 4,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1879,7 +1882,7 @@ static struct clk usb_fck = {
 	.name		= "usb_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 0,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1888,7 +1891,7 @@ static struct clk usbhs_ick = {
 	.name		= "usbhs_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 6,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1897,7 +1900,7 @@ static struct clk mmchs1_ick = {
 	.name		= "mmchs1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 7,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1906,7 +1909,7 @@ static struct clk mmchs1_fck = {
 	.name		= "mmchs1_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 7,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1915,7 +1918,7 @@ static struct clk mmchs2_ick = {
 	.name		= "mmchs2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 8,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1924,7 +1927,7 @@ static struct clk mmchs2_fck = {
 	.name		= "mmchs2_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 8,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1933,7 +1936,7 @@ static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 10,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1942,7 +1945,7 @@ static struct clk gpio5_fck = {
 	.name		= "gpio5_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 10,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1951,7 +1954,7 @@ static struct clk mdm_intc_ick = {
 	.name		= "mdm_intc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= 11,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1960,7 +1963,7 @@ static struct clk mmchsdb1_fck = {
 	.name		= "mmchsdb1_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 16,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1969,7 +1972,7 @@ static struct clk mmchsdb2_fck = {
 	.name		= "mmchsdb2_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= 17,
 	.recalc		= &omap2_followparent_recalc,
 };
-- 
1.5.1.3

-- 
