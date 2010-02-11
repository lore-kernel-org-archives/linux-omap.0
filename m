From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV6 2/3] OMAP3: Introduce 3630 DPLL4 HSDivider changes
Date: Wed, 10 Feb 2010 23:49:51 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002102347340.28188@utopia.booyaka.com>
References: <1265789514-4329-1-git-send-email-vishwanath.bs@ti.com> <1265789514-4329-2-git-send-email-vishwanath.bs@ti.com> <1265789514-4329-3-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56357 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab0BKGtw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 01:49:52 -0500
In-Reply-To: <1265789514-4329-3-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, 10 Feb 2010, Vishwanath BS wrote:

> Divider (M2, M3, M4, M5 and M6) field width has been increased by 1 bit
> in 3630. This patch has changes to accommodate this in CM dynamically
> based on chip version.
> Basically new clock nodes have been added for 3630 DPLL4 M2,M3,M4,M5 and
> M6 and value of these nodes are used if cpu type is 3630.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

thanks, applied with a few minor changes for 2.6.34; revised patch 
follows.


- Paul

From: Vishwanath BS <vishwanath.bs@ti.com>
Date: Wed, 10 Feb 2010 17:18:24 -0700
Subject: [PATCH] OMAP3 clock: Introduce 3630 DPLL4 HSDivider changes

Divider (M2, M3, M4, M5 and M6) field width has been increased by 1 bit
in 3630. This patch has changes to accommodate this in CM dynamically
based on chip version.
Basically new clock nodes have been added for 3630 DPLL4 M2,M3,M4,M5 and
M6 and value of these nodes are used if cpu type is 3630.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
[paul@pwsan.com: updated to apply on 2.6.34 queue; comments added]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx_data.c    |  146 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/cm-regbits-34xx.h   |    5 +
 arch/arm/plat-omap/include/plat/clock.h |    5 +-
 3 files changed, 149 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 8be3eda..f58c895 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -237,6 +237,42 @@ static const struct clksel_rate div16_dpll_rates[] = {
 	{ .div = 0 }
 };
 
+static const struct clksel_rate div32_dpll4_rates_3630[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_36XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_36XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_36XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_36XX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_36XX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_36XX },
+	{ .div = 7, .val = 7, .flags = RATE_IN_36XX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_36XX },
+	{ .div = 9, .val = 9, .flags = RATE_IN_36XX },
+	{ .div = 10, .val = 10, .flags = RATE_IN_36XX },
+	{ .div = 11, .val = 11, .flags = RATE_IN_36XX },
+	{ .div = 12, .val = 12, .flags = RATE_IN_36XX },
+	{ .div = 13, .val = 13, .flags = RATE_IN_36XX },
+	{ .div = 14, .val = 14, .flags = RATE_IN_36XX },
+	{ .div = 15, .val = 15, .flags = RATE_IN_36XX },
+	{ .div = 16, .val = 16, .flags = RATE_IN_36XX },
+	{ .div = 17, .val = 17, .flags = RATE_IN_36XX },
+	{ .div = 18, .val = 18, .flags = RATE_IN_36XX },
+	{ .div = 19, .val = 19, .flags = RATE_IN_36XX },
+	{ .div = 20, .val = 20, .flags = RATE_IN_36XX },
+	{ .div = 21, .val = 21, .flags = RATE_IN_36XX },
+	{ .div = 22, .val = 22, .flags = RATE_IN_36XX },
+	{ .div = 23, .val = 23, .flags = RATE_IN_36XX },
+	{ .div = 24, .val = 24, .flags = RATE_IN_36XX },
+	{ .div = 25, .val = 25, .flags = RATE_IN_36XX },
+	{ .div = 26, .val = 26, .flags = RATE_IN_36XX },
+	{ .div = 27, .val = 27, .flags = RATE_IN_36XX },
+	{ .div = 28, .val = 28, .flags = RATE_IN_36XX },
+	{ .div = 29, .val = 29, .flags = RATE_IN_36XX },
+	{ .div = 30, .val = 30, .flags = RATE_IN_36XX },
+	{ .div = 31, .val = 31, .flags = RATE_IN_36XX },
+	{ .div = 32, .val = 32, .flags = RATE_IN_36XX },
+	{ .div = 0 }
+};
+
 /* DPLL1 */
 /* MPU clock source */
 /* Type: DPLL */
