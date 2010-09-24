From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/12] OMAP4: clock: Fix clock names and align with hwmod names
Date: Fri, 24 Sep 2010 01:08:10 -0600
Message-ID: <20100924070808.14014.10389.stgit@twilight.localdomain>
References: <20100924070643.14014.11359.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33632 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab0IXHJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 03:09:03 -0400
In-Reply-To: <20100924070643.14014.11359.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

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
 arch/arm/mach-omap2/clock44xx_data.c |  665 ++++++++++++++++------------------
 1 files changed, 310 insertions(+), 355 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index f39552b..8296ae0 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -26,7 +26,6 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/clk.h>
-
 #include <plat/control.h>
 #include <plat/clkdev_omap.h>
 
@@ -914,6 +913,7 @@ static struct clk usb_hs_clk_div_ck = {
 static struct dpll_data dpll_usb_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_USB,
 	.clk_bypass	= &usb_hs_clk_div_ck,
+	.flags		= DPLL_J_TYPE | DPLL_NO_DCO_SEL,
 	.clk_ref	= &sys_clkin_ck,
 	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_USB,
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
@@ -927,7 +927,6 @@ static struct dpll_data dpll_usb_dd = {
 	.max_multiplier	= OMAP4430_MAX_DPLL_MULT,
 	.max_divider	= OMAP4430_MAX_DPLL_DIV,
 	.min_divider	= 1,
-	.flags		= DPLL_J_TYPE | DPLL_NO_DCO_SEL
 };
 
 
@@ -1289,16 +1288,6 @@ static struct clk aess_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk cust_efuse_fck = {
-	.name		= "cust_efuse_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_cefuse_clkdm",
-	.parent		= &sys_clkin_ck,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk des3des_fck = {
 	.name		= "des3des_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -1349,6 +1338,16 @@ static struct clk dmic_fck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
+static struct clk dsp_fck = {
+	.name		= "dsp_fck",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_TESLA_TESLA_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
+	.clkdm_name	= "tesla_clkdm",
+	.parent		= &dpll_iva_m4_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk dss_fck = {
 	.name		= "dss_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -1359,18 +1358,18 @@ static struct clk dss_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ducati_ick = {
-	.name		= "ducati_ick",
+static struct clk efuse_ctrl_cust_fck = {
+	.name		= "efuse_ctrl_cust_fck",
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "ducati_clkdm",
-	.parent		= &ducati_clk_mux_ck,
+	.enable_reg	= OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "l4_cefuse_clkdm",
+	.parent		= &sys_clkin_ck,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk emif1_ick = {
-	.name		= "emif1_ick",
+static struct clk emif1_fck = {
+	.name		= "emif1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1380,8 +1379,8 @@ static struct clk emif1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk emif2_ick = {
-	.name		= "emif2_ick",
+static struct clk emif2_fck = {
+	.name		= "emif2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1412,25 +1411,14 @@ static struct clk fdif_fck = {
 	.clkdm_name	= "iss_clkdm",
 };
 
-static const struct clksel sgx_clk_mux_sel[] = {
-	{ .parent = &dpll_core_m7_ck, .rates = div_1_0_rates },
-	{ .parent = &dpll_per_m7_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
-
-/* Merged sgx_clk_mux into gfx */
-static struct clk gfx_fck = {
-	.name		= "gfx_fck",
-	.parent		= &dpll_core_m7_ck,
-	.clksel		= sgx_clk_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_SGX_FCLK_MASK,
+static struct clk fpka_fck = {
+	.name		= "fpka_fck",
 	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
+	.enable_reg	= OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_gfx_clkdm",
+	.clkdm_name	= "l4_secure_clkdm",
+	.parent		= &l4_div_ck,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpio1_ick = {
@@ -1503,208 +1491,25 @@ static struct clk gpmc_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-/*
- * Merged dmt1_clk_mux into gptimer1
- * gptimer1 renamed temporarily into gpt1 to match OMAP3 convention
- */
-static struct clk gpt1_fck = {
-	.name		= "gpt1_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_wkup_clkdm",
-};
-
-/*
- * Merged cm2_dm10_mux into gptimer10
- * gptimer10 renamed temporarily into gpt10 to match OMAP3 convention
- */
-static struct clk gpt10_fck = {
-	.name		= "gpt10_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-};
-
-/*
- * Merged cm2_dm11_mux into gptimer11
- * gptimer11 renamed temporarily into gpt11 to match OMAP3 convention
- */
-static struct clk gpt11_fck = {
-	.name		= "gpt11_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-};
-
-/*
- * Merged cm2_dm2_mux into gptimer2
- * gptimer2 renamed temporarily into gpt2 to match OMAP3 convention
- */
-static struct clk gpt2_fck = {
-	.name		= "gpt2_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-};
-
-/*
- * Merged cm2_dm3_mux into gptimer3
- * gptimer3 renamed temporarily into gpt3 to match OMAP3 convention
- */
-static struct clk gpt3_fck = {
-	.name		= "gpt3_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-};
-
-/*
- * Merged cm2_dm4_mux into gptimer4
- * gptimer4 renamed temporarily into gpt4 to match OMAP3 convention
- */
-static struct clk gpt4_fck = {
-	.name		= "gpt4_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-};
-
-static const struct clksel timer5_sync_mux_sel[] = {
-	{ .parent = &syc_clk_div_ck, .rates = div_1_0_rates },
-	{ .parent = &sys_32k_ck, .rates = div_1_1_rates },
+static const struct clksel sgx_clk_mux_sel[] = {
+	{ .parent = &dpll_core_m7_ck, .rates = div_1_0_rates },
+	{ .parent = &dpll_per_m7_ck, .rates = div_1_1_rates },
 	{ .parent = NULL },
 };
 
-/*
- * Merged timer5_sync_mux into gptimer5
- * gptimer5 renamed temporarily into gpt5 to match OMAP3 convention
- */
-static struct clk gpt5_fck = {
-	.name		= "gpt5_fck",
-	.parent		= &syc_clk_div_ck,
-	.clksel		= timer5_sync_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
-
-/*
- * Merged timer6_sync_mux into gptimer6
- * gptimer6 renamed temporarily into gpt6 to match OMAP3 convention
- */
-static struct clk gpt6_fck = {
-	.name		= "gpt6_fck",
-	.parent		= &syc_clk_div_ck,
-	.clksel		= timer5_sync_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
-
-/*
- * Merged timer7_sync_mux into gptimer7
- * gptimer7 renamed temporarily into gpt7 to match OMAP3 convention
- */
-static struct clk gpt7_fck = {
-	.name		= "gpt7_fck",
-	.parent		= &syc_clk_div_ck,
-	.clksel		= timer5_sync_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
-
-/*
- * Merged timer8_sync_mux into gptimer8
- * gptimer8 renamed temporarily into gpt8 to match OMAP3 convention
- */
-static struct clk gpt8_fck = {
-	.name		= "gpt8_fck",
-	.parent		= &syc_clk_div_ck,
-	.clksel		= timer5_sync_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
-
-/*
- * Merged cm2_dm9_mux into gptimer9
- * gptimer9 renamed temporarily into gpt9 to match OMAP3 convention
- */
-static struct clk gpt9_fck = {
-	.name		= "gpt9_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
+/* Merged sgx_clk_mux into gpu */
+static struct clk gpu_fck = {
+	.name		= "gpu_fck",
+	.parent		= &dpll_core_m7_ck,
+	.clksel		= sgx_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.clksel_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_SGX_FCLK_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
+	.enable_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
+	.clkdm_name	= "l3_gfx_clkdm",
 };
 
 static struct clk hdq1w_fck = {
@@ -1723,8 +1528,8 @@ static const struct clksel hsi_fclk_div[] = {
 };
 
 /* Merged hsi_fclk into hsi */
-static struct clk hsi_ick = {
-	.name		= "hsi_ick",
+static struct clk hsi_fck = {
+	.name		= "hsi_fck",
 	.parent		= &dpll_per_m2x2_ck,
 	.clksel		= hsi_fclk_div,
 	.clksel_reg	= OMAP4430_CM_L3INIT_HSI_CLKCTRL,
@@ -1778,6 +1583,16 @@ static struct clk i2c4_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk ipu_fck = {
+	.name		= "ipu_fck",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
+	.clkdm_name	= "ducati_clkdm",
+	.parent		= &ducati_clk_mux_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk iss_fck = {
 	.name		= "iss_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -1788,8 +1603,8 @@ static struct clk iss_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ivahd_ick = {
-	.name		= "ivahd_ick",
+static struct clk iva_fck = {
+	.name		= "iva_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1798,8 +1613,8 @@ static struct clk ivahd_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk keyboard_fck = {
-	.name		= "keyboard_fck",
+static struct clk kbd_fck = {
+	.name		= "kbd_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1808,8 +1623,8 @@ static struct clk keyboard_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk l3_instr_interconnect_ick = {
-	.name		= "l3_instr_interconnect_ick",
+static struct clk l3_instr_ick = {
+	.name		= "l3_instr_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1818,8 +1633,8 @@ static struct clk l3_instr_interconnect_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk l3_interconnect_3_ick = {
-	.name		= "l3_interconnect_3_ick",
+static struct clk l3_main_3_ick = {
+	.name		= "l3_main_3_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_L3_3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1992,6 +1807,16 @@ static struct clk mcbsp4_fck = {
 	.clkdm_name	= "l4_per_clkdm",
 };
 
+static struct clk mcpdm_fck = {
+	.name		= "mcpdm_fck",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM1_ABE_PDM_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "abe_clkdm",
+	.parent		= &pad_clks_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk mcspi1_fck = {
 	.name		= "mcspi1_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -2092,8 +1917,8 @@ static struct clk mmc5_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ocp_wp1_ick = {
-	.name		= "ocp_wp1_ick",
+static struct clk ocp_wp_noc_ick = {
+	.name		= "ocp_wp_noc_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2102,26 +1927,6 @@ static struct clk ocp_wp1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk pdm_fck = {
-	.name		= "pdm_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_PDM_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &pad_clks_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk pkaeip29_fck = {
-	.name		= "pkaeip29_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_secure_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk rng_ick = {
 	.name		= "rng_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -2132,8 +1937,8 @@ static struct clk rng_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sha2md51_fck = {
-	.name		= "sha2md51_fck",
+static struct clk sha2md5_fck = {
+	.name		= "sha2md5_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2142,8 +1947,8 @@ static struct clk sha2md51_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sl2_ick = {
-	.name		= "sl2_ick",
+static struct clk sl2if_ick = {
+	.name		= "sl2if_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_IVAHD_SL2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2172,8 +1977,8 @@ static struct clk slimbus2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sr_core_fck = {
-	.name		= "sr_core_fck",
+static struct clk smartreflex_core_fck = {
+	.name		= "smartreflex_core_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2182,8 +1987,8 @@ static struct clk sr_core_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sr_iva_fck = {
-	.name		= "sr_iva_fck",
+static struct clk smartreflex_iva_fck = {
+	.name		= "smartreflex_iva_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2192,8 +1997,8 @@ static struct clk sr_iva_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sr_mpu_fck = {
-	.name		= "sr_mpu_fck",
+static struct clk smartreflex_mpu_fck = {
+	.name		= "smartreflex_mpu_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2202,14 +2007,175 @@ static struct clk sr_mpu_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk tesla_ick = {
-	.name		= "tesla_ick",
+/* Merged dmt1_clk_mux into timer1 */
+static struct clk timer1_fck = {
+	.name		= "timer1_fck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_TESLA_TESLA_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "tesla_clkdm",
-	.parent		= &dpll_iva_m4_ck,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "l4_wkup_clkdm",
+};
+
+/* Merged cm2_dm10_mux into timer10 */
+static struct clk timer10_fck = {
+	.name		= "timer10_fck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "l4_per_clkdm",
+};
+
+/* Merged cm2_dm11_mux into timer11 */
+static struct clk timer11_fck = {
+	.name		= "timer11_fck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "l4_per_clkdm",
+};
+
+/* Merged cm2_dm2_mux into timer2 */
+static struct clk timer2_fck = {
+	.name		= "timer2_fck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "l4_per_clkdm",
+};
+
+/* Merged cm2_dm3_mux into timer3 */
+static struct clk timer3_fck = {
+	.name		= "timer3_fck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "l4_per_clkdm",
+};
+
+/* Merged cm2_dm4_mux into timer4 */
+static struct clk timer4_fck = {
+	.name		= "timer4_fck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "l4_per_clkdm",
+};
+
+static const struct clksel timer5_sync_mux_sel[] = {
+	{ .parent = &syc_clk_div_ck, .rates = div_1_0_rates },
+	{ .parent = &sys_32k_ck, .rates = div_1_1_rates },
+	{ .parent = NULL },
+};
+
+/* Merged timer5_sync_mux into timer5 */
+static struct clk timer5_fck = {
+	.name		= "timer5_fck",
+	.parent		= &syc_clk_div_ck,
+	.clksel		= timer5_sync_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "abe_clkdm",
+};
+
+/* Merged timer6_sync_mux into timer6 */
+static struct clk timer6_fck = {
+	.name		= "timer6_fck",
+	.parent		= &syc_clk_div_ck,
+	.clksel		= timer5_sync_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "abe_clkdm",
+};
+
+/* Merged timer7_sync_mux into timer7 */
+static struct clk timer7_fck = {
+	.name		= "timer7_fck",
+	.parent		= &syc_clk_div_ck,
+	.clksel		= timer5_sync_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "abe_clkdm",
+};
+
+/* Merged timer8_sync_mux into timer8 */
+static struct clk timer8_fck = {
+	.name		= "timer8_fck",
+	.parent		= &syc_clk_div_ck,
+	.clksel		= timer5_sync_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "abe_clkdm",
+};
+
+/* Merged cm2_dm9_mux into timer9 */
+static struct clk timer9_fck = {
+	.name		= "timer9_fck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "l4_per_clkdm",
 };
 
 static struct clk uart1_fck = {
@@ -2252,18 +2218,18 @@ static struct clk uart4_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk unipro1_fck = {
-	.name		= "unipro1_fck",
+static struct clk usb_host_fs_fck = {
+	.name		= "usb_host_fs_fck",
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_UNIPRO1_CLKCTRL,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &func_96m_fclk,
+	.parent		= &func_48mc_fclk,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_fck = {
-	.name		= "usb_host_fck",
+static struct clk usb_host_hs_fck = {
+	.name		= "usb_host_hs_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2272,18 +2238,8 @@ static struct clk usb_host_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_fs_fck = {
-	.name		= "usb_host_fs_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &func_48mc_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_otg_ick = {
-	.name		= "usb_otg_ick",
+static struct clk usb_otg_hs_ick = {
+	.name		= "usb_otg_hs_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2292,8 +2248,8 @@ static struct clk usb_otg_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_tll_ick = {
-	.name		= "usb_tll_ick",
+static struct clk usb_tll_hs_ick = {
+	.name		= "usb_tll_hs_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2302,8 +2258,8 @@ static struct clk usb_tll_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usim_ick = {
-	.name		= "usim_ick",
+static struct clk usim_fck = {
+	.name		= "usim_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2312,8 +2268,8 @@ static struct clk usim_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt2_fck = {
-	.name		= "wdt2_fck",
+static struct clk wd_timer2_fck = {
+	.name		= "wd_timer2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_WDT2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2322,8 +2278,8 @@ static struct clk wdt2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt3_fck = {
-	.name		= "wdt3_fck",
+static struct clk wd_timer3_fck = {
+	.name		= "wd_timer3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_WDT3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2535,16 +2491,16 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"aes1_fck",			&aes1_fck,	CK_443X),
 	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_443X),
 	CLK(NULL,	"aess_fck",			&aess_fck,	CK_443X),
-	CLK(NULL,	"cust_efuse_fck",		&cust_efuse_fck,	CK_443X),
 	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
+	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
 	CLK(NULL,	"dss_fck",			&dss_fck,	CK_443X),
-	CLK(NULL,	"ducati_ick",			&ducati_ick,	CK_443X),
-	CLK(NULL,	"emif1_ick",			&emif1_ick,	CK_443X),
-	CLK(NULL,	"emif2_ick",			&emif2_ick,	CK_443X),
+	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_443X),
+	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_443X),
+	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_443X),
 	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_443X),
-	CLK(NULL,	"gfx_fck",			&gfx_fck,	CK_443X),
+	CLK(NULL,	"fpka_fck",			&fpka_fck,	CK_443X),
 	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_443X),
 	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_443X),
 	CLK(NULL,	"gpio3_ick",			&gpio3_ick,	CK_443X),
@@ -2552,28 +2508,19 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"gpio5_ick",			&gpio5_ick,	CK_443X),
 	CLK(NULL,	"gpio6_ick",			&gpio6_ick,	CK_443X),
 	CLK(NULL,	"gpmc_ick",			&gpmc_ick,	CK_443X),
-	CLK(NULL,	"gpt1_fck",			&gpt1_fck,	CK_443X),
-	CLK(NULL,	"gpt10_fck",			&gpt10_fck,	CK_443X),
-	CLK(NULL,	"gpt11_fck",			&gpt11_fck,	CK_443X),
-	CLK(NULL,	"gpt2_fck",			&gpt2_fck,	CK_443X),
-	CLK(NULL,	"gpt3_fck",			&gpt3_fck,	CK_443X),
-	CLK(NULL,	"gpt4_fck",			&gpt4_fck,	CK_443X),
-	CLK(NULL,	"gpt5_fck",			&gpt5_fck,	CK_443X),
-	CLK(NULL,	"gpt6_fck",			&gpt6_fck,	CK_443X),
-	CLK(NULL,	"gpt7_fck",			&gpt7_fck,	CK_443X),
-	CLK(NULL,	"gpt8_fck",			&gpt8_fck,	CK_443X),
-	CLK(NULL,	"gpt9_fck",			&gpt9_fck,	CK_443X),
+	CLK(NULL,	"gpu_fck",			&gpu_fck,	CK_443X),
 	CLK("omap2_hdq.0",	"fck",				&hdq1w_fck,	CK_443X),
-	CLK(NULL,	"hsi_ick",			&hsi_ick,	CK_443X),
+	CLK(NULL,	"hsi_fck",			&hsi_fck,	CK_443X),
 	CLK("i2c_omap.1",	"fck",				&i2c1_fck,	CK_443X),
 	CLK("i2c_omap.2",	"fck",				&i2c2_fck,	CK_443X),
 	CLK("i2c_omap.3",	"fck",				&i2c3_fck,	CK_443X),
 	CLK("i2c_omap.4",	"fck",				&i2c4_fck,	CK_443X),
+	CLK(NULL,	"ipu_fck",			&ipu_fck,	CK_443X),
 	CLK(NULL,	"iss_fck",			&iss_fck,	CK_443X),
-	CLK(NULL,	"ivahd_ick",			&ivahd_ick,	CK_443X),
-	CLK(NULL,	"keyboard_fck",			&keyboard_fck,	CK_443X),
-	CLK(NULL,	"l3_instr_interconnect_ick",	&l3_instr_interconnect_ick,	CK_443X),
-	CLK(NULL,	"l3_interconnect_3_ick",	&l3_interconnect_3_ick,	CK_443X),
+	CLK(NULL,	"iva_fck",			&iva_fck,	CK_443X),
+	CLK(NULL,	"kbd_fck",			&kbd_fck,	CK_443X),
+	CLK(NULL,	"l3_instr_ick",			&l3_instr_ick,	CK_443X),
+	CLK(NULL,	"l3_main_3_ick",		&l3_main_3_ick,	CK_443X),
 	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"mcasp_fck",			&mcasp_fck,	CK_443X),
 	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck,	CK_443X),
@@ -2584,6 +2531,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap-mcbsp.3",	"fck",				&mcbsp3_fck,	CK_443X),
 	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck,	CK_443X),
 	CLK("omap-mcbsp.4",	"fck",				&mcbsp4_fck,	CK_443X),
+	CLK(NULL,	"mcpdm_fck",			&mcpdm_fck,	CK_443X),
 	CLK("omap2_mcspi.1",	"fck",				&mcspi1_fck,	CK_443X),
 	CLK("omap2_mcspi.2",	"fck",				&mcspi2_fck,	CK_443X),
 	CLK("omap2_mcspi.3",	"fck",				&mcspi3_fck,	CK_443X),
@@ -2593,30 +2541,37 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("mmci-omap-hs.2",	"fck",				&mmc3_fck,	CK_443X),
 	CLK("mmci-omap-hs.3",	"fck",				&mmc4_fck,	CK_443X),
 	CLK("mmci-omap-hs.4",	"fck",				&mmc5_fck,	CK_443X),
-	CLK(NULL,	"ocp_wp1_ick",			&ocp_wp1_ick,	CK_443X),
-	CLK(NULL,	"pdm_fck",			&pdm_fck,	CK_443X),
-	CLK(NULL,	"pkaeip29_fck",			&pkaeip29_fck,	CK_443X),
+	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_443X),
 	CLK("omap_rng",	"ick",				&rng_ick,	CK_443X),
-	CLK(NULL,	"sha2md51_fck",			&sha2md51_fck,	CK_443X),
-	CLK(NULL,	"sl2_ick",			&sl2_ick,	CK_443X),
+	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_443X),
+	CLK(NULL,	"sl2if_ick",			&sl2if_ick,	CK_443X),
 	CLK(NULL,	"slimbus1_fck",			&slimbus1_fck,	CK_443X),
 	CLK(NULL,	"slimbus2_fck",			&slimbus2_fck,	CK_443X),
-	CLK(NULL,	"sr_core_fck",			&sr_core_fck,	CK_443X),
-	CLK(NULL,	"sr_iva_fck",			&sr_iva_fck,	CK_443X),
-	CLK(NULL,	"sr_mpu_fck",			&sr_mpu_fck,	CK_443X),
-	CLK(NULL,	"tesla_ick",			&tesla_ick,	CK_443X),
+	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
+	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
+	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
+	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
+	CLK(NULL,	"gpt10_fck",			&timer10_fck,	CK_443X),
+	CLK(NULL,	"gpt11_fck",			&timer11_fck,	CK_443X),
+	CLK(NULL,	"gpt2_fck",			&timer2_fck,	CK_443X),
+	CLK(NULL,	"gpt3_fck",			&timer3_fck,	CK_443X),
+	CLK(NULL,	"gpt4_fck",			&timer4_fck,	CK_443X),
+	CLK(NULL,	"gpt5_fck",			&timer5_fck,	CK_443X),
+	CLK(NULL,	"gpt6_fck",			&timer6_fck,	CK_443X),
+	CLK(NULL,	"gpt7_fck",			&timer7_fck,	CK_443X),
+	CLK(NULL,	"gpt8_fck",			&timer8_fck,	CK_443X),
+	CLK(NULL,	"gpt9_fck",			&timer9_fck,	CK_443X),
 	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_443X),
 	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
 	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
 	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_443X),
-	CLK(NULL,	"unipro1_fck",			&unipro1_fck,	CK_443X),
-	CLK(NULL,	"usb_host_fck",			&usb_host_fck,	CK_443X),
 	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
-	CLK("musb_hdrc",	"ick",				&usb_otg_ick,	CK_443X),
-	CLK(NULL,	"usb_tll_ick",			&usb_tll_ick,	CK_443X),
-	CLK(NULL,	"usim_ick",			&usim_ick,	CK_443X),
-	CLK("omap_wdt",	"fck",				&wdt2_fck,	CK_443X),
-	CLK(NULL,	"wdt3_fck",			&wdt3_fck,	CK_443X),
+	CLK(NULL,	"usb_host_hs_fck",		&usb_host_hs_fck,	CK_443X),
+	CLK("musb_hdrc",	"ick",				&usb_otg_hs_ick,	CK_443X),
+	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick,	CK_443X),
+	CLK(NULL,	"usim_fck",			&usim_fck,	CK_443X),
+	CLK("omap_wdt",	"fck",				&wd_timer2_fck,	CK_443X),
+	CLK(NULL,	"wd_timer3_fck",		&wd_timer3_fck,	CK_443X),
 	CLK(NULL,	"otg_60m_gfclk_ck",		&otg_60m_gfclk_ck,	CK_443X),
 	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_443X),
 	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_443X),
@@ -2645,19 +2600,19 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("i2c_omap.2",	"ick",				&dummy_ck,	CK_443X),
 	CLK("i2c_omap.3",	"ick",				&dummy_ck,	CK_443X),
 	CLK("i2c_omap.4",	"ick",				&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.0",	"ick",				&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.1",	"ick",				&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.2",	"ick",				&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.3",	"ick",				&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.4",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.1",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.2",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.3",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.1",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.2",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.3",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.4",	"ick",			&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.0",	"ick",		&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.1",	"ick",		&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.2",	"ick",		&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.3",	"ick",		&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.4",	"ick",		&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.1",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.2",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.3",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.4",	"ick",				&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),


