From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 17/19] OMAP3 clock: introduce DPLL4 Jtype
Date: Mon, 15 Feb 2010 18:25:01 -0700
Message-ID: <20100216012500.1101.64927.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57446 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502Ab0BPB1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:27:00 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Vishwanath BS <Vishwanath.bs@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

=46rom: Richard Woodruff <r-woodruff2@ti.com>

DPLL4 for 3630 introduces a changed block called j type dpll, requiring
special divisor bits and additional reg fields. To allow for silicons t=
o
use this, this is introduced as a flag and is enabled for 3630 silicon.
OMAP4 also has j type dpll for usb.

Tested with 3630 ZOOM3 and OMAP3430 ZOOM2

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
[paul@pwsan.com: added some comments; updated copyrights and credits; f=
ixed
 some style issues]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.h             |    4 ++
 arch/arm/mach-omap2/clock34xx_data.c    |   32 ++++++++++++++-
 arch/arm/mach-omap2/clock44xx_data.c    |    1=20
 arch/arm/mach-omap2/cm-regbits-34xx.h   |    5 ++
 arch/arm/mach-omap2/dpll3xxx.c          |   67 +++++++++++++++++++++++=
++++++--
 arch/arm/plat-omap/include/plat/clock.h |    5 ++
 6 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index c500a5f..f7e7100 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -47,6 +47,10 @@
 #define DPLL_LOW_POWER_BYPASS	0x5
 #define DPLL_LOCKED		0x7
=20
+/* DPLL Type and DCO Selection Flags */
+#define DPLL_J_TYPE		0x1
+#define DPLL_NO_DCO_SEL		0x2
+
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2=
/clock34xx_data.c
index caa6a41..8be3eda 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -38,6 +38,7 @@
=20
 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT		2048
+#define OMAP3630_MAX_JTYPE_DPLL_MULT	4095
 #define OMAP3_MAX_DPLL_DIV		128
=20
 /*
@@ -529,7 +530,8 @@ static struct clk emu_core_alwon_ck =3D {
 /* DPLL4 */
 /* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trac=
e clk */
 /* Type: DPLL */