@@ -606,8 +642,15 @@ static const struct clksel div16_dpll4_clksel[] = {
 	{ .parent = NULL }
 };
 
+static const struct clksel div32_dpll4_clksel[] = {
+	{ .parent = &dpll4_ck, .rates = div32_dpll4_rates_3630 },
+	{ .parent = NULL }
+};
+
 /* This virtual clock is the source for dpll4_m2x2_ck */
-static struct clk dpll4_m2_ck = {
+static struct clk dpll4_m2_ck;
+
+static struct clk dpll4_m2_ck_34xx __initdata = {
 	.name		= "dpll4_m2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -619,6 +662,18 @@ static struct clk dpll4_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk dpll4_m2_ck_3630 __initdata  = {
+	.name		= "dpll4_m2_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
+	.clksel_mask	= OMAP3630_DIV_96M_MASK,
+	.clksel		= div32_dpll4_clksel,
+	.clkdm_name	= "dpll4_clkdm",
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m2x2_ck = {
 	.name		= "dpll4_m2x2_ck",
@@ -679,7 +734,9 @@ static struct clk omap_96m_fck = {
 };
 
 /* This virtual clock is the source for dpll4_m3x2_ck */
-static struct clk dpll4_m3_ck = {
+static struct clk dpll4_m3_ck;
+
+static struct clk dpll4_m3_ck_34xx __initdata = {
 	.name		= "dpll4_m3_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -691,6 +748,18 @@ static struct clk dpll4_m3_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk dpll4_m3_ck_3630 __initdata = {
+	.name		= "dpll4_m3_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3630_CLKSEL_TV_MASK,
+	.clksel		= div32_dpll4_clksel,
+	.clkdm_name	= "dpll4_clkdm",
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m3x2_ck = {
 	.name		= "dpll4_m3x2_ck",
@@ -764,7 +833,9 @@ static struct clk omap_12m_fck = {
 };
 
 /* This virstual clock is the source for dpll4_m4x2_ck */
-static struct clk dpll4_m4_ck = {
+static struct clk dpll4_m4_ck;
+
+static struct clk dpll4_m4_ck_34xx __initdata = {
 	.name		= "dpll4_m4_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -778,6 +849,20 @@ static struct clk dpll4_m4_ck = {
 	.round_rate	= &omap2_clksel_round_rate,
 };
 
+static struct clk dpll4_m4_ck_3630 __initdata = {
+	.name		= "dpll4_m4_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3630_CLKSEL_DSS1_MASK,
+	.clksel		= div32_dpll4_clksel,
+	.clkdm_name	= "dpll4_clkdm",
+	.recalc		= &omap2_clksel_recalc,
+	.set_rate	= &omap2_clksel_set_rate,
+	.round_rate	= &omap2_clksel_round_rate,
+};
+
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m4x2_ck = {
 	.name		= "dpll4_m4x2_ck",
@@ -791,7 +876,9 @@ static struct clk dpll4_m4x2_ck = {
 };
 
 /* This virtual clock is the source for dpll4_m5x2_ck */
-static struct clk dpll4_m5_ck = {
+static struct clk dpll4_m5_ck;
+
+static struct clk dpll4_m5_ck_34xx __initdata = {
 	.name		= "dpll4_m5_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -805,6 +892,18 @@ static struct clk dpll4_m5_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk dpll4_m5_ck_3630 __initdata = {
+	.name		= "dpll4_m5_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3630_CLKSEL_CAM_MASK,
+	.clksel		= div32_dpll4_clksel,
+	.clkdm_name	= "dpll4_clkdm",
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m5x2_ck = {
 	.name		= "dpll4_m5x2_ck",
@@ -818,7 +917,9 @@ static struct clk dpll4_m5x2_ck = {
 };
 
 /* This virtual clock is the source for dpll4_m6x2_ck */
-static struct clk dpll4_m6_ck = {
+static struct clk dpll4_m6_ck;
+
+static struct clk dpll4_m6_ck_34xx __initdata = {
 	.name		= "dpll4_m6_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
@@ -830,6 +931,18 @@ static struct clk dpll4_m6_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk dpll4_m6_ck_3630 __initdata = {
+	.name		= "dpll4_m6_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3630_DIV_DPLL4_MASK,
+	.clksel		= div32_dpll4_clksel,
+	.clkdm_name	= "dpll4_clkdm",
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m6x2_ck = {
 	.name		= "dpll4_m6x2_ck",
@@ -3384,6 +3497,19 @@ int __init omap3xxx_clk_init(void)
 	}
 
 	if (cpu_is_omap3630()) {
+		cpu_mask |= RATE_IN_36XX;
+		cpu_clkflg |= CK_36XX;
+
+		/*
+		 * XXX This type of dynamic rewriting of the clock tree is
+		 * deprecated and should be revised soon.
+		 */
+		dpll4_m2_ck = dpll4_m2_ck_3630;
+		dpll4_m3_ck = dpll4_m3_ck_3630;
+		dpll4_m4_ck = dpll4_m4_ck_3630;
+		dpll4_m5_ck = dpll4_m5_ck_3630;
+		dpll4_m6_ck = dpll4_m6_ck_3630;
+
 		/*
 		 * For 3630: override clkops_omap2_dflt_wait for the
 		 * clocks affected from PWRDN reset Limitation
@@ -3400,6 +3526,16 @@ int __init omap3xxx_clk_init(void)
 				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
 		dpll4_m6x2_ck.ops =
 				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
+	} else {
+		/*
+		 * XXX This type of dynamic rewriting of the clock tree is
+		 * deprecated and should be revised soon.
+		 */
+		dpll4_m2_ck = dpll4_m2_ck_34xx;
+		dpll4_m3_ck = dpll4_m3_ck_34xx;
+		dpll4_m4_ck = dpll4_m4_ck_34xx;
+		dpll4_m5_ck = dpll4_m5_ck_34xx;
+		dpll4_m6_ck = dpll4_m6_ck_34xx;
 	}
 
 	if (cpu_is_omap3630())
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 29cd13b..e6a724c 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -542,6 +542,7 @@
 /* CM_CLKSEL3_PLL */
 #define OMAP3430_DIV_96M_SHIFT				0
 #define OMAP3430_DIV_96M_MASK				(0x1f << 0)
+#define OMAP3630_DIV_96M_MASK				(0x3f << 0)
 
 /* CM_CLKSEL4_PLL */
 #define OMAP3430ES2_PERIPH2_DPLL_MULT_SHIFT		8
@@ -588,8 +589,10 @@
 /* CM_CLKSEL_DSS */
 #define OMAP3430_CLKSEL_TV_SHIFT			8
 #define OMAP3430_CLKSEL_TV_MASK				(0x1f << 8)
+#define OMAP3630_CLKSEL_TV_MASK				(0x3f << 8)
 #define OMAP3430_CLKSEL_DSS1_SHIFT			0
 #define OMAP3430_CLKSEL_DSS1_MASK			(0x1f << 0)
+#define OMAP3630_CLKSEL_DSS1_MASK			(0x3f << 0)
 
 /* CM_SLEEPDEP_DSS specific bits */
 
@@ -617,6 +620,7 @@
 /* CM_CLKSEL_CAM */
 #define OMAP3430_CLKSEL_CAM_SHIFT			0
 #define OMAP3430_CLKSEL_CAM_MASK			(0x1f << 0)
+#define OMAP3630_CLKSEL_CAM_MASK			(0x3f << 0)
 
 /* CM_SLEEPDEP_CAM specific bits */
 
@@ -712,6 +716,7 @@
 /* CM_CLKSEL1_EMU */
 #define OMAP3430_DIV_DPLL4_SHIFT			24
 #define OMAP3430_DIV_DPLL4_MASK				(0x1f << 24)
+#define OMAP3630_DIV_DPLL4_MASK				(0x3f << 24)
 #define OMAP3430_DIV_DPLL3_SHIFT			16
 #define OMAP3430_DIV_DPLL3_MASK				(0x1f << 16)
 #define OMAP3430_CLKSEL_TRACECLK_SHIFT			11
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 66ebb08..62fd64f 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -169,8 +169,9 @@ extern const struct clkops clkops_null;
 #define RATE_IN_242X		(1 << 1)
 #define RATE_IN_243X		(1 << 2)
 #define RATE_IN_343X		(1 << 3)	/* rates common to all 343X */
-#define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates only */
-#define RATE_IN_4430            (1 << 5)
+#define RATE_IN_3430ES2	(1 << 4)	/* 3430ES2 rates only */
+#define RATE_IN_36XX		(1 << 5)
+#define RATE_IN_4430		(1 << 6)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 
-- 
1.6.6.GIT

