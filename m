From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/10] OMAP3 clock: remove unnecessary duplicate of
	dpll4_m2_ck, added for 36xx
Date: Mon, 26 Apr 2010 01:04:35 -0600
Message-ID: <20100426070434.9743.55620.stgit@localhost.localdomain>
References: <20100426070217.9743.92728.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52250 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab0DZHHg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 03:07:36 -0400
In-Reply-To: <20100426070217.9743.92728.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Commit 678bc9a2eabb7f444ef8ad1cfc5ef394e2bd8bf2 split dpll4_m2_ck,
creating a 34xx and a 36xx variant, to handle the additional 16
divider steps provided on the 36xx.  This in turn required dynamic
rewriting of the clock tree during initialization, which is
undesirable.  All this seems to be unnecessary, though, since the
additional 16 divider steps can simply be marked with RATE_IN_36XX.
This patch does so and re-merges the affected structures.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |  163 ++++++++--------------------------
 1 files changed, 36 insertions(+), 127 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 68aae9f..fbd2796 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -232,23 +232,23 @@ static const struct clksel_rate div16_dpll_rates[] = {
 	{ .div = 0 }
 };
 
-static const struct clksel_rate div32_dpll4_rates_3630[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_36XX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_36XX },
-	{ .div = 3, .val = 3, .flags = RATE_IN_36XX },
-	{ .div = 4, .val = 4, .flags = RATE_IN_36XX },
-	{ .div = 5, .val = 5, .flags = RATE_IN_36XX },
-	{ .div = 6, .val = 6, .flags = RATE_IN_36XX },
-	{ .div = 7, .val = 7, .flags = RATE_IN_36XX },
-	{ .div = 8, .val = 8, .flags = RATE_IN_36XX },
-	{ .div = 9, .val = 9, .flags = RATE_IN_36XX },
-	{ .div = 10, .val = 10, .flags = RATE_IN_36XX },
-	{ .div = 11, .val = 11, .flags = RATE_IN_36XX },
-	{ .div = 12, .val = 12, .flags = RATE_IN_36XX },
-	{ .div = 13, .val = 13, .flags = RATE_IN_36XX },
-	{ .div = 14, .val = 14, .flags = RATE_IN_36XX },
-	{ .div = 15, .val = 15, .flags = RATE_IN_36XX },
-	{ .div = 16, .val = 16, .flags = RATE_IN_36XX },
+static const struct clksel_rate dpll4_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_3XXX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_3XXX },
+	{ .div = 7, .val = 7, .flags = RATE_IN_3XXX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_3XXX },
+	{ .div = 9, .val = 9, .flags = RATE_IN_3XXX },
+	{ .div = 10, .val = 10, .flags = RATE_IN_3XXX },
+	{ .div = 11, .val = 11, .flags = RATE_IN_3XXX },
+	{ .div = 12, .val = 12, .flags = RATE_IN_3XXX },
+	{ .div = 13, .val = 13, .flags = RATE_IN_3XXX },
+	{ .div = 14, .val = 14, .flags = RATE_IN_3XXX },
+	{ .div = 15, .val = 15, .flags = RATE_IN_3XXX },
+	{ .div = 16, .val = 16, .flags = RATE_IN_3XXX },
 	{ .div = 17, .val = 17, .flags = RATE_IN_36XX },
 	{ .div = 18, .val = 18, .flags = RATE_IN_36XX },
 	{ .div = 19, .val = 19, .flags = RATE_IN_36XX },
