From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/28] omap2 clock: add clksel and clksel_rate data
Date: Mon, 20 Aug 2007 03:53:53 -0600
Message-ID: <20070820095530.544514938@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add-clksel-clksel_rate-data.patch
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

Many OMAP2 clocks are either source- or divisor-selectable by twiddling 
various register bits; these are 'clksel' clocks.  The table of rate divisors
and source clock settings was previously embedded in the clock.c source code.
Encode this data in two data structures:

1) struct clksel_rate for divisor-selection, mapping divisor values to 
register bit field values, along with a flags field indicating which 
chips the rate is available for -- one for each parent-rate combination; and:

2) struct clksel for source-selection, mapping parent struct clk pointers
to struct clksel_rate array pointers; one for each parent.

Also, add several fields to the clk structure:

1) clksel: pointer to the struct clksel array

2) clksel_reg: pointer to the clksel register

3) clksel_mask: mask for the clksel bitfield

Add this data to each clksel clock.  All this data is not yet used by the clock
framework; that functionality is in the following patches.

N.B. Two clocks, sys_clkout and sys_clkout2, could not be converted to
this setup without splitting source selection and divisor selection.
This is because these clocks use separate registers for each
selector.  So, create two new clocks, sys_clkout_src and
sys_clkout2_src, and locate source-selection there, and keep divisor
selection in sys_clkout/sys_clkout2.  This entailed modifying
board-n800-audio.c.


Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/board-n800-audio.c |   13 
 arch/arm/mach-omap2/clock.h            |  536 ++++++++++++++++++++++++++++++++-
 include/asm-arm/arch-omap/clock.h      |   25 +
 3 files changed, 557 insertions(+), 17 deletions(-)

Index: linux-omap/include/asm-arm/arch-omap/clock.h
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h
+++ linux-omap/include/asm-arm/arch-omap/clock.h
@@ -14,6 +14,22 @@
 #define __ARCH_ARM_OMAP_CLOCK_H
 
 struct module;
