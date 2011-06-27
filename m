From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 5/7] OMAP4: clock data: Remove leaf clock nodes
Date: Mon, 27 Jun 2011 18:33:09 +0200
Message-ID: <1309192391-12410-6-git-send-email-b-cousson@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32810 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787Ab1F0QeB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 12:34:01 -0400
In-Reply-To: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Since the modulemode is now handled by the hwmod, the clock leaf
nodes are not needed anymore.

Remove them.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
c: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c | 1732 ++++++++++------------------------
 1 files changed, 506 insertions(+), 1226 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 684ae8b..547f02b 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1267,511 +1267,548 @@ static struct clk syc_clk_div_ck = {
 
 /* Leaf clocks controlled by modules */
 
-static struct clk aes1_fck = {
-	.name		= "aes1_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4SEC_AES1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_secure_clkdm",
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk aes2_fck = {
-	.name		= "aes2_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4SEC_AES2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_secure_clkdm",
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk aess_fck = {
-	.name		= "aess_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_AESS_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &aess_fclk,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk bandgap_fclk = {
 	.name		= "bandgap_fclk",
+	.parent		= &sys_32k_ck,
 	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
 	.enable_reg	= OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
 	.enable_bit	= OMAP4430_OPTFCLKEN_BGAP_32K_SHIFT,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
 };
 
-static struct clk des3des_fck = {
-	.name		= "des3des_fck",
+static struct clk dss_48mhz_clk = {
+	.name		= "dss_48mhz_clk",
+	.parent		= &func_48mc_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4SEC_DES3DES_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_secure_clkdm",
-	.parent		= &l4_div_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT,
+	.clkdm_name	= "l3_dss_clkdm",
 };
 
-static const struct clksel dmic_sync_mux_sel[] = {
-	{ .parent = &abe_24m_fclk, .rates = div_1_0_rates },
-	{ .parent = &syc_clk_div_ck, .rates = div_1_1_rates },
-	{ .parent = &func_24m_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
-};
-
-static struct clk dmic_sync_mux_ck = {
-	.name		= "dmic_sync_mux_ck",
-	.parent		= &abe_24m_fclk,
-	.clksel		= dmic_sync_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_DMIC_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel func_dmic_abe_gfclk_sel[] = {
-	{ .parent = &dmic_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
-};
-
-/* Merged func_dmic_abe_gfclk into dmic */
-static struct clk dmic_fck = {
-	.name		= "dmic_fck",
-	.parent		= &dmic_sync_mux_ck,
-	.clksel		= func_dmic_abe_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM1_ABE_DMIC_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_DMIC_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
-
-static struct clk dsp_fck = {
-	.name		= "dsp_fck",
+static struct clk dss_dss_clk = {
+	.name		= "dss_dss_clk",
+	.parent		= &dpll_per_m5x2_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_TESLA_TESLA_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "tesla_clkdm",
-	.parent		= &dpll_iva_m4x2_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
+	.clkdm_name	= "l3_dss_clkdm",
 };
 
 static struct clk dss_sys_clk = {
 	.name		= "dss_sys_clk",
+	.parent		= &syc_clk_div_ck,
 	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
 	.enable_bit	= OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT,
 	.clkdm_name	= "l3_dss_clkdm",
-	.parent		= &syc_clk_div_ck,
-	.recalc		= &followparent_recalc,
 };
 
 static struct clk dss_tv_clk = {
 	.name		= "dss_tv_clk",
+	.parent		= &extalt_clkin_ck,
 	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
 	.enable_bit	= OMAP4430_OPTFCLKEN_TV_CLK_SHIFT,
 	.clkdm_name	= "l3_dss_clkdm",
-	.parent		= &extalt_clkin_ck,
-	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_dss_clk = {
-	.name		= "dss_dss_clk",
+static struct clk gpio1_dbclk = {
+	.name		= "gpio1_dbclk",
+	.parent		= &sys_32k_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
-	.clkdm_name	= "l3_dss_clkdm",
-	.parent		= &dpll_per_m5x2_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_wkup_clkdm",
 };
 
-static struct clk dss_48mhz_clk = {
-	.name		= "dss_48mhz_clk",
+static struct clk gpio2_dbclk = {
+	.name		= "gpio2_dbclk",
+	.parent		= &sys_32k_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT,
-	.clkdm_name	= "l3_dss_clkdm",
-	.parent		= &func_48mc_fclk,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
 };
 
-static struct clk dss_fck = {
-	.name		= "dss_fck",
+static struct clk gpio3_dbclk = {
+	.name		= "gpio3_dbclk",
+	.parent		= &sys_32k_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_dss_clkdm",
-	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
 };
 
-static struct clk efuse_ctrl_cust_fck = {
-	.name		= "efuse_ctrl_cust_fck",
+static struct clk gpio4_dbclk = {
+	.name		= "gpio4_dbclk",
+	.parent		= &sys_32k_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_cefuse_clkdm",
-	.parent		= &sys_clkin_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
 };
 
-static struct clk emif1_fck = {
-	.name		= "emif1_fck",
+static struct clk gpio5_dbclk = {
+	.name		= "gpio5_dbclk",
+	.parent		= &sys_32k_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "l3_emif_clkdm",
-	.parent		= &ddrphy_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
 };
 
-static struct clk emif2_fck = {
-	.name		= "emif2_fck",
+static struct clk gpio6_dbclk = {
+	.name		= "gpio6_dbclk",
+	.parent		= &sys_32k_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "l3_emif_clkdm",
-	.parent		= &ddrphy_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
 };
 
-static const struct clksel fdif_fclk_div[] = {
-	{ .parent = &dpll_per_m4x2_ck, .rates = div3_1to4_rates },
-	{ .parent = NULL },
-};
-
-/* Merged fdif_fclk into fdif */
-static struct clk fdif_fck = {
-	.name		= "fdif_fck",
-	.parent		= &dpll_per_m4x2_ck,
-	.clksel		= fdif_fclk_div,
-	.clksel_reg	= OMAP4430_CM_CAM_FDIF_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_FCLK_MASK,
+static struct clk iss_ctrlclk = {
+	.name		= "iss_ctrlclk",
+	.parent		= &func_96m_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-	.enable_reg	= OMAP4430_CM_CAM_FDIF_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_CAM_ISS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_CTRLCLK_SHIFT,
 	.clkdm_name	= "iss_clkdm",
 };
 
-static struct clk fpka_fck = {
-	.name		= "fpka_fck",
+static struct clk ocp2scp_usb_phy_phy_48m_ck = {
+	.name		= "ocp2scp_usb_phy_phy_48m_ck",
+	.parent		= &func_48m_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_secure_clkdm",
-	.parent		= &l4_div_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_PHY_48M_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk gpio1_dbclk = {
-	.name		= "gpio1_dbclk",
+static struct clk slimbus1_fclk_0_ck = {
+	.name		= "slimbus1_fclk_0_ck",
+	.parent		= &abe_24m_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK0_SHIFT,
+	.clkdm_name	= "abe_clkdm",
 };
 
-static struct clk gpio1_ick = {
-	.name		= "gpio1_ick",
+static struct clk slimbus1_fclk_1_ck = {
+	.name		= "slimbus1_fclk_1_ck",
+	.parent		= &func_24m_clk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &l4_wkup_clk_mux_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK1_SHIFT,
+	.clkdm_name	= "abe_clkdm",
 };
 
-static struct clk gpio2_dbclk = {
-	.name		= "gpio2_dbclk",
+static struct clk slimbus1_fclk_2_ck = {
+	.name		= "slimbus1_fclk_2_ck",
+	.parent		= &pad_clks_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK2_SHIFT,
+	.clkdm_name	= "abe_clkdm",
 };
 
-static struct clk gpio2_ick = {
-	.name		= "gpio2_ick",
+static struct clk slimbus1_slimbus_clk = {
+	.name		= "slimbus1_slimbus_clk",
+	.parent		= &slimbus_clk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_SLIMBUS_CLK_11_11_SHIFT,
+	.clkdm_name	= "abe_clkdm",
 };
 
-static struct clk gpio3_dbclk = {
-	.name		= "gpio3_dbclk",
+static struct clk slimbus2_fclk_0_ck = {
+	.name		= "slimbus2_fclk_0_ck",
+	.parent		= &func_24mc_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio3_ick = {
-	.name		= "gpio3_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
+	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_PER24MC_GFCLK_SHIFT,
 	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio4_dbclk = {
-	.name		= "gpio4_dbclk",
+static struct clk slimbus2_fclk_1_ck = {
+	.name		= "slimbus2_fclk_1_ck",
+	.parent		= &per_abe_24m_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_PERABE24M_GFCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
 };
 
-static struct clk gpio4_ick = {
-	.name		= "gpio4_ick",
+static struct clk slimbus2_slimbus_clk = {
+	.name		= "slimbus2_slimbus_clk",
+	.parent		= &pad_slimbus_core_clks_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_SLIMBUS_CLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
 };
 
-static struct clk gpio5_dbclk = {
-	.name		= "gpio5_dbclk",
+static struct clk usb_host_hs_func48mclk_ck = {
+	.name		= "usb_host_hs_func48mclk_ck",
+	.parent		= &func_48mc_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_FUNC48MCLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk gpio5_ick = {
-	.name		= "gpio5_ick",
+static struct clk usb_host_hs_hsic480m_p1_clk = {
+	.name		= "usb_host_hs_hsic480m_p1_clk",
+	.parent		= &dpll_usb_m2_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC480M_P1_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk gpio6_dbclk = {
-	.name		= "gpio6_dbclk",
+static struct clk usb_host_hs_hsic480m_p2_clk = {
+	.name		= "usb_host_hs_hsic480m_p2_clk",
+	.parent		= &dpll_usb_m2_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC480M_P2_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk gpio6_ick = {
-	.name		= "gpio6_ick",
+static struct clk usb_host_hs_hsic60m_p1_clk = {
+	.name		= "usb_host_hs_hsic60m_p1_clk",
+	.parent		= &init_60m_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC60M_P1_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk gpmc_ick = {
-	.name		= "gpmc_ick",
+static struct clk usb_host_hs_hsic60m_p2_clk = {
+	.name		= "usb_host_hs_hsic60m_p2_clk",
+	.parent		= &init_60m_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3_2_GPMC_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_2_clkdm",
-	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC60M_P2_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static const struct clksel sgx_clk_mux_sel[] = {
-	{ .parent = &dpll_core_m7x2_ck, .rates = div_1_0_rates },
-	{ .parent = &dpll_per_m7x2_ck, .rates = div_1_1_rates },
+static const struct clksel utmi_p1_gfclk_sel[] = {
+	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
+	{ .parent = &xclk60mhsp1_ck, .rates = div_1_1_rates },
 	{ .parent = NULL },
 };
 
-/* Merged sgx_clk_mux into gpu */
-static struct clk gpu_fck = {
-	.name		= "gpu_fck",
-	.parent		= &dpll_core_m7x2_ck,
-	.clksel		= sgx_clk_mux_sel,
+static struct clk utmi_p1_gfclk = {
+	.name		= "utmi_p1_gfclk",
+	.parent		= &init_60m_fclk,
+	.clksel		= utmi_p1_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_SGX_FCLK_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.clksel_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P1_MASK,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_gfx_clkdm",
 };
 
-static struct clk hdq1w_fck = {
-	.name		= "hdq1w_fck",
+static struct clk usb_host_hs_utmi_p1_clk = {
+	.name		= "usb_host_hs_utmi_p1_clk",
+	.parent		= &utmi_p1_gfclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_HDQ1W_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_12m_fclk,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P1_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static const struct clksel hsi_fclk_div[] = {
-	{ .parent = &dpll_per_m2x2_ck, .rates = div3_1to4_rates },
+static const struct clksel utmi_p2_gfclk_sel[] = {
+	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
+	{ .parent = &xclk60mhsp2_ck, .rates = div_1_1_rates },
 	{ .parent = NULL },
 };
 
-/* Merged hsi_fclk into hsi */
-static struct clk hsi_fck = {
-	.name		= "hsi_fck",
-	.parent		= &dpll_per_m2x2_ck,
-	.clksel		= hsi_fclk_div,
-	.clksel_reg	= OMAP4430_CM_L3INIT_HSI_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_24_25_MASK,
-	.ops		= &clkops_omap2_dflt,
+static struct clk utmi_p2_gfclk = {
+	.name		= "utmi_p2_gfclk",
+	.parent		= &init_60m_fclk,
+	.clksel		= utmi_p2_gfclk_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P2_MASK,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-	.enable_reg	= OMAP4430_CM_L3INIT_HSI_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk i2c1_fck = {
-	.name		= "i2c1_fck",
+static struct clk usb_host_hs_utmi_p2_clk = {
+	.name		= "usb_host_hs_utmi_p2_clk",
+	.parent		= &utmi_p2_gfclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_I2C1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_96m_fclk,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P2_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk i2c2_fck = {
-	.name		= "i2c2_fck",
+static struct clk usb_host_hs_utmi_p3_clk = {
+	.name		= "usb_host_hs_utmi_p3_clk",
+	.parent		= &init_60m_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_I2C2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_96m_fclk,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P3_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk i2c3_fck = {
-	.name		= "i2c3_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_I2C3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_96m_fclk,
-	.recalc		= &followparent_recalc,
+static const struct clksel otg_60m_gfclk_sel[] = {
+	{ .parent = &utmi_phy_clkout_ck, .rates = div_1_0_rates },
+	{ .parent = &xclk60motg_ck, .rates = div_1_1_rates },
+	{ .parent = NULL },
 };
 
-static struct clk i2c4_fck = {
-	.name		= "i2c4_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_I2C4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_96m_fclk,
-	.recalc		= &followparent_recalc,
+static struct clk otg_60m_gfclk = {
+	.name		= "otg_60m_gfclk",
+	.parent		= &utmi_phy_clkout_ck,
+	.clksel		= otg_60m_gfclk_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_60M_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk ipu_fck = {
-	.name		= "ipu_fck",
+static struct clk usb_otg_hs_xclk = {
+	.name		= "usb_otg_hs_xclk",
+	.parent		= &otg_60m_gfclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "ducati_clkdm",
-	.parent		= &ducati_clk_mux_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_XCLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk iss_ctrlclk = {
-	.name		= "iss_ctrlclk",
+static struct clk usb_phy_cm_clk32k_ck = {
+	.name		= "usb_phy_cm_clk32k_ck",
+	.parent		= &sys_32k_ck,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_CAM_ISS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_CTRLCLK_SHIFT,
-	.clkdm_name	= "iss_clkdm",
-	.parent		= &func_96m_fclk,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_ALWON_USBPHY_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_CLK32K_SHIFT,
+	.clkdm_name	= "l4_ao_clkdm",
 };
 
-static struct clk iss_fck = {
-	.name		= "iss_fck",
+static struct clk usb_tll_hs_usb_ch0_clk = {
+	.name		= "usb_tll_hs_usb_ch0_clk",
+	.parent		= &init_60m_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_CAM_ISS_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "iss_clkdm",
-	.parent		= &ducati_clk_mux_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH0_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk iva_fck = {
-	.name		= "iva_fck",
+static struct clk usb_tll_hs_usb_ch1_clk = {
+	.name		= "usb_tll_hs_usb_ch1_clk",
+	.parent		= &init_60m_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "ivahd_clkdm",
-	.parent		= &dpll_iva_m5x2_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH1_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk kbd_fck = {
-	.name		= "kbd_fck",
+static struct clk usb_tll_hs_usb_ch2_clk = {
+	.name		= "usb_tll_hs_usb_ch2_clk",
+	.parent		= &init_60m_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH2_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk l3_instr_ick = {
-	.name		= "l3_instr_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "l3_instr_clkdm",
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
+static const struct clksel_rate div2_14to18_rates[] = {
+	{ .div = 14, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 18, .val = 1, .flags = RATE_IN_44XX },
+	{ .div = 0 },
+};
+
+static const struct clksel usim_fclk_div[] = {
+	{ .parent = &dpll_per_m4x2_ck, .rates = div2_14to18_rates },
+	{ .parent = NULL },
+};
+
+static struct clk usim_fclk = {
+	.name		= "usim_fclk",
+	.parent		= &dpll_per_m4x2_ck,
+	.clksel		= usim_fclk_div,
+	.clksel_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_DIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk l3_main_3_ick = {
-	.name		= "l3_main_3_ick",
+static struct clk usim_clk = {
+	.name		= "usim_clk",
+	.parent		= &usim_fclk,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INSTR_L3_3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "l3_instr_clkdm",
-	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
+	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK_SHIFT,
+	.clkdm_name	= "l4_wkup_clkdm",
+};
+
+static struct clk cm2_dm10_mux_ck = {
+	.name		= "cm2_dm10_mux_ck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk cm2_dm11_mux_ck = {
+	.name		= "cm2_dm11_mux_ck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk cm2_dm2_mux_ck = {
+	.name		= "cm2_dm2_mux_ck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk cm2_dm3_mux_ck = {
+	.name		= "cm2_dm3_mux_ck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk cm2_dm4_mux_ck = {
+	.name		= "cm2_dm4_mux_ck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk cm2_dm9_mux_ck = {
+	.name		= "cm2_dm9_mux_ck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel dmic_sync_mux_sel[] = {
+	{ .parent = &abe_24m_fclk, .rates = div_1_0_rates },
+	{ .parent = &syc_clk_div_ck, .rates = div_1_1_rates },
+	{ .parent = &func_24m_clk, .rates = div_1_2_rates },
+	{ .parent = NULL },
+};
+
+static struct clk dmic_sync_mux_ck = {
+	.name		= "dmic_sync_mux_ck",
+	.parent		= &abe_24m_fclk,
+	.clksel		= dmic_sync_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM1_ABE_DMIC_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk dmt1_clk_mux_ck = {
+	.name		= "dmt1_clk_mux_ck",
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel fdif_fclk_div[] = {
+	{ .parent = &dpll_per_m4x2_ck, .rates = div3_1to4_rates },
+	{ .parent = NULL },
+};
+
+static struct clk fdif_fclk = {
+	.name		= "fdif_fclk",
+	.parent		= &dpll_per_m4x2_ck,
+	.clksel		= fdif_fclk_div,
+	.clksel_reg	= OMAP4430_CM_CAM_FDIF_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_FCLK_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static const struct clksel func_dmic_abe_gfclk_sel[] = {
+	{ .parent = &dmic_sync_mux_ck, .rates = div_1_0_rates },
+	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
+	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
+	{ .parent = NULL },
+};
+
+static struct clk func_dmic_abe_gfclk = {
+	.name		= "func_dmic_abe_gfclk",
+	.parent		= &dmic_sync_mux_ck,
+	.clksel		= func_dmic_abe_gfclk_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM1_ABE_DMIC_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk mcasp_sync_mux_ck = {
@@ -1792,19 +1829,15 @@ static const struct clksel func_mcasp_abe_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged func_mcasp_abe_gfclk into mcasp */
-static struct clk mcasp_fck = {
-	.name		= "mcasp_fck",
+static struct clk func_mcasp_abe_gfclk = {
+	.name		= "func_mcasp_abe_gfclk",
 	.parent		= &mcasp_sync_mux_ck,
 	.clksel		= func_mcasp_abe_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM1_ABE_MCASP_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_MCASP_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
 };
 
 static struct clk mcbsp1_sync_mux_ck = {
@@ -1825,19 +1858,15 @@ static const struct clksel func_mcbsp1_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged func_mcbsp1_gfclk into mcbsp1 */
-static struct clk mcbsp1_fck = {
-	.name		= "mcbsp1_fck",
+static struct clk func_mcbsp1_gfclk = {
+	.name		= "func_mcbsp1_gfclk",
 	.parent		= &mcbsp1_sync_mux_ck,
 	.clksel		= func_mcbsp1_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
 };
 
 static struct clk mcbsp2_sync_mux_ck = {
@@ -1858,19 +1887,15 @@ static const struct clksel func_mcbsp2_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged func_mcbsp2_gfclk into mcbsp2 */
-static struct clk mcbsp2_fck = {
-	.name		= "mcbsp2_fck",
+static struct clk func_mcbsp2_gfclk = {
+	.name		= "func_mcbsp2_gfclk",
 	.parent		= &mcbsp2_sync_mux_ck,
 	.clksel		= func_mcbsp2_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
 };
 
 static struct clk mcbsp3_sync_mux_ck = {
@@ -1891,107 +1916,32 @@ static const struct clksel func_mcbsp3_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged func_mcbsp3_gfclk into mcbsp3 */
-static struct clk mcbsp3_fck = {
-	.name		= "mcbsp3_fck",
+static struct clk func_mcbsp3_gfclk = {
+	.name		= "func_mcbsp3_gfclk",
 	.parent		= &mcbsp3_sync_mux_ck,
 	.clksel		= func_mcbsp3_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
-
-static const struct clksel mcbsp4_sync_mux_sel[] = {
-	{ .parent = &func_96m_fclk, .rates = div_1_0_rates },
-	{ .parent = &per_abe_nc_fclk, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
-
-static struct clk mcbsp4_sync_mux_ck = {
-	.name		= "mcbsp4_sync_mux_ck",
-	.parent		= &func_96m_fclk,
-	.clksel		= mcbsp4_sync_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static const struct clksel per_mcbsp4_gfclk_sel[] = {
-	{ .parent = &mcbsp4_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
+static const struct clksel hsi_fclk_div[] = {
+	{ .parent = &dpll_per_m2x2_ck, .rates = div3_1to4_rates },
 	{ .parent = NULL },
 };
 
-/* Merged per_mcbsp4_gfclk into mcbsp4 */
-static struct clk mcbsp4_fck = {
-	.name		= "mcbsp4_fck",
-	.parent		= &mcbsp4_sync_mux_ck,
-	.clksel		= per_mcbsp4_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_24_24_MASK,
-	.ops		= &clkops_omap2_dflt,
+static struct clk hsi_fclk = {
+	.name		= "hsi_fclk",
+	.parent		= &dpll_per_m2x2_ck,
+	.clksel		= hsi_fclk_div,
+	.clksel_reg	= OMAP4430_CM_L3INIT_HSI_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_24_25_MASK,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-};
-
-static struct clk mcpdm_fck = {
-	.name		= "mcpdm_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_PDM_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &pad_clks_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi1_fck = {
-	.name		= "mcspi1_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi2_fck = {
-	.name		= "mcspi2_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi3_fck = {
-	.name		= "mcspi3_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi4_fck = {
-	.name		= "mcspi4_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
 };
 
 static const struct clksel hsmmc1_fclk_sel[] = {
@@ -2000,335 +1950,94 @@ static const struct clksel hsmmc1_fclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged hsmmc1_fclk into mmc1 */
-static struct clk mmc1_fck = {
-	.name		= "mmc1_fck",
+static struct clk hsmmc1_fclk = {
+	.name		= "hsmmc1_fclk",
 	.parent		= &func_64m_fclk,
 	.clksel		= hsmmc1_fclk_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
 };
 
-/* Merged hsmmc2_fclk into mmc2 */
-static struct clk mmc2_fck = {
-	.name		= "mmc2_fck",
+static struct clk hsmmc2_fclk = {
+	.name		= "hsmmc2_fclk",
 	.parent		= &func_64m_fclk,
 	.clksel		= hsmmc1_fclk_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_L3INIT_MMC2_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L3INIT_MMC2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-};
-
-static struct clk mmc3_fck = {
-	.name		= "mmc3_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MMCSD3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmc4_fck = {
-	.name		= "mmc4_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MMCSD4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmc5_fck = {
-	.name		= "mmc5_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_MMCSD5_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk ocp2scp_usb_phy_phy_48m = {
-	.name		= "ocp2scp_usb_phy_phy_48m",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_PHY_48M_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk ocp2scp_usb_phy_ick = {
-	.name		= "ocp2scp_usb_phy_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk ocp_wp_noc_ick = {
-	.name		= "ocp_wp_noc_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "l3_instr_clkdm",
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk rng_ick = {
-	.name		= "rng_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4SEC_RNG_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_secure_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk sha2md5_fck = {
-	.name		= "sha2md5_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_secure_clkdm",
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk sl2if_ick = {
-	.name		= "sl2if_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_IVAHD_SL2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "ivahd_clkdm",
-	.parent		= &dpll_iva_m5x2_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk slimbus1_fclk_1 = {
-	.name		= "slimbus1_fclk_1",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK1_SHIFT,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &func_24m_clk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk slimbus1_fclk_0 = {
-	.name		= "slimbus1_fclk_0",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK0_SHIFT,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &abe_24m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk slimbus1_fclk_2 = {
-	.name		= "slimbus1_fclk_2",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK2_SHIFT,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &pad_clks_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk slimbus1_slimbus_clk = {
-	.name		= "slimbus1_slimbus_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_SLIMBUS_CLK_11_11_SHIFT,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &slimbus_clk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk slimbus1_fck = {
-	.name		= "slimbus1_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &ocp_abe_iclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk slimbus2_fclk_1 = {
-	.name		= "slimbus2_fclk_1",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_PERABE24M_GFCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &per_abe_24m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk slimbus2_fclk_0 = {
-	.name		= "slimbus2_fclk_0",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_PER24MC_GFCLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_24mc_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk slimbus2_slimbus_clk = {
-	.name		= "slimbus2_slimbus_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_SLIMBUS_CLK_SHIFT,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &pad_slimbus_core_clks_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk slimbus2_fck = {
-	.name		= "slimbus2_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk smartreflex_core_fck = {
-	.name		= "smartreflex_core_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_ao_clkdm",
-	.parent		= &l4_wkup_clk_mux_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk smartreflex_iva_fck = {
-	.name		= "smartreflex_iva_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_ao_clkdm",
-	.parent		= &l4_wkup_clk_mux_ck,
-	.recalc		= &followparent_recalc,
 };
 
-static struct clk smartreflex_mpu_fck = {
-	.name		= "smartreflex_mpu_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_ao_clkdm",
-	.parent		= &l4_wkup_clk_mux_ck,
-	.recalc		= &followparent_recalc,
+static const struct clksel mcbsp4_sync_mux_sel[] = {
+	{ .parent = &func_96m_fclk, .rates = div_1_0_rates },
+	{ .parent = &per_abe_nc_fclk, .rates = div_1_1_rates },
+	{ .parent = NULL },
 };
 
-/* Merged dmt1_clk_mux into timer1 */
-static struct clk timer1_fck = {
-	.name		= "timer1_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
+static struct clk mcbsp4_sync_mux_ck = {
+	.name		= "mcbsp4_sync_mux_ck",
+	.parent		= &func_96m_fclk,
+	.clksel		= mcbsp4_sync_mux_sel,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.clksel_reg	= OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_wkup_clkdm",
 };
 
-/* Merged cm2_dm10_mux into timer10 */
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
+static const struct clksel per_mcbsp4_gfclk_sel[] = {
+	{ .parent = &mcbsp4_sync_mux_ck, .rates = div_1_0_rates },
+	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
+	{ .parent = NULL },
 };
 
-/* Merged cm2_dm11_mux into timer11 */
-static struct clk timer11_fck = {
-	.name		= "timer11_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
+static struct clk per_mcbsp4_gfclk = {
+	.name		= "per_mcbsp4_gfclk",
+	.parent		= &mcbsp4_sync_mux_ck,
+	.clksel		= per_mcbsp4_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.clksel_reg	= OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_24_24_MASK,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
 };
 
-/* Merged cm2_dm2_mux into timer2 */
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
+static const struct clksel sgx_clk_mux_sel[] = {
+	{ .parent = &dpll_core_m7x2_ck, .rates = div_1_0_rates },
+	{ .parent = &dpll_per_m7x2_ck, .rates = div_1_1_rates },
+	{ .parent = NULL },
 };
 
-/* Merged cm2_dm3_mux into timer3 */
-static struct clk timer3_fck = {
-	.name		= "timer3_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
+static struct clk sgx_clk_mux_ck = {
+	.name		= "sgx_clk_mux_ck",
+	.parent		= &dpll_core_m7x2_ck,
+	.clksel		= sgx_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.clksel_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_SGX_FCLK_MASK,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
 };
 
-/* Merged cm2_dm4_mux into timer4 */
-static struct clk timer4_fck = {
-	.name		= "timer4_fck",
-	.parent		= &sys_clkin_ck,
-	.clksel		= abe_dpll_bypass_clk_mux_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
+static const struct clksel stm_clk_div_div[] = {
+	{ .parent = &pmd_stm_clock_mux_ck, .rates = div3_1to4_rates },
+	{ .parent = NULL },
+};
+
+static struct clk stm_clk_div_ck = {
+	.name		= "stm_clk_div_ck",
+	.parent		= &pmd_stm_clock_mux_ck,
+	.clksel		= stm_clk_div_div,
+	.clksel_reg	= OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_PMD_STM_CLK_MASK,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
 };
 
 static const struct clksel timer5_sync_mux_sel[] = {
@@ -2337,420 +2046,48 @@ static const struct clksel timer5_sync_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged timer5_sync_mux into timer5 */
-static struct clk timer5_fck = {
-	.name		= "timer5_fck",
+static struct clk timer5_sync_mux_ck = {
+	.name		= "timer5_sync_mux_ck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
 };
 
-/* Merged timer6_sync_mux into timer6 */
-static struct clk timer6_fck = {
-	.name		= "timer6_fck",
+static struct clk timer6_sync_mux_ck = {
+	.name		= "timer6_sync_mux_ck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
 };
 
-/* Merged timer7_sync_mux into timer7 */
-static struct clk timer7_fck = {
-	.name		= "timer7_fck",
+static struct clk timer7_sync_mux_ck = {
+	.name		= "timer7_sync_mux_ck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
+	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
 };
 
-/* Merged timer8_sync_mux into timer8 */
-static struct clk timer8_fck = {
-	.name		= "timer8_fck",
+static struct clk timer8_sync_mux_ck = {
+	.name		= "timer8_sync_mux_ck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_omap2_dflt,
-	.recalc		= &omap2_clksel_recalc,
-	.enable_reg	= OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-};
-
-/* Merged cm2_dm9_mux into timer9 */
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
-
-static struct clk uart1_fck = {
-	.name		= "uart1_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_UART1_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk uart2_fck = {
-	.name		= "uart2_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_UART2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk uart3_fck = {
-	.name		= "uart3_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_UART3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk uart4_fck = {
-	.name		= "uart4_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L4PER_UART4_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_per_clkdm",
-	.parent		= &func_48m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
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
-static const struct clksel utmi_p1_gfclk_sel[] = {
-	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
-	{ .parent = &xclk60mhsp1_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
-
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
-
-static struct clk usb_host_hs_utmi_p1_clk = {
-	.name		= "usb_host_hs_utmi_p1_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P1_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &utmi_p1_gfclk,
-	.recalc		= &followparent_recalc,
-};
-
-static const struct clksel utmi_p2_gfclk_sel[] = {
-	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
-	{ .parent = &xclk60mhsp2_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
-
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
-
-static struct clk usb_host_hs_utmi_p2_clk = {
-	.name		= "usb_host_hs_utmi_p2_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P2_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &utmi_p2_gfclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_host_hs_utmi_p3_clk = {
-	.name		= "usb_host_hs_utmi_p3_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P3_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_host_hs_hsic480m_p1_clk = {
-	.name		= "usb_host_hs_hsic480m_p1_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC480M_P1_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &dpll_usb_m2_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_host_hs_hsic60m_p1_clk = {
-	.name		= "usb_host_hs_hsic60m_p1_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC60M_P1_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_host_hs_hsic60m_p2_clk = {
-	.name		= "usb_host_hs_hsic60m_p2_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC60M_P2_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_host_hs_hsic480m_p2_clk = {
-	.name		= "usb_host_hs_hsic480m_p2_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC480M_P2_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &dpll_usb_m2_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_host_hs_func48mclk = {
-	.name		= "usb_host_hs_func48mclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_FUNC48MCLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &func_48mc_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_host_hs_fck = {
-	.name		= "usb_host_hs_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static const struct clksel otg_60m_gfclk_sel[] = {
-	{ .parent = &utmi_phy_clkout_ck, .rates = div_1_0_rates },
-	{ .parent = &xclk60motg_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
-
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
-
-static struct clk usb_otg_hs_xclk = {
-	.name		= "usb_otg_hs_xclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_XCLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &otg_60m_gfclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_otg_hs_ick = {
-	.name		= "usb_otg_hs_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &l3_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_phy_cm_clk32k = {
-	.name		= "usb_phy_cm_clk32k",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_ALWON_USBPHY_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_CLK32K_SHIFT,
-	.clkdm_name	= "l4_ao_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_tll_hs_usb_ch2_clk = {
-	.name		= "usb_tll_hs_usb_ch2_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH2_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_tll_hs_usb_ch0_clk = {
-	.name		= "usb_tll_hs_usb_ch0_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH0_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_tll_hs_usb_ch1_clk = {
-	.name		= "usb_tll_hs_usb_ch1_clk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH1_CLK_SHIFT,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &init_60m_fclk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usb_tll_hs_ick = {
-	.name		= "usb_tll_hs_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static const struct clksel_rate div2_14to18_rates[] = {
-	{ .div = 14, .val = 0, .flags = RATE_IN_44XX },
-	{ .div = 18, .val = 1, .flags = RATE_IN_44XX },
-	{ .div = 0 },
-};
-
-static const struct clksel usim_fclk_div[] = {
-	{ .parent = &dpll_per_m4x2_ck, .rates = div2_14to18_rates },
-	{ .parent = NULL },
-};
-
-static struct clk usim_ck = {
-	.name		= "usim_ck",
-	.parent		= &dpll_per_m4x2_ck,
-	.clksel		= usim_fclk_div,
-	.clksel_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_DIV_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-};
-
-static struct clk usim_fclk = {
-	.name		= "usim_fclk",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK_SHIFT,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &usim_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usim_fck = {
-	.name		= "usim_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk wd_timer2_fck = {
-	.name		= "wd_timer2_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_WKUP_WDT2_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk wd_timer3_fck = {
-	.name		= "wd_timer3_fck",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM1_ABE_WDT3_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
-	.clkdm_name	= "abe_clkdm",
-	.parent		= &sys_32k_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static const struct clksel stm_clk_div_div[] = {
-	{ .parent = &pmd_stm_clock_mux_ck, .rates = div3_1to4_rates },
-	{ .parent = NULL },
-};
-
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
 };
 
 static const struct clksel trace_clk_div_div[] = {
@@ -3145,130 +2482,73 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"pmd_stm_clock_mux_ck",		&pmd_stm_clock_mux_ck,	CK_44XX),
 	CLK(NULL,	"pmd_trace_clk_mux_ck",		&pmd_trace_clk_mux_ck,	CK_44XX),
 	CLK(NULL,	"syc_clk_div_ck",		&syc_clk_div_ck,	CK_44XX),
-	CLK(NULL,	"aes1_fck",			&aes1_fck,	CK_44XX),
-	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_44XX),
-	CLK(NULL,	"aess_fck",			&aess_fck,	CK_44XX),
 	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_44XX),
-	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_44XX),
-	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_44XX),
-	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_44XX),
-	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_44XX),
+	CLK("omapdss_dss",	"video_clk",		&dss_48mhz_clk,	CK_44XX),
+	CLK("omapdss_dss",	"fck",			&dss_dss_clk,	CK_44XX),
 	CLK("omapdss_dss",	"sys_clk",		&dss_sys_clk,	CK_44XX),
 	CLK("omapdss_dss",	"tv_clk",		&dss_tv_clk,	CK_44XX),
-	CLK("omapdss_dss",	"fck",			&dss_dss_clk,	CK_44XX),
-	CLK("omapdss_dss",	"video_clk",		&dss_48mhz_clk,	CK_44XX),
-	CLK("omapdss_dss",	"ick",			&dss_fck,	CK_44XX),
-	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_44XX),
-	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_44XX),
-	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_44XX),
-	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_44XX),
-	CLK(NULL,	"fpka_fck",			&fpka_fck,	CK_44XX),
 	CLK(NULL,	"gpio1_dbclk",			&gpio1_dbclk,	CK_44XX),
-	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_44XX),
 	CLK(NULL,	"gpio2_dbclk",			&gpio2_dbclk,	CK_44XX),
-	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_44XX),
 	CLK(NULL,	"gpio3_dbclk",			&gpio3_dbclk,	CK_44XX),
-	CLK(NULL,	"gpio3_ick",			&gpio3_ick,	CK_44XX),
 	CLK(NULL,	"gpio4_dbclk",			&gpio4_dbclk,	CK_44XX),
-	CLK(NULL,	"gpio4_ick",			&gpio4_ick,	CK_44XX),
 	CLK(NULL,	"gpio5_dbclk",			&gpio5_dbclk,	CK_44XX),
-	CLK(NULL,	"gpio5_ick",			&gpio5_ick,	CK_44XX),
 	CLK(NULL,	"gpio6_dbclk",			&gpio6_dbclk,	CK_44XX),
-	CLK(NULL,	"gpio6_ick",			&gpio6_ick,	CK_44XX),
-	CLK(NULL,	"gpmc_ick",			&gpmc_ick,	CK_44XX),
-	CLK(NULL,	"gpu_fck",			&gpu_fck,	CK_44XX),
-	CLK("omap2_hdq.0",	"fck",			&hdq1w_fck,	CK_44XX),
-	CLK(NULL,	"hsi_fck",			&hsi_fck,	CK_44XX),
-	CLK("omap_i2c.1",	"fck",			&i2c1_fck,	CK_44XX),
-	CLK("omap_i2c.2",	"fck",			&i2c2_fck,	CK_44XX),
-	CLK("omap_i2c.3",	"fck",			&i2c3_fck,	CK_44XX),
-	CLK("omap_i2c.4",	"fck",			&i2c4_fck,	CK_44XX),
-	CLK(NULL,	"ipu_fck",			&ipu_fck,	CK_44XX),
 	CLK(NULL,	"iss_ctrlclk",			&iss_ctrlclk,	CK_44XX),
-	CLK(NULL,	"iss_fck",			&iss_fck,	CK_44XX),
-	CLK(NULL,	"iva_fck",			&iva_fck,	CK_44XX),
-	CLK(NULL,	"kbd_fck",			&kbd_fck,	CK_44XX),
-	CLK(NULL,	"l3_instr_ick",			&l3_instr_ick,	CK_44XX),
-	CLK(NULL,	"l3_main_3_ick",		&l3_main_3_ick,	CK_44XX),
-	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_44XX),
-	CLK(NULL,	"mcasp_fck",			&mcasp_fck,	CK_44XX),
-	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck,	CK_44XX),
-	CLK("omap-mcbsp.1",	"fck",			&mcbsp1_fck,	CK_44XX),
-	CLK(NULL,	"mcbsp2_sync_mux_ck",		&mcbsp2_sync_mux_ck,	CK_44XX),
-	CLK("omap-mcbsp.2",	"fck",			&mcbsp2_fck,	CK_44XX),
-	CLK(NULL,	"mcbsp3_sync_mux_ck",		&mcbsp3_sync_mux_ck,	CK_44XX),
-	CLK("omap-mcbsp.3",	"fck",			&mcbsp3_fck,	CK_44XX),
-	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck,	CK_44XX),
-	CLK("omap-mcbsp.4",	"fck",			&mcbsp4_fck,	CK_44XX),
-	CLK(NULL,	"mcpdm_fck",			&mcpdm_fck,	CK_44XX),
-	CLK("omap2_mcspi.1",	"fck",			&mcspi1_fck,	CK_44XX),
-	CLK("omap2_mcspi.2",	"fck",			&mcspi2_fck,	CK_44XX),
-	CLK("omap2_mcspi.3",	"fck",			&mcspi3_fck,	CK_44XX),
-	CLK("omap2_mcspi.4",	"fck",			&mcspi4_fck,	CK_44XX),
-	CLK("omap_hsmmc.0",	"fck",			&mmc1_fck,	CK_44XX),
-	CLK("omap_hsmmc.1",	"fck",			&mmc2_fck,	CK_44XX),
-	CLK("omap_hsmmc.2",	"fck",			&mmc3_fck,	CK_44XX),
-	CLK("omap_hsmmc.3",	"fck",			&mmc4_fck,	CK_44XX),
-	CLK("omap_hsmmc.4",	"fck",			&mmc5_fck,	CK_44XX),
-	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",	&ocp2scp_usb_phy_phy_48m,	CK_44XX),
-	CLK(NULL,	"ocp2scp_usb_phy_ick",		&ocp2scp_usb_phy_ick,	CK_44XX),
-	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_44XX),
-	CLK("omap_rng",	"ick",				&rng_ick,	CK_44XX),
-	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_44XX),
-	CLK(NULL,	"sl2if_ick",			&sl2if_ick,	CK_44XX),
-	CLK(NULL,	"slimbus1_fclk_1",		&slimbus1_fclk_1,	CK_44XX),
-	CLK(NULL,	"slimbus1_fclk_0",		&slimbus1_fclk_0,	CK_44XX),
-	CLK(NULL,	"slimbus1_fclk_2",		&slimbus1_fclk_2,	CK_44XX),
+	CLK(NULL,	"ocp2scp_usb_phy_phy_48m_ck",	&ocp2scp_usb_phy_phy_48m_ck,	CK_44XX),
+	CLK(NULL,	"slimbus1_fclk_0_ck",		&slimbus1_fclk_0_ck,	CK_44XX),
+	CLK(NULL,	"slimbus1_fclk_1_ck",		&slimbus1_fclk_1_ck,	CK_44XX),
+	CLK(NULL,	"slimbus1_fclk_2_ck",		&slimbus1_fclk_2_ck,	CK_44XX),
 	CLK(NULL,	"slimbus1_slimbus_clk",		&slimbus1_slimbus_clk,	CK_44XX),
-	CLK(NULL,	"slimbus1_fck",			&slimbus1_fck,	CK_44XX),
-	CLK(NULL,	"slimbus2_fclk_1",		&slimbus2_fclk_1,	CK_44XX),
-	CLK(NULL,	"slimbus2_fclk_0",		&slimbus2_fclk_0,	CK_44XX),
+	CLK(NULL,	"slimbus2_fclk_0_ck",		&slimbus2_fclk_0_ck,	CK_44XX),
+	CLK(NULL,	"slimbus2_fclk_1_ck",		&slimbus2_fclk_1_ck,	CK_44XX),
 	CLK(NULL,	"slimbus2_slimbus_clk",		&slimbus2_slimbus_clk,	CK_44XX),
-	CLK(NULL,	"slimbus2_fck",			&slimbus2_fck,	CK_44XX),
-	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_44XX),
-	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_44XX),
-	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_44XX),
-	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_44XX),
-	CLK(NULL,	"gpt10_fck",			&timer10_fck,	CK_44XX),
-	CLK(NULL,	"gpt11_fck",			&timer11_fck,	CK_44XX),
-	CLK(NULL,	"gpt2_fck",			&timer2_fck,	CK_44XX),
-	CLK(NULL,	"gpt3_fck",			&timer3_fck,	CK_44XX),
-	CLK(NULL,	"gpt4_fck",			&timer4_fck,	CK_44XX),
-	CLK(NULL,	"gpt5_fck",			&timer5_fck,	CK_44XX),
-	CLK(NULL,	"gpt6_fck",			&timer6_fck,	CK_44XX),
-	CLK(NULL,	"gpt7_fck",			&timer7_fck,	CK_44XX),
-	CLK(NULL,	"gpt8_fck",			&timer8_fck,	CK_44XX),
-	CLK(NULL,	"gpt9_fck",			&timer9_fck,	CK_44XX),
-	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_44XX),
-	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_44XX),
-	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_44XX),
-	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_44XX),
-	CLK("usbhs-omap.0",	"fs_fck",		&usb_host_fs_fck,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_func48mclk_ck",	&usb_host_hs_func48mclk_ck,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_hsic480m_p1_clk",	&usb_host_hs_hsic480m_p1_clk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_hsic60m_p1_clk",	&usb_host_hs_hsic60m_p1_clk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_hsic60m_p2_clk",	&usb_host_hs_hsic60m_p2_clk,	CK_44XX),
 	CLK(NULL,	"utmi_p1_gfclk",		&utmi_p1_gfclk,	CK_44XX),
 	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&usb_host_hs_utmi_p1_clk,	CK_44XX),
 	CLK(NULL,	"utmi_p2_gfclk",		&utmi_p2_gfclk,	CK_44XX),
 	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&usb_host_hs_utmi_p2_clk,	CK_44XX),
 	CLK(NULL,	"usb_host_hs_utmi_p3_clk",	&usb_host_hs_utmi_p3_clk,	CK_44XX),
-	CLK(NULL,	"usb_host_hs_hsic480m_p1_clk",	&usb_host_hs_hsic480m_p1_clk,	CK_44XX),
-	CLK(NULL,	"usb_host_hs_hsic60m_p1_clk",	&usb_host_hs_hsic60m_p1_clk,	CK_44XX),
-	CLK(NULL,	"usb_host_hs_hsic60m_p2_clk",	&usb_host_hs_hsic60m_p2_clk,	CK_44XX),
-	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk,	CK_44XX),
-	CLK(NULL,	"usb_host_hs_func48mclk",	&usb_host_hs_func48mclk,	CK_44XX),
-	CLK("usbhs-omap.0",	"hs_fck",		&usb_host_hs_fck,	CK_44XX),
 	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk,	CK_44XX),
 	CLK(NULL,	"usb_otg_hs_xclk",		&usb_otg_hs_xclk,	CK_44XX),
-	CLK("musb-omap2430",	"ick",			&usb_otg_hs_ick,	CK_44XX),
-	CLK(NULL,	"usb_phy_cm_clk32k",		&usb_phy_cm_clk32k,	CK_44XX),
-	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",	&usb_tll_hs_usb_ch2_clk,	CK_44XX),
+	CLK(NULL,	"usb_phy_cm_clk32k_ck",		&usb_phy_cm_clk32k_ck,	CK_44XX),
 	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk,	CK_44XX),
 	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk,	CK_44XX),
-	CLK("usbhs-omap.0",	"usbtll_ick",		&usb_tll_hs_ick,	CK_44XX),
-	CLK(NULL,	"usim_ck",			&usim_ck,	CK_44XX),
+	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",	&usb_tll_hs_usb_ch2_clk,	CK_44XX),
 	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_44XX),
-	CLK(NULL,	"usim_fck",			&usim_fck,	CK_44XX),
-	CLK("omap_wdt",	"fck",				&wd_timer2_fck,	CK_44XX),
-	CLK(NULL,	"wd_timer3_fck",		&wd_timer3_fck,	CK_44XX),
+	CLK(NULL,	"usim_clk",			&usim_clk,	CK_44XX),
+	CLK(NULL,	"cm2_dm10_mux_ck",		&cm2_dm10_mux_ck,	CK_44XX),
+	CLK(NULL,	"cm2_dm11_mux_ck",		&cm2_dm11_mux_ck,	CK_44XX),
+	CLK(NULL,	"cm2_dm2_mux_ck",		&cm2_dm2_mux_ck,	CK_44XX),
+	CLK(NULL,	"cm2_dm3_mux_ck",		&cm2_dm3_mux_ck,	CK_44XX),
+	CLK(NULL,	"cm2_dm4_mux_ck",		&cm2_dm4_mux_ck,	CK_44XX),
+	CLK(NULL,	"cm2_dm9_mux_ck",		&cm2_dm9_mux_ck,	CK_44XX),
+	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"dmt1_clk_mux_ck",		&dmt1_clk_mux_ck,	CK_44XX),
+	CLK(NULL,	"fdif_fclk",			&fdif_fclk,	CK_44XX),
+	CLK(NULL,	"func_dmic_abe_gfclk",		&func_dmic_abe_gfclk,	CK_44XX),
+	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"func_mcasp_abe_gfclk",		&func_mcasp_abe_gfclk,	CK_44XX),
+	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"func_mcbsp1_gfclk",		&func_mcbsp1_gfclk,	CK_44XX),
+	CLK(NULL,	"mcbsp2_sync_mux_ck",		&mcbsp2_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"func_mcbsp2_gfclk",		&func_mcbsp2_gfclk,	CK_44XX),
+	CLK(NULL,	"mcbsp3_sync_mux_ck",		&mcbsp3_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"func_mcbsp3_gfclk",		&func_mcbsp3_gfclk,	CK_44XX),
+	CLK(NULL,	"hsi_fclk",			&hsi_fclk,	CK_44XX),
+	CLK(NULL,	"hsmmc1_fclk",			&hsmmc1_fclk,	CK_44XX),
+	CLK(NULL,	"hsmmc2_fclk",			&hsmmc2_fclk,	CK_44XX),
+	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"per_mcbsp4_gfclk",		&per_mcbsp4_gfclk,	CK_44XX),
+	CLK(NULL,	"sgx_clk_mux_ck",		&sgx_clk_mux_ck,	CK_44XX),
 	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_44XX),
+	CLK(NULL,	"gpt5_sync_mux_ck",		&timer5_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"gpt6_sync_mux_ck",		&timer6_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"gpt7_sync_mux_ck",		&timer7_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"gpt8_sync_mux_ck",		&timer8_sync_mux_ck,	CK_44XX),
 	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_44XX),
 	CLK(NULL,	"auxclk0_src_ck",		&auxclk0_src_ck,	CK_44XX),
 	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck,	CK_44XX),
-- 
1.7.0.4

