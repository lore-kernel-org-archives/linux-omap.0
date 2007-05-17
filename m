From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 15/18] omap2: convert clock.h to use symbolic register bit
	defines
Date: Wed, 16 May 2007 18:11:47 -0600
Message-ID: <20070517005444.581904817@pwsan.com>
References: <20070517001132.652728079@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0015-omap2-convert-clock.h-to-use-symbolic-register-bit.patch
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

Convert magic numbers in the enable_bit member of the struct clk
definitions in clock.h to use the new-style register bit defines from
{prm,cm}_regbits_24xx.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.h |  239 ++++++++++++++++++++++---------------------
 1 files changed, 121 insertions(+), 118 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index e6616b9..78da556 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -19,6 +19,8 @@
 
 #include "prm.h"
 #include "cm.h"
+#include "prm_regbits_24xx.h"
+#include "cm_regbits_24xx.h"
 
 static void omap2_sys_clk_recalc(struct clk * clk);
 static void omap2_clksel_recalc(struct clk * clk);
@@ -643,7 +645,7 @@ static struct clk apll96_ck = {
 	.flags		= CLOCK_IN_OMAP242X |CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= 0x2,
+	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
 	.recalc		= &omap2_propagate_rate,
 };
 
@@ -654,7 +656,7 @@ static struct clk apll54_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= 0x6,
+	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
 	.recalc		= &omap2_propagate_rate,
 };
 
