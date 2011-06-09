From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 7/8] OMAP: clock: Add flags to identify optional clock nodes
Date: Thu, 9 Jun 2011 16:24:12 +0530
Message-ID: <1307616853-28395-8-git-send-email-rnayak@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
 <1307616853-28395-2-git-send-email-rnayak@ti.com>
 <1307616853-28395-3-git-send-email-rnayak@ti.com>
 <1307616853-28395-4-git-send-email-rnayak@ti.com>
 <1307616853-28395-5-git-send-email-rnayak@ti.com>
 <1307616853-28395-6-git-send-email-rnayak@ti.com>
 <1307616853-28395-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40276 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757126Ab1FIKyg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jun 2011 06:54:36 -0400
In-Reply-To: <1307616853-28395-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

There is a need to identify optional clock nodes in
the clock framework, so some specific sequence
to enable them can be supported, which should be
evident in the subsequent patches.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c    |   34 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h |    1 +
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 8c96567..58564fd 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1394,6 +1394,7 @@ static struct clk bandgap_fclk = {
 	.clkdm_name	= "l4_wkup_clkdm",
 	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk des3des_fck = {
@@ -1464,6 +1465,7 @@ static struct clk dss_sys_clk = {
 	.clkdm_name	= "l3_dss_clkdm",
 	.parent		= &syc_clk_div_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk dss_tv_clk = {
@@ -1474,6 +1476,7 @@ static struct clk dss_tv_clk = {
 	.clkdm_name	= "l3_dss_clkdm",
 	.parent		= &extalt_clkin_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk dss_dss_clk = {
@@ -1484,6 +1487,7 @@ static struct clk dss_dss_clk = {
 	.clkdm_name	= "l3_dss_clkdm",
 	.parent		= &dpll_per_m5x2_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk dss_48mhz_clk = {
@@ -1494,6 +1498,7 @@ static struct clk dss_48mhz_clk = {
 	.clkdm_name	= "l3_dss_clkdm",
 	.parent		= &func_48mc_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk dss_fck = {
@@ -1577,6 +1582,7 @@ static struct clk gpio1_dbclk = {
 	.clkdm_name	= "l4_wkup_clkdm",
 	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk gpio1_ick = {
@@ -1597,6 +1603,7 @@ static struct clk gpio2_dbclk = {
 	.clkdm_name	= "l4_per_clkdm",
 	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk gpio2_ick = {
@@ -1617,6 +1624,7 @@ static struct clk gpio3_dbclk = {
 	.clkdm_name	= "l4_per_clkdm",
 	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk gpio3_ick = {
@@ -1637,6 +1645,7 @@ static struct clk gpio4_dbclk = {
 	.clkdm_name	= "l4_per_clkdm",
 	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk gpio4_ick = {
@@ -1657,6 +1666,7 @@ static struct clk gpio5_dbclk = {
 	.clkdm_name	= "l4_per_clkdm",
 	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk gpio5_ick = {
@@ -1677,6 +1687,7 @@ static struct clk gpio6_dbclk = {
 	.clkdm_name	= "l4_per_clkdm",
 	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk gpio6_ick = {
@@ -1809,6 +1820,7 @@ static struct clk iss_ctrlclk = {
 	.clkdm_name	= "iss_clkdm",
 	.parent		= &func_96m_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk iss_fck = {
@@ -2145,6 +2157,7 @@ static struct clk ocp2scp_usb_phy_phy_48m = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &func_48m_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk ocp2scp_usb_phy_ick = {
@@ -2206,6 +2219,7 @@ static struct clk slimbus1_fclk_1 = {
 	.clkdm_name	= "abe_clkdm",
 	.parent		= &func_24m_clk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk slimbus1_fclk_0 = {
@@ -2216,6 +2230,7 @@ static struct clk slimbus1_fclk_0 = {
 	.clkdm_name	= "abe_clkdm",
 	.parent		= &abe_24m_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk slimbus1_fclk_2 = {
@@ -2226,6 +2241,7 @@ static struct clk slimbus1_fclk_2 = {
 	.clkdm_name	= "abe_clkdm",
 	.parent		= &pad_clks_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk slimbus1_slimbus_clk = {
@@ -2236,6 +2252,7 @@ static struct clk slimbus1_slimbus_clk = {
 	.clkdm_name	= "abe_clkdm",
 	.parent		= &slimbus_clk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk slimbus1_fck = {
@@ -2256,6 +2273,7 @@ static struct clk slimbus2_fclk_1 = {
 	.clkdm_name	= "l4_per_clkdm",
 	.parent		= &per_abe_24m_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk slimbus2_fclk_0 = {
@@ -2266,6 +2284,7 @@ static struct clk slimbus2_fclk_0 = {
 	.clkdm_name	= "l4_per_clkdm",
 	.parent		= &func_24mc_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk slimbus2_slimbus_clk = {
@@ -2276,6 +2295,7 @@ static struct clk slimbus2_slimbus_clk = {
 	.clkdm_name	= "l4_per_clkdm",
 	.parent		= &pad_slimbus_core_clks_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk slimbus2_fck = {
@@ -2564,6 +2584,7 @@ static struct clk usb_host_hs_utmi_p1_clk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &utmi_p1_gfclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static const struct clksel utmi_p2_gfclk_sel[] = {
@@ -2591,6 +2612,7 @@ static struct clk usb_host_hs_utmi_p2_clk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &utmi_p2_gfclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_host_hs_utmi_p3_clk = {
@@ -2601,6 +2623,7 @@ static struct clk usb_host_hs_utmi_p3_clk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &init_60m_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_host_hs_hsic480m_p1_clk = {
@@ -2611,6 +2634,7 @@ static struct clk usb_host_hs_hsic480m_p1_clk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &dpll_usb_m2_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_host_hs_hsic60m_p1_clk = {
@@ -2621,6 +2645,7 @@ static struct clk usb_host_hs_hsic60m_p1_clk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &init_60m_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_host_hs_hsic60m_p2_clk = {
@@ -2631,6 +2656,7 @@ static struct clk usb_host_hs_hsic60m_p2_clk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &init_60m_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_host_hs_hsic480m_p2_clk = {
@@ -2641,6 +2667,7 @@ static struct clk usb_host_hs_hsic480m_p2_clk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &dpll_usb_m2_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_host_hs_func48mclk = {
@@ -2651,6 +2678,7 @@ static struct clk usb_host_hs_func48mclk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &func_48mc_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_host_hs_fck = {
@@ -2688,6 +2716,7 @@ static struct clk usb_otg_hs_xclk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &otg_60m_gfclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_otg_hs_ick = {
@@ -2708,6 +2737,7 @@ static struct clk usb_phy_cm_clk32k = {
 	.clkdm_name	= "l4_ao_clkdm",
 	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_tll_hs_usb_ch2_clk = {
@@ -2718,6 +2748,7 @@ static struct clk usb_tll_hs_usb_ch2_clk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &init_60m_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_tll_hs_usb_ch0_clk = {
@@ -2728,6 +2759,7 @@ static struct clk usb_tll_hs_usb_ch0_clk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &init_60m_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_tll_hs_usb_ch1_clk = {
@@ -2738,6 +2770,7 @@ static struct clk usb_tll_hs_usb_ch1_clk = {
 	.clkdm_name	= "l3_init_clkdm",
 	.parent		= &init_60m_fclk,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usb_tll_hs_ick = {
@@ -2781,6 +2814,7 @@ static struct clk usim_fclk = {
 	.clkdm_name	= "l4_wkup_clkdm",
 	.parent		= &usim_ck,
 	.recalc		= &followparent_recalc,
+	.flags		= CLOCK_OPTCLK,
 };
 
 static struct clk usim_fck = {
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 006e599..cb2de7d 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -189,6 +189,7 @@ struct dpll_data {
 #define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
 #define CLOCK_CLKOUTX2		(1 << 5)
+#define CLOCK_OPTCLK		(1 << 6)
 
 /**
  * struct clk - OMAP struct clk
-- 
1.7.0.4