+struct clk;
+
+#if defined(CONFIG_ARCH_OMAP2)
+
+struct clksel_rate {
+	u8			div;
+	u32			val;
+	u8			flags;
+};
+
+struct clksel {
+	struct clk		 *parent;
+	const struct clksel_rate *rates;
+};
+
+#endif
 
 struct clk {
 	struct list_head	node;
@@ -36,6 +52,9 @@ struct clk {
 	void			(*disable)(struct clk *);
 #if defined(CONFIG_ARCH_OMAP2)
 	u8			fixed_div;
+	void __iomem		*clksel_reg;
+	u32			clksel_mask;
+	const struct clksel	*clksel;
 #endif
 };
 
@@ -94,6 +113,12 @@ extern int clk_get_usecount(struct clk *
 #define CLOCK_IN_OMAP343X	(1 << 27)
 #define PARENT_CONTROLS_CLOCK	(1 << 28)
 
+/* Clksel_rate flags */
+#define DEFAULT_RATE            (1 << 0)
+#define RATE_IN_242X            (1 << 1)
+#define RATE_IN_243X            (1 << 2)
+#define RATE_IN_343X            (1 << 3)
+#define RATE_IN_24XX            (RATE_IN_242X | RATE_IN_243X)
 
 
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC options (24XX) */
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -34,10 +34,6 @@ static u32 omap2_clksel_get_divisor(stru
 static void omap2_dpll_recalc(struct clk *clk);
 static void omap2_fixed_divisor_recalc(struct clk *clk);
 
-#define RATE_IN_242X	(1 << 0)
-#define RATE_IN_243X	(1 << 1)
-#define RATE_IN_343X	(1 << 2)
-
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
  * CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL CM_CLKSEL2_PLL, CM_CLKSEL_MDM
@@ -57,6 +53,8 @@ struct prcm_config {
 	unsigned char flags;
 };
 
+/* REVISIT: CM_PLL_SEL2 unused */
+
 /* Mask for clksel which support parent settign in set_rate */
 #define SRC_SEL_MASK (CM_CORE_SEL1 | CM_CORE_SEL2 | CM_WKUP_SEL1 | \
 			CM_PLL_SEL1 | CM_PLL_SEL2 | CM_SYSCLKOUT_SEL1)
@@ -628,6 +626,9 @@ static struct clk alt_ck = {		/* Typical
  */
 
 /* dpll_ck, is broken out in to special cases through clksel */
+/* REVISIT: Rate changes on dpll_ck trigger a full set change.	...
+ * deal with this
+ */
 static struct clk dpll_ck = {
 	.name		= "dpll_ck",
 	.parent		= &sys_ck,		/* Can be func_32k also */
@@ -662,6 +663,25 @@ static struct clk apll54_ck = {
 /*
  * PRCM digital base sources
  */
+
+/* func_54m_ck */
+
+static const struct clksel_rate func_54m_apll54_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate func_54m_alt_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel func_54m_clksel[] = {
+	{ .parent = &apll54_ck, .rates = func_54m_apll54_rates, },
+	{ .parent = &alt_ck,	.rates = func_54m_alt_rates, },
+	{ .parent = NULL },
+};
+
 static struct clk func_54m_ck = {
 	.name		= "func_54m_ck",
 	.parent		= &apll54_ck,	/* can also be alt_clk */
@@ -670,6 +690,9 @@ static struct clk func_54m_ck = {
 				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.src_offset	= OMAP24XX_54M_SOURCE_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_54M_SOURCE,
+	.clksel		= func_54m_clksel,
 	.recalc		= &propagate_rate,
 };
 
@@ -681,6 +704,24 @@ static struct clk core_ck = {
 	.recalc		= &followparent_recalc,
 };
 
+/* func_96m_ck */
+static const struct clksel_rate func_96m_apll96_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate func_96m_alt_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_243X | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel func_96m_clksel[] = {
+	{ .parent = &apll96_ck,	.rates = func_96m_apll96_rates },
+	{ .parent = &alt_ck,	.rates = func_96m_alt_rates },
+	{ .parent = NULL }
+};
+
+/* The parent of this clock is not selectable on 2420. */
 static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.parent		= &apll96_ck,
@@ -688,9 +729,30 @@ static struct clk func_96m_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP2430_96M_SOURCE,
+	.clksel		= func_96m_clksel,
 	.recalc		= &propagate_rate,
 };
 
+/* func_48m_ck */
+
+static const struct clksel_rate func_48m_apll96_rates[] = {
+	{ .div = 2, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate func_48m_alt_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel func_48m_clksel[] = {
+	{ .parent = &apll96_ck,	.rates	= func_48m_apll96_rates },
+	{ .parent = &alt_ck, .rates  = func_48m_alt_rates },
+	{ .parent = NULL }
+};
+
 static struct clk func_48m_ck = {
 	.name		= "func_48m_ck",
 	.parent		= &apll96_ck,	 /* 96M or Alt */
@@ -699,6 +761,9 @@ static struct clk func_48m_ck = {
 				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.src_offset	= OMAP24XX_48M_SOURCE_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_48M_SOURCE,
+	.clksel		= func_48m_clksel,
 	.recalc		= &propagate_rate,
 };
 
@@ -719,30 +784,116 @@ static struct clk wdt1_osc_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sys_clkout = {
-	.name		= "sys_clkout",
+/*
+ * The common_clkout* clksel_rate structs are common to
+ * sys_clkout, sys_clkout_src, sys_clkout2, and sys_clkout2_src.
+ * sys_clkout2_* are 2420-only, so the
+ * clksel_rate flags fields are inaccurate for those clocks. This is
+ * harmless since access to those clocks are gated by the struct clk
+ * flags fields, which mark them as 2420-only.
+ */
+static const struct clksel_rate common_clkout_src_core_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate common_clkout_src_sys_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate common_clkout_src_96m_rates[] = {
+	{ .div = 1, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate common_clkout_src_54m_rates[] = {
+	{ .div = 1, .val = 3, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel common_clkout_src_clksel[] = {
+	{ .parent = &core_ck,	  .rates = common_clkout_src_core_rates },
+	{ .parent = &sys_ck,	  .rates = common_clkout_src_sys_rates },
+	{ .parent = &func_96m_ck, .rates = common_clkout_src_96m_rates },
+	{ .parent = &func_54m_ck, .rates = common_clkout_src_54m_rates },
+	{ .parent = NULL }
+};
+
+static struct clk sys_clkout_src = {
+	.name		= "sys_clkout_src",
 	.parent		= &func_54m_ck,
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
+				CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
+				RATE_PROPAGATES,
 	.src_offset	= OMAP24XX_CLKOUT_SOURCE_SHIFT,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP24XX_CLKOUT_SOURCE_MASK,
+	.clksel		= common_clkout_src_clksel,
+	.recalc		= &propagate_rate,
+};
+
+static const struct clksel_rate common_clkout_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 8, .val = 3, .flags = RATE_IN_24XX },
+	{ .div = 16, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 0 },
+};
+
+static const struct clksel sys_clkout_clksel[] = {
+	{ .parent = &sys_clkout_src, .rates = common_clkout_rates },
+	{ .parent = NULL }
+};
+
+static struct clk sys_clkout = {
+	.name		= "sys_clkout",
+	.parent		= &sys_clkout_src,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
+				PARENT_CONTROLS_CLOCK,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
+	.clksel		= sys_clkout_clksel,
 	.rate_offset	= OMAP24XX_CLKOUT_DIV_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
 
 /* In 2430, new in 2420 ES2 */
-static struct clk sys_clkout2 = {
-	.name		= "sys_clkout2",
+static struct clk sys_clkout2_src = {
+	.name		= "sys_clkout2_src",
 	.parent		= &func_54m_ck,
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
 	.src_offset	= OMAP2420_CLKOUT2_SOURCE_SHIFT,
+	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
+				RATE_PROPAGATES,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP2420_CLKOUT2_SOURCE_MASK,
+	.clksel		= common_clkout_src_clksel,
+	.recalc		= &propagate_rate,
+};
+
+static const struct clksel sys_clkout2_clksel[] = {
+	{ .parent = &sys_clkout2_src, .rates = common_clkout_rates },
+	{ .parent = NULL }
+};
+
+/* In 2430, new in 2420 ES2 */
+static struct clk sys_clkout2 = {
+	.name		= "sys_clkout2",
+	.parent		= &sys_clkout2_src,
+	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
+				PARENT_CONTROLS_CLOCK,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
+	.clksel		= sys_clkout2_clksel,
 	.rate_offset	= OMAP2420_CLKOUT2_DIV_SHIFT,
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &propagate_rate,
 };
 
 static struct clk emul_ck = {
@@ -765,6 +916,20 @@ static struct clk emul_ck = {
  * - Base divider comes from: CM_CLKSEL_MPU
  *
  */
+static const struct clksel_rate mpu_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_242X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 0 },
+};
+
+static const struct clksel mpu_clksel[] = {
+	{ .parent = &core_ck, .rates = mpu_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.parent		= &core_ck,
@@ -772,6 +937,9 @@ static struct clk mpu_ck = {	/* Control 
 				ALWAYS_ENABLED | CM_MPU_SEL1 | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.rate_offset	= OMAP24XX_CLKSEL_MPU_SHIFT,	/* bits 0-4 */
+	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
+	.clksel		= mpu_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -781,6 +949,27 @@ static struct clk mpu_ck = {	/* Control 
  *	2430: IVA2.1_FCLK, IVA2.1_ICLK
  *	2420: UMA_FCLK, UMA_ICLK, IVA_MPU, IVA_COP
  */
+/* XXX Okay, this is dumb.  iva2_1fck and dsp_fck are the same clock.
+ * they should just be treated as such.
+ */
+
+/* iva2_1_fck */
+static const struct clksel_rate iva2_1_fck_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
+	{ .div = 0 },
+};
+
+static const struct clksel iva2_1_fck_clksel[] = {
+	{ .parent = &core_ck, .rates = iva2_1_fck_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk iva2_1_fck = {
 	.name		= "iva2_1_fck",
 	.parent		= &core_ck,
@@ -790,15 +979,34 @@ static struct clk iva2_1_fck = {
 	.rate_offset	= OMAP24XX_CLKSEL_DSP_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
+	.clksel		= iva2_1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
+/* iva2_1_ick */
+static const struct clksel_rate iva2_1_ick_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
+	{ .div = 0 },
+};
+
+static const struct clksel iva2_1_ick_clksel[] = {
+	{ .parent = &core_ck, .rates = iva2_1_ick_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.parent		= &iva2_1_fck,
 	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
 	.rate_offset	= OMAP24XX_CLKSEL_DSP_IF_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
+	.clksel		= iva2_1_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -808,6 +1016,22 @@ static struct clk iva2_1_ick = {
  * controls. The other branch gets further divided by 2 then possibly
  * routed into a synchronizer and out of clocks abc.
  */
+static const struct clksel_rate dsp_fck_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
+	{ .div = 0 },
+};
+
+static const struct clksel dsp_fck_clksel[] = {
+	{ .parent = &core_ck, .rates = dsp_fck_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.parent		= &core_ck,
@@ -816,9 +1040,24 @@ static struct clk dsp_fck = {
 	.rate_offset	= OMAP24XX_CLKSEL_DSP_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
+	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static const struct clksel_rate dsp_ick_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
+	{ .div = 0 },
+};
+
+static const struct clksel dsp_ick_clksel[] = {
+	{ .parent = &core_ck, .rates = dsp_ick_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.parent		= &core_ck,
@@ -827,9 +1066,28 @@ static struct clk dsp_ick = {
 	.rate_offset	= OMAP24XX_CLKSEL_DSP_IF_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,		/* for ipi */
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
+	.clksel		= dsp_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static const struct clksel_rate iva1_ifck_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_242X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
+	{ .div = 3, .val = 3, .flags = RATE_IN_242X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_242X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
+	{ .div = 0 },
+};
+
+static const struct clksel iva1_ifck_clksel[] = {
+	{ .parent = &core_ck, .rates = iva1_ifck_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.parent		= &core_ck,
@@ -838,6 +1096,9 @@ static struct clk iva1_ifck = {
 	.rate_offset	= OMAP2420_CLKSEL_IVA_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
+	.clksel		= iva1_ifck_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -871,6 +1132,22 @@ static struct clk iva1_mpu_int_ifck = {
  * may very well need notification when the clock changes. Currently for low
  * operating points, these are taken care of in sleep.S.
  */
+static const struct clksel_rate core_l3_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 6, .val = 6, .flags = RATE_IN_24XX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
+	{ .div = 16, .val = 16, .flags = RATE_IN_242X },
+	{ .div = 0 }
+};
+
+static const struct clksel core_l3_clksel[] = {
+	{ .parent = &core_ck, .rates = core_l3_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.parent		= &core_ck,
@@ -879,9 +1156,25 @@ static struct clk core_l3_ck = {	/* Used
 				DELAYED_APP | CONFIG_PARTICIPANT |
 				RATE_PROPAGATES,
 	.rate_offset	= OMAP24XX_CLKSEL_L3_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
+	.clksel		= core_l3_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
+/* usb_l4_ick */
+static const struct clksel_rate usb_l4_ick_core_l3_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 0 }
+};
+
+static const struct clksel usb_l4_ick_clksel[] = {
+	{ .parent = &core_l3_ck, .rates = usb_l4_ick_core_l3_rates },
+	{ .parent = NULL },
+};
+
 static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.name		= "usb_l4_ick",
 	.parent		= &core_l3_ck,
@@ -891,6 +1184,9 @@ static struct clk usb_l4_ick = {	/* FS-U
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
 	.rate_offset	= OMAP24XX_CLKSEL_USB_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
+	.clksel		= usb_l4_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -902,6 +1198,22 @@ static struct clk usb_l4_ick = {	/* FS-U
  *
  * ssr = core/1/2/3/4/5, sst = 1/2 ssr.
  */
+static const struct clksel_rate ssi_ssr_sst_fck_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_243X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 0 }
+};
+
+static const struct clksel ssi_ssr_sst_fck_clksel[] = {
+	{ .parent = &core_ck, .rates = ssi_ssr_sst_fck_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk ssi_ssr_sst_fck = {
 	.name		= "ssi_fck",
 	.parent		= &core_ck,
@@ -909,6 +1221,9 @@ static struct clk ssi_ssr_sst_fck = {
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),	/* bit 1 */
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_SSI_MASK,
+	.clksel		= ssi_ssr_sst_fck_clksel,
 	.rate_offset	= OMAP24XX_CLKSEL_SSI_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -924,6 +1239,25 @@ static struct clk ssi_ssr_sst_fck = {
  * divided value of fclk.
  *
  */
+/* XXX REVISIT: GFX clock is part of CONFIG_PARTICIPANT, no? doublecheck. */
+
+/*
+ * These clksel_rate/clksel structs are shared between gfx_3d_fck and
+ * gfx_2d_fck
+ */
+static const struct clksel_rate gfx_fck_core_l3_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_243X },
+	{ .div = 0 }
+};
+
+static const struct clksel gfx_fck_clksel[] = {
+	{ .parent = &core_l3_ck, .rates = gfx_fck_core_l3_rates },
+	{ .parent = NULL },
+};
+
 static struct clk gfx_3d_fck = {
 	.name		= "gfx_3d_fck",
 	.parent		= &core_l3_ck,
@@ -932,6 +1266,9 @@ static struct clk gfx_3d_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
 	.rate_offset	= OMAP_CLKSEL_GFX_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
+	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -943,6 +1280,9 @@ static struct clk gfx_2d_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
 	.rate_offset	= OMAP_CLKSEL_GFX_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
+	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -962,6 +1302,19 @@ static struct clk gfx_ick = {
  *		MDM_ICLK
  * These clocks are usable in chassis mode only.
  */
+static const struct clksel_rate mdm_ick_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_243X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_243X | DEFAULT_RATE },
+	{ .div = 6, .val = 6, .flags = RATE_IN_243X },
+	{ .div = 9, .val = 9, .flags = RATE_IN_243X },
+	{ .div = 0 }
+};
+
+static const struct clksel mdm_ick_clksel[] = {
+	{ .parent = &core_ck, .rates = mdm_ick_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
 	.parent		= &core_ck,
@@ -970,6 +1323,9 @@ static struct clk mdm_ick = {		/* used b
 	.rate_offset	= OMAP2430_CLKSEL_MDM_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP2430_CLKSEL_MDM_MASK,
+	.clksel		= mdm_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -989,6 +1345,17 @@ static struct clk mdm_osc_ck = {
  * functional clocks.	Fixed APLL functional source clocks are managed in
  * this domain.
  */
+static const struct clksel_rate l4_core_l3_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 0 }
+};
+
+static const struct clksel l4_clksel[] = {
+	{ .parent = &core_l3_ck, .rates = l4_core_l3_rates },
+	{ .parent = NULL }
+};
+
 static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
 	.parent		= &core_l3_ck,
@@ -996,6 +1363,9 @@ static struct clk l4_ck = {		/* used bot
 				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
 				DELAYED_APP | RATE_PROPAGATES,
 	.rate_offset	= OMAP24XX_CLKSEL_L4_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
+	.clksel		= l4_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1016,6 +1386,33 @@ static struct clk ssi_l4_ick = {
  *
  * DSS is both initiator and target.
  */
+/* XXX Add RATE_NOT_VALIDATED */
+
+static const struct clksel_rate dss1_fck_sys_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate dss1_fck_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_24XX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_24XX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_24XX },
+	{ .div = 9, .val = 9, .flags = RATE_IN_24XX },
+	{ .div = 12, .val = 12, .flags = RATE_IN_24XX },
+	{ .div = 16, .val = 16, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel dss1_fck_clksel[] = {
+	{ .parent = &sys_ck, .rates  = dss1_fck_sys_rates },
+	{ .parent = &core_ck,.rates  = dss1_fck_core_rates },
+	{ .parent = NULL },
+};
+
 static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.name		= "dss_ick",
 	.parent		= &l4_ck,	/* really both l3 and l4 */
@@ -1034,9 +1431,28 @@ static struct clk dss1_fck = {
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
 	.rate_offset	= OMAP24XX_CLKSEL_DSS1_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_DSS1_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSS1_MASK,
+	.clksel		= dss1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static const struct clksel_rate dss2_fck_sys_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate dss2_fck_48m_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel dss2_fck_clksel[] = {
+	{ .parent = &sys_ck,	  .rates = dss2_fck_sys_rates },
+	{ .parent = &func_48m_ck, .rates = dss2_fck_48m_rates },
+	{ .parent = NULL }
+};
+
 static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.name		= "dss2_fck",
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
@@ -1046,6 +1462,9 @@ static struct clk dss2_fck = {		/* Alt c
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_DSS2_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSS2_MASK,
+	.clksel		= dss2_fck_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1064,6 +1483,28 @@ static struct clk dss_54m_fck = {	/* Alt
  * here will likely have an L4 interface parent, and may have multiple
  * functional clock parents.
  */
+static const struct clksel_rate gpt_32k_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate gpt_sys_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate gpt_alt_rates[] = {
+	{ .div = 1, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel gpt_clksel[] = {
+	{ .parent = &func_32k_ck, .rates = gpt_32k_rates },
+	{ .parent = &sys_ck,	  .rates = gpt_sys_rates },
+	{ .parent = &alt_ck,	  .rates = gpt_alt_rates },
+	{ .parent = NULL },
+};
+
 static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
 	.parent		= &l4_ck,
@@ -1081,6 +1522,9 @@ static struct clk gpt1_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),	/* Bit0 */
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT1_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1101,6 +1545,9 @@ static struct clk gpt2_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT2_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT2_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1121,6 +1568,9 @@ static struct clk gpt3_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT3_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT3_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1141,6 +1591,9 @@ static struct clk gpt4_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT4_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT4_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1161,6 +1614,9 @@ static struct clk gpt5_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT5_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT5_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1168,8 +1624,8 @@ static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit8 */
+	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1181,6 +1637,9 @@ static struct clk gpt6_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT6_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT6_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1201,6 +1660,9 @@ static struct clk gpt7_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT7_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT7_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1221,6 +1683,9 @@ static struct clk gpt8_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT8_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT8_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1241,6 +1706,9 @@ static struct clk gpt9_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT9_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT9_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1261,6 +1729,9 @@ static struct clk gpt10_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT10_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT10_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1281,6 +1752,9 @@ static struct clk gpt11_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT11_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT11_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1301,15 +1775,17 @@ static struct clk gpt12_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT12_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT12_MASK,
+	.clksel		= gpt_clksel,
 	.recalc		= &followparent_recalc,
 };
 
-/* REVISIT: bit comment below wrong? */
 static struct clk mcbsp1_ick = {
 	.name		= "mcbsp1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit16 */
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1800,6 +2276,31 @@ static struct clk vlynq_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static const struct clksel_rate vlynq_fck_96m_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_242X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate vlynq_fck_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_242X },
+	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
+	{ .div = 3, .val = 3, .flags = RATE_IN_242X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_242X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 9, .val = 9, .flags = RATE_IN_242X },
+	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
+	{ .div = 16, .val = 16, .flags = RATE_IN_242X | DEFAULT_RATE },
+	{ .div = 18, .val = 18, .flags = RATE_IN_242X },
+	{ .div = 0 }
+};
+
+static const struct clksel vlynq_fck_clksel[] = {
+	{ .parent = &func_96m_ck, .rates = vlynq_fck_96m_rates },
+	{ .parent = &core_ck,	  .rates = vlynq_fck_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.parent		= &func_96m_ck,
@@ -1807,6 +2308,9 @@ static struct clk vlynq_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
 	.src_offset	= OMAP2420_CLKSEL_VLYNQ_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
+	.clksel		= vlynq_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2004,7 +2508,9 @@ static struct clk *onchip_clks[] __initd
 	&func_48m_ck,
 	&func_12m_ck,
 	&wdt1_osc_ck,
+	&sys_clkout_src,
 	&sys_clkout,
+	&sys_clkout2_src,
 	&sys_clkout2,
 	&emul_ck,
 	/* mpu domain clocks */
Index: linux-omap/arch/arm/mach-omap2/board-n800-audio.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-n800-audio.c
+++ linux-omap/arch/arm/mach-omap2/board-n800-audio.c
@@ -35,6 +35,7 @@
 #define AUDIO_ENABLED
 
 static struct clk *sys_clkout2;
+static struct clk *sys_clkout2_src;
 static struct clk *func96m_clk;
 static struct device *eac_device;
 static struct device *tsc2301_device;
@@ -186,9 +187,15 @@ static void n800_eac_cleanup(struct devi
 
 static int n800_codec_get_clocks(struct device *dev)
 {
+	sys_clkout2_src = clk_get(dev, "sys_clkout2_src");
+	if (IS_ERR(sys_clkout2_src)) {
+		dev_err(dev, "Could not get sys_clkout2_src clock\n");
+		return -ENODEV;
+	}
 	sys_clkout2 = clk_get(dev, "sys_clkout2");
 	if (IS_ERR(sys_clkout2)) {
-		dev_err(dev, "Could not get sys_clkout2\n");
+		dev_err(dev, "Could not get sys_clkout2 clock\n");
+		clk_put(sys_clkout2_src);
 		return -ENODEV;
 	}
 	/* configure 12 MHz output on SYS_CLKOUT2. Therefore we must use
@@ -197,10 +204,11 @@ static int n800_codec_get_clocks(struct 
 	if (IS_ERR(func96m_clk)) {
 		dev_err(dev, "Could not get func 96M clock\n");
 		clk_put(sys_clkout2);
+		clk_put(sys_clkout2_src);
 		return -ENODEV;
 	}
 
-	clk_set_parent(sys_clkout2, func96m_clk);
+	clk_set_parent(sys_clkout2_src, func96m_clk);
 	clk_set_rate(sys_clkout2, 12000000);
 
 	return 0;
@@ -210,6 +218,7 @@ static void n800_codec_put_clocks(struct
 {
 	clk_put(func96m_clk);
 	clk_put(sys_clkout2);
+	clk_put(sys_clkout2_src);
 }
 
 static int n800_codec_enable_clock(struct device *dev)

-- 
