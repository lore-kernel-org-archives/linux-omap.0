From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP4: clock/hwmod data: start to remove some IP block
 control "clocks"
Date: Mon, 17 Dec 2012 20:40:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212172039200.29833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1972203429-1355776810=:29833"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39363 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab2LQUkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 15:40:47 -0500
Content-ID: <alpine.DEB.2.00.1212172040201.29833@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b-cousson@ti.com, rogerq@ti.com, t-kristo@ti.com, mturquette@linaro.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1972203429-1355776810=:29833
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1212172040202.29833@utopia.booyaka.com>


Remove some leaf "clocks" that are actually IP block idle control
points, since these should now be handled by the hwmod code.

There are still a few types of MODULEMODE clocks that need to be
cleaned up:

- those still in use by driver or integration code

- those in DEFINE_CLK_OMAP_MUX_GATE() blocks; the gate portion of
  these should be removed

A similar process may also be possible on OMAP2/3.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
---

It boots with omap2plus_defconfig, at least.

 arch/arm/mach-omap2/cclock44xx_data.c      |  291 +-----------------------=
----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   62 +++---
 2 files changed, 36 insertions(+), 317 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cc=
lock44xx_data.c
index 5789a5e..c772ea5 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -16,6 +16,11 @@
  * XXX Some of the ES1 clocks have been removed/changed; once support
  * is added for discriminating clocks by ES level, these should be added b=
ack
  * in.
+ *
+ * XXX All of the CLK_OMAP_MUX_GATE entries with MODULEMODE registers shou=
ld
+ * be split into separate mux and gate nodes, then the gates should be rem=
oved
+ * (handled by hwmod).  Also all of the other remaining MODULEMODE entries
+ * should be removed once the drivers are updated to use pm_runtime.
  */
=20
 #include <linux/kernel.h>
