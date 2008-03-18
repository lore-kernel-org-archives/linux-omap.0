From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/17] ARM: OMAP: Add rest of 24xx clocks
Date: Tue, 18 Mar 2008 16:02:09 +0200
Message-ID: <1205848935-12078-12-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-03-18-160209
	<1205848935-12078-1-git-send-email-tony@atomide.com>
	<1205848935-12078-2-git-send-email-tony@atomide.com>
	<1205848935-12078-3-git-send-email-tony@atomide.com>
	<1205848935-12078-4-git-send-email-tony@atomide.com>
	<1205848935-12078-5-git-send-email-tony@atomide.com>
	<1205848935-12078-6-git-send-email-tony@atomide.com>
	<1205848935-12078-7-git-send-email-tony@atomide.com>
	<1205848935-12078-8-git-send-email-tony@atomide.com>
	<1205848935-12078-9-git-send-email-tony@atomide.com>
	<1205848935-12078-10-git-send-email-tony@atomide.com>
	<1205848935-12078-11-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1205848935-12078-11-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

This patch adds the rest of clocks for 24xx.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock24xx.h | 1487 +++++++++++++++++++++++++--------------
 1 files changed, 957 insertions(+), 530 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 9363c20..559eade 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -621,41 +621,42 @@ static struct prcm_config rate_table[] = {
  *	clocks.
  *-------------------------------------------------------------------------*/
 
-#ifdef OLD_CK
 /* Base external input clocks */
 static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.rate		= 32000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED,
+				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+	.recalc		= &propagate_rate,
 };
-#endif	/* OLD_CK */
+
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
 static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 	.name		= "osc_ck",
-	.rate		= 26000000,		/* fixed up in clock init */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
+				RATE_PROPAGATES,
+	.enable		= &omap2_enable_osc_ck,
+	.disable	= &omap2_disable_osc_ck,
+	.recalc		= &omap2_osc_clk_recalc,
 };
 
 /* With out modem likely 12MHz, with modem likely 13MHz */
 static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
 	.parent		= &osc_ck,
-	.rate		= 13000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+				ALWAYS_ENABLED | RATE_PROPAGATES,
 	.recalc		= &omap2_sys_clk_recalc,
 };
-#ifdef OLD_CK
+
 static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &propagate_rate,
 };
-#endif	/* OLD_CK */
+
 /*
  * Analog domain root source clocks
  */
