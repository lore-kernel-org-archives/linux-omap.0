From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP4: clock/hwmod data: remove MODULEMODE entries in
 mux + gate combos
Date: Mon, 17 Dec 2012 22:41:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212172240101.29833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1446217938-1355784073=:29833"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39750 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701Ab2LQWlO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 17:41:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, mturquette@linaro.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1446217938-1355784073=:29833
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Convert all DEFINE_OMAP_MUX_GATE() combinations that list MODULEMODE
registers in their gate arguments to DEFINE_OMAP_MUX(), dropping the
MODULEMODE data.  This is possible because the MODULEMODE bits control
IP blocks, not clocks; and the hwmod code takes care of IP block
control.  Rename these clocks to reflect the original multiplexer name
as specified in the comments.  And convert the hwmod data to use the
multiplexer clock name.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
---

Seems to boot with omap2plus_defconfig, anyway.

 arch/arm/mach-omap2/cclock44xx_data.c      |  301 +++++++++++-------------=
----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   41 ++--
 2 files changed, 141 insertions(+), 201 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cc=
lock44xx_data.c
index c772ea5..f673138 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -17,10 +17,9 @@
  * is added for discriminating clocks by ES level, these should be added b=
ack
  * in.
  *
- * XXX All of the CLK_OMAP_MUX_GATE entries with MODULEMODE registers shou=
ld
- * be split into separate mux and gate nodes, then the gates should be rem=
oved
- * (handled by hwmod).  Also all of the other remaining MODULEMODE entries
- * should be removed once the drivers are updated to use pm_runtime.
+ * XXX All of the remaining MODULEMODE clock nodes should be removed
+ * once the drivers are updated to use pm_runtime or to use the appropriat=
e
+ * upstream clock node for rate/parent selection.
  */
=20
 #include <linux/kernel.h>
@@ -320,7 +319,7 @@ DEFINE_CLK_DIVIDER(dpll_abe_m2_ck, "dpll_abe_ck", &dpll=
_abe_ck, 0x0,
 =09=09   OMAP4430_CM_DIV_M2_DPLL_ABE, OMAP4430_DPLL_CLKOUT_DIV_SHIFT,
 =09=09   OMAP4430_DPLL_CLKOUT_DIV_WIDTH, CLK_DIVIDER_ONE_BASED, NULL);
