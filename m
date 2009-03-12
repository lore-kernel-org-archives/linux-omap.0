From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 49/86] [ARM] OMAP3 PRCM: add DPLL1-5 powerdomains, clockdomains; mark clocks
Date: Thu, 12 Mar 2009 11:27:59 -0700
Message-ID: <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739AbZCLScR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:32:17 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:32:16 -0700 (PDT)
In-Reply-To: <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Each DPLL exists in its own powerdomain (cf 34xx TRM figure 4-18) and
clockdomain; so, create powerdomain and clockdomain structures for them.
Mark each DPLL clock as belonging to their respective DPLL clockdomain.
cf. 34xx TRM Table 4-27 (among other references).

linux-omap source commits are acdb615850b9b4f7d1ab68133a16be8c8c0e7419 and
a8798a48f33e9268dcc7f30a4b4a3ce4220fe0c9.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock34xx.h        |   27 ++++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomains.h     |   35 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains.h     |    5 ++++
 arch/arm/mach-omap2/powerdomains34xx.h |   31 ++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index baed53f..9dec698 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -280,6 +280,7 @@ static struct clk dpll1_ck = {
 	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm_name	= "dpll1_clkdm",
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -292,6 +293,7 @@ static struct clk dpll1_x2_ck = {
 	.ops		= &clkops_null,
 	.parent		= &dpll1_ck,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll1_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -314,6 +316,7 @@ static struct clk dpll1_x2m2_ck = {
 	.clksel_mask	= OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll1_x2m2_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll1_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -350,6 +353,7 @@ static struct clk dpll2_ck = {
 	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm_name	= "dpll2_clkdm",
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -372,6 +376,7 @@ static struct clk dpll2_m2_ck = {
 	.clksel_mask	= OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll2_m2x2_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll2_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -404,6 +409,7 @@ static struct clk dpll3_ck = {
 	.dpll_data	= &dpll3_dd,
 	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
+	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -416,6 +422,7 @@ static struct clk dpll3_x2_ck = {
 	.ops		= &clkops_null,
 	.parent		= &dpll3_ck,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -473,6 +480,7 @@ static struct clk dpll3_m2_ck = {
 	.clksel_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div31_dpll3m2_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -507,6 +515,7 @@ static struct clk dpll3_m2x2_ck = {
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= dpll3_m2x2_ck_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -526,6 +535,7 @@ static struct clk dpll3_m3_ck = {
 	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
 	.clksel		= div16_dpll3_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -537,6 +547,7 @@ static struct clk dpll3_m3x2_ck = {
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_CORE_SHIFT,
 	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -555,6 +566,7 @@ static struct clk emu_core_alwon_ck = {
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= emu_core_alwon_ck_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -589,6 +601,7 @@ static struct clk dpll4_ck = {
 	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_dpll4_set_rate,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -602,6 +615,7 @@ static struct clk dpll4_x2_ck = {
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -620,6 +634,7 @@ static struct clk dpll4_m2_ck = {
 	.clksel_mask	= OMAP3430_DIV_96M_MASK,
 	.clksel		= div16_dpll4_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -631,6 +646,7 @@ static struct clk dpll4_m2x2_ck = {
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_96M_SHIFT,
 	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -704,6 +720,7 @@ static struct clk dpll4_m3_ck = {
 	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
 	.clksel		= div16_dpll4_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -716,6 +733,7 @@ static struct clk dpll4_m3x2_ck = {
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_TV_SHIFT,
 	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -810,6 +828,7 @@ static struct clk dpll4_m4_ck = {
 	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
 	.clksel		= div16_dpll4_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 	.set_rate	= &omap2_clksel_set_rate,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -823,6 +842,7 @@ static struct clk dpll4_m4x2_ck = {
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
 	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -836,6 +856,7 @@ static struct clk dpll4_m5_ck = {
 	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
 	.clksel		= div16_dpll4_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -847,6 +868,7 @@ static struct clk dpll4_m5x2_ck = {
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
 	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -860,6 +882,7 @@ static struct clk dpll4_m6_ck = {
 	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
 	.clksel		= div16_dpll4_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -872,6 +895,7 @@ static struct clk dpll4_m6x2_ck = {
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
 	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -880,6 +904,7 @@ static struct clk emu_per_alwon_ck = {
 	.ops		= &clkops_null,
 	.parent		= &dpll4_m6x2_ck,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -915,6 +940,7 @@ static struct clk dpll5_ck = {
 	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm_name	= "dpll5_clkdm",
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -932,6 +958,7 @@ static struct clk dpll5_m2_ck = {
 	.clksel_mask	= OMAP3430ES2_DIV_120M_MASK,
 	.clksel		= div16_dpll5_clksel,
 	.flags		= RATE_PROPAGATES,
+	.clkdm_name	= "dpll5_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index ec5a720..9eb7343 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -256,6 +256,36 @@ static struct clockdomain emu_clkdm = {
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
@@ -318,6 +348,11 @@ static struct clockdomain *clockdomains_omap[] = {
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
index 3a8e4fb..7b63fa0 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -322,6 +322,37 @@ static struct powerdomain usbhost_pwrdm = {
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
 
 
-- 
1.6.1.2