@@ -739,7 +741,7 @@ static struct clk sys_clkout = {
 				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
 	.src_offset	= 0,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
-	.enable_bit	= 7,
+	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
 	.rate_offset	= 3,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -753,7 +755,7 @@ static struct clk sys_clkout2 = {
 				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
 	.src_offset	= 8,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
-	.enable_bit	= 15,
+	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
 	.rate_offset	= 11,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -763,7 +765,7 @@ static struct clk emul_ck = {
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP24XX_PRCM_CLKEMUL_CTRL,
-	.enable_bit	= 0,
+	.enable_bit	= OMAP24XX_EMULATION_EN_SHIFT,
 	.recalc		= &omap2_propagate_rate,
 
 };
@@ -802,7 +804,7 @@ static struct clk iva2_1_fck = {
 				CONFIG_PARTICIPANT,
 	.rate_offset	= 0,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
-	.enable_bit	= 0,
+	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -828,7 +830,7 @@ static struct clk dsp_fck = {
 			DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.rate_offset	= 0,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
-	.enable_bit	= 0,
+	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -839,7 +841,7 @@ static struct clk dsp_ick = {
 				DELAYED_APP | CONFIG_PARTICIPANT,
 	.rate_offset	= 5,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
-	.enable_bit	= 1,		/* for ipi */
+	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,		/* for ipi */
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -850,7 +852,7 @@ static struct clk iva1_ifck = {
 			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
 	.rate_offset	= 8,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
-	.enable_bit	= 10,
+	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -860,7 +862,7 @@ static struct clk iva1_mpu_int_ifck = {
 	.parent		= &iva1_ifck,
 	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
-	.enable_bit	= 8,
+	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -901,7 +903,7 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP |
 				CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 0,
+	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
 	.rate_offset	= 25,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -920,7 +922,7 @@ static struct clk ssi_ssr_sst_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),	/* bit 1 */
-	.enable_bit	= 1,
+	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
 	.rate_offset	= 20,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -942,7 +944,7 @@ static struct clk gfx_3d_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | CM_GFX_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
-	.enable_bit	= 2,
+	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
 	.rate_offset	= 0,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -953,7 +955,7 @@ static struct clk gfx_2d_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | CM_GFX_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
-	.enable_bit	= 1,
+	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
 	.rate_offset	= 0,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -964,7 +966,7 @@ static struct clk gfx_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),	/* bit 0 */
-	.enable_bit	= 0,
+	.enable_bit	= OMAP_EN_GFX_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -981,7 +983,7 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 				DELAYED_APP | CONFIG_PARTICIPANT,
 	.rate_offset	= 0,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
-	.enable_bit	= 0,
+	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -991,7 +993,7 @@ static struct clk mdm_osc_ck = {
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP243X | RATE_FIXED,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, OMAP24XX_CM_FCLKEN),
-	.enable_bit	= 1,
+	.enable_bit	= OMAP2430_EN_OSC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1017,7 +1019,7 @@ static struct clk ssi_l4_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),	/* bit 1 */
-	.enable_bit	= 1,
+	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1034,7 +1036,7 @@ static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.parent		= &l4_ck,	/* really both l3 and l4 */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 0,
+	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1044,7 +1046,7 @@ static struct clk dss1_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 0,
+	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
 	.rate_offset	= 8,
 	.src_offset	= 8,
 	.recalc		= &omap2_clksel_recalc,
@@ -1057,7 +1059,7 @@ static struct clk dss2_fck = {		/* Alt clk used in power management */
 				RATE_CKCTL | CM_CORE_SEL1 | RATE_FIXED |
 				DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 1,
+	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
 	.src_offset	= 13,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1069,7 +1071,7 @@ static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 2,
+	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
 	.recalc		= &omap2_propagate_rate,
 };
 
@@ -1084,7 +1086,7 @@ static struct clk gpt1_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),	/* Bit0 */
-	.enable_bit	= 0,
+	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1094,7 +1096,7 @@ static struct clk gpt1_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_WKUP_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),	/* Bit0 */
-	.enable_bit	= 0,
+	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.src_offset	= 0,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1104,7 +1106,7 @@ static struct clk gpt2_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit4 */
-	.enable_bit	= 4,
+	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1114,7 +1116,7 @@ static struct clk gpt2_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 4,
+	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
 	.src_offset	= 2,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1124,7 +1126,7 @@ static struct clk gpt3_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit5 */
-	.enable_bit	= 5,
+	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1134,7 +1136,7 @@ static struct clk gpt3_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 5,
+	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
 	.src_offset	= 4,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1144,7 +1146,7 @@ static struct clk gpt4_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit6 */
-	.enable_bit	= 6,
+	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1154,7 +1156,7 @@ static struct clk gpt4_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 6,
+	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
 	.src_offset	= 6,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1164,7 +1166,7 @@ static struct clk gpt5_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* Bit7 */
-	.enable_bit	= 7,
+	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1174,7 +1176,7 @@ static struct clk gpt5_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 7,
+	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
 	.src_offset	= 8,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1183,7 +1185,7 @@ static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 8,
+	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit8 */
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1194,7 +1196,7 @@ static struct clk gpt6_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 8,
+	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.src_offset	= 10,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1204,7 +1206,7 @@ static struct clk gpt7_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit9 */
-	.enable_bit	= 9,
+	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1214,7 +1216,7 @@ static struct clk gpt7_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 9,
+	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.src_offset	= 12,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1224,7 +1226,7 @@ static struct clk gpt8_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit10 */
-	.enable_bit	= 10,
+	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1234,7 +1236,7 @@ static struct clk gpt8_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 10,
+	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
 	.src_offset	= 14,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1244,7 +1246,7 @@ static struct clk gpt9_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 11,
+	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1254,7 +1256,7 @@ static struct clk gpt9_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 11,
+	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
 	.src_offset	= 16,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1264,7 +1266,7 @@ static struct clk gpt10_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 12,
+	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1274,7 +1276,7 @@ static struct clk gpt10_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 12,
+	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
 	.src_offset	= 18,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1284,7 +1286,7 @@ static struct clk gpt11_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 13,
+	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1294,7 +1296,7 @@ static struct clk gpt11_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 13,
+	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
 	.src_offset	= 20,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1304,7 +1306,7 @@ static struct clk gpt12_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit14 */
-	.enable_bit	= 14,
+	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1314,17 +1316,18 @@ static struct clk gpt12_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 14,
+	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
 	.src_offset	= 22,
 	.recalc		= &omap2_followparent_recalc,
 };
 
+/* REVISIT: bit comment below wrong? */
 static struct clk mcbsp1_ick = {
 	.name		= "mcbsp1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit16 */
-	.enable_bit	= 15,
+	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1333,7 +1336,7 @@ static struct clk mcbsp1_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 15,
+	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1342,7 +1345,7 @@ static struct clk mcbsp2_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 16,
+	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1351,7 +1354,7 @@ static struct clk mcbsp2_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 16,
+	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1360,7 +1363,7 @@ static struct clk mcbsp3_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 3,
+	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1369,7 +1372,7 @@ static struct clk mcbsp3_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 3,
+	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1378,7 +1381,7 @@ static struct clk mcbsp4_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 4,
+	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1387,7 +1390,7 @@ static struct clk mcbsp4_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 4,
+	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1396,7 +1399,7 @@ static struct clk mcbsp5_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 5,
+	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1405,7 +1408,7 @@ static struct clk mcbsp5_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 5,
+	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1415,7 +1418,7 @@ static struct clk mcspi1_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 17,
+	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1425,7 +1428,7 @@ static struct clk mcspi1_fck = {
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 17,
+	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1435,7 +1438,7 @@ static struct clk mcspi2_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 18,
+	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1445,7 +1448,7 @@ static struct clk mcspi2_fck = {
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 18,
+	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1455,7 +1458,7 @@ static struct clk mcspi3_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 9,
+	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1465,7 +1468,7 @@ static struct clk mcspi3_fck = {
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 9,
+	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1474,7 +1477,7 @@ static struct clk uart1_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 21,
+	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1483,7 +1486,7 @@ static struct clk uart1_fck = {
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 21,
+	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1492,7 +1495,7 @@ static struct clk uart2_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 22,
+	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1501,7 +1504,7 @@ static struct clk uart2_fck = {
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 22,
+	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1510,7 +1513,7 @@ static struct clk uart3_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 2,
+	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1519,7 +1522,7 @@ static struct clk uart3_fck = {
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 2,
+	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1528,7 +1531,7 @@ static struct clk gpios_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= 2,
+	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1537,7 +1540,7 @@ static struct clk gpios_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
-	.enable_bit	= 2,
+	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1546,7 +1549,7 @@ static struct clk mpu_wdt_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= 3,
+	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1555,7 +1558,7 @@ static struct clk mpu_wdt_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
-	.enable_bit	= 3,
+	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1564,7 +1567,7 @@ static struct clk sync_32k_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= 1,
+	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 static struct clk wdt1_ick = {
@@ -1572,7 +1575,7 @@ static struct clk wdt1_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= 4,
+	.enable_bit	= OMAP24XX_EN_WDT1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 static struct clk omapctrl_ick = {
@@ -1580,7 +1583,7 @@ static struct clk omapctrl_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= 5,
+	.enable_bit	= OMAP24XX_EN_OMAPCTRL_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 static struct clk icr_ick = {
@@ -1588,7 +1591,7 @@ static struct clk icr_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= 6,
+	.enable_bit	= OMAP2430_EN_ICR_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1597,7 +1600,7 @@ static struct clk cam_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 31,
+	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1606,7 +1609,7 @@ static struct clk cam_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 31,
+	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1615,7 +1618,7 @@ static struct clk mailboxes_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 30,
+	.enable_bit	= OMAP24XX_EN_MAILBOXES_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1624,7 +1627,7 @@ static struct clk wdt4_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 29,
+	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1633,7 +1636,7 @@ static struct clk wdt4_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 29,
+	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1642,7 +1645,7 @@ static struct clk wdt3_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 28,
+	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1651,7 +1654,7 @@ static struct clk wdt3_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 28,
+	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1660,7 +1663,7 @@ static struct clk mspro_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 27,
+	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1669,7 +1672,7 @@ static struct clk mspro_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 27,
+	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1678,7 +1681,7 @@ static struct clk mmc_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 26,
+	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1687,7 +1690,7 @@ static struct clk mmc_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 26,
+	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1696,7 +1699,7 @@ static struct clk fac_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 25,
+	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1705,7 +1708,7 @@ static struct clk fac_fck = {
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 25,
+	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1714,7 +1717,7 @@ static struct clk eac_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 24,
+	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1723,7 +1726,7 @@ static struct clk eac_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 24,
+	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1732,7 +1735,7 @@ static struct clk hdq_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 23,
+	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1741,7 +1744,7 @@ static struct clk hdq_fck = {
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 23,
+	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1751,7 +1754,7 @@ static struct clk i2c2_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 20,
+	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1761,7 +1764,7 @@ static struct clk i2c2_fck = {
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 20,
+	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1771,7 +1774,7 @@ static struct clk i2chs2_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 20,
+	.enable_bit	= OMAP2430_EN_I2CHS2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1781,7 +1784,7 @@ static struct clk i2c1_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 19,
+	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1791,7 +1794,7 @@ static struct clk i2c1_fck = {
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 19,
+	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1801,7 +1804,7 @@ static struct clk i2chs1_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 19,
+	.enable_bit	= OMAP2430_EN_I2CHS1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1810,7 +1813,7 @@ static struct clk vlynq_ick = {
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= 3,
+	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1819,7 +1822,7 @@ static struct clk vlynq_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X  | RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= 3,
+	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
 	.src_offset	= 15,
 	.recalc		= &omap2_followparent_recalc,
 };
@@ -1829,7 +1832,7 @@ static struct clk sdrc_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP2430_CM_ICLKEN3),
-	.enable_bit	= 2,
+	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1838,7 +1841,7 @@ static struct clk des_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
-	.enable_bit	= 0,
+	.enable_bit	= OMAP24XX_EN_DES_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1847,7 +1850,7 @@ static struct clk sha_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
-	.enable_bit	= 1,
+	.enable_bit	= OMAP24XX_EN_SHA_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1856,7 +1859,7 @@ static struct clk rng_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
-	.enable_bit	= 2,
+	.enable_bit	= OMAP24XX_EN_RNG_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1865,7 +1868,7 @@ static struct clk aes_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
-	.enable_bit	= 3,
+	.enable_bit	= OMAP24XX_EN_AES_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1874,7 +1877,7 @@ static struct clk pka_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
-	.enable_bit	= 4,
+	.enable_bit	= OMAP24XX_EN_PKA_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1883,7 +1886,7 @@ static struct clk usb_fck = {
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 0,
+	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1892,7 +1895,7 @@ static struct clk usbhs_ick = {
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 6,
+	.enable_bit	= OMAP2430_EN_USBHS_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1901,7 +1904,7 @@ static struct clk mmchs1_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 7,
+	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1910,7 +1913,7 @@ static struct clk mmchs1_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 7,
+	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1919,7 +1922,7 @@ static struct clk mmchs2_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 8,
+	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1928,7 +1931,7 @@ static struct clk mmchs2_fck = {
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 8,
+	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1937,7 +1940,7 @@ static struct clk gpio5_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 10,
+	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1946,7 +1949,7 @@ static struct clk gpio5_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 10,
+	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1955,7 +1958,7 @@ static struct clk mdm_intc_ick = {
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= 11,
+	.enable_bit	= OMAP2430_EN_MDM_INTC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1964,7 +1967,7 @@ static struct clk mmchsdb1_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 16,
+	.enable_bit	= OMAP2430_EN_MMCHSDB1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1973,7 +1976,7 @@ static struct clk mmchsdb2_fck = {
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= 17,
+	.enable_bit	= OMAP2430_EN_MMCHSDB2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
-- 
1.5.1.3

-- 
