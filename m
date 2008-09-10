From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 08/12] OMAP3 clock: mark DPLL clocks with their DPLLx
	clockdomains
Date: Wed, 10 Sep 2008 10:47:58 -0600
Message-ID: <20080910164755.17024.36446.stgit@localhost.localdomain>
References: <20080910164631.17024.43733.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58276 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbYIJQs6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 12:48:58 -0400
In-Reply-To: <20080910164631.17024.43733.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Mark each DPLL clock as belonging to their respective DPLL clockdomain.
cf. 34xx TRM Table 4-27 (among other references).

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 0c2acea..682f43a 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -323,6 +323,7 @@ static struct clk dpll1_ck = {
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm		= { .name = "dpll1_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -335,6 +336,7 @@ static struct clk dpll1_x2_ck = {
 	.parent		= &dpll1_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll1_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -357,6 +359,7 @@ static struct clk dpll1_x2m2_ck = {
 	.clksel		= div16_dpll1_x2m2_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll1_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -394,6 +397,7 @@ static struct clk dpll2_ck = {
 	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm		= { .name = "dpll2_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -416,6 +420,7 @@ static struct clk dpll2_m2_ck = {
 	.clksel		= div16_dpll2_m2x2_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll2_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -447,6 +452,7 @@ static struct clk dpll3_ck = {
 	.dpll_data	= &dpll3_dd,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.round_rate	= &omap2_dpll_round_rate,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -459,6 +465,7 @@ static struct clk dpll3_x2_ck = {
 	.parent		= &dpll3_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -512,6 +519,7 @@ static struct clk dpll3_m2_ck = {
 	.clksel		= div31_dpll3m2_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap3_core_dpll_m2_set_rate,
 	.recalc		= &omap2_clksel_recalc,
@@ -549,6 +557,7 @@ static struct clk dpll3_m2x2_ck = {
 	.clksel		= dpll3_m2x2_ck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -568,6 +577,7 @@ static struct clk dpll3_m3_ck = {
 	.clksel		= div16_dpll3_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -578,6 +588,7 @@ static struct clk dpll3_m3x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_CORE_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -596,6 +607,7 @@ static struct clk emu_core_alwon_ck = {
 	.clksel		= emu_core_alwon_ck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -631,6 +643,7 @@ static struct clk dpll4_ck = {
 	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -644,6 +657,7 @@ static struct clk dpll4_x2_ck = {
 	.parent		= &dpll4_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -662,6 +676,7 @@ static struct clk dpll4_m2_ck = {
 	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -672,6 +687,7 @@ static struct clk dpll4_m2x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_96M_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -748,6 +764,7 @@ static struct clk dpll4_m3_ck = {
 	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -759,6 +776,7 @@ static struct clk dpll4_m3x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_TV_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -857,6 +875,7 @@ static struct clk dpll4_m4_ck = {
 	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -867,6 +886,7 @@ static struct clk dpll4_m4x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_DSS1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -880,6 +900,7 @@ static struct clk dpll4_m5_ck = {
 	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -890,6 +911,7 @@ static struct clk dpll4_m5x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -903,6 +925,7 @@ static struct clk dpll4_m6_ck = {
 	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -914,6 +937,7 @@ static struct clk dpll4_m6x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -922,6 +946,7 @@ static struct clk emu_per_alwon_ck = {
 	.parent		= &dpll4_m6x2_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -958,6 +983,7 @@ static struct clk dpll5_ck = {
 	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm		= { .name = "dpll5_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -975,6 +1001,7 @@ static struct clk dpll5_m2_ck = {
 	.clksel		= div16_dpll5_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll5_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 


