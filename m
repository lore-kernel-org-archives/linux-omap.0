From: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Subject: [PATCHV2 1/2] OMAP3630: Clock: add clksel_shift to struct clk
Date: Mon, 18 Jan 2010 18:04:24 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC11@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41011 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163Ab0ARMeq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 07:34:46 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Turquette, Mike" <mturquette@ti.com>

>From f9a7f877368830fdf28f9892940d05517f07a582 Mon Sep 17 00:00:00 2001
From: Mike Turquette <mturquette@ti.com>
Date: Tue, 12 Jan 2010 16:58:39 +0530
Subject: [PATCH 1/2] OMAP3630: Clock: add clksel_shift to struct clk

Introduces clksel_shift to struct clk and populates the same for
dpll4_m3_ck, dpll4_m4_ck, dpll4_m2_ck, dpll4_m6, dpll4_m5_ck and dpll3_m3.
The purpose of this change is to make it easy for a generic function to
refresh specific CM_CLKSEL registers on a per-clock basis by first
adding then subtracting the shift value from the register.This is the 
recommended sequence to solve HSDivider PWRDN limitations in OMAP3630.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Vijaykumar GN <vijaykumar.gn@ti.com>
---
 arch/arm/mach-omap2/clock34xx_data.c    |    6 ++++++
 arch/arm/plat-omap/include/plat/clock.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 6473247..ed17501 100755
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -537,6 +537,7 @@ static struct clk dpll3_m3_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
+	.clksel_shift	= OMAP3430_DIV_DPLL3_SHIFT,
 	.clksel		= div16_dpll3_clksel,
 	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
@@ -677,6 +678,7 @@ static struct clk dpll4_m2_ck_3630 __initdata  = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
 	.clksel_mask	= OMAP3630_DIV_96M_MASK,
+	.clksel_shift	= OMAP3430_DIV_96M_SHIFT,
 	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
@@ -792,6 +794,7 @@ static struct clk dpll4_m3_ck_3630 __initdata = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3630_CLKSEL_TV_MASK,
+	.clksel_shift = OMAP3430_CLKSEL_TV_SHIFT,
 	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
@@ -892,6 +895,7 @@ static struct clk dpll4_m4_ck_3630 __initdata = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3630_CLKSEL_DSS1_MASK,
+	.clksel_shift	= OMAP3430_CLKSEL_DSS1_SHIFT,
 	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
@@ -933,6 +937,7 @@ static struct clk dpll4_m5_ck_3630 __initdata = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3630_CLKSEL_CAM_MASK,
+	.clksel_shift	= OMAP3430_CLKSEL_CAM_SHIFT,
 	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
@@ -970,6 +975,7 @@ static struct clk dpll4_m6_ck_3630 __initdata = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3630_DIV_DPLL4_MASK,
+	.clksel_shift	= OMAP3430_DIV_DPLL4_SHIFT,
 	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 71d78f7..e841755 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -93,6 +93,7 @@ struct clk {
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 		defined(CONFIG_ARCH_OMAP4)
 	u8			fixed_div;
+	u8			clksel_shift;
 	void __iomem		*clksel_reg;
 	u32			clksel_mask;
 	const struct clksel	*clksel;
-- 
1.5.6.3

