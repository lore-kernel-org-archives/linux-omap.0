From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV3 3/4] OMAP3: Correct width for CLKSEL Fields
Date: Thu, 26 Nov 2009 10:28:36 +0530
Message-ID: <1259211517-12713-4-git-send-email-vishwanath.bs@ti.com>
References: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com>
 <1259211517-12713-2-git-send-email-vishwanath.bs@ti.com>
 <1259211517-12713-3-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57449 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331AbZKZE5X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Nov 2009 23:57:23 -0500
In-Reply-To: <1259211517-12713-3-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>

DPLL4 M, M3, M4, M5 and M6 field width has been increased by 1 bit in
3630.This patch has changes to accommodate this in CM dynamically based
on chip version. Primary changes are
1. Added clksel_mask_3630 to take care clksel width changes
2. CLock nodes which are newly added for 3630 are marked under CK_363X
3. Clock nodes which have changes for 3630 are marked as CK_3XXX | CK_363X
4. Clock nodes which are unchanged for 3630 are retained as CK_3XXX
5. 3630 specific Clock rates are marked as RATE_IN_363X

Cc: Paul Walmsley <paul@pwsan.com>

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 167f075..c304da5
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -43,6 +43,7 @@
 #include "prm-regbits-34xx.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
+#include <plat/cpu.h>
 
 static const struct clkops clkops_noncore_dpll_ops;
 
@@ -97,6 +98,7 @@ struct omap_clk {
 #define CK_3XXX		(1 << 0)
 #define CK_3430ES1	(1 << 1)
 #define CK_3430ES2	(1 << 2)
+#define CK_363X		(1 << 3)
 
 static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_3XXX),
@@ -134,13 +136,13 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck,	CK_3XXX),
 	CLK(NULL,	"dpll4_m2_ck",	&dpll4_m2_ck,	CK_3XXX),
 	CLK(NULL,	"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_3XXX),
-	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_3XXX),
+	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_3XXX | CK_363X),
 	CLK(NULL,	"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_3XXX),
-	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_3XXX),
+	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_3XXX | CK_363X),
 	CLK(NULL,	"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_3XXX),
-	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_3XXX),
+	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_3XXX | CK_363X),
 	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_3XXX),
-	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_3XXX),
+	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_3XXX | CK_363X),
 	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_3XXX),
 	CLK(NULL,	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_3XXX),
 	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2),
@@ -1222,7 +1224,11 @@ int __init omap2_clk_init(void)
 				OMAP3630_PERIPH_DPLL_DCO_SEL_MASK;
 			dpll4_ck.dpll_data->sd_div_mask =
 				OMAP3630_PERIPH_DPLL_SD_DIV_MASK;
+			dpll4_dd.mult_mask = OMAP3630_PERIPH_DPLL_MULT_MASK;
+			cpu_mask |= RATE_IN_363X;
 			}
+		if (cpu_is_omap3630())
+			cpu_clkflg |= CK_363X;
 	}
 
 	clk_init(&omap2_clk_functions);
@@ -1232,6 +1238,12 @@ int __init omap2_clk_init(void)
 
 	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
 		if (c->cpu & cpu_clkflg) {
+			/* for 3630, change the mask value for clocks which are
+				marked as CK_363X*/
+			if (cpu_is_omap3630() && (c->cpu & CK_363X)) {
+				c->lk.clk->clksel_mask =
+						c->lk.clk->clksel_mask_3630;
+			}
 			clkdev_add(&c->lk);
 			clk_register(c->lk.clk);
 			omap2_init_clk_clkdm(c->lk.clk);
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 813a83e..93c92e5 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -243,6 +243,42 @@ static const struct clksel_rate div16_dpll_rates[] = {
 	{ .div = 0 }
 };
 
+static const struct clksel_rate div32_dpll_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
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
+	{ .div = 17, .val = 17, .flags = RATE_IN_363X },
+	{ .div = 18, .val = 18, .flags = RATE_IN_363X },
+	{ .div = 19, .val = 19, .flags = RATE_IN_363X },
+	{ .div = 20, .val = 20, .flags = RATE_IN_363X },
+	{ .div = 21, .val = 21, .flags = RATE_IN_363X },
+	{ .div = 22, .val = 22, .flags = RATE_IN_363X },
+	{ .div = 23, .val = 23, .flags = RATE_IN_363X },
+	{ .div = 24, .val = 24, .flags = RATE_IN_363X },
+	{ .div = 25, .val = 25, .flags = RATE_IN_363X },
+	{ .div = 26, .val = 26, .flags = RATE_IN_363X },
+	{ .div = 27, .val = 27, .flags = RATE_IN_363X },
+	{ .div = 28, .val = 28, .flags = RATE_IN_363X },
+	{ .div = 29, .val = 29, .flags = RATE_IN_363X },
+	{ .div = 30, .val = 30, .flags = RATE_IN_363X },
+	{ .div = 31, .val = 31, .flags = RATE_IN_363X },
+	{ .div = 32, .val = 32, .flags = RATE_IN_363X },
+	{ .div = 0 }
+};
+
 /* DPLL1 */
 /* MPU clock source */
 /* Type: DPLL */
