From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 2/7] OMAP4: clock: Fix clock names and align with
 hwmod names
Date: Wed, 22 Sep 2010 01:23:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009220120110.21002@utopia.booyaka.com>
References: <1281023276-15679-1-git-send-email-b-cousson@ti.com> <1281023276-15679-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-122915866-1285140217=:21002"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58678 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab0IVHXi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 03:23:38 -0400
In-Reply-To: <1281023276-15679-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, rnayak@ti.com, santosh.shilimkar@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-122915866-1285140217=:21002
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Beno=EEt,

On Thu, 5 Aug 2010, Benoit Cousson wrote:

> The OMAP4 hwmod data introduced the new naming convention for TI
> IPs (See patch OMAP4: hwmod: Add partial hwmod support for OMAP4430 ES1.0=
)
>=20
> The leaf clock names are using the same IP name and thus must be
> modified to match the clock populated in the hwmod data.
>=20
> - Fix some leaf clocks nodes that were using a _iclk instead of the _fclk
> prefix.
> - Fix some wrong interface clock name for master IPs connected to
> interconnect.
>=20
> Please not that due to the fact that nodes are sorted by name, the name
> change will introduce a quite ugly diff a little bit hard to follow.
>=20
> Timers clock con_id is still using the old gptX_fck name until the
> gptimer driver is updated to omap_device framework.
> Timers entries in hwmods DB are still disabled until the migration
> if timer to platform_driver + omap_hwmod.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

I had to manually resolve conflicts with Rajendra's patch in order to=20
apply this one.  Could you please doublecheck it (or at least, the final=20
clock44xx_data.c, after the next patch from you is applied) to help me=20
make sure I didn't mess anything up too badly?

(The updated patch is below)


- Paul

From=20a9ddb89a380b862e72a65fba0034fb077f873ba6 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Thu, 5 Aug 2010 17:47:51 +0200
Subject: [PATCH] OMAP4: clock: Fix clock names and align with hwmod names

The OMAP4 hwmod data introduced the new naming convention for TI
IPs (See patch OMAP4: hwmod: Add partial hwmod support for OMAP4430 ES1.0)

The leaf clock names are using the same IP name and thus must be
modified to match the clock populated in the hwmod data.

- Fix some leaf clocks nodes that were using a _iclk instead of the _fclk
prefix.
- Fix some wrong interface clock name for master IPs connected to
interconnect.

Please not that due to the fact that nodes are sorted by name, the name
change will introduce a quite ugly diff a little bit hard to follow.

