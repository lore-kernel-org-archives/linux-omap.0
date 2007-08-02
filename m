From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/22] omap2 clock: use symbolic constants in clock.h
	rate_offset/src_offset fields
Date: Thu, 02 Aug 2007 12:10:12 -0600
Message-ID: <20070802181142.450896576@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=cleanup-clock.h-magic-numbers.patch
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

Convert most of the magic numbers remaining in mach-omap2/clock.h to
symbolic constants.  This primarily affects the src_offset/rate_offset 
fields.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h           |   78 ++++++++++++++++------------------
 arch/arm/mach-omap2/cm_regbits_24xx.h |    3 +
 2 files changed, 41 insertions(+), 40 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -65,10 +65,8 @@ struct prcm_config {
 			CM_PLL_SEL1 | CM_PLL_SEL2 | CM_SYSCLKOUT_SEL1)
 
 /* Mask for clksel regs which support rate operations */
-#define SRC_RATE_SEL_MASK (CM_MPU_SEL1 | CM_DSP_SEL1 | CM_GFX_SEL1 | \
-			CM_MODEM_SEL1 | CM_CORE_SEL1 | CM_CORE_SEL2 | \
-			CM_WKUP_SEL1 | CM_PLL_SEL1 | CM_PLL_SEL2 | \
-			CM_SYSCLKOUT_SEL1)
+#define SRC_RATE_SEL_MASK (SRC_SEL_MASK | CM_MPU_SEL1 | CM_DSP_SEL1 | \
+			CM_GFX_SEL1 | CM_MODEM_SEL1)
 
 /*
  * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
@@ -614,7 +612,7 @@ static struct clk sys_ck = {		/* (*12, *
 	.rate		= 13000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.rate_offset	= 6, /* sysclkdiv 1 or 2, already handled or no boot */
+	.rate_offset	= OMAP_SYSCLKDIV_SHIFT, /* sysclkdiv 1 or 2, already handled or no boot */
 	.recalc		= &omap2_sys_clk_recalc,
 };
 