@@ -749,10 +754,6 @@ DEFINE_CLK_GATE(aes2_fck, "l3_div_ck", &l3_div_ck, 0x0=
,
 =09=09OMAP4430_CM_L4SEC_AES2_CLKCTRL,
 =09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
=20
-DEFINE_CLK_GATE(aess_fck, "aess_fclk", &aess_fclk, 0x0,
-=09=09OMAP4430_CM1_ABE_AESS_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
-=09=090x0, NULL);
-
 DEFINE_CLK_GATE(bandgap_fclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 =09=09OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
 =09=09OMAP4430_OPTFCLKEN_BGAP_32K_SHIFT, 0x0, NULL);
@@ -774,11 +775,6 @@ DEFINE_CLK_GATE(bandgap_ts_fclk, "div_ts_ck", &div_ts_=
ck, 0x0,
 =09=09OMAP4460_OPTFCLKEN_TS_FCLK_SHIFT,
 =09=090x0, NULL);
=20
-DEFINE_CLK_GATE(des3des_fck, "l4_div_ck", &l4_div_ck, 0x0,
-=09=09OMAP4430_CM_L4SEC_DES3DES_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT,
-=09=090x0, NULL);
-
 static const char *dmic_sync_mux_ck_parents[] =3D {
 =09"abe_24m_fclk", "syc_clk_div_ck", "func_24m_clk",
 };
@@ -809,10 +805,6 @@ DEFINE_CLK_OMAP_MUX_GATE(dmic_fck, "abe_clkdm", func_d=
mic_abe_gfclk_sel,
 =09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 =09=09=09 dmic_fck_parents, dmic_fck_ops);
=20
-DEFINE_CLK_GATE(dsp_fck, "dpll_iva_m4x2_ck", &dpll_iva_m4x2_ck, 0x0,
-=09=09OMAP4430_CM_TESLA_TESLA_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_GATE(dss_sys_clk, "syc_clk_div_ck", &syc_clk_div_ck, 0x0,
 =09=09OMAP4430_CM_DSS_DSS_CLKCTRL,
 =09=09OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT, 0x0, NULL);
@@ -833,78 +825,34 @@ DEFINE_CLK_GATE(dss_fck, "l3_div_ck", &l3_div_ck, 0x0=
,
 =09=09OMAP4430_CM_DSS_DSS_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
 =09=090x0, NULL);
=20
-DEFINE_CLK_GATE(efuse_ctrl_cust_fck, "sys_clkin_ck", &sys_clkin_ck, 0x0,
-=09=09OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(emif1_fck, "ddrphy_ck", &ddrphy_ck, 0x0,
-=09=09OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(emif2_fck, "ddrphy_ck", &ddrphy_ck, 0x0,
-=09=09OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_DIVIDER(fdif_fck, "dpll_per_m4x2_ck", &dpll_per_m4x2_ck, 0x0,
 =09=09   OMAP4430_CM_CAM_FDIF_CLKCTRL, OMAP4430_CLKSEL_FCLK_SHIFT,
 =09=09   OMAP4430_CLKSEL_FCLK_WIDTH, CLK_DIVIDER_POWER_OF_TWO, NULL);
=20
-DEFINE_CLK_GATE(fpka_fck, "l4_div_ck", &l4_div_ck, 0x0,
-=09=09OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_GATE(gpio1_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 =09=09OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
 =09=09OMAP4430_OPTFCLKEN_DBCLK_SHIFT,=090x0, NULL);
=20
-DEFINE_CLK_GATE(gpio1_ick, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck, 0x0,
-=09=09OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_GATE(gpio2_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 =09=09OMAP4430_CM_L4PER_GPIO2_CLKCTRL, OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
 =09=090x0, NULL);
=20
-DEFINE_CLK_GATE(gpio2_ick, "l4_div_ck", &l4_div_ck, 0x0,
-=09=09OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_GATE(gpio3_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 =09=09OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
 =09=09OMAP4430_OPTFCLKEN_DBCLK_SHIFT, 0x0, NULL);
=20
-DEFINE_CLK_GATE(gpio3_ick, "l4_div_ck", &l4_div_ck, 0x0,
-=09=09OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_GATE(gpio4_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 =09=09OMAP4430_CM_L4PER_GPIO4_CLKCTRL, OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
 =09=090x0, NULL);
=20
-DEFINE_CLK_GATE(gpio4_ick, "l4_div_ck", &l4_div_ck, 0x0,
-=09=09OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_GATE(gpio5_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 =09=09OMAP4430_CM_L4PER_GPIO5_CLKCTRL, OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
 =09=090x0, NULL);
=20
-DEFINE_CLK_GATE(gpio5_ick, "l4_div_ck", &l4_div_ck, 0x0,
-=09=09OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_GATE(gpio6_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 =09=09OMAP4430_CM_L4PER_GPIO6_CLKCTRL, OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
 =09=090x0, NULL);
=20
-DEFINE_CLK_GATE(gpio6_ick, "l4_div_ck", &l4_div_ck, 0x0,
-=09=09OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(gpmc_ick, "l3_div_ck", &l3_div_ck, 0x0,
-=09=09OMAP4430_CM_L3_2_GPMC_CLKCTRL, OMAP4430_MODULEMODE_HWCTRL_SHIFT,
-=09=090x0, NULL);
-
 static const struct clksel sgx_clk_mux_sel[] =3D {
 =09{ .parent =3D &dpll_core_m7x2_ck, .rates =3D div_1_0_rates },
 =09{ .parent =3D &dpll_per_m7x2_ck, .rates =3D div_1_1_rates },
@@ -923,87 +871,15 @@ DEFINE_CLK_OMAP_MUX_GATE(gpu_fck, "l3_gfx_clkdm", sgx=
_clk_mux_sel,
 =09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 =09=09=09 gpu_fck_parents, dmic_fck_ops);
=20
-DEFINE_CLK_GATE(hdq1w_fck, "func_12m_fclk", &func_12m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_HDQ1W_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_DIVIDER(hsi_fck, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck, 0x0,
 =09=09   OMAP4430_CM_L3INIT_HSI_CLKCTRL, OMAP4430_CLKSEL_24_25_SHIFT,
 =09=09   OMAP4430_CLKSEL_24_25_WIDTH, CLK_DIVIDER_POWER_OF_TWO,
 =09=09   NULL);
=20
-DEFINE_CLK_GATE(i2c1_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_I2C1_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(i2c2_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_I2C2_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(i2c3_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_I2C3_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(i2c4_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_I2C4_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(ipu_fck, "ducati_clk_mux_ck", &ducati_clk_mux_ck, 0x0,
-=09=09OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_GATE(iss_ctrlclk, "func_96m_fclk", &func_96m_fclk, 0x0,
 =09=09OMAP4430_CM_CAM_ISS_CLKCTRL, OMAP4430_OPTFCLKEN_CTRLCLK_SHIFT,
 =09=090x0, NULL);
=20
-DEFINE_CLK_GATE(iss_fck, "ducati_clk_mux_ck", &ducati_clk_mux_ck, 0x0,
-=09=09OMAP4430_CM_CAM_ISS_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
-=09=090x0, NULL);
-
-DEFINE_CLK_GATE(iva_fck, "dpll_iva_m5x2_ck", &dpll_iva_m5x2_ck, 0x0,
-=09=09OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(kbd_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
-=09=09OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-static struct clk l3_instr_ick;
-
-static const char *l3_instr_ick_parent_names[] =3D {
-=09"l3_div_ck",
-};
-
-static const struct clk_ops l3_instr_ick_ops =3D {
-=09.enable=09=09=3D &omap2_dflt_clk_enable,
-=09.disable=09=3D &omap2_dflt_clk_disable,
-=09.is_enabled=09=3D &omap2_dflt_clk_is_enabled,
-=09.init=09=09=3D &omap2_init_clk_clkdm,
-};
-
-static struct clk_hw_omap l3_instr_ick_hw =3D {
-=09.hw =3D {
-=09=09.clk =3D &l3_instr_ick,
-=09},
-=09.enable_reg=09=3D OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL_SHIFT,
-=09.clkdm_name=09=3D "l3_instr_clkdm",
-};
-
-DEFINE_STRUCT_CLK(l3_instr_ick, l3_instr_ick_parent_names, l3_instr_ick_op=
s);
-
-static struct clk l3_main_3_ick;
-static struct clk_hw_omap l3_main_3_ick_hw =3D {
-=09.hw =3D {
-=09=09.clk =3D &l3_main_3_ick,
-=09},
-=09.enable_reg=09=3D OMAP4430_CM_L3INSTR_L3_3_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL_SHIFT,
-=09.clkdm_name=09=3D "l3_instr_clkdm",
-};
-
-DEFINE_STRUCT_CLK(l3_main_3_ick, l3_instr_ick_parent_names, l3_instr_ick_o=
ps);
-
 DEFINE_CLK_MUX(mcasp_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
 =09       OMAP4430_CM1_ABE_MCASP_CLKCTRL,
 =09       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
@@ -1127,26 +1003,6 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp4_fck, "l4_per_clkdm",=
 per_mcbsp4_gfclk_sel,
 =09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 =09=09=09 mcbsp4_fck_parents, dmic_fck_ops);
=20
-DEFINE_CLK_GATE(mcpdm_fck, "pad_clks_ck", &pad_clks_ck, 0x0,
-=09=09OMAP4430_CM1_ABE_PDM_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
-=09=090x0, NULL);
-
-DEFINE_CLK_GATE(mcspi1_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(mcspi2_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(mcspi3_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(mcspi4_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
 static const struct clksel hsmmc1_fclk_sel[] =3D {
 =09{ .parent =3D &func_64m_fclk, .rates =3D div_1_0_rates },
 =09{ .parent =3D &func_96m_fclk, .rates =3D div_1_1_rates },
@@ -1171,51 +1027,10 @@ DEFINE_CLK_OMAP_MUX_GATE(mmc2_fck, "l3_init_clkdm",=
 hsmmc1_fclk_sel,
 =09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 =09=09=09 mmc1_fck_parents, dmic_fck_ops);
=20
-DEFINE_CLK_GATE(mmc3_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_MMCSD3_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(mmc4_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_MMCSD4_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(mmc5_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_MMCSD5_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(ocp2scp_usb_phy_phy_48m, "func_48m_fclk", &func_48m_fclk, =
0x0,
-=09=09OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-=09=09OMAP4430_OPTFCLKEN_PHY_48M_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(ocp2scp_usb_phy_ick, "l4_div_ck", &l4_div_ck, 0x0,
-=09=09OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
-
-static struct clk ocp_wp_noc_ick;
-
-static struct clk_hw_omap ocp_wp_noc_ick_hw =3D {
-=09.hw =3D {
-=09=09.clk =3D &ocp_wp_noc_ick,
-=09},
-=09.enable_reg=09=3D OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL_SHIFT,
-=09.clkdm_name=09=3D "l3_instr_clkdm",
-};
-
-DEFINE_STRUCT_CLK(ocp_wp_noc_ick, l3_instr_ick_parent_names, l3_instr_ick_=
ops);
-
-DEFINE_CLK_GATE(rng_ick, "l4_div_ck", &l4_div_ck, 0x0,
-=09=09OMAP4430_CM_L4SEC_RNG_CLKCTRL, OMAP4430_MODULEMODE_HWCTRL_SHIFT,
-=09=090x0, NULL);
-
 DEFINE_CLK_GATE(sha2md5_fck, "l3_div_ck", &l3_div_ck, 0x0,
 =09=09OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
 =09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
=20
-DEFINE_CLK_GATE(sl2if_ick, "dpll_iva_m5x2_ck", &dpll_iva_m5x2_ck, 0x0,
-=09=09OMAP4430_CM_IVAHD_SL2_CLKCTRL, OMAP4430_MODULEMODE_HWCTRL_SHIFT,
-=09=090x0, NULL);
-
 DEFINE_CLK_GATE(slimbus1_fclk_1, "func_24m_clk", &func_24m_clk, 0x0,
 =09=09OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
 =09=09OMAP4430_OPTFCLKEN_FCLK1_SHIFT, 0x0, NULL);
@@ -1232,10 +1047,6 @@ DEFINE_CLK_GATE(slimbus1_slimbus_clk, "slimbus_clk",=
 &slimbus_clk, 0x0,
 =09=09OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
 =09=09OMAP4430_OPTFCLKEN_SLIMBUS_CLK_11_11_SHIFT, 0x0, NULL);
=20
-DEFINE_CLK_GATE(slimbus1_fck, "ocp_abe_iclk", &ocp_abe_iclk, 0x0,
-=09=09OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_GATE(slimbus2_fclk_1, "per_abe_24m_fclk", &per_abe_24m_fclk, 0x=
0,
 =09=09OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
 =09=09OMAP4430_OPTFCLKEN_PERABE24M_GFCLK_SHIFT, 0x0, NULL);
@@ -1249,10 +1060,6 @@ DEFINE_CLK_GATE(slimbus2_slimbus_clk, "pad_slimbus_c=
ore_clks_ck",
 =09=09OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
 =09=09OMAP4430_OPTFCLKEN_SLIMBUS_CLK_SHIFT, 0x0, NULL);
=20
-DEFINE_CLK_GATE(slimbus2_fck, "l4_div_ck", &l4_div_ck, 0x0,
-=09=09OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
 DEFINE_CLK_GATE(smartreflex_core_fck, "l4_wkup_clk_mux_ck", &l4_wkup_clk_m=
ux_ck,
 =09=090x0, OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
 =09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
@@ -1364,22 +1171,6 @@ DEFINE_CLK_OMAP_MUX_GATE(timer9_fck, "l4_per_clkdm",=
 dmt1_clk_mux_sel,
 =09=09=09 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 =09=09=09 abe_dpll_bypass_clk_mux_ck_parents, dmic_fck_ops);
=20
-DEFINE_CLK_GATE(uart1_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_UART1_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(uart2_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_UART2_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(uart3_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_UART3_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
-DEFINE_CLK_GATE(uart4_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
-=09=09OMAP4430_CM_L4PER_UART4_CLKCTRL,
-=09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
-
 static struct clk usb_host_fs_fck;
=20
 static const char *usb_host_fs_fck_parent_names[] =3D {
@@ -1512,18 +1303,6 @@ DEFINE_CLK_GATE(usim_fclk, "usim_ck", &usim_ck, 0x0,
 =09=09OMAP4430_CM_WKUP_USIM_CLKCTRL, OMAP4430_OPTFCLKEN_FCLK_SHIFT,
 =09=090x0, NULL);
=20
-DEFINE_CLK_GATE(usim_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
-=09=09OMAP4430_CM_WKUP_USIM_CLKCTRL, OMAP4430_MODULEMODE_HWCTRL_SHIFT,
-=09=090x0, NULL);
-
-DEFINE_CLK_GATE(wd_timer2_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
-=09=09OMAP4430_CM_WKUP_WDT2_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
-=09=090x0, NULL);
-
-DEFINE_CLK_GATE(wd_timer3_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
-=09=09OMAP4430_CM1_ABE_WDT3_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
-=09=090x0, NULL);
-
 /* Remaining optional clocks */
 static const char *pmd_stm_clock_mux_ck_parents[] =3D {
 =09"sys_clkin_ck", "dpll_core_m6x2_ck", "tie_low_clock_ck",
@@ -1774,52 +1553,27 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"syc_clk_div_ck",=09=09&syc_clk_div_ck,=09CK_443X),
 =09CLK(NULL,=09"aes1_fck",=09=09=09&aes1_fck,=09CK_443X),
 =09CLK(NULL,=09"aes2_fck",=09=09=09&aes2_fck,=09CK_443X),
-=09CLK(NULL,=09"aess_fck",=09=09=09&aess_fck,=09CK_443X),
 =09CLK(NULL,=09"bandgap_fclk",=09=09=09&bandgap_fclk,=09CK_443X),
 =09CLK(NULL,=09"div_ts_ck",=09=09=09&div_ts_ck,=09CK_446X),
 =09CLK(NULL,=09"bandgap_ts_fclk",=09=09&bandgap_ts_fclk,=09CK_446X),
-=09CLK(NULL,=09"des3des_fck",=09=09=09&des3des_fck,=09CK_443X),
 =09CLK(NULL,=09"dmic_sync_mux_ck",=09=09&dmic_sync_mux_ck,=09CK_443X),
 =09CLK(NULL,=09"dmic_fck",=09=09=09&dmic_fck,=09CK_443X),
-=09CLK(NULL,=09"dsp_fck",=09=09=09&dsp_fck,=09CK_443X),
 =09CLK(NULL,=09"dss_sys_clk",=09=09=09&dss_sys_clk,=09CK_443X),
 =09CLK(NULL,=09"dss_tv_clk",=09=09=09&dss_tv_clk,=09CK_443X),
 =09CLK(NULL,=09"dss_dss_clk",=09=09=09&dss_dss_clk,=09CK_443X),
 =09CLK(NULL,=09"dss_48mhz_clk",=09=09&dss_48mhz_clk,=09CK_443X),
 =09CLK(NULL,=09"dss_fck",=09=09=09&dss_fck,=09CK_443X),
 =09CLK("omapdss_dss",=09"ick",=09=09=09&dss_fck,=09CK_443X),
-=09CLK(NULL,=09"efuse_ctrl_cust_fck",=09=09&efuse_ctrl_cust_fck,=09CK_443X=
),
-=09CLK(NULL,=09"emif1_fck",=09=09=09&emif1_fck,=09CK_443X),
-=09CLK(NULL,=09"emif2_fck",=09=09=09&emif2_fck,=09CK_443X),
 =09CLK(NULL,=09"fdif_fck",=09=09=09&fdif_fck,=09CK_443X),
-=09CLK(NULL,=09"fpka_fck",=09=09=09&fpka_fck,=09CK_443X),
 =09CLK(NULL,=09"gpio1_dbclk",=09=09=09&gpio1_dbclk,=09CK_443X),
-=09CLK(NULL,=09"gpio1_ick",=09=09=09&gpio1_ick,=09CK_443X),
 =09CLK(NULL,=09"gpio2_dbclk",=09=09=09&gpio2_dbclk,=09CK_443X),
-=09CLK(NULL,=09"gpio2_ick",=09=09=09&gpio2_ick,=09CK_443X),
 =09CLK(NULL,=09"gpio3_dbclk",=09=09=09&gpio3_dbclk,=09CK_443X),
-=09CLK(NULL,=09"gpio3_ick",=09=09=09&gpio3_ick,=09CK_443X),
 =09CLK(NULL,=09"gpio4_dbclk",=09=09=09&gpio4_dbclk,=09CK_443X),
-=09CLK(NULL,=09"gpio4_ick",=09=09=09&gpio4_ick,=09CK_443X),
 =09CLK(NULL,=09"gpio5_dbclk",=09=09=09&gpio5_dbclk,=09CK_443X),
-=09CLK(NULL,=09"gpio5_ick",=09=09=09&gpio5_ick,=09CK_443X),
 =09CLK(NULL,=09"gpio6_dbclk",=09=09=09&gpio6_dbclk,=09CK_443X),
-=09CLK(NULL,=09"gpio6_ick",=09=09=09&gpio6_ick,=09CK_443X),
-=09CLK(NULL,=09"gpmc_ick",=09=09=09&gpmc_ick,=09CK_443X),
 =09CLK(NULL,=09"gpu_fck",=09=09=09&gpu_fck,=09CK_443X),
-=09CLK(NULL,=09"hdq1w_fck",=09=09=09&hdq1w_fck,=09CK_443X),
 =09CLK(NULL,=09"hsi_fck",=09=09=09&hsi_fck,=09CK_443X),
-=09CLK(NULL,=09"i2c1_fck",=09=09=09&i2c1_fck,=09CK_443X),
-=09CLK(NULL,=09"i2c2_fck",=09=09=09&i2c2_fck,=09CK_443X),
-=09CLK(NULL,=09"i2c3_fck",=09=09=09&i2c3_fck,=09CK_443X),
-=09CLK(NULL,=09"i2c4_fck",=09=09=09&i2c4_fck,=09CK_443X),
-=09CLK(NULL,=09"ipu_fck",=09=09=09&ipu_fck,=09CK_443X),
 =09CLK(NULL,=09"iss_ctrlclk",=09=09=09&iss_ctrlclk,=09CK_443X),
-=09CLK(NULL,=09"iss_fck",=09=09=09&iss_fck,=09CK_443X),
-=09CLK(NULL,=09"iva_fck",=09=09=09&iva_fck,=09CK_443X),
-=09CLK(NULL,=09"kbd_fck",=09=09=09&kbd_fck,=09CK_443X),
-=09CLK(NULL,=09"l3_instr_ick",=09=09=09&l3_instr_ick,=09CK_443X),
-=09CLK(NULL,=09"l3_main_3_ick",=09=09&l3_main_3_ick,=09CK_443X),
 =09CLK(NULL,=09"mcasp_sync_mux_ck",=09=09&mcasp_sync_mux_ck,=09CK_443X),
 =09CLK(NULL,=09"mcasp_fck",=09=09=09&mcasp_fck,=09CK_443X),
 =09CLK(NULL,=09"mcbsp1_sync_mux_ck",=09=09&mcbsp1_sync_mux_ck,=09CK_443X),
@@ -1830,32 +1584,16 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"mcbsp3_fck",=09=09=09&mcbsp3_fck,=09CK_443X),
 =09CLK(NULL,=09"mcbsp4_sync_mux_ck",=09=09&mcbsp4_sync_mux_ck,=09CK_443X),
 =09CLK(NULL,=09"mcbsp4_fck",=09=09=09&mcbsp4_fck,=09CK_443X),
-=09CLK(NULL,=09"mcpdm_fck",=09=09=09&mcpdm_fck,=09CK_443X),
-=09CLK(NULL,=09"mcspi1_fck",=09=09=09&mcspi1_fck,=09CK_443X),
-=09CLK(NULL,=09"mcspi2_fck",=09=09=09&mcspi2_fck,=09CK_443X),
-=09CLK(NULL,=09"mcspi3_fck",=09=09=09&mcspi3_fck,=09CK_443X),
-=09CLK(NULL,=09"mcspi4_fck",=09=09=09&mcspi4_fck,=09CK_443X),
 =09CLK(NULL,=09"mmc1_fck",=09=09=09&mmc1_fck,=09CK_443X),
 =09CLK(NULL,=09"mmc2_fck",=09=09=09&mmc2_fck,=09CK_443X),
-=09CLK(NULL,=09"mmc3_fck",=09=09=09&mmc3_fck,=09CK_443X),
-=09CLK(NULL,=09"mmc4_fck",=09=09=09&mmc4_fck,=09CK_443X),
-=09CLK(NULL,=09"mmc5_fck",=09=09=09&mmc5_fck,=09CK_443X),
-=09CLK(NULL,=09"ocp2scp_usb_phy_phy_48m",=09&ocp2scp_usb_phy_phy_48m,=09CK=
_443X),
-=09CLK(NULL,=09"ocp2scp_usb_phy_ick",=09=09&ocp2scp_usb_phy_ick,=09CK_443X=
),
-=09CLK(NULL,=09"ocp_wp_noc_ick",=09=09&ocp_wp_noc_ick,=09CK_443X),
-=09CLK(NULL,=09"rng_ick",=09=09=09&rng_ick,=09CK_443X),
-=09CLK("omap_rng",=09"ick",=09=09=09=09&rng_ick,=09CK_443X),
 =09CLK(NULL,=09"sha2md5_fck",=09=09=09&sha2md5_fck,=09CK_443X),
-=09CLK(NULL,=09"sl2if_ick",=09=09=09&sl2if_ick,=09CK_443X),
 =09CLK(NULL,=09"slimbus1_fclk_1",=09=09&slimbus1_fclk_1,=09CK_443X),
 =09CLK(NULL,=09"slimbus1_fclk_0",=09=09&slimbus1_fclk_0,=09CK_443X),
 =09CLK(NULL,=09"slimbus1_fclk_2",=09=09&slimbus1_fclk_2,=09CK_443X),
 =09CLK(NULL,=09"slimbus1_slimbus_clk",=09=09&slimbus1_slimbus_clk,=09CK_44=
3X),
-=09CLK(NULL,=09"slimbus1_fck",=09=09=09&slimbus1_fck,=09CK_443X),
 =09CLK(NULL,=09"slimbus2_fclk_1",=09=09&slimbus2_fclk_1,=09CK_443X),
 =09CLK(NULL,=09"slimbus2_fclk_0",=09=09&slimbus2_fclk_0,=09CK_443X),
 =09CLK(NULL,=09"slimbus2_slimbus_clk",=09=09&slimbus2_slimbus_clk,=09CK_44=
3X),
-=09CLK(NULL,=09"slimbus2_fck",=09=09=09&slimbus2_fck,=09CK_443X),
 =09CLK(NULL,=09"smartreflex_core_fck",=09=09&smartreflex_core_fck,=09CK_44=
3X),
 =09CLK(NULL,=09"smartreflex_iva_fck",=09=09&smartreflex_iva_fck,=09CK_443X=
),
 =09CLK(NULL,=09"smartreflex_mpu_fck",=09=09&smartreflex_mpu_fck,=09CK_443X=
),
@@ -1870,10 +1608,6 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"timer7_fck",=09=09=09&timer7_fck,=09CK_443X),
 =09CLK(NULL,=09"timer8_fck",=09=09=09&timer8_fck,=09CK_443X),
 =09CLK(NULL,=09"timer9_fck",=09=09=09&timer9_fck,=09CK_443X),
-=09CLK(NULL,=09"uart1_fck",=09=09=09&uart1_fck,=09CK_443X),
-=09CLK(NULL,=09"uart2_fck",=09=09=09&uart2_fck,=09CK_443X),
-=09CLK(NULL,=09"uart3_fck",=09=09=09&uart3_fck,=09CK_443X),
-=09CLK(NULL,=09"uart4_fck",=09=09=09&uart4_fck,=09CK_443X),
 =09CLK(NULL,=09"usb_host_fs_fck",=09=09&usb_host_fs_fck,=09CK_443X),
 =09CLK("usbhs_omap",=09"fs_fck",=09=09&usb_host_fs_fck,=09CK_443X),
 =09CLK(NULL,=09"utmi_p1_gfclk",=09=09&utmi_p1_gfclk,=09CK_443X),
@@ -1901,9 +1635,6 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK("usbhs_tll",=09"usbtll_ick",=09=09&usb_tll_hs_ick,=09CK_443X),
 =09CLK(NULL,=09"usim_ck",=09=09=09&usim_ck,=09CK_443X),
 =09CLK(NULL,=09"usim_fclk",=09=09=09&usim_fclk,=09CK_443X),
-=09CLK(NULL,=09"usim_fck",=09=09=09&usim_fck,=09CK_443X),
-=09CLK(NULL,=09"wd_timer2_fck",=09=09&wd_timer2_fck,=09CK_443X),
-=09CLK(NULL,=09"wd_timer3_fck",=09=09&wd_timer3_fck,=09CK_443X),
 =09CLK(NULL,=09"pmd_stm_clock_mux_ck",=09=09&pmd_stm_clock_mux_ck,=09CK_44=
3X),
 =09CLK(NULL,=09"pmd_trace_clk_mux_ck",=09=09&pmd_trace_clk_mux_ck,=09CK_44=
3X),
 =09CLK(NULL,=09"stm_clk_div_ck",=09=09&stm_clk_div_ck,=09CK_443X),
@@ -1980,15 +1711,6 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"cpufreq_ck",=09&dpll_mpu_ck,=09CK_443X),
 };
=20
-static const char *enable_init_clks[] =3D {
-=09"emif1_fck",
-=09"emif2_fck",
-=09"gpmc_ick",
-=09"l3_instr_ick",
-=09"l3_main_3_ick",
-=09"ocp_wp_noc_ick",
-};
-
 int __init omap4xxx_clk_init(void)
 {
 =09u32 cpu_clkflg;
@@ -2019,9 +1741,6 @@ int __init omap4xxx_clk_init(void)
=20
 =09omap2_clk_disable_autoidle_all();
=20
-=09omap2_clk_enable_init_clocks(enable_init_clks,
-=09=09=09=09     ARRAY_SIZE(enable_init_clks));
-
 =09/*
 =09 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
 =09 * state when turning the ABE clock domain. Workaround this by
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index eb61cfd..0b59ddb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -653,7 +653,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod =3D {
 =09.mpu_irqs=09=3D omap44xx_dsp_irqs,
 =09.rst_lines=09=3D omap44xx_dsp_resets,
 =09.rst_lines_cnt=09=3D ARRAY_SIZE(omap44xx_dsp_resets),
-=09.main_clk=09=3D "dsp_fck",
+=09.main_clk=09=3D "dpll_iva_m4x2_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
@@ -1162,7 +1162,7 @@ static struct omap_hwmod omap44xx_gpio1_hwmod =3D {
 =09.class=09=09=3D &omap44xx_gpio_hwmod_class,
 =09.clkdm_name=09=3D "l4_wkup_clkdm",
 =09.mpu_irqs=09=3D omap44xx_gpio1_irqs,
-=09.main_clk=09=3D "gpio1_ick",
+=09.main_clk=09=3D "l4_wkup_clk_mux_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_WKUP_GPIO1_CLKCTRL_OFFSET,
@@ -1191,7 +1191,7 @@ static struct omap_hwmod omap44xx_gpio2_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.flags=09=09=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 =09.mpu_irqs=09=3D omap44xx_gpio2_irqs,
-=09.main_clk=09=3D "gpio2_ick",
+=09.main_clk=09=3D "l4_div_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
@@ -1220,7 +1220,7 @@ static struct omap_hwmod omap44xx_gpio3_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.flags=09=09=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 =09.mpu_irqs=09=3D omap44xx_gpio3_irqs,
-=09.main_clk=09=3D "gpio3_ick",
+=09.main_clk=09=3D "l4_div_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
@@ -1249,7 +1249,7 @@ static struct omap_hwmod omap44xx_gpio4_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.flags=09=09=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 =09.mpu_irqs=09=3D omap44xx_gpio4_irqs,
-=09.main_clk=09=3D "gpio4_ick",
+=09.main_clk=09=3D "l4_div_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
@@ -1278,7 +1278,7 @@ static struct omap_hwmod omap44xx_gpio5_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.flags=09=09=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 =09.mpu_irqs=09=3D omap44xx_gpio5_irqs,
-=09.main_clk=09=3D "gpio5_ick",
+=09.main_clk=09=3D "l4_div_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
@@ -1307,7 +1307,7 @@ static struct omap_hwmod omap44xx_gpio6_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.flags=09=09=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 =09.mpu_irqs=09=3D omap44xx_gpio6_irqs,
-=09.main_clk=09=3D "gpio6_ick",
+=09.main_clk=09=3D "l4_div_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
@@ -1447,7 +1447,7 @@ static struct omap_hwmod omap44xx_hdq1w_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.flags=09=09=3D HWMOD_INIT_NO_RESET, /* XXX temporary */
 =09.mpu_irqs=09=3D omap44xx_hdq1w_irqs,
-=09.main_clk=09=3D "hdq1w_fck",
+=09.main_clk=09=3D "func_12m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_HDQ1W_CLKCTRL_OFFSET,
@@ -1552,7 +1552,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod =3D {
 =09.flags=09=09=3D HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 =09.mpu_irqs=09=3D omap44xx_i2c1_irqs,
 =09.sdma_reqs=09=3D omap44xx_i2c1_sdma_reqs,
-=09.main_clk=09=3D "i2c1_fck",
+=09.main_clk=09=3D "func_96m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET,
@@ -1582,7 +1582,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod =3D {
 =09.flags=09=09=3D HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 =09.mpu_irqs=09=3D omap44xx_i2c2_irqs,
 =09.sdma_reqs=09=3D omap44xx_i2c2_sdma_reqs,
-=09.main_clk=09=3D "i2c2_fck",
+=09.main_clk=09=3D "func_96m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
@@ -1612,7 +1612,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod =3D {
 =09.flags=09=09=3D HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 =09.mpu_irqs=09=3D omap44xx_i2c3_irqs,
 =09.sdma_reqs=09=3D omap44xx_i2c3_sdma_reqs,
-=09.main_clk=09=3D "i2c3_fck",
+=09.main_clk=09=3D "func_96m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
@@ -1642,7 +1642,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod =3D {
 =09.flags=09=09=3D HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 =09.mpu_irqs=09=3D omap44xx_i2c4_irqs,
 =09.sdma_reqs=09=3D omap44xx_i2c4_sdma_reqs,
-=09.main_clk=09=3D "i2c4_fck",
+=09.main_clk=09=3D "func_96m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
@@ -1680,7 +1680,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod =3D {
 =09.mpu_irqs=09=3D omap44xx_ipu_irqs,
 =09.rst_lines=09=3D omap44xx_ipu_resets,
 =09.rst_lines_cnt=09=3D ARRAY_SIZE(omap44xx_ipu_resets),
-=09.main_clk=09=3D "ipu_fck",
+=09.main_clk=09=3D "ducati_clk_mux_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
@@ -1745,7 +1745,7 @@ static struct omap_hwmod omap44xx_iss_hwmod =3D {
 =09.clkdm_name=09=3D "iss_clkdm",
 =09.mpu_irqs=09=3D omap44xx_iss_irqs,
 =09.sdma_reqs=09=3D omap44xx_iss_sdma_reqs,
-=09.main_clk=09=3D "iss_fck",
+=09.main_clk=09=3D "ducati_clk_mux_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_CAM_ISS_CLKCTRL_OFFSET,
@@ -1787,7 +1787,7 @@ static struct omap_hwmod omap44xx_iva_hwmod =3D {
 =09.mpu_irqs=09=3D omap44xx_iva_irqs,
 =09.rst_lines=09=3D omap44xx_iva_resets,
 =09.rst_lines_cnt=09=3D ARRAY_SIZE(omap44xx_iva_resets),
-=09.main_clk=09=3D "iva_fck",
+=09.main_clk=09=3D "dpll_iva_m5x2_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_IVAHD_IVAHD_CLKCTRL_OFFSET,
@@ -1831,7 +1831,7 @@ static struct omap_hwmod omap44xx_kbd_hwmod =3D {
 =09.class=09=09=3D &omap44xx_kbd_hwmod_class,
 =09.clkdm_name=09=3D "l4_wkup_clkdm",
 =09.mpu_irqs=09=3D omap44xx_kbd_irqs,
-=09.main_clk=09=3D "kbd_fck",
+=09.main_clk=09=3D "sys_32k_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_WKUP_KEYBOARD_CLKCTRL_OFFSET,
@@ -2138,7 +2138,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod =3D {
 =09.flags=09=09=3D HWMOD_EXT_OPT_MAIN_CLK,
 =09.mpu_irqs=09=3D omap44xx_mcpdm_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcpdm_sdma_reqs,
-=09.main_clk=09=3D "mcpdm_fck",
+=09.main_clk=09=3D "pad_clks_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET,
@@ -2199,7 +2199,7 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mcspi1_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcspi1_sdma_reqs,
-=09.main_clk=09=3D "mcspi1_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
@@ -2235,7 +2235,7 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mcspi2_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcspi2_sdma_reqs,
-=09.main_clk=09=3D "mcspi2_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
@@ -2271,7 +2271,7 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mcspi3_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcspi3_sdma_reqs,
-=09.main_clk=09=3D "mcspi3_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
@@ -2305,7 +2305,7 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mcspi4_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcspi4_sdma_reqs,
-=09.main_clk=09=3D "mcspi4_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
@@ -2418,7 +2418,7 @@ static struct omap_hwmod omap44xx_mmc3_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mmc3_irqs,
 =09.sdma_reqs=09=3D omap44xx_mmc3_sdma_reqs,
-=09.main_clk=09=3D "mmc3_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
@@ -2446,7 +2446,7 @@ static struct omap_hwmod omap44xx_mmc4_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mmc4_irqs,
 =09.sdma_reqs=09=3D omap44xx_mmc4_sdma_reqs,
-=09.main_clk=09=3D "mmc4_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
@@ -2474,7 +2474,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_mmc5_irqs,
 =09.sdma_reqs=09=3D omap44xx_mmc5_sdma_reqs,
-=09.main_clk=09=3D "mmc5_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
@@ -2723,7 +2723,7 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwm=
od =3D {
 =09.name=09=09=3D "ocp2scp_usb_phy",
 =09.class=09=09=3D &omap44xx_ocp2scp_hwmod_class,
 =09.clkdm_name=09=3D "l3_init_clkdm",
-=09.main_clk=09=3D "ocp2scp_usb_phy_phy_48m",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
@@ -3431,7 +3431,7 @@ static struct omap_hwmod omap44xx_uart1_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_uart1_irqs,
 =09.sdma_reqs=09=3D omap44xx_uart1_sdma_reqs,
-=09.main_clk=09=3D "uart1_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET,
@@ -3459,7 +3459,7 @@ static struct omap_hwmod omap44xx_uart2_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_uart2_irqs,
 =09.sdma_reqs=09=3D omap44xx_uart2_sdma_reqs,
-=09.main_clk=09=3D "uart2_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET,
@@ -3488,7 +3488,7 @@ static struct omap_hwmod omap44xx_uart3_hwmod =3D {
 =09.flags=09=09=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 =09.mpu_irqs=09=3D omap44xx_uart3_irqs,
 =09.sdma_reqs=09=3D omap44xx_uart3_sdma_reqs,
-=09.main_clk=09=3D "uart3_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
@@ -3516,7 +3516,7 @@ static struct omap_hwmod omap44xx_uart4_hwmod =3D {
 =09.clkdm_name=09=3D "l4_per_clkdm",
 =09.mpu_irqs=09=3D omap44xx_uart4_irqs,
 =09.sdma_reqs=09=3D omap44xx_uart4_sdma_reqs,
-=09.main_clk=09=3D "uart4_fck",
+=09.main_clk=09=3D "func_48m_fclk",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET,
@@ -3795,7 +3795,7 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod =3D=
 {
 =09.class=09=09=3D &omap44xx_wd_timer_hwmod_class,
 =09.clkdm_name=09=3D "l4_wkup_clkdm",
 =09.mpu_irqs=09=3D omap44xx_wd_timer2_irqs,
-=09.main_clk=09=3D "wd_timer2_fck",
+=09.main_clk=09=3D "sys_32k_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_WKUP_WDT2_CLKCTRL_OFFSET,
@@ -3816,7 +3816,7 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod =3D=
 {
 =09.class=09=09=3D &omap44xx_wd_timer_hwmod_class,
 =09.clkdm_name=09=3D "abe_clkdm",
 =09.mpu_irqs=09=3D omap44xx_wd_timer3_irqs,
-=09.main_clk=09=3D "wd_timer3_fck",
+=09.main_clk=09=3D "sys_32k_ck",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_WDT3_CLKCTRL_OFFSET,
--=20
1.7.10.4
--843723315-1972203429-1355776810=:29833--
