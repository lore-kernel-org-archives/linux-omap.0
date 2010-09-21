From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] OMAP4: clock: Add optional clock nodes
Date: Tue, 21 Sep 2010 23:10:30 +0200
Message-ID: <1285103430-5964-2-git-send-email-b-cousson@ti.com>
References: <1285103430-5964-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54876 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693Ab0IUVKh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 17:10:37 -0400
In-Reply-To: <1285103430-5964-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

OMAP4 IP optional clocks require explicit enable in module CTRLCLK
register. In order to allow that we have to create artificial clock
nodes that represent this clock inputs in the IP.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |  893 ++++++++++++++++++++++++----------
 1 files changed, 625 insertions(+), 268 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index a0e369e..e2cffcc 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1283,6 +1283,16 @@ static struct clk aess_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk bandgap_fclk = {
+	.name		= "bandgap_fclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_BGAP_32K_SHIFT,
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &sys_32k_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk des3des_fck = {
 	.name		= "des3des_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -1343,6 +1353,46 @@ static struct clk dsp_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk dss_sys_clk = {
+	.name		= "dss_sys_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT,
+	.clkdm_name	= "l3_dss_clkdm",
+	.parent		= &syc_clk_div_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dss_tv_clk = {
+	.name		= "dss_tv_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_TV_CLK_SHIFT,
+	.clkdm_name	= "l3_dss_clkdm",
+	.parent		= &extalt_clkin_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dss_dss_clk = {
+	.name		= "dss_dss_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
+	.clkdm_name	= "l3_dss_clkdm",
+	.parent		= &dpll_per_m5_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dss_48mhz_clk = {
+	.name		= "dss_48mhz_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT,
+	.clkdm_name	= "l3_dss_clkdm",
+	.parent		= &func_48mc_fclk,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk dss_fck = {
 	.name		= "dss_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -1416,6 +1466,16 @@ static struct clk fpka_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk gpio1_dbclk = {
+	.name		= "gpio1_dbclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &sys_32k_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk gpio1_ick = {
 	.name		= "gpio1_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -1426,6 +1486,16 @@ static struct clk gpio1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk gpio2_dbclk = {
+	.name		= "gpio2_dbclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
+	.parent		= &sys_32k_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk gpio2_ick = {
 	.name		= "gpio2_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -1436,6 +1506,16 @@ static struct clk gpio2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk gpio3_dbclk = {
+	.name		= "gpio3_dbclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
+	.parent		= &sys_32k_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk gpio3_ick = {
 	.name		= "gpio3_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -1446,6 +1526,16 @@ static struct clk gpio3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk gpio4_dbclk = {
+	.name		= "gpio4_dbclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
+	.parent		= &sys_32k_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk gpio4_ick = {
 	.name		= "gpio4_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -1456,6 +1546,16 @@ static struct clk gpio4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk gpio5_dbclk = {
+	.name		= "gpio5_dbclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
+	.parent		= &sys_32k_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -1466,6 +1566,16 @@ static struct clk gpio5_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk gpio6_dbclk = {
+	.name		= "gpio6_dbclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
+	.parent		= &sys_32k_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk gpio6_ick = {
 	.name		= "gpio6_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -1600,6 +1710,16 @@ static struct clk ipu_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk iss_ctrlclk = {
+	.name		= "iss_ctrlclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_CAM_ISS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_CTRLCLK_SHIFT,
+	.clkdm_name	= "iss_clkdm",
+	.parent		= &func_96m_fclk,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk iss_fck = {
 	.name		= "iss_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -1924,6 +2044,26 @@ static struct clk mmc5_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk ocp2scp_usb_phy_clk32k = {
+	.name		= "ocp2scp_usb_phy_clk32k",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_CLK32K_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &sys_32k_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk ocp2scp_usb_phy_phy_48m = {
+	.name		= "ocp2scp_usb_phy_phy_48m",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_PHY_48M_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &func_48m_fclk,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk ocp2scp_usb_phy_ick = {
 	.name		= "ocp2scp_usb_phy_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -1974,6 +2114,46 @@ static struct clk sl2if_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk slimbus1_fclk_1 = {
+	.name		= "slimbus1_fclk_1",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK1_SHIFT,
+	.clkdm_name	= "abe_clkdm",
+	.parent		= &func_24m_clk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk slimbus1_fclk_0 = {
+	.name		= "slimbus1_fclk_0",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK0_SHIFT,
+	.clkdm_name	= "abe_clkdm",
+	.parent		= &abe_24m_fclk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk slimbus1_fclk_2 = {
+	.name		= "slimbus1_fclk_2",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK2_SHIFT,
+	.clkdm_name	= "abe_clkdm",
+	.parent		= &pad_clks_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk slimbus1_slimbus_clk = {
+	.name		= "slimbus1_slimbus_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_SLIMBUS_CLK_11_11_SHIFT,
+	.clkdm_name	= "abe_clkdm",
+	.parent		= &slimbus_clk,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk slimbus1_fck = {
 	.name		= "slimbus1_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -1984,6 +2164,36 @@ static struct clk slimbus1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk slimbus2_fclk_1 = {
+	.name		= "slimbus2_fclk_1",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_PERABE24M_GFCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
+	.parent		= &per_abe_24m_fclk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk slimbus2_fclk_0 = {
+	.name		= "slimbus2_fclk_0",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_PER24MC_GFCLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
+	.parent		= &func_24mc_fclk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk slimbus2_slimbus_clk = {
+	.name		= "slimbus2_slimbus_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_SLIMBUS_CLK_SHIFT,
+	.clkdm_name	= "l4_per_clkdm",
+	.parent		= &pad_slimbus_core_clks_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk slimbus2_fck = {
 	.name		= "slimbus2_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -2251,6 +2461,120 @@ static struct clk usb_host_fs_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk usb_host_hs_utmi_p3_clk = {
+	.name		= "usb_host_hs_utmi_p3_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P3_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &init_60m_fclk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk usb_host_hs_hsic60m_p1_clk = {
+	.name		= "usb_host_hs_hsic60m_p1_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC60M_P1_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &init_60m_fclk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk usb_host_hs_hsic60m_p2_clk = {
+	.name		= "usb_host_hs_hsic60m_p2_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC60M_P2_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &init_60m_fclk,
+	.recalc		= &followparent_recalc,
+};
+
+static const struct clksel utmi_p1_gfclk_sel[] = {
+	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
+	{ .parent = &xclk60mhsp1_ck, .rates = div_1_1_rates },
+	{ .parent = NULL },
+};
+
+static struct clk utmi_p1_gfclk = {
+	.name		= "utmi_p1_gfclk",
+	.parent		= &init_60m_fclk,
+	.clksel		= utmi_p1_gfclk_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P1_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk usb_host_hs_utmi_p1_clk = {
+	.name		= "usb_host_hs_utmi_p1_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P1_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &utmi_p1_gfclk,
+	.recalc		= &followparent_recalc,
+};
+
+static const struct clksel utmi_p2_gfclk_sel[] = {
+	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
+	{ .parent = &xclk60mhsp2_ck, .rates = div_1_1_rates },
+	{ .parent = NULL },
+};
+
+static struct clk utmi_p2_gfclk = {
+	.name		= "utmi_p2_gfclk",
+	.parent		= &init_60m_fclk,
+	.clksel		= utmi_p2_gfclk_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P2_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk usb_host_hs_utmi_p2_clk = {
+	.name		= "usb_host_hs_utmi_p2_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P2_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &utmi_p2_gfclk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk usb_host_hs_hsic480m_p1_clk = {
+	.name		= "usb_host_hs_hsic480m_p1_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC480M_P1_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &dpll_usb_m2_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk usb_host_hs_hsic480m_p2_clk = {
+	.name		= "usb_host_hs_hsic480m_p2_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_HSIC480M_P2_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &dpll_usb_m2_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk usb_host_hs_func48mclk = {
+	.name		= "usb_host_hs_func48mclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_FUNC48MCLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &func_48mc_fclk,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk usb_host_hs_fck = {
 	.name		= "usb_host_hs_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -2261,6 +2585,33 @@ static struct clk usb_host_hs_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static const struct clksel otg_60m_gfclk_sel[] = {
+	{ .parent = &utmi_phy_clkout_ck, .rates = div_1_0_rates },
+	{ .parent = &xclk60motg_ck, .rates = div_1_1_rates },
+	{ .parent = NULL },
+};
+
+static struct clk otg_60m_gfclk = {
+	.name		= "otg_60m_gfclk",
+	.parent		= &utmi_phy_clkout_ck,
+	.clksel		= otg_60m_gfclk_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_60M_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk usb_otg_hs_xclk = {
+	.name		= "usb_otg_hs_xclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_XCLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &otg_60m_gfclk,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk usb_otg_hs_ick = {
 	.name		= "usb_otg_hs_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -2271,6 +2622,36 @@ static struct clk usb_otg_hs_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk usb_tll_hs_usb_ch2_clk = {
+	.name		= "usb_tll_hs_usb_ch2_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH2_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &init_60m_fclk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk usb_tll_hs_usb_ch0_clk = {
+	.name		= "usb_tll_hs_usb_ch0_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH0_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &init_60m_fclk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk usb_tll_hs_usb_ch1_clk = {
+	.name		= "usb_tll_hs_usb_ch1_clk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_USB_CH1_CLK_SHIFT,
+	.clkdm_name	= "l3_init_clkdm",
+	.parent		= &init_60m_fclk,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk usb_tll_hs_ick = {
 	.name		= "usb_tll_hs_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -2312,23 +2693,6 @@ static struct clk wd_timer3_fck = {
 };
 
 /* Remaining optional clocks */
-static const struct clksel otg_60m_gfclk_sel[] = {
-	{ .parent = &utmi_phy_clkout_ck, .rates = div_1_0_rates },
-	{ .parent = &xclk60motg_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
-
-static struct clk otg_60m_gfclk_ck = {
-	.name		= "otg_60m_gfclk_ck",
-	.parent		= &utmi_phy_clkout_ck,
-	.clksel		= otg_60m_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_60M_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
-
 static const struct clksel stm_clk_div_div[] = {
 	{ .parent = &pmd_stm_clock_mux_ck, .rates = div3_1to4_rates },
 	{ .parent = NULL },
@@ -2386,262 +2750,255 @@ static struct clk usim_fclk = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static const struct clksel utmi_p1_gfclk_sel[] = {
-	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
-	{ .parent = &xclk60mhsp1_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
-
-static struct clk utmi_p1_gfclk_ck = {
-	.name		= "utmi_p1_gfclk_ck",
-	.parent		= &init_60m_fclk,
-	.clksel		= utmi_p1_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P1_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel utmi_p2_gfclk_sel[] = {
-	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
-	{ .parent = &xclk60mhsp2_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
-
-static struct clk utmi_p2_gfclk_ck = {
-	.name		= "utmi_p2_gfclk_ck",
-	.parent		= &init_60m_fclk,
-	.clksel		= utmi_p2_gfclk_sel,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P2_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
-
 /*
  * clkdev
  */
 
 static struct omap_clk omap44xx_clks[] = {
-	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck,	CK_443X),
-	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck,	CK_443X),
-	CLK(NULL,	"pad_slimbus_core_clks_ck",	&pad_slimbus_core_clks_ck,	CK_443X),
-	CLK(NULL,	"secure_32k_clk_src_ck",	&secure_32k_clk_src_ck,	CK_443X),
-	CLK(NULL,	"slimbus_clk",			&slimbus_clk,	CK_443X),
-	CLK(NULL,	"sys_32k_ck",			&sys_32k_ck,	CK_443X),
-	CLK(NULL,	"virt_12000000_ck",		&virt_12000000_ck,	CK_443X),
-	CLK(NULL,	"virt_13000000_ck",		&virt_13000000_ck,	CK_443X),
-	CLK(NULL,	"virt_16800000_ck",		&virt_16800000_ck,	CK_443X),
-	CLK(NULL,	"virt_19200000_ck",		&virt_19200000_ck,	CK_443X),
-	CLK(NULL,	"virt_26000000_ck",		&virt_26000000_ck,	CK_443X),
-	CLK(NULL,	"virt_27000000_ck",		&virt_27000000_ck,	CK_443X),
-	CLK(NULL,	"virt_38400000_ck",		&virt_38400000_ck,	CK_443X),
-	CLK(NULL,	"sys_clkin_ck",			&sys_clkin_ck,	CK_443X),
-	CLK(NULL,	"utmi_phy_clkout_ck",		&utmi_phy_clkout_ck,	CK_443X),
-	CLK(NULL,	"xclk60mhsp1_ck",		&xclk60mhsp1_ck,	CK_443X),
-	CLK(NULL,	"xclk60mhsp2_ck",		&xclk60mhsp2_ck,	CK_443X),
-	CLK(NULL,	"xclk60motg_ck",		&xclk60motg_ck,	CK_443X),
-	CLK(NULL,	"dpll_sys_ref_clk",		&dpll_sys_ref_clk,	CK_443X),
-	CLK(NULL,	"abe_dpll_refclk_mux_ck",	&abe_dpll_refclk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_ck",			&dpll_abe_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_m2x2_ck",		&dpll_abe_m2x2_ck,	CK_443X),
-	CLK(NULL,	"abe_24m_fclk",			&abe_24m_fclk,	CK_443X),
-	CLK(NULL,	"abe_clk",			&abe_clk,	CK_443X),
-	CLK(NULL,	"aess_fclk",			&aess_fclk,	CK_443X),
-	CLK(NULL,	"dpll_abe_m3_ck",		&dpll_abe_m3_ck,	CK_443X),
-	CLK(NULL,	"core_hsd_byp_clk_mux_ck",	&core_hsd_byp_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_ck",			&dpll_core_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m6_ck",		&dpll_core_m6_ck,	CK_443X),
-	CLK(NULL,	"dbgclk_mux_ck",		&dbgclk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m2_ck",		&dpll_core_m2_ck,	CK_443X),
-	CLK(NULL,	"ddrphy_ck",			&ddrphy_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m5_ck",		&dpll_core_m5_ck,	CK_443X),
-	CLK(NULL,	"div_core_ck",			&div_core_ck,	CK_443X),
-	CLK(NULL,	"div_iva_hs_clk",		&div_iva_hs_clk,	CK_443X),
-	CLK(NULL,	"div_mpu_hs_clk",		&div_mpu_hs_clk,	CK_443X),
-	CLK(NULL,	"dpll_core_m4_ck",		&dpll_core_m4_ck,	CK_443X),
-	CLK(NULL,	"dll_clk_div_ck",		&dll_clk_div_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_m2_ck",		&dpll_abe_m2_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m3_ck",		&dpll_core_m3_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m7_ck",		&dpll_core_m7_ck,	CK_443X),
-	CLK(NULL,	"iva_hsd_byp_clk_mux_ck",	&iva_hsd_byp_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_ck",			&dpll_iva_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_m4_ck",		&dpll_iva_m4_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_m5_ck",		&dpll_iva_m5_ck,	CK_443X),
-	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck,	CK_443X),
-	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck,	CK_443X),
-	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck,	CK_443X),
-	CLK(NULL,	"per_hsd_byp_clk_mux_ck",	&per_hsd_byp_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_ck",			&dpll_per_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m2_ck",		&dpll_per_m2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m2x2_ck",		&dpll_per_m2x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m3_ck",		&dpll_per_m3_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m4_ck",		&dpll_per_m4_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m5_ck",		&dpll_per_m5_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m6_ck",		&dpll_per_m6_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m7_ck",		&dpll_per_m7_ck,	CK_443X),
-	CLK(NULL,	"dpll_unipro_ck",		&dpll_unipro_ck,	CK_443X),
-	CLK(NULL,	"dpll_unipro_m2x2_ck",		&dpll_unipro_m2x2_ck,	CK_443X),
-	CLK(NULL,	"usb_hs_clk_div_ck",		&usb_hs_clk_div_ck,	CK_443X),
-	CLK(NULL,	"dpll_usb_ck",			&dpll_usb_ck,	CK_443X),
-	CLK(NULL,	"dpll_usb_clkdcoldo_ck",	&dpll_usb_clkdcoldo_ck,	CK_443X),
-	CLK(NULL,	"dpll_usb_m2_ck",		&dpll_usb_m2_ck,	CK_443X),
-	CLK(NULL,	"ducati_clk_mux_ck",		&ducati_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"func_12m_fclk",		&func_12m_fclk,	CK_443X),
-	CLK(NULL,	"func_24m_clk",			&func_24m_clk,	CK_443X),
-	CLK(NULL,	"func_24mc_fclk",		&func_24mc_fclk,	CK_443X),
-	CLK(NULL,	"func_48m_fclk",		&func_48m_fclk,	CK_443X),
-	CLK(NULL,	"func_48mc_fclk",		&func_48mc_fclk,	CK_443X),
-	CLK(NULL,	"func_64m_fclk",		&func_64m_fclk,	CK_443X),
-	CLK(NULL,	"func_96m_fclk",		&func_96m_fclk,	CK_443X),
-	CLK(NULL,	"hsmmc6_fclk",			&hsmmc6_fclk,	CK_443X),
-	CLK(NULL,	"init_60m_fclk",		&init_60m_fclk,	CK_443X),
-	CLK(NULL,	"l3_div_ck",			&l3_div_ck,	CK_443X),
-	CLK(NULL,	"l4_div_ck",			&l4_div_ck,	CK_443X),
-	CLK(NULL,	"lp_clk_div_ck",		&lp_clk_div_ck,	CK_443X),
-	CLK(NULL,	"l4_wkup_clk_mux_ck",		&l4_wkup_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"per_abe_nc_fclk",		&per_abe_nc_fclk,	CK_443X),
-	CLK(NULL,	"mcasp2_fclk",			&mcasp2_fclk,	CK_443X),
-	CLK(NULL,	"mcasp3_fclk",			&mcasp3_fclk,	CK_443X),
-	CLK(NULL,	"ocp_abe_iclk",			&ocp_abe_iclk,	CK_443X),
-	CLK(NULL,	"per_abe_24m_fclk",		&per_abe_24m_fclk,	CK_443X),
-	CLK(NULL,	"pmd_stm_clock_mux_ck",		&pmd_stm_clock_mux_ck,	CK_443X),
-	CLK(NULL,	"pmd_trace_clk_mux_ck",		&pmd_trace_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"syc_clk_div_ck",		&syc_clk_div_ck,	CK_443X),
-	CLK(NULL,	"aes1_fck",			&aes1_fck,	CK_443X),
-	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_443X),
-	CLK(NULL,	"aess_fck",			&aess_fck,	CK_443X),
-	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
-	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
-	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
-	CLK(NULL,	"dss_fck",			&dss_fck,	CK_443X),
-	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_443X),
-	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_443X),
-	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_443X),
-	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_443X),
-	CLK(NULL,	"fpka_fck",			&fpka_fck,	CK_443X),
-	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_443X),
-	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_443X),
-	CLK(NULL,	"gpio3_ick",			&gpio3_ick,	CK_443X),
-	CLK(NULL,	"gpio4_ick",			&gpio4_ick,	CK_443X),
-	CLK(NULL,	"gpio5_ick",			&gpio5_ick,	CK_443X),
-	CLK(NULL,	"gpio6_ick",			&gpio6_ick,	CK_443X),
-	CLK(NULL,	"gpmc_ick",			&gpmc_ick,	CK_443X),
-	CLK(NULL,	"per_sgx_fclk",			&per_sgx_fclk,	CK_443X),
-	CLK(NULL,	"gpu_fck",			&gpu_fck,	CK_443X),
-	CLK("omap2_hdq.0",	"fck",				&hdq1w_fck,	CK_443X),
-	CLK(NULL,	"hsi_fck",			&hsi_fck,	CK_443X),
-	CLK("i2c_omap.1",	"fck",				&i2c1_fck,	CK_443X),
-	CLK("i2c_omap.2",	"fck",				&i2c2_fck,	CK_443X),
-	CLK("i2c_omap.3",	"fck",				&i2c3_fck,	CK_443X),
-	CLK("i2c_omap.4",	"fck",				&i2c4_fck,	CK_443X),
-	CLK(NULL,	"ipu_fck",			&ipu_fck,	CK_443X),
-	CLK(NULL,	"iss_fck",			&iss_fck,	CK_443X),
-	CLK(NULL,	"iva_fck",			&iva_fck,	CK_443X),
-	CLK(NULL,	"kbd_fck",			&kbd_fck,	CK_443X),
-	CLK(NULL,	"l3_instr_ick",			&l3_instr_ick,	CK_443X),
-	CLK(NULL,	"l3_main_3_ick",		&l3_main_3_ick,	CK_443X),
-	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"mcasp_fck",			&mcasp_fck,	CK_443X),
-	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.1",	"fck",				&mcbsp1_fck,	CK_443X),
-	CLK(NULL,	"mcbsp2_sync_mux_ck",		&mcbsp2_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.2",	"fck",				&mcbsp2_fck,	CK_443X),
-	CLK(NULL,	"mcbsp3_sync_mux_ck",		&mcbsp3_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.3",	"fck",				&mcbsp3_fck,	CK_443X),
-	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.4",	"fck",				&mcbsp4_fck,	CK_443X),
-	CLK(NULL,	"mcpdm_fck",			&mcpdm_fck,	CK_443X),
-	CLK("omap2_mcspi.1",	"fck",				&mcspi1_fck,	CK_443X),
-	CLK("omap2_mcspi.2",	"fck",				&mcspi2_fck,	CK_443X),
-	CLK("omap2_mcspi.3",	"fck",				&mcspi3_fck,	CK_443X),
-	CLK("omap2_mcspi.4",	"fck",				&mcspi4_fck,	CK_443X),
-	CLK("mmci-omap-hs.0",	"fck",				&mmc1_fck,	CK_443X),
-	CLK("mmci-omap-hs.1",	"fck",				&mmc2_fck,	CK_443X),
-	CLK("mmci-omap-hs.2",	"fck",				&mmc3_fck,	CK_443X),
-	CLK("mmci-omap-hs.3",	"fck",				&mmc4_fck,	CK_443X),
-	CLK("mmci-omap-hs.4",	"fck",				&mmc5_fck,	CK_443X),
-	CLK(NULL,	"ocp2scp_usb_phy_ick",		&ocp2scp_usb_phy_ick,	CK_443X),
-	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_443X),
-	CLK("omap_rng",	"ick",				&rng_ick,	CK_443X),
-	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_443X),
-	CLK(NULL,	"sl2if_ick",			&sl2if_ick,	CK_443X),
-	CLK(NULL,	"slimbus1_fck",			&slimbus1_fck,	CK_443X),
-	CLK(NULL,	"slimbus2_fck",			&slimbus2_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
-	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
-	CLK(NULL,	"gpt10_fck",			&timer10_fck,	CK_443X),
-	CLK(NULL,	"gpt11_fck",			&timer11_fck,	CK_443X),
-	CLK(NULL,	"gpt2_fck",			&timer2_fck,	CK_443X),
-	CLK(NULL,	"gpt3_fck",			&timer3_fck,	CK_443X),
-	CLK(NULL,	"gpt4_fck",			&timer4_fck,	CK_443X),
-	CLK(NULL,	"gpt5_fck",			&timer5_fck,	CK_443X),
-	CLK(NULL,	"gpt6_fck",			&timer6_fck,	CK_443X),
-	CLK(NULL,	"gpt7_fck",			&timer7_fck,	CK_443X),
-	CLK(NULL,	"gpt8_fck",			&timer8_fck,	CK_443X),
-	CLK(NULL,	"gpt9_fck",			&timer9_fck,	CK_443X),
-	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_443X),
-	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
-	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
-	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_443X),
-	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
-	CLK(NULL,	"usb_host_hs_fck",		&usb_host_hs_fck,	CK_443X),
-	CLK("musb_hdrc",	"ick",				&usb_otg_hs_ick,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick,	CK_443X),
-	CLK(NULL,	"usim_fck",			&usim_fck,	CK_443X),
-	CLK("omap_wdt",	"fck",				&wd_timer2_fck,	CK_443X),
-	CLK(NULL,	"wd_timer3_fck",		&wd_timer3_fck,	CK_443X),
-	CLK(NULL,	"otg_60m_gfclk_ck",		&otg_60m_gfclk_ck,	CK_443X),
-	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_443X),
-	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_443X),
-	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
-	CLK(NULL,	"utmi_p1_gfclk_ck",		&utmi_p1_gfclk_ck,	CK_443X),
-	CLK(NULL,	"utmi_p2_gfclk_ck",		&utmi_p2_gfclk_ck,	CK_443X),
-	CLK(NULL,	"gpio1_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpio2_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpio3_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpio4_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpio5_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpio6_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt2_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt3_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt4_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt5_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt6_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt7_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt8_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt9_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt10_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt11_ick",			&dummy_ck,	CK_443X),
-	CLK("i2c_omap.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("i2c_omap.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("i2c_omap.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("i2c_omap.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.0",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
-	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"extalt_clkin_ck",			&extalt_clkin_ck,	CK_443X),
+	CLK(NULL,	"pad_clks_ck",				&pad_clks_ck,	CK_443X),
+	CLK(NULL,	"pad_slimbus_core_clks_ck",		&pad_slimbus_core_clks_ck,	CK_443X),
+	CLK(NULL,	"secure_32k_clk_src_ck",		&secure_32k_clk_src_ck,	CK_443X),
+	CLK(NULL,	"slimbus_clk",				&slimbus_clk,	CK_443X),
+	CLK(NULL,	"sys_32k_ck",				&sys_32k_ck,	CK_443X),
+	CLK(NULL,	"virt_12000000_ck",			&virt_12000000_ck,	CK_443X),
+	CLK(NULL,	"virt_13000000_ck",			&virt_13000000_ck,	CK_443X),
+	CLK(NULL,	"virt_16800000_ck",			&virt_16800000_ck,	CK_443X),
+	CLK(NULL,	"virt_19200000_ck",			&virt_19200000_ck,	CK_443X),
+	CLK(NULL,	"virt_26000000_ck",			&virt_26000000_ck,	CK_443X),
+	CLK(NULL,	"virt_27000000_ck",			&virt_27000000_ck,	CK_443X),
+	CLK(NULL,	"virt_38400000_ck",			&virt_38400000_ck,	CK_443X),
+	CLK(NULL,	"sys_clkin_ck",				&sys_clkin_ck,	CK_443X),
+	CLK(NULL,	"utmi_phy_clkout_ck",			&utmi_phy_clkout_ck,	CK_443X),
+	CLK(NULL,	"xclk60mhsp1_ck",			&xclk60mhsp1_ck,	CK_443X),
+	CLK(NULL,	"xclk60mhsp2_ck",			&xclk60mhsp2_ck,	CK_443X),
+	CLK(NULL,	"xclk60motg_ck",			&xclk60motg_ck,	CK_443X),
+	CLK(NULL,	"dpll_sys_ref_clk",			&dpll_sys_ref_clk,	CK_443X),
+	CLK(NULL,	"abe_dpll_refclk_mux_ck",		&abe_dpll_refclk_mux_ck,	CK_443X),
+	CLK(NULL,	"dpll_abe_ck",				&dpll_abe_ck,	CK_443X),
+	CLK(NULL,	"dpll_abe_m2x2_ck",			&dpll_abe_m2x2_ck,	CK_443X),
+	CLK(NULL,	"abe_24m_fclk",				&abe_24m_fclk,	CK_443X),
+	CLK(NULL,	"abe_clk",				&abe_clk,	CK_443X),
+	CLK(NULL,	"aess_fclk",				&aess_fclk,	CK_443X),
+	CLK(NULL,	"dpll_abe_m3_ck",			&dpll_abe_m3_ck,	CK_443X),
+	CLK(NULL,	"core_hsd_byp_clk_mux_ck",		&core_hsd_byp_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_ck",				&dpll_core_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m6_ck",			&dpll_core_m6_ck,	CK_443X),
+	CLK(NULL,	"dbgclk_mux_ck",			&dbgclk_mux_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m2_ck",			&dpll_core_m2_ck,	CK_443X),
+	CLK(NULL,	"ddrphy_ck",				&ddrphy_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m5_ck",			&dpll_core_m5_ck,	CK_443X),
+	CLK(NULL,	"div_core_ck",				&div_core_ck,	CK_443X),
+	CLK(NULL,	"div_iva_hs_clk",			&div_iva_hs_clk,	CK_443X),
+	CLK(NULL,	"div_mpu_hs_clk",			&div_mpu_hs_clk,	CK_443X),
+	CLK(NULL,	"dpll_core_m4_ck",			&dpll_core_m4_ck,	CK_443X),
+	CLK(NULL,	"dll_clk_div_ck",			&dll_clk_div_ck,	CK_443X),
+	CLK(NULL,	"dpll_abe_m2_ck",			&dpll_abe_m2_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m3_ck",			&dpll_core_m3_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m7_ck",			&dpll_core_m7_ck,	CK_443X),
+	CLK(NULL,	"iva_hsd_byp_clk_mux_ck",		&iva_hsd_byp_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"dpll_iva_ck",				&dpll_iva_ck,	CK_443X),
+	CLK(NULL,	"dpll_iva_m4_ck",			&dpll_iva_m4_ck,	CK_443X),
+	CLK(NULL,	"dpll_iva_m5_ck",			&dpll_iva_m5_ck,	CK_443X),
+	CLK(NULL,	"dpll_mpu_ck",				&dpll_mpu_ck,	CK_443X),
+	CLK(NULL,	"dpll_mpu_m2_ck",			&dpll_mpu_m2_ck,	CK_443X),
+	CLK(NULL,	"per_hs_clk_div_ck",			&per_hs_clk_div_ck,	CK_443X),
+	CLK(NULL,	"per_hsd_byp_clk_mux_ck",		&per_hsd_byp_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_ck",				&dpll_per_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m2_ck",			&dpll_per_m2_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m2x2_ck",			&dpll_per_m2x2_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m3_ck",			&dpll_per_m3_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m4_ck",			&dpll_per_m4_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m5_ck",			&dpll_per_m5_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m6_ck",			&dpll_per_m6_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m7_ck",			&dpll_per_m7_ck,	CK_443X),
+	CLK(NULL,	"dpll_unipro_ck",			&dpll_unipro_ck,	CK_443X),
+	CLK(NULL,	"dpll_unipro_m2x2_ck",			&dpll_unipro_m2x2_ck,	CK_443X),
+	CLK(NULL,	"usb_hs_clk_div_ck",			&usb_hs_clk_div_ck,	CK_443X),
+	CLK(NULL,	"dpll_usb_ck",				&dpll_usb_ck,	CK_443X),
+	CLK(NULL,	"dpll_usb_clkdcoldo_ck",		&dpll_usb_clkdcoldo_ck,	CK_443X),
+	CLK(NULL,	"dpll_usb_m2_ck",			&dpll_usb_m2_ck,	CK_443X),
+	CLK(NULL,	"ducati_clk_mux_ck",			&ducati_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"func_12m_fclk",			&func_12m_fclk,	CK_443X),
+	CLK(NULL,	"func_24m_clk",				&func_24m_clk,	CK_443X),
+	CLK(NULL,	"func_24mc_fclk",			&func_24mc_fclk,	CK_443X),
+	CLK(NULL,	"func_48m_fclk",			&func_48m_fclk,	CK_443X),
+	CLK(NULL,	"func_48mc_fclk",			&func_48mc_fclk,	CK_443X),
+	CLK(NULL,	"func_64m_fclk",			&func_64m_fclk,	CK_443X),
+	CLK(NULL,	"func_96m_fclk",			&func_96m_fclk,	CK_443X),
+	CLK(NULL,	"hsmmc6_fclk",				&hsmmc6_fclk,	CK_443X),
+	CLK(NULL,	"init_60m_fclk",			&init_60m_fclk,	CK_443X),
+	CLK(NULL,	"l3_div_ck",				&l3_div_ck,	CK_443X),
+	CLK(NULL,	"l4_div_ck",				&l4_div_ck,	CK_443X),
+	CLK(NULL,	"lp_clk_div_ck",			&lp_clk_div_ck,	CK_443X),
+	CLK(NULL,	"l4_wkup_clk_mux_ck",			&l4_wkup_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"per_abe_nc_fclk",			&per_abe_nc_fclk,	CK_443X),
+	CLK(NULL,	"mcasp2_fclk",				&mcasp2_fclk,	CK_443X),
+	CLK(NULL,	"mcasp3_fclk",				&mcasp3_fclk,	CK_443X),
+	CLK(NULL,	"ocp_abe_iclk",				&ocp_abe_iclk,	CK_443X),
+	CLK(NULL,	"per_abe_24m_fclk",			&per_abe_24m_fclk,	CK_443X),
+	CLK(NULL,	"pmd_stm_clock_mux_ck",			&pmd_stm_clock_mux_ck,	CK_443X),
+	CLK(NULL,	"pmd_trace_clk_mux_ck",			&pmd_trace_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"syc_clk_div_ck",			&syc_clk_div_ck,	CK_443X),
+	CLK(NULL,	"aes1_fck",				&aes1_fck,	CK_443X),
+	CLK(NULL,	"aes2_fck",				&aes2_fck,	CK_443X),
+	CLK(NULL,	"aess_fck",				&aess_fck,	CK_443X),
+	CLK(NULL,	"bandgap_fclk",				&bandgap_fclk,	CK_443X),
+	CLK(NULL,	"des3des_fck",				&des3des_fck,	CK_443X),
+	CLK(NULL,	"dmic_sync_mux_ck",			&dmic_sync_mux_ck,	CK_443X),
+	CLK(NULL,	"dmic_fck",				&dmic_fck,	CK_443X),
+	CLK(NULL,	"dsp_fck",				&dsp_fck,	CK_443X),
+	CLK(NULL,	"dss_sys_clk",				&dss_sys_clk,	CK_443X),
+	CLK(NULL,	"dss_tv_clk",				&dss_tv_clk,	CK_443X),
+	CLK(NULL,	"dss_dss_clk",				&dss_dss_clk,	CK_443X),
+	CLK(NULL,	"dss_48mhz_clk",			&dss_48mhz_clk,	CK_443X),
+	CLK(NULL,	"dss_fck",				&dss_fck,	CK_443X),
+	CLK(NULL,	"efuse_ctrl_cust_fck",			&efuse_ctrl_cust_fck,	CK_443X),
+	CLK(NULL,	"emif1_fck",				&emif1_fck,	CK_443X),
+	CLK(NULL,	"emif2_fck",				&emif2_fck,	CK_443X),
+	CLK(NULL,	"fdif_fck",				&fdif_fck,	CK_443X),
+	CLK(NULL,	"fpka_fck",				&fpka_fck,	CK_443X),
+	CLK(NULL,	"gpio1_dbclk",				&gpio1_dbclk,	CK_443X),
+	CLK(NULL,	"gpio1_ick",				&gpio1_ick,	CK_443X),
+	CLK(NULL,	"gpio2_dbclk",				&gpio2_dbclk,	CK_443X),
+	CLK(NULL,	"gpio2_ick",				&gpio2_ick,	CK_443X),
+	CLK(NULL,	"gpio3_dbclk",				&gpio3_dbclk,	CK_443X),
+	CLK(NULL,	"gpio3_ick",				&gpio3_ick,	CK_443X),
+	CLK(NULL,	"gpio4_dbclk",				&gpio4_dbclk,	CK_443X),
+	CLK(NULL,	"gpio4_ick",				&gpio4_ick,	CK_443X),
+	CLK(NULL,	"gpio5_dbclk",				&gpio5_dbclk,	CK_443X),
+	CLK(NULL,	"gpio5_ick",				&gpio5_ick,	CK_443X),
+	CLK(NULL,	"gpio6_dbclk",				&gpio6_dbclk,	CK_443X),
+	CLK(NULL,	"gpio6_ick",				&gpio6_ick,	CK_443X),
+	CLK(NULL,	"gpmc_ick",				&gpmc_ick,	CK_443X),
+	CLK(NULL,	"per_sgx_fclk",				&per_sgx_fclk,	CK_443X),
+	CLK(NULL,	"gpu_fck",				&gpu_fck,	CK_443X),
+	CLK("omap2_hdq.0",	"fck",					&hdq1w_fck,	CK_443X),
+	CLK(NULL,	"hsi_fck",				&hsi_fck,	CK_443X),
+	CLK("i2c_omap.1",	"fck",					&i2c1_fck,	CK_443X),
+	CLK("i2c_omap.2",	"fck",					&i2c2_fck,	CK_443X),
+	CLK("i2c_omap.3",	"fck",					&i2c3_fck,	CK_443X),
+	CLK("i2c_omap.4",	"fck",					&i2c4_fck,	CK_443X),
+	CLK(NULL,	"ipu_fck",				&ipu_fck,	CK_443X),
+	CLK(NULL,	"iss_ctrlclk",				&iss_ctrlclk,	CK_443X),
+	CLK(NULL,	"iss_fck",				&iss_fck,	CK_443X),
+	CLK(NULL,	"iva_fck",				&iva_fck,	CK_443X),
+	CLK(NULL,	"kbd_fck",				&kbd_fck,	CK_443X),
+	CLK(NULL,	"l3_instr_ick",				&l3_instr_ick,	CK_443X),
+	CLK(NULL,	"l3_main_3_ick",			&l3_main_3_ick,	CK_443X),
+	CLK(NULL,	"mcasp_sync_mux_ck",			&mcasp_sync_mux_ck,	CK_443X),
+	CLK(NULL,	"mcasp_fck",				&mcasp_fck,	CK_443X),
+	CLK(NULL,	"mcbsp1_sync_mux_ck",			&mcbsp1_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.1",	"fck",					&mcbsp1_fck,	CK_443X),
+	CLK(NULL,	"mcbsp2_sync_mux_ck",			&mcbsp2_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.2",	"fck",					&mcbsp2_fck,	CK_443X),
+	CLK(NULL,	"mcbsp3_sync_mux_ck",			&mcbsp3_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.3",	"fck",					&mcbsp3_fck,	CK_443X),
+	CLK(NULL,	"mcbsp4_sync_mux_ck",			&mcbsp4_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.4",	"fck",					&mcbsp4_fck,	CK_443X),
+	CLK(NULL,	"mcpdm_fck",				&mcpdm_fck,	CK_443X),
+	CLK("omap2_mcspi.1",	"fck",					&mcspi1_fck,	CK_443X),
+	CLK("omap2_mcspi.2",	"fck",					&mcspi2_fck,	CK_443X),
+	CLK("omap2_mcspi.3",	"fck",					&mcspi3_fck,	CK_443X),
+	CLK("omap2_mcspi.4",	"fck",					&mcspi4_fck,	CK_443X),
+	CLK("mmci-omap-hs.0",	"fck",					&mmc1_fck,	CK_443X),
+	CLK("mmci-omap-hs.1",	"fck",					&mmc2_fck,	CK_443X),
+	CLK("mmci-omap-hs.2",	"fck",					&mmc3_fck,	CK_443X),
+	CLK("mmci-omap-hs.3",	"fck",					&mmc4_fck,	CK_443X),
+	CLK("mmci-omap-hs.4",	"fck",					&mmc5_fck,	CK_443X),
+	CLK(NULL,	"ocp2scp_usb_phy_clk32k",		&ocp2scp_usb_phy_clk32k,	CK_443X),
+	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",		&ocp2scp_usb_phy_phy_48m,	CK_443X),
+	CLK(NULL,	"ocp2scp_usb_phy_ick",			&ocp2scp_usb_phy_ick,	CK_443X),
+	CLK(NULL,	"ocp_wp_noc_ick",			&ocp_wp_noc_ick,	CK_443X),
+	CLK("omap_rng",	"ick",					&rng_ick,	CK_443X),
+	CLK(NULL,	"sha2md5_fck",				&sha2md5_fck,	CK_443X),
+	CLK(NULL,	"sl2if_ick",				&sl2if_ick,	CK_443X),
+	CLK(NULL,	"slimbus1_fclk_1",			&slimbus1_fclk_1,	CK_443X),
+	CLK(NULL,	"slimbus1_fclk_0",			&slimbus1_fclk_0,	CK_443X),
+	CLK(NULL,	"slimbus1_fclk_2",			&slimbus1_fclk_2,	CK_443X),
+	CLK(NULL,	"slimbus1_slimbus_clk",			&slimbus1_slimbus_clk,	CK_443X),
+	CLK(NULL,	"slimbus1_fck",				&slimbus1_fck,	CK_443X),
+	CLK(NULL,	"slimbus2_fclk_1",			&slimbus2_fclk_1,	CK_443X),
+	CLK(NULL,	"slimbus2_fclk_0",			&slimbus2_fclk_0,	CK_443X),
+	CLK(NULL,	"slimbus2_slimbus_clk",			&slimbus2_slimbus_clk,	CK_443X),
+	CLK(NULL,	"slimbus2_fck",				&slimbus2_fck,	CK_443X),
+	CLK(NULL,	"smartreflex_core_fck",			&smartreflex_core_fck,	CK_443X),
+	CLK(NULL,	"smartreflex_iva_fck",			&smartreflex_iva_fck,	CK_443X),
+	CLK(NULL,	"smartreflex_mpu_fck",			&smartreflex_mpu_fck,	CK_443X),
+	CLK(NULL,	"gpt1_fck",				&timer1_fck,	CK_443X),
+	CLK(NULL,	"gpt10_fck",				&timer10_fck,	CK_443X),
+	CLK(NULL,	"gpt11_fck",				&timer11_fck,	CK_443X),
+	CLK(NULL,	"gpt2_fck",				&timer2_fck,	CK_443X),
+	CLK(NULL,	"gpt3_fck",				&timer3_fck,	CK_443X),
+	CLK(NULL,	"gpt4_fck",				&timer4_fck,	CK_443X),
+	CLK(NULL,	"gpt5_fck",				&timer5_fck,	CK_443X),
+	CLK(NULL,	"gpt6_fck",				&timer6_fck,	CK_443X),
+	CLK(NULL,	"gpt7_fck",				&timer7_fck,	CK_443X),
+	CLK(NULL,	"gpt8_fck",				&timer8_fck,	CK_443X),
+	CLK(NULL,	"gpt9_fck",				&timer9_fck,	CK_443X),
+	CLK(NULL,	"uart1_fck",				&uart1_fck,	CK_443X),
+	CLK(NULL,	"uart2_fck",				&uart2_fck,	CK_443X),
+	CLK(NULL,	"uart3_fck",				&uart3_fck,	CK_443X),
+	CLK(NULL,	"uart4_fck",				&uart4_fck,	CK_443X),
+	CLK(NULL,	"usb_host_fs_fck",			&usb_host_fs_fck,	CK_443X),
+	CLK(NULL,	"usb_host_hs_utmi_p3_clk",		&usb_host_hs_utmi_p3_clk,	CK_443X),
+	CLK(NULL,	"usb_host_hs_hsic60m_p1_clk",		&usb_host_hs_hsic60m_p1_clk,	CK_443X),
+	CLK(NULL,	"usb_host_hs_hsic60m_p2_clk",		&usb_host_hs_hsic60m_p2_clk,	CK_443X),
+	CLK(NULL,	"utmi_p1_gfclk",			&utmi_p1_gfclk,	CK_443X),
+	CLK(NULL,	"usb_host_hs_utmi_p1_clk",		&usb_host_hs_utmi_p1_clk,	CK_443X),
+	CLK(NULL,	"utmi_p2_gfclk",			&utmi_p2_gfclk,	CK_443X),
+	CLK(NULL,	"usb_host_hs_utmi_p2_clk",		&usb_host_hs_utmi_p2_clk,	CK_443X),
+	CLK(NULL,	"usb_host_hs_hsic480m_p1_clk",		&usb_host_hs_hsic480m_p1_clk,	CK_443X),
+	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",		&usb_host_hs_hsic480m_p2_clk,	CK_443X),
+	CLK(NULL,	"usb_host_hs_func48mclk",		&usb_host_hs_func48mclk,	CK_443X),
+	CLK(NULL,	"usb_host_hs_fck",			&usb_host_hs_fck,	CK_443X),
+	CLK(NULL,	"otg_60m_gfclk",			&otg_60m_gfclk,	CK_443X),
+	CLK(NULL,	"usb_otg_hs_xclk",			&usb_otg_hs_xclk,	CK_443X),
+	CLK("musb_hdrc",	"ick",					&usb_otg_hs_ick,	CK_443X),
+	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",		&usb_tll_hs_usb_ch2_clk,	CK_443X),
+	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",		&usb_tll_hs_usb_ch0_clk,	CK_443X),
+	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",		&usb_tll_hs_usb_ch1_clk,	CK_443X),
+	CLK(NULL,	"usb_tll_hs_ick",			&usb_tll_hs_ick,	CK_443X),
+	CLK(NULL,	"usim_fck",				&usim_fck,	CK_443X),
+	CLK("omap_wdt",	"fck",					&wd_timer2_fck,	CK_443X),
+	CLK(NULL,	"wd_timer3_fck",			&wd_timer3_fck,	CK_443X),
+	CLK(NULL,	"stm_clk_div_ck",			&stm_clk_div_ck,	CK_443X),
+	CLK(NULL,	"trace_clk_div_ck",			&trace_clk_div_ck,	CK_443X),
+	CLK(NULL,	"usim_fclk",				&usim_fclk,	CK_443X),
+	CLK(NULL,	"gpmc_ck",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt1_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt2_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt3_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt4_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt5_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt6_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt7_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt8_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt9_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt10_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt11_ick",				&dummy_ck,	CK_443X),
+	CLK("i2c_omap.1",	"ick",					&dummy_ck,	CK_443X),
+	CLK("i2c_omap.2",	"ick",					&dummy_ck,	CK_443X),
+	CLK("i2c_omap.3",	"ick",					&dummy_ck,	CK_443X),
+	CLK("i2c_omap.4",	"ick",					&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.0",	"ick",					&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.1",	"ick",					&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.2",	"ick",					&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.3",	"ick",					&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.4",	"ick",					&dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.1",	"ick",					&dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.2",	"ick",					&dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.3",	"ick",					&dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.4",	"ick",					&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.1",	"ick",					&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.2",	"ick",					&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.3",	"ick",					&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.4",	"ick",					&dummy_ck,	CK_443X),
+	CLK(NULL,	"uart1_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"uart2_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"uart3_ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"uart4_ick",				&dummy_ck,	CK_443X),
+	CLK("omap_wdt",	"ick",					&dummy_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.6.0.4

