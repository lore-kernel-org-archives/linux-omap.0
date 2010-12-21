From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 4/6] omap3: mark some data as omap3-specific
Date: Tue, 21 Dec 2010 19:20:02 +0100
Message-ID: <1292955604-8809-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44903 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab0LUSUs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 13:20:48 -0500
In-Reply-To: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Petazzoni <tpetazzoni@ti.com>, Thomas Petazzoni <t-petazzoni@ti.com>

From: Thomas Petazzoni <tpetazzoni@ti.com>

Use __omap3_data on clock related data and hwmod related data for
OMAP3 SoCs. This data will later be freed if we end up booting on a
non-OMAP3 SoC.

Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c       |  486 ++++++++++++++--------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  180 +++++-----
 2 files changed, 333 insertions(+), 333 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d85ecd5..1d11bea 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -54,56 +54,56 @@
  */
 
 /* Forward declarations for DPLL bypass clocks */
-static struct clk dpll1_fck;
-static struct clk dpll2_fck;
+static struct clk __omap3_data dpll1_fck;
+static struct clk __omap3_data dpll2_fck;
 
 /* PRM CLOCKS */
 
 /* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. */
-static struct clk omap_32k_fck = {
+static struct clk __omap3_data omap_32k_fck = {
 	.name		= "omap_32k_fck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
 };
 
-static struct clk secure_32k_fck = {
+static struct clk __omap3_data secure_32k_fck = {
 	.name		= "secure_32k_fck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
 };
 
 /* Virtual source clocks for osc_sys_ck */
-static struct clk virt_12m_ck = {
+static struct clk __omap3_data virt_12m_ck = {
 	.name		= "virt_12m_ck",
 	.ops		= &clkops_null,
 	.rate		= 12000000,
 };
 
-static struct clk virt_13m_ck = {
+static struct clk __omap3_data virt_13m_ck = {
 	.name		= "virt_13m_ck",
 	.ops		= &clkops_null,
 	.rate		= 13000000,
 };
 
-static struct clk virt_16_8m_ck = {
+static struct clk __omap3_data virt_16_8m_ck = {
 	.name		= "virt_16_8m_ck",
 	.ops		= &clkops_null,
 	.rate		= 16800000,
 };
 
-static struct clk virt_19_2m_ck = {
+static struct clk __omap3_data virt_19_2m_ck = {
 	.name		= "virt_19_2m_ck",
 	.ops		= &clkops_null,
 	.rate		= 19200000,
 };
 
-static struct clk virt_26m_ck = {
+static struct clk __omap3_data virt_26m_ck = {
 	.name		= "virt_26m_ck",
 	.ops		= &clkops_null,
 	.rate		= 26000000,
 };
 
-static struct clk virt_38_4m_ck = {
+static struct clk __omap3_data virt_38_4m_ck = {
 	.name		= "virt_38_4m_ck",
 	.ops		= &clkops_null,
 	.rate		= 38400000,
@@ -151,7 +151,7 @@ static const struct clksel osc_sys_clksel[] = {
 
 /* Oscillator clock */
 /* 12, 13, 16.8, 19.2, 26, or 38.4 MHz */
-static struct clk osc_sys_ck = {
+static struct clk __omap3_data osc_sys_ck = {
 	.name		= "osc_sys_ck",
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
@@ -175,7 +175,7 @@ static const struct clksel sys_clksel[] = {
 
 /* Latency: this clock is only enabled after PRM_CLKSETUP.SETUP_TIME */
 /* Feeds DPLLs - divided first by PRM_CLKSRC_CTRL.SYSCLKDIV? */
-static struct clk sys_ck = {
+static struct clk __omap3_data sys_ck = {
 	.name		= "sys_ck",
 	.ops		= &clkops_null,
 	.parent		= &osc_sys_ck,
@@ -186,20 +186,20 @@ static struct clk sys_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk sys_altclk = {
+static struct clk __omap3_data sys_altclk = {
 	.name		= "sys_altclk",
 	.ops		= &clkops_null,
 };
 
 /* Optional external clock input for some McBSPs */
-static struct clk mcbsp_clks = {
+static struct clk __omap3_data mcbsp_clks = {
 	.name		= "mcbsp_clks",
 	.ops		= &clkops_null,
 };
 
 /* PRM EXTERNAL CLOCK OUTPUT */
 
-static struct clk sys_clkout1 = {
+static struct clk __omap3_data sys_clkout1 = {
 	.name		= "sys_clkout1",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &osc_sys_ck,
@@ -271,7 +271,7 @@ static const struct clksel_rate dpll4_rates[] = {
 /* DPLL1 */
 /* MPU clock source */
 /* Type: DPLL */
-static struct dpll_data dpll1_dd = {
+static struct dpll_data __omap3_data dpll1_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.mult_mask	= OMAP3430_MPU_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_MPU_DPLL_DIV_MASK,
@@ -294,7 +294,7 @@ static struct dpll_data dpll1_dd = {
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
-static struct clk dpll1_ck = {
+static struct clk __omap3_data dpll1_ck = {
 	.name		= "dpll1_ck",
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
@@ -309,7 +309,7 @@ static struct clk dpll1_ck = {
  * This virtual clock provides the CLKOUTX2 output from the DPLL if the
  * DPLL isn't bypassed.
  */
-static struct clk dpll1_x2_ck = {
+static struct clk __omap3_data dpll1_x2_ck = {
 	.name		= "dpll1_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll1_ck,
@@ -327,7 +327,7 @@ static const struct clksel div16_dpll1_x2m2_clksel[] = {
  * Does not exist in the TRM - needed to separate the M2 divider from
  * bypass selection in mpu_ck
  */
-static struct clk dpll1_x2m2_ck = {
+static struct clk __omap3_data dpll1_x2m2_ck = {
 	.name		= "dpll1_x2m2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll1_x2_ck,
@@ -343,7 +343,7 @@ static struct clk dpll1_x2m2_ck = {
 /* IVA2 clock source */
 /* Type: DPLL */
 
-static struct dpll_data dpll2_dd = {
+static struct dpll_data __omap3_data dpll2_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.mult_mask	= OMAP3430_IVA2_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_IVA2_DPLL_DIV_MASK,
@@ -367,7 +367,7 @@ static struct dpll_data dpll2_dd = {
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
-static struct clk dpll2_ck = {
+static struct clk __omap3_data dpll2_ck = {
 	.name		= "dpll2_ck",
 	.ops		= &clkops_omap3_noncore_dpll_ops,
 	.parent		= &sys_ck,
@@ -387,7 +387,7 @@ static const struct clksel div16_dpll2_m2x2_clksel[] = {
  * The TRM is conflicted on whether IVA2 clock comes from DPLL2 CLKOUT
  * or CLKOUTX2. CLKOUT seems most plausible.
  */
-static struct clk dpll2_m2_ck = {
+static struct clk __omap3_data dpll2_m2_ck = {
 	.name		= "dpll2_m2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll2_ck,
@@ -405,7 +405,7 @@ static struct clk dpll2_m2_ck = {
  * Source clock for all interfaces and for some device fclks
  * REVISIT: Also supports fast relock bypass - not included below
  */
-static struct dpll_data dpll3_dd = {
+static struct dpll_data __omap3_data dpll3_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.mult_mask	= OMAP3430_CORE_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_CORE_DPLL_DIV_MASK,
@@ -427,7 +427,7 @@ static struct dpll_data dpll3_dd = {
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
-static struct clk dpll3_ck = {
+static struct clk __omap3_data dpll3_ck = {
 	.name		= "dpll3_ck",
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
@@ -441,7 +441,7 @@ static struct clk dpll3_ck = {
  * This virtual clock provides the CLKOUTX2 output from the DPLL if the
  * DPLL isn't bypassed
  */
-static struct clk dpll3_x2_ck = {
+static struct clk __omap3_data dpll3_x2_ck = {
 	.name		= "dpll3_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_ck,
@@ -490,7 +490,7 @@ static const struct clksel div31_dpll3m2_clksel[] = {
 };
 
 /* DPLL3 output M2 - primary control point for CORE speed */
-static struct clk dpll3_m2_ck = {
+static struct clk __omap3_data dpll3_m2_ck = {
 	.name		= "dpll3_m2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_ck,
@@ -504,14 +504,14 @@ static struct clk dpll3_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk core_ck = {
+static struct clk __omap3_data core_ck = {
 	.name		= "core_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_m2_ck,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dpll3_m2x2_ck = {
+static struct clk __omap3_data dpll3_m2x2_ck = {
 	.name		= "dpll3_m2x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_m2_ck,
@@ -526,7 +526,7 @@ static const struct clksel div16_dpll3_clksel[] = {
 };
 
 /* This virtual clock is the source for dpll3_m3x2_ck */
-static struct clk dpll3_m3_ck = {
+static struct clk __omap3_data dpll3_m3_ck = {
 	.name		= "dpll3_m3_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_ck,
@@ -539,7 +539,7 @@ static struct clk dpll3_m3_ck = {
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll3_m3x2_ck = {
+static struct clk __omap3_data dpll3_m3x2_ck = {
 	.name		= "dpll3_m3x2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll3_m3_ck,
@@ -550,7 +550,7 @@ static struct clk dpll3_m3x2_ck = {
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
-static struct clk emu_core_alwon_ck = {
+static struct clk __omap3_data emu_core_alwon_ck = {
 	.name		= "emu_core_alwon_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_m3x2_ck,
@@ -561,7 +561,7 @@ static struct clk emu_core_alwon_ck = {
 /* DPLL4 */
 /* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace clk */
 /* Type: DPLL */
-static struct dpll_data dpll4_dd;
+static struct dpll_data __omap3_data dpll4_dd;
 
 static struct dpll_data dpll4_dd_34xx __initdata = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
@@ -609,7 +609,7 @@ static struct dpll_data dpll4_dd_3630 __initdata = {
 	.flags		= DPLL_J_TYPE
 };
 
-static struct clk dpll4_ck = {
+static struct clk __omap3_data dpll4_ck = {
 	.name		= "dpll4_ck",
 	.ops		= &clkops_omap3_noncore_dpll_ops,
 	.parent		= &sys_ck,
@@ -625,7 +625,7 @@ static struct clk dpll4_ck = {
  * DPLL isn't bypassed --
  * XXX does this serve any downstream clocks?
  */
-static struct clk dpll4_x2_ck = {
+static struct clk __omap3_data dpll4_x2_ck = {
 	.name		= "dpll4_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -639,7 +639,7 @@ static const struct clksel dpll4_clksel[] = {
 };
 
 /* This virtual clock is the source for dpll4_m2x2_ck */
-static struct clk dpll4_m2_ck = {
+static struct clk __omap3_data dpll4_m2_ck = {
 	.name		= "dpll4_m2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -652,7 +652,7 @@ static struct clk dpll4_m2_ck = {
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m2x2_ck = {
+static struct clk __omap3_data dpll4_m2x2_ck = {
 	.name		= "dpll4_m2x2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m2_ck,
@@ -671,7 +671,7 @@ static struct clk dpll4_m2x2_ck = {
  */
 
 /* Adding 192MHz Clock node needed by SGX */
-static struct clk omap_192m_alwon_fck = {
+static struct clk __omap3_data omap_192m_alwon_fck = {
 	.name		= "omap_192m_alwon_fck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_m2x2_ck,
@@ -699,14 +699,14 @@ static const struct clksel_rate omap_96m_sys_rates[] = {
 	{ .div = 0 }
 };
 
-static struct clk omap_96m_alwon_fck = {
+static struct clk __omap3_data omap_96m_alwon_fck = {
 	.name		= "omap_96m_alwon_fck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_m2x2_ck,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk omap_96m_alwon_fck_3630 = {
+static struct clk __omap3_data omap_96m_alwon_fck_3630 = {
 	.name		= "omap_96m_alwon_fck",
 	.parent		= &omap_192m_alwon_fck,
 	.init		= &omap2_init_clksel_parent,
@@ -717,7 +717,7 @@ static struct clk omap_96m_alwon_fck_3630 = {
 	.clksel		= omap_96m_alwon_fck_clksel
 };
 
-static struct clk cm_96m_fck = {
+static struct clk __omap3_data cm_96m_fck = {
 	.name		= "cm_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
@@ -730,7 +730,7 @@ static const struct clksel omap_96m_fck_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk omap_96m_fck = {
+static struct clk __omap3_data omap_96m_fck = {
 	.name		= "omap_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
@@ -742,7 +742,7 @@ static struct clk omap_96m_fck = {
 };
 
 /* This virtual clock is the source for dpll4_m3x2_ck */
-static struct clk dpll4_m3_ck = {
+static struct clk __omap3_data dpll4_m3_ck = {
 	.name		= "dpll4_m3_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -755,7 +755,7 @@ static struct clk dpll4_m3_ck = {
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m3x2_ck = {
+static struct clk __omap3_data dpll4_m3x2_ck = {
 	.name		= "dpll4_m3x2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m3_ck,
@@ -782,7 +782,7 @@ static const struct clksel omap_54m_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk omap_54m_fck = {
+static struct clk __omap3_data omap_54m_fck = {
 	.name		= "omap_54m_fck",
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
@@ -808,7 +808,7 @@ static const struct clksel omap_48m_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk omap_48m_fck = {
+static struct clk __omap3_data omap_48m_fck = {
 	.name		= "omap_48m_fck",
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
@@ -818,7 +818,7 @@ static struct clk omap_48m_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk omap_12m_fck = {
+static struct clk __omap3_data omap_12m_fck = {
 	.name		= "omap_12m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
@@ -827,7 +827,7 @@ static struct clk omap_12m_fck = {
 };
 
 /* This virtual clock is the source for dpll4_m4x2_ck */
-static struct clk dpll4_m4_ck = {
+static struct clk __omap3_data dpll4_m4_ck = {
 	.name		= "dpll4_m4_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -842,7 +842,7 @@ static struct clk dpll4_m4_ck = {
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m4x2_ck = {
+static struct clk __omap3_data dpll4_m4x2_ck = {
 	.name		= "dpll4_m4x2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m4_ck,
@@ -854,7 +854,7 @@ static struct clk dpll4_m4x2_ck = {
 };
 
 /* This virtual clock is the source for dpll4_m5x2_ck */
-static struct clk dpll4_m5_ck = {
+static struct clk __omap3_data dpll4_m5_ck = {
 	.name		= "dpll4_m5_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -869,7 +869,7 @@ static struct clk dpll4_m5_ck = {
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m5x2_ck = {
+static struct clk __omap3_data dpll4_m5x2_ck = {
 	.name		= "dpll4_m5x2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m5_ck,
@@ -881,7 +881,7 @@ static struct clk dpll4_m5x2_ck = {
 };
 
 /* This virtual clock is the source for dpll4_m6x2_ck */
-static struct clk dpll4_m6_ck = {
+static struct clk __omap3_data dpll4_m6_ck = {
 	.name		= "dpll4_m6_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -894,7 +894,7 @@ static struct clk dpll4_m6_ck = {
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m6x2_ck = {
+static struct clk __omap3_data dpll4_m6x2_ck = {
 	.name		= "dpll4_m6x2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m6_ck,
@@ -905,7 +905,7 @@ static struct clk dpll4_m6x2_ck = {
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
-static struct clk emu_per_alwon_ck = {
+static struct clk __omap3_data emu_per_alwon_ck = {
 	.name		= "emu_per_alwon_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_m6x2_ck,
@@ -917,7 +917,7 @@ static struct clk emu_per_alwon_ck = {
 /* Supplies 120MHz clock, USIM source clock */
 /* Type: DPLL */
 /* 3430ES2 only */
-static struct dpll_data dpll5_dd = {
+static struct dpll_data __omap3_data dpll5_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL4),
 	.mult_mask	= OMAP3430ES2_PERIPH2_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430ES2_PERIPH2_DPLL_DIV_MASK,
@@ -940,7 +940,7 @@ static struct dpll_data dpll5_dd = {
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
-static struct clk dpll5_ck = {
+static struct clk __omap3_data dpll5_ck = {
 	.name		= "dpll5_ck",
 	.ops		= &clkops_omap3_noncore_dpll_ops,
 	.parent		= &sys_ck,
@@ -956,7 +956,7 @@ static const struct clksel div16_dpll5_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk dpll5_m2_ck = {
+static struct clk __omap3_data dpll5_m2_ck = {
 	.name		= "dpll5_m2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll5_ck,
@@ -998,7 +998,7 @@ static const struct clksel clkout2_src_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk clkout2_src_ck = {
+static struct clk __omap3_data clkout2_src_ck = {
 	.name		= "clkout2_src_ck",
 	.ops		= &clkops_omap2_dflt,
 	.init		= &omap2_init_clksel_parent,
@@ -1025,7 +1025,7 @@ static const struct clksel sys_clkout2_clksel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk sys_clkout2 = {
+static struct clk __omap3_data sys_clkout2 = {
 	.name		= "sys_clkout2",
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
@@ -1039,7 +1039,7 @@ static struct clk sys_clkout2 = {
 
 /* CM OUTPUT CLOCKS */
 
-static struct clk corex2_fck = {
+static struct clk __omap3_data corex2_fck = {
 	.name		= "corex2_fck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_m2x2_ck,
@@ -1064,7 +1064,7 @@ static const struct clksel div4_core_clksel[] = {
  * REVISIT: Are these in DPLL power domain or CM power domain? docs
  * may be inconsistent here?
  */
-static struct clk dpll1_fck = {
+static struct clk __omap3_data dpll1_fck = {
 	.name		= "dpll1_fck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
@@ -1075,7 +1075,7 @@ static struct clk dpll1_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk mpu_ck = {
+static struct clk __omap3_data mpu_ck = {
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll1_x2m2_ck,
@@ -1095,7 +1095,7 @@ static const struct clksel arm_fck_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk arm_fck = {
+static struct clk __omap3_data arm_fck = {
 	.name		= "arm_fck",
 	.ops		= &clkops_null,
 	.parent		= &mpu_ck,
@@ -1113,14 +1113,14 @@ static struct clk arm_fck = {
  * REVISIT: This clock is never specifically defined in the 3430 TRM,
  * although it is referenced - so this is a guess
  */
-static struct clk emu_mpu_alwon_ck = {
+static struct clk __omap3_data emu_mpu_alwon_ck = {
 	.name		= "emu_mpu_alwon_ck",
 	.ops		= &clkops_null,
 	.parent		= &mpu_ck,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dpll2_fck = {
+static struct clk __omap3_data dpll2_fck = {
 	.name		= "dpll2_fck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
@@ -1131,7 +1131,7 @@ static struct clk dpll2_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk iva2_ck = {
+static struct clk __omap3_data iva2_ck = {
 	.name		= "iva2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll2_m2_ck,
@@ -1148,7 +1148,7 @@ static const struct clksel div2_core_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk l3_ick = {
+static struct clk __omap3_data l3_ick = {
 	.name		= "l3_ick",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
@@ -1165,7 +1165,7 @@ static const struct clksel div2_l3_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk l4_ick = {
+static struct clk __omap3_data l4_ick = {
 	.name		= "l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l3_ick,
@@ -1183,7 +1183,7 @@ static const struct clksel div2_l4_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk rm_ick = {
+static struct clk __omap3_data rm_ick = {
 	.name		= "rm_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
@@ -1204,7 +1204,7 @@ static const struct clksel gfx_l3_clksel[] = {
 };
 
 /* Virtual parent clock for gfx_l3_ick and gfx_l3_fck */
-static struct clk gfx_l3_ck = {
+static struct clk __omap3_data gfx_l3_ck = {
 	.name		= "gfx_l3_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l3_ick,
@@ -1213,7 +1213,7 @@ static struct clk gfx_l3_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gfx_l3_fck = {
+static struct clk __omap3_data gfx_l3_fck = {
 	.name		= "gfx_l3_fck",
 	.ops		= &clkops_null,
 	.parent		= &gfx_l3_ck,
@@ -1225,7 +1225,7 @@ static struct clk gfx_l3_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gfx_l3_ick = {
+static struct clk __omap3_data gfx_l3_ick = {
 	.name		= "gfx_l3_ick",
 	.ops		= &clkops_null,
 	.parent		= &gfx_l3_ck,
@@ -1233,7 +1233,7 @@ static struct clk gfx_l3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gfx_cg1_ck = {
+static struct clk __omap3_data gfx_cg1_ck = {
 	.name		= "gfx_cg1_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
@@ -1243,7 +1243,7 @@ static struct clk gfx_cg1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gfx_cg2_ck = {
+static struct clk __omap3_data gfx_cg2_ck = {
 	.name		= "gfx_cg2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
@@ -1287,7 +1287,7 @@ static const struct clksel sgx_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk sgx_fck = {
+static struct clk __omap3_data sgx_fck = {
 	.name		= "sgx_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -1302,7 +1302,7 @@ static struct clk sgx_fck = {
 	.round_rate	= &omap2_clksel_round_rate
 };
 
-static struct clk sgx_ick = {
+static struct clk __omap3_data sgx_ick = {
 	.name		= "sgx_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l3_ick,
@@ -1314,7 +1314,7 @@ static struct clk sgx_ick = {
 
 /* CORE power domain */
 
-static struct clk d2d_26m_fck = {
+static struct clk __omap3_data d2d_26m_fck = {
 	.name		= "d2d_26m_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
@@ -1324,7 +1324,7 @@ static struct clk d2d_26m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk modem_fck = {
+static struct clk __omap3_data modem_fck = {
 	.name		= "modem_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
@@ -1334,7 +1334,7 @@ static struct clk modem_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sad2d_ick = {
+static struct clk __omap3_data sad2d_ick = {
 	.name		= "sad2d_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l3_ick,
@@ -1344,7 +1344,7 @@ static struct clk sad2d_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mad2d_ick = {
+static struct clk __omap3_data mad2d_ick = {
 	.name		= "mad2d_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l3_ick,
@@ -1360,7 +1360,7 @@ static const struct clksel omap343x_gpt_clksel[] = {
 	{ .parent = NULL}
 };
 
-static struct clk gpt10_fck = {
+static struct clk __omap3_data gpt10_fck = {
 	.name		= "gpt10_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
@@ -1374,7 +1374,7 @@ static struct clk gpt10_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt11_fck = {
+static struct clk __omap3_data gpt11_fck = {
 	.name		= "gpt11_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
@@ -1388,7 +1388,7 @@ static struct clk gpt11_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk cpefuse_fck = {
+static struct clk __omap3_data cpefuse_fck = {
 	.name		= "cpefuse_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,
@@ -1397,7 +1397,7 @@ static struct clk cpefuse_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ts_fck = {
+static struct clk __omap3_data ts_fck = {
 	.name		= "ts_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &omap_32k_fck,
@@ -1406,7 +1406,7 @@ static struct clk ts_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usbtll_fck = {
+static struct clk __omap3_data usbtll_fck = {
 	.name		= "usbtll_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll5_m2_ck,
@@ -1417,7 +1417,7 @@ static struct clk usbtll_fck = {
 
 /* CORE 96M FCLK-derived clocks */
 
-static struct clk core_96m_fck = {
+static struct clk __omap3_data core_96m_fck = {
 	.name		= "core_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_fck,
@@ -1425,7 +1425,7 @@ static struct clk core_96m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmchs3_fck = {
+static struct clk __omap3_data mmchs3_fck = {
 	.name		= "mmchs3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
@@ -1435,7 +1435,7 @@ static struct clk mmchs3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmchs2_fck = {
+static struct clk __omap3_data mmchs2_fck = {
 	.name		= "mmchs2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
@@ -1445,7 +1445,7 @@ static struct clk mmchs2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mspro_fck = {
+static struct clk __omap3_data mspro_fck = {
 	.name		= "mspro_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
@@ -1455,7 +1455,7 @@ static struct clk mspro_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmchs1_fck = {
+static struct clk __omap3_data mmchs1_fck = {
 	.name		= "mmchs1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
@@ -1465,7 +1465,7 @@ static struct clk mmchs1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c3_fck = {
+static struct clk __omap3_data i2c3_fck = {
 	.name		= "i2c3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
@@ -1475,7 +1475,7 @@ static struct clk i2c3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c2_fck = {
+static struct clk __omap3_data i2c2_fck = {
 	.name		= "i2c2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
@@ -1485,7 +1485,7 @@ static struct clk i2c2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c1_fck = {
+static struct clk __omap3_data i2c1_fck = {
 	.name		= "i2c1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
@@ -1515,7 +1515,7 @@ static const struct clksel mcbsp_15_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk mcbsp5_fck = {
+static struct clk __omap3_data mcbsp5_fck = {
 	.name		= "mcbsp5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -1528,7 +1528,7 @@ static struct clk mcbsp5_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk mcbsp1_fck = {
+static struct clk __omap3_data mcbsp1_fck = {
 	.name		= "mcbsp1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -1543,7 +1543,7 @@ static struct clk mcbsp1_fck = {
 
 /* CORE_48M_FCK-derived clocks */
 
-static struct clk core_48m_fck = {
+static struct clk __omap3_data core_48m_fck = {
 	.name		= "core_48m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
@@ -1551,7 +1551,7 @@ static struct clk core_48m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi4_fck = {
+static struct clk __omap3_data mcspi4_fck = {
 	.name		= "mcspi4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
@@ -1560,7 +1560,7 @@ static struct clk mcspi4_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi3_fck = {
+static struct clk __omap3_data mcspi3_fck = {
 	.name		= "mcspi3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
@@ -1569,7 +1569,7 @@ static struct clk mcspi3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi2_fck = {
+static struct clk __omap3_data mcspi2_fck = {
 	.name		= "mcspi2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
@@ -1578,7 +1578,7 @@ static struct clk mcspi2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi1_fck = {
+static struct clk __omap3_data mcspi1_fck = {
 	.name		= "mcspi1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
@@ -1587,7 +1587,7 @@ static struct clk mcspi1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart2_fck = {
+static struct clk __omap3_data uart2_fck = {
 	.name		= "uart2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
@@ -1597,7 +1597,7 @@ static struct clk uart2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart1_fck = {
+static struct clk __omap3_data uart1_fck = {
 	.name		= "uart1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
@@ -1607,7 +1607,7 @@ static struct clk uart1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk fshostusb_fck = {
+static struct clk __omap3_data fshostusb_fck = {
 	.name		= "fshostusb_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
@@ -1618,7 +1618,7 @@ static struct clk fshostusb_fck = {
 
 /* CORE_12M_FCK based clocks */
 
-static struct clk core_12m_fck = {
+static struct clk __omap3_data core_12m_fck = {
 	.name		= "core_12m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_12m_fck,
@@ -1626,7 +1626,7 @@ static struct clk core_12m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk hdq_fck = {
+static struct clk __omap3_data hdq_fck = {
 	.name		= "hdq_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_12m_fck,
@@ -1652,7 +1652,7 @@ static const struct clksel ssi_ssr_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk ssi_ssr_fck_3430es1 = {
+static struct clk __omap3_data ssi_ssr_fck_3430es1 = {
 	.name		= "ssi_ssr_fck",
 	.ops		= &clkops_omap2_dflt,
 	.init		= &omap2_init_clksel_parent,
@@ -1665,7 +1665,7 @@ static struct clk ssi_ssr_fck_3430es1 = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk ssi_ssr_fck_3430es2 = {
+static struct clk __omap3_data ssi_ssr_fck_3430es2 = {
 	.name		= "ssi_ssr_fck",
 	.ops		= &clkops_omap3430es2_ssi_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -1678,7 +1678,7 @@ static struct clk ssi_ssr_fck_3430es2 = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk ssi_sst_fck_3430es1 = {
+static struct clk __omap3_data ssi_sst_fck_3430es1 = {
 	.name		= "ssi_sst_fck",
 	.ops		= &clkops_null,
 	.parent		= &ssi_ssr_fck_3430es1,
@@ -1686,7 +1686,7 @@ static struct clk ssi_sst_fck_3430es1 = {
 	.recalc		= &omap_fixed_divisor_recalc,
 };
 
-static struct clk ssi_sst_fck_3430es2 = {
+static struct clk __omap3_data ssi_sst_fck_3430es2 = {
 	.name		= "ssi_sst_fck",
 	.ops		= &clkops_null,
 	.parent		= &ssi_ssr_fck_3430es2,
@@ -1702,7 +1702,7 @@ static struct clk ssi_sst_fck_3430es2 = {
  * XXX must add clk_enable/clk_disable for these if standard code won't
  * handle it
  */
-static struct clk core_l3_ick = {
+static struct clk __omap3_data core_l3_ick = {
 	.name		= "core_l3_ick",
 	.ops		= &clkops_null,
 	.parent		= &l3_ick,
@@ -1710,7 +1710,7 @@ static struct clk core_l3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk hsotgusb_ick_3430es1 = {
+static struct clk __omap3_data hsotgusb_ick_3430es1 = {
 	.name		= "hsotgusb_ick",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &core_l3_ick,
@@ -1720,7 +1720,7 @@ static struct clk hsotgusb_ick_3430es1 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk hsotgusb_ick_3430es2 = {
+static struct clk __omap3_data hsotgusb_ick_3430es2 = {
 	.name		= "hsotgusb_ick",
 	.ops		= &clkops_omap3430es2_hsotgusb_wait,
 	.parent		= &core_l3_ick,
@@ -1730,7 +1730,7 @@ static struct clk hsotgusb_ick_3430es2 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sdrc_ick = {
+static struct clk __omap3_data sdrc_ick = {
 	.name		= "sdrc_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ick,
@@ -1741,7 +1741,7 @@ static struct clk sdrc_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpmc_fck = {
+static struct clk __omap3_data gpmc_fck = {
 	.name		= "gpmc_fck",
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ick,
@@ -1752,14 +1752,14 @@ static struct clk gpmc_fck = {
 
 /* SECURITY_L3_ICK based clocks */
 
-static struct clk security_l3_ick = {
+static struct clk __omap3_data security_l3_ick = {
 	.name		= "security_l3_ick",
 	.ops		= &clkops_null,
 	.parent		= &l3_ick,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk pka_ick = {
+static struct clk __omap3_data pka_ick = {
 	.name		= "pka_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &security_l3_ick,
@@ -1770,7 +1770,7 @@ static struct clk pka_ick = {
 
 /* CORE_L4_ICK based clocks */
 
-static struct clk core_l4_ick = {
+static struct clk __omap3_data core_l4_ick = {
 	.name		= "core_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
@@ -1778,7 +1778,7 @@ static struct clk core_l4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usbtll_ick = {
+static struct clk __omap3_data usbtll_ick = {
 	.name		= "usbtll_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1788,7 +1788,7 @@ static struct clk usbtll_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmchs3_ick = {
+static struct clk __omap3_data mmchs3_ick = {
 	.name		= "mmchs3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1799,7 +1799,7 @@ static struct clk mmchs3_ick = {
 };
 
 /* Intersystem Communication Registers - chassis mode only */
-static struct clk icr_ick = {
+static struct clk __omap3_data icr_ick = {
 	.name		= "icr_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1809,7 +1809,7 @@ static struct clk icr_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk aes2_ick = {
+static struct clk __omap3_data aes2_ick = {
 	.name		= "aes2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1819,7 +1819,7 @@ static struct clk aes2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sha12_ick = {
+static struct clk __omap3_data sha12_ick = {
 	.name		= "sha12_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1829,7 +1829,7 @@ static struct clk sha12_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk des2_ick = {
+static struct clk __omap3_data des2_ick = {
 	.name		= "des2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1839,7 +1839,7 @@ static struct clk des2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmchs2_ick = {
+static struct clk __omap3_data mmchs2_ick = {
 	.name		= "mmchs2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1849,7 +1849,7 @@ static struct clk mmchs2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmchs1_ick = {
+static struct clk __omap3_data mmchs1_ick = {
 	.name		= "mmchs1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1859,7 +1859,7 @@ static struct clk mmchs1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mspro_ick = {
+static struct clk __omap3_data mspro_ick = {
 	.name		= "mspro_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1869,7 +1869,7 @@ static struct clk mspro_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk hdq_ick = {
+static struct clk __omap3_data hdq_ick = {
 	.name		= "hdq_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1879,7 +1879,7 @@ static struct clk hdq_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi4_ick = {
+static struct clk __omap3_data mcspi4_ick = {
 	.name		= "mcspi4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1889,7 +1889,7 @@ static struct clk mcspi4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi3_ick = {
+static struct clk __omap3_data mcspi3_ick = {
 	.name		= "mcspi3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1899,7 +1899,7 @@ static struct clk mcspi3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi2_ick = {
+static struct clk __omap3_data mcspi2_ick = {
 	.name		= "mcspi2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1909,7 +1909,7 @@ static struct clk mcspi2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi1_ick = {
+static struct clk __omap3_data mcspi1_ick = {
 	.name		= "mcspi1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1919,7 +1919,7 @@ static struct clk mcspi1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c3_ick = {
+static struct clk __omap3_data i2c3_ick = {
 	.name		= "i2c3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1929,7 +1929,7 @@ static struct clk i2c3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c2_ick = {
+static struct clk __omap3_data i2c2_ick = {
 	.name		= "i2c2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1939,7 +1939,7 @@ static struct clk i2c2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c1_ick = {
+static struct clk __omap3_data i2c1_ick = {
 	.name		= "i2c1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1949,7 +1949,7 @@ static struct clk i2c1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart2_ick = {
+static struct clk __omap3_data uart2_ick = {
 	.name		= "uart2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1959,7 +1959,7 @@ static struct clk uart2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart1_ick = {
+static struct clk __omap3_data uart1_ick = {
 	.name		= "uart1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1969,7 +1969,7 @@ static struct clk uart1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt11_ick = {
+static struct clk __omap3_data gpt11_ick = {
 	.name		= "gpt11_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1979,7 +1979,7 @@ static struct clk gpt11_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt10_ick = {
+static struct clk __omap3_data gpt10_ick = {
 	.name		= "gpt10_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1989,7 +1989,7 @@ static struct clk gpt10_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcbsp5_ick = {
+static struct clk __omap3_data mcbsp5_ick = {
 	.name		= "mcbsp5_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -1999,7 +1999,7 @@ static struct clk mcbsp5_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcbsp1_ick = {
+static struct clk __omap3_data mcbsp1_ick = {
 	.name		= "mcbsp1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -2009,7 +2009,7 @@ static struct clk mcbsp1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk fac_ick = {
+static struct clk __omap3_data fac_ick = {
 	.name		= "fac_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -2019,7 +2019,7 @@ static struct clk fac_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mailboxes_ick = {
+static struct clk __omap3_data mailboxes_ick = {
 	.name		= "mailboxes_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -2029,7 +2029,7 @@ static struct clk mailboxes_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk omapctrl_ick = {
+static struct clk __omap3_data omapctrl_ick = {
 	.name		= "omapctrl_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -2041,7 +2041,7 @@ static struct clk omapctrl_ick = {
 
 /* SSI_L4_ICK based clocks */
 
-static struct clk ssi_l4_ick = {
+static struct clk __omap3_data ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
@@ -2049,7 +2049,7 @@ static struct clk ssi_l4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ssi_ick_3430es1 = {
+static struct clk __omap3_data ssi_ick_3430es1 = {
 	.name		= "ssi_ick",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &ssi_l4_ick,
@@ -2059,7 +2059,7 @@ static struct clk ssi_ick_3430es1 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ssi_ick_3430es2 = {
+static struct clk __omap3_data ssi_ick_3430es2 = {
 	.name		= "ssi_ick",
 	.ops		= &clkops_omap3430es2_ssi_wait,
 	.parent		= &ssi_l4_ick,
@@ -2077,7 +2077,7 @@ static const struct clksel usb_l4_clksel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk usb_l4_ick = {
+static struct clk __omap3_data usb_l4_ick = {
 	.name		= "usb_l4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ick,
@@ -2092,14 +2092,14 @@ static struct clk usb_l4_ick = {
 
 /* SECURITY_L4_ICK2 based clocks */
 
-static struct clk security_l4_ick2 = {
+static struct clk __omap3_data security_l4_ick2 = {
 	.name		= "security_l4_ick2",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk aes1_ick = {
+static struct clk __omap3_data aes1_ick = {
 	.name		= "aes1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &security_l4_ick2,
@@ -2108,7 +2108,7 @@ static struct clk aes1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk rng_ick = {
+static struct clk __omap3_data rng_ick = {
 	.name		= "rng_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &security_l4_ick2,
@@ -2117,7 +2117,7 @@ static struct clk rng_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sha11_ick = {
+static struct clk __omap3_data sha11_ick = {
 	.name		= "sha11_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &security_l4_ick2,
@@ -2126,7 +2126,7 @@ static struct clk sha11_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk des1_ick = {
+static struct clk __omap3_data des1_ick = {
 	.name		= "des1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &security_l4_ick2,
@@ -2136,7 +2136,7 @@ static struct clk des1_ick = {
 };
 
 /* DSS */
-static struct clk dss1_alwon_fck_3430es1 = {
+static struct clk __omap3_data dss1_alwon_fck_3430es1 = {
 	.name		= "dss1_alwon_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &dpll4_m4x2_ck,
@@ -2146,7 +2146,7 @@ static struct clk dss1_alwon_fck_3430es1 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss1_alwon_fck_3430es2 = {
+static struct clk __omap3_data dss1_alwon_fck_3430es2 = {
 	.name		= "dss1_alwon_fck",
 	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
 	.parent		= &dpll4_m4x2_ck,
@@ -2156,7 +2156,7 @@ static struct clk dss1_alwon_fck_3430es2 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_tv_fck = {
+static struct clk __omap3_data dss_tv_fck = {
 	.name		= "dss_tv_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &omap_54m_fck,
@@ -2166,7 +2166,7 @@ static struct clk dss_tv_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_96m_fck = {
+static struct clk __omap3_data dss_96m_fck = {
 	.name		= "dss_96m_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &omap_96m_fck,
@@ -2176,7 +2176,7 @@ static struct clk dss_96m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss2_alwon_fck = {
+static struct clk __omap3_data dss2_alwon_fck = {
 	.name		= "dss2_alwon_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,
@@ -2186,7 +2186,7 @@ static struct clk dss2_alwon_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_ick_3430es1 = {
+static struct clk __omap3_data dss_ick_3430es1 = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "dss_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -2197,7 +2197,7 @@ static struct clk dss_ick_3430es1 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_ick_3430es2 = {
+static struct clk __omap3_data dss_ick_3430es2 = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "dss_ick",
 	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
@@ -2210,7 +2210,7 @@ static struct clk dss_ick_3430es2 = {
 
 /* CAM */
 
-static struct clk cam_mclk = {
+static struct clk __omap3_data cam_mclk = {
 	.name		= "cam_mclk",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &dpll4_m5x2_ck,
@@ -2220,7 +2220,7 @@ static struct clk cam_mclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk cam_ick = {
+static struct clk __omap3_data cam_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "cam_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -2231,7 +2231,7 @@ static struct clk cam_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk csi2_96m_fck = {
+static struct clk __omap3_data csi2_96m_fck = {
 	.name		= "csi2_96m_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &core_96m_fck,
@@ -2243,7 +2243,7 @@ static struct clk csi2_96m_fck = {
 
 /* USBHOST - 3430ES2 only */
 
-static struct clk usbhost_120m_fck = {
+static struct clk __omap3_data usbhost_120m_fck = {
 	.name		= "usbhost_120m_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &dpll5_m2_ck,
@@ -2253,7 +2253,7 @@ static struct clk usbhost_120m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usbhost_48m_fck = {
+static struct clk __omap3_data usbhost_48m_fck = {
 	.name		= "usbhost_48m_fck",
 	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
 	.parent		= &omap_48m_fck,
@@ -2263,7 +2263,7 @@ static struct clk usbhost_48m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usbhost_ick = {
+static struct clk __omap3_data usbhost_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "usbhost_ick",
 	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
@@ -2300,7 +2300,7 @@ static const struct clksel usim_clksel[] = {
 };
 
 /* 3430ES2 only */
-static struct clk usim_fck = {
+static struct clk __omap3_data usim_fck = {
 	.name		= "usim_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2313,7 +2313,7 @@ static struct clk usim_fck = {
 };
 
 /* XXX should gpt1's clksel have wkup_32k_fck as the 32k opt? */
-static struct clk gpt1_fck = {
+static struct clk __omap3_data gpt1_fck = {
 	.name		= "gpt1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2326,7 +2326,7 @@ static struct clk gpt1_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk wkup_32k_fck = {
+static struct clk __omap3_data wkup_32k_fck = {
 	.name		= "wkup_32k_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_32k_fck,
@@ -2334,7 +2334,7 @@ static struct clk wkup_32k_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio1_dbck = {
+static struct clk __omap3_data gpio1_dbck = {
 	.name		= "gpio1_dbck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &wkup_32k_fck,
@@ -2344,7 +2344,7 @@ static struct clk gpio1_dbck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt2_fck = {
+static struct clk __omap3_data wdt2_fck = {
 	.name		= "wdt2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_32k_fck,
@@ -2354,7 +2354,7 @@ static struct clk wdt2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wkup_l4_ick = {
+static struct clk __omap3_data wkup_l4_ick = {
 	.name		= "wkup_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
@@ -2364,7 +2364,7 @@ static struct clk wkup_l4_ick = {
 
 /* 3430ES2 only */
 /* Never specifically named in the TRM, so we have to infer a likely name */
-static struct clk usim_ick = {
+static struct clk __omap3_data usim_ick = {
 	.name		= "usim_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
@@ -2374,7 +2374,7 @@ static struct clk usim_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt2_ick = {
+static struct clk __omap3_data wdt2_ick = {
 	.name		= "wdt2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
@@ -2384,7 +2384,7 @@ static struct clk wdt2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt1_ick = {
+static struct clk __omap3_data wdt1_ick = {
 	.name		= "wdt1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
@@ -2394,7 +2394,7 @@ static struct clk wdt1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio1_ick = {
+static struct clk __omap3_data gpio1_ick = {
 	.name		= "gpio1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
@@ -2404,7 +2404,7 @@ static struct clk gpio1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk omap_32ksync_ick = {
+static struct clk __omap3_data omap_32ksync_ick = {
 	.name		= "omap_32ksync_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
@@ -2415,7 +2415,7 @@ static struct clk omap_32ksync_ick = {
 };
 
 /* XXX This clock no longer exists in 3430 TRM rev F */
-static struct clk gpt12_ick = {
+static struct clk __omap3_data gpt12_ick = {
 	.name		= "gpt12_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
@@ -2425,7 +2425,7 @@ static struct clk gpt12_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt1_ick = {
+static struct clk __omap3_data gpt1_ick = {
 	.name		= "gpt1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
@@ -2439,7 +2439,7 @@ static struct clk gpt1_ick = {
 
 /* PER clock domain */
 
-static struct clk per_96m_fck = {
+static struct clk __omap3_data per_96m_fck = {
 	.name		= "per_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
@@ -2447,7 +2447,7 @@ static struct clk per_96m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk per_48m_fck = {
+static struct clk __omap3_data per_48m_fck = {
 	.name		= "per_48m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
@@ -2455,7 +2455,7 @@ static struct clk per_48m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart3_fck = {
+static struct clk __omap3_data uart3_fck = {
 	.name		= "uart3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_48m_fck,
@@ -2465,7 +2465,7 @@ static struct clk uart3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart4_fck = {
+static struct clk __omap3_data uart4_fck = {
 	.name		= "uart4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_48m_fck,
@@ -2475,7 +2475,7 @@ static struct clk uart4_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt2_fck = {
+static struct clk __omap3_data gpt2_fck = {
 	.name		= "gpt2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2488,7 +2488,7 @@ static struct clk gpt2_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt3_fck = {
+static struct clk __omap3_data gpt3_fck = {
 	.name		= "gpt3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2501,7 +2501,7 @@ static struct clk gpt3_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt4_fck = {
+static struct clk __omap3_data gpt4_fck = {
 	.name		= "gpt4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2514,7 +2514,7 @@ static struct clk gpt4_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt5_fck = {
+static struct clk __omap3_data gpt5_fck = {
 	.name		= "gpt5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2527,7 +2527,7 @@ static struct clk gpt5_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt6_fck = {
+static struct clk __omap3_data gpt6_fck = {
 	.name		= "gpt6_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2540,7 +2540,7 @@ static struct clk gpt6_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt7_fck = {
+static struct clk __omap3_data gpt7_fck = {
 	.name		= "gpt7_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2553,7 +2553,7 @@ static struct clk gpt7_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt8_fck = {
+static struct clk __omap3_data gpt8_fck = {
 	.name		= "gpt8_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2566,7 +2566,7 @@ static struct clk gpt8_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt9_fck = {
+static struct clk __omap3_data gpt9_fck = {
 	.name		= "gpt9_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2579,7 +2579,7 @@ static struct clk gpt9_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk per_32k_alwon_fck = {
+static struct clk __omap3_data per_32k_alwon_fck = {
 	.name		= "per_32k_alwon_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_32k_fck,
@@ -2587,7 +2587,7 @@ static struct clk per_32k_alwon_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio6_dbck = {
+static struct clk __omap3_data gpio6_dbck = {
 	.name		= "gpio6_dbck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &per_32k_alwon_fck,
@@ -2597,7 +2597,7 @@ static struct clk gpio6_dbck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio5_dbck = {
+static struct clk __omap3_data gpio5_dbck = {
 	.name		= "gpio5_dbck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &per_32k_alwon_fck,
@@ -2607,7 +2607,7 @@ static struct clk gpio5_dbck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio4_dbck = {
+static struct clk __omap3_data gpio4_dbck = {
 	.name		= "gpio4_dbck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &per_32k_alwon_fck,
@@ -2617,7 +2617,7 @@ static struct clk gpio4_dbck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio3_dbck = {
+static struct clk __omap3_data gpio3_dbck = {
 	.name		= "gpio3_dbck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &per_32k_alwon_fck,
@@ -2627,7 +2627,7 @@ static struct clk gpio3_dbck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio2_dbck = {
+static struct clk __omap3_data gpio2_dbck = {
 	.name		= "gpio2_dbck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &per_32k_alwon_fck,
@@ -2637,7 +2637,7 @@ static struct clk gpio2_dbck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt3_fck = {
+static struct clk __omap3_data wdt3_fck = {
 	.name		= "wdt3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_32k_alwon_fck,
@@ -2647,7 +2647,7 @@ static struct clk wdt3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk per_l4_ick = {
+static struct clk __omap3_data per_l4_ick = {
 	.name		= "per_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
@@ -2655,7 +2655,7 @@ static struct clk per_l4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio6_ick = {
+static struct clk __omap3_data gpio6_ick = {
 	.name		= "gpio6_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2665,7 +2665,7 @@ static struct clk gpio6_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio5_ick = {
+static struct clk __omap3_data gpio5_ick = {
 	.name		= "gpio5_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2675,7 +2675,7 @@ static struct clk gpio5_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio4_ick = {
+static struct clk __omap3_data gpio4_ick = {
 	.name		= "gpio4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2685,7 +2685,7 @@ static struct clk gpio4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio3_ick = {
+static struct clk __omap3_data gpio3_ick = {
 	.name		= "gpio3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2695,7 +2695,7 @@ static struct clk gpio3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio2_ick = {
+static struct clk __omap3_data gpio2_ick = {
 	.name		= "gpio2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2705,7 +2705,7 @@ static struct clk gpio2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt3_ick = {
+static struct clk __omap3_data wdt3_ick = {
 	.name		= "wdt3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2715,7 +2715,7 @@ static struct clk wdt3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart3_ick = {
+static struct clk __omap3_data uart3_ick = {
 	.name		= "uart3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2725,7 +2725,7 @@ static struct clk uart3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart4_ick = {
+static struct clk __omap3_data uart4_ick = {
 	.name		= "uart4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2735,7 +2735,7 @@ static struct clk uart4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt9_ick = {
+static struct clk __omap3_data gpt9_ick = {
 	.name		= "gpt9_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2745,7 +2745,7 @@ static struct clk gpt9_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt8_ick = {
+static struct clk __omap3_data gpt8_ick = {
 	.name		= "gpt8_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2755,7 +2755,7 @@ static struct clk gpt8_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt7_ick = {
+static struct clk __omap3_data gpt7_ick = {
 	.name		= "gpt7_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2765,7 +2765,7 @@ static struct clk gpt7_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt6_ick = {
+static struct clk __omap3_data gpt6_ick = {
 	.name		= "gpt6_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2775,7 +2775,7 @@ static struct clk gpt6_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt5_ick = {
+static struct clk __omap3_data gpt5_ick = {
 	.name		= "gpt5_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2785,7 +2785,7 @@ static struct clk gpt5_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt4_ick = {
+static struct clk __omap3_data gpt4_ick = {
 	.name		= "gpt4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2795,7 +2795,7 @@ static struct clk gpt4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt3_ick = {
+static struct clk __omap3_data gpt3_ick = {
 	.name		= "gpt3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2805,7 +2805,7 @@ static struct clk gpt3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt2_ick = {
+static struct clk __omap3_data gpt2_ick = {
 	.name		= "gpt2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2815,7 +2815,7 @@ static struct clk gpt2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcbsp2_ick = {
+static struct clk __omap3_data mcbsp2_ick = {
 	.name		= "mcbsp2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2825,7 +2825,7 @@ static struct clk mcbsp2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcbsp3_ick = {
+static struct clk __omap3_data mcbsp3_ick = {
 	.name		= "mcbsp3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2835,7 +2835,7 @@ static struct clk mcbsp3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcbsp4_ick = {
+static struct clk __omap3_data mcbsp4_ick = {
 	.name		= "mcbsp4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
@@ -2851,7 +2851,7 @@ static const struct clksel mcbsp_234_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk mcbsp2_fck = {
+static struct clk __omap3_data mcbsp2_fck = {
 	.name		= "mcbsp2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2864,7 +2864,7 @@ static struct clk mcbsp2_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk mcbsp3_fck = {
+static struct clk __omap3_data mcbsp3_fck = {
 	.name		= "mcbsp3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2877,7 +2877,7 @@ static struct clk mcbsp3_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk mcbsp4_fck = {
+static struct clk __omap3_data mcbsp4_fck = {
 	.name		= "mcbsp4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
@@ -2927,7 +2927,7 @@ static const struct clksel emu_src_clksel[] = {
  * to switch the source of some of the EMU clocks.
  * XXX Are there CLKEN bits for these EMU clks?
  */
-static struct clk emu_src_ck = {
+static struct clk __omap3_data emu_src_ck = {
 	.name		= "emu_src_ck",
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
@@ -2951,7 +2951,7 @@ static const struct clksel pclk_emu_clksel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk pclk_fck = {
+static struct clk __omap3_data pclk_fck = {
 	.name		= "pclk_fck",
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
@@ -2974,7 +2974,7 @@ static const struct clksel pclkx2_emu_clksel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk pclkx2_fck = {
+static struct clk __omap3_data pclkx2_fck = {
 	.name		= "pclkx2_fck",
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
@@ -2990,7 +2990,7 @@ static const struct clksel atclk_emu_clksel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk atclk_fck = {
+static struct clk __omap3_data atclk_fck = {
 	.name		= "atclk_fck",
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
@@ -3001,7 +3001,7 @@ static struct clk atclk_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk traceclk_src_fck = {
+static struct clk __omap3_data traceclk_src_fck = {
 	.name		= "traceclk_src_fck",
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
@@ -3024,7 +3024,7 @@ static const struct clksel traceclk_clksel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk traceclk_fck = {
+static struct clk __omap3_data traceclk_fck = {
 	.name		= "traceclk_fck",
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
@@ -3038,7 +3038,7 @@ static struct clk traceclk_fck = {
 /* SR clocks */
 
 /* SmartReflex fclk (VDD1) */
-static struct clk sr1_fck = {
+static struct clk __omap3_data sr1_fck = {
 	.name		= "sr1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
@@ -3048,7 +3048,7 @@ static struct clk sr1_fck = {
 };
 
 /* SmartReflex fclk (VDD2) */
-static struct clk sr2_fck = {
+static struct clk __omap3_data sr2_fck = {
 	.name		= "sr2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
@@ -3057,7 +3057,7 @@ static struct clk sr2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sr_l4_ick = {
+static struct clk __omap3_data sr_l4_ick = {
 	.name		= "sr_l4_ick",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &l4_ick,
@@ -3067,14 +3067,14 @@ static struct clk sr_l4_ick = {
 
 /* SECURE_32K_FCK clocks */
 
-static struct clk gpt12_fck = {
+static struct clk __omap3_data gpt12_fck = {
 	.name		= "gpt12_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt1_fck = {
+static struct clk __omap3_data wdt1_fck = {
 	.name		= "wdt1_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
@@ -3082,7 +3082,7 @@ static struct clk wdt1_fck = {
 };
 
 /* Clocks for AM35XX */
-static struct clk ipss_ick = {
+static struct clk __omap3_data ipss_ick = {
 	.name		= "ipss_ick",
 	.ops		= &clkops_am35xx_ipss_wait,
 	.parent		= &core_l3_ick,
@@ -3092,7 +3092,7 @@ static struct clk ipss_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk emac_ick = {
+static struct clk __omap3_data emac_ick = {
 	.name		= "emac_ick",
 	.ops		= &clkops_am35xx_ipss_module_wait,
 	.parent		= &ipss_ick,
@@ -3102,13 +3102,13 @@ static struct clk emac_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk rmii_ck = {
+static struct clk __omap3_data rmii_ck = {
 	.name		= "rmii_ck",
 	.ops		= &clkops_null,
 	.rate		= 50000000,
 };
 
-static struct clk emac_fck = {
+static struct clk __omap3_data emac_fck = {
 	.name		= "emac_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &rmii_ck,
@@ -3117,7 +3117,7 @@ static struct clk emac_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk hsotgusb_ick_am35xx = {
+static struct clk __omap3_data hsotgusb_ick_am35xx = {
 	.name		= "hsotgusb_ick",
 	.ops		= &clkops_am35xx_ipss_module_wait,
 	.parent		= &ipss_ick,
@@ -3127,7 +3127,7 @@ static struct clk hsotgusb_ick_am35xx = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk hsotgusb_fck_am35xx = {
+static struct clk __omap3_data hsotgusb_fck_am35xx = {
 	.name		= "hsotgusb_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,
@@ -3137,7 +3137,7 @@ static struct clk hsotgusb_fck_am35xx = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk hecc_ck = {
+static struct clk __omap3_data hecc_ck = {
 	.name		= "hecc_ck",
 	.ops		= &clkops_am35xx_ipss_module_wait,
 	.parent		= &sys_ck,
@@ -3147,7 +3147,7 @@ static struct clk hecc_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk vpfe_ick = {
+static struct clk __omap3_data vpfe_ick = {
 	.name		= "vpfe_ick",
 	.ops		= &clkops_am35xx_ipss_module_wait,
 	.parent		= &ipss_ick,
@@ -3157,13 +3157,13 @@ static struct clk vpfe_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk pclk_ck = {
+static struct clk __omap3_data pclk_ck = {
 	.name		= "pclk_ck",
 	.ops		= &clkops_null,
 	.rate		= 27000000,
 };
 
-static struct clk vpfe_fck = {
+static struct clk __omap3_data vpfe_fck = {
 	.name		= "vpfe_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &pclk_ck,
@@ -3176,7 +3176,7 @@ static struct clk vpfe_fck = {
  * The UART1/2 functional clock acts as the functional
  * clock for UART4. No separate fclk control available.
  */
-static struct clk uart4_ick_am35xx = {
+static struct clk __omap3_data uart4_ick_am35xx = {
 	.name		= "uart4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
@@ -3186,7 +3186,7 @@ static struct clk uart4_ick_am35xx = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dummy_apb_pclk = {
+static struct clk __omap3_data dummy_apb_pclk = {
 	.name		= "apb_pclk",
 	.ops		= &clkops_null,
 };
@@ -3196,7 +3196,7 @@ static struct clk dummy_apb_pclk = {
  */
 
 /* XXX At some point we should rename this file to clock3xxx_data.c */
-static struct omap_clk omap3xxx_clks[] = {
+static struct omap_clk __omap3_data omap3xxx_clks[] = {
 	CLK(NULL,	"apb_pclk",	&dummy_apb_pclk,	CK_3XXX),
 	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_3XXX),
 	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ed6bf4a..d435d46 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -36,50 +36,50 @@
  * elsewhere.
  */
 
-static struct omap_hwmod omap3xxx_mpu_hwmod;
-static struct omap_hwmod omap3xxx_iva_hwmod;
-static struct omap_hwmod omap3xxx_l3_main_hwmod;
-static struct omap_hwmod omap3xxx_l4_core_hwmod;
-static struct omap_hwmod omap3xxx_l4_per_hwmod;
-static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
-static struct omap_hwmod omap3xxx_i2c1_hwmod;
-static struct omap_hwmod omap3xxx_i2c2_hwmod;
-static struct omap_hwmod omap3xxx_i2c3_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_mpu_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_iva_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_l3_main_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_l4_core_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_l4_per_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_wd_timer2_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_i2c1_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_i2c2_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_i2c3_hwmod;
 
 /* L3 -> L4_CORE interface */
-static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
+static struct omap_hwmod_ocp_if __omap3_data omap3xxx_l3_main__l4_core = {
 	.master	= &omap3xxx_l3_main_hwmod,
 	.slave	= &omap3xxx_l4_core_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* L3 -> L4_PER interface */
-static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_per = {
+static struct omap_hwmod_ocp_if __omap3_data omap3xxx_l3_main__l4_per = {
 	.master = &omap3xxx_l3_main_hwmod,
 	.slave	= &omap3xxx_l4_per_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* MPU -> L3 interface */
-static struct omap_hwmod_ocp_if omap3xxx_mpu__l3_main = {
+static struct omap_hwmod_ocp_if __omap3_data omap3xxx_mpu__l3_main = {
 	.master = &omap3xxx_mpu_hwmod,
 	.slave	= &omap3xxx_l3_main_hwmod,
 	.user	= OCP_USER_MPU,
 };
 
 /* Slave interfaces on the L3 interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l3_main_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_l3_main_slaves[] = {
 	&omap3xxx_mpu__l3_main,
 };
 
 /* Master interfaces on the L3 interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l3_main_masters[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_l3_main_masters[] = {
 	&omap3xxx_l3_main__l4_core,
 	&omap3xxx_l3_main__l4_per,
 };
 
 /* L3 */
-static struct omap_hwmod omap3xxx_l3_main_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_l3_main_hwmod = {
 	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
 	.masters	= omap3xxx_l3_main_masters,
@@ -90,21 +90,21 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
-static struct omap_hwmod omap3xxx_uart1_hwmod;
-static struct omap_hwmod omap3xxx_uart2_hwmod;
-static struct omap_hwmod omap3xxx_uart3_hwmod;
-static struct omap_hwmod omap3xxx_uart4_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_l4_wkup_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_uart1_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_uart2_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_uart3_hwmod;
+static struct omap_hwmod __omap3_data omap3xxx_uart4_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
-static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
+static struct omap_hwmod_ocp_if __omap3_data omap3xxx_l4_core__l4_wkup = {
 	.master	= &omap3xxx_l4_core_hwmod,
 	.slave	= &omap3xxx_l4_wkup_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* L4 CORE -> UART1 interface */
-static struct omap_hwmod_addr_space omap3xxx_uart1_addr_space[] = {
+static struct omap_hwmod_addr_space __omap3_data omap3xxx_uart1_addr_space[] = {
 	{
 		.pa_start	= OMAP3_UART1_BASE,
 		.pa_end		= OMAP3_UART1_BASE + SZ_8K - 1,
@@ -112,7 +112,7 @@ static struct omap_hwmod_addr_space omap3xxx_uart1_addr_space[] = {
 	},
 };
 
-static struct omap_hwmod_ocp_if omap3_l4_core__uart1 = {
+static struct omap_hwmod_ocp_if __omap3_data omap3_l4_core__uart1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_uart1_hwmod,
 	.clk		= "uart1_ick",
@@ -122,7 +122,7 @@ static struct omap_hwmod_ocp_if omap3_l4_core__uart1 = {
 };
 
 /* L4 CORE -> UART2 interface */
-static struct omap_hwmod_addr_space omap3xxx_uart2_addr_space[] = {
+static struct omap_hwmod_addr_space __omap3_data omap3xxx_uart2_addr_space[] = {
 	{
 		.pa_start	= OMAP3_UART2_BASE,
 		.pa_end		= OMAP3_UART2_BASE + SZ_1K - 1,
@@ -130,7 +130,7 @@ static struct omap_hwmod_addr_space omap3xxx_uart2_addr_space[] = {
 	},
 };
 
-static struct omap_hwmod_ocp_if omap3_l4_core__uart2 = {
+static struct omap_hwmod_ocp_if __omap3_data omap3_l4_core__uart2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_uart2_hwmod,
 	.clk		= "uart2_ick",
@@ -140,7 +140,7 @@ static struct omap_hwmod_ocp_if omap3_l4_core__uart2 = {
 };
 
 /* L4 PER -> UART3 interface */
-static struct omap_hwmod_addr_space omap3xxx_uart3_addr_space[] = {
+static struct omap_hwmod_addr_space __omap3_data omap3xxx_uart3_addr_space[] = {
 	{
 		.pa_start	= OMAP3_UART3_BASE,
 		.pa_end		= OMAP3_UART3_BASE + SZ_1K - 1,
@@ -148,7 +148,7 @@ static struct omap_hwmod_addr_space omap3xxx_uart3_addr_space[] = {
 	},
 };
 
-static struct omap_hwmod_ocp_if omap3_l4_per__uart3 = {
+static struct omap_hwmod_ocp_if __omap3_data omap3_l4_per__uart3 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_uart3_hwmod,
 	.clk		= "uart3_ick",
@@ -158,7 +158,7 @@ static struct omap_hwmod_ocp_if omap3_l4_per__uart3 = {
 };
 
 /* L4 PER -> UART4 interface */
-static struct omap_hwmod_addr_space omap3xxx_uart4_addr_space[] = {
+static struct omap_hwmod_addr_space __omap3_data omap3xxx_uart4_addr_space[] = {
 	{
 		.pa_start	= OMAP3_UART4_BASE,
 		.pa_end		= OMAP3_UART4_BASE + SZ_1K - 1,
@@ -166,7 +166,7 @@ static struct omap_hwmod_addr_space omap3xxx_uart4_addr_space[] = {
 	},
 };
 
-static struct omap_hwmod_ocp_if omap3_l4_per__uart4 = {
+static struct omap_hwmod_ocp_if __omap3_data omap3_l4_per__uart4 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_uart4_hwmod,
 	.clk		= "uart4_ick",
@@ -179,7 +179,7 @@ static struct omap_hwmod_ocp_if omap3_l4_per__uart4 = {
 #define OMAP2_I2C_AS_LEN		128
 
 /* L4 CORE -> I2C1 interface */
-static struct omap_hwmod_addr_space omap3xxx_i2c1_addr_space[] = {
+static struct omap_hwmod_addr_space __omap3_data omap3xxx_i2c1_addr_space[] = {
 	{
 		.pa_start	= 0x48070000,
 		.pa_end		= 0x48070000 + OMAP2_I2C_AS_LEN - 1,
@@ -187,7 +187,7 @@ static struct omap_hwmod_addr_space omap3xxx_i2c1_addr_space[] = {
 	},
 };
 
-static struct omap_hwmod_ocp_if omap3_l4_core__i2c1 = {
+static struct omap_hwmod_ocp_if __omap3_data omap3_l4_core__i2c1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_i2c1_hwmod,
 	.clk		= "i2c1_ick",
@@ -204,7 +204,7 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c1 = {
 };
 
 /* L4 CORE -> I2C2 interface */
-static struct omap_hwmod_addr_space omap3xxx_i2c2_addr_space[] = {
+static struct omap_hwmod_addr_space __omap3_data omap3xxx_i2c2_addr_space[] = {
 	{
 		.pa_start	= 0x48072000,
 		.pa_end		= 0x48072000 + OMAP2_I2C_AS_LEN - 1,
@@ -212,7 +212,7 @@ static struct omap_hwmod_addr_space omap3xxx_i2c2_addr_space[] = {
 	},
 };
 
-static struct omap_hwmod_ocp_if omap3_l4_core__i2c2 = {
+static struct omap_hwmod_ocp_if __omap3_data omap3_l4_core__i2c2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_i2c2_hwmod,
 	.clk		= "i2c2_ick",
@@ -229,7 +229,7 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c2 = {
 };
 
 /* L4 CORE -> I2C3 interface */
-static struct omap_hwmod_addr_space omap3xxx_i2c3_addr_space[] = {
+static struct omap_hwmod_addr_space __omap3_data omap3xxx_i2c3_addr_space[] = {
 	{
 		.pa_start	= 0x48060000,
 		.pa_end		= 0x48060000 + OMAP2_I2C_AS_LEN - 1,
@@ -237,7 +237,7 @@ static struct omap_hwmod_addr_space omap3xxx_i2c3_addr_space[] = {
 	},
 };
 
-static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
+static struct omap_hwmod_ocp_if __omap3_data omap3_l4_core__i2c3 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_i2c3_hwmod,
 	.clk		= "i2c3_ick",
@@ -254,12 +254,12 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
 };
 
 /* Slave interfaces on the L4_CORE interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3_main__l4_core,
 };
 
 /* Master interfaces on the L4_CORE interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_l4_core_masters[] = {
 	&omap3xxx_l4_core__l4_wkup,
 	&omap3_l4_core__uart1,
 	&omap3_l4_core__uart2,
@@ -269,7 +269,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] = {
 };
 
 /* L4 CORE */
-static struct omap_hwmod omap3xxx_l4_core_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_l4_core_hwmod = {
 	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_core_masters,
@@ -281,18 +281,18 @@ static struct omap_hwmod omap3xxx_l4_core_hwmod = {
 };
 
 /* Slave interfaces on the L4_PER interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_per_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_l4_per_slaves[] = {
 	&omap3xxx_l3_main__l4_per,
 };
 
 /* Master interfaces on the L4_PER interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_l4_per_masters[] = {
 	&omap3_l4_per__uart3,
 	&omap3_l4_per__uart4,
 };
 
 /* L4 PER */
-static struct omap_hwmod omap3xxx_l4_per_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_l4_per_hwmod = {
 	.name		= "l4_per",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_per_masters,
@@ -304,16 +304,16 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 };
 
 /* Slave interfaces on the L4_WKUP interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_l4_wkup_slaves[] = {
 	&omap3xxx_l4_core__l4_wkup,
 };
 
 /* Master interfaces on the L4_WKUP interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_masters[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_l4_wkup_masters[] = {
 };
 
 /* L4 WKUP */
-static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_l4_wkup_hwmod = {
 	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_wkup_masters,
@@ -325,12 +325,12 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
 };
 
 /* Master interfaces on the MPU device */
-static struct omap_hwmod_ocp_if *omap3xxx_mpu_masters[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_mpu_masters[] = {
 	&omap3xxx_mpu__l3_main,
 };
 
 /* MPU */
-static struct omap_hwmod omap3xxx_mpu_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_mpu_hwmod = {
 	.name		= "mpu",
 	.class		= &mpu_hwmod_class,
 	.main_clk	= "arm_fck",
@@ -344,14 +344,14 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
  */
 
 /* IVA2 <- L3 interface */
-static struct omap_hwmod_ocp_if omap3xxx_l3__iva = {
+static struct omap_hwmod_ocp_if __omap3_data omap3xxx_l3__iva = {
 	.master		= &omap3xxx_l3_main_hwmod,
 	.slave		= &omap3xxx_iva_hwmod,
 	.clk		= "iva2_ck",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_ocp_if *omap3xxx_iva_masters[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_iva_masters[] = {
 	&omap3xxx_l3__iva,
 };
 
@@ -359,7 +359,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_iva_masters[] = {
  * IVA2 (IVA2)
  */
 
-static struct omap_hwmod omap3xxx_iva_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_iva_hwmod = {
 	.name		= "iva",
 	.class		= &iva_hwmod_class,
 	.masters	= omap3xxx_iva_masters,
@@ -368,7 +368,7 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 };
 
 /* l4_wkup -> wd_timer2 */
-static struct omap_hwmod_addr_space omap3xxx_wd_timer2_addrs[] = {
+static struct omap_hwmod_addr_space __omap3_data omap3xxx_wd_timer2_addrs[] = {
 	{
 		.pa_start	= 0x48314000,
 		.pa_end		= 0x4831407f,
@@ -376,7 +376,7 @@ static struct omap_hwmod_addr_space omap3xxx_wd_timer2_addrs[] = {
 	},
 };
 
-static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__wd_timer2 = {
+static struct omap_hwmod_ocp_if __omap3_data omap3xxx_l4_wkup__wd_timer2 = {
 	.master		= &omap3xxx_l4_wkup_hwmod,
 	.slave		= &omap3xxx_wd_timer2_hwmod,
 	.clk		= "wdt2_ick",
@@ -391,7 +391,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__wd_timer2 = {
  * overflow condition
  */
 
-static struct omap_hwmod_class_sysconfig omap3xxx_wd_timer_sysc = {
+static struct omap_hwmod_class_sysconfig __omap3_data omap3xxx_wd_timer_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
@@ -403,7 +403,7 @@ static struct omap_hwmod_class_sysconfig omap3xxx_wd_timer_sysc = {
 };
 
 /* I2C common */
-static struct omap_hwmod_class_sysconfig i2c_sysc = {
+static struct omap_hwmod_class_sysconfig __omap3_data i2c_sysc = {
 	.rev_offs	= 0x00,
 	.sysc_offs	= 0x20,
 	.syss_offs	= 0x10,
@@ -414,17 +414,17 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
-static struct omap_hwmod_class omap3xxx_wd_timer_hwmod_class = {
+static struct omap_hwmod_class __omap3_data omap3xxx_wd_timer_hwmod_class = {
 	.name = "wd_timer",
 	.sysc = &omap3xxx_wd_timer_sysc,
 };
 
 /* wd_timer2 */
-static struct omap_hwmod_ocp_if *omap3xxx_wd_timer2_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_wd_timer2_slaves[] = {
 	&omap3xxx_l4_wkup__wd_timer2,
 };
 
-static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_wd_timer2_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &omap3xxx_wd_timer_hwmod_class,
 	.main_clk	= "wdt2_fck",
@@ -444,7 +444,7 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
 
 /* UART common */
 
-static struct omap_hwmod_class_sysconfig uart_sysc = {
+static struct omap_hwmod_class_sysconfig __omap3_data uart_sysc = {
 	.rev_offs	= 0x50,
 	.sysc_offs	= 0x54,
 	.syss_offs	= 0x58,
@@ -455,27 +455,27 @@ static struct omap_hwmod_class_sysconfig uart_sysc = {
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
-static struct omap_hwmod_class uart_class = {
+static struct omap_hwmod_class __omap3_data uart_class = {
 	.name = "uart",
 	.sysc = &uart_sysc,
 };
 
 /* UART1 */
 
-static struct omap_hwmod_irq_info uart1_mpu_irqs[] = {
+static struct omap_hwmod_irq_info __omap3_data uart1_mpu_irqs[] = {
 	{ .irq = INT_24XX_UART1_IRQ, },
 };
 
-static struct omap_hwmod_dma_info uart1_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap3_data uart1_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART1_TX, },
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART1_RX, },
 };
 
-static struct omap_hwmod_ocp_if *omap3xxx_uart1_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_uart1_slaves[] = {
 	&omap3_l4_core__uart1,
 };
 
-static struct omap_hwmod omap3xxx_uart1_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_uart1_hwmod = {
 	.name		= "uart1",
 	.mpu_irqs	= uart1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart1_mpu_irqs),
@@ -499,20 +499,20 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 
 /* UART2 */
 
-static struct omap_hwmod_irq_info uart2_mpu_irqs[] = {
+static struct omap_hwmod_irq_info __omap3_data uart2_mpu_irqs[] = {
 	{ .irq = INT_24XX_UART2_IRQ, },
 };
 
-static struct omap_hwmod_dma_info uart2_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap3_data uart2_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART2_TX, },
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART2_RX, },
 };
 
-static struct omap_hwmod_ocp_if *omap3xxx_uart2_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_uart2_slaves[] = {
 	&omap3_l4_core__uart2,
 };
 
-static struct omap_hwmod omap3xxx_uart2_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_uart2_hwmod = {
 	.name		= "uart2",
 	.mpu_irqs	= uart2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart2_mpu_irqs),
@@ -536,20 +536,20 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 
 /* UART3 */
 
-static struct omap_hwmod_irq_info uart3_mpu_irqs[] = {
+static struct omap_hwmod_irq_info __omap3_data uart3_mpu_irqs[] = {
 	{ .irq = INT_24XX_UART3_IRQ, },
 };
 
-static struct omap_hwmod_dma_info uart3_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap3_data uart3_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART3_TX, },
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART3_RX, },
 };
 
-static struct omap_hwmod_ocp_if *omap3xxx_uart3_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_uart3_slaves[] = {
 	&omap3_l4_per__uart3,
 };
 
-static struct omap_hwmod omap3xxx_uart3_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_uart3_hwmod = {
 	.name		= "uart3",
 	.mpu_irqs	= uart3_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart3_mpu_irqs),
@@ -573,20 +573,20 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 
 /* UART4 */
 
-static struct omap_hwmod_irq_info uart4_mpu_irqs[] = {
+static struct omap_hwmod_irq_info __omap3_data uart4_mpu_irqs[] = {
 	{ .irq = INT_36XX_UART4_IRQ, },
 };
 
-static struct omap_hwmod_dma_info uart4_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap3_data uart4_sdma_reqs[] = {
 	{ .name = "rx",	.dma_req = OMAP36XX_DMA_UART4_RX, },
 	{ .name = "tx",	.dma_req = OMAP36XX_DMA_UART4_TX, },
 };
 
-static struct omap_hwmod_ocp_if *omap3xxx_uart4_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_uart4_slaves[] = {
 	&omap3_l4_per__uart4,
 };
 
-static struct omap_hwmod omap3xxx_uart4_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_uart4_hwmod = {
 	.name		= "uart4",
 	.mpu_irqs	= uart4_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart4_mpu_irqs),
@@ -608,31 +608,31 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
-static struct omap_hwmod_class i2c_class = {
+static struct omap_hwmod_class __omap3_data i2c_class = {
 	.name = "i2c",
 	.sysc = &i2c_sysc,
 };
 
 /* I2C1 */
 
-static struct omap_i2c_dev_attr i2c1_dev_attr = {
+static struct omap_i2c_dev_attr __omap3_data i2c1_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
 };
 
-static struct omap_hwmod_irq_info i2c1_mpu_irqs[] = {
+static struct omap_hwmod_irq_info __omap3_data i2c1_mpu_irqs[] = {
 	{ .irq = INT_24XX_I2C1_IRQ, },
 };
 
-static struct omap_hwmod_dma_info i2c1_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap3_data i2c1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C1_TX },
 	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C1_RX },
 };
 
-static struct omap_hwmod_ocp_if *omap3xxx_i2c1_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_i2c1_slaves[] = {
 	&omap3_l4_core__i2c1,
 };
 
-static struct omap_hwmod omap3xxx_i2c1_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.mpu_irqs	= i2c1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
@@ -656,24 +656,24 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 
 /* I2C2 */
 
-static struct omap_i2c_dev_attr i2c2_dev_attr = {
+static struct omap_i2c_dev_attr __omap3_data i2c2_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
 };
 
-static struct omap_hwmod_irq_info i2c2_mpu_irqs[] = {
+static struct omap_hwmod_irq_info __omap3_data i2c2_mpu_irqs[] = {
 	{ .irq = INT_24XX_I2C2_IRQ, },
 };
 
-static struct omap_hwmod_dma_info i2c2_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap3_data i2c2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C2_TX },
 	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C2_RX },
 };
 
-static struct omap_hwmod_ocp_if *omap3xxx_i2c2_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_i2c2_slaves[] = {
 	&omap3_l4_core__i2c2,
 };
 
-static struct omap_hwmod omap3xxx_i2c2_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.mpu_irqs	= i2c2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
@@ -697,24 +697,24 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 
 /* I2C3 */
 
-static struct omap_i2c_dev_attr i2c3_dev_attr = {
+static struct omap_i2c_dev_attr __omap3_data i2c3_dev_attr = {
 	.fifo_depth	= 64, /* bytes */
 };
 
-static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
+static struct omap_hwmod_irq_info __omap3_data i2c3_mpu_irqs[] = {
 	{ .irq = INT_34XX_I2C3_IRQ, },
 };
 
-static struct omap_hwmod_dma_info i2c3_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap3_data i2c3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = OMAP34XX_DMA_I2C3_TX },
 	{ .name = "rx", .dma_req = OMAP34XX_DMA_I2C3_RX },
 };
 
-static struct omap_hwmod_ocp_if *omap3xxx_i2c3_slaves[] = {
+static struct omap_hwmod_ocp_if __omap3_data *omap3xxx_i2c3_slaves[] = {
 	&omap3_l4_core__i2c3,
 };
 
-static struct omap_hwmod omap3xxx_i2c3_hwmod = {
+static struct omap_hwmod __omap3_data omap3xxx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.mpu_irqs	= i2c3_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c3_mpu_irqs),
-- 
1.7.0.4

