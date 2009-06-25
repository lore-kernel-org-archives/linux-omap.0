From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 3/3] OMAP3 clock: correct module IDLEST bits: SSI; DSS; USBHOST;
	HSOTGUSB
Date: Thu, 25 Jun 2009 17:38:58 -0600
Message-ID: <20090625233832.19686.8316.stgit@localhost.localdomain>
References: <20090625233647.19686.87614.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45700 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbZFYXlt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 19:41:49 -0400
In-Reply-To: <20090625233647.19686.87614.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>

=46ix two bugs in the OMAP3 clock tree pertaining to the SSI, DSS,
USBHOST, and HSOTGUSB devices.  These devices are both interconnect
initiators and targets.  Without this patch, clk_enable()s on clocks fo=
r
these modules can be very high latency (potentially up to ~200
milliseconds) and message such as the following are generated:

    Clock usbhost_48m_fck didn't enable in 100000 tries

Two bugs are fixed by this patch.  First, OMAP hardware only supports
target CM_IDLEST register bits on ES2+ chips and beyond.  ES1 chips
should not wait for these clocks to enable.  So, split the appropriate
clocks into ES1 and ES2+ variants, so that kernels running on ES1
devices won't try to wait.

Second, the current heuristic in omap2_clk_dflt_find_idlest() will
fail for these clocks.  It assumes that the CM_IDLEST bit to wait upon
is the same as the CM_*CLKEN bit, which is false[1].  Fix by
implementing custom clkops .find_idlest function pointers for the
appropriate clocks that return the correct slave IDLEST bit shift.

This was originally fixed in the linux-omap kernel during 2.6.29 in a
slightly different manner[2][3].

In the medium-term future, all of the module IDLEST code will
eventually be moved to the omap_hwmod code.

Problem reported by Jarkko Nikula <jhnikula@gmail.com>:

    http://marc.info/?l=3Dlinux-omap&m=3D124306184903679&w=3D2

=2E..

1. See for example 34xx TRM Revision P Table 4-213 and 4-217 (for the
   DSS case).

2. http://www.spinics.net/lists/linux-omap/msg05512.html et seq.

3. http://lkml.indiana.edu/hypermail/linux/kernel/0901.3/01498.html


Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/clock34xx.c |  118 +++++++++++++++++++++++++++++++=
++++++--
 arch/arm/mach-omap2/clock34xx.h |   85 ++++++++++++++++++++++++----
 2 files changed, 185 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/cloc=
k34xx.c
index 045da92..97907c6 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -2,7 +2,7 @@
  * OMAP3-specific clock framework functions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  * Testing and integration fixes by Jouni H=C3=B6gander
@@ -41,6 +41,37 @@
=20
 static const struct clkops clkops_noncore_dpll_ops;
=20
+static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
+					    void __iomem **idlest_reg,
+					    u8 *idlest_bit);
+static void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
+					    void __iomem **idlest_reg,
+					    u8 *idlest_bit);
+static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
+						    void __iomem **idlest_reg,
+						    u8 *idlest_bit);
+
+static const struct clkops clkops_omap3430es2_ssi_wait =3D {
+	.enable		=3D omap2_dflt_clk_enable,
+	.disable	=3D omap2_dflt_clk_disable,
+	.find_idlest	=3D omap3430es2_clk_ssi_find_idlest,
+	.find_companion =3D omap2_clk_dflt_find_companion,
+};
+
+static const struct clkops clkops_omap3430es2_hsotgusb_wait =3D {
+	.enable		=3D omap2_dflt_clk_enable,
+	.disable	=3D omap2_dflt_clk_disable,
+	.find_idlest	=3D omap3430es2_clk_hsotgusb_find_idlest,
+	.find_companion =3D omap2_clk_dflt_find_companion,
+};
+
+static const struct clkops clkops_omap3430es2_dss_usbhost_wait =3D {
+	.enable		=3D omap2_dflt_clk_enable,
+	.disable	=3D omap2_dflt_clk_disable,
+	.find_idlest	=3D omap3430es2_clk_dss_usbhost_find_idlest,
+	.find_companion =3D omap2_clk_dflt_find_companion,
+};
+
 #include "clock34xx.h"