-static struct dpll_data dpll4_dd =3D {
+static struct dpll_data dpll4_dd;
+static struct dpll_data dpll4_dd_34xx __initdata =3D {
 	.mult_div1_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
 	.mult_mask	=3D OMAP3430_PERIPH_DPLL_MULT_MASK,
 	.div1_mask	=3D OMAP3430_PERIPH_DPLL_DIV_MASK,
@@ -552,6 +554,29 @@ static struct dpll_data dpll4_dd =3D {
 	.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
 };
=20
+static struct dpll_data dpll4_dd_3630 __initdata =3D {
+	.mult_div1_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
+	.mult_mask	=3D OMAP3630_PERIPH_DPLL_MULT_MASK,
+	.div1_mask	=3D OMAP3430_PERIPH_DPLL_DIV_MASK,
+	.clk_bypass	=3D &sys_ck,
+	.clk_ref	=3D &sys_ck,
+	.control_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_mask	=3D OMAP3430_EN_PERIPH_DPLL_MASK,
+	.modes		=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
+	.auto_recal_bit	=3D OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
+	.recal_en_bit	=3D OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
+	.recal_st_bit	=3D OMAP3430_PERIPH_DPLL_ST_SHIFT,
+	.autoidle_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+	.autoidle_mask	=3D OMAP3430_AUTO_PERIPH_DPLL_MASK,
+	.idlest_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.idlest_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
+	.max_multiplier =3D OMAP3630_MAX_JTYPE_DPLL_MULT,
+	.min_divider	=3D 1,
+	.max_divider	=3D OMAP3_MAX_DPLL_DIV,
+	.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE,
+	.flags		=3D DPLL_J_TYPE
+};
+
 static struct clk dpll4_ck =3D {
 	.name		=3D "dpll4_ck",
 	.ops		=3D &clkops_noncore_dpll_ops,
@@ -3377,6 +3402,11 @@ int __init omap3xxx_clk_init(void)
 				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
 	}
=20
+	if (cpu_is_omap3630())
+		dpll4_dd =3D dpll4_dd_3630;
+	else
+		dpll4_dd =3D dpll4_dd_34xx;
+
 	clk_init(&omap2_clk_functions);
=20
 	for (c =3D omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clk=
s); c++)
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2=
/clock44xx_data.c
index 35ffe63..3165f53 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -980,6 +980,7 @@ static struct dpll_data dpll_usb_dd =3D {
 	.max_multiplier	=3D OMAP4430_MAX_DPLL_MULT,
 	.max_divider	=3D OMAP4430_MAX_DPLL_DIV,
 	.min_divider	=3D 1,
+	.flags		=3D DPLL_J_TYPE | DPLL_NO_DCO_SEL
 };
=20
=20
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap=
2/cm-regbits-34xx.h
index c04c7c6..29cd13b 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -531,8 +531,13 @@
 /* CM_CLKSEL2_PLL */
 #define OMAP3430_PERIPH_DPLL_MULT_SHIFT			8
 #define OMAP3430_PERIPH_DPLL_MULT_MASK			(0x7ff << 8)
+#define OMAP3630_PERIPH_DPLL_MULT_MASK			(0xfff << 8)
 #define OMAP3430_PERIPH_DPLL_DIV_SHIFT			0
 #define OMAP3430_PERIPH_DPLL_DIV_MASK			(0x7f << 0)
+#define OMAP3630_PERIPH_DPLL_DCO_SEL_SHIFT		21
+#define OMAP3630_PERIPH_DPLL_DCO_SEL_MASK		(0x7 << 21)
+#define OMAP3630_PERIPH_DPLL_SD_DIV_SHIFT		24
+#define OMAP3630_PERIPH_DPLL_SD_DIV_MASK		(0xff << 24)
=20
 /* CM_CLKSEL3_PLL */
 #define OMAP3430_DIV_96M_SHIFT				0
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3=
xxx.c
index 84be81c..781f750 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -1,11 +1,14 @@
 /*
  * OMAP3/4 - specific DPLL control functions
  *
- * Copyright (C) 2009 Texas Instruments, Inc.
- * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2009-2010 Nokia Corporation
  *
  * Written by Paul Walmsley
- * Testing and integration fixes by Jouni H=C3=83=C2=B6gander
+ * Testing and integration fixes by Jouni H=C3=B6gander
+ *
+ * 36xx support added by Vishwanath BS, Richard Woodruff, and Nishanth
+ * Menon
  *
  * Parts of this code are based on code written by
  * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
@@ -225,6 +228,47 @@ static int _omap3_noncore_dpll_stop(struct clk *cl=
k)
 	return 0;
 }
=20
+/**
+ * lookup_dco_sddiv -  Set j-type DPLL4 compensation variables
+ * @clk: pointer to a DPLL struct clk
+ * @dco: digital control oscillator selector
+ * @sd_div: target sigma-delta divider
+ * @m: DPLL multiplier to set
+ * @n: DPLL divider to set
+ *
+ * See 36xx TRM section 3.5.3.3.3.2 "Type B DPLL (Low-Jitter)"
+ *
+ * XXX This code is not needed for 3430/AM35xx; can it be optimized
+ * out in non-multi-OMAP builds for those chips?
+ */
+static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16=
 m,
+			     u8 n)
+{
+	unsigned long fint, clkinp, sd; /* watch out for overflow */
+	int mod1, mod2;
+
+	clkinp =3D clk->parent->rate;
+	fint =3D (clkinp / n) * m;
+
+	if (fint < 1000000000)
+		*dco =3D 2;
+	else
+		*dco =3D 4;
+	/*
+	 * target sigma-delta to near 250MHz
+	 * sd =3D ceil[(m/(n+1)) * (clkinp_MHz / 250)]
+	 */
+	clkinp /=3D 100000; /* shift from MHz to 10*Hz for 38.4 and 19.2 */
+	mod1 =3D (clkinp * m) % (250 * n);
+	sd =3D (clkinp * m) / (250 * n);
+	mod2 =3D sd % 10;
+	sd /=3D 10;
+
+	if (mod1 || mod2)
+		sd++;
+	*sd_div =3D sd;
+}
+
 /*
  * _omap3_noncore_dpll_program - set non-core DPLL M,N values directly
  * @clk: struct clk * of DPLL to set
@@ -259,6 +303,21 @@ static int omap3_noncore_dpll_program(struct clk *=
clk, u16 m, u8 n, u16 freqsel)
 	v &=3D ~(dd->mult_mask | dd->div1_mask);
 	v |=3D m << __ffs(dd->mult_mask);
 	v |=3D (n - 1) << __ffs(dd->div1_mask);
+
+	/*
+	 * XXX This code is not needed for 3430/AM35XX; can it be optimized
+	 * out in non-multi-OMAP builds for those chips?
+	 */
+	if ((dd->flags & DPLL_J_TYPE) && !(dd->flags & DPLL_NO_DCO_SEL)) {
+		u8 dco, sd_div;
+		lookup_dco_sddiv(clk, &dco, &sd_div, m, n);
+		/* XXX This probably will need revision for OMAP4 */
+		v &=3D ~(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK
+			| OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
+		v |=3D dco << __ffs(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK);
+		v |=3D sd_div << __ffs(OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
+	}
+
 	__raw_writel(v, dd->mult_div1_reg);
=20
 	/* We let the clock framework set the other output dividers later */
@@ -536,7 +595,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk=
)
=20
 	v =3D __raw_readl(dd->control_reg) & dd->enable_mask;
 	v >>=3D __ffs(dd->enable_mask);
-	if (v !=3D OMAP3XXX_EN_DPLL_LOCKED)
+	if ((v !=3D OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
 		rate =3D clk->parent->rate;
 	else
 		rate =3D clk->parent->rate * 2;
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-om=
ap/include/plat/clock.h
index 9042dab..66ebb08 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -42,6 +42,10 @@ struct clksel {
 	const struct clksel_rate *rates;
 };
=20
+/*
+ * A new flag called flag has been added which indicates what is the
+ * type of dpll (like j_type, no_dco_sel)
+ */
 struct dpll_data {
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
@@ -68,6 +72,7 @@ struct dpll_data {
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
+	u8			flags;
 #  endif
 };
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
