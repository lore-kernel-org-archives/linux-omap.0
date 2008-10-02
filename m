From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/10] OMAP3 PRCM: add DPLL1-5 powerdomains, clockdomains;
	mark clocks
Date: Thu, 02 Oct 2008 10:37:55 -0600
Message-ID: <20081002163755.15385.16783.stgit@localhost.localdomain>
References: <20081002163508.15385.43247.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51931 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbYJBQrN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 12:47:13 -0400
In-Reply-To: <20081002163508.15385.43247.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Each DPLL exists in its own powerdomain (cf 34xx TRM figure 4-18) and
clockdomain; so, create powerdomain and clockdomain structures for them.
Mark each DPLL clock as belonging to their respective DPLL clockdomain.
cf. 34xx TRM Table 4-27 (among other references).

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock34xx.h        |   27 +++++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomains.h     |   35 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains.h     |    5 +++++
 arch/arm/mach-omap2/powerdomains34xx.h |   31 ++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 7578146..f1c5c58 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -316,6 +316,7 @@ static struct clk dpll1_ck = {
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm		= { .name = "dpll1_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -328,6 +329,7 @@ static struct clk dpll1_x2_ck = {
 	.parent		= &dpll1_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll1_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -350,6 +352,7 @@ static struct clk dpll1_x2m2_ck = {
 	.clksel		= div16_dpll1_x2m2_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll1_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -387,6 +390,7 @@ static struct clk dpll2_ck = {
 	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm		= { .name = "dpll2_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -409,6 +413,7 @@ static struct clk dpll2_m2_ck = {
 	.clksel		= div16_dpll2_m2x2_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll2_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -440,6 +445,7 @@ static struct clk dpll3_ck = {
 	.dpll_data	= &dpll3_dd,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.round_rate	= &omap2_dpll_round_rate,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -452,6 +458,7 @@ static struct clk dpll3_x2_ck = {
 	.parent		= &dpll3_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -509,6 +516,7 @@ static struct clk dpll3_m2_ck = {
 	.clksel		= div31_dpll3m2_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -544,6 +552,7 @@ static struct clk dpll3_m2x2_ck = {
 	.clksel		= dpll3_m2x2_ck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -563,6 +572,7 @@ static struct clk dpll3_m3_ck = {
 	.clksel		= div16_dpll3_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -573,6 +583,7 @@ static struct clk dpll3_m3x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_CORE_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -591,6 +602,7 @@ static struct clk emu_core_alwon_ck = {
 	.clksel		= emu_core_alwon_ck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll3_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -626,6 +638,7 @@ static struct clk dpll4_ck = {
 	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -639,6 +652,7 @@ static struct clk dpll4_x2_ck = {
 	.parent		= &dpll4_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -657,6 +671,7 @@ static struct clk dpll4_m2_ck = {
 	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -667,6 +682,7 @@ static struct clk dpll4_m2x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_96M_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -743,6 +759,7 @@ static struct clk dpll4_m3_ck = {
 	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -754,6 +771,7 @@ static struct clk dpll4_m3x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_TV_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -852,6 +870,7 @@ static struct clk dpll4_m4_ck = {
 	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -862,6 +881,7 @@ static struct clk dpll4_m4x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -875,6 +895,7 @@ static struct clk dpll4_m5_ck = {
 	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -885,6 +906,7 @@ static struct clk dpll4_m5x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -898,6 +920,7 @@ static struct clk dpll4_m6_ck = {
 	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -909,6 +932,7 @@ static struct clk dpll4_m6x2_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -917,6 +941,7 @@ static struct clk emu_per_alwon_ck = {
 	.parent		= &dpll4_m6x2_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -953,6 +978,7 @@ static struct clk dpll5_ck = {
 	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm		= { .name = "dpll5_clkdm" },
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -970,6 +996,7 @@ static struct clk dpll5_m2_ck = {
 	.clksel		= div16_dpll5_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll5_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index e8320ee..bafa650 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -259,6 +259,36 @@ static struct clockdomain emu_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+static struct clockdomain dpll1_clkdm = {
+	.name		= "dpll1_clkdm",
+	.pwrdm		= { .name = "dpll1_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct clockdomain dpll2_clkdm = {
+	.name		= "dpll2_clkdm",
+	.pwrdm		= { .name = "dpll2_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct clockdomain dpll3_clkdm = {
+	.name		= "dpll3_clkdm",
+	.pwrdm		= { .name = "dpll3_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct clockdomain dpll4_clkdm = {
+	.name		= "dpll4_clkdm",
+	.pwrdm		= { .name = "dpll4_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct clockdomain dpll5_clkdm = {
+	.name		= "dpll5_clkdm",
+	.pwrdm		= { .name = "dpll5_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+};
+
 #endif   /* CONFIG_ARCH_OMAP34XX */
 
 /*
@@ -321,6 +351,11 @@ static struct clockdomain *clockdomains_omap[] = {
 	&usbhost_clkdm,
 	&per_clkdm,
 	&emu_clkdm,
+	&dpll1_clkdm,
+	&dpll2_clkdm,
+	&dpll3_clkdm,
+	&dpll4_clkdm,
+	&dpll5_clkdm,
 #endif
 
 	NULL,
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index 1e151fa..1329443 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -178,6 +178,11 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 	&emu_pwrdm,
 	&sgx_pwrdm,
 	&usbhost_pwrdm,
+	&dpll1_pwrdm,
+	&dpll2_pwrdm,
+	&dpll3_pwrdm,
+	&dpll4_pwrdm,
+	&dpll5_pwrdm,
 #endif
 
 	NULL
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index f573f71..46c2146 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -321,6 +321,37 @@ static struct powerdomain usbhost_pwrdm = {
 	},
 };
 
+static struct powerdomain dpll1_pwrdm = {
+	.name		= "dpll1_pwrdm",
+	.prcm_offs	= MPU_MOD,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct powerdomain dpll2_pwrdm = {
+	.name		= "dpll2_pwrdm",
+	.prcm_offs	= OMAP3430_IVA2_MOD,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct powerdomain dpll3_pwrdm = {
+	.name		= "dpll3_pwrdm",
+	.prcm_offs	= PLL_MOD,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct powerdomain dpll4_pwrdm = {
+	.name		= "dpll4_pwrdm",
+	.prcm_offs	= PLL_MOD,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct powerdomain dpll5_pwrdm = {
+	.name		= "dpll5_pwrdm",
+	.prcm_offs	= PLL_MOD,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+};
+
+
 #endif    /* CONFIG_ARCH_OMAP34XX */
 
 