=20
 struct omap_clk {
@@ -157,10 +188,13 @@ static struct omap_clk omap34xx_clks[] =3D {
 	CLK(NULL,	"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
 	CLK(NULL,	"core_12m_fck",	&core_12m_fck,	CK_343X),
 	CLK("omap_hdq.0", "fck",	&hdq_fck,	CK_343X),
-	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck,	CK_343X),
-	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck,	CK_343X),
+	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es1,	CK_3430ES1),
+	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es2,	CK_3430ES2),
+	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es1,	CK_3430ES1),
+	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es2,	CK_3430ES2),
 	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_343X),
-	CLK("musb_hdrc",	"ick",	&hsotgusb_ick,	CK_343X),
+	CLK("musb_hdrc",	"ick",	&hsotgusb_ick_3430es1,	CK_3430ES1),
+	CLK("musb_hdrc",	"ick",	&hsotgusb_ick_3430es2,	CK_3430ES2),
 	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_343X),
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_343X),
 	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_343X),
@@ -193,18 +227,21 @@ static struct omap_clk omap34xx_clks[] =3D {
 	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_343X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_343X),
 	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_343X),
-	CLK(NULL,	"ssi_ick",	&ssi_ick,	CK_343X),
+	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es1,	CK_3430ES1),
+	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es2,	CK_3430ES2),
 	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_3430ES1),
 	CLK(NULL,	"security_l4_ick2", &security_l4_ick2, CK_343X),
 	CLK(NULL,	"aes1_ick",	&aes1_ick,	CK_343X),
 	CLK("omap_rng",	"ick",		&rng_ick,	CK_343X),
 	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
 	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
