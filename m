From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/12] OMAP4: clocks: Update clock tree for ES2
Date: Fri, 24 Sep 2010 01:08:08 -0600
Message-ID: <20100924070806.14014.40.stgit@twilight.localdomain>
References: <20100924070643.14014.11359.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33627 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744Ab0IXHJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 03:09:03 -0400
In-Reply-To: <20100924070643.14014.11359.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Rajendra Nayak <rnayak@ti.com>

This patch updates the clock tree with all the
changes in OMAP4430 ES2.

clock nodes added
-1- tie_low_clock_ck
-2- abe_dpll_bypass_clk_mux_ck

clock nodes deleted
-1- dpll_sys_ref_clk
-2- per_sgx_fclk
-3- usbphyocp2scp_ick

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
[paul@pwsan.com: added comment re ES1 clocks to top of file]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |  172 +++++++++++++++-----------=
--------
 1 files changed, 74 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2=
/clock44xx_data.c
index e10db7a..f39552b 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -17,6 +17,10 @@
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * XXX Some of the ES1 clocks have been removed/changed; once support
+ * is added for discriminating clocks by ES level, these should be add=
ed back
+ * in.
  */
=20
 #include <linux/kernel.h>
@@ -175,21 +179,27 @@ static struct clk sys_clkin_ck =3D {
 	.recalc		=3D &omap2_clksel_recalc,
 };
=20
+static struct clk tie_low_clock_ck =3D {
+	.name		=3D "tie_low_clock_ck",
+	.rate		=3D 0,
+	.ops		=3D &clkops_null,
+};
+
 static struct clk utmi_phy_clkout_ck =3D {
 	.name		=3D "utmi_phy_clkout_ck",
-	.rate		=3D 12000000,
+	.rate		=3D 60000000,
 	.ops		=3D &clkops_null,
 };
=20
 static struct clk xclk60mhsp1_ck =3D {
 	.name		=3D "xclk60mhsp1_ck",
-	.rate		=3D 12000000,
+	.rate		=3D 60000000,
 	.ops		=3D &clkops_null,
 };
=20
 static struct clk xclk60mhsp2_ck =3D {
 	.name		=3D "xclk60mhsp2_ck",
-	.rate		=3D 12000000,
+	.rate		=3D 60000000,
 	.ops		=3D &clkops_null,
 };
