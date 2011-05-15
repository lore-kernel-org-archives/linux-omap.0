From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: [PATCHv2 2/2] [RFC] OMAP4: clock data: shrink more clock data.
Date: Mon, 16 May 2011 00:45:58 +0300
Message-ID: <1305495958-2236-3-git-send-email-vzapolskiy@gmail.com>
References: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42796 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab1EOVqN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 May 2011 17:46:13 -0400
Received: by eyx24 with SMTP id 24so1105260eyx.19
        for <linux-omap@vger.kernel.org>; Sun, 15 May 2011 14:46:11 -0700 (PDT)
In-Reply-To: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vzapolskiy@gmail.com>

This mass change continues the reduction of homogeneous data chunks
along clock definitions. No semantical difference is added in the
change.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
---
 arch/arm/mach-omap2/clock44xx_data.c | 1675 ++++++++--------------------------
 1 files changed, 378 insertions(+), 1297 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 423f180..ccbc29e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -846,1395 +846,524 @@ DEFINE_CLOCK_DM(emif2_fck, ddrphy_ck, l3_emif_clkdm,
 DEFINE_CLKSEL(fdif_fclk_div, dpll_per_m4x2_ck, div3_1to4_rates);
 
 /* Merged fdif_fclk into fdif */
-static struct clk fdif_fck = {
-	.name		= "fdif_fck",
-	.parent		= &dpll_per_m4x2_ck,
-	.clksel		= fdif_fclk_div,
-	.clksel_reg	= OMAP4430_CM_CAM_FDIF_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_FCLK_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-	.enable_reg	= OMAP4430_CM_CAM_FDIF_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "iss_clkdm",
-};
+DEFINE_CLOCK_DM(fdif_fck, dpll_per_m4x2_ck, iss_clkdm,
+		CLOCK_OPS_DFLT_SW(CM_CAM_FDIF),
+		CLOCK_CLKSEL(fdif_fclk_div, CM_CAM_FDIF_CLKCTRL, CLKSEL_FCLK));
 
-static struct clk fpka_fck = {
-	.name		= "fpka_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_secure_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(fpka_fck, l4_div_ck, l4_secure_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4SEC_PKAEIP29));
 
-static struct clk gpio1_dbclk = {
-	.name		= "gpio1_dbclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio1_dbclk, sys_32k_ck, l4_wkup_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_WKUP_GPIO1, OPTFCLKEN_DBCLK));
 
-static struct clk gpio1_ick = {
-	.name		= "gpio1_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &l4_wkup_clk_mux_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio1_ick, l4_wkup_clk_mux_ck, l4_wkup_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_WKUP_GPIO1));
 
-static struct clk gpio2_dbclk = {
-	.name		= "gpio2_dbclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio2_dbclk, sys_32k_ck, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L4PER_GPIO2, OPTFCLKEN_DBCLK));
 
-static struct clk gpio2_ick = {
-	.name		= "gpio2_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio2_ick, l4_div_ck, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_L4PER_GPIO2));
 
-static struct clk gpio3_dbclk = {
-	.name		= "gpio3_dbclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio3_dbclk, sys_32k_ck, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L4PER_GPIO3, OPTFCLKEN_DBCLK));
 
-static struct clk gpio3_ick = {
-	.name		= "gpio3_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio3_ick, l4_div_ck, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_L4PER_GPIO3));
 
-static struct clk gpio4_dbclk = {
-	.name		= "gpio4_dbclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio4_dbclk, sys_32k_ck, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L4PER_GPIO4, OPTFCLKEN_DBCLK));
 
-static struct clk gpio4_ick = {
-	.name		= "gpio4_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio4_ick, l4_div_ck, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_L4PER_GPIO4));
 
-static struct clk gpio5_dbclk = {
-	.name		= "gpio5_dbclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio5_dbclk, sys_32k_ck, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L4PER_GPIO5, OPTFCLKEN_DBCLK));
 
-static struct clk gpio5_ick = {
-	.name		= "gpio5_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio5_ick, l4_div_ck, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_L4PER_GPIO5));
 
-static struct clk gpio6_dbclk = {
-	.name		= "gpio6_dbclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio6_dbclk, sys_32k_ck, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L4PER_GPIO6, OPTFCLKEN_DBCLK));
 
-static struct clk gpio6_ick = {
-	.name		= "gpio6_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpio6_ick, l4_div_ck, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_L4PER_GPIO6));
 
-static struct clk gpmc_ick = {
-	.name		= "gpmc_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3_2_GPMC_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_2_clkdm",
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(gpmc_ick, l3_div_ck, l3_2_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_L3_2_GPMC));
 
-static const struct clksel sgx_clk_mux_sel[] = {
-	{ .parent = &dpll_core_m7x2_ck, .rates = div_1_0_rates },
-	{ .parent = &dpll_per_m7x2_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL2(sgx_clk_mux_sel, dpll_core_m7x2_ck, dpll_per_m7x2_ck);
 
 /* Merged sgx_clk_mux into gpu */
-static struct clk gpu_fck = {
-	.name		= "gpu_fck",
-	.parent		= &dpll_core_m7x2_ck,
-	.clksel		= sgx_clk_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_SGX_FCLK_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_gfx_clkdm",
-};
+DEFINE_CLOCK_DM(gpu_fck, dpll_core_m7x2_ck, l3_gfx_clkdm,
+		CLOCK_OPS_DFLT_SW(CM_GFX_GFX),
+		CLOCK_CLKSEL0(sgx_clk_mux_sel,
+			      CM_GFX_GFX_CLKCTRL, CLKSEL_SGX_FCLK));
 
-static struct clk hdq1w_fck = {
-	.name		= "hdq1w_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_HDQ1W_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_12m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(hdq1w_fck, func_12m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_HDQ1W));
 
-static const struct clksel hsi_fclk_div[] = {
-	{ .parent = &dpll_per_m2x2_ck, .rates = div3_1to4_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL(hsi_fclk_div, dpll_per_m2x2_ck, div3_1to4_rates);
 
 /* Merged hsi_fclk into hsi */
-static struct clk hsi_fck = {
-	.name		= "hsi_fck",
-	.parent		= &dpll_per_m2x2_ck,
-	.clksel		= hsi_fclk_div,
-	.clksel_reg	= OMAP4430_CM_L3INIT_HSI_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_24_25_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-	.enable_reg	= OMAP4430_CM_L3INIT_HSI_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-};
+DEFINE_CLOCK_DM(hsi_fck, dpll_per_m2x2_ck, l3_init_clkdm,
+		CLOCK_OPS_DFLT_HW(CM_L3INIT_HSI),
+		CLOCK_CLKSEL(hsi_fclk_div,
+			     CM_L3INIT_HSI_CLKCTRL, CLKSEL_24_25));
 
-static struct clk i2c1_fck = {
-	.name		= "i2c1_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_I2C1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_96m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(i2c1_fck, func_96m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_I2C1));
 
-static struct clk i2c2_fck = {
-	.name		= "i2c2_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_I2C2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_96m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(i2c2_fck, func_96m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_I2C2));
 
-static struct clk i2c3_fck = {
-	.name		= "i2c3_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_I2C3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_96m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(i2c3_fck, func_96m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_I2C3));
 
-static struct clk i2c4_fck = {
-	.name		= "i2c4_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_I2C4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_96m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(i2c4_fck, func_96m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_I2C4));
 
-static struct clk ipu_fck = {
-	.name		= "ipu_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "ducati_clkdm",
-	.parent		= &ducati_clk_mux_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(ipu_fck, ducati_clk_mux_ck, ducati_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_DUCATI_DUCATI));
 
-static struct clk iss_ctrlclk = {
-	.name		= "iss_ctrlclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_CAM_ISS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_CTRLCLK_SHIFT,
-	.clkdm_name	= "iss_clkdm",
-	.parent		= &func_96m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(iss_ctrlclk, func_96m_fclk, iss_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_CAM_ISS, OPTFCLKEN_CTRLCLK));
 
-static struct clk iss_fck = {
-	.name		= "iss_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_CAM_ISS_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "iss_clkdm",
-	.parent		= &ducati_clk_mux_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(iss_fck, ducati_clk_mux_ck, iss_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_CAM_ISS));
 
-static struct clk iva_fck = {
-	.name		= "iva_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "ivahd_clkdm",
-	.parent		= &dpll_iva_m5x2_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(iva_fck, dpll_iva_m5x2_ck, ivahd_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_IVAHD_IVAHD));
 
-static struct clk kbd_fck = {
-	.name		= "kbd_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(kbd_fck, sys_32k_ck, l4_wkup_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_WKUP_KEYBOARD));
 
-static struct clk l3_instr_ick = {
-	.name		= "l3_instr_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_instr_clkdm",
-	.flags		= ENABLE_ON_INIT,
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(l3_instr_ick, l3_div_ck, l3_instr_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_L3INSTR_L3_INSTR),
+		CLOCK_FLAGS_ENABLE());
 
-static struct clk l3_main_3_ick = {
-	.name		= "l3_main_3_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INSTR_L3_3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_instr_clkdm",
-	.flags		= ENABLE_ON_INIT,
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(l3_main_3_ick, l3_div_ck, l3_instr_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_L3INSTR_L3_3),
+		CLOCK_FLAGS_ENABLE());
 
-static struct clk mcasp_sync_mux_ck = {
-	.name		= "mcasp_sync_mux_ck",
-	.parent		= &abe_24m_fclk,
-	.clksel		= dmic_sync_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_MCASP_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(mcasp_sync_mux_ck, abe_24m_fclk,
+	     CLOCK_CLKSEL_INIT(dmic_sync_mux_sel,
+			       CM1_ABE_MCASP_CLKCTRL, CLKSEL_INTERNAL_SOURCE));
 
-static const struct clksel func_mcasp_abe_gfclk_sel[] = {
-	{ .parent = &mcasp_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL3(func_mcasp_abe_gfclk_sel,
+	       mcasp_sync_mux_ck, pad_clks_ck, slimbus_clk);
 
 /* Merged func_mcasp_abe_gfclk into mcasp */
-static struct clk mcasp_fck = {
-	.name		= "mcasp_fck",
-	.parent		= &mcasp_sync_mux_ck,
-	.clksel		= func_mcasp_abe_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_MCASP_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_MCASP_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
+DEFINE_CLOCK_DM(mcasp_fck, mcasp_sync_mux_ck, abe_clkdm,
+		CLOCK_CLKSEL_INIT_SW(func_mcasp_abe_gfclk_sel,
+				     CM1_ABE_MCASP, CLKSEL_SOURCE));
 
-static struct clk mcbsp1_sync_mux_ck = {
-	.name		= "mcbsp1_sync_mux_ck",
-	.parent		= &abe_24m_fclk,
-	.clksel		= dmic_sync_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(mcbsp1_sync_mux_ck, abe_24m_fclk,
+	     CLOCK_CLKSEL_INIT(dmic_sync_mux_sel,
+			       CM1_ABE_MCBSP1_CLKCTRL, CLKSEL_INTERNAL_SOURCE));
 
-static const struct clksel func_mcbsp1_gfclk_sel[] = {
-	{ .parent = &mcbsp1_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL3(func_mcbsp1_gfclk_sel,
+	       mcbsp1_sync_mux_ck, pad_clks_ck, slimbus_clk);
 
 /* Merged func_mcbsp1_gfclk into mcbsp1 */
-static struct clk mcbsp1_fck = {
-	.name		= "mcbsp1_fck",
-	.parent		= &mcbsp1_sync_mux_ck,
-	.clksel		= func_mcbsp1_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
+DEFINE_CLOCK_DM(mcbsp1_fck, mcbsp1_sync_mux_ck, abe_clkdm,
+		CLOCK_CLKSEL_INIT_SW(func_mcbsp1_gfclk_sel,
+				     CM1_ABE_MCBSP1, CLKSEL_SOURCE));
 
-static struct clk mcbsp2_sync_mux_ck = {
-	.name		= "mcbsp2_sync_mux_ck",
-	.parent		= &abe_24m_fclk,
-	.clksel		= dmic_sync_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(mcbsp2_sync_mux_ck, abe_24m_fclk,
+	     CLOCK_CLKSEL_INIT(dmic_sync_mux_sel,
+			       CM1_ABE_MCBSP2_CLKCTRL, CLKSEL_INTERNAL_SOURCE));
 
-static const struct clksel func_mcbsp2_gfclk_sel[] = {
-	{ .parent = &mcbsp2_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL3(func_mcbsp2_gfclk_sel,
+	       mcbsp2_sync_mux_ck, pad_clks_ck, slimbus_clk);
 
 /* Merged func_mcbsp2_gfclk into mcbsp2 */
-static struct clk mcbsp2_fck = {
-	.name		= "mcbsp2_fck",
-	.parent		= &mcbsp2_sync_mux_ck,
-	.clksel		= func_mcbsp2_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
+DEFINE_CLOCK_DM(mcbsp2_fck, mcbsp2_sync_mux_ck, abe_clkdm,
+		CLOCK_CLKSEL_INIT_SW(func_mcbsp2_gfclk_sel,
+				     CM1_ABE_MCBSP2, CLKSEL_SOURCE));
 
-static struct clk mcbsp3_sync_mux_ck = {
-	.name		= "mcbsp3_sync_mux_ck",
-	.parent		= &abe_24m_fclk,
-	.clksel		= dmic_sync_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(mcbsp3_sync_mux_ck, abe_24m_fclk,
+	     CLOCK_CLKSEL_INIT(dmic_sync_mux_sel,
+			       CM1_ABE_MCBSP3_CLKCTRL, CLKSEL_INTERNAL_SOURCE));
 
-static const struct clksel func_mcbsp3_gfclk_sel[] = {
-	{ .parent = &mcbsp3_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL3(func_mcbsp3_gfclk_sel,
+	       mcbsp3_sync_mux_ck, pad_clks_ck, slimbus_clk);
 
 /* Merged func_mcbsp3_gfclk into mcbsp3 */
-static struct clk mcbsp3_fck = {
-	.name		= "mcbsp3_fck",
-	.parent		= &mcbsp3_sync_mux_ck,
-	.clksel		= func_mcbsp3_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
+DEFINE_CLOCK_DM(mcbsp3_fck, mcbsp3_sync_mux_ck, abe_clkdm,
+		CLOCK_CLKSEL_INIT_SW(func_mcbsp3_gfclk_sel,
+				     CM1_ABE_MCBSP3, CLKSEL_SOURCE));
 
-static struct clk mcbsp4_sync_mux_ck = {
-	.name		= "mcbsp4_sync_mux_ck",
-	.parent		= &func_96m_fclk,
-	.clksel		= mcasp2_fclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(mcbsp4_sync_mux_ck, func_96m_fclk,
+	     CLOCK_CLKSEL_INIT(mcasp2_fclk_sel,
+			       CM_L4PER_MCBSP4_CLKCTRL,
+			       CLKSEL_INTERNAL_SOURCE));
 
-static const struct clksel per_mcbsp4_gfclk_sel[] = {
-	{ .parent = &mcbsp4_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL2(per_mcbsp4_gfclk_sel, mcbsp4_sync_mux_ck, pad_clks_ck);
 
 /* Merged per_mcbsp4_gfclk into mcbsp4 */
-static struct clk mcbsp4_fck = {
-	.name		= "mcbsp4_fck",
-	.parent		= &mcbsp4_sync_mux_ck,
-	.clksel		= per_mcbsp4_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_24_24_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-};
+DEFINE_CLOCK_DM(mcbsp4_fck, mcbsp4_sync_mux_ck, l4_per_clkdm,
+		CLOCK_CLKSEL_INIT_SW(per_mcbsp4_gfclk_sel,
+				     CM_L4PER_MCBSP4, CLKSEL_SOURCE_24_24));
 
-static struct clk mcpdm_fck = {
-	.name		= "mcpdm_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_PDM_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &pad_clks_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(mcpdm_fck, pad_clks_ck, abe_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM1_ABE_PDM));
 
-static struct clk mcspi1_fck = {
-	.name		= "mcspi1_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(mcspi1_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_MCSPI1));
 
-static struct clk mcspi2_fck = {
-	.name		= "mcspi2_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(mcspi2_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_MCSPI2));
 
-static struct clk mcspi3_fck = {
-	.name		= "mcspi3_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(mcspi3_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_MCSPI3));
 
-static struct clk mcspi4_fck = {
-	.name		= "mcspi4_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(mcspi4_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_MCSPI4));
 
 /* Merged hsmmc1_fclk into mmc1 */
-static struct clk mmc1_fck = {
-	.name		= "mmc1_fck",
-	.parent		= &func_64m_fclk,
-	.clksel		= hsmmc6_fclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-};
+DEFINE_CLOCK_DM(mmc1_fck, func_64m_fclk, l3_init_clkdm,
+		CLOCK_CLKSEL_INIT_SW(hsmmc6_fclk_sel, CM_L3INIT_MMC1, CLKSEL));
 
 /* Merged hsmmc2_fclk into mmc2 */
-static struct clk mmc2_fck = {
-	.name		= "mmc2_fck",
-	.parent		= &func_64m_fclk,
-	.clksel		= hsmmc6_fclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L3INIT_MMC2_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L3INIT_MMC2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-};
+DEFINE_CLOCK_DM(mmc2_fck, func_64m_fclk, l3_init_clkdm,
+		CLOCK_CLKSEL_INIT_SW(hsmmc6_fclk_sel, CM_L3INIT_MMC2, CLKSEL));
 
-static struct clk mmc3_fck = {
-	.name		= "mmc3_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MMCSD3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(mmc3_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_OPS_DFLT_SW(CM_L4PER_MMCSD3),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk mmc4_fck = {
-	.name		= "mmc4_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MMCSD4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(mmc4_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_OPS_DFLT_SW(CM_L4PER_MMCSD4),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk mmc5_fck = {
-	.name		= "mmc5_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MMCSD5_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(mmc5_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_OPS_DFLT_SW(CM_L4PER_MMCSD5),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk ocp2scp_usb_phy_phy_48m = {
-	.name		= "ocp2scp_usb_phy_phy_48m",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_PHY_48M_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(ocp2scp_usb_phy_phy_48m, func_48m_fclk, l3_init_clkdm,
+		CLOCK_OPS_DFLT(CM_L3INIT_USBPHYOCP2SCP, OPTFCLKEN_PHY_48M),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk ocp2scp_usb_phy_ick = {
-	.name		= "ocp2scp_usb_phy_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(ocp2scp_usb_phy_ick, l4_div_ck, l3_init_clkdm,
+		CLOCK_OPS_DFLT_HW(CM_L3INIT_USBPHYOCP2SCP),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk ocp_wp_noc_ick = {
-	.name		= "ocp_wp_noc_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_instr_clkdm",
-	.flags		= ENABLE_ON_INIT,
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(ocp_wp_noc_ick, l3_div_ck, l3_instr_clkdm,
+		CLOCK_OPS_DFLT_HW(CM_L3INSTR_OCP_WP1),
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_FLAGS_ENABLE());
 
-static struct clk rng_ick = {
-	.name		= "rng_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4SEC_RNG_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_secure_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(rng_ick, l4_div_ck, l4_secure_clkdm,
+		CLOCK_OPS_DFLT_HW(CM_L4SEC_RNG),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk sha2md5_fck = {
-	.name		= "sha2md5_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_secure_clkdm",
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(sha2md5_fck, l3_div_ck, l4_secure_clkdm,
+		CLOCK_OPS_DFLT_SW(CM_L4SEC_SHA2MD51),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk sl2if_ick = {
-	.name		= "sl2if_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_IVAHD_SL2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "ivahd_clkdm",
-	.parent		= &dpll_iva_m5x2_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(sl2if_ick, dpll_iva_m5x2_ck, ivahd_clkdm,
+		CLOCK_OPS_DFLT_HW(CM_IVAHD_SL2),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk slimbus1_fclk_1 = {
-	.name		= "slimbus1_fclk_1",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK1_SHIFT,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &func_24m_clk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(slimbus1_fclk_0, abe_24m_fclk, abe_clkdm,
+		CLOCK_OPS_DFLT(CM1_ABE_SLIMBUS, OPTFCLKEN_FCLK0),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk slimbus1_fclk_0 = {
-	.name		= "slimbus1_fclk_0",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK0_SHIFT,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &abe_24m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(slimbus1_fclk_1, func_24m_clk, abe_clkdm,
+		CLOCK_OPS_DFLT(CM1_ABE_SLIMBUS, OPTFCLKEN_FCLK1),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk slimbus1_fclk_2 = {
-	.name		= "slimbus1_fclk_2",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK2_SHIFT,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &pad_clks_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(slimbus1_fclk_2, pad_clks_ck, abe_clkdm,
+		CLOCK_OPS_DFLT(CM1_ABE_SLIMBUS, OPTFCLKEN_FCLK2),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk slimbus1_slimbus_clk = {
-	.name		= "slimbus1_slimbus_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_SLIMBUS_CLK_11_11_SHIFT,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &slimbus_clk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(slimbus1_slimbus_clk, slimbus_clk, abe_clkdm,
+		CLOCK_OPS_DFLT(CM1_ABE_SLIMBUS, OPTFCLKEN_SLIMBUS_CLK_11_11),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk slimbus1_fck = {
-	.name		= "slimbus1_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &ocp_abe_iclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(slimbus1_fck, ocp_abe_iclk, abe_clkdm,
+		CLOCK_OPS_DFLT_SW(CM1_ABE_SLIMBUS),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk slimbus2_fclk_1 = {
-	.name		= "slimbus2_fclk_1",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_PERABE24M_GFCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &per_abe_24m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(slimbus2_fclk_1, per_abe_24m_fclk, l4_per_clkdm,
+		CLOCK_OPS_DFLT(CM_L4PER_SLIMBUS2, OPTFCLKEN_PERABE24M_GFCLK),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk slimbus2_fclk_0 = {
-	.name		= "slimbus2_fclk_0",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_PER24MC_GFCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_24mc_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(slimbus2_fclk_0, func_24mc_fclk, l4_per_clkdm,
+		CLOCK_OPS_DFLT(CM_L4PER_SLIMBUS2, OPTFCLKEN_PER24MC_GFCLK),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk slimbus2_slimbus_clk = {
-	.name		= "slimbus2_slimbus_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_SLIMBUS_CLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &pad_slimbus_core_clks_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(slimbus2_slimbus_clk, pad_slimbus_core_clks_ck, l4_per_clkdm,
+		CLOCK_OPS_DFLT(CM_L4PER_SLIMBUS2, OPTFCLKEN_SLIMBUS_CLK),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk slimbus2_fck = {
-	.name		= "slimbus2_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(slimbus2_fck, l4_div_ck, l4_per_clkdm,
+		CLOCK_OPS_DFLT_SW(CM_L4PER_SLIMBUS2),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk smartreflex_core_fck = {
-	.name		= "smartreflex_core_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_ao_clkdm",
-	.parent		= &l4_wkup_clk_mux_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(smartreflex_core_fck, l4_wkup_clk_mux_ck, l4_ao_clkdm,
+		CLOCK_OPS_DFLT_SW(CM_ALWON_SR_CORE),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk smartreflex_iva_fck = {
-	.name		= "smartreflex_iva_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_ao_clkdm",
-	.parent		= &l4_wkup_clk_mux_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(smartreflex_iva_fck, l4_wkup_clk_mux_ck, l4_ao_clkdm,
+		CLOCK_OPS_DFLT_SW(CM_ALWON_SR_IVA),
+		CLOCK_RECALC_FOLLOWPARENT());
 
-static struct clk smartreflex_mpu_fck = {
-	.name		= "smartreflex_mpu_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_ao_clkdm",
-	.parent		= &l4_wkup_clk_mux_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(smartreflex_mpu_fck, l4_wkup_clk_mux_ck, l4_ao_clkdm,
+		CLOCK_OPS_DFLT_SW(CM_ALWON_SR_MPU),
+		CLOCK_RECALC_FOLLOWPARENT());
 
 /* Merged dmt1_clk_mux into timer1 */
-static struct clk timer1_fck = {
-	.name		= "timer1_fck",
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
+DEFINE_CLOCK_DM(timer1_fck, sys_clkin_ck, l4_wkup_clkdm,
+		CLOCK_CLKSEL_INIT_SW(abe_dpll_bypass_clk_mux_sel,
+				     CM_WKUP_TIMER1, CLKSEL));
 
 /* Merged cm2_dm10_mux into timer10 */
-static struct clk timer10_fck = {
-	.name		= "timer10_fck",
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
+DEFINE_CLOCK_DM(timer10_fck, sys_clkin_ck, l4_per_clkdm,
+		CLOCK_CLKSEL_INIT_SW(abe_dpll_bypass_clk_mux_sel,
+				     CM_L4PER_DMTIMER10, CLKSEL));
 
 /* Merged cm2_dm11_mux into timer11 */
-static struct clk timer11_fck = {
-	.name		= "timer11_fck",
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
+DEFINE_CLOCK_DM(timer11_fck, sys_clkin_ck, l4_per_clkdm,
+		CLOCK_CLKSEL_INIT_SW(abe_dpll_bypass_clk_mux_sel,
+				     CM_L4PER_DMTIMER11, CLKSEL));
 
 /* Merged cm2_dm2_mux into timer2 */
-static struct clk timer2_fck = {
-	.name		= "timer2_fck",
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
+DEFINE_CLOCK_DM(timer2_fck, sys_clkin_ck, l4_per_clkdm,
+		CLOCK_CLKSEL_INIT_SW(abe_dpll_bypass_clk_mux_sel,
+				     CM_L4PER_DMTIMER2, CLKSEL));
 
 /* Merged cm2_dm3_mux into timer3 */
-static struct clk timer3_fck = {
-	.name		= "timer3_fck",
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
+DEFINE_CLOCK_DM(timer3_fck, sys_clkin_ck, l4_per_clkdm,
+		CLOCK_CLKSEL_INIT_SW(abe_dpll_bypass_clk_mux_sel,
+				     CM_L4PER_DMTIMER3, CLKSEL));
 
 /* Merged cm2_dm4_mux into timer4 */
-static struct clk timer4_fck = {
-	.name		= "timer4_fck",
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
+DEFINE_CLOCK_DM(timer4_fck, sys_clkin_ck, l4_per_clkdm,
+		CLOCK_CLKSEL_INIT_SW(abe_dpll_bypass_clk_mux_sel,
+				     CM_L4PER_DMTIMER4, CLKSEL));
 
-static const struct clksel timer5_sync_mux_sel[] = {
-	{ .parent = &syc_clk_div_ck, .rates = div_1_0_rates },
-	{ .parent = &sys_32k_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL2(timer5_sync_mux_sel, syc_clk_div_ck, sys_32k_ck);
 
 /* Merged timer5_sync_mux into timer5 */
-static struct clk timer5_fck = {
-	.name		= "timer5_fck",
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
+DEFINE_CLOCK_DM(timer5_fck, syc_clk_div_ck, abe_clkdm,
+		CLOCK_CLKSEL_INIT_SW(timer5_sync_mux_sel,
+				     CM1_ABE_TIMER5, CLKSEL));
 
 /* Merged timer6_sync_mux into timer6 */
-static struct clk timer6_fck = {
-	.name		= "timer6_fck",
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
+DEFINE_CLOCK_DM(timer6_fck, syc_clk_div_ck, abe_clkdm,
+		CLOCK_CLKSEL_INIT_SW(timer5_sync_mux_sel,
+				     CM1_ABE_TIMER6, CLKSEL));
 
 /* Merged timer7_sync_mux into timer7 */
-static struct clk timer7_fck = {
-	.name		= "timer7_fck",
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
+DEFINE_CLOCK_DM(timer7_fck, syc_clk_div_ck, abe_clkdm,
+		CLOCK_CLKSEL_INIT_SW(timer5_sync_mux_sel,
+				     CM1_ABE_TIMER7, CLKSEL));
 
 /* Merged timer8_sync_mux into timer8 */
-static struct clk timer8_fck = {
-	.name		= "timer8_fck",
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
+DEFINE_CLOCK_DM(timer8_fck, syc_clk_div_ck, abe_clkdm,
+		CLOCK_CLKSEL_INIT_SW(timer5_sync_mux_sel,
+				     CM1_ABE_TIMER8, CLKSEL));
 
 /* Merged cm2_dm9_mux into timer9 */
-static struct clk timer9_fck = {
-	.name		= "timer9_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-};
+DEFINE_CLOCK_DM(timer9_fck, sys_clkin_ck, l4_per_clkdm,
+		CLOCK_CLKSEL_INIT_SW(abe_dpll_bypass_clk_mux_sel,
+				     CM_L4PER_DMTIMER9, CLKSEL));
 
-static struct clk uart1_fck = {
-	.name		= "uart1_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_UART1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(uart1_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_UART1));
 
-static struct clk uart2_fck = {
-	.name		= "uart2_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_UART2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(uart2_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_UART2));
 
-static struct clk uart3_fck = {
-	.name		= "uart3_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_UART3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(uart3_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_UART3));
 
-static struct clk uart4_fck = {
-	.name		= "uart4_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_UART4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(uart4_fck, func_48m_fclk, l4_per_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L4PER_UART4));
 
-static struct clk usb_host_fs_fck = {
-	.name		= "usb_host_fs_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &func_48mc_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_host_fs_fck, func_48mc_fclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L3INIT_USB_HOST_FS));
 
-static const struct clksel utmi_p1_gfclk_sel[] = {
-	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
-	{ .parent = &xclk60mhsp1_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL2(utmi_p1_gfclk_sel, init_60m_fclk, xclk60mhsp1_ck);
 
-static struct clk utmi_p1_gfclk = {
-	.name		= "utmi_p1_gfclk",
-	.parent		= &init_60m_fclk,
-	.clksel		= utmi_p1_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P1_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(utmi_p1_gfclk, init_60m_fclk,
+	     CLOCK_CLKSEL_INIT(utmi_p1_gfclk_sel,
+			       CM_L3INIT_USB_HOST_CLKCTRL, CLKSEL_UTMI_P1));
 
-static struct clk usb_host_hs_utmi_p1_clk = {
-	.name		= "usb_host_hs_utmi_p1_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P1_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &utmi_p1_gfclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_host_hs_utmi_p1_clk, utmi_p1_gfclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_HOST, OPTFCLKEN_UTMI_P1_CLK));
 
-static const struct clksel utmi_p2_gfclk_sel[] = {
-	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
-	{ .parent = &xclk60mhsp2_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL2(utmi_p2_gfclk_sel, init_60m_fclk, xclk60mhsp2_ck);
 
-static struct clk utmi_p2_gfclk = {
-	.name		= "utmi_p2_gfclk",
-	.parent		= &init_60m_fclk,
-	.clksel		= utmi_p2_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P2_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(utmi_p2_gfclk, init_60m_fclk,
+	     CLOCK_CLKSEL_INIT(utmi_p2_gfclk_sel,
+			       CM_L3INIT_USB_HOST_CLKCTRL, CLKSEL_UTMI_P2));
 
-static struct clk usb_host_hs_utmi_p2_clk = {
-	.name		= "usb_host_hs_utmi_p2_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P2_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &utmi_p2_gfclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_host_hs_utmi_p2_clk, utmi_p2_gfclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_HOST, OPTFCLKEN_UTMI_P2_CLK));
 
-static struct clk usb_host_hs_utmi_p3_clk = {
-	.name		= "usb_host_hs_utmi_p3_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P3_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_host_hs_utmi_p3_clk, init_60m_fclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_HOST, OPTFCLKEN_UTMI_P3_CLK));
 
-static struct clk usb_host_hs_hsic480m_p1_clk = {
-	.name		= "usb_host_hs_hsic480m_p1_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC480M_P1_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &dpll_usb_m2_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_host_hs_hsic60m_p1_clk, init_60m_fclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_HOST, OPTFCLKEN_HSIC60M_P1_CLK));
 
-static struct clk usb_host_hs_hsic60m_p1_clk = {
-	.name		= "usb_host_hs_hsic60m_p1_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC60M_P1_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_host_hs_hsic60m_p2_clk, init_60m_fclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_HOST, OPTFCLKEN_HSIC60M_P2_CLK));
 
-static struct clk usb_host_hs_hsic60m_p2_clk = {
-	.name		= "usb_host_hs_hsic60m_p2_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC60M_P2_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_host_hs_hsic480m_p1_clk, dpll_usb_m2_ck, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_HOST, OPTFCLKEN_HSIC480M_P1_CLK));
 
-static struct clk usb_host_hs_hsic480m_p2_clk = {
-	.name		= "usb_host_hs_hsic480m_p2_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC480M_P2_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &dpll_usb_m2_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_host_hs_hsic480m_p2_clk, dpll_usb_m2_ck, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_HOST, OPTFCLKEN_HSIC480M_P2_CLK));
 
-static struct clk usb_host_hs_func48mclk = {
-	.name		= "usb_host_hs_func48mclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_FUNC48MCLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &func_48mc_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_host_hs_func48mclk, func_48mc_fclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_HOST, OPTFCLKEN_FUNC48MCLK));
 
-static struct clk usb_host_hs_fck = {
-	.name		= "usb_host_hs_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_host_hs_fck, init_60m_fclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_L3INIT_USB_HOST));
 
-static const struct clksel otg_60m_gfclk_sel[] = {
-	{ .parent = &utmi_phy_clkout_ck, .rates = div_1_0_rates },
-	{ .parent = &xclk60motg_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL2(otg_60m_gfclk_sel, utmi_phy_clkout_ck, xclk60motg_ck);
 
-static struct clk otg_60m_gfclk = {
-	.name		= "otg_60m_gfclk",
-	.parent		= &utmi_phy_clkout_ck,
-	.clksel		= otg_60m_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_60M_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(otg_60m_gfclk, utmi_phy_clkout_ck,
+	     CLOCK_CLKSEL_INIT(otg_60m_gfclk_sel,
+			       CM_L3INIT_USB_OTG_CLKCTRL, CLKSEL_60M));
 
-static struct clk usb_otg_hs_xclk = {
-	.name		= "usb_otg_hs_xclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_XCLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &otg_60m_gfclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_otg_hs_xclk, otg_60m_gfclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_OTG, OPTFCLKEN_XCLK));
 
-static struct clk usb_otg_hs_ick = {
-	.name		= "usb_otg_hs_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_otg_hs_ick, l3_div_ck, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_L3INIT_USB_OTG));
 
-static struct clk usb_phy_cm_clk32k = {
-	.name		= "usb_phy_cm_clk32k",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_ALWON_USBPHY_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_CLK32K_SHIFT,
-	.clkdm_name	= "l4_ao_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_phy_cm_clk32k, sys_32k_ck, l4_ao_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_ALWON_USBPHY, OPTFCLKEN_CLK32K));
 
-static struct clk usb_tll_hs_usb_ch2_clk = {
-	.name		= "usb_tll_hs_usb_ch2_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH2_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_tll_hs_usb_ch0_clk, init_60m_fclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_TLL, OPTFCLKEN_USB_CH0_CLK));
 
-static struct clk usb_tll_hs_usb_ch0_clk = {
-	.name		= "usb_tll_hs_usb_ch0_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH0_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_tll_hs_usb_ch1_clk, init_60m_fclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_TLL, OPTFCLKEN_USB_CH1_CLK));
 
-static struct clk usb_tll_hs_usb_ch1_clk = {
-	.name		= "usb_tll_hs_usb_ch1_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH1_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usb_tll_hs_usb_ch2_clk, init_60m_fclk, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_L3INIT_USB_TLL, OPTFCLKEN_USB_CH2_CLK));
 
-static struct clk usb_tll_hs_ick = {
-	.name		= "usb_tll_hs_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
 
-static const struct clksel_rate div2_14to18_rates[] = {
-	{ .div = 14, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 18, .val = 1, .flags = RATE_IN_4430 },
-	{ .div = 0 },
-};
+DEFINE_CLOCK_DM(usb_tll_hs_ick, l4_div_ck, l3_init_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_L3INIT_USB_TLL));
 
-static const struct clksel usim_fclk_div[] = {
-	{ .parent = &dpll_per_m4x2_ck, .rates = div2_14to18_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL_RATE2(14to18, 14, 18);
 
-static struct clk usim_ck = {
-	.name		= "usim_ck",
-	.parent		= &dpll_per_m4x2_ck,
-	.clksel		= usim_fclk_div,
-	.clksel_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_DIV_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-};
+DEFINE_CLKSEL(usim_fclk_div, dpll_per_m4x2_ck, div2_14to18_rates);
 
-static struct clk usim_fclk = {
-	.name		= "usim_fclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK_SHIFT,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &usim_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK(usim_ck, dpll_per_m4x2_ck, CLOCK_OPS_NULL(),
+	     CLOCK_CLKSEL(usim_fclk_div, CM_WKUP_USIM_CLKCTRL, CLKSEL_DIV));
 
-static struct clk usim_fck = {
-	.name		= "usim_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usim_fclk, usim_ck, l4_wkup_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT(CM_WKUP_USIM, OPTFCLKEN_FCLK));
 
-static struct clk wd_timer2_fck = {
-	.name		= "wd_timer2_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_WDT2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(usim_fck, sys_32k_ck, l4_wkup_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_HW(CM_WKUP_USIM));
 
-static struct clk wd_timer3_fck = {
-	.name		= "wd_timer3_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_WDT3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
+DEFINE_CLOCK_DM(wd_timer2_fck, sys_32k_ck, l4_wkup_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM_WKUP_WDT2));
+
+DEFINE_CLOCK_DM(wd_timer3_fck, sys_32k_ck, abe_clkdm,
+		CLOCK_RECALC_FOLLOWPARENT(),
+		CLOCK_OPS_DFLT_SW(CM1_ABE_WDT3));
 
 /* Remaining optional clocks */
-static const struct clksel stm_clk_div_div[] = {
-	{ .parent = &pmd_stm_clock_mux_ck, .rates = div3_1to4_rates },
-	{ .parent = NULL },
-};
 
-static struct clk stm_clk_div_ck = {
-	.name		= "stm_clk_div_ck",
-	.parent		= &pmd_stm_clock_mux_ck,
-	.clksel		= stm_clk_div_div,
-	.clksel_reg	= OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_PMD_STM_CLK_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-};
+DEFINE_CLKSEL(stm_clk_div_div, pmd_stm_clock_mux_ck, div3_1to4_rates);
 
-static const struct clksel trace_clk_div_div[] = {
-	{ .parent = &pmd_trace_clk_mux_ck, .rates = div3_1to4_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLOCK(stm_clk_div_ck, pmd_stm_clock_mux_ck, CLOCK_OPS_NULL(),
+	     CLOCK_CLKSEL(stm_clk_div_div,
+			  CM_EMU_DEBUGSS_CLKCTRL, CLKSEL_PMD_STM_CLK));
 
-static struct clk trace_clk_div_ck = {
-	.name		= "trace_clk_div_ck",
-	.parent		= &pmd_trace_clk_mux_ck,
-	.clksel		= trace_clk_div_div,
-	.clksel_reg	= OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_PMD_TRACE_CLK_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-};
+DEFINE_CLKSEL(trace_clk_div_div, pmd_trace_clk_mux_ck, div3_1to4_rates);
+
+DEFINE_CLOCK(trace_clk_div_ck, pmd_trace_clk_mux_ck, CLOCK_OPS_NULL(),
+	     CLOCK_CLKSEL(trace_clk_div_div,
+			  CM_EMU_DEBUGSS_CLKCTRL, CLKSEL_PMD_TRACE_CLK));
 
 /* SCRM aux clk nodes */
 
-static const struct clksel auxclk_sel[] = {
-	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
-	{ .parent = &dpll_core_m3x2_ck, .rates = div_1_1_rates },
-	{ .parent = &dpll_per_m3x2_ck, .rates = div_1_2_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL3(auxclk_sel,
+	       sys_clkin_ck, dpll_core_m3x2_ck, dpll_per_m3x2_ck);
 
-static struct clk auxclk0_ck = {
-	.name		= "auxclk0_ck",
-	.parent		= &sys_clkin_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLK0,
-	.clksel_mask	= OMAP4_SRCSELECT_MASK,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4_SCRM_AUXCLK0,
-	.enable_bit	= OMAP4_ENABLE_SHIFT,
-};
+DEFINE_CLOCK(auxclk0_ck, sys_clkin_ck, CLOCK_OPS_DFLT2(SCRM_AUXCLK0),
+	     CLOCK_CLKSEL_INIT2(auxclk_sel, SCRM_AUXCLK0, SRCSELECT));
 
-static struct clk auxclk1_ck = {
-	.name		= "auxclk1_ck",
-	.parent		= &sys_clkin_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLK1,
-	.clksel_mask	= OMAP4_SRCSELECT_MASK,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4_SCRM_AUXCLK1,
-	.enable_bit	= OMAP4_ENABLE_SHIFT,
-};
+DEFINE_CLOCK(auxclk1_ck, sys_clkin_ck, CLOCK_OPS_DFLT2(SCRM_AUXCLK1),
+	     CLOCK_CLKSEL_INIT2(auxclk_sel, SCRM_AUXCLK1, SRCSELECT));
 
-static struct clk auxclk2_ck = {
-	.name		= "auxclk2_ck",
-	.parent		= &sys_clkin_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLK2,
-	.clksel_mask	= OMAP4_SRCSELECT_MASK,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4_SCRM_AUXCLK2,
-	.enable_bit	= OMAP4_ENABLE_SHIFT,
-};
-static struct clk auxclk3_ck = {
-	.name		= "auxclk3_ck",
-	.parent		= &sys_clkin_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLK3,
-	.clksel_mask	= OMAP4_SRCSELECT_MASK,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4_SCRM_AUXCLK3,
-	.enable_bit	= OMAP4_ENABLE_SHIFT,
-};
+DEFINE_CLOCK(auxclk2_ck, sys_clkin_ck, CLOCK_OPS_DFLT2(SCRM_AUXCLK2),
+	     CLOCK_CLKSEL_INIT2(auxclk_sel, SCRM_AUXCLK2, SRCSELECT));
 
-static struct clk auxclk4_ck = {
-	.name		= "auxclk4_ck",
-	.parent		= &sys_clkin_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLK4,
-	.clksel_mask	= OMAP4_SRCSELECT_MASK,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4_SCRM_AUXCLK4,
-	.enable_bit	= OMAP4_ENABLE_SHIFT,
-};
+DEFINE_CLOCK(auxclk3_ck, sys_clkin_ck, CLOCK_OPS_DFLT2(SCRM_AUXCLK3),
+	     CLOCK_CLKSEL_INIT2(auxclk_sel, SCRM_AUXCLK3, SRCSELECT));
 
-static struct clk auxclk5_ck = {
-	.name		= "auxclk5_ck",
-	.parent		= &sys_clkin_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLK5,
-	.clksel_mask	= OMAP4_SRCSELECT_MASK,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4_SCRM_AUXCLK5,
-	.enable_bit	= OMAP4_ENABLE_SHIFT,
-};
+DEFINE_CLOCK(auxclk4_ck, sys_clkin_ck, CLOCK_OPS_DFLT2(SCRM_AUXCLK4),
+	     CLOCK_CLKSEL_INIT2(auxclk_sel, SCRM_AUXCLK4, SRCSELECT));
+
+DEFINE_CLOCK(auxclk5_ck, sys_clkin_ck, CLOCK_OPS_DFLT2(SCRM_AUXCLK5),
+	     CLOCK_CLKSEL_INIT2(auxclk_sel, SCRM_AUXCLK5, SRCSELECT));
 
 static const struct clksel auxclkreq_sel[] = {
 	{ .parent = &auxclk0_ck, .rates = div_1_0_rates },
@@ -2246,71 +1375,23 @@ static const struct clksel auxclkreq_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk auxclkreq0_ck = {
-	.name		= "auxclkreq0_ck",
-	.parent		= &auxclk0_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_null,
-	.clksel         = auxclkreq_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ0,
-	.clksel_mask	= OMAP4_MAPPING_MASK,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(auxclkreq0_ck, auxclk0_ck, CLOCK_OPS_NULL(),
+	     CLOCK_CLKSEL_INIT2(auxclkreq_sel, SCRM_AUXCLKREQ0, MAPPING));
 
-static struct clk auxclkreq1_ck = {
-	.name		= "auxclkreq1_ck",
-	.parent		= &auxclk1_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_null,
-	.clksel         = auxclkreq_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ1,
-	.clksel_mask	= OMAP4_MAPPING_MASK,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(auxclkreq1_ck, auxclk1_ck, CLOCK_OPS_NULL(),
+	     CLOCK_CLKSEL_INIT2(auxclkreq_sel, SCRM_AUXCLKREQ1, MAPPING));
 
-static struct clk auxclkreq2_ck = {
-	.name		= "auxclkreq2_ck",
-	.parent		= &auxclk2_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_null,
-	.clksel         = auxclkreq_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ2,
-	.clksel_mask	= OMAP4_MAPPING_MASK,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(auxclkreq2_ck, auxclk2_ck, CLOCK_OPS_NULL(),
+	     CLOCK_CLKSEL_INIT2(auxclkreq_sel, SCRM_AUXCLKREQ2, MAPPING));
 
-static struct clk auxclkreq3_ck = {
-	.name		= "auxclkreq3_ck",
-	.parent		= &auxclk3_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_null,
-	.clksel         = auxclkreq_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ3,
-	.clksel_mask	= OMAP4_MAPPING_MASK,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(auxclkreq3_ck, auxclk3_ck, CLOCK_OPS_NULL(),
+	     CLOCK_CLKSEL_INIT2(auxclkreq_sel, SCRM_AUXCLKREQ3, MAPPING));
 
-static struct clk auxclkreq4_ck = {
-	.name		= "auxclkreq4_ck",
-	.parent		= &auxclk4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_null,
-	.clksel         = auxclkreq_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ4,
-	.clksel_mask	= OMAP4_MAPPING_MASK,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(auxclkreq4_ck, auxclk4_ck, CLOCK_OPS_NULL(),
+	     CLOCK_CLKSEL_INIT2(auxclkreq_sel, SCRM_AUXCLKREQ4, MAPPING));
 
-static struct clk auxclkreq5_ck = {
-	.name		= "auxclkreq5_ck",
-	.parent		= &auxclk5_ck,
-	.init		= &omap2_init_clksel_parent,
-	.ops		= &clkops_null,
-	.clksel         = auxclkreq_sel,
-	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ5,
-	.clksel_mask	= OMAP4_MAPPING_MASK,
-	.recalc		= &omap2_clksel_recalc,
-};
+DEFINE_CLOCK(auxclkreq5_ck, auxclk5_ck, CLOCK_OPS_NULL(),
+	     CLOCK_CLKSEL_INIT2(auxclkreq_sel, SCRM_AUXCLKREQ5, MAPPING));
 
 /*
  * clkdev
-- 
1.7.2.3