@@ -588,6 +624,11 @@ static const struct clksel div16_dpll4_clksel[] = {
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
@@ -668,7 +709,8 @@ static struct clk dpll4_m3_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
-	.clksel		= div16_dpll4_clksel,
+	.clksel_mask_3630 = OMAP3630_CLKSEL_TV_MASK,
+	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -754,7 +796,8 @@ static struct clk dpll4_m4_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
-	.clksel		= div16_dpll4_clksel,
+	.clksel_mask_3630 = OMAP3630_CLKSEL_DSS1_MASK,
+	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -781,7 +824,8 @@ static struct clk dpll4_m5_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
-	.clksel		= div16_dpll4_clksel,
+	.clksel_mask_3630 = OMAP3630_CLKSEL_CAM_MASK,
+	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -806,7 +850,8 @@ static struct clk dpll4_m6_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
-	.clksel		= div16_dpll4_clksel,
+	.clksel_mask_3630 = OMAP3630_DIV_DPLL4_MASK,
+	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6f2802b..a6383f9 100644
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
@@ -573,8 +574,10 @@
 /* CM_CLKSEL_DSS */
 #define OMAP3430_CLKSEL_TV_SHIFT			8
 #define OMAP3430_CLKSEL_TV_MASK				(0x1f << 8)
+#define OMAP3630_CLKSEL_TV_MASK				(0x3f << 8)
 #define OMAP3430_CLKSEL_DSS1_SHIFT			0
 #define OMAP3430_CLKSEL_DSS1_MASK			(0x1f << 0)
+#define OMAP3630_CLKSEL_DSS1_MASK			(0x3f << 0)
 
 /* CM_SLEEPDEP_DSS specific bits */
 
@@ -602,6 +605,7 @@
 /* CM_CLKSEL_CAM */
 #define OMAP3430_CLKSEL_CAM_SHIFT			0
 #define OMAP3430_CLKSEL_CAM_MASK			(0x1f << 0)
+#define OMAP3630_CLKSEL_CAM_MASK			(0x3f << 0)
 
 /* CM_SLEEPDEP_CAM specific bits */
 
@@ -697,6 +701,7 @@
 /* CM_CLKSEL1_EMU */
 #define OMAP3430_DIV_DPLL4_SHIFT			24
 #define OMAP3430_DIV_DPLL4_MASK				(0x1f << 24)
+#define OMAP3630_DIV_DPLL4_MASK				(0x3f << 24)
 #define OMAP3430_DIV_DPLL3_SHIFT			16
 #define OMAP3430_DIV_DPLL3_MASK				(0x1f << 16)
 #define OMAP3430_CLKSEL_TRACECLK_SHIFT			11
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 359ccb4..0e0a5cc 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -93,7 +93,7 @@ struct clk {
 		defined(CONFIG_ARCH_OMAP4)
 	u8			fixed_div;
 	void __iomem		*clksel_reg;
-	u32			clksel_mask;
+	u32			clksel_mask, clksel_mask_3630;
 	const struct clksel	*clksel;
 	struct dpll_data	*dpll_data;
 	const char		*clkdm_name;
@@ -159,7 +159,7 @@ extern const struct clkops clkops_null;
 #define RATE_IN_243X		(1 << 2)
 #define RATE_IN_3XXX		(1 << 3)	/* rates common to all 343X */
 #define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates only */
-
+#define RATE_IN_363X		(1 << 5)        /* rates common to all 363X */
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 
 
