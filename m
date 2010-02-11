From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV6 1/3] OMAP3: introduce DPLL4 Jtype
Date: Wed, 10 Feb 2010 23:45:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002102343260.28188@utopia.booyaka.com>
References: <1265789514-4329-1-git-send-email-vishwanath.bs@ti.com> <1265789514-4329-2-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1075150849-1265870708=:28188"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49803 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab0BKGpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 01:45:09 -0500
In-Reply-To: <1265789514-4329-2-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>, Nishanth Menon <nm@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1075150849-1265870708=:28188
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 10 Feb 2010, Vishwanath BS wrote:

> From: Richard Woodruff <r-woodruff2@ti.com>
>=20
> DPLL4 for 3630 introduces a changed block called j type dpll, requiring
> special divisor bits and additional reg fields. To allow for silicons to
> use this, this is introduced as a flag and is enabled for 3630 silicon.
> OMAP4 also has j type dpll for usb.
>=20
> Tested with 3630 ZOOM3 and OMAP3430 ZOOM2
>=20
> Cc: Paul Walmsley <paul@pwsan.com>
>=20
> Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>

I made a few changes to this patch (revised version below) and ququed it=20
up for 2.6.34.  Please let me know if you have any comments on the revised=
=20
patch.


thanks,

- Paul

From=208069cd708068fa48eaf065c576455537ca4a740d Mon Sep 17 00:00:00 2001
From: Richard Woodruff <r-woodruff2@ti.com>
Date: Wed, 10 Feb 2010 17:24:31 -0700
Subject: [PATCH] DPLL4 for 3630 introduces a changed block called j type dp=
ll, requiring
 special divisor bits and additional reg fields. To allow for silicons to
 use this, this is introduced as a flag and is enabled for 3630 silicon.
 OMAP4 also has j type dpll for usb.

Tested with 3630 ZOOM3 and OMAP3430 ZOOM2

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
[paul@pwsan.com: added some comments; updated copyrights and credits; fixed
 some style issues]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.h             |    4 ++
 arch/arm/mach-omap2/clock34xx_data.c    |   32 ++++++++++++++-
 arch/arm/mach-omap2/clock44xx_data.c    |    1 +
 arch/arm/mach-omap2/cm-regbits-34xx.h   |    5 ++
 arch/arm/mach-omap2/dpll3xxx.c          |   67 +++++++++++++++++++++++++++=
++--
 arch/arm/plat-omap/include/plat/clock.h |    5 ++
 6 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index c500a5f..f7e7100 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -47,6 +47,10 @@
 #define DPLL_LOW_POWER_BYPASS=090x5
 #define DPLL_LOCKED=09=090x7
=20
+/* DPLL Type and DCO Selection Flags */
+#define DPLL_J_TYPE=09=090x1
+#define DPLL_NO_DCO_SEL=09=090x2
+
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clo=
ck34xx_data.c
index caa6a41..8be3eda 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -38,6 +38,7 @@
=20
 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT=09=092048
+#define OMAP3630_MAX_JTYPE_DPLL_MULT=094095
 #define OMAP3_MAX_DPLL_DIV=09=09128
=20
 /*
@@ -529,7 +530,8 @@ static struct clk emu_core_alwon_ck =3D {
 /* DPLL4 */
 /* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace cl=
k */
 /* Type: DPLL */