@@ -670,7 +668,7 @@ static struct clk func_54m_ck = {
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
-	.src_offset	= 5,
+	.src_offset	= OMAP24XX_54M_SOURCE_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_propagate_rate,
@@ -701,7 +699,7 @@ static struct clk func_48m_ck = {
 	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
-	.src_offset	= 3,
+	.src_offset	= OMAP24XX_48M_SOURCE_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_propagate_rate,
@@ -732,10 +730,10 @@ static struct clk sys_clkout = {
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
-	.src_offset	= 0,
+	.src_offset	= OMAP24XX_CLKOUT_SOURCE_SHIFT,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
-	.rate_offset	= 3,
+	.rate_offset	= OMAP24XX_CLKOUT_DIV_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -746,10 +744,10 @@ static struct clk sys_clkout2 = {
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
-	.src_offset	= 8,
+	.src_offset	= OMAP2420_CLKOUT2_SOURCE_SHIFT,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
-	.rate_offset	= 11,
+	.rate_offset	= OMAP2420_CLKOUT2_DIV_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -779,7 +777,7 @@ static struct clk mpu_ck = {	/* Control 
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL |
 				ALWAYS_ENABLED | CM_MPU_SEL1 | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.rate_offset	= 0,	/* bits 0-4 */
+	.rate_offset	= OMAP24XX_CLKSEL_MPU_SHIFT,	/* bits 0-4 */
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -795,7 +793,7 @@ static struct clk iva2_1_fck = {
 	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
 				DELAYED_APP | RATE_PROPAGATES |
 				CONFIG_PARTICIPANT,
-	.rate_offset	= 0,
+	.rate_offset	= OMAP24XX_CLKSEL_DSP_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
@@ -806,7 +804,7 @@ static struct clk iva2_1_ick = {
 	.parent		= &iva2_1_fck,
 	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= 5,
+	.rate_offset	= OMAP24XX_CLKSEL_DSP_IF_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -821,7 +819,7 @@ static struct clk dsp_fck = {
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
 			DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.rate_offset	= 0,
+	.rate_offset	= OMAP24XX_CLKSEL_DSP_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
@@ -832,7 +830,7 @@ static struct clk dsp_ick = {
 	.parent		= &dsp_fck,
 	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= 5,
+	.rate_offset	= OMAP24XX_CLKSEL_DSP_IF_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,		/* for ipi */
 	.recalc		= &omap2_clksel_recalc,
@@ -843,7 +841,7 @@ static struct clk iva1_ifck = {
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 | RATE_CKCTL |
 			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
-	.rate_offset	= 8,
+	.rate_offset	= OMAP2420_CLKSEL_IVA_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
@@ -885,7 +883,7 @@ static struct clk core_l3_ck = {	/* Used
 				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT |
 				RATE_PROPAGATES,
-	.rate_offset	= 0,
+	.rate_offset	= OMAP24XX_CLKSEL_L3_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -897,7 +895,7 @@ static struct clk usb_l4_ick = {	/* FS-U
 				CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
-	.rate_offset	= 25,
+	.rate_offset	= OMAP24XX_CLKSEL_USB_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -916,7 +914,7 @@ static struct clk ssi_ssr_sst_fck = {
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),	/* bit 1 */
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
-	.rate_offset	= 20,
+	.rate_offset	= OMAP24XX_CLKSEL_SSI_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -938,7 +936,7 @@ static struct clk gfx_3d_fck = {
 				RATE_CKCTL | CM_GFX_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
-	.rate_offset	= 0,
+	.rate_offset	= OMAP_CLKSEL_GFX_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -949,7 +947,7 @@ static struct clk gfx_2d_fck = {
 				RATE_CKCTL | CM_GFX_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
-	.rate_offset	= 0,
+	.rate_offset	= OMAP_CLKSEL_GFX_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -973,7 +971,7 @@ static struct clk mdm_ick = {		/* used b
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_MODEM_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= 0,
+	.rate_offset	= OMAP2430_CLKSEL_MDM_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
@@ -1002,7 +1000,7 @@ static struct clk l4_ck = {		/* used bot
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
 				DELAYED_APP | RATE_PROPAGATES,
-	.rate_offset	= 5,
+	.rate_offset	= OMAP24XX_CLKSEL_L4_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1039,8 +1037,8 @@ static struct clk dss1_fck = {
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
-	.rate_offset	= 8,
-	.src_offset	= 8,
+	.rate_offset	= OMAP24XX_CLKSEL_DSS1_SHIFT,
+	.src_offset	= OMAP24XX_CLKSEL_DSS1_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1052,7 +1050,7 @@ static struct clk dss2_fck = {		/* Alt c
 				DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
-	.src_offset	= 13,
+	.src_offset	= OMAP24XX_CLKSEL_DSS2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1087,7 +1085,7 @@ static struct clk gpt1_fck = {
 				CM_WKUP_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),	/* Bit0 */
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
-	.src_offset	= 0,
+	.src_offset	= OMAP24XX_CLKSEL_GPT1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1107,7 +1105,7 @@ static struct clk gpt2_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
-	.src_offset	= 2,
+	.src_offset	= OMAP24XX_CLKSEL_GPT2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1127,7 +1125,7 @@ static struct clk gpt3_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
-	.src_offset	= 4,
+	.src_offset	= OMAP24XX_CLKSEL_GPT3_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1147,7 +1145,7 @@ static struct clk gpt4_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
-	.src_offset	= 6,
+	.src_offset	= OMAP24XX_CLKSEL_GPT4_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1167,7 +1165,7 @@ static struct clk gpt5_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
-	.src_offset	= 8,
+	.src_offset	= OMAP24XX_CLKSEL_GPT5_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1187,7 +1185,7 @@ static struct clk gpt6_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
-	.src_offset	= 10,
+	.src_offset	= OMAP24XX_CLKSEL_GPT6_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1207,7 +1205,7 @@ static struct clk gpt7_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
-	.src_offset	= 12,
+	.src_offset	= OMAP24XX_CLKSEL_GPT7_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1227,7 +1225,7 @@ static struct clk gpt8_fck = {
 				CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
-	.src_offset	= 14,
+	.src_offset	= OMAP24XX_CLKSEL_GPT8_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1247,7 +1245,7 @@ static struct clk gpt9_fck = {
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
-	.src_offset	= 16,
+	.src_offset	= OMAP24XX_CLKSEL_GPT9_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1267,7 +1265,7 @@ static struct clk gpt10_fck = {
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
-	.src_offset	= 18,
+	.src_offset	= OMAP24XX_CLKSEL_GPT10_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1287,7 +1285,7 @@ static struct clk gpt11_fck = {
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
-	.src_offset	= 20,
+	.src_offset	= OMAP24XX_CLKSEL_GPT11_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1307,7 +1305,7 @@ static struct clk gpt12_fck = {
 					CM_CORE_SEL2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
-	.src_offset	= 22,
+	.src_offset	= OMAP24XX_CLKSEL_GPT12_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1813,7 +1811,7 @@ static struct clk vlynq_fck = {
 	.flags		= CLOCK_IN_OMAP242X  | RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
-	.src_offset	= 15,
+	.src_offset	= OMAP2420_CLKSEL_VLYNQ_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
Index: linux-omap/arch/arm/mach-omap2/cm_regbits_24xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/cm_regbits_24xx.h
+++ linux-omap/arch/arm/mach-omap2/cm_regbits_24xx.h
@@ -323,8 +323,11 @@
 #define OMAP24XX_DPLL_MULT_MASK				(0x3ff << 12)
 #define OMAP24XX_DPLL_DIV_SHIFT				8
 #define OMAP24XX_DPLL_DIV_MASK				(0xf << 8)
+#define OMAP24XX_54M_SOURCE_SHIFT			5
 #define OMAP24XX_54M_SOURCE				(1 << 5)
+#define OMAP2430_96M_SOURCE_SHIFT			4
 #define OMAP2430_96M_SOURCE				(1 << 4)
+#define OMAP24XX_48M_SOURCE_SHIFT			3
 #define OMAP24XX_48M_SOURCE				(1 << 3)
 #define OMAP2430_ALTCLK_SOURCE_SHIFT			0
 #define OMAP2430_ALTCLK_SOURCE_MASK			(0x7 << 0)

-- 