@@ -710,19 +711,37 @@ static struct clk apll54_ck = {
 /*
  * PRCM digital base sources
  */
-#ifdef OLD_CK
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
-	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
-	.src_offset	= 5,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
-	.recalc		= &omap2_propagate_rate,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_54M_SOURCE,
+	.clksel		= func_54m_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
-#endif	/* OLD_CK */
+
 static struct clk core_ck = {
 	.name		= "core_ck",
 	.parent		= &dpll_ck,		/* can also be 32k */
@@ -730,47 +749,78 @@ static struct clk core_ck = {
 				ALWAYS_ENABLED | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
-#ifdef OLD_CK
-static struct clk sleep_ck = {		/* sys_clk or 32k */
-	.name		= "sleep_ck",
-	.parent		= &func_32k_ck,
-	.rate		= 32000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.recalc		= &omap2_propagate_rate,
+
+/* func_96m_ck */
+static const struct clksel_rate func_96m_apll96_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
 };
 
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
-	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
-	.recalc		= &omap2_propagate_rate,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP2430_96M_SOURCE,
+	.clksel		= func_96m_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
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
+	{ .parent = &apll96_ck,	.rates = func_48m_apll96_rates },
+	{ .parent = &alt_ck, .rates = func_48m_alt_rates },
+	{ .parent = NULL }
 };
 
 static struct clk func_48m_ck = {
 	.name		= "func_48m_ck",
 	.parent		= &apll96_ck,	 /* 96M or Alt */
-	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
-	.src_offset	= 3,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
-	.recalc		= &omap2_propagate_rate,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_48M_SOURCE,
+	.clksel		= func_48m_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk func_12m_ck = {
 	.name		= "func_12m_ck",
 	.parent		= &func_48m_ck,
-	.rate		= 12000000,
+	.fixed_div	= 4,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
 /* Secure timer, only available in secure mode */
@@ -778,46 +828,132 @@ static struct clk wdt1_osc_ck = {
 	.name		= "ck_wdt1_osc",
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
+};
+
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
+	.parent		= &func_54m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_PROPAGATES,
+	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP24XX_CLKOUT_SOURCE_MASK,
+	.clksel		= common_clkout_src_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
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
 };
 
 static struct clk sys_clkout = {
 	.name		= "sys_clkout",
-	.parent		= &func_54m_ck,
-	.rate		= 54000000,
+	.parent		= &sys_clkout_src,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
-	.src_offset	= 0,
-	.enable_reg	= (void __iomem *)&PRCM_CLKOUT_CTRL,
-	.enable_bit	= 7,
-	.rate_offset	= 3,
+				PARENT_CONTROLS_CLOCK,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
+	.clksel		= sys_clkout_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
+/* In 2430, new in 2420 ES2 */
+static struct clk sys_clkout2_src = {
+	.name		= "sys_clkout2_src",
+	.parent		= &func_54m_ck,
+	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES,
+	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP2420_CLKOUT2_SOURCE_MASK,
+	.clksel		= common_clkout_src_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
+static const struct clksel sys_clkout2_clksel[] = {
+	{ .parent = &sys_clkout2_src, .rates = common_clkout_rates },
+	{ .parent = NULL }
 };
 
 /* In 2430, new in 2420 ES2 */
 static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
-	.parent		= &func_54m_ck,
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
-	.src_offset	= 8,
-	.enable_reg	= (void __iomem *)&PRCM_CLKOUT_CTRL,
-	.enable_bit	= 15,
-	.rate_offset	= 11,
+	.parent		= &sys_clkout2_src,
+	.flags		= CLOCK_IN_OMAP242X | PARENT_CONTROLS_CLOCK,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
+	.clksel		= sys_clkout2_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk emul_ck = {
 	.name		= "emul_ck",
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&PRCM_CLKEMUL_CTRL,
-	.enable_bit	= 0,
-	.recalc		= &omap2_propagate_rate,
+	.enable_reg	= OMAP24XX_PRCM_CLKEMUL_CTRL,
+	.enable_bit	= OMAP24XX_EMULATION_EN_SHIFT,
+	.recalc		= &followparent_recalc,
 
 };
-#endif	/* OLD_CK */
+
 /*
  * MPU clock domain
  *	Clocks:
@@ -828,6 +964,20 @@ static struct clk emul_ck = {
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
@@ -837,85 +987,126 @@ static struct clk mpu_ck = {	/* Control cpu */
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
+	.clksel		= mpu_clksel,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate     = &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate
 };
-#ifdef OLD_CK
+
 /*
  * DSP (2430-IVA2.1) (2420-UMA+IVA1) clock domain
  * Clocks:
- *	2430: IVA2.1_FCLK, IVA2.1_ICLK
+ *	2430: IVA2.1_FCLK (really just DSP_FCLK), IVA2.1_ICLK
  *	2420: UMA_FCLK, UMA_ICLK, IVA_MPU, IVA_COP
+ *
+ * Won't be too specific here. The core clock comes into this block
+ * it is divided then tee'ed. One branch goes directly to xyz enable
+ * controls. The other branch gets further divided by 2 then possibly
+ * routed into a synchronizer and out of clocks abc.
  */
-static struct clk iva2_1_fck = {
-	.name		= "iva2_1_fck",
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
+static struct clk dsp_fck = {
+	.name		= "dsp_fck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
-				DELAYED_APP | RATE_PROPAGATES |
-				CONFIG_PARTICIPANT,
-	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 0,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
+				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
+	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
-static struct clk iva2_1_ick = {
-	.name		= "iva2_1_ick",
-	.parent		= &iva2_1_fck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= 5,
-	.recalc		= &omap2_clksel_recalc,
+/* DSP interface clock */
+static const struct clksel_rate dsp_irate_ick_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
+	{ .div = 0 },
+};
+
+static const struct clksel dsp_irate_ick_clksel[] = {
+	{ .parent = &dsp_fck, .rates = dsp_irate_ick_rates },
+	{ .parent = NULL }
 };
 
 /*
- * Won't be too specific here. The core clock comes into this block
- * it is divided then tee'ed. One branch goes directly to xyz enable
- * controls. The other branch gets further divided by 2 then possibly
- * routed into a synchronizer and out of clocks abc.
+ * This clock does not exist as such in the TRM, but is added to
+ * separate source selection from  XXX
  */
-static struct clk dsp_fck = {
-	.name		= "dsp_fck",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
-			DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 0,
+static struct clk dsp_irate_ick = {
+	.name		= "dsp_irate_ick",
+	.parent		= &dsp_fck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
+				CONFIG_PARTICIPANT | PARENT_CONTROLS_CLOCK,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
+	.clksel		= dsp_irate_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	      = &omap2_clksel_set_rate
 };
 
+/* 2420 only */
 static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
-	.parent		= &dsp_fck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset = 5,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_DSP,
-	.enable_bit	= 1,		/* for ipi */
-	.recalc		= &omap2_clksel_recalc,
+	.parent		= &dsp_irate_ick,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
+};
+
+/* 2430 only - EN_DSP controls both dsp fclk and iclk on 2430 */
+static struct clk iva2_1_ick = {
+	.name		= "iva2_1_ick",
+	.parent		= &dsp_irate_ick,
+	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 };
 
 static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 | RATE_CKCTL |
-			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
-	.rate_offset= 8,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 10,
+	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT |
+				RATE_PROPAGATES | DELAYED_APP,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
+	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* IVA1 mpu/int/i/f clocks are /2 of parent */
 static struct clk iva1_mpu_int_ifck = {
 	.name		= "iva1_mpu_int_ifck",
 	.parent		= &iva1_ifck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 8,
-	.recalc		= &omap2_clksel_recalc,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
+	.fixed_div	= 2,
+	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
 /*
@@ -937,27 +1128,62 @@ static struct clk iva1_mpu_int_ifck = {
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
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT |
-				RATE_PROPAGATES,
-	.rate_offset	= 0,
+				ALWAYS_ENABLED | DELAYED_APP |
+				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
+	.clksel		= core_l3_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
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
 };
 
 static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.name		= "usb_l4_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP |
-				CONFIG_PARTICIPANT,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 0,
-	.rate_offset = 25,
+				DELAYED_APP | CONFIG_PARTICIPANT,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
+	.clksel		= usb_l4_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -968,15 +1194,35 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
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
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,	/* bit 1 */
-	.enable_bit	= 1,
-	.rate_offset = 20,
+				DELAYED_APP,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_SSI_MASK,
+	.clksel		= ssi_ssr_sst_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -990,36 +1236,49 @@ static struct clk ssi_ssr_sst_fck = {
  * divided value of fclk.
  *
  */
+/* XXX REVISIT: GFX clock is part of CONFIG_PARTICIPANT, no? doublecheck. */
+
+/* This clksel struct is shared between gfx_3d_fck and gfx_2d_fck */
+static const struct clksel gfx_fck_clksel[] = {
+	{ .parent = &core_l3_ck, .rates = gfx_l3_rates },
+	{ .parent = NULL },
+};
+
 static struct clk gfx_3d_fck = {
 	.name		= "gfx_3d_fck",
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_GFX_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
-	.enable_bit	= 2,
-	.rate_offset= 0,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
+	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_GFX_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
-	.enable_bit	= 1,
-	.rate_offset= 0,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
+	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk gfx_ick = {
 	.name		= "gfx_ick",		/* From l3 */
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_GFX,	/* bit 0 */
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP_EN_GFX_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -1027,26 +1286,42 @@ static struct clk gfx_ick = {
  *	CLOCKS:
  *		MDM_OSC_CLK
  *		MDM_ICLK
+ * These clocks are usable in chassis mode only.
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
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_MODEM_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_MDM,
-	.enable_bit	= 0,
+	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP2430_CLKSEL_MDM_MASK,
+	.clksel		= mdm_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk mdm_osc_ck = {
 	.name		= "mdm_osc_ck",
-	.rate		= 26000000,
 	.parent		= &osc_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_FIXED,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_MDM,
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP2430_EN_OSC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -1056,23 +1331,37 @@ static struct clk mdm_osc_ck = {
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
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
-				DELAYED_APP | RATE_PROPAGATES,
-	.rate_offset	= 5,
+				ALWAYS_ENABLED | DELAYED_APP | RATE_PROPAGATES,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
+	.clksel		= l4_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,	/* bit 1 */
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -1083,48 +1372,95 @@ static struct clk ssi_l4_ick = {
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
+	{ .parent = &sys_ck,  .rates = dss1_fck_sys_rates },
+	{ .parent = &core_ck, .rates = dss1_fck_core_rates },
+	{ .parent = NULL },
+};
+
 static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.name		= "dss_ick",
 	.parent		= &l4_ck,	/* really both l3 and l4 */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk dss1_fck = {
 	.name		= "dss1_fck",
 	.parent		= &core_ck,		/* Core or sys */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 0,
-	.rate_offset	= 8,
-	.src_offset	= 8,
+				DELAYED_APP,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSS1_MASK,
+	.clksel		= dss1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
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
 };
 
 static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.name		= "dss2_fck",
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | RATE_FIXED |
 				DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 1,
-	.src_offset	= 13,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSS2_MASK,
+	.clksel		= dss2_fck_clksel,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.name		= "dss_54m_fck",	/* 54m tv clk */
 	.parent		= &func_54m_ck,
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_propagate_rate,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_TV_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -1133,334 +1469,372 @@ static struct clk dss_54m_fck = {	/* Alt clk used in power management */
  * here will likely have an L4 interface parent, and may have multiple
  * functional clock parents.
  */
+static const struct clksel_rate gpt_alt_rates[] = {
+	{ .div = 1, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel omap24xx_gpt_clksel[] = {
+	{ .parent = &func_32k_ck, .rates = gpt_32k_rates },
+	{ .parent = &sys_ck,	  .rates = gpt_sys_rates },
+	{ .parent = &alt_ck,	  .rates = gpt_alt_rates },
+	{ .parent = NULL },
+};
+
 static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,	/* Bit0 */
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_WKUP_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,	/* Bit0 */
-	.enable_bit	= 0,
-	.src_offset	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit4 */
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 4,
-	.src_offset	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT2_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit5 */
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt3_fck = {
 	.name		= "gpt3_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 5,
-	.src_offset	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT3_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt4_ick = {
 	.name		= "gpt4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit6 */
-	.enable_bit	= 6,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt4_fck = {
 	.name		= "gpt4_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 6,
-	.src_offset	= 6,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT4_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt5_ick = {
 	.name		= "gpt5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* Bit7 */
-	.enable_bit	= 7,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt5_fck = {
 	.name		= "gpt5_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 7,
-	.src_offset	= 8,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT5_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 8,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit8 */
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt6_fck = {
 	.name		= "gpt6_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 8,
-	.src_offset	= 10,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT6_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit9 */
-	.enable_bit	= 9,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt7_fck = {
 	.name		= "gpt7_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 9,
-	.src_offset	= 12,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT7_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt8_ick = {
 	.name		= "gpt8_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit10 */
-	.enable_bit	= 10,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt8_fck = {
 	.name		= "gpt8_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 10,
-	.src_offset	= 14,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT8_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 11,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt9_fck = {
 	.name		= "gpt9_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 11,
-	.src_offset	= 16,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT9_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt10_ick = {
 	.name		= "gpt10_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 12,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt10_fck = {
 	.name		= "gpt10_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 12,
-	.src_offset	= 18,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT10_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt11_ick = {
 	.name		= "gpt11_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 13,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt11_fck = {
 	.name		= "gpt11_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 13,
-	.src_offset	= 20,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT11_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit14 */
-	.enable_bit	= 14,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 14,
-	.src_offset	= 22,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT12_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk mcbsp1_ick = {
 	.name		= "mcbsp1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 15,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit16 */
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp1_fck = {
 	.name		= "mcbsp1_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 15,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp2_ick = {
 	.name		= "mcbsp2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 16,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp2_fck = {
 	.name		= "mcbsp2_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 16,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp3_ick = {
 	.name		= "mcbsp3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp3_fck = {
 	.name		= "mcbsp3_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp4_ick = {
 	.name		= "mcbsp4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp4_fck = {
 	.name		= "mcbsp4_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp5_ick = {
 	.name		= "mcbsp5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp5_fck = {
 	.name		= "mcbsp5_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi1_ick = {
@@ -1468,9 +1842,9 @@ static struct clk mcspi1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 17,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi1_fck = {
@@ -1478,9 +1852,9 @@ static struct clk mcspi1_fck = {
 	.id		= 1,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 17,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi2_ick = {
@@ -1488,9 +1862,9 @@ static struct clk mcspi2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 18,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi2_fck = {
@@ -1498,9 +1872,9 @@ static struct clk mcspi2_fck = {
 	.id		= 2,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 18,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi3_ick = {
@@ -1508,9 +1882,9 @@ static struct clk mcspi3_ick = {
 	.id		= 3,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 9,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi3_fck = {
@@ -1518,285 +1892,285 @@ static struct clk mcspi3_fck = {
 	.id		= 3,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 9,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart1_ick = {
 	.name		= "uart1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 21,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart1_fck = {
 	.name		= "uart1_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 21,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart2_ick = {
 	.name		= "uart2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 22,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart2_fck = {
 	.name		= "uart2_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 22,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart3_ick = {
 	.name		= "uart3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart3_fck = {
 	.name		= "uart3_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpios_ick = {
 	.name		= "gpios_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpios_fck = {
 	.name		= "gpios_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mpu_wdt_fck = {
 	.name		= "mpu_wdt_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_WDT1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_OMAPCTRL_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 static struct clk icr_ick = {
 	.name		= "icr_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 6,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP2430_EN_ICR_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk cam_ick = {
 	.name		= "cam_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 31,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk cam_fck = {
 	.name		= "cam_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 31,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mailboxes_ick = {
 	.name		= "mailboxes_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 30,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MAILBOXES_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt4_ick = {
 	.name		= "wdt4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 29,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt4_fck = {
 	.name		= "wdt4_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 29,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt3_ick = {
 	.name		= "wdt3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 28,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt3_fck = {
 	.name		= "wdt3_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 28,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mspro_ick = {
 	.name		= "mspro_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 27,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mspro_fck = {
 	.name		= "mspro_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 27,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmc_ick = {
 	.name		= "mmc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 26,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmc_fck = {
 	.name		= "mmc_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 26,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk fac_ick = {
 	.name		= "fac_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 25,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk fac_fck = {
 	.name		= "fac_fck",
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 25,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk eac_ick = {
 	.name		= "eac_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 24,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk eac_fck = {
 	.name		= "eac_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 24,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk hdq_ick = {
 	.name		= "hdq_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 23,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk hdq_fck = {
 	.name		= "hdq_fck",
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 23,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c2_ick = {
@@ -1804,28 +2178,29 @@ static struct clk i2c2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 20,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c2_fck = {
 	.name		= "i2c_fck",
 	.id		= 2,
 	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 20,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2chs2_fck = {
-	.name		= "i2chs2_fck",
+	.name		= "i2chs_fck",
+	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 20,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_I2CHS2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c1_ick = {
@@ -1833,202 +2208,260 @@ static struct clk i2c1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 19,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c1_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
 	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 19,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2chs1_fck = {
-	.name		= "i2chs1_fck",
+	.name		= "i2chs_fck",
+	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 19,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_I2CHS1_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpmc_fck = {
+	.name		= "gpmc_fck",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sdma_fck = {
+	.name		= "sdma_fck",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sdma_ick = {
+	.name		= "sdma_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk vlynq_ick = {
 	.name		= "vlynq_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
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
 };
 
 static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X  | RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 3,
-	.src_offset	= 15,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
+	.clksel		= vlynq_fck_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN3_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
+	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk des_ick = {
 	.name		= "des_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_bit	= OMAP24XX_EN_DES_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk sha_ick = {
 	.name		= "sha_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_bit	= OMAP24XX_EN_SHA_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk rng_ick = {
 	.name		= "rng_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_bit	= OMAP24XX_EN_RNG_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk aes_ick = {
 	.name		= "aes_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_bit	= OMAP24XX_EN_AES_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk pka_ick = {
 	.name		= "pka_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_bit	= OMAP24XX_EN_PKA_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk usb_fck = {
 	.name		= "usb_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk usbhs_ick = {
 	.name		= "usbhs_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 6,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_USBHS_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs1_ick = {
-	.name		= "mmchs1_ick",
+	.name		= "mmchs_ick",
+	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 7,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs1_fck = {
-	.name		= "mmchs1_fck",
+	.name		= "mmchs_fck",
+	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 7,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs2_ick = {
-	.name		= "mmchs2_ick",
+	.name		= "mmchs_ick",
+	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 8,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs2_fck = {
-	.name		= "mmchs2_fck",
+	.name		= "mmchs_fck",
+	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 8,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 10,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpio5_fck = {
 	.name		= "gpio5_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 10,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mdm_intc_ick = {
 	.name		= "mdm_intc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 11,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MDM_INTC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchsdb1_fck = {
-	.name		= "mmchsdb1_fck",
+	.name		= "mmchsdb_fck",
+	.id		= 1,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 16,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHSDB1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchsdb2_fck = {
-	.name		= "mmchsdb2_fck",
+	.name		= "mmchsdb_fck",
+	.id		= 2,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 17,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHSDB2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
-#endif	/* OLD_CK */
+
 /*
  * This clock is a composite clock which does entire set changes then
  * forces a rebalance. It keys on the MPU speed, but it really could
@@ -2048,11 +2481,12 @@ static struct clk virt_prcm_set = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				VIRTUAL_CLOCK | ALWAYS_ENABLED | DELAYED_APP,
 	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
+	.recalc		= &omap2_table_mpu_recalc,	/* sets are keyed on mpu rate */
 	.set_rate	= &omap2_select_table_rate,
 	.round_rate	= &omap2_round_to_table_rate,
 };
-#ifdef OLD_CK
-static struct clk *onchip_clks[] = {
+
+static struct clk *onchip_24xx_clks[] __initdata = {
 	/* external root sources */
 	&func_32k_ck,
 	&osc_ck,
@@ -2065,23 +2499,24 @@ static struct clk *onchip_clks[] = {
 	/* internal prcm root sources */
 	&func_54m_ck,
 	&core_ck,
-	&sleep_ck,
 	&func_96m_ck,
 	&func_48m_ck,
 	&func_12m_ck,
 	&wdt1_osc_ck,
+	&sys_clkout_src,
 	&sys_clkout,
+	&sys_clkout2_src,
 	&sys_clkout2,
 	&emul_ck,
 	/* mpu domain clocks */
 	&mpu_ck,
 	/* dsp domain clocks */
-	&iva2_1_fck,		/* 2430 */
-	&iva2_1_ick,
-	&dsp_ick,		/* 2420 */
 	&dsp_fck,
-	&iva1_ifck,
-	&iva1_mpu_int_ifck,
+	&dsp_irate_ick,
+	&dsp_ick,		/* 242x */
+	&iva2_1_ick,		/* 243x */
+	&iva1_ifck,		/* 242x */
+	&iva1_mpu_int_ifck,	/* 242x */
 	/* GFX domain clocks */
 	&gfx_3d_fck,
 	&gfx_2d_fck,
@@ -2181,6 +2616,9 @@ static struct clk *onchip_clks[] = {
 	&i2c2_ick,
 	&i2c2_fck,
 	&i2chs2_fck,
+	&gpmc_fck,
+	&sdma_fck,
+	&sdma_ick,
 	&vlynq_ick,
 	&vlynq_fck,
 	&sdrc_ick,
@@ -2201,17 +2639,6 @@ static struct clk *onchip_clks[] = {
 	&mmchsdb1_fck,
 	&mmchsdb2_fck,
 };
-#endif	/* OLD_CK */
-
-static struct clk *onchip_24xx_clks[] __initdata = {
-	/* external root sources */
-	&osc_ck,
-	&sys_ck,
-	/* internal analog sources */
-	&dpll_ck,
-	&apll96_ck,
-	&apll54_ck,
-};
 
 #endif
 
-- 
1.5.3.6


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