-	CLK("omapfb",	"dss1_fck",	&dss1_alwon_fck, CK_343X),
+	CLK("omapfb",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
+	CLK("omapfb",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2),
 	CLK("omapfb",	"tv_fck",	&dss_tv_fck,	CK_343X),
 	CLK("omapfb",	"video_fck",	&dss_96m_fck,	CK_343X),
 	CLK("omapfb",	"dss2_fck",	&dss2_alwon_fck, CK_343X),
-	CLK("omapfb",	"ick",		&dss_ick,	CK_343X),
+	CLK("omapfb",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
+	CLK("omapfb",	"ick",		&dss_ick_3430es2,	CK_3430ES2),
 	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
 	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
 	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
@@ -301,6 +338,73 @@ static struct omap_clk omap34xx_clks[] =3D {
 #define SDRC_MPURATE_LOOPS		96
=20
 /**
+ * omap3430es2_clk_ssi_find_idlest - return CM_IDLEST info for SSI
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ *
+ * The OMAP3430ES2 SSI target CM_IDLEST bit is at a different shift
+ * from the CM_{I,F}CLKEN bit.  Pass back the correct info via
+ * @idlest_reg and @idlest_bit.  No return value.
+ */
+static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
+					    void __iomem **idlest_reg,
+					    u8 *idlest_bit)
+{
+	u32 r;
+
+	r =3D (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+	*idlest_reg =3D (__force void __iomem *)r;
+	*idlest_bit =3D OMAP3430ES2_ST_SSI_IDLE_SHIFT;
+}
+
+/**
+ * omap3430es2_clk_dss_usbhost_find_idlest - CM_IDLEST info for DSS, U=
SBHOST
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ *
+ * Some OMAP modules on OMAP3 ES2+ chips have both initiator and
+ * target IDLEST bits.  For our purposes, we are concerned with the
+ * target IDLEST bits, which exist at a different bit position than
+ * the *CLKEN bit position for these modules (DSS and USBHOST) (The
+ * default find_idlest code assumes that they are at the same
+ * position.)  No return value.
+ */
+static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
+						    void __iomem **idlest_reg,
+						    u8 *idlest_bit)
+{
+	u32 r;
+
+	r =3D (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+	*idlest_reg =3D (__force void __iomem *)r;
+	/* USBHOST_IDLE has same shift */
+	*idlest_bit =3D OMAP3430ES2_ST_DSS_IDLE_SHIFT;
+}
+
+/**
+ * omap3430es2_clk_hsotgusb_find_idlest - return CM_IDLEST info for HS=
OTGUSB
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ *
+ * The OMAP3430ES2 HSOTGUSB target CM_IDLEST bit is at a different
+ * shift from the CM_{I,F}CLKEN bit.  Pass back the correct info via
+ * @idlest_reg and @idlest_bit.  No return value.
+ */
+static void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
+						 void __iomem **idlest_reg,
+						 u8 *idlest_bit)
+{
+	u32 r;
+
+	r =3D (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+	*idlest_reg =3D (__force void __iomem *)r;
+	*idlest_bit =3D OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT;
+}
+
+/**
  * omap3_dpll_recalc - recalculate DPLL rate
  * @clk: DPLL struct clk
  *
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cloc=
k34xx.h
index e433aec..57cc272 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1568,7 +1568,7 @@ static const struct clksel ssi_ssr_clksel[] =3D {
 	{ .parent =3D NULL }
 };
=20
-static struct clk ssi_ssr_fck =3D {
+static struct clk ssi_ssr_fck_3430es1 =3D {
 	.name		=3D "ssi_ssr_fck",
 	.ops		=3D &clkops_omap2_dflt,
 	.init		=3D &omap2_init_clksel_parent,
@@ -1581,10 +1581,31 @@ static struct clk ssi_ssr_fck =3D {
 	.recalc		=3D &omap2_clksel_recalc,
 };
=20
-static struct clk ssi_sst_fck =3D {
+static struct clk ssi_ssr_fck_3430es2 =3D {
+	.name		=3D "ssi_ssr_fck",
+	.ops		=3D &clkops_omap3430es2_ssi_wait,
+	.init		=3D &omap2_init_clksel_parent,
+	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	=3D OMAP3430_EN_SSI_SHIFT,
+	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+	.clksel_mask	=3D OMAP3430_CLKSEL_SSI_MASK,
+	.clksel		=3D ssi_ssr_clksel,
+	.clkdm_name	=3D "core_l4_clkdm",
+	.recalc		=3D &omap2_clksel_recalc,
+};
+
+static struct clk ssi_sst_fck_3430es1 =3D {
 	.name		=3D "ssi_sst_fck",
 	.ops		=3D &clkops_null,
-	.parent		=3D &ssi_ssr_fck,
+	.parent		=3D &ssi_ssr_fck_3430es1,
+	.fixed_div	=3D 2,
+	.recalc		=3D &omap2_fixed_divisor_recalc,
+};
+
+static struct clk ssi_sst_fck_3430es2 =3D {
+	.name		=3D "ssi_sst_fck",
+	.ops		=3D &clkops_null,
+	.parent		=3D &ssi_ssr_fck_3430es2,
 	.fixed_div	=3D 2,
 	.recalc		=3D &omap2_fixed_divisor_recalc,
 };
@@ -1606,9 +1627,19 @@ static struct clk core_l3_ick =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
-static struct clk hsotgusb_ick =3D {
+static struct clk hsotgusb_ick_3430es1 =3D {
 	.name		=3D "hsotgusb_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_dflt,
+	.parent		=3D &core_l3_ick,
+	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	=3D OMAP3430_EN_HSOTGUSB_SHIFT,
+	.clkdm_name	=3D "core_l3_clkdm",
+	.recalc		=3D &followparent_recalc,
+};
+
+static struct clk hsotgusb_ick_3430es2 =3D {
+	.name		=3D "hsotgusb_ick",
+	.ops		=3D &clkops_omap3430es2_hsotgusb_wait,
 	.parent		=3D &core_l3_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_HSOTGUSB_SHIFT,
@@ -1947,7 +1978,7 @@ static struct clk ssi_l4_ick =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
-static struct clk ssi_ick =3D {
+static struct clk ssi_ick_3430es1 =3D {
 	.name		=3D "ssi_ick",
 	.ops		=3D &clkops_omap2_dflt,
 	.parent		=3D &ssi_l4_ick,
@@ -1957,6 +1988,16 @@ static struct clk ssi_ick =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
+static struct clk ssi_ick_3430es2 =3D {
+	.name		=3D "ssi_ick",
+	.ops		=3D &clkops_omap3430es2_ssi_wait,
+	.parent		=3D &ssi_l4_ick,
+	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	=3D OMAP3430_EN_SSI_SHIFT,
+	.clkdm_name	=3D "core_l4_clkdm",
+	.recalc		=3D &followparent_recalc,
+};
+
 /* REVISIT: Technically the TRM claims that this is CORE_CLK based,
  * but l4_ick makes more sense to me */
=20
@@ -2024,7 +2065,7 @@ static struct clk des1_ick =3D {
 };
=20
 /* DSS */
-static struct clk dss1_alwon_fck =3D {
+static struct clk dss1_alwon_fck_3430es1 =3D {
 	.name		=3D "dss1_alwon_fck",
 	.ops		=3D &clkops_omap2_dflt,
 	.parent		=3D &dpll4_m4x2_ck,
@@ -2034,6 +2075,16 @@ static struct clk dss1_alwon_fck =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
+static struct clk dss1_alwon_fck_3430es2 =3D {
+	.name		=3D "dss1_alwon_fck",
+	.ops		=3D &clkops_omap3430es2_dss_usbhost_wait,
+	.parent		=3D &dpll4_m4x2_ck,
+	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
+	.enable_bit	=3D OMAP3430_EN_DSS1_SHIFT,
+	.clkdm_name	=3D "dss_clkdm",
+	.recalc		=3D &followparent_recalc,
+};
+
 static struct clk dss_tv_fck =3D {
 	.name		=3D "dss_tv_fck",
 	.ops		=3D &clkops_omap2_dflt,
@@ -2067,7 +2118,7 @@ static struct clk dss2_alwon_fck =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
-static struct clk dss_ick =3D {
+static struct clk dss_ick_3430es1 =3D {
 	/* Handles both L3 and L4 clocks */
 	.name		=3D "dss_ick",
 	.ops		=3D &clkops_omap2_dflt,
@@ -2079,6 +2130,18 @@ static struct clk dss_ick =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
+static struct clk dss_ick_3430es2 =3D {
+	/* Handles both L3 and L4 clocks */
+	.name		=3D "dss_ick",
+	.ops		=3D &clkops_omap3430es2_dss_usbhost_wait,
+	.parent		=3D &l4_ick,
+	.init		=3D &omap2_init_clk_clkdm,
+	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
+	.enable_bit	=3D OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
+	.clkdm_name	=3D "dss_clkdm",
+	.recalc		=3D &followparent_recalc,
+};
+
 /* CAM */
=20
 static struct clk cam_mclk =3D {
@@ -2118,7 +2181,7 @@ static struct clk csi2_96m_fck =3D {
=20
 static struct clk usbhost_120m_fck =3D {
 	.name		=3D "usbhost_120m_fck",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_dflt,
 	.parent		=3D &dpll5_m2_ck,
 	.init		=3D &omap2_init_clk_clkdm,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
@@ -2129,7 +2192,7 @@ static struct clk usbhost_120m_fck =3D {
=20
 static struct clk usbhost_48m_fck =3D {
 	.name		=3D "usbhost_48m_fck",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap3430es2_dss_usbhost_wait,
 	.parent		=3D &omap_48m_fck,
 	.init		=3D &omap2_init_clk_clkdm,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
@@ -2141,7 +2204,7 @@ static struct clk usbhost_48m_fck =3D {
 static struct clk usbhost_ick =3D {
 	/* Handles both L3 and L4 clocks */
 	.name		=3D "usbhost_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap3430es2_dss_usbhost_wait,
 	.parent		=3D &l4_ick,
 	.init		=3D &omap2_init_clk_clkdm,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
