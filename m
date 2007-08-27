From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 20/27] omap2 clock: remove *_SEL* clock flags
Date: Mon, 27 Aug 2007 02:39:16 -0600
Message-ID: <20070827084124.069868859@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=nuke_src_rate_mask.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

We no longer need the *_SEL* clock flags with the struct clksel conversion,
so we get rid of them.  This frees up 10 clock flag bits.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |    4 -
 arch/arm/mach-omap2/clock.h       |  111 +++++++++++++-------------------------
 include/asm-arm/arch-omap/clock.h |   11 ---
 3 files changed, 41 insertions(+), 85 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:40.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:42.000000000 -0600
@@ -891,7 +891,7 @@
 	if (unlikely(clk->flags & CONFIG_PARTICIPANT))
 		return -EINVAL;
 
-	if (unlikely(!(clk->flags & SRC_SEL_MASK)))
+	if (!clk->clksel)
 		return -EINVAL;
 
 	field_val = omap2_clksel_get_src_field(&src_addr, new_parent,
@@ -919,7 +919,7 @@
 
 	clk->parent = new_parent;
 
-	/* SRC_RATE_SEL_MASK clocks follow their parents rates.*/
+	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
 	clk->rate = new_parent->rate;
 
 	if (parent_div > 0)
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-08-27 02:19:41.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-08-27 02:19:42.000000000 -0600
@@ -62,16 +62,6 @@
 	unsigned char flags;
 };
 
-/* REVISIT: CM_PLL_SEL2 unused */
-
-/* Mask for clksel which support parent settign in set_rate */
-#define SRC_SEL_MASK (CM_CORE_SEL1 | CM_CORE_SEL2 | CM_WKUP_SEL1 | \
-			CM_PLL_SEL1 | CM_PLL_SEL2 | CM_SYSCLKOUT_SEL1)
-
-/* Mask for clksel regs which support rate operations */
-#define SRC_RATE_SEL_MASK (SRC_SEL_MASK | CM_MPU_SEL1 | CM_DSP_SEL1 | \
-			CM_GFX_SEL1 | CM_MODEM_SEL1)
-
 /*
  * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
  * These configurations are characterized by voltage and speed for clocks.
@@ -641,7 +631,7 @@
 	.name		= "dpll_ck",
 	.parent		= &sys_ck,		/* Can be func_32k also */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | CM_PLL_SEL1 |	ALWAYS_ENABLED,
+				RATE_PROPAGATES | ALWAYS_ENABLED,
 	.recalc		= &omap2_dpll_recalc,
 	.set_rate	= &omap2_reprogram_dpll,
 };
@@ -694,8 +684,7 @@
 	.name		= "func_54m_ck",
 	.parent		= &apll54_ck,	/* can also be alt_clk */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_PLL_SEL1 | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_54M_SOURCE,
@@ -765,8 +754,7 @@
 	.name		= "func_48m_ck",
 	.parent		= &apll96_ck,	 /* 96M or Alt */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_PLL_SEL1 | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_48M_SOURCE,
@@ -833,7 +821,7 @@
 	.name		= "sys_clkout_src",
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_PROPAGATES,
+				RATE_PROPAGATES,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -863,7 +851,7 @@
 	.name		= "sys_clkout",
 	.parent		= &sys_clkout_src,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | PARENT_CONTROLS_CLOCK,
+				PARENT_CONTROLS_CLOCK,
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
@@ -876,8 +864,7 @@
 static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
 	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 |
-				RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -898,8 +885,7 @@
 static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
 	.parent		= &sys_clkout2_src,
