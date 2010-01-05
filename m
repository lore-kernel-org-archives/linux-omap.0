From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV4 2/3] OMAP3: Correct width for CLKSEL Fields
Date: Tue,  5 Jan 2010 12:06:09 +0530
Message-ID: <1262673370-5757-3-git-send-email-vishwanath.bs@ti.com>
References: <1262673370-5757-1-git-send-email-vishwanath.bs@ti.com>
 <1262673370-5757-2-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48663 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326Ab0AEGde (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jan 2010 01:33:34 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o056XVXZ028951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 5 Jan 2010 00:33:33 -0600
In-Reply-To: <1262673370-5757-2-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

DPLL4 M, M3, M4, M5 and M6 field width has been increased by 1 bit in
3630. This patch has changes to accommodate this in CM dynamically based
on chip version.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/clock34xx_data.c    |  153 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock44xx_data.c    |    2 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h   |    9 ++-
 arch/arm/plat-omap/include/plat/clock.h |    1 +
 4 files changed, 160 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 9aac354..fa0476c
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -236,6 +236,42 @@ static const struct clksel_rate div16_dpll_rates[] = {
 	{ .div = 0 }
 };
 
+static const struct clksel_rate div32_dpll_rates[] = {
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
@@ -552,6 +588,33 @@ static struct dpll_data dpll4_dd = {
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
+/* DPLL4 */
+/* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace clk */
+/* Type: DPLL */
+static struct dpll_data dpll4_dd_3630 = {
+	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
+	.mult_mask	= OMAP3630_PERIPH_DPLL_MULT_MASK,
+	.div1_mask	= OMAP3430_PERIPH_DPLL_DIV_MASK,
+	.clk_bypass	= &sys_ck,
+	.clk_ref	= &sys_ck,
+	.freqsel_mask	= OMAP3430_PERIPH_DPLL_FREQSEL_MASK,
+	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_mask	= OMAP3430_EN_PERIPH_DPLL_MASK,
+	.modes		= (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
+	.auto_recal_bit	= OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
+	.recal_en_bit	= OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
+	.recal_st_bit	= OMAP3430_PERIPH_DPLL_ST_SHIFT,
+	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
+	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
+	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
+	.max_divider	= OMAP3_MAX_DPLL_DIV,
+	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE,
+	.flags	= DPLL_J_TYPE
+};
+
 static struct clk dpll4_ck = {
 	.name		= "dpll4_ck",
 	.ops		= &clkops_noncore_dpll_ops,
@@ -563,6 +626,17 @@ static struct clk dpll4_ck = {
 	.recalc		= &omap3_dpll_recalc,
 };
 
+static struct clk dpll4_ck_3630 = {
+	.name		= "dpll4_ck",
+	.ops		= &clkops_noncore_dpll_ops,
+	.parent		= &sys_ck,
+	.dpll_data	= &dpll4_dd_3630,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_dpll4_set_rate,
+	.clkdm_name	= "dpll4_clkdm",
+	.recalc		= &omap3_dpll_recalc,
+};
+
 /*
  * This virtual clock provides the CLKOUTX2 output from the DPLL if the
  * DPLL isn't bypassed --
@@ -581,6 +655,11 @@ static const struct clksel div16_dpll4_clksel[] = {
 	{ .parent = NULL }
 };
 
+static const struct clksel div32_dpll4_clksel[] = {
+	{ .parent = &dpll4_ck, .rates = div32_dpll_rates },
+	{ .parent = NULL }
+};
+
 /* This virtual clock is the source for dpll4_m2x2_ck */
 static struct clk dpll4_m2_ck = {
 	.name		= "dpll4_m2_ck",
@@ -594,6 +673,18 @@ static struct clk dpll4_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk dpll4_m2_ck_3630 = {
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
@@ -666,6 +757,18 @@ static struct clk dpll4_m3_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk dpll4_m3_ck_3630 = {
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
@@ -754,6 +857,20 @@ static struct clk dpll4_m4_ck = {
 	.round_rate	= &omap2_clksel_round_rate,
 };
 
+static struct clk dpll4_m4_ck_3630 = {
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
@@ -779,6 +896,18 @@ static struct clk dpll4_m5_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk dpll4_m5_ck_3630 = {
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
@@ -804,6 +933,18 @@ static struct clk dpll4_m6_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk dpll4_m6_ck_3630 = {
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
@@ -3241,8 +3382,16 @@ int __init omap2_clk_init(void)
 			cpu_clkflg |= CK_3430ES2;
 		}
 	}
-	if (cpu_is_omap3630())
-		dpll4_ck.dpll_data->flags |= DPLL_J_TYPE;
+	if (cpu_is_omap3630()) {
+		cpu_mask |= RATE_IN_36XX;
+		cpu_clkflg |= CK_36XX;
+		dpll4_ck = dpll4_ck_3630;
+		dpll4_m2_ck = dpll4_m2_ck_3630;
+		dpll4_m3_ck = dpll4_m3_ck_3630;
+		dpll4_m4_ck = dpll4_m4_ck_3630;
+		dpll4_m5_ck = dpll4_m5_ck_3630;
+		dpll4_m6_ck = dpll4_m6_ck_3630;
+	}
 
 	clk_init(&omap2_clk_functions);
 
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 7347246..fe73cf0
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -980,6 +980,7 @@ static struct dpll_data dpll_usb_dd = {
 	.max_multiplier	= OMAP4430_MAX_DPLL_MULT,
 	.max_divider	= OMAP4430_MAX_DPLL_DIV,
 	.min_divider	= 1,
+	.flags	= DPLL_J_TYPE | DPLL_NO_DCO_SEL
 };
 
 
@@ -2736,7 +2737,6 @@ int __init omap2_clk_init(void)
 	if (cpu_is_omap44xx()) {
 		cpu_mask = RATE_IN_4430;
 		cpu_clkflg = CK_443X;
-		dpll_usb_ck.dpll_data->flags |= DPLL_NO_DCO_SEL | DPLL_J_TYPE;
 	}
 
 	clk_init(&omap2_clk_functions);
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6f2802b..2925a93
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -516,7 +516,8 @@
 
 /* CM_CLKSEL2_PLL */
 #define OMAP3430_PERIPH_DPLL_MULT_SHIFT			8
-#define OMAP3430_PERIPH_DPLL_MULT_MASK			(0xfff << 8)
+#define OMAP3430_PERIPH_DPLL_MULT_MASK			(0x7ff << 8)
+#define OMAP3630_PERIPH_DPLL_MULT_MASK			(0xfff << 8)
 #define OMAP3430_PERIPH_DPLL_DIV_SHIFT			0
 #define OMAP3430_PERIPH_DPLL_DIV_MASK			(0x7f << 0)
 #define OMAP3630_PERIPH_DPLL_DCO_SEL_SHIFT		21
@@ -527,6 +528,7 @@
 /* CM_CLKSEL3_PLL */
 #define OMAP3430_DIV_96M_SHIFT				0
 #define OMAP3430_DIV_96M_MASK				(0x1f << 0)
+#define OMAP3630_DIV_96M_MASK				(0x3f << 0)
 
 /* CM_CLKSEL4_PLL */
 #define OMAP3430ES2_PERIPH2_DPLL_MULT_SHIFT		8
@@ -573,8 +575,10 @@
 /* CM_CLKSEL_DSS */
 #define OMAP3430_CLKSEL_TV_SHIFT			8
 #define OMAP3430_CLKSEL_TV_MASK				(0x1f << 8)
+#define OMAP3630_CLKSEL_TV_MASK				(0x3f << 8)
 #define OMAP3430_CLKSEL_DSS1_SHIFT			0
 #define OMAP3430_CLKSEL_DSS1_MASK			(0x1f << 0)
+#define OMAP3630_CLKSEL_DSS1_MASK			(0x3f << 0)
 
 /* CM_SLEEPDEP_DSS specific bits */
 
@@ -602,7 +606,7 @@
 /* CM_CLKSEL_CAM */
 #define OMAP3430_CLKSEL_CAM_SHIFT			0
 #define OMAP3430_CLKSEL_CAM_MASK			(0x1f << 0)
-
+#define OMAP3630_CLKSEL_CAM_MASK			(0x3f << 0)
 /* CM_SLEEPDEP_CAM specific bits */
 
 /* CM_CLKSTCTRL_CAM */
@@ -697,6 +701,7 @@
 /* CM_CLKSEL1_EMU */
 #define OMAP3430_DIV_DPLL4_SHIFT			24
 #define OMAP3430_DIV_DPLL4_MASK				(0x1f << 24)
+#define OMAP3630_DIV_DPLL4_MASK				(0x3f << 24)
 #define OMAP3430_DIV_DPLL3_SHIFT			16
 #define OMAP3430_DIV_DPLL3_MASK				(0x1f << 16)
 #define OMAP3430_CLKSEL_TRACECLK_SHIFT			11
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 15d0d9a..e3f1eb3 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -162,6 +162,7 @@ extern const struct clkops clkops_null;
 #define RATE_IN_343X		(1 << 3)	/* rates common to all 343X */
 #define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates only */
 #define RATE_IN_4430            (1 << 5)
+#define RATE_IN_36XX		(1 << 6)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 
-- 
1.5.6.3