=20
-static const struct clk_ops dmic_fck_ops =3D {
+static const struct clk_ops dpll_hsd_ops =3D {
 =09.enable=09=09=3D &omap2_dflt_clk_enable,
 =09.disable=09=3D &omap2_dflt_clk_disable,
 =09.is_enabled=09=3D &omap2_dflt_clk_is_enabled,
@@ -330,6 +329,12 @@ static const struct clk_ops dmic_fck_ops =3D {
 =09.init=09=09=3D &omap2_init_clk_clkdm,
 };
=20
+static const struct clk_ops func_dmic_abe_gfclk_ops =3D {
+=09.recalc_rate=09=3D &omap2_clksel_recalc,
+=09.get_parent=09=3D &omap2_clksel_find_parent_index,
+=09.set_parent=09=3D &omap2_clksel_set_parent,
+};
+
 static const char *dpll_core_m3x2_ck_parents[] =3D {
 =09"dpll_core_x2_ck",
 };
@@ -345,7 +350,7 @@ DEFINE_CLK_OMAP_MUX_GATE(dpll_core_m3x2_ck, NULL, dpll_=
core_m3x2_div,
 =09=09=09 OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
 =09=09=09 OMAP4430_CM_DIV_M3_DPLL_CORE,
 =09=09=09 OMAP4430_DPLL_CLKOUTHIF_GATE_CTRL_SHIFT, NULL,
-=09=09=09 dpll_core_m3x2_ck_parents, dmic_fck_ops);
+=09=09=09 dpll_core_m3x2_ck_parents, dpll_hsd_ops);
=20
 DEFINE_CLK_OMAP_HSDIVIDER(dpll_core_m7x2_ck, "dpll_core_x2_ck",
 =09=09=09  &dpll_core_x2_ck, 0x0, OMAP4430_CM_DIV_M7_DPLL_CORE,
@@ -552,7 +557,7 @@ DEFINE_CLK_OMAP_MUX_GATE(dpll_per_m3x2_ck, NULL, dpll_p=
er_m3x2_div,
 =09=09=09 OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
 =09=09=09 OMAP4430_CM_DIV_M3_DPLL_PER,
 =09=09=09 OMAP4430_DPLL_CLKOUTHIF_GATE_CTRL_SHIFT, NULL,
-=09=09=09 dpll_per_m3x2_ck_parents, dmic_fck_ops);
+=09=09=09 dpll_per_m3x2_ck_parents, dpll_hsd_ops);
=20
 DEFINE_CLK_OMAP_HSDIVIDER(dpll_per_m4x2_ck, "dpll_per_x2_ck", &dpll_per_x2=
_ck,
 =09=09=09  0x0, OMAP4430_CM_DIV_M4_DPLL_PER,
@@ -791,19 +796,13 @@ static const struct clksel func_dmic_abe_gfclk_sel[] =
=3D {
 =09{ .parent =3D NULL },
 };
=20
-static const char *dmic_fck_parents[] =3D {
+static const char *func_dmic_abe_gfclk_parents[] =3D {
 =09"dmic_sync_mux_ck", "pad_clks_ck", "slimbus_clk",
 };
=20
-/* Merged func_dmic_abe_gfclk into dmic */
-static struct clk dmic_fck;
-
-DEFINE_CLK_OMAP_MUX_GATE(dmic_fck, "abe_clkdm", func_dmic_abe_gfclk_sel,
-=09=09=09 OMAP4430_CM1_ABE_DMIC_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_SOURCE_MASK,
-=09=09=09 OMAP4430_CM1_ABE_DMIC_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 dmic_fck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(func_dmic_abe_gfclk, "abe_clkdm", func_dmic_abe_gfclk_=
sel,
+=09=09    OMAP4430_CM1_ABE_DMIC_CLKCTRL, OMAP4430_CLKSEL_SOURCE_MASK,
+=09=09    func_dmic_abe_gfclk_parents, func_dmic_abe_gfclk_ops);
=20
 DEFINE_CLK_GATE(dss_sys_clk, "syc_clk_div_ck", &syc_clk_div_ck, 0x0,
 =09=09OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -859,17 +858,13 @@ static const struct clksel sgx_clk_mux_sel[] =3D {
 =09{ .parent =3D NULL },
 };
=20
-static const char *gpu_fck_parents[] =3D {
+static const char *sgx_clk_mux_parents[] =3D {
 =09"dpll_core_m7x2_ck", "dpll_per_m7x2_ck",
 };
=20
-/* Merged sgx_clk_mux into gpu */
-DEFINE_CLK_OMAP_MUX_GATE(gpu_fck, "l3_gfx_clkdm", sgx_clk_mux_sel,
-=09=09=09 OMAP4430_CM_GFX_GFX_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_SGX_FCLK_MASK,
-=09=09=09 OMAP4430_CM_GFX_GFX_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 gpu_fck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(sgx_clk_mux, "l3_gfx_clkdm", sgx_clk_mux_sel,
+=09=09    OMAP4430_CM_GFX_GFX_CLKCTRL, OMAP4430_CLKSEL_SGX_FCLK_MASK,
+=09=09    sgx_clk_mux_parents, func_dmic_abe_gfclk_ops);
=20
 DEFINE_CLK_DIVIDER(hsi_fck, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck, 0x0,
 =09=09   OMAP4430_CM_L3INIT_HSI_CLKCTRL, OMAP4430_CLKSEL_24_25_SHIFT,
@@ -892,17 +887,13 @@ static const struct clksel func_mcasp_abe_gfclk_sel[]=
 =3D {
 =09{ .parent =3D NULL },
 };
=20
-static const char *mcasp_fck_parents[] =3D {
+static const char *func_mcasp_abe_gfclk_parents[] =3D {
 =09"mcasp_sync_mux_ck", "pad_clks_ck", "slimbus_clk",
 };
=20
-/* Merged func_mcasp_abe_gfclk into mcasp */
-DEFINE_CLK_OMAP_MUX_GATE(mcasp_fck, "abe_clkdm", func_mcasp_abe_gfclk_sel,
-=09=09=09 OMAP4430_CM1_ABE_MCASP_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_SOURCE_MASK,
-=09=09=09 OMAP4430_CM1_ABE_MCASP_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 mcasp_fck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(func_mcasp_abe_gfclk, "abe_clkdm", func_mcasp_abe_gfcl=
k_sel,
+=09=09    OMAP4430_CM1_ABE_MCASP_CLKCTRL, OMAP4430_CLKSEL_SOURCE_MASK,
+=09=09    func_mcasp_abe_gfclk_parents, func_dmic_abe_gfclk_ops);
=20
 DEFINE_CLK_MUX(mcbsp1_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
 =09       OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
@@ -916,17 +907,14 @@ static const struct clksel func_mcbsp1_gfclk_sel[] =
=3D {
 =09{ .parent =3D NULL },
 };
=20
-static const char *mcbsp1_fck_parents[] =3D {
+static const char *func_mcbsp1_gfclk_parents[] =3D {
 =09"mcbsp1_sync_mux_ck", "pad_clks_ck", "slimbus_clk",
 };
=20
-/* Merged func_mcbsp1_gfclk into mcbsp1 */
-DEFINE_CLK_OMAP_MUX_GATE(mcbsp1_fck, "abe_clkdm", func_mcbsp1_gfclk_sel,
-=09=09=09 OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_SOURCE_MASK,
-=09=09=09 OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 mcbsp1_fck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(func_mcbsp1_gfclk, "abe_clkdm", func_mcbsp1_gfclk_sel,
+=09=09    OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
+=09=09    OMAP4430_CLKSEL_SOURCE_MASK, func_mcbsp1_gfclk_parents,
+=09=09    func_dmic_abe_gfclk_ops);
=20
 DEFINE_CLK_MUX(mcbsp2_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
 =09       OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
@@ -940,17 +928,14 @@ static const struct clksel func_mcbsp2_gfclk_sel[] =
=3D {
 =09{ .parent =3D NULL },
 };
=20
-static const char *mcbsp2_fck_parents[] =3D {
+static const char *func_mcbsp2_gfclk_parents[] =3D {
 =09"mcbsp2_sync_mux_ck", "pad_clks_ck", "slimbus_clk",
 };
=20
-/* Merged func_mcbsp2_gfclk into mcbsp2 */
-DEFINE_CLK_OMAP_MUX_GATE(mcbsp2_fck, "abe_clkdm", func_mcbsp2_gfclk_sel,
-=09=09=09 OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_SOURCE_MASK,
-=09=09=09 OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 mcbsp2_fck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(func_mcbsp2_gfclk, "abe_clkdm", func_mcbsp2_gfclk_sel,
+=09=09    OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
+=09=09    OMAP4430_CLKSEL_SOURCE_MASK, func_mcbsp2_gfclk_parents,
+=09=09    func_dmic_abe_gfclk_ops);
=20
 DEFINE_CLK_MUX(mcbsp3_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
 =09       OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
@@ -964,17 +949,14 @@ static const struct clksel func_mcbsp3_gfclk_sel[] =
=3D {
 =09{ .parent =3D NULL },
 };
=20
-static const char *mcbsp3_fck_parents[] =3D {
+static const char *func_mcbsp3_gfclk_parents[] =3D {
 =09"mcbsp3_sync_mux_ck", "pad_clks_ck", "slimbus_clk",
 };
=20
-/* Merged func_mcbsp3_gfclk into mcbsp3 */
-DEFINE_CLK_OMAP_MUX_GATE(mcbsp3_fck, "abe_clkdm", func_mcbsp3_gfclk_sel,
-=09=09=09 OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_SOURCE_MASK,
-=09=09=09 OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 mcbsp3_fck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(func_mcbsp3_gfclk, "abe_clkdm", func_mcbsp3_gfclk_sel,
+=09=09    OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
+=09=09    OMAP4430_CLKSEL_SOURCE_MASK, func_mcbsp3_gfclk_parents,
+=09=09    func_dmic_abe_gfclk_ops);
=20
 static const char *mcbsp4_sync_mux_ck_parents[] =3D {
 =09"func_96m_fclk", "per_abe_nc_fclk",
@@ -991,17 +973,14 @@ static const struct clksel per_mcbsp4_gfclk_sel[] =3D=
 {
 =09{ .parent =3D NULL },
 };
=20
-static const char *mcbsp4_fck_parents[] =3D {
+static const char *per_mcbsp4_gfclk_parents[] =3D {
 =09"mcbsp4_sync_mux_ck", "pad_clks_ck",
 };
=20
-/* Merged per_mcbsp4_gfclk into mcbsp4 */
-DEFINE_CLK_OMAP_MUX_GATE(mcbsp4_fck, "l4_per_clkdm", per_mcbsp4_gfclk_sel,
-=09=09=09 OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_SOURCE_24_24_MASK,
-=09=09=09 OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 mcbsp4_fck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(per_mcbsp4_gfclk, "l4_per_clkdm", per_mcbsp4_gfclk_sel=
,
+=09=09    OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
+=09=09    OMAP4430_CLKSEL_SOURCE_24_24_MASK, per_mcbsp4_gfclk_parents,
+=09=09    func_dmic_abe_gfclk_ops);
=20
 static const struct clksel hsmmc1_fclk_sel[] =3D {
 =09{ .parent =3D &func_64m_fclk, .rates =3D div_1_0_rates },
@@ -1009,23 +988,17 @@ static const struct clksel hsmmc1_fclk_sel[] =3D {
 =09{ .parent =3D NULL },
 };
=20
-static const char *mmc1_fck_parents[] =3D {
+static const char *hsmmc1_fclk_parents[] =3D {
 =09"func_64m_fclk", "func_96m_fclk",
 };
=20
-/* Merged hsmmc1_fclk into mmc1 */
-DEFINE_CLK_OMAP_MUX_GATE(mmc1_fck, "l3_init_clkdm", hsmmc1_fclk_sel,
-=09=09=09 OMAP4430_CM_L3INIT_MMC1_CLKCTRL, OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 mmc1_fck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(hsmmc1_fclk, "l3_init_clkdm", hsmmc1_fclk_sel,
+=09=09    OMAP4430_CM_L3INIT_MMC1_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    hsmmc1_fclk_parents, func_dmic_abe_gfclk_ops);
=20
-/* Merged hsmmc2_fclk into mmc2 */
-DEFINE_CLK_OMAP_MUX_GATE(mmc2_fck, "l3_init_clkdm", hsmmc1_fclk_sel,
-=09=09=09 OMAP4430_CM_L3INIT_MMC2_CLKCTRL, OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM_L3INIT_MMC2_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 mmc1_fck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(hsmmc2_fclk, "l3_init_clkdm", hsmmc1_fclk_sel,
+=09=09    OMAP4430_CM_L3INIT_MMC2_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    hsmmc1_fclk_parents, func_dmic_abe_gfclk_ops);
=20
 DEFINE_CLK_GATE(sha2md5_fck, "l3_div_ck", &l3_div_ck, 0x0,
 =09=09OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
@@ -1078,52 +1051,35 @@ static const struct clksel dmt1_clk_mux_sel[] =3D {
 =09{ .parent =3D NULL },
 };
=20
-/* Merged dmt1_clk_mux into timer1 */
-DEFINE_CLK_OMAP_MUX_GATE(timer1_fck, "l4_wkup_clkdm", dmt1_clk_mux_sel,
-=09=09=09 OMAP4430_CM_WKUP_TIMER1_CLKCTRL, OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 abe_dpll_bypass_clk_mux_ck_parents, dmic_fck_ops);
-
-/* Merged cm2_dm10_mux into timer10 */
-DEFINE_CLK_OMAP_MUX_GATE(timer10_fck, "l4_per_clkdm", dmt1_clk_mux_sel,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 abe_dpll_bypass_clk_mux_ck_parents, dmic_fck_ops);
-
-/* Merged cm2_dm11_mux into timer11 */
-DEFINE_CLK_OMAP_MUX_GATE(timer11_fck, "l4_per_clkdm", dmt1_clk_mux_sel,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 abe_dpll_bypass_clk_mux_ck_parents, dmic_fck_ops);
-
-/* Merged cm2_dm2_mux into timer2 */
-DEFINE_CLK_OMAP_MUX_GATE(timer2_fck, "l4_per_clkdm", dmt1_clk_mux_sel,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 abe_dpll_bypass_clk_mux_ck_parents, dmic_fck_ops);
-
-/* Merged cm2_dm3_mux into timer3 */
-DEFINE_CLK_OMAP_MUX_GATE(timer3_fck, "l4_per_clkdm", dmt1_clk_mux_sel,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 abe_dpll_bypass_clk_mux_ck_parents, dmic_fck_ops);
-
-/* Merged cm2_dm4_mux into timer4 */
-DEFINE_CLK_OMAP_MUX_GATE(timer4_fck, "l4_per_clkdm", dmt1_clk_mux_sel,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 abe_dpll_bypass_clk_mux_ck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(dmt1_clk_mux, "l4_wkup_clkdm", dmt1_clk_mux_sel,
+=09=09    OMAP4430_CM_WKUP_TIMER1_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    abe_dpll_bypass_clk_mux_ck_parents,
+=09=09    func_dmic_abe_gfclk_ops);
+
+DEFINE_CLK_OMAP_MUX(cm2_dm10_mux, "l4_per_clkdm", dmt1_clk_mux_sel,
+=09=09    OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    abe_dpll_bypass_clk_mux_ck_parents,
+=09=09    func_dmic_abe_gfclk_ops);
+
+DEFINE_CLK_OMAP_MUX(cm2_dm11_mux, "l4_per_clkdm", dmt1_clk_mux_sel,
+=09=09    OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    abe_dpll_bypass_clk_mux_ck_parents,
+=09=09    func_dmic_abe_gfclk_ops);
+
+DEFINE_CLK_OMAP_MUX(cm2_dm2_mux, "l4_per_clkdm", dmt1_clk_mux_sel,
+=09=09    OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    abe_dpll_bypass_clk_mux_ck_parents,
+=09=09    func_dmic_abe_gfclk_ops);
+
+DEFINE_CLK_OMAP_MUX(cm2_dm3_mux, "l4_per_clkdm", dmt1_clk_mux_sel,
+=09=09    OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    abe_dpll_bypass_clk_mux_ck_parents,
+=09=09    func_dmic_abe_gfclk_ops);
+
+DEFINE_CLK_OMAP_MUX(cm2_dm4_mux, "l4_per_clkdm", dmt1_clk_mux_sel,
+=09=09    OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    abe_dpll_bypass_clk_mux_ck_parents,
+=09=09    func_dmic_abe_gfclk_ops);
=20
 static const struct clksel timer5_sync_mux_sel[] =3D {
 =09{ .parent =3D &syc_clk_div_ck, .rates =3D div_1_0_rates },
@@ -1131,45 +1087,30 @@ static const struct clksel timer5_sync_mux_sel[] =
=3D {
 =09{ .parent =3D NULL },
 };
=20
-static const char *timer5_fck_parents[] =3D {
+static const char *timer5_sync_mux_parents[] =3D {
 =09"syc_clk_div_ck", "sys_32k_ck",
 };
=20
-/* Merged timer5_sync_mux into timer5 */
-DEFINE_CLK_OMAP_MUX_GATE(timer5_fck, "abe_clkdm", timer5_sync_mux_sel,
-=09=09=09 OMAP4430_CM1_ABE_TIMER5_CLKCTRL, OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 timer5_fck_parents, dmic_fck_ops);
-
-/* Merged timer6_sync_mux into timer6 */
-DEFINE_CLK_OMAP_MUX_GATE(timer6_fck, "abe_clkdm", timer5_sync_mux_sel,
-=09=09=09 OMAP4430_CM1_ABE_TIMER6_CLKCTRL, OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 timer5_fck_parents, dmic_fck_ops);
-
-/* Merged timer7_sync_mux into timer7 */
-DEFINE_CLK_OMAP_MUX_GATE(timer7_fck, "abe_clkdm", timer5_sync_mux_sel,
-=09=09=09 OMAP4430_CM1_ABE_TIMER7_CLKCTRL, OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 timer5_fck_parents, dmic_fck_ops);
-
-/* Merged timer8_sync_mux into timer8 */
-DEFINE_CLK_OMAP_MUX_GATE(timer8_fck, "abe_clkdm", timer5_sync_mux_sel,
-=09=09=09 OMAP4430_CM1_ABE_TIMER8_CLKCTRL, OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 timer5_fck_parents, dmic_fck_ops);
-
-/* Merged cm2_dm9_mux into timer9 */
-DEFINE_CLK_OMAP_MUX_GATE(timer9_fck, "l4_per_clkdm", dmt1_clk_mux_sel,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
-=09=09=09 OMAP4430_CLKSEL_MASK,
-=09=09=09 OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
-=09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
-=09=09=09 abe_dpll_bypass_clk_mux_ck_parents, dmic_fck_ops);
+DEFINE_CLK_OMAP_MUX(timer5_sync_mux, "abe_clkdm", timer5_sync_mux_sel,
+=09=09    OMAP4430_CM1_ABE_TIMER5_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    timer5_sync_mux_parents, func_dmic_abe_gfclk_ops);
+
+DEFINE_CLK_OMAP_MUX(timer6_sync_mux, "abe_clkdm", timer5_sync_mux_sel,
+=09=09    OMAP4430_CM1_ABE_TIMER6_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    timer5_sync_mux_parents, func_dmic_abe_gfclk_ops);
+
+DEFINE_CLK_OMAP_MUX(timer7_sync_mux, "abe_clkdm", timer5_sync_mux_sel,
+=09=09    OMAP4430_CM1_ABE_TIMER7_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    timer5_sync_mux_parents, func_dmic_abe_gfclk_ops);
+
+DEFINE_CLK_OMAP_MUX(timer8_sync_mux, "abe_clkdm", timer5_sync_mux_sel,
+=09=09    OMAP4430_CM1_ABE_TIMER8_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    timer5_sync_mux_parents, func_dmic_abe_gfclk_ops);
+
+DEFINE_CLK_OMAP_MUX(cm2_dm9_mux, "l4_per_clkdm", dmt1_clk_mux_sel,
+=09=09    OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL, OMAP4430_CLKSEL_MASK,
+=09=09    abe_dpll_bypass_clk_mux_ck_parents,
+=09=09    func_dmic_abe_gfclk_ops);
=20
 static struct clk usb_host_fs_fck;
=20
@@ -1557,7 +1498,7 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"div_ts_ck",=09=09=09&div_ts_ck,=09CK_446X),
 =09CLK(NULL,=09"bandgap_ts_fclk",=09=09&bandgap_ts_fclk,=09CK_446X),
 =09CLK(NULL,=09"dmic_sync_mux_ck",=09=09&dmic_sync_mux_ck,=09CK_443X),
-=09CLK(NULL,=09"dmic_fck",=09=09=09&dmic_fck,=09CK_443X),
+=09CLK(NULL,=09"func_dmic_abe_gfclk",=09=09=09&func_dmic_abe_gfclk,=09CK_4=
43X),
 =09CLK(NULL,=09"dss_sys_clk",=09=09=09&dss_sys_clk,=09CK_443X),
 =09CLK(NULL,=09"dss_tv_clk",=09=09=09&dss_tv_clk,=09CK_443X),
 =09CLK(NULL,=09"dss_dss_clk",=09=09=09&dss_dss_clk,=09CK_443X),
@@ -1571,21 +1512,21 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"gpio4_dbclk",=09=09=09&gpio4_dbclk,=09CK_443X),
 =09CLK(NULL,=09"gpio5_dbclk",=09=09=09&gpio5_dbclk,=09CK_443X),
 =09CLK(NULL,=09"gpio6_dbclk",=09=09=09&gpio6_dbclk,=09CK_443X),
-=09CLK(NULL,=09"gpu_fck",=09=09=09&gpu_fck,=09CK_443X),
+=09CLK(NULL,=09"sgx_clk_mux",=09=09=09&sgx_clk_mux,=09CK_443X),
 =09CLK(NULL,=09"hsi_fck",=09=09=09&hsi_fck,=09CK_443X),
 =09CLK(NULL,=09"iss_ctrlclk",=09=09=09&iss_ctrlclk,=09CK_443X),
 =09CLK(NULL,=09"mcasp_sync_mux_ck",=09=09&mcasp_sync_mux_ck,=09CK_443X),
-=09CLK(NULL,=09"mcasp_fck",=09=09=09&mcasp_fck,=09CK_443X),
+=09CLK(NULL,=09"func_mcasp_abe_gfclk",=09=09=09&func_mcasp_abe_gfclk,=09CK=
_443X),
 =09CLK(NULL,=09"mcbsp1_sync_mux_ck",=09=09&mcbsp1_sync_mux_ck,=09CK_443X),
-=09CLK(NULL,=09"mcbsp1_fck",=09=09=09&mcbsp1_fck,=09CK_443X),
+=09CLK(NULL,=09"func_mcbsp1_gfclk",=09=09=09&func_mcbsp1_gfclk,=09CK_443X)=
,
 =09CLK(NULL,=09"mcbsp2_sync_mux_ck",=09=09&mcbsp2_sync_mux_ck,=09CK_443X),
-=09CLK(NULL,=09"mcbsp2_fck",=09=09=09&mcbsp2_fck,=09CK_443X),
+=09CLK(NULL,=09"func_mcbsp2_gfclk",=09=09=09&func_mcbsp2_gfclk,=09CK_443X)=
,
 =09CLK(NULL,=09"mcbsp3_sync_mux_ck",=09=09&mcbsp3_sync_mux_ck,=09CK_443X),
-=09CLK(NULL,=09"mcbsp3_fck",=09=09=09&mcbsp3_fck,=09CK_443X),
+=09CLK(NULL,=09"func_mcbsp3_gfclk",=09=09=09&func_mcbsp3_gfclk,=09CK_443X)=
,
 =09CLK(NULL,=09"mcbsp4_sync_mux_ck",=09=09&mcbsp4_sync_mux_ck,=09CK_443X),
-=09CLK(NULL,=09"mcbsp4_fck",=09=09=09&mcbsp4_fck,=09CK_443X),
-=09CLK(NULL,=09"mmc1_fck",=09=09=09&mmc1_fck,=09CK_443X),
-=09CLK(NULL,=09"mmc2_fck",=09=09=09&mmc2_fck,=09CK_443X),
+=09CLK(NULL,=09"per_mcbsp4_gfclk",=09=09=09&per_mcbsp4_gfclk,=09CK_443X),
+=09CLK(NULL,=09"hsmmc1_fclk",=09=09=09&hsmmc1_fclk,=09CK_443X),
+=09CLK(NULL,=09"hsmmc2_fclk",=09=09=09&hsmmc2_fclk,=09CK_443X),
 =09CLK(NULL,=09"sha2md5_fck",=09=09=09&sha2md5_fck,=09CK_443X),
 =09CLK(NULL,=09"slimbus1_fclk_1",=09=09&slimbus1_fclk_1,=09CK_443X),
 =09CLK(NULL,=09"slimbus1_fclk_0",=09=09&slimbus1_fclk_0,=09CK_443X),
@@ -1597,17 +1538,17 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"smartreflex_core_fck",=09=09&smartreflex_core_fck,=09CK_44=
3X),
 =09CLK(NULL,=09"smartreflex_iva_fck",=09=09&smartreflex_iva_fck,=09CK_443X=
),
 =09CLK(NULL,=09"smartreflex_mpu_fck",=09=09&smartreflex_mpu_fck,=09CK_443X=
),
-=09CLK(NULL,=09"timer1_fck",=09=09=09&timer1_fck,=09CK_443X),
-=09CLK(NULL,=09"timer10_fck",=09=09=09&timer10_fck,=09CK_443X),
-=09CLK(NULL,=09"timer11_fck",=09=09=09&timer11_fck,=09CK_443X),
-=09CLK(NULL,=09"timer2_fck",=09=09=09&timer2_fck,=09CK_443X),
-=09CLK(NULL,=09"timer3_fck",=09=09=09&timer3_fck,=09CK_443X),
-=09CLK(NULL,=09"timer4_fck",=09=09=09&timer4_fck,=09CK_443X),
-=09CLK(NULL,=09"timer5_fck",=09=09=09&timer5_fck,=09CK_443X),
-=09CLK(NULL,=09"timer6_fck",=09=09=09&timer6_fck,=09CK_443X),
-=09CLK(NULL,=09"timer7_fck",=09=09=09&timer7_fck,=09CK_443X),
-=09CLK(NULL,=09"timer8_fck",=09=09=09&timer8_fck,=09CK_443X),
-=09CLK(NULL,=09"timer9_fck",=09=09=09&timer9_fck,=09CK_443X),
+=09CLK(NULL,=09"dmt1_clk_mux",=09=09=09&dmt1_clk_mux,=09CK_443X),
+=09CLK(NULL,=09"cm2_dm10_mux",=09=09=09&cm2_dm10_mux,=09CK_443X),
+=09CLK(NULL,=09"cm2_dm11_mux",=09=09=09&cm2_dm11_mux,=09CK_443X),
+=09CLK(NULL,=09"cm2_dm2_mux",=09=09=09&cm2_dm2_mux,=09CK_443X),
+=09CLK(NULL,=09"cm2_dm3_mux",=09=09=09&cm2_dm3_mux,=09CK_443X),
+=09CLK(NULL,=09"cm2_dm4_mux",=09=09=09&cm2_dm4_mux,=09CK_443X),
+=09CLK(NULL,=09"timer5_sync_mux",=09=09&timer5_sync_mux,=09CK_443X),
+=09CLK(NULL,=09"timer6_sync_mux",=09=09=09&timer6_sync_mux,=09CK_443X),
+=09CLK(NULL,=09"timer7_sync_mux",=09=09=09&timer7_sync_mux,=09CK_443X),
+=09CLK(NULL,=09"timer8_sync_mux",=09=09=09&timer8_sync_mux,=09CK_443X),
+=09CLK(NULL,=09"cm2_dm9_mux",=09=09=09&cm2_dm9_mux,=09CK_443X),
 =09CLK(NULL,=09"usb_host_fs_fck",=09=09&usb_host_fs_fck,=09CK_443X),
 =09CLK("usbhs_omap",=09"fs_fck",=09=09&usb_host_fs_fck,=09CK_443X),
 =09CLK(NULL,=09"utmi_p1_gfclk",=09=09&utmi_p1_gfclk,=09CK_443X),
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index 0b59ddb..5df8367 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -617,7 +617,7 @@ static struct omap_hwmod omap44xx_dmic_hwmod =3D {
 =09.clkdm_name=09=3D "abe_clkdm",
 =09.mpu_irqs=09=3D omap44xx_dmic_irqs,
 =09.sdma_reqs=09=3D omap44xx_dmic_sdma_reqs,
-=09.main_clk=09=3D "dmic_fck",
+=09.main_clk=09=3D "func_dmic_abe_gfclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET,
@@ -1406,7 +1406,7 @@ static struct omap_hwmod omap44xx_gpu_hwmod =3D {
 =09.class=09=09=3D &omap44xx_gpu_hwmod_class,
 =09.clkdm_name=09=3D "l3_gfx_clkdm",
 =09.mpu_irqs=09=3D omap44xx_gpu_irqs,
-=09.main_clk=09=3D "gpu_fck",
+=09.main_clk=09=3D "sgx_clk_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_GFX_GFX_CLKCTRL_OFFSET,
@@ -1922,7 +1922,7 @@ static struct omap_hwmod omap44xx_mcasp_hwmod =3D {
 =09.clkdm_name=09=3D "abe_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mcasp_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcasp_sdma_reqs,
-=09.main_clk=09=3D "mcasp_fck",
+=09.main_clk=09=3D "func_mcasp_abe_gfclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_MCASP_CLKCTRL_OFFSET,
@@ -1974,7 +1974,7 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod =3D {
 =09.clkdm_name=09=3D "abe_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mcbsp1_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcbsp1_sdma_reqs,
-=09.main_clk=09=3D "mcbsp1_fck",
+=09.main_clk=09=3D "func_mcbsp1_gfclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET,
@@ -2009,7 +2009,7 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod =3D {
 =09.clkdm_name=09=3D "abe_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mcbsp2_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcbsp2_sdma_reqs,
-=09.main_clk=09=3D "mcbsp2_fck",
+=09.main_clk=09=3D "func_mcbsp2_gfclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET,
@@ -2044,7 +2044,7 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod =3D {
 =09.clkdm_name=09=3D "abe_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mcbsp3_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcbsp3_sdma_reqs,
-=09.main_clk=09=3D "mcbsp3_fck",
+=09.main_clk=09=3D "func_mcbsp3_gfclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET,
@@ -2079,7 +2079,7 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mcbsp4_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcbsp4_sdma_reqs,
-=09.main_clk=09=3D "mcbsp4_fck",
+=09.main_clk=09=3D "per_mcbsp4_gfclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_MCBSP4_CLKCTRL_OFFSET,
@@ -2361,7 +2361,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod =3D {
 =09.clkdm_name=09=3D "l3_init_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mmc1_irqs,
 =09.sdma_reqs=09=3D omap44xx_mmc1_sdma_reqs,
-=09.main_clk=09=3D "mmc1_fck",
+=09.main_clk=09=3D "hsmmc1_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
@@ -2390,7 +2390,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod =3D {
 =09.clkdm_name=09=3D "l3_init_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mmc2_irqs,
 =09.sdma_reqs=09=3D omap44xx_mmc2_sdma_reqs,
-=09.main_clk=09=3D "mmc2_fck",
+=09.main_clk=09=3D "hsmmc2_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
@@ -3160,7 +3160,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod =3D {
 =09.clkdm_name=09=3D "l4_wkup_clkdm",
 =09.flags=09=09=3D HWMOD_SET_DEFAULT_CLOCKACT,
 =09.mpu_irqs=09=3D omap44xx_timer1_irqs,
-=09.main_clk=09=3D "timer1_fck",
+=09.main_clk=09=3D "dmt1_clk_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
@@ -3183,7 +3183,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.flags=09=09=3D HWMOD_SET_DEFAULT_CLOCKACT,
 =09.mpu_irqs=09=3D omap44xx_timer2_irqs,
-=09.main_clk=09=3D "timer2_fck",
+=09.main_clk=09=3D "cm2_dm2_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_DMTIMER2_CLKCTRL_OFFSET,
@@ -3204,7 +3204,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod =3D {
 =09.class=09=09=3D &omap44xx_timer_hwmod_class,
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_timer3_irqs,
-=09.main_clk=09=3D "timer3_fck",
+=09.main_clk=09=3D "cm2_dm3_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_DMTIMER3_CLKCTRL_OFFSET,
@@ -3225,7 +3225,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod =3D {
 =09.class=09=09=3D &omap44xx_timer_hwmod_class,
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_timer4_irqs,
-=09.main_clk=09=3D "timer4_fck",
+=09.main_clk=09=3D "cm2_dm4_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_DMTIMER4_CLKCTRL_OFFSET,
@@ -3246,7 +3246,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod =3D {
 =09.class=09=09=3D &omap44xx_timer_hwmod_class,
 =09.clkdm_name=09=3D "abe_clkdm",
 =09.mpu_irqs=09=3D omap44xx_timer5_irqs,
-=09.main_clk=09=3D "timer5_fck",
+=09.main_clk=09=3D "timer5_sync_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET,
@@ -3268,8 +3268,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod =3D {
 =09.class=09=09=3D &omap44xx_timer_hwmod_class,
 =09.clkdm_name=09=3D "abe_clkdm",
 =09.mpu_irqs=09=3D omap44xx_timer6_irqs,
-
-=09.main_clk=09=3D "timer6_fck",
+=09.main_clk=09=3D "timer6_sync_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET,
@@ -3291,7 +3290,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod =3D {
 =09.class=09=09=3D &omap44xx_timer_hwmod_class,
 =09.clkdm_name=09=3D "abe_clkdm",
 =09.mpu_irqs=09=3D omap44xx_timer7_irqs,
-=09.main_clk=09=3D "timer7_fck",
+=09.main_clk=09=3D "timer7_sync_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET,
@@ -3313,7 +3312,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod =3D {
 =09.class=09=09=3D &omap44xx_timer_hwmod_class,
 =09.clkdm_name=09=3D "abe_clkdm",
 =09.mpu_irqs=09=3D omap44xx_timer8_irqs,
-=09.main_clk=09=3D "timer8_fck",
+=09.main_clk=09=3D "timer8_sync_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET,
@@ -3335,7 +3334,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod =3D {
 =09.class=09=09=3D &omap44xx_timer_hwmod_class,
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_timer9_irqs,
-=09.main_clk=09=3D "timer9_fck",
+=09.main_clk=09=3D "cm2_dm9_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_DMTIMER9_CLKCTRL_OFFSET,
@@ -3358,7 +3357,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.flags=09=09=3D HWMOD_SET_DEFAULT_CLOCKACT,
 =09.mpu_irqs=09=3D omap44xx_timer10_irqs,
-=09.main_clk=09=3D "timer10_fck",
+=09.main_clk=09=3D "cm2_dm10_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_DMTIMER10_CLKCTRL_OFFSET,
@@ -3380,7 +3379,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod =3D {
 =09.class=09=09=3D &omap44xx_timer_hwmod_class,
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_timer11_irqs,
-=09.main_clk=09=3D "timer11_fck",
+=09.main_clk=09=3D "cm2_dm11_mux",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_DMTIMER11_CLKCTRL_OFFSET,
--=20
1.7.10.4

--843723315-1446217938-1355784073=:29833--