Timers clock con_id is still using the old gptX_fck name until the
gptimer driver is updated to omap_device framework.
Timers entries in hwmods DB are still disabled until the migration
if timer to platform_driver + omap_hwmod.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
[paul@pwsan.com: manually resolved conflicts with Rajendra's clock patch]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |  665 ++++++++++++++++--------------=
----
 1 files changed, 310 insertions(+), 355 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clo=
ck44xx_data.c
index 6e5a893..401a6c4 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -22,7 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/clk.h>
-
 #include <plat/control.h>
 #include <plat/clkdev_omap.h>
=20
@@ -910,6 +909,7 @@ static struct clk usb_hs_clk_div_ck =3D {
 static struct dpll_data dpll_usb_dd =3D {
 =09.mult_div1_reg=09=3D OMAP4430_CM_CLKSEL_DPLL_USB,
 =09.clk_bypass=09=3D &usb_hs_clk_div_ck,
+=09.flags=09=09=3D DPLL_J_TYPE | DPLL_NO_DCO_SEL,
 =09.clk_ref=09=3D &sys_clkin_ck,
 =09.control_reg=09=3D OMAP4430_CM_CLKMODE_DPLL_USB,
 =09.modes=09=09=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
@@ -923,7 +923,6 @@ static struct dpll_data dpll_usb_dd =3D {
 =09.max_multiplier=09=3D OMAP4430_MAX_DPLL_MULT,
 =09.max_divider=09=3D OMAP4430_MAX_DPLL_DIV,
 =09.min_divider=09=3D 1,
-=09.flags=09=09=3D DPLL_J_TYPE | DPLL_NO_DCO_SEL
 };
=20
=20
@@ -1285,16 +1284,6 @@ static struct clk aess_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk cust_efuse_fck =3D {
-=09.name=09=09=3D "cust_efuse_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.enable_reg=09=3D OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l4_cefuse_clkdm",
-=09.parent=09=09=3D &sys_clkin_ck,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
 static struct clk des3des_fck =3D {
 =09.name=09=09=3D "des3des_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1345,6 +1334,16 @@ static struct clk dmic_fck =3D {
 =09.clkdm_name=09=3D "abe_clkdm",
 };
=20
+static struct clk dsp_fck =3D {
+=09.name=09=09=3D "dsp_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_TESLA_TESLA_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
+=09.clkdm_name=09=3D "tesla_clkdm",
+=09.parent=09=09=3D &dpll_iva_m4_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk dss_fck =3D {
 =09.name=09=09=3D "dss_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1355,18 +1354,18 @@ static struct clk dss_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk ducati_ick =3D {
-=09.name=09=09=3D "ducati_ick",
+static struct clk efuse_ctrl_cust_fck =3D {
+=09.name=09=09=3D "efuse_ctrl_cust_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
-=09.enable_reg=09=3D OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
-=09.clkdm_name=09=3D "ducati_clkdm",
-=09.parent=09=09=3D &ducati_clk_mux_ck,
+=09.enable_reg=09=3D OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "l4_cefuse_clkdm",
+=09.parent=09=09=3D &sys_clkin_ck,
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk emif1_ick =3D {
-=09.name=09=09=3D "emif1_ick",
+static struct clk emif1_fck =3D {
+=09.name=09=09=3D "emif1_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
@@ -1376,8 +1375,8 @@ static struct clk emif1_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk emif2_ick =3D {
-=09.name=09=09=3D "emif2_ick",
+static struct clk emif2_fck =3D {
+=09.name=09=09=3D "emif2_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
@@ -1408,25 +1407,14 @@ static struct clk fdif_fck =3D {
 =09.clkdm_name=09=3D "iss_clkdm",
 };
=20
-static const struct clksel sgx_clk_mux_sel[] =3D {
-=09{ .parent =3D &dpll_core_m7_ck, .rates =3D div_1_0_rates },
-=09{ .parent =3D &dpll_per_m7_ck, .rates =3D div_1_1_rates },
-=09{ .parent =3D NULL },
-};
-
-/* Merged sgx_clk_mux into gfx */
-static struct clk gfx_fck =3D {
-=09.name=09=09=3D "gfx_fck",
-=09.parent=09=09=3D &dpll_core_m7_ck,
-=09.clksel=09=09=3D sgx_clk_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_GFX_GFX_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_SGX_FCLK_MASK,
+static struct clk fpka_fck =3D {
+=09.name=09=09=3D "fpka_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM_GFX_GFX_CLKCTRL,
+=09.enable_reg=09=3D OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l3_gfx_clkdm",
+=09.clkdm_name=09=3D "l4_secure_clkdm",
+=09.parent=09=09=3D &l4_div_ck,
+=09.recalc=09=09=3D &followparent_recalc,
 };
=20
 static struct clk gpio1_ick =3D {
@@ -1499,208 +1487,25 @@ static struct clk gpmc_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-/*
- * Merged dmt1_clk_mux into gptimer1
- * gptimer1 renamed temporarily into gpt1 to match OMAP3 convention
- */
-static struct clk gpt1_fck =3D {
-=09.name=09=09=3D "gpt1_fck",
-=09.parent=09=09=3D &sys_clkin_ck,
-=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l4_wkup_clkdm",
-};
-
-/*
- * Merged cm2_dm10_mux into gptimer10
- * gptimer10 renamed temporarily into gpt10 to match OMAP3 convention
- */
-static struct clk gpt10_fck =3D {
-=09.name=09=09=3D "gpt10_fck",
-=09.parent=09=09=3D &sys_clkin_ck,
-=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l4_per_clkdm",
-};
-
-/*
- * Merged cm2_dm11_mux into gptimer11
- * gptimer11 renamed temporarily into gpt11 to match OMAP3 convention
- */
-static struct clk gpt11_fck =3D {
-=09.name=09=09=3D "gpt11_fck",
-=09.parent=09=09=3D &sys_clkin_ck,
-=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l4_per_clkdm",
-};
-
-/*
- * Merged cm2_dm2_mux into gptimer2
- * gptimer2 renamed temporarily into gpt2 to match OMAP3 convention
- */
-static struct clk gpt2_fck =3D {
-=09.name=09=09=3D "gpt2_fck",
-=09.parent=09=09=3D &sys_clkin_ck,
-=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l4_per_clkdm",
-};
-
-/*
- * Merged cm2_dm3_mux into gptimer3
- * gptimer3 renamed temporarily into gpt3 to match OMAP3 convention
- */
-static struct clk gpt3_fck =3D {
-=09.name=09=09=3D "gpt3_fck",
-=09.parent=09=09=3D &sys_clkin_ck,
-=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l4_per_clkdm",
-};
-
-/*
- * Merged cm2_dm4_mux into gptimer4
- * gptimer4 renamed temporarily into gpt4 to match OMAP3 convention
- */
-static struct clk gpt4_fck =3D {
-=09.name=09=09=3D "gpt4_fck",
-=09.parent=09=09=3D &sys_clkin_ck,
-=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l4_per_clkdm",
-};
-
-static const struct clksel timer5_sync_mux_sel[] =3D {
-=09{ .parent =3D &syc_clk_div_ck, .rates =3D div_1_0_rates },
-=09{ .parent =3D &sys_32k_ck, .rates =3D div_1_1_rates },
+static const struct clksel sgx_clk_mux_sel[] =3D {
+=09{ .parent =3D &dpll_core_m7_ck, .rates =3D div_1_0_rates },
+=09{ .parent =3D &dpll_per_m7_ck, .rates =3D div_1_1_rates },
 =09{ .parent =3D NULL },
 };
=20
-/*
- * Merged timer5_sync_mux into gptimer5
- * gptimer5 renamed temporarily into gpt5 to match OMAP3 convention
- */
-static struct clk gpt5_fck =3D {
-=09.name=09=09=3D "gpt5_fck",
-=09.parent=09=09=3D &syc_clk_div_ck,
-=09.clksel=09=09=3D timer5_sync_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "abe_clkdm",
-};
-
-/*
- * Merged timer6_sync_mux into gptimer6
- * gptimer6 renamed temporarily into gpt6 to match OMAP3 convention
- */
-static struct clk gpt6_fck =3D {
-=09.name=09=09=3D "gpt6_fck",
-=09.parent=09=09=3D &syc_clk_div_ck,
-=09.clksel=09=09=3D timer5_sync_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "abe_clkdm",
-};
-
-/*
- * Merged timer7_sync_mux into gptimer7
- * gptimer7 renamed temporarily into gpt7 to match OMAP3 convention
- */
-static struct clk gpt7_fck =3D {
-=09.name=09=09=3D "gpt7_fck",
-=09.parent=09=09=3D &syc_clk_div_ck,
-=09.clksel=09=09=3D timer5_sync_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "abe_clkdm",
-};
-
-/*
- * Merged timer8_sync_mux into gptimer8
- * gptimer8 renamed temporarily into gpt8 to match OMAP3 convention
- */
-static struct clk gpt8_fck =3D {
-=09.name=09=09=3D "gpt8_fck",
-=09.parent=09=09=3D &syc_clk_div_ck,
-=09.clksel=09=09=3D timer5_sync_mux_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "abe_clkdm",
-};
-
-/*
- * Merged cm2_dm9_mux into gptimer9
- * gptimer9 renamed temporarily into gpt9 to match OMAP3 convention
- */
-static struct clk gpt9_fck =3D {
-=09.name=09=09=3D "gpt9_fck",
-=09.parent=09=09=3D &sys_clkin_ck,
-=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
+/* Merged sgx_clk_mux into gpu */
+static struct clk gpu_fck =3D {
+=09.name=09=09=3D "gpu_fck",
+=09.parent=09=09=3D &dpll_core_m7_ck,
+=09.clksel=09=09=3D sgx_clk_mux_sel,
 =09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.clksel_reg=09=3D OMAP4430_CM_GFX_GFX_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_SGX_FCLK_MASK,
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
+=09.enable_reg=09=3D OMAP4430_CM_GFX_GFX_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l4_per_clkdm",
+=09.clkdm_name=09=3D "l3_gfx_clkdm",
 };
=20
 static struct clk hdq1w_fck =3D {
@@ -1719,8 +1524,8 @@ static const struct clksel hsi_fclk_div[] =3D {
 };
=20
 /* Merged hsi_fclk into hsi */
-static struct clk hsi_ick =3D {
-=09.name=09=09=3D "hsi_ick",
+static struct clk hsi_fck =3D {
+=09.name=09=09=3D "hsi_fck",
 =09.parent=09=09=3D &dpll_per_m2x2_ck,
 =09.clksel=09=09=3D hsi_fclk_div,
 =09.clksel_reg=09=3D OMAP4430_CM_L3INIT_HSI_CLKCTRL,
@@ -1774,6 +1579,16 @@ static struct clk i2c4_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk ipu_fck =3D {
+=09.name=09=09=3D "ipu_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
+=09.clkdm_name=09=3D "ducati_clkdm",
+=09.parent=09=09=3D &ducati_clk_mux_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk iss_fck =3D {
 =09.name=09=09=3D "iss_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1784,8 +1599,8 @@ static struct clk iss_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk ivahd_ick =3D {
-=09.name=09=09=3D "ivahd_ick",
+static struct clk iva_fck =3D {
+=09.name=09=09=3D "iva_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
@@ -1794,8 +1609,8 @@ static struct clk ivahd_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk keyboard_fck =3D {
-=09.name=09=09=3D "keyboard_fck",
+static struct clk kbd_fck =3D {
+=09.name=09=09=3D "kbd_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
@@ -1804,8 +1619,8 @@ static struct clk keyboard_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk l3_instr_interconnect_ick =3D {
-=09.name=09=09=3D "l3_instr_interconnect_ick",
+static struct clk l3_instr_ick =3D {
+=09.name=09=09=3D "l3_instr_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
@@ -1814,8 +1629,8 @@ static struct clk l3_instr_interconnect_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk l3_interconnect_3_ick =3D {
-=09.name=09=09=3D "l3_interconnect_3_ick",
+static struct clk l3_main_3_ick =3D {
+=09.name=09=09=3D "l3_main_3_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_L3INSTR_L3_3_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
@@ -1988,6 +1803,16 @@ static struct clk mcbsp4_fck =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 };
=20
+static struct clk mcpdm_fck =3D {
+=09.name=09=09=3D "mcpdm_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM1_ABE_PDM_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "abe_clkdm",
+=09.parent=09=09=3D &pad_clks_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk mcspi1_fck =3D {
 =09.name=09=09=3D "mcspi1_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -2088,8 +1913,8 @@ static struct clk mmc5_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk ocp_wp1_ick =3D {
-=09.name=09=09=3D "ocp_wp1_ick",
+static struct clk ocp_wp_noc_ick =3D {
+=09.name=09=09=3D "ocp_wp_noc_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
@@ -2098,26 +1923,6 @@ static struct clk ocp_wp1_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk pdm_fck =3D {
-=09.name=09=09=3D "pdm_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.enable_reg=09=3D OMAP4430_CM1_ABE_PDM_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "abe_clkdm",
-=09.parent=09=09=3D &pad_clks_ck,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk pkaeip29_fck =3D {
-=09.name=09=09=3D "pkaeip29_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.enable_reg=09=3D OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l4_secure_clkdm",
-=09.parent=09=09=3D &l4_div_ck,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
 static struct clk rng_ick =3D {
 =09.name=09=09=3D "rng_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -2128,8 +1933,8 @@ static struct clk rng_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk sha2md51_fck =3D {
-=09.name=09=09=3D "sha2md51_fck",
+static struct clk sha2md5_fck =3D {
+=09.name=09=09=3D "sha2md5_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
@@ -2138,8 +1943,8 @@ static struct clk sha2md51_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk sl2_ick =3D {
-=09.name=09=09=3D "sl2_ick",
+static struct clk sl2if_ick =3D {
+=09.name=09=09=3D "sl2if_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_IVAHD_SL2_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
@@ -2168,8 +1973,8 @@ static struct clk slimbus2_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk sr_core_fck =3D {
-=09.name=09=09=3D "sr_core_fck",
+static struct clk smartreflex_core_fck =3D {
+=09.name=09=09=3D "smartreflex_core_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
@@ -2178,8 +1983,8 @@ static struct clk sr_core_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk sr_iva_fck =3D {
-=09.name=09=09=3D "sr_iva_fck",
+static struct clk smartreflex_iva_fck =3D {
+=09.name=09=09=3D "smartreflex_iva_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
@@ -2188,8 +1993,8 @@ static struct clk sr_iva_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk sr_mpu_fck =3D {
-=09.name=09=09=3D "sr_mpu_fck",
+static struct clk smartreflex_mpu_fck =3D {
+=09.name=09=09=3D "smartreflex_mpu_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
@@ -2198,14 +2003,175 @@ static struct clk sr_mpu_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk tesla_ick =3D {
-=09.name=09=09=3D "tesla_ick",
+/* Merged dmt1_clk_mux into timer1 */
+static struct clk timer1_fck =3D {
+=09.name=09=09=3D "timer1_fck",
+=09.parent=09=09=3D &sys_clkin_ck,
+=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
 =09.ops=09=09=3D &clkops_omap2_dflt,
-=09.enable_reg=09=3D OMAP4430_CM_TESLA_TESLA_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
-=09.clkdm_name=09=3D "tesla_clkdm",
-=09.parent=09=09=3D &dpll_iva_m4_ck,
-=09.recalc=09=09=3D &followparent_recalc,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "l4_wkup_clkdm",
+};
+
+/* Merged cm2_dm10_mux into timer10 */
+static struct clk timer10_fck =3D {
+=09.name=09=09=3D "timer10_fck",
+=09.parent=09=09=3D &sys_clkin_ck,
+=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+};
+
+/* Merged cm2_dm11_mux into timer11 */
+static struct clk timer11_fck =3D {
+=09.name=09=09=3D "timer11_fck",
+=09.parent=09=09=3D &sys_clkin_ck,
+=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+};
+
+/* Merged cm2_dm2_mux into timer2 */
+static struct clk timer2_fck =3D {
+=09.name=09=09=3D "timer2_fck",
+=09.parent=09=09=3D &sys_clkin_ck,
+=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+};
+
+/* Merged cm2_dm3_mux into timer3 */
+static struct clk timer3_fck =3D {
+=09.name=09=09=3D "timer3_fck",
+=09.parent=09=09=3D &sys_clkin_ck,
+=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+};
+
+/* Merged cm2_dm4_mux into timer4 */
+static struct clk timer4_fck =3D {
+=09.name=09=09=3D "timer4_fck",
+=09.parent=09=09=3D &sys_clkin_ck,
+=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+};
+
+static const struct clksel timer5_sync_mux_sel[] =3D {
+=09{ .parent =3D &syc_clk_div_ck, .rates =3D div_1_0_rates },
+=09{ .parent =3D &sys_32k_ck, .rates =3D div_1_1_rates },
+=09{ .parent =3D NULL },
+};
+
+/* Merged timer5_sync_mux into timer5 */
+static struct clk timer5_fck =3D {
+=09.name=09=09=3D "timer5_fck",
+=09.parent=09=09=3D &syc_clk_div_ck,
+=09.clksel=09=09=3D timer5_sync_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "abe_clkdm",
+};
+
+/* Merged timer6_sync_mux into timer6 */
+static struct clk timer6_fck =3D {
+=09.name=09=09=3D "timer6_fck",
+=09.parent=09=09=3D &syc_clk_div_ck,
+=09.clksel=09=09=3D timer5_sync_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "abe_clkdm",
+};
+
+/* Merged timer7_sync_mux into timer7 */
+static struct clk timer7_fck =3D {
+=09.name=09=09=3D "timer7_fck",
+=09.parent=09=09=3D &syc_clk_div_ck,
+=09.clksel=09=09=3D timer5_sync_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "abe_clkdm",
+};
+
+/* Merged timer8_sync_mux into timer8 */
+static struct clk timer8_fck =3D {
+=09.name=09=09=3D "timer8_fck",
+=09.parent=09=09=3D &syc_clk_div_ck,
+=09.clksel=09=09=3D timer5_sync_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "abe_clkdm",
+};
+
+/* Merged cm2_dm9_mux into timer9 */
+static struct clk timer9_fck =3D {
+=09.name=09=09=3D "timer9_fck",
+=09.parent=09=09=3D &sys_clkin_ck,
+=09.clksel=09=09=3D abe_dpll_bypass_clk_mux_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_MASK,
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
+=09.clkdm_name=09=3D "l4_per_clkdm",
 };
=20
 static struct clk uart1_fck =3D {
@@ -2248,18 +2214,18 @@ static struct clk uart4_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk unipro1_fck =3D {
-=09.name=09=09=3D "unipro1_fck",
+static struct clk usb_host_fs_fck =3D {
+=09.name=09=09=3D "usb_host_fs_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
-=09.enable_reg=09=3D OMAP4430_CM_L3INIT_UNIPRO1_CLKCTRL,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
 =09.clkdm_name=09=3D "l3_init_clkdm",
-=09.parent=09=09=3D &func_96m_fclk,
+=09.parent=09=09=3D &func_48mc_fclk,
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk usb_host_fck =3D {
-=09.name=09=09=3D "usb_host_fck",
+static struct clk usb_host_hs_fck =3D {
+=09.name=09=09=3D "usb_host_hs_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
@@ -2268,18 +2234,8 @@ static struct clk usb_host_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk usb_host_fs_fck =3D {
-=09.name=09=09=3D "usb_host_fs_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
-=09.clkdm_name=09=3D "l3_init_clkdm",
-=09.parent=09=09=3D &func_48mc_fclk,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk usb_otg_ick =3D {
-=09.name=09=09=3D "usb_otg_ick",
+static struct clk usb_otg_hs_ick =3D {
+=09.name=09=09=3D "usb_otg_hs_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
@@ -2288,8 +2244,8 @@ static struct clk usb_otg_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk usb_tll_ick =3D {
-=09.name=09=09=3D "usb_tll_ick",
+static struct clk usb_tll_hs_ick =3D {
+=09.name=09=09=3D "usb_tll_hs_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
@@ -2298,8 +2254,8 @@ static struct clk usb_tll_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk usim_ick =3D {
-=09.name=09=09=3D "usim_ick",
+static struct clk usim_fck =3D {
+=09.name=09=09=3D "usim_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_WKUP_USIM_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
@@ -2308,8 +2264,8 @@ static struct clk usim_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk wdt2_fck =3D {
-=09.name=09=09=3D "wdt2_fck",
+static struct clk wd_timer2_fck =3D {
+=09.name=09=09=3D "wd_timer2_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_WKUP_WDT2_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
@@ -2318,8 +2274,8 @@ static struct clk wdt2_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk wdt3_fck =3D {
-=09.name=09=09=3D "wdt3_fck",
+static struct clk wd_timer3_fck =3D {
+=09.name=09=09=3D "wd_timer3_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM1_ABE_WDT3_CLKCTRL,
 =09.enable_bit=09=3D OMAP4430_MODULEMODE_SWCTRL,
@@ -2531,16 +2487,16 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"aes1_fck",=09=09=09&aes1_fck,=09CK_443X),
 =09CLK(NULL,=09"aes2_fck",=09=09=09&aes2_fck,=09CK_443X),
 =09CLK(NULL,=09"aess_fck",=09=09=09&aess_fck,=09CK_443X),
-=09CLK(NULL,=09"cust_efuse_fck",=09=09&cust_efuse_fck,=09CK_443X),
 =09CLK(NULL,=09"des3des_fck",=09=09=09&des3des_fck,=09CK_443X),
 =09CLK(NULL,=09"dmic_sync_mux_ck",=09=09&dmic_sync_mux_ck,=09CK_443X),
 =09CLK(NULL,=09"dmic_fck",=09=09=09&dmic_fck,=09CK_443X),
+=09CLK(NULL,=09"dsp_fck",=09=09=09&dsp_fck,=09CK_443X),
 =09CLK(NULL,=09"dss_fck",=09=09=09&dss_fck,=09CK_443X),
-=09CLK(NULL,=09"ducati_ick",=09=09=09&ducati_ick,=09CK_443X),
-=09CLK(NULL,=09"emif1_ick",=09=09=09&emif1_ick,=09CK_443X),
-=09CLK(NULL,=09"emif2_ick",=09=09=09&emif2_ick,=09CK_443X),
+=09CLK(NULL,=09"efuse_ctrl_cust_fck",=09=09&efuse_ctrl_cust_fck,=09CK_443X=
),
+=09CLK(NULL,=09"emif1_fck",=09=09=09&emif1_fck,=09CK_443X),
+=09CLK(NULL,=09"emif2_fck",=09=09=09&emif2_fck,=09CK_443X),
 =09CLK(NULL,=09"fdif_fck",=09=09=09&fdif_fck,=09CK_443X),
-=09CLK(NULL,=09"gfx_fck",=09=09=09&gfx_fck,=09CK_443X),
+=09CLK(NULL,=09"fpka_fck",=09=09=09&fpka_fck,=09CK_443X),
 =09CLK(NULL,=09"gpio1_ick",=09=09=09&gpio1_ick,=09CK_443X),
 =09CLK(NULL,=09"gpio2_ick",=09=09=09&gpio2_ick,=09CK_443X),
 =09CLK(NULL,=09"gpio3_ick",=09=09=09&gpio3_ick,=09CK_443X),
@@ -2548,28 +2504,19 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"gpio5_ick",=09=09=09&gpio5_ick,=09CK_443X),
 =09CLK(NULL,=09"gpio6_ick",=09=09=09&gpio6_ick,=09CK_443X),
 =09CLK(NULL,=09"gpmc_ick",=09=09=09&gpmc_ick,=09CK_443X),
-=09CLK(NULL,=09"gpt1_fck",=09=09=09&gpt1_fck,=09CK_443X),
-=09CLK(NULL,=09"gpt10_fck",=09=09=09&gpt10_fck,=09CK_443X),
-=09CLK(NULL,=09"gpt11_fck",=09=09=09&gpt11_fck,=09CK_443X),
-=09CLK(NULL,=09"gpt2_fck",=09=09=09&gpt2_fck,=09CK_443X),
-=09CLK(NULL,=09"gpt3_fck",=09=09=09&gpt3_fck,=09CK_443X),
-=09CLK(NULL,=09"gpt4_fck",=09=09=09&gpt4_fck,=09CK_443X),
-=09CLK(NULL,=09"gpt5_fck",=09=09=09&gpt5_fck,=09CK_443X),
-=09CLK(NULL,=09"gpt6_fck",=09=09=09&gpt6_fck,=09CK_443X),
-=09CLK(NULL,=09"gpt7_fck",=09=09=09&gpt7_fck,=09CK_443X),
-=09CLK(NULL,=09"gpt8_fck",=09=09=09&gpt8_fck,=09CK_443X),
-=09CLK(NULL,=09"gpt9_fck",=09=09=09&gpt9_fck,=09CK_443X),
+=09CLK(NULL,=09"gpu_fck",=09=09=09&gpu_fck,=09CK_443X),
 =09CLK("omap2_hdq.0",=09"fck",=09=09=09=09&hdq1w_fck,=09CK_443X),
-=09CLK(NULL,=09"hsi_ick",=09=09=09&hsi_ick,=09CK_443X),
+=09CLK(NULL,=09"hsi_fck",=09=09=09&hsi_fck,=09CK_443X),
 =09CLK("i2c_omap.1",=09"fck",=09=09=09=09&i2c1_fck,=09CK_443X),
 =09CLK("i2c_omap.2",=09"fck",=09=09=09=09&i2c2_fck,=09CK_443X),
 =09CLK("i2c_omap.3",=09"fck",=09=09=09=09&i2c3_fck,=09CK_443X),
 =09CLK("i2c_omap.4",=09"fck",=09=09=09=09&i2c4_fck,=09CK_443X),
+=09CLK(NULL,=09"ipu_fck",=09=09=09&ipu_fck,=09CK_443X),
 =09CLK(NULL,=09"iss_fck",=09=09=09&iss_fck,=09CK_443X),
-=09CLK(NULL,=09"ivahd_ick",=09=09=09&ivahd_ick,=09CK_443X),
-=09CLK(NULL,=09"keyboard_fck",=09=09=09&keyboard_fck,=09CK_443X),
-=09CLK(NULL,=09"l3_instr_interconnect_ick",=09&l3_instr_interconnect_ick,=
=09CK_443X),
-=09CLK(NULL,=09"l3_interconnect_3_ick",=09&l3_interconnect_3_ick,=09CK_443=
X),
+=09CLK(NULL,=09"iva_fck",=09=09=09&iva_fck,=09CK_443X),
+=09CLK(NULL,=09"kbd_fck",=09=09=09&kbd_fck,=09CK_443X),
+=09CLK(NULL,=09"l3_instr_ick",=09=09=09&l3_instr_ick,=09CK_443X),
+=09CLK(NULL,=09"l3_main_3_ick",=09=09&l3_main_3_ick,=09CK_443X),
 =09CLK(NULL,=09"mcasp_sync_mux_ck",=09=09&mcasp_sync_mux_ck,=09CK_443X),
 =09CLK(NULL,=09"mcasp_fck",=09=09=09&mcasp_fck,=09CK_443X),
 =09CLK(NULL,=09"mcbsp1_sync_mux_ck",=09=09&mcbsp1_sync_mux_ck,=09CK_443X),
@@ -2580,6 +2527,7 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK("omap-mcbsp.3",=09"fck",=09=09=09=09&mcbsp3_fck,=09CK_443X),
 =09CLK(NULL,=09"mcbsp4_sync_mux_ck",=09=09&mcbsp4_sync_mux_ck,=09CK_443X),
 =09CLK("omap-mcbsp.4",=09"fck",=09=09=09=09&mcbsp4_fck,=09CK_443X),
+=09CLK(NULL,=09"mcpdm_fck",=09=09=09&mcpdm_fck,=09CK_443X),
 =09CLK("omap2_mcspi.1",=09"fck",=09=09=09=09&mcspi1_fck,=09CK_443X),
 =09CLK("omap2_mcspi.2",=09"fck",=09=09=09=09&mcspi2_fck,=09CK_443X),
 =09CLK("omap2_mcspi.3",=09"fck",=09=09=09=09&mcspi3_fck,=09CK_443X),
@@ -2589,30 +2537,37 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK("mmci-omap-hs.2",=09"fck",=09=09=09=09&mmc3_fck,=09CK_443X),
 =09CLK("mmci-omap-hs.3",=09"fck",=09=09=09=09&mmc4_fck,=09CK_443X),
 =09CLK("mmci-omap-hs.4",=09"fck",=09=09=09=09&mmc5_fck,=09CK_443X),
-=09CLK(NULL,=09"ocp_wp1_ick",=09=09=09&ocp_wp1_ick,=09CK_443X),
-=09CLK(NULL,=09"pdm_fck",=09=09=09&pdm_fck,=09CK_443X),
-=09CLK(NULL,=09"pkaeip29_fck",=09=09=09&pkaeip29_fck,=09CK_443X),
+=09CLK(NULL,=09"ocp_wp_noc_ick",=09=09&ocp_wp_noc_ick,=09CK_443X),
 =09CLK("omap_rng",=09"ick",=09=09=09=09&rng_ick,=09CK_443X),
-=09CLK(NULL,=09"sha2md51_fck",=09=09=09&sha2md51_fck,=09CK_443X),
-=09CLK(NULL,=09"sl2_ick",=09=09=09&sl2_ick,=09CK_443X),
+=09CLK(NULL,=09"sha2md5_fck",=09=09=09&sha2md5_fck,=09CK_443X),
+=09CLK(NULL,=09"sl2if_ick",=09=09=09&sl2if_ick,=09CK_443X),
 =09CLK(NULL,=09"slimbus1_fck",=09=09=09&slimbus1_fck,=09CK_443X),
 =09CLK(NULL,=09"slimbus2_fck",=09=09=09&slimbus2_fck,=09CK_443X),
-=09CLK(NULL,=09"sr_core_fck",=09=09=09&sr_core_fck,=09CK_443X),
-=09CLK(NULL,=09"sr_iva_fck",=09=09=09&sr_iva_fck,=09CK_443X),
-=09CLK(NULL,=09"sr_mpu_fck",=09=09=09&sr_mpu_fck,=09CK_443X),
-=09CLK(NULL,=09"tesla_ick",=09=09=09&tesla_ick,=09CK_443X),
+=09CLK(NULL,=09"smartreflex_core_fck",=09=09&smartreflex_core_fck,=09CK_44=
3X),
+=09CLK(NULL,=09"smartreflex_iva_fck",=09=09&smartreflex_iva_fck,=09CK_443X=
),
+=09CLK(NULL,=09"smartreflex_mpu_fck",=09=09&smartreflex_mpu_fck,=09CK_443X=
),
+=09CLK(NULL,=09"gpt1_fck",=09=09=09&timer1_fck,=09CK_443X),
+=09CLK(NULL,=09"gpt10_fck",=09=09=09&timer10_fck,=09CK_443X),
+=09CLK(NULL,=09"gpt11_fck",=09=09=09&timer11_fck,=09CK_443X),
+=09CLK(NULL,=09"gpt2_fck",=09=09=09&timer2_fck,=09CK_443X),
+=09CLK(NULL,=09"gpt3_fck",=09=09=09&timer3_fck,=09CK_443X),
+=09CLK(NULL,=09"gpt4_fck",=09=09=09&timer4_fck,=09CK_443X),
+=09CLK(NULL,=09"gpt5_fck",=09=09=09&timer5_fck,=09CK_443X),
+=09CLK(NULL,=09"gpt6_fck",=09=09=09&timer6_fck,=09CK_443X),
+=09CLK(NULL,=09"gpt7_fck",=09=09=09&timer7_fck,=09CK_443X),
+=09CLK(NULL,=09"gpt8_fck",=09=09=09&timer8_fck,=09CK_443X),
+=09CLK(NULL,=09"gpt9_fck",=09=09=09&timer9_fck,=09CK_443X),
 =09CLK(NULL,=09"uart1_fck",=09=09=09&uart1_fck,=09CK_443X),
 =09CLK(NULL,=09"uart2_fck",=09=09=09&uart2_fck,=09CK_443X),
 =09CLK(NULL,=09"uart3_fck",=09=09=09&uart3_fck,=09CK_443X),
 =09CLK(NULL,=09"uart4_fck",=09=09=09&uart4_fck,=09CK_443X),
-=09CLK(NULL,=09"unipro1_fck",=09=09=09&unipro1_fck,=09CK_443X),
-=09CLK(NULL,=09"usb_host_fck",=09=09=09&usb_host_fck,=09CK_443X),
 =09CLK(NULL,=09"usb_host_fs_fck",=09=09&usb_host_fs_fck,=09CK_443X),
-=09CLK("musb_hdrc",=09"ick",=09=09=09=09&usb_otg_ick,=09CK_443X),
-=09CLK(NULL,=09"usb_tll_ick",=09=09=09&usb_tll_ick,=09CK_443X),
-=09CLK(NULL,=09"usim_ick",=09=09=09&usim_ick,=09CK_443X),
-=09CLK("omap_wdt",=09"fck",=09=09=09=09&wdt2_fck,=09CK_443X),
-=09CLK(NULL,=09"wdt3_fck",=09=09=09&wdt3_fck,=09CK_443X),
+=09CLK(NULL,=09"usb_host_hs_fck",=09=09&usb_host_hs_fck,=09CK_443X),
+=09CLK("musb_hdrc",=09"ick",=09=09=09=09&usb_otg_hs_ick,=09CK_443X),
+=09CLK(NULL,=09"usb_tll_hs_ick",=09=09&usb_tll_hs_ick,=09CK_443X),
+=09CLK(NULL,=09"usim_fck",=09=09=09&usim_fck,=09CK_443X),
+=09CLK("omap_wdt",=09"fck",=09=09=09=09&wd_timer2_fck,=09CK_443X),
+=09CLK(NULL,=09"wd_timer3_fck",=09=09&wd_timer3_fck,=09CK_443X),
 =09CLK(NULL,=09"otg_60m_gfclk_ck",=09=09&otg_60m_gfclk_ck,=09CK_443X),
 =09CLK(NULL,=09"stm_clk_div_ck",=09=09&stm_clk_div_ck,=09CK_443X),
 =09CLK(NULL,=09"trace_clk_div_ck",=09=09&trace_clk_div_ck,=09CK_443X),
@@ -2641,19 +2596,19 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK("i2c_omap.2",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
 =09CLK("i2c_omap.3",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
 =09CLK("i2c_omap.4",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
+=09CLK("mmci-omap-hs.0",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
+=09CLK("mmci-omap-hs.1",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
+=09CLK("mmci-omap-hs.2",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
+=09CLK("mmci-omap-hs.3",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
+=09CLK("mmci-omap-hs.4",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
 =09CLK("omap-mcbsp.1",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
 =09CLK("omap-mcbsp.2",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
 =09CLK("omap-mcbsp.3",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
 =09CLK("omap-mcbsp.4",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
-=09CLK("omap2_mcspi.1",=09"ick",=09=09=09&dummy_ck,=09CK_443X),
-=09CLK("omap2_mcspi.2",=09"ick",=09=09=09&dummy_ck,=09CK_443X),
-=09CLK("omap2_mcspi.3",=09"ick",=09=09=09&dummy_ck,=09CK_443X),
-=09CLK("omap2_mcspi.4",=09"ick",=09=09=09&dummy_ck,=09CK_443X),
-=09CLK("mmci-omap-hs.0",=09"ick",=09=09&dummy_ck,=09CK_443X),
-=09CLK("mmci-omap-hs.1",=09"ick",=09=09&dummy_ck,=09CK_443X),
-=09CLK("mmci-omap-hs.2",=09"ick",=09=09&dummy_ck,=09CK_443X),
-=09CLK("mmci-omap-hs.3",=09"ick",=09=09&dummy_ck,=09CK_443X),
-=09CLK("mmci-omap-hs.4",=09"ick",=09=09&dummy_ck,=09CK_443X),
+=09CLK("omap2_mcspi.1",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
+=09CLK("omap2_mcspi.2",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
+=09CLK("omap2_mcspi.3",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
+=09CLK("omap2_mcspi.4",=09"ick",=09=09=09=09&dummy_ck,=09CK_443X),
 =09CLK(NULL,=09"uart1_ick",=09=09=09&dummy_ck,=09CK_443X),
 =09CLK(NULL,=09"uart2_ick",=09=09=09&dummy_ck,=09CK_443X),
 =09CLK(NULL,=09"uart3_ick",=09=09=09&dummy_ck,=09CK_443X),
--=20
1.7.1

--155748971-122915866-1285140217=:21002--