-static struct dpll_data dpll4_dd =3D {
+static struct dpll_data dpll4_dd;
+static struct dpll_data dpll4_dd_34xx __initdata =3D {
 =09.mult_div1_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
 =09.mult_mask=09=3D OMAP3430_PERIPH_DPLL_MULT_MASK,
 =09.div1_mask=09=3D OMAP3430_PERIPH_DPLL_DIV_MASK,
@@ -552,6 +554,29 @@ static struct dpll_data dpll4_dd =3D {
 =09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
 };
=20
+static struct dpll_data dpll4_dd_3630 __initdata =3D {
+=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
+=09.mult_mask=09=3D OMAP3630_PERIPH_DPLL_MULT_MASK,
+=09.div1_mask=09=3D OMAP3430_PERIPH_DPLL_DIV_MASK,
+=09.clk_bypass=09=3D &sys_ck,
+=09.clk_ref=09=3D &sys_ck,
+=09.control_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+=09.enable_mask=09=3D OMAP3430_EN_PERIPH_DPLL_MASK,
+=09.modes=09=09=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
+=09.auto_recal_bit=09=3D OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
+=09.recal_en_bit=09=3D OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
+=09.recal_st_bit=09=3D OMAP3430_PERIPH_DPLL_ST_SHIFT,
+=09.autoidle_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+=09.autoidle_mask=09=3D OMAP3430_AUTO_PERIPH_DPLL_MASK,
+=09.idlest_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+=09.idlest_mask=09=3D OMAP3430_ST_PERIPH_CLK_MASK,
+=09.max_multiplier =3D OMAP3630_MAX_JTYPE_DPLL_MULT,
+=09.min_divider=09=3D 1,
+=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
+=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE,
+=09.flags=09=09=3D DPLL_J_TYPE
+};
+
 static struct clk dpll4_ck =3D {
 =09.name=09=09=3D "dpll4_ck",
 =09.ops=09=09=3D &clkops_noncore_dpll_ops,
@@ -3377,6 +3402,11 @@ int __init omap3xxx_clk_init(void)
 =09=09=09=09&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
 =09}
=20
+=09if (cpu_is_omap3630())
+=09=09dpll4_dd =3D dpll4_dd_3630;
+=09else
+=09=09dpll4_dd =3D dpll4_dd_34xx;
+
 =09clk_init(&omap2_clk_functions);
=20
 =09for (c =3D omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks)=
; c++)
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clo=
ck44xx_data.c
index 35ffe63..3165f53 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -980,6 +980,7 @@ static struct dpll_data dpll_usb_dd =3D {
 =09.max_multiplier=09=3D OMAP4430_MAX_DPLL_MULT,
 =09.max_divider=09=3D OMAP4430_MAX_DPLL_DIV,
 =09.min_divider=09=3D 1,
+=09.flags=09=09=3D DPLL_J_TYPE | DPLL_NO_DCO_SEL
 };
=20
=20
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm=
-regbits-34xx.h
index c04c7c6..29cd13b 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -531,8 +531,13 @@
 /* CM_CLKSEL2_PLL */
 #define OMAP3430_PERIPH_DPLL_MULT_SHIFT=09=09=098
 #define OMAP3430_PERIPH_DPLL_MULT_MASK=09=09=09(0x7ff << 8)
+#define OMAP3630_PERIPH_DPLL_MULT_MASK=09=09=09(0xfff << 8)
 #define OMAP3430_PERIPH_DPLL_DIV_SHIFT=09=09=090
 #define OMAP3430_PERIPH_DPLL_DIV_MASK=09=09=09(0x7f << 0)
+#define OMAP3630_PERIPH_DPLL_DCO_SEL_SHIFT=09=0921
+#define OMAP3630_PERIPH_DPLL_DCO_SEL_MASK=09=09(0x7 << 21)
+#define OMAP3630_PERIPH_DPLL_SD_DIV_SHIFT=09=0924
+#define OMAP3630_PERIPH_DPLL_SD_DIV_MASK=09=09(0xff << 24)
=20
 /* CM_CLKSEL3_PLL */
 #define OMAP3430_DIV_96M_SHIFT=09=09=09=090
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.=
c
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
- * Testing and integration fixes by Jouni H=C3=B6gander
+ * Testing and integration fixes by Jouni H=F6gander
+ *
+ * 36xx support added by Vishwanath BS, Richard Woodruff, and Nishanth
+ * Menon
  *
  * Parts of this code are based on code written by
  * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
@@ -225,6 +228,47 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 =09return 0;
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
+static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
+=09=09=09     u8 n)
+{
+=09unsigned long fint, clkinp, sd; /* watch out for overflow */
+=09int mod1, mod2;
+
+=09clkinp =3D clk->parent->rate;
+=09fint =3D (clkinp / n) * m;
+
+=09if (fint < 1000000000)
+=09=09*dco =3D 2;
+=09else
+=09=09*dco =3D 4;
+=09/*
+=09 * target sigma-delta to near 250MHz
+=09 * sd =3D ceil[(m/(n+1)) * (clkinp_MHz / 250)]
+=09 */
+=09clkinp /=3D 100000; /* shift from MHz to 10*Hz for 38.4 and 19.2 */
+=09mod1 =3D (clkinp * m) % (250 * n);
+=09sd =3D (clkinp * m) / (250 * n);
+=09mod2 =3D sd % 10;
+=09sd /=3D 10;
+
+=09if (mod1 || mod2)
+=09=09sd++;
+=09*sd_div =3D sd;
+}
+
 /*
  * _omap3_noncore_dpll_program - set non-core DPLL M,N values directly
  * @clk: struct clk * of DPLL to set
@@ -259,6 +303,21 @@ static int omap3_noncore_dpll_program(struct clk *clk,=
 u16 m, u8 n, u16 freqsel)
 =09v &=3D ~(dd->mult_mask | dd->div1_mask);
 =09v |=3D m << __ffs(dd->mult_mask);
 =09v |=3D (n - 1) << __ffs(dd->div1_mask);
+
+=09/*
+=09 * XXX This code is not needed for 3430/AM35XX; can it be optimized
+=09 * out in non-multi-OMAP builds for those chips?
+=09 */
+=09if ((dd->flags & DPLL_J_TYPE) && !(dd->flags & DPLL_NO_DCO_SEL)) {
+=09=09u8 dco, sd_div;
+=09=09lookup_dco_sddiv(clk, &dco, &sd_div, m, n);
+=09=09/* XXX This probably will need revision for OMAP4 */
+=09=09v &=3D ~(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK
+=09=09=09| OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
+=09=09v |=3D dco << __ffs(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK);
+=09=09v |=3D sd_div << __ffs(OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
+=09}
+
 =09__raw_writel(v, dd->mult_div1_reg);
=20
 =09/* We let the clock framework set the other output dividers later */
@@ -536,7 +595,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
=20
 =09v =3D __raw_readl(dd->control_reg) & dd->enable_mask;
 =09v >>=3D __ffs(dd->enable_mask);
-=09if (v !=3D OMAP3XXX_EN_DPLL_LOCKED)
+=09if ((v !=3D OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
 =09=09rate =3D clk->parent->rate;
 =09else
 =09=09rate =3D clk->parent->rate * 2;
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/i=
nclude/plat/clock.h
index 9042dab..66ebb08 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -42,6 +42,10 @@ struct clksel {
 =09const struct clksel_rate *rates;
 };
=20
+/*
+ * A new flag called flag has been added which indicates what is the
+ * type of dpll (like j_type, no_dco_sel)
+ */
 struct dpll_data {
 =09void __iomem=09=09*mult_div1_reg;
 =09u32=09=09=09mult_mask;
@@ -68,6 +72,7 @@ struct dpll_data {
 =09u8=09=09=09auto_recal_bit;
 =09u8=09=09=09recal_en_bit;
 =09u8=09=09=09recal_st_bit;
+=09u8=09=09=09flags;
 #  endif
 };
=20
--=20
1.6.6.GIT

--155748971-1075150849-1265870708=:28188--