=20
@@ -201,39 +211,23 @@ static struct clk xclk60motg_ck =3D {
=20
 /* Module clocks and DPLL outputs */
=20
-static const struct clksel_rate div2_1to2_rates[] =3D {
-	{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_4430 },
-	{ .div =3D 2, .val =3D 1, .flags =3D RATE_IN_4430 },
-	{ .div =3D 0 },
-};
-
-static const struct clksel dpll_sys_ref_clk_div[] =3D {
-	{ .parent =3D &sys_clkin_ck, .rates =3D div2_1to2_rates },
+static const struct clksel abe_dpll_bypass_clk_mux_sel[] =3D {
+	{ .parent =3D &sys_clkin_ck, .rates =3D div_1_0_rates },
+	{ .parent =3D &sys_32k_ck, .rates =3D div_1_1_rates },
 	{ .parent =3D NULL },
 };
=20
-static struct clk dpll_sys_ref_clk =3D {
-	.name		=3D "dpll_sys_ref_clk",
+static struct clk abe_dpll_bypass_clk_mux_ck =3D {
+	.name		=3D "abe_dpll_bypass_clk_mux_ck",
 	.parent		=3D &sys_clkin_ck,
-	.clksel		=3D dpll_sys_ref_clk_div,
-	.clksel_reg	=3D OMAP4430_CM_DPLL_SYS_REF_CLKSEL,
-	.clksel_mask	=3D OMAP4430_CLKSEL_0_0_MASK,
 	.ops		=3D &clkops_null,
-	.recalc		=3D &omap2_clksel_recalc,
-	.round_rate	=3D &omap2_clksel_round_rate,
-	.set_rate	=3D &omap2_clksel_set_rate,
-};
-
-static const struct clksel abe_dpll_refclk_mux_sel[] =3D {
-	{ .parent =3D &dpll_sys_ref_clk, .rates =3D div_1_0_rates },
-	{ .parent =3D &sys_32k_ck, .rates =3D div_1_1_rates },
-	{ .parent =3D NULL },
+	.recalc		=3D &followparent_recalc,
 };
=20
 static struct clk abe_dpll_refclk_mux_ck =3D {
 	.name		=3D "abe_dpll_refclk_mux_ck",
-	.parent		=3D &dpll_sys_ref_clk,
-	.clksel		=3D abe_dpll_refclk_mux_sel,
+	.parent		=3D &sys_clkin_ck,
+	.clksel		=3D abe_dpll_bypass_clk_mux_sel,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP4430_CM_ABE_PLL_REF_CLKSEL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_0_0_MASK,
@@ -244,7 +238,7 @@ static struct clk abe_dpll_refclk_mux_ck =3D {
 /* DPLL_ABE */
 static struct dpll_data dpll_abe_dd =3D {
 	.mult_div1_reg	=3D OMAP4430_CM_CLKSEL_DPLL_ABE,
-	.clk_bypass	=3D &sys_clkin_ck,
+	.clk_bypass	=3D &abe_dpll_bypass_clk_mux_ck,
 	.clk_ref	=3D &abe_dpll_refclk_mux_ck,
 	.control_reg	=3D OMAP4430_CM_CLKMODE_DPLL_ABE,
 	.modes		=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
@@ -310,6 +304,12 @@ static struct clk abe_clk =3D {
 	.set_rate	=3D &omap2_clksel_set_rate,
 };
=20
+static const struct clksel_rate div2_1to2_rates[] =3D {
+	{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_4430 },
+	{ .div =3D 2, .val =3D 1, .flags =3D RATE_IN_4430 },
+	{ .div =3D 0 },
+};
+
 static const struct clksel aess_fclk_div[] =3D {
 	{ .parent =3D &abe_clk, .rates =3D div2_1to2_rates },
 	{ .parent =3D NULL },
@@ -380,14 +380,14 @@ static struct clk dpll_abe_m3_ck =3D {
 };
=20
 static const struct clksel core_hsd_byp_clk_mux_sel[] =3D {
-	{ .parent =3D &dpll_sys_ref_clk, .rates =3D div_1_0_rates },
+	{ .parent =3D &sys_clkin_ck, .rates =3D div_1_0_rates },
 	{ .parent =3D &dpll_abe_m3_ck, .rates =3D div_1_1_rates },
 	{ .parent =3D NULL },
 };
=20
 static struct clk core_hsd_byp_clk_mux_ck =3D {
 	.name		=3D "core_hsd_byp_clk_mux_ck",
-	.parent		=3D &dpll_sys_ref_clk,
+	.parent		=3D &sys_clkin_ck,
 	.clksel		=3D core_hsd_byp_clk_mux_sel,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP4430_CM_CLKSEL_DPLL_CORE,
@@ -400,7 +400,7 @@ static struct clk core_hsd_byp_clk_mux_ck =3D {
 static struct dpll_data dpll_core_dd =3D {
 	.mult_div1_reg	=3D OMAP4430_CM_CLKSEL_DPLL_CORE,
 	.clk_bypass	=3D &core_hsd_byp_clk_mux_ck,
-	.clk_ref	=3D &dpll_sys_ref_clk,
+	.clk_ref	=3D &sys_clkin_ck,
 	.control_reg	=3D OMAP4430_CM_CLKMODE_DPLL_CORE,
 	.modes		=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	=3D OMAP4430_CM_AUTOIDLE_DPLL_CORE,
@@ -418,7 +418,7 @@ static struct dpll_data dpll_core_dd =3D {
=20
 static struct clk dpll_core_ck =3D {
 	.name		=3D "dpll_core_ck",
-	.parent		=3D &dpll_sys_ref_clk,
+	.parent		=3D &sys_clkin_ck,
 	.dpll_data	=3D &dpll_core_dd,
 	.init		=3D &omap2_init_dpll_parent,
 	.ops		=3D &clkops_null,
@@ -596,14 +596,14 @@ static struct clk dpll_core_m7_ck =3D {
 };
=20
 static const struct clksel iva_hsd_byp_clk_mux_sel[] =3D {
-	{ .parent =3D &dpll_sys_ref_clk, .rates =3D div_1_0_rates },
+	{ .parent =3D &sys_clkin_ck, .rates =3D div_1_0_rates },
 	{ .parent =3D &div_iva_hs_clk, .rates =3D div_1_1_rates },
 	{ .parent =3D NULL },
 };
=20
 static struct clk iva_hsd_byp_clk_mux_ck =3D {
 	.name		=3D "iva_hsd_byp_clk_mux_ck",
-	.parent		=3D &dpll_sys_ref_clk,
+	.parent		=3D &sys_clkin_ck,
 	.ops		=3D &clkops_null,
 	.recalc		=3D &followparent_recalc,
 };
@@ -612,7 +612,7 @@ static struct clk iva_hsd_byp_clk_mux_ck =3D {
 static struct dpll_data dpll_iva_dd =3D {
 	.mult_div1_reg	=3D OMAP4430_CM_CLKSEL_DPLL_IVA,
 	.clk_bypass	=3D &iva_hsd_byp_clk_mux_ck,
-	.clk_ref	=3D &dpll_sys_ref_clk,
+	.clk_ref	=3D &sys_clkin_ck,
 	.control_reg	=3D OMAP4430_CM_CLKMODE_DPLL_IVA,
 	.modes		=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	=3D OMAP4430_CM_AUTOIDLE_DPLL_IVA,
@@ -630,7 +630,7 @@ static struct dpll_data dpll_iva_dd =3D {
=20
 static struct clk dpll_iva_ck =3D {
 	.name		=3D "dpll_iva_ck",
-	.parent		=3D &dpll_sys_ref_clk,
+	.parent		=3D &sys_clkin_ck,
 	.dpll_data	=3D &dpll_iva_dd,
 	.init		=3D &omap2_init_dpll_parent,
 	.ops		=3D &clkops_omap3_noncore_dpll_ops,
@@ -672,7 +672,7 @@ static struct clk dpll_iva_m5_ck =3D {
 static struct dpll_data dpll_mpu_dd =3D {
 	.mult_div1_reg	=3D OMAP4430_CM_CLKSEL_DPLL_MPU,
 	.clk_bypass	=3D &div_mpu_hs_clk,
-	.clk_ref	=3D &dpll_sys_ref_clk,
+	.clk_ref	=3D &sys_clkin_ck,
 	.control_reg	=3D OMAP4430_CM_CLKMODE_DPLL_MPU,
 	.modes		=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	=3D OMAP4430_CM_AUTOIDLE_DPLL_MPU,
@@ -690,7 +690,7 @@ static struct dpll_data dpll_mpu_dd =3D {
=20
 static struct clk dpll_mpu_ck =3D {
 	.name		=3D "dpll_mpu_ck",
-	.parent		=3D &dpll_sys_ref_clk,
+	.parent		=3D &sys_clkin_ck,
 	.dpll_data	=3D &dpll_mpu_dd,
 	.init		=3D &omap2_init_dpll_parent,
 	.ops		=3D &clkops_omap3_noncore_dpll_ops,
@@ -724,14 +724,14 @@ static struct clk per_hs_clk_div_ck =3D {
 };
=20
 static const struct clksel per_hsd_byp_clk_mux_sel[] =3D {
-	{ .parent =3D &dpll_sys_ref_clk, .rates =3D div_1_0_rates },
+	{ .parent =3D &sys_clkin_ck, .rates =3D div_1_0_rates },
 	{ .parent =3D &per_hs_clk_div_ck, .rates =3D div_1_1_rates },
 	{ .parent =3D NULL },
 };
=20
 static struct clk per_hsd_byp_clk_mux_ck =3D {
 	.name		=3D "per_hsd_byp_clk_mux_ck",
-	.parent		=3D &dpll_sys_ref_clk,
+	.parent		=3D &sys_clkin_ck,
 	.clksel		=3D per_hsd_byp_clk_mux_sel,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP4430_CM_CLKSEL_DPLL_PER,
@@ -744,7 +744,7 @@ static struct clk per_hsd_byp_clk_mux_ck =3D {
 static struct dpll_data dpll_per_dd =3D {
 	.mult_div1_reg	=3D OMAP4430_CM_CLKSEL_DPLL_PER,
 	.clk_bypass	=3D &per_hsd_byp_clk_mux_ck,
-	.clk_ref	=3D &dpll_sys_ref_clk,
+	.clk_ref	=3D &sys_clkin_ck,
 	.control_reg	=3D OMAP4430_CM_CLKMODE_DPLL_PER,
 	.modes		=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	=3D OMAP4430_CM_AUTOIDLE_DPLL_PER,
@@ -762,7 +762,7 @@ static struct dpll_data dpll_per_dd =3D {
=20
 static struct clk dpll_per_ck =3D {
 	.name		=3D "dpll_per_ck",
-	.parent		=3D &dpll_sys_ref_clk,
+	.parent		=3D &sys_clkin_ck,
 	.dpll_data	=3D &dpll_per_dd,
 	.init		=3D &omap2_init_dpll_parent,
 	.ops		=3D &clkops_omap3_noncore_dpll_ops,
@@ -858,8 +858,8 @@ static struct clk dpll_per_m7_ck =3D {
 /* DPLL_UNIPRO */
 static struct dpll_data dpll_unipro_dd =3D {
 	.mult_div1_reg	=3D OMAP4430_CM_CLKSEL_DPLL_UNIPRO,
-	.clk_bypass	=3D &dpll_sys_ref_clk,
-	.clk_ref	=3D &dpll_sys_ref_clk,
+	.clk_bypass	=3D &sys_clkin_ck,
+	.clk_ref	=3D &sys_clkin_ck,
 	.control_reg	=3D OMAP4430_CM_CLKMODE_DPLL_UNIPRO,
 	.modes		=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	=3D OMAP4430_CM_AUTOIDLE_DPLL_UNIPRO,
@@ -877,7 +877,7 @@ static struct dpll_data dpll_unipro_dd =3D {
=20
 static struct clk dpll_unipro_ck =3D {
 	.name		=3D "dpll_unipro_ck",
-	.parent		=3D &dpll_sys_ref_clk,
+	.parent		=3D &sys_clkin_ck,
 	.dpll_data	=3D &dpll_unipro_dd,
 	.init		=3D &omap2_init_dpll_parent,
 	.ops		=3D &clkops_omap3_noncore_dpll_ops,
@@ -914,7 +914,7 @@ static struct clk usb_hs_clk_div_ck =3D {
 static struct dpll_data dpll_usb_dd =3D {
 	.mult_div1_reg	=3D OMAP4430_CM_CLKSEL_DPLL_USB,
 	.clk_bypass	=3D &usb_hs_clk_div_ck,
-	.clk_ref	=3D &dpll_sys_ref_clk,
+	.clk_ref	=3D &sys_clkin_ck,
 	.control_reg	=3D OMAP4430_CM_CLKMODE_DPLL_USB,
 	.modes		=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	=3D OMAP4430_CM_AUTOIDLE_DPLL_USB,
@@ -933,7 +933,7 @@ static struct dpll_data dpll_usb_dd =3D {
=20
 static struct clk dpll_usb_ck =3D {
 	.name		=3D "dpll_usb_ck",
-	.parent		=3D &dpll_sys_ref_clk,
+	.parent		=3D &sys_clkin_ck,
 	.dpll_data	=3D &dpll_usb_dd,
 	.init		=3D &omap2_init_dpll_parent,
 	.ops		=3D &clkops_omap3_noncore_dpll_ops,
@@ -1222,7 +1222,7 @@ static struct clk per_abe_24m_fclk =3D {
 static const struct clksel pmd_stm_clock_mux_sel[] =3D {
 	{ .parent =3D &sys_clkin_ck, .rates =3D div_1_0_rates },
 	{ .parent =3D &dpll_core_m6_ck, .rates =3D div_1_1_rates },
-	{ .parent =3D &dpll_per_m7_ck, .rates =3D div_1_2_rates },
+	{ .parent =3D &tie_low_clock_ck, .rates =3D div_1_2_rates },
 	{ .parent =3D NULL },
 };
=20
@@ -1240,10 +1240,15 @@ static struct clk pmd_trace_clk_mux_ck =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
+static const struct clksel syc_clk_div_div[] =3D {
+	{ .parent =3D &sys_clkin_ck, .rates =3D div2_1to2_rates },
+	{ .parent =3D NULL },
+};
+
 static struct clk syc_clk_div_ck =3D {
 	.name		=3D "syc_clk_div_ck",
 	.parent		=3D &sys_clkin_ck,
-	.clksel		=3D dpll_sys_ref_clk_div,
+	.clksel		=3D syc_clk_div_div,
 	.clksel_reg	=3D OMAP4430_CM_ABE_DSS_SYS_CLKSEL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_0_0_MASK,
 	.ops		=3D &clkops_null,
@@ -1407,26 +1412,9 @@ static struct clk fdif_fck =3D {
 	.clkdm_name	=3D "iss_clkdm",
 };
=20
-static const struct clksel per_sgx_fclk_div[] =3D {
-	{ .parent =3D &dpll_per_m2x2_ck, .rates =3D div3_1to4_rates },
-	{ .parent =3D NULL },
-};
-
-static struct clk per_sgx_fclk =3D {
-	.name		=3D "per_sgx_fclk",
-	.parent		=3D &dpll_per_m2x2_ck,
-	.clksel		=3D per_sgx_fclk_div,
-	.clksel_reg	=3D OMAP4430_CM_GFX_GFX_CLKCTRL,
-	.clksel_mask	=3D OMAP4430_CLKSEL_PER_192M_MASK,
-	.ops		=3D &clkops_null,
-	.recalc		=3D &omap2_clksel_recalc,
-	.round_rate	=3D &omap2_clksel_round_rate,
-	.set_rate	=3D &omap2_clksel_set_rate,
-};
-
 static const struct clksel sgx_clk_mux_sel[] =3D {
 	{ .parent =3D &dpll_core_m7_ck, .rates =3D div_1_0_rates },
-	{ .parent =3D &per_sgx_fclk, .rates =3D div_1_1_rates },
+	{ .parent =3D &dpll_per_m7_ck, .rates =3D div_1_1_rates },
 	{ .parent =3D NULL },
 };
=20
@@ -1515,12 +1503,6 @@ static struct clk gpmc_ick =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
-static const struct clksel dmt1_clk_mux_sel[] =3D {
-	{ .parent =3D &sys_clkin_ck, .rates =3D div_1_0_rates },
-	{ .parent =3D &sys_32k_ck, .rates =3D div_1_1_rates },
-	{ .parent =3D NULL },
-};
-
 /*
  * Merged dmt1_clk_mux into gptimer1
  * gptimer1 renamed temporarily into gpt1 to match OMAP3 convention
@@ -1528,7 +1510,7 @@ static const struct clksel dmt1_clk_mux_sel[] =3D=
 {
 static struct clk gpt1_fck =3D {
 	.name		=3D "gpt1_fck",
 	.parent		=3D &sys_clkin_ck,
-	.clksel		=3D dmt1_clk_mux_sel,
+	.clksel		=3D abe_dpll_bypass_clk_mux_sel,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_MASK,
@@ -1546,7 +1528,7 @@ static struct clk gpt1_fck =3D {
 static struct clk gpt10_fck =3D {
 	.name		=3D "gpt10_fck",
 	.parent		=3D &sys_clkin_ck,
-	.clksel		=3D dmt1_clk_mux_sel,
+	.clksel		=3D abe_dpll_bypass_clk_mux_sel,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_MASK,
@@ -1564,7 +1546,7 @@ static struct clk gpt10_fck =3D {
 static struct clk gpt11_fck =3D {
 	.name		=3D "gpt11_fck",
 	.parent		=3D &sys_clkin_ck,
-	.clksel		=3D dmt1_clk_mux_sel,
+	.clksel		=3D abe_dpll_bypass_clk_mux_sel,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_MASK,
@@ -1582,7 +1564,7 @@ static struct clk gpt11_fck =3D {
 static struct clk gpt2_fck =3D {
 	.name		=3D "gpt2_fck",
 	.parent		=3D &sys_clkin_ck,
-	.clksel		=3D dmt1_clk_mux_sel,
+	.clksel		=3D abe_dpll_bypass_clk_mux_sel,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_MASK,
@@ -1600,7 +1582,7 @@ static struct clk gpt2_fck =3D {
 static struct clk gpt3_fck =3D {
 	.name		=3D "gpt3_fck",
 	.parent		=3D &sys_clkin_ck,
-	.clksel		=3D dmt1_clk_mux_sel,
+	.clksel		=3D abe_dpll_bypass_clk_mux_sel,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_MASK,
@@ -1618,7 +1600,7 @@ static struct clk gpt3_fck =3D {
 static struct clk gpt4_fck =3D {
 	.name		=3D "gpt4_fck",
 	.parent		=3D &sys_clkin_ck,
-	.clksel		=3D dmt1_clk_mux_sel,
+	.clksel		=3D abe_dpll_bypass_clk_mux_sel,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_MASK,
@@ -1714,7 +1696,7 @@ static struct clk gpt8_fck =3D {
 static struct clk gpt9_fck =3D {
 	.name		=3D "gpt9_fck",
 	.parent		=3D &sys_clkin_ck,
-	.clksel		=3D dmt1_clk_mux_sel,
+	.clksel		=3D abe_dpll_bypass_clk_mux_sel,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_MASK,
@@ -1735,11 +1717,16 @@ static struct clk hdq1w_fck =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
+static const struct clksel hsi_fclk_div[] =3D {
+	{ .parent =3D &dpll_per_m2x2_ck, .rates =3D div3_1to4_rates },
+	{ .parent =3D NULL },
+};
+
 /* Merged hsi_fclk into hsi */
 static struct clk hsi_ick =3D {
 	.name		=3D "hsi_ick",
 	.parent		=3D &dpll_per_m2x2_ck,
-	.clksel		=3D per_sgx_fclk_div,
+	.clksel		=3D hsi_fclk_div,
 	.clksel_reg	=3D OMAP4430_CM_L3INIT_HSI_CLKCTRL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_24_25_MASK,
 	.ops		=3D &clkops_omap2_dflt,
@@ -2315,21 +2302,11 @@ static struct clk usb_tll_ick =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
-static struct clk usbphyocp2scp_ick =3D {
-	.name		=3D "usbphyocp2scp_ick",
-	.ops		=3D &clkops_omap2_dflt,
-	.enable_reg	=3D OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-	.enable_bit	=3D OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	=3D "l3_init_clkdm",
-	.parent		=3D &l4_div_ck,
-	.recalc		=3D &followparent_recalc,
-};
-
-static struct clk usim_fck =3D {
-	.name		=3D "usim_fck",
+static struct clk usim_ick =3D {
+	.name		=3D "usim_ick",
 	.ops		=3D &clkops_omap2_dflt,
 	.enable_reg	=3D OMAP4430_CM_WKUP_USIM_CLKCTRL,
-	.enable_bit	=3D OMAP4430_MODULEMODE_SWCTRL,
+	.enable_bit	=3D OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	=3D "l4_wkup_clkdm",
 	.parent		=3D &sys_32k_ck,
 	.recalc		=3D &followparent_recalc,
@@ -2483,11 +2460,12 @@ static struct omap_clk omap44xx_clks[] =3D {
 	CLK(NULL,	"virt_27000000_ck",		&virt_27000000_ck,	CK_443X),
 	CLK(NULL,	"virt_38400000_ck",		&virt_38400000_ck,	CK_443X),
 	CLK(NULL,	"sys_clkin_ck",			&sys_clkin_ck,	CK_443X),
+	CLK(NULL,	"tie_low_clock_ck",		&tie_low_clock_ck,	CK_443X),
 	CLK(NULL,	"utmi_phy_clkout_ck",		&utmi_phy_clkout_ck,	CK_443X),
 	CLK(NULL,	"xclk60mhsp1_ck",		&xclk60mhsp1_ck,	CK_443X),
 	CLK(NULL,	"xclk60mhsp2_ck",		&xclk60mhsp2_ck,	CK_443X),
 	CLK(NULL,	"xclk60motg_ck",		&xclk60motg_ck,	CK_443X),
-	CLK(NULL,	"dpll_sys_ref_clk",		&dpll_sys_ref_clk,	CK_443X),
+	CLK(NULL,	"abe_dpll_bypass_clk_mux_ck",	&abe_dpll_bypass_clk_mux_ck,	=
CK_443X),
 	CLK(NULL,	"abe_dpll_refclk_mux_ck",	&abe_dpll_refclk_mux_ck,	CK_443X)=
,
 	CLK(NULL,	"dpll_abe_ck",			&dpll_abe_ck,	CK_443X),
 	CLK(NULL,	"dpll_abe_m2x2_ck",		&dpll_abe_m2x2_ck,	CK_443X),
@@ -2566,7 +2544,6 @@ static struct omap_clk omap44xx_clks[] =3D {
 	CLK(NULL,	"emif1_ick",			&emif1_ick,	CK_443X),
 	CLK(NULL,	"emif2_ick",			&emif2_ick,	CK_443X),
 	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_443X),
-	CLK(NULL,	"per_sgx_fclk",			&per_sgx_fclk,	CK_443X),
 	CLK(NULL,	"gfx_fck",			&gfx_fck,	CK_443X),
 	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_443X),
 	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_443X),
@@ -2637,8 +2614,7 @@ static struct omap_clk omap44xx_clks[] =3D {
 	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
 	CLK("musb_hdrc",	"ick",				&usb_otg_ick,	CK_443X),
 	CLK(NULL,	"usb_tll_ick",			&usb_tll_ick,	CK_443X),
-	CLK(NULL,	"usbphyocp2scp_ick",		&usbphyocp2scp_ick,	CK_443X),
-	CLK(NULL,	"usim_fck",			&usim_fck,	CK_443X),
+	CLK(NULL,	"usim_ick",			&usim_ick,	CK_443X),
 	CLK("omap_wdt",	"fck",				&wdt2_fck,	CK_443X),
 	CLK(NULL,	"wdt3_fck",			&wdt3_fck,	CK_443X),
 	CLK(NULL,	"otg_60m_gfclk_ck",		&otg_60m_gfclk_ck,	CK_443X),


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