-	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 |
-				PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP242X | PARENT_CONTROLS_CLOCK,
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
@@ -946,7 +932,7 @@
 	.name		= "mpu_ck",
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | CM_MPU_SEL1 | DELAYED_APP |
+				ALWAYS_ENABLED | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
@@ -987,8 +973,7 @@
 static struct clk iva2_1_fck = {
 	.name		= "iva2_1_fck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | CM_DSP_SEL1 |
-				DELAYED_APP | RATE_PROPAGATES |
+	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | RATE_PROPAGATES |
 				CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -1016,8 +1001,7 @@
 static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.parent		= &iva2_1_fck,
-	.flags		= CLOCK_IN_OMAP243X | CM_DSP_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= iva2_1_ick_clksel,
@@ -1051,8 +1035,8 @@
 static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 |
-			DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP |
+				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
@@ -1078,8 +1062,7 @@
 static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,		/* for ipi */
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
@@ -1107,8 +1090,8 @@
 static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 |
-			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
+	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT |
+				RATE_PROPAGATES | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
@@ -1169,9 +1152,8 @@
 	.name		= "core_l3_ck",
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | CM_CORE_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT |
-				RATE_PROPAGATES,
+				ALWAYS_ENABLED | DELAYED_APP |
+				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
 	.clksel		= core_l3_clksel,
@@ -1197,8 +1179,7 @@
 	.name		= "usb_l4_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL1 | DELAYED_APP |
-				CONFIG_PARTICIPANT,
+				DELAYED_APP | CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
@@ -1237,7 +1218,7 @@
 	.name		= "ssi_fck",
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL1 | DELAYED_APP,
+				DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),	/* bit 1 */
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
@@ -1281,8 +1262,7 @@
 static struct clk gfx_3d_fck = {
 	.name		= "gfx_3d_fck",
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_GFX_SEL1,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
@@ -1296,8 +1276,7 @@
 static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_GFX_SEL1,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
@@ -1340,8 +1319,7 @@
 static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | CM_MODEM_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL),
@@ -1383,8 +1361,7 @@
 	.name		= "l4_ck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | CM_CORE_SEL1 |
-				DELAYED_APP | RATE_PROPAGATES,
+				ALWAYS_ENABLED | DELAYED_APP | RATE_PROPAGATES,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
 	.clksel		= l4_clksel,
@@ -1450,7 +1427,7 @@
 	.name		= "dss1_fck",
 	.parent		= &core_ck,		/* Core or sys */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL1 | DELAYED_APP,
+				DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1482,7 +1459,7 @@
 	.name		= "dss2_fck",
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL1 | DELAYED_APP,
+				DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1541,8 +1518,7 @@
 static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_WKUP_SEL1,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),	/* Bit0 */
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1566,8 +1542,7 @@
 static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1589,8 +1564,7 @@
 static struct clk gpt3_fck = {
 	.name		= "gpt3_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1612,8 +1586,7 @@
 static struct clk gpt4_fck = {
 	.name		= "gpt4_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1635,8 +1608,7 @@
 static struct clk gpt5_fck = {
 	.name		= "gpt5_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1658,8 +1630,7 @@
 static struct clk gpt6_fck = {
 	.name		= "gpt6_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1681,8 +1652,7 @@
 static struct clk gpt7_fck = {
 	.name		= "gpt7_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1704,8 +1674,7 @@
 static struct clk gpt8_fck = {
 	.name		= "gpt8_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1727,8 +1696,7 @@
 static struct clk gpt9_fck = {
 	.name		= "gpt9_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1750,8 +1718,7 @@
 static struct clk gpt10_fck = {
 	.name		= "gpt10_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1773,8 +1740,7 @@
 static struct clk gpt11_fck = {
 	.name		= "gpt11_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1796,8 +1762,7 @@
 static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -2330,7 +2295,7 @@
 static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CM_CORE_SEL1 | DELAYED_APP,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
 	.init		= &omap2_init_clksel_parent,
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h	2007-08-27 02:19:39.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/clock.h	2007-08-27 02:19:42.000000000 -0600
@@ -95,16 +95,7 @@
 #define CLOCK_NO_IDLE_PARENT	(1 << 8)
 #define DELAYED_APP		(1 << 9)	/* Delay application of clock */
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
-#define CM_MPU_SEL1		(1 << 11)	/* Domain divider/source */
-#define CM_DSP_SEL1		(1 << 12)
-#define CM_GFX_SEL1		(1 << 13)
-#define CM_MODEM_SEL1		(1 << 14)
-#define CM_CORE_SEL1		(1 << 15)	/* Sets divider for many */
-#define CM_CORE_SEL2		(1 << 16)	/* sets parent for GPT */
-#define CM_WKUP_SEL1		(1 << 17)
-#define CM_PLL_SEL1		(1 << 18)
-#define CM_PLL_SEL2		(1 << 19)
-#define CM_SYSCLKOUT_SEL1	(1 << 20)
+/* bits 11-20 are currently free */
 #define CLOCK_IN_OMAP310	(1 << 21)
 #define CLOCK_IN_OMAP730	(1 << 22)
 #define CLOCK_IN_OMAP1510	(1 << 23)

-- 