@@ -562,6 +562,7 @@ static struct clk emu_core_alwon_ck = {
 /* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace clk */
 /* Type: DPLL */
 static struct dpll_data dpll4_dd;
+
 static struct dpll_data dpll4_dd_34xx __initdata = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
 	.mult_mask	= OMAP3430_PERIPH_DPLL_MULT_MASK,
@@ -632,39 +633,20 @@ static struct clk dpll4_x2_ck = {
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
-static const struct clksel div16_dpll4_clksel[] = {
-	{ .parent = &dpll4_ck, .rates = div16_dpll_rates },
-	{ .parent = NULL }
-};
-
-static const struct clksel div32_dpll4_clksel[] = {
-	{ .parent = &dpll4_ck, .rates = div32_dpll4_rates_3630 },
+static const struct clksel dpll4_clksel[] = {
+	{ .parent = &dpll4_ck, .rates = dpll4_rates },
 	{ .parent = NULL }
 };
 
 /* This virtual clock is the source for dpll4_m2x2_ck */
-static struct clk dpll4_m2_ck;
-
-static struct clk dpll4_m2_ck_34xx __initdata = {
-	.name		= "dpll4_m2_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
-	.clksel_mask	= OMAP3430_DIV_96M_MASK,
-	.clksel		= div16_dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk dpll4_m2_ck_3630 __initdata  = {
+static struct clk dpll4_m2_ck = {
 	.name		= "dpll4_m2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
 	.clksel_mask	= OMAP3630_DIV_96M_MASK,
-	.clksel		= div32_dpll4_clksel,
+	.clksel		= dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -760,28 +742,14 @@ static struct clk omap_96m_fck = {
 };
 
 /* This virtual clock is the source for dpll4_m3x2_ck */
-static struct clk dpll4_m3_ck;
-
-static struct clk dpll4_m3_ck_34xx __initdata = {
+static struct clk dpll4_m3_ck = {
 	.name		= "dpll4_m3_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
-	.clksel		= div16_dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk dpll4_m3_ck_3630 __initdata = {
-	.name		= "dpll4_m3_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3630_CLKSEL_TV_MASK,
-	.clksel		= div32_dpll4_clksel,
+	.clksel		= dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -858,31 +826,15 @@ static struct clk omap_12m_fck = {
 	.recalc		= &omap_fixed_divisor_recalc,
 };
 
-/* This virstual clock is the source for dpll4_m4x2_ck */
-static struct clk dpll4_m4_ck;
-
-static struct clk dpll4_m4_ck_34xx __initdata = {
+/* This virtual clock is the source for dpll4_m4x2_ck */
+static struct clk dpll4_m4_ck = {
 	.name		= "dpll4_m4_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
-	.clksel		= div16_dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-	.set_rate	= &omap2_clksel_set_rate,
-	.round_rate	= &omap2_clksel_round_rate,
-};
-
-static struct clk dpll4_m4_ck_3630 __initdata = {
-	.name		= "dpll4_m4_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3630_CLKSEL_DSS1_MASK,
-	.clksel		= div32_dpll4_clksel,
+	.clksel		= dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -902,30 +854,14 @@ static struct clk dpll4_m4x2_ck = {
 };
 
 /* This virtual clock is the source for dpll4_m5x2_ck */
-static struct clk dpll4_m5_ck;
-
-static struct clk dpll4_m5_ck_34xx __initdata = {
+static struct clk dpll4_m5_ck = {
 	.name		= "dpll4_m5_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
-	.clksel		= div16_dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
-	.set_rate	= &omap2_clksel_set_rate,
-	.round_rate	= &omap2_clksel_round_rate,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk dpll4_m5_ck_3630 __initdata = {
-	.name		= "dpll4_m5_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3630_CLKSEL_CAM_MASK,
-	.clksel		= div32_dpll4_clksel,
+	.clksel		= dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.set_rate	= &omap2_clksel_set_rate,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -945,28 +881,14 @@ static struct clk dpll4_m5x2_ck = {
 };
 
 /* This virtual clock is the source for dpll4_m6x2_ck */
-static struct clk dpll4_m6_ck;
-
-static struct clk dpll4_m6_ck_34xx __initdata = {
+static struct clk dpll4_m6_ck = {
 	.name		= "dpll4_m6_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
-	.clksel		= div16_dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk dpll4_m6_ck_3630 __initdata = {
-	.name		= "dpll4_m6_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3630_DIV_DPLL4_MASK,
-	.clksel		= div32_dpll4_clksel,
+	.clksel		= dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3521,14 +3443,7 @@ int __init omap3xxx_clk_init(void)
 		/*
 		 * XXX This type of dynamic rewriting of the clock tree is
 		 * deprecated and should be revised soon.
-		 */
-		dpll4_m2_ck = dpll4_m2_ck_3630;
-		dpll4_m3_ck = dpll4_m3_ck_3630;
-		dpll4_m4_ck = dpll4_m4_ck_3630;
-		dpll4_m5_ck = dpll4_m5_ck_3630;
-		dpll4_m6_ck = dpll4_m6_ck_3630;
-
-		/*
+		 *
 		 * For 3630: override clkops_omap2_dflt_wait for the
 		 * clocks affected from PWRDN reset Limitation
 		 */
@@ -3544,18 +3459,12 @@ int __init omap3xxx_clk_init(void)
 				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
 		dpll4_m6x2_ck.ops =
 				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
-	} else {
-		/*
-		 * XXX This type of dynamic rewriting of the clock tree is
-		 * deprecated and should be revised soon.
-		 */
-		dpll4_m2_ck = dpll4_m2_ck_34xx;
-		dpll4_m3_ck = dpll4_m3_ck_34xx;
-		dpll4_m4_ck = dpll4_m4_ck_34xx;
-		dpll4_m5_ck = dpll4_m5_ck_34xx;
-		dpll4_m6_ck = dpll4_m6_ck_34xx;
 	}
 
+	/*
+	 * XXX This type of dynamic rewriting of the clock tree is
+	 * deprecated and should be revised soon.
+	 */
 	if (cpu_is_omap3630())
 		dpll4_dd = dpll4_dd_3630;
 	else


