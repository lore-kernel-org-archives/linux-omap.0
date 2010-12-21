From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 5/6] omap4: mark some data as omap4-specific
Date: Tue, 21 Dec 2010 19:20:03 +0100
Message-ID: <1292955604-8809-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44934 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab0LUSVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 13:21:01 -0500
In-Reply-To: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Petazzoni <tpetazzoni@ti.com>, Thomas Petazzoni <t-petazzoni@ti.com>

From: Thomas Petazzoni <tpetazzoni@ti.com>

Use __omap4_data on clock related data and hwmod related data for
OMAP4 SoCs. This data will later be freed if we end up booting on a
non-OMAP4 SoC.

Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c       |  438 ++++++++++++++--------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  278 +++++++++---------
 2 files changed, 358 insertions(+), 358 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 1599836..0b0f213 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -38,79 +38,79 @@
 
 /* Root clocks */
 
-static struct clk extalt_clkin_ck = {
+static struct clk __omap4_data extalt_clkin_ck = {
 	.name		= "extalt_clkin_ck",
 	.rate		= 59000000,
 	.ops		= &clkops_null,
 };
 
-static struct clk pad_clks_ck = {
+static struct clk __omap4_data pad_clks_ck = {
 	.name		= "pad_clks_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
 };
 
-static struct clk pad_slimbus_core_clks_ck = {
+static struct clk __omap4_data pad_slimbus_core_clks_ck = {
 	.name		= "pad_slimbus_core_clks_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
 };
 
-static struct clk secure_32k_clk_src_ck = {
+static struct clk __omap4_data secure_32k_clk_src_ck = {
 	.name		= "secure_32k_clk_src_ck",
 	.rate		= 32768,
 	.ops		= &clkops_null,
 };
 
-static struct clk slimbus_clk = {
+static struct clk __omap4_data slimbus_clk = {
 	.name		= "slimbus_clk",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
 };
 
-static struct clk sys_32k_ck = {
+static struct clk __omap4_data sys_32k_ck = {
 	.name		= "sys_32k_ck",
 	.rate		= 32768,
 	.ops		= &clkops_null,
 };
 
-static struct clk virt_12000000_ck = {
+static struct clk __omap4_data virt_12000000_ck = {
 	.name		= "virt_12000000_ck",
 	.ops		= &clkops_null,
 	.rate		= 12000000,
 };
 
-static struct clk virt_13000000_ck = {
+static struct clk __omap4_data virt_13000000_ck = {
 	.name		= "virt_13000000_ck",
 	.ops		= &clkops_null,
 	.rate		= 13000000,
 };
 
-static struct clk virt_16800000_ck = {
+static struct clk __omap4_data virt_16800000_ck = {
 	.name		= "virt_16800000_ck",
 	.ops		= &clkops_null,
 	.rate		= 16800000,
 };
 
-static struct clk virt_19200000_ck = {
+static struct clk __omap4_data virt_19200000_ck = {
 	.name		= "virt_19200000_ck",
 	.ops		= &clkops_null,
 	.rate		= 19200000,
 };
 
-static struct clk virt_26000000_ck = {
+static struct clk __omap4_data virt_26000000_ck = {
 	.name		= "virt_26000000_ck",
 	.ops		= &clkops_null,
 	.rate		= 26000000,
 };
 
-static struct clk virt_27000000_ck = {
+static struct clk __omap4_data virt_27000000_ck = {
 	.name		= "virt_27000000_ck",
 	.ops		= &clkops_null,
 	.rate		= 27000000,
 };
 
-static struct clk virt_38400000_ck = {
+static struct clk __omap4_data virt_38400000_ck = {
 	.name		= "virt_38400000_ck",
 	.ops		= &clkops_null,
 	.rate		= 38400000,
@@ -167,7 +167,7 @@ static const struct clksel sys_clkin_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk sys_clkin_ck = {
+static struct clk __omap4_data sys_clkin_ck = {
 	.name		= "sys_clkin_ck",
 	.rate		= 38400000,
 	.clksel		= sys_clkin_sel,
@@ -178,31 +178,31 @@ static struct clk sys_clkin_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk tie_low_clock_ck = {
+static struct clk __omap4_data tie_low_clock_ck = {
 	.name		= "tie_low_clock_ck",
 	.rate		= 0,
 	.ops		= &clkops_null,
 };
 
-static struct clk utmi_phy_clkout_ck = {
+static struct clk __omap4_data utmi_phy_clkout_ck = {
 	.name		= "utmi_phy_clkout_ck",
 	.rate		= 60000000,
 	.ops		= &clkops_null,
 };
 
-static struct clk xclk60mhsp1_ck = {
+static struct clk __omap4_data xclk60mhsp1_ck = {
 	.name		= "xclk60mhsp1_ck",
 	.rate		= 60000000,
 	.ops		= &clkops_null,
 };
 
-static struct clk xclk60mhsp2_ck = {
+static struct clk __omap4_data xclk60mhsp2_ck = {
 	.name		= "xclk60mhsp2_ck",
 	.rate		= 60000000,
 	.ops		= &clkops_null,
 };
 
-static struct clk xclk60motg_ck = {
+static struct clk __omap4_data xclk60motg_ck = {
 	.name		= "xclk60motg_ck",
 	.rate		= 60000000,
 	.ops		= &clkops_null,
@@ -216,14 +216,14 @@ static const struct clksel abe_dpll_bypass_clk_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk abe_dpll_bypass_clk_mux_ck = {
+static struct clk __omap4_data abe_dpll_bypass_clk_mux_ck = {
 	.name		= "abe_dpll_bypass_clk_mux_ck",
 	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk abe_dpll_refclk_mux_ck = {
+static struct clk __omap4_data abe_dpll_refclk_mux_ck = {
 	.name		= "abe_dpll_refclk_mux_ck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= abe_dpll_bypass_clk_mux_sel,
@@ -235,7 +235,7 @@ static struct clk abe_dpll_refclk_mux_ck = {
 };
 
 /* DPLL_ABE */
-static struct dpll_data dpll_abe_dd = {
+static struct dpll_data __omap4_data dpll_abe_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_ABE,
 	.clk_bypass	= &abe_dpll_bypass_clk_mux_ck,
 	.clk_ref	= &abe_dpll_refclk_mux_ck,
@@ -254,7 +254,7 @@ static struct dpll_data dpll_abe_dd = {
 };
 
 
-static struct clk dpll_abe_ck = {
+static struct clk __omap4_data dpll_abe_ck = {
 	.name		= "dpll_abe_ck",
 	.parent		= &abe_dpll_refclk_mux_ck,
 	.dpll_data	= &dpll_abe_dd,
@@ -265,14 +265,14 @@ static struct clk dpll_abe_ck = {
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 };
 
-static struct clk dpll_abe_m2x2_ck = {
+static struct clk __omap4_data dpll_abe_m2x2_ck = {
 	.name		= "dpll_abe_m2x2_ck",
 	.parent		= &dpll_abe_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk abe_24m_fclk = {
+static struct clk __omap4_data abe_24m_fclk = {
 	.name		= "abe_24m_fclk",
 	.parent		= &dpll_abe_m2x2_ck,
 	.ops		= &clkops_null,
@@ -291,7 +291,7 @@ static const struct clksel abe_clk_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk abe_clk = {
+static struct clk __omap4_data abe_clk = {
 	.name		= "abe_clk",
 	.parent		= &dpll_abe_m2x2_ck,
 	.clksel		= abe_clk_div,
@@ -314,7 +314,7 @@ static const struct clksel aess_fclk_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk aess_fclk = {
+static struct clk __omap4_data aess_fclk = {
 	.name		= "aess_fclk",
 	.parent		= &abe_clk,
 	.clksel		= aess_fclk_div,
@@ -366,7 +366,7 @@ static const struct clksel dpll_abe_m3_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk dpll_abe_m3_ck = {
+static struct clk __omap4_data dpll_abe_m3_ck = {
 	.name		= "dpll_abe_m3_ck",
 	.parent		= &dpll_abe_ck,
 	.clksel		= dpll_abe_m3_div,
@@ -384,7 +384,7 @@ static const struct clksel core_hsd_byp_clk_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk core_hsd_byp_clk_mux_ck = {
+static struct clk __omap4_data core_hsd_byp_clk_mux_ck = {
 	.name		= "core_hsd_byp_clk_mux_ck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= core_hsd_byp_clk_mux_sel,
@@ -396,7 +396,7 @@ static struct clk core_hsd_byp_clk_mux_ck = {
 };
 
 /* DPLL_CORE */
-static struct dpll_data dpll_core_dd = {
+static struct dpll_data __omap4_data dpll_core_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_CORE,
 	.clk_bypass	= &core_hsd_byp_clk_mux_ck,
 	.clk_ref	= &sys_clkin_ck,
@@ -415,7 +415,7 @@ static struct dpll_data dpll_core_dd = {
 };
 
 
-static struct clk dpll_core_ck = {
+static struct clk __omap4_data dpll_core_ck = {
 	.name		= "dpll_core_ck",
 	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_core_dd,
@@ -429,7 +429,7 @@ static const struct clksel dpll_core_m6_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk dpll_core_m6_ck = {
+static struct clk __omap4_data dpll_core_m6_ck = {
 	.name		= "dpll_core_m6_ck",
 	.parent		= &dpll_core_ck,
 	.clksel		= dpll_core_m6_div,
@@ -447,14 +447,14 @@ static const struct clksel dbgclk_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk dbgclk_mux_ck = {
+static struct clk __omap4_data dbgclk_mux_ck = {
 	.name		= "dbgclk_mux_ck",
 	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dpll_core_m2_ck = {
+static struct clk __omap4_data dpll_core_m2_ck = {
 	.name		= "dpll_core_m2_ck",
 	.parent		= &dpll_core_ck,
 	.clksel		= dpll_core_m6_div,
@@ -466,14 +466,14 @@ static struct clk dpll_core_m2_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk ddrphy_ck = {
+static struct clk __omap4_data ddrphy_ck = {
 	.name		= "ddrphy_ck",
 	.parent		= &dpll_core_m2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dpll_core_m5_ck = {
+static struct clk __omap4_data dpll_core_m5_ck = {
 	.name		= "dpll_core_m5_ck",
 	.parent		= &dpll_core_ck,
 	.clksel		= dpll_core_m6_div,
@@ -490,7 +490,7 @@ static const struct clksel div_core_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk div_core_ck = {
+static struct clk __omap4_data div_core_ck = {
 	.name		= "div_core_ck",
 	.parent		= &dpll_core_m5_ck,
 	.clksel		= div_core_div,
@@ -515,7 +515,7 @@ static const struct clksel div_iva_hs_clk_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk div_iva_hs_clk = {
+static struct clk __omap4_data div_iva_hs_clk = {
 	.name		= "div_iva_hs_clk",
 	.parent		= &dpll_core_m5_ck,
 	.clksel		= div_iva_hs_clk_div,
@@ -527,7 +527,7 @@ static struct clk div_iva_hs_clk = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk div_mpu_hs_clk = {
+static struct clk __omap4_data div_mpu_hs_clk = {
 	.name		= "div_mpu_hs_clk",
 	.parent		= &dpll_core_m5_ck,
 	.clksel		= div_iva_hs_clk_div,
@@ -539,7 +539,7 @@ static struct clk div_mpu_hs_clk = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk dpll_core_m4_ck = {
+static struct clk __omap4_data dpll_core_m4_ck = {
 	.name		= "dpll_core_m4_ck",
 	.parent		= &dpll_core_ck,
 	.clksel		= dpll_core_m6_div,
@@ -551,14 +551,14 @@ static struct clk dpll_core_m4_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk dll_clk_div_ck = {
+static struct clk __omap4_data dll_clk_div_ck = {
 	.name		= "dll_clk_div_ck",
 	.parent		= &dpll_core_m4_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dpll_abe_m2_ck = {
+static struct clk __omap4_data dpll_abe_m2_ck = {
 	.name		= "dpll_abe_m2_ck",
 	.parent		= &dpll_abe_ck,
 	.clksel		= dpll_abe_m3_div,
@@ -570,7 +570,7 @@ static struct clk dpll_abe_m2_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk dpll_core_m3_ck = {
+static struct clk __omap4_data dpll_core_m3_ck = {
 	.name		= "dpll_core_m3_ck",
 	.parent		= &dpll_core_ck,
 	.clksel		= dpll_core_m6_div,
@@ -582,7 +582,7 @@ static struct clk dpll_core_m3_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk dpll_core_m7_ck = {
+static struct clk __omap4_data dpll_core_m7_ck = {
 	.name		= "dpll_core_m7_ck",
 	.parent		= &dpll_core_ck,
 	.clksel		= dpll_core_m6_div,
@@ -600,7 +600,7 @@ static const struct clksel iva_hsd_byp_clk_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk iva_hsd_byp_clk_mux_ck = {
+static struct clk __omap4_data iva_hsd_byp_clk_mux_ck = {
 	.name		= "iva_hsd_byp_clk_mux_ck",
 	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
@@ -608,7 +608,7 @@ static struct clk iva_hsd_byp_clk_mux_ck = {
 };
 
 /* DPLL_IVA */
-static struct dpll_data dpll_iva_dd = {
+static struct dpll_data __omap4_data dpll_iva_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_IVA,
 	.clk_bypass	= &iva_hsd_byp_clk_mux_ck,
 	.clk_ref	= &sys_clkin_ck,
@@ -627,7 +627,7 @@ static struct dpll_data dpll_iva_dd = {
 };
 
 
-static struct clk dpll_iva_ck = {
+static struct clk __omap4_data dpll_iva_ck = {
 	.name		= "dpll_iva_ck",
 	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_iva_dd,
@@ -643,7 +643,7 @@ static const struct clksel dpll_iva_m4_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk dpll_iva_m4_ck = {
+static struct clk __omap4_data dpll_iva_m4_ck = {
 	.name		= "dpll_iva_m4_ck",
 	.parent		= &dpll_iva_ck,
 	.clksel		= dpll_iva_m4_div,
@@ -655,7 +655,7 @@ static struct clk dpll_iva_m4_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk dpll_iva_m5_ck = {
+static struct clk __omap4_data dpll_iva_m5_ck = {
 	.name		= "dpll_iva_m5_ck",
 	.parent		= &dpll_iva_ck,
 	.clksel		= dpll_iva_m4_div,
@@ -668,7 +668,7 @@ static struct clk dpll_iva_m5_ck = {
 };
 
 /* DPLL_MPU */
-static struct dpll_data dpll_mpu_dd = {
+static struct dpll_data __omap4_data dpll_mpu_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_MPU,
 	.clk_bypass	= &div_mpu_hs_clk,
 	.clk_ref	= &sys_clkin_ck,
@@ -687,7 +687,7 @@ static struct dpll_data dpll_mpu_dd = {
 };
 
 
-static struct clk dpll_mpu_ck = {
+static struct clk __omap4_data dpll_mpu_ck = {
 	.name		= "dpll_mpu_ck",
 	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_mpu_dd,
@@ -703,7 +703,7 @@ static const struct clksel dpll_mpu_m2_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk dpll_mpu_m2_ck = {
+static struct clk __omap4_data dpll_mpu_m2_ck = {
 	.name		= "dpll_mpu_m2_ck",
 	.parent		= &dpll_mpu_ck,
 	.clksel		= dpll_mpu_m2_div,
@@ -715,7 +715,7 @@ static struct clk dpll_mpu_m2_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk per_hs_clk_div_ck = {
+static struct clk __omap4_data per_hs_clk_div_ck = {
 	.name		= "per_hs_clk_div_ck",
 	.parent		= &dpll_abe_m3_ck,
 	.ops		= &clkops_null,
@@ -728,7 +728,7 @@ static const struct clksel per_hsd_byp_clk_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk per_hsd_byp_clk_mux_ck = {
+static struct clk __omap4_data per_hsd_byp_clk_mux_ck = {
 	.name		= "per_hsd_byp_clk_mux_ck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= per_hsd_byp_clk_mux_sel,
@@ -740,7 +740,7 @@ static struct clk per_hsd_byp_clk_mux_ck = {
 };
 
 /* DPLL_PER */
-static struct dpll_data dpll_per_dd = {
+static struct dpll_data __omap4_data dpll_per_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_PER,
 	.clk_bypass	= &per_hsd_byp_clk_mux_ck,
 	.clk_ref	= &sys_clkin_ck,
@@ -759,7 +759,7 @@ static struct dpll_data dpll_per_dd = {
 };
 
 
-static struct clk dpll_per_ck = {
+static struct clk __omap4_data dpll_per_ck = {
 	.name		= "dpll_per_ck",
 	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_per_dd,
@@ -775,7 +775,7 @@ static const struct clksel dpll_per_m2_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk dpll_per_m2_ck = {
+static struct clk __omap4_data dpll_per_m2_ck = {
 	.name		= "dpll_per_m2_ck",
 	.parent		= &dpll_per_ck,
 	.clksel		= dpll_per_m2_div,
@@ -787,14 +787,14 @@ static struct clk dpll_per_m2_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk dpll_per_m2x2_ck = {
+static struct clk __omap4_data dpll_per_m2x2_ck = {
 	.name		= "dpll_per_m2x2_ck",
 	.parent		= &dpll_per_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dpll_per_m3_ck = {
+static struct clk __omap4_data dpll_per_m3_ck = {
 	.name		= "dpll_per_m3_ck",
 	.parent		= &dpll_per_ck,
 	.clksel		= dpll_per_m2_div,
@@ -806,7 +806,7 @@ static struct clk dpll_per_m3_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk dpll_per_m4_ck = {
+static struct clk __omap4_data dpll_per_m4_ck = {
 	.name		= "dpll_per_m4_ck",
 	.parent		= &dpll_per_ck,
 	.clksel		= dpll_per_m2_div,
@@ -818,7 +818,7 @@ static struct clk dpll_per_m4_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk dpll_per_m5_ck = {
+static struct clk __omap4_data dpll_per_m5_ck = {
 	.name		= "dpll_per_m5_ck",
 	.parent		= &dpll_per_ck,
 	.clksel		= dpll_per_m2_div,
@@ -830,7 +830,7 @@ static struct clk dpll_per_m5_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk dpll_per_m6_ck = {
+static struct clk __omap4_data dpll_per_m6_ck = {
 	.name		= "dpll_per_m6_ck",
 	.parent		= &dpll_per_ck,
 	.clksel		= dpll_per_m2_div,
@@ -842,7 +842,7 @@ static struct clk dpll_per_m6_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk dpll_per_m7_ck = {
+static struct clk __omap4_data dpll_per_m7_ck = {
 	.name		= "dpll_per_m7_ck",
 	.parent		= &dpll_per_ck,
 	.clksel		= dpll_per_m2_div,
@@ -855,7 +855,7 @@ static struct clk dpll_per_m7_ck = {
 };
 
 /* DPLL_UNIPRO */
-static struct dpll_data dpll_unipro_dd = {
+static struct dpll_data __omap4_data dpll_unipro_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_UNIPRO,
 	.clk_bypass	= &sys_clkin_ck,
 	.clk_ref	= &sys_clkin_ck,
@@ -874,7 +874,7 @@ static struct dpll_data dpll_unipro_dd = {
 };
 
 
-static struct clk dpll_unipro_ck = {
+static struct clk __omap4_data dpll_unipro_ck = {
 	.name		= "dpll_unipro_ck",
 	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_unipro_dd,
@@ -890,7 +890,7 @@ static const struct clksel dpll_unipro_m2x2_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk dpll_unipro_m2x2_ck = {
+static struct clk __omap4_data dpll_unipro_m2x2_ck = {
 	.name		= "dpll_unipro_m2x2_ck",
 	.parent		= &dpll_unipro_ck,
 	.clksel		= dpll_unipro_m2x2_div,
@@ -902,7 +902,7 @@ static struct clk dpll_unipro_m2x2_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk usb_hs_clk_div_ck = {
+static struct clk __omap4_data usb_hs_clk_div_ck = {
 	.name		= "usb_hs_clk_div_ck",
 	.parent		= &dpll_abe_m3_ck,
 	.ops		= &clkops_null,
@@ -910,7 +910,7 @@ static struct clk usb_hs_clk_div_ck = {
 };
 
 /* DPLL_USB */
-static struct dpll_data dpll_usb_dd = {
+static struct dpll_data __omap4_data dpll_usb_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_USB,
 	.clk_bypass	= &usb_hs_clk_div_ck,
 	.flags		= DPLL_J_TYPE | DPLL_NO_DCO_SEL,
@@ -930,7 +930,7 @@ static struct dpll_data dpll_usb_dd = {
 };
 
 
-static struct clk dpll_usb_ck = {
+static struct clk __omap4_data dpll_usb_ck = {
 	.name		= "dpll_usb_ck",
 	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_usb_dd,
@@ -941,7 +941,7 @@ static struct clk dpll_usb_ck = {
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 };
 
-static struct clk dpll_usb_clkdcoldo_ck = {
+static struct clk __omap4_data dpll_usb_clkdcoldo_ck = {
 	.name		= "dpll_usb_clkdcoldo_ck",
 	.parent		= &dpll_usb_ck,
 	.ops		= &clkops_null,
@@ -953,7 +953,7 @@ static const struct clksel dpll_usb_m2_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk dpll_usb_m2_ck = {
+static struct clk __omap4_data dpll_usb_m2_ck = {
 	.name		= "dpll_usb_m2_ck",
 	.parent		= &dpll_usb_ck,
 	.clksel		= dpll_usb_m2_div,
@@ -971,7 +971,7 @@ static const struct clksel ducati_clk_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk ducati_clk_mux_ck = {
+static struct clk __omap4_data ducati_clk_mux_ck = {
 	.name		= "ducati_clk_mux_ck",
 	.parent		= &div_core_ck,
 	.clksel		= ducati_clk_mux_sel,
@@ -982,21 +982,21 @@ static struct clk ducati_clk_mux_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk func_12m_fclk = {
+static struct clk __omap4_data func_12m_fclk = {
 	.name		= "func_12m_fclk",
 	.parent		= &dpll_per_m2x2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk func_24m_clk = {
+static struct clk __omap4_data func_24m_clk = {
 	.name		= "func_24m_clk",
 	.parent		= &dpll_per_m2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk func_24mc_fclk = {
+static struct clk __omap4_data func_24mc_fclk = {
 	.name		= "func_24mc_fclk",
 	.parent		= &dpll_per_m2x2_ck,
 	.ops		= &clkops_null,
@@ -1014,7 +1014,7 @@ static const struct clksel func_48m_fclk_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk func_48m_fclk = {
+static struct clk __omap4_data func_48m_fclk = {
 	.name		= "func_48m_fclk",
 	.parent		= &dpll_per_m2x2_ck,
 	.clksel		= func_48m_fclk_div,
@@ -1026,7 +1026,7 @@ static struct clk func_48m_fclk = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk func_48mc_fclk = {
+static struct clk __omap4_data func_48mc_fclk = {
 	.name		= "func_48mc_fclk",
 	.parent		= &dpll_per_m2x2_ck,
 	.ops		= &clkops_null,
@@ -1044,7 +1044,7 @@ static const struct clksel func_64m_fclk_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk func_64m_fclk = {
+static struct clk __omap4_data func_64m_fclk = {
 	.name		= "func_64m_fclk",
 	.parent		= &dpll_per_m4_ck,
 	.clksel		= func_64m_fclk_div,
@@ -1061,7 +1061,7 @@ static const struct clksel func_96m_fclk_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk func_96m_fclk = {
+static struct clk __omap4_data func_96m_fclk = {
 	.name		= "func_96m_fclk",
 	.parent		= &dpll_per_m2x2_ck,
 	.clksel		= func_96m_fclk_div,
@@ -1079,7 +1079,7 @@ static const struct clksel hsmmc6_fclk_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk hsmmc6_fclk = {
+static struct clk __omap4_data hsmmc6_fclk = {
 	.name		= "hsmmc6_fclk",
 	.parent		= &func_64m_fclk,
 	.ops		= &clkops_null,
@@ -1097,7 +1097,7 @@ static const struct clksel init_60m_fclk_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk init_60m_fclk = {
+static struct clk __omap4_data init_60m_fclk = {
 	.name		= "init_60m_fclk",
 	.parent		= &dpll_usb_m2_ck,
 	.clksel		= init_60m_fclk_div,
@@ -1114,7 +1114,7 @@ static const struct clksel l3_div_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk l3_div_ck = {
+static struct clk __omap4_data l3_div_ck = {
 	.name		= "l3_div_ck",
 	.parent		= &div_core_ck,
 	.clksel		= l3_div_div,
@@ -1131,7 +1131,7 @@ static const struct clksel l4_div_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk l4_div_ck = {
+static struct clk __omap4_data l4_div_ck = {
 	.name		= "l4_div_ck",
 	.parent		= &l3_div_ck,
 	.clksel		= l4_div_div,
@@ -1143,7 +1143,7 @@ static struct clk l4_div_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk lp_clk_div_ck = {
+static struct clk __omap4_data lp_clk_div_ck = {
 	.name		= "lp_clk_div_ck",
 	.parent		= &dpll_abe_m2x2_ck,
 	.ops		= &clkops_null,
@@ -1156,7 +1156,7 @@ static const struct clksel l4_wkup_clk_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk l4_wkup_clk_mux_ck = {
+static struct clk __omap4_data l4_wkup_clk_mux_ck = {
 	.name		= "l4_wkup_clk_mux_ck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= l4_wkup_clk_mux_sel,
@@ -1172,7 +1172,7 @@ static const struct clksel per_abe_nc_fclk_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk per_abe_nc_fclk = {
+static struct clk __omap4_data per_abe_nc_fclk = {
 	.name		= "per_abe_nc_fclk",
 	.parent		= &dpll_abe_m2_ck,
 	.clksel		= per_abe_nc_fclk_div,
@@ -1190,28 +1190,28 @@ static const struct clksel mcasp2_fclk_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk mcasp2_fclk = {
+static struct clk __omap4_data mcasp2_fclk = {
 	.name		= "mcasp2_fclk",
 	.parent		= &func_96m_fclk,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcasp3_fclk = {
+static struct clk __omap4_data mcasp3_fclk = {
 	.name		= "mcasp3_fclk",
 	.parent		= &func_96m_fclk,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ocp_abe_iclk = {
+static struct clk __omap4_data ocp_abe_iclk = {
 	.name		= "ocp_abe_iclk",
 	.parent		= &aess_fclk,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk per_abe_24m_fclk = {
+static struct clk __omap4_data per_abe_24m_fclk = {
 	.name		= "per_abe_24m_fclk",
 	.parent		= &dpll_abe_m2_ck,
 	.ops		= &clkops_null,
@@ -1225,14 +1225,14 @@ static const struct clksel pmd_stm_clock_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk pmd_stm_clock_mux_ck = {
+static struct clk __omap4_data pmd_stm_clock_mux_ck = {
 	.name		= "pmd_stm_clock_mux_ck",
 	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk pmd_trace_clk_mux_ck = {
+static struct clk __omap4_data pmd_trace_clk_mux_ck = {
 	.name		= "pmd_trace_clk_mux_ck",
 	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
@@ -1244,7 +1244,7 @@ static const struct clksel syc_clk_div_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk syc_clk_div_ck = {
+static struct clk __omap4_data syc_clk_div_ck = {
 	.name		= "syc_clk_div_ck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= syc_clk_div_div,
@@ -1258,7 +1258,7 @@ static struct clk syc_clk_div_ck = {
 
 /* Leaf clocks controlled by modules */
 
-static struct clk aes1_fck = {
+static struct clk __omap4_data aes1_fck = {
 	.name		= "aes1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_AES1_CLKCTRL,
@@ -1268,7 +1268,7 @@ static struct clk aes1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk aes2_fck = {
+static struct clk __omap4_data aes2_fck = {
 	.name		= "aes2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_AES2_CLKCTRL,
@@ -1278,7 +1278,7 @@ static struct clk aes2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk aess_fck = {
+static struct clk __omap4_data aess_fck = {
 	.name		= "aess_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_AESS_CLKCTRL,
@@ -1288,7 +1288,7 @@ static struct clk aess_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk bandgap_fclk = {
+static struct clk __omap4_data bandgap_fclk = {
 	.name		= "bandgap_fclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
@@ -1298,7 +1298,7 @@ static struct clk bandgap_fclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk des3des_fck = {
+static struct clk __omap4_data des3des_fck = {
 	.name		= "des3des_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_DES3DES_CLKCTRL,
@@ -1315,7 +1315,7 @@ static const struct clksel dmic_sync_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk dmic_sync_mux_ck = {
+static struct clk __omap4_data dmic_sync_mux_ck = {
 	.name		= "dmic_sync_mux_ck",
 	.parent		= &abe_24m_fclk,
 	.clksel		= dmic_sync_mux_sel,
@@ -1334,7 +1334,7 @@ static const struct clksel func_dmic_abe_gfclk_sel[] = {
 };
 
 /* Merged func_dmic_abe_gfclk into dmic */
-static struct clk dmic_fck = {
+static struct clk __omap4_data dmic_fck = {
 	.name		= "dmic_fck",
 	.parent		= &dmic_sync_mux_ck,
 	.clksel		= func_dmic_abe_gfclk_sel,
@@ -1348,7 +1348,7 @@ static struct clk dmic_fck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
-static struct clk dsp_fck = {
+static struct clk __omap4_data dsp_fck = {
 	.name		= "dsp_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_TESLA_TESLA_CLKCTRL,
@@ -1358,7 +1358,7 @@ static struct clk dsp_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_sys_clk = {
+static struct clk __omap4_data dss_sys_clk = {
 	.name		= "dss_sys_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1368,7 +1368,7 @@ static struct clk dss_sys_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_tv_clk = {
+static struct clk __omap4_data dss_tv_clk = {
 	.name		= "dss_tv_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1378,7 +1378,7 @@ static struct clk dss_tv_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_dss_clk = {
+static struct clk __omap4_data dss_dss_clk = {
 	.name		= "dss_dss_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1388,7 +1388,7 @@ static struct clk dss_dss_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_48mhz_clk = {
+static struct clk __omap4_data dss_48mhz_clk = {
 	.name		= "dss_48mhz_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1398,7 +1398,7 @@ static struct clk dss_48mhz_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_fck = {
+static struct clk __omap4_data dss_fck = {
 	.name		= "dss_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1408,7 +1408,7 @@ static struct clk dss_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk efuse_ctrl_cust_fck = {
+static struct clk __omap4_data efuse_ctrl_cust_fck = {
 	.name		= "efuse_ctrl_cust_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL,
@@ -1418,7 +1418,7 @@ static struct clk efuse_ctrl_cust_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk emif1_fck = {
+static struct clk __omap4_data emif1_fck = {
 	.name		= "emif1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL,
@@ -1429,7 +1429,7 @@ static struct clk emif1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk emif2_fck = {
+static struct clk __omap4_data emif2_fck = {
 	.name		= "emif2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL,
@@ -1446,7 +1446,7 @@ static const struct clksel fdif_fclk_div[] = {
 };
 
 /* Merged fdif_fclk into fdif */
-static struct clk fdif_fck = {
+static struct clk __omap4_data fdif_fck = {
 	.name		= "fdif_fck",
 	.parent		= &dpll_per_m4_ck,
 	.clksel		= fdif_fclk_div,
@@ -1461,7 +1461,7 @@ static struct clk fdif_fck = {
 	.clkdm_name	= "iss_clkdm",
 };
 
-static struct clk fpka_fck = {
+static struct clk __omap4_data fpka_fck = {
 	.name		= "fpka_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL,
@@ -1471,7 +1471,7 @@ static struct clk fpka_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio1_dbclk = {
+static struct clk __omap4_data gpio1_dbclk = {
 	.name		= "gpio1_dbclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
@@ -1481,7 +1481,7 @@ static struct clk gpio1_dbclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio1_ick = {
+static struct clk __omap4_data gpio1_ick = {
 	.name		= "gpio1_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
@@ -1491,7 +1491,7 @@ static struct clk gpio1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio2_dbclk = {
+static struct clk __omap4_data gpio2_dbclk = {
 	.name		= "gpio2_dbclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
@@ -1501,7 +1501,7 @@ static struct clk gpio2_dbclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio2_ick = {
+static struct clk __omap4_data gpio2_ick = {
 	.name		= "gpio2_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
@@ -1511,7 +1511,7 @@ static struct clk gpio2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio3_dbclk = {
+static struct clk __omap4_data gpio3_dbclk = {
 	.name		= "gpio3_dbclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
@@ -1521,7 +1521,7 @@ static struct clk gpio3_dbclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio3_ick = {
+static struct clk __omap4_data gpio3_ick = {
 	.name		= "gpio3_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
@@ -1531,7 +1531,7 @@ static struct clk gpio3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio4_dbclk = {
+static struct clk __omap4_data gpio4_dbclk = {
 	.name		= "gpio4_dbclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
@@ -1541,7 +1541,7 @@ static struct clk gpio4_dbclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio4_ick = {
+static struct clk __omap4_data gpio4_ick = {
 	.name		= "gpio4_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
@@ -1551,7 +1551,7 @@ static struct clk gpio4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio5_dbclk = {
+static struct clk __omap4_data gpio5_dbclk = {
 	.name		= "gpio5_dbclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
@@ -1561,7 +1561,7 @@ static struct clk gpio5_dbclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio5_ick = {
+static struct clk __omap4_data gpio5_ick = {
 	.name		= "gpio5_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
@@ -1571,7 +1571,7 @@ static struct clk gpio5_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio6_dbclk = {
+static struct clk __omap4_data gpio6_dbclk = {
 	.name		= "gpio6_dbclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
@@ -1581,7 +1581,7 @@ static struct clk gpio6_dbclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio6_ick = {
+static struct clk __omap4_data gpio6_ick = {
 	.name		= "gpio6_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
@@ -1591,7 +1591,7 @@ static struct clk gpio6_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpmc_ick = {
+static struct clk __omap4_data gpmc_ick = {
 	.name		= "gpmc_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3_2_GPMC_CLKCTRL,
@@ -1608,7 +1608,7 @@ static const struct clksel sgx_clk_mux_sel[] = {
 };
 
 /* Merged sgx_clk_mux into gpu */
-static struct clk gpu_fck = {
+static struct clk __omap4_data gpu_fck = {
 	.name		= "gpu_fck",
 	.parent		= &dpll_core_m7_ck,
 	.clksel		= sgx_clk_mux_sel,
@@ -1622,7 +1622,7 @@ static struct clk gpu_fck = {
 	.clkdm_name	= "l3_gfx_clkdm",
 };
 
-static struct clk hdq1w_fck = {
+static struct clk __omap4_data hdq1w_fck = {
 	.name		= "hdq1w_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_HDQ1W_CLKCTRL,
@@ -1638,7 +1638,7 @@ static const struct clksel hsi_fclk_div[] = {
 };
 
 /* Merged hsi_fclk into hsi */
-static struct clk hsi_fck = {
+static struct clk __omap4_data hsi_fck = {
 	.name		= "hsi_fck",
 	.parent		= &dpll_per_m2x2_ck,
 	.clksel		= hsi_fclk_div,
@@ -1653,7 +1653,7 @@ static struct clk hsi_fck = {
 	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk i2c1_fck = {
+static struct clk __omap4_data i2c1_fck = {
 	.name		= "i2c1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_I2C1_CLKCTRL,
@@ -1663,7 +1663,7 @@ static struct clk i2c1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c2_fck = {
+static struct clk __omap4_data i2c2_fck = {
 	.name		= "i2c2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_I2C2_CLKCTRL,
@@ -1673,7 +1673,7 @@ static struct clk i2c2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c3_fck = {
+static struct clk __omap4_data i2c3_fck = {
 	.name		= "i2c3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_I2C3_CLKCTRL,
@@ -1683,7 +1683,7 @@ static struct clk i2c3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c4_fck = {
+static struct clk __omap4_data i2c4_fck = {
 	.name		= "i2c4_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_I2C4_CLKCTRL,
@@ -1693,7 +1693,7 @@ static struct clk i2c4_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ipu_fck = {
+static struct clk __omap4_data ipu_fck = {
 	.name		= "ipu_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
@@ -1703,7 +1703,7 @@ static struct clk ipu_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk iss_ctrlclk = {
+static struct clk __omap4_data iss_ctrlclk = {
 	.name		= "iss_ctrlclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_CAM_ISS_CLKCTRL,
@@ -1713,7 +1713,7 @@ static struct clk iss_ctrlclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk iss_fck = {
+static struct clk __omap4_data iss_fck = {
 	.name		= "iss_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_CAM_ISS_CLKCTRL,
@@ -1723,7 +1723,7 @@ static struct clk iss_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk iva_fck = {
+static struct clk __omap4_data iva_fck = {
 	.name		= "iva_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
@@ -1733,7 +1733,7 @@ static struct clk iva_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk kbd_fck = {
+static struct clk __omap4_data kbd_fck = {
 	.name		= "kbd_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
@@ -1743,7 +1743,7 @@ static struct clk kbd_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk l3_instr_ick = {
+static struct clk __omap4_data l3_instr_ick = {
 	.name		= "l3_instr_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL,
@@ -1753,7 +1753,7 @@ static struct clk l3_instr_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk l3_main_3_ick = {
+static struct clk __omap4_data l3_main_3_ick = {
 	.name		= "l3_main_3_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_L3_3_CLKCTRL,
@@ -1763,7 +1763,7 @@ static struct clk l3_main_3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcasp_sync_mux_ck = {
+static struct clk __omap4_data mcasp_sync_mux_ck = {
 	.name		= "mcasp_sync_mux_ck",
 	.parent		= &abe_24m_fclk,
 	.clksel		= dmic_sync_mux_sel,
@@ -1782,7 +1782,7 @@ static const struct clksel func_mcasp_abe_gfclk_sel[] = {
 };
 
 /* Merged func_mcasp_abe_gfclk into mcasp */
-static struct clk mcasp_fck = {
+static struct clk __omap4_data mcasp_fck = {
 	.name		= "mcasp_fck",
 	.parent		= &mcasp_sync_mux_ck,
 	.clksel		= func_mcasp_abe_gfclk_sel,
@@ -1796,7 +1796,7 @@ static struct clk mcasp_fck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
-static struct clk mcbsp1_sync_mux_ck = {
+static struct clk __omap4_data mcbsp1_sync_mux_ck = {
 	.name		= "mcbsp1_sync_mux_ck",
 	.parent		= &abe_24m_fclk,
 	.clksel		= dmic_sync_mux_sel,
@@ -1815,7 +1815,7 @@ static const struct clksel func_mcbsp1_gfclk_sel[] = {
 };
 
 /* Merged func_mcbsp1_gfclk into mcbsp1 */
-static struct clk mcbsp1_fck = {
+static struct clk __omap4_data mcbsp1_fck = {
 	.name		= "mcbsp1_fck",
 	.parent		= &mcbsp1_sync_mux_ck,
 	.clksel		= func_mcbsp1_gfclk_sel,
@@ -1829,7 +1829,7 @@ static struct clk mcbsp1_fck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
-static struct clk mcbsp2_sync_mux_ck = {
+static struct clk __omap4_data mcbsp2_sync_mux_ck = {
 	.name		= "mcbsp2_sync_mux_ck",
 	.parent		= &abe_24m_fclk,
 	.clksel		= dmic_sync_mux_sel,
@@ -1848,7 +1848,7 @@ static const struct clksel func_mcbsp2_gfclk_sel[] = {
 };
 
 /* Merged func_mcbsp2_gfclk into mcbsp2 */
-static struct clk mcbsp2_fck = {
+static struct clk __omap4_data mcbsp2_fck = {
 	.name		= "mcbsp2_fck",
 	.parent		= &mcbsp2_sync_mux_ck,
 	.clksel		= func_mcbsp2_gfclk_sel,
@@ -1862,7 +1862,7 @@ static struct clk mcbsp2_fck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
-static struct clk mcbsp3_sync_mux_ck = {
+static struct clk __omap4_data mcbsp3_sync_mux_ck = {
 	.name		= "mcbsp3_sync_mux_ck",
 	.parent		= &abe_24m_fclk,
 	.clksel		= dmic_sync_mux_sel,
@@ -1881,7 +1881,7 @@ static const struct clksel func_mcbsp3_gfclk_sel[] = {
 };
 
 /* Merged func_mcbsp3_gfclk into mcbsp3 */
-static struct clk mcbsp3_fck = {
+static struct clk __omap4_data mcbsp3_fck = {
 	.name		= "mcbsp3_fck",
 	.parent		= &mcbsp3_sync_mux_ck,
 	.clksel		= func_mcbsp3_gfclk_sel,
@@ -1895,7 +1895,7 @@ static struct clk mcbsp3_fck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
-static struct clk mcbsp4_sync_mux_ck = {
+static struct clk __omap4_data mcbsp4_sync_mux_ck = {
 	.name		= "mcbsp4_sync_mux_ck",
 	.parent		= &func_96m_fclk,
 	.clksel		= mcasp2_fclk_sel,
@@ -1913,7 +1913,7 @@ static const struct clksel per_mcbsp4_gfclk_sel[] = {
 };
 
 /* Merged per_mcbsp4_gfclk into mcbsp4 */
-static struct clk mcbsp4_fck = {
+static struct clk __omap4_data mcbsp4_fck = {
 	.name		= "mcbsp4_fck",
 	.parent		= &mcbsp4_sync_mux_ck,
 	.clksel		= per_mcbsp4_gfclk_sel,
@@ -1927,7 +1927,7 @@ static struct clk mcbsp4_fck = {
 	.clkdm_name	= "l4_per_clkdm",
 };
 
-static struct clk mcpdm_fck = {
+static struct clk __omap4_data mcpdm_fck = {
 	.name		= "mcpdm_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_PDM_CLKCTRL,
@@ -1937,7 +1937,7 @@ static struct clk mcpdm_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi1_fck = {
+static struct clk __omap4_data mcspi1_fck = {
 	.name		= "mcspi1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
@@ -1947,7 +1947,7 @@ static struct clk mcspi1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi2_fck = {
+static struct clk __omap4_data mcspi2_fck = {
 	.name		= "mcspi2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
@@ -1957,7 +1957,7 @@ static struct clk mcspi2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi3_fck = {
+static struct clk __omap4_data mcspi3_fck = {
 	.name		= "mcspi3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
@@ -1967,7 +1967,7 @@ static struct clk mcspi3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi4_fck = {
+static struct clk __omap4_data mcspi4_fck = {
 	.name		= "mcspi4_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
@@ -1978,7 +1978,7 @@ static struct clk mcspi4_fck = {
 };
 
 /* Merged hsmmc1_fclk into mmc1 */
-static struct clk mmc1_fck = {
+static struct clk __omap4_data mmc1_fck = {
 	.name		= "mmc1_fck",
 	.parent		= &func_64m_fclk,
 	.clksel		= hsmmc6_fclk_sel,
@@ -1993,7 +1993,7 @@ static struct clk mmc1_fck = {
 };
 
 /* Merged hsmmc2_fclk into mmc2 */
-static struct clk mmc2_fck = {
+static struct clk __omap4_data mmc2_fck = {
 	.name		= "mmc2_fck",
 	.parent		= &func_64m_fclk,
 	.clksel		= hsmmc6_fclk_sel,
@@ -2007,7 +2007,7 @@ static struct clk mmc2_fck = {
 	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk mmc3_fck = {
+static struct clk __omap4_data mmc3_fck = {
 	.name		= "mmc3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MMCSD3_CLKCTRL,
@@ -2017,7 +2017,7 @@ static struct clk mmc3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmc4_fck = {
+static struct clk __omap4_data mmc4_fck = {
 	.name		= "mmc4_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MMCSD4_CLKCTRL,
@@ -2027,7 +2027,7 @@ static struct clk mmc4_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmc5_fck = {
+static struct clk __omap4_data mmc5_fck = {
 	.name		= "mmc5_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MMCSD5_CLKCTRL,
@@ -2037,7 +2037,7 @@ static struct clk mmc5_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ocp2scp_usb_phy_phy_48m = {
+static struct clk __omap4_data ocp2scp_usb_phy_phy_48m = {
 	.name		= "ocp2scp_usb_phy_phy_48m",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
@@ -2047,7 +2047,7 @@ static struct clk ocp2scp_usb_phy_phy_48m = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ocp2scp_usb_phy_ick = {
+static struct clk __omap4_data ocp2scp_usb_phy_ick = {
 	.name		= "ocp2scp_usb_phy_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
@@ -2057,7 +2057,7 @@ static struct clk ocp2scp_usb_phy_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ocp_wp_noc_ick = {
+static struct clk __omap4_data ocp_wp_noc_ick = {
 	.name		= "ocp_wp_noc_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL,
@@ -2067,7 +2067,7 @@ static struct clk ocp_wp_noc_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk rng_ick = {
+static struct clk __omap4_data rng_ick = {
 	.name		= "rng_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_RNG_CLKCTRL,
@@ -2077,7 +2077,7 @@ static struct clk rng_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sha2md5_fck = {
+static struct clk __omap4_data sha2md5_fck = {
 	.name		= "sha2md5_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
@@ -2087,7 +2087,7 @@ static struct clk sha2md5_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sl2if_ick = {
+static struct clk __omap4_data sl2if_ick = {
 	.name		= "sl2if_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_IVAHD_SL2_CLKCTRL,
@@ -2097,7 +2097,7 @@ static struct clk sl2if_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus1_fclk_1 = {
+static struct clk __omap4_data slimbus1_fclk_1 = {
 	.name		= "slimbus1_fclk_1",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
@@ -2107,7 +2107,7 @@ static struct clk slimbus1_fclk_1 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus1_fclk_0 = {
+static struct clk __omap4_data slimbus1_fclk_0 = {
 	.name		= "slimbus1_fclk_0",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
@@ -2117,7 +2117,7 @@ static struct clk slimbus1_fclk_0 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus1_fclk_2 = {
+static struct clk __omap4_data slimbus1_fclk_2 = {
 	.name		= "slimbus1_fclk_2",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
@@ -2127,7 +2127,7 @@ static struct clk slimbus1_fclk_2 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus1_slimbus_clk = {
+static struct clk __omap4_data slimbus1_slimbus_clk = {
 	.name		= "slimbus1_slimbus_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
@@ -2137,7 +2137,7 @@ static struct clk slimbus1_slimbus_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus1_fck = {
+static struct clk __omap4_data slimbus1_fck = {
 	.name		= "slimbus1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
@@ -2147,7 +2147,7 @@ static struct clk slimbus1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus2_fclk_1 = {
+static struct clk __omap4_data slimbus2_fclk_1 = {
 	.name		= "slimbus2_fclk_1",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
@@ -2157,7 +2157,7 @@ static struct clk slimbus2_fclk_1 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus2_fclk_0 = {
+static struct clk __omap4_data slimbus2_fclk_0 = {
 	.name		= "slimbus2_fclk_0",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
@@ -2167,7 +2167,7 @@ static struct clk slimbus2_fclk_0 = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus2_slimbus_clk = {
+static struct clk __omap4_data slimbus2_slimbus_clk = {
 	.name		= "slimbus2_slimbus_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
@@ -2177,7 +2177,7 @@ static struct clk slimbus2_slimbus_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus2_fck = {
+static struct clk __omap4_data slimbus2_fck = {
 	.name		= "slimbus2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
@@ -2187,7 +2187,7 @@ static struct clk slimbus2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk smartreflex_core_fck = {
+static struct clk __omap4_data smartreflex_core_fck = {
 	.name		= "smartreflex_core_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
@@ -2197,7 +2197,7 @@ static struct clk smartreflex_core_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk smartreflex_iva_fck = {
+static struct clk __omap4_data smartreflex_iva_fck = {
 	.name		= "smartreflex_iva_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
@@ -2207,7 +2207,7 @@ static struct clk smartreflex_iva_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk smartreflex_mpu_fck = {
+static struct clk __omap4_data smartreflex_mpu_fck = {
 	.name		= "smartreflex_mpu_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
@@ -2218,7 +2218,7 @@ static struct clk smartreflex_mpu_fck = {
 };
 
 /* Merged dmt1_clk_mux into timer1 */
-static struct clk timer1_fck = {
+static struct clk __omap4_data timer1_fck = {
 	.name		= "timer1_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= abe_dpll_bypass_clk_mux_sel,
@@ -2233,7 +2233,7 @@ static struct clk timer1_fck = {
 };
 
 /* Merged cm2_dm10_mux into timer10 */
-static struct clk timer10_fck = {
+static struct clk __omap4_data timer10_fck = {
 	.name		= "timer10_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= abe_dpll_bypass_clk_mux_sel,
@@ -2248,7 +2248,7 @@ static struct clk timer10_fck = {
 };
 
 /* Merged cm2_dm11_mux into timer11 */
-static struct clk timer11_fck = {
+static struct clk __omap4_data timer11_fck = {
 	.name		= "timer11_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= abe_dpll_bypass_clk_mux_sel,
@@ -2263,7 +2263,7 @@ static struct clk timer11_fck = {
 };
 
 /* Merged cm2_dm2_mux into timer2 */
-static struct clk timer2_fck = {
+static struct clk __omap4_data timer2_fck = {
 	.name		= "timer2_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= abe_dpll_bypass_clk_mux_sel,
@@ -2278,7 +2278,7 @@ static struct clk timer2_fck = {
 };
 
 /* Merged cm2_dm3_mux into timer3 */
-static struct clk timer3_fck = {
+static struct clk __omap4_data timer3_fck = {
 	.name		= "timer3_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= abe_dpll_bypass_clk_mux_sel,
@@ -2293,7 +2293,7 @@ static struct clk timer3_fck = {
 };
 
 /* Merged cm2_dm4_mux into timer4 */
-static struct clk timer4_fck = {
+static struct clk __omap4_data timer4_fck = {
 	.name		= "timer4_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= abe_dpll_bypass_clk_mux_sel,
@@ -2314,7 +2314,7 @@ static const struct clksel timer5_sync_mux_sel[] = {
 };
 
 /* Merged timer5_sync_mux into timer5 */
-static struct clk timer5_fck = {
+static struct clk __omap4_data timer5_fck = {
 	.name		= "timer5_fck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
@@ -2329,7 +2329,7 @@ static struct clk timer5_fck = {
 };
 
 /* Merged timer6_sync_mux into timer6 */
-static struct clk timer6_fck = {
+static struct clk __omap4_data timer6_fck = {
 	.name		= "timer6_fck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
@@ -2344,7 +2344,7 @@ static struct clk timer6_fck = {
 };
 
 /* Merged timer7_sync_mux into timer7 */
-static struct clk timer7_fck = {
+static struct clk __omap4_data timer7_fck = {
 	.name		= "timer7_fck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
@@ -2359,7 +2359,7 @@ static struct clk timer7_fck = {
 };
 
 /* Merged timer8_sync_mux into timer8 */
-static struct clk timer8_fck = {
+static struct clk __omap4_data timer8_fck = {
 	.name		= "timer8_fck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
@@ -2374,7 +2374,7 @@ static struct clk timer8_fck = {
 };
 
 /* Merged cm2_dm9_mux into timer9 */
-static struct clk timer9_fck = {
+static struct clk __omap4_data timer9_fck = {
 	.name		= "timer9_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= abe_dpll_bypass_clk_mux_sel,
@@ -2388,7 +2388,7 @@ static struct clk timer9_fck = {
 	.clkdm_name	= "l4_per_clkdm",
 };
 
-static struct clk uart1_fck = {
+static struct clk __omap4_data uart1_fck = {
 	.name		= "uart1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_UART1_CLKCTRL,
@@ -2398,7 +2398,7 @@ static struct clk uart1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart2_fck = {
+static struct clk __omap4_data uart2_fck = {
 	.name		= "uart2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_UART2_CLKCTRL,
@@ -2408,7 +2408,7 @@ static struct clk uart2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart3_fck = {
+static struct clk __omap4_data uart3_fck = {
 	.name		= "uart3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_UART3_CLKCTRL,
@@ -2418,7 +2418,7 @@ static struct clk uart3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart4_fck = {
+static struct clk __omap4_data uart4_fck = {
 	.name		= "uart4_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_UART4_CLKCTRL,
@@ -2428,7 +2428,7 @@ static struct clk uart4_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_fs_fck = {
+static struct clk __omap4_data usb_host_fs_fck = {
 	.name		= "usb_host_fs_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL,
@@ -2438,7 +2438,7 @@ static struct clk usb_host_fs_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_hs_utmi_p3_clk = {
+static struct clk __omap4_data usb_host_hs_utmi_p3_clk = {
 	.name		= "usb_host_hs_utmi_p3_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
@@ -2448,7 +2448,7 @@ static struct clk usb_host_hs_utmi_p3_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_hs_hsic60m_p1_clk = {
+static struct clk __omap4_data usb_host_hs_hsic60m_p1_clk = {
 	.name		= "usb_host_hs_hsic60m_p1_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
@@ -2458,7 +2458,7 @@ static struct clk usb_host_hs_hsic60m_p1_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_hs_hsic60m_p2_clk = {
+static struct clk __omap4_data usb_host_hs_hsic60m_p2_clk = {
 	.name		= "usb_host_hs_hsic60m_p2_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
@@ -2474,7 +2474,7 @@ static const struct clksel utmi_p1_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk utmi_p1_gfclk = {
+static struct clk __omap4_data utmi_p1_gfclk = {
 	.name		= "utmi_p1_gfclk",
 	.parent		= &init_60m_fclk,
 	.clksel		= utmi_p1_gfclk_sel,
@@ -2485,7 +2485,7 @@ static struct clk utmi_p1_gfclk = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk usb_host_hs_utmi_p1_clk = {
+static struct clk __omap4_data usb_host_hs_utmi_p1_clk = {
 	.name		= "usb_host_hs_utmi_p1_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
@@ -2501,7 +2501,7 @@ static const struct clksel utmi_p2_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk utmi_p2_gfclk = {
+static struct clk __omap4_data utmi_p2_gfclk = {
 	.name		= "utmi_p2_gfclk",
 	.parent		= &init_60m_fclk,
 	.clksel		= utmi_p2_gfclk_sel,
@@ -2512,7 +2512,7 @@ static struct clk utmi_p2_gfclk = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk usb_host_hs_utmi_p2_clk = {
+static struct clk __omap4_data usb_host_hs_utmi_p2_clk = {
 	.name		= "usb_host_hs_utmi_p2_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
@@ -2522,7 +2522,7 @@ static struct clk usb_host_hs_utmi_p2_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_hs_hsic480m_p1_clk = {
+static struct clk __omap4_data usb_host_hs_hsic480m_p1_clk = {
 	.name		= "usb_host_hs_hsic480m_p1_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
@@ -2532,7 +2532,7 @@ static struct clk usb_host_hs_hsic480m_p1_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_hs_hsic480m_p2_clk = {
+static struct clk __omap4_data usb_host_hs_hsic480m_p2_clk = {
 	.name		= "usb_host_hs_hsic480m_p2_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
@@ -2542,7 +2542,7 @@ static struct clk usb_host_hs_hsic480m_p2_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_hs_func48mclk = {
+static struct clk __omap4_data usb_host_hs_func48mclk = {
 	.name		= "usb_host_hs_func48mclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
@@ -2552,7 +2552,7 @@ static struct clk usb_host_hs_func48mclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_hs_fck = {
+static struct clk __omap4_data usb_host_hs_fck = {
 	.name		= "usb_host_hs_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
@@ -2568,7 +2568,7 @@ static const struct clksel otg_60m_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk otg_60m_gfclk = {
+static struct clk __omap4_data otg_60m_gfclk = {
 	.name		= "otg_60m_gfclk",
 	.parent		= &utmi_phy_clkout_ck,
 	.clksel		= otg_60m_gfclk_sel,
@@ -2579,7 +2579,7 @@ static struct clk otg_60m_gfclk = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk usb_otg_hs_xclk = {
+static struct clk __omap4_data usb_otg_hs_xclk = {
 	.name		= "usb_otg_hs_xclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
@@ -2589,7 +2589,7 @@ static struct clk usb_otg_hs_xclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_otg_hs_ick = {
+static struct clk __omap4_data usb_otg_hs_ick = {
 	.name		= "usb_otg_hs_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
@@ -2599,7 +2599,7 @@ static struct clk usb_otg_hs_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_phy_cm_clk32k = {
+static struct clk __omap4_data usb_phy_cm_clk32k = {
 	.name		= "usb_phy_cm_clk32k",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_ALWON_USBPHY_CLKCTRL,
@@ -2609,7 +2609,7 @@ static struct clk usb_phy_cm_clk32k = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_tll_hs_usb_ch2_clk = {
+static struct clk __omap4_data usb_tll_hs_usb_ch2_clk = {
 	.name		= "usb_tll_hs_usb_ch2_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
@@ -2619,7 +2619,7 @@ static struct clk usb_tll_hs_usb_ch2_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_tll_hs_usb_ch0_clk = {
+static struct clk __omap4_data usb_tll_hs_usb_ch0_clk = {
 	.name		= "usb_tll_hs_usb_ch0_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
@@ -2629,7 +2629,7 @@ static struct clk usb_tll_hs_usb_ch0_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_tll_hs_usb_ch1_clk = {
+static struct clk __omap4_data usb_tll_hs_usb_ch1_clk = {
 	.name		= "usb_tll_hs_usb_ch1_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
@@ -2639,7 +2639,7 @@ static struct clk usb_tll_hs_usb_ch1_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_tll_hs_ick = {
+static struct clk __omap4_data usb_tll_hs_ick = {
 	.name		= "usb_tll_hs_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
@@ -2660,7 +2660,7 @@ static const struct clksel usim_fclk_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk usim_ck = {
+static struct clk __omap4_data usim_ck = {
 	.name		= "usim_ck",
 	.parent		= &dpll_per_m4_ck,
 	.clksel		= usim_fclk_div,
@@ -2672,7 +2672,7 @@ static struct clk usim_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clk usim_fclk = {
+static struct clk __omap4_data usim_fclk = {
 	.name		= "usim_fclk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
@@ -2682,7 +2682,7 @@ static struct clk usim_fclk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usim_fck = {
+static struct clk __omap4_data usim_fck = {
 	.name		= "usim_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
@@ -2692,7 +2692,7 @@ static struct clk usim_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wd_timer2_fck = {
+static struct clk __omap4_data wd_timer2_fck = {
 	.name		= "wd_timer2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_WDT2_CLKCTRL,
@@ -2702,7 +2702,7 @@ static struct clk wd_timer2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wd_timer3_fck = {
+static struct clk __omap4_data wd_timer3_fck = {
 	.name		= "wd_timer3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_WDT3_CLKCTRL,
@@ -2718,7 +2718,7 @@ static const struct clksel stm_clk_div_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk stm_clk_div_ck = {
+static struct clk __omap4_data stm_clk_div_ck = {
 	.name		= "stm_clk_div_ck",
 	.parent		= &pmd_stm_clock_mux_ck,
 	.clksel		= stm_clk_div_div,
@@ -2735,7 +2735,7 @@ static const struct clksel trace_clk_div_div[] = {
 	{ .parent = NULL },
 };
 
-static struct clk trace_clk_div_ck = {
+static struct clk __omap4_data trace_clk_div_ck = {
 	.name		= "trace_clk_div_ck",
 	.parent		= &pmd_trace_clk_mux_ck,
 	.clksel		= trace_clk_div_div,
@@ -2751,7 +2751,7 @@ static struct clk trace_clk_div_ck = {
  * clkdev
  */
 
-static struct omap_clk omap44xx_clks[] = {
+static struct omap_clk __omap4_data omap44xx_clks[] = {
 	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck,	CK_443X),
 	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck,	CK_443X),
 	CLK(NULL,	"pad_slimbus_core_clks_ck",	&pad_slimbus_core_clks_ck,	CK_443X),
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 0d5c6eb..76fc0fe 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -35,18 +35,18 @@
 #define OMAP44XX_DMA_REQ_START  1
 
 /* Backward references (IPs with Bus Master capability) */
-static struct omap_hwmod omap44xx_dmm_hwmod;
-static struct omap_hwmod omap44xx_emif_fw_hwmod;
-static struct omap_hwmod omap44xx_l3_instr_hwmod;
-static struct omap_hwmod omap44xx_l3_main_1_hwmod;
-static struct omap_hwmod omap44xx_l3_main_2_hwmod;
-static struct omap_hwmod omap44xx_l3_main_3_hwmod;
-static struct omap_hwmod omap44xx_l4_abe_hwmod;
-static struct omap_hwmod omap44xx_l4_cfg_hwmod;
-static struct omap_hwmod omap44xx_l4_per_hwmod;
-static struct omap_hwmod omap44xx_l4_wkup_hwmod;
-static struct omap_hwmod omap44xx_mpu_hwmod;
-static struct omap_hwmod omap44xx_mpu_private_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_dmm_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_emif_fw_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_l3_instr_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_l3_main_1_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_l3_main_2_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_l3_main_3_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_l4_abe_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_l4_cfg_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_l4_per_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_l4_wkup_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_mpu_hwmod;
+static struct omap_hwmod __omap4_data omap44xx_mpu_private_hwmod;
 
 /*
  * Interconnects omap_hwmod structures
@@ -57,13 +57,13 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod;
  * 'dmm' class
  * instance(s): dmm
  */
-static struct omap_hwmod_class omap44xx_dmm_hwmod_class = {
+static struct omap_hwmod_class __omap4_data omap44xx_dmm_hwmod_class = {
 	.name = "dmm",
 };
 
 /* dmm interface data */
 /* l3_main_1 -> dmm */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_1__dmm = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l3_main_1__dmm = {
 	.master		= &omap44xx_l3_main_1_hwmod,
 	.slave		= &omap44xx_dmm_hwmod,
 	.clk		= "l3_div_ck",
@@ -71,7 +71,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__dmm = {
 };
 
 /* mpu -> dmm */
-static struct omap_hwmod_ocp_if omap44xx_mpu__dmm = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_mpu__dmm = {
 	.master		= &omap44xx_mpu_hwmod,
 	.slave		= &omap44xx_dmm_hwmod,
 	.clk		= "l3_div_ck",
@@ -79,16 +79,16 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__dmm = {
 };
 
 /* dmm slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_dmm_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_dmm_slaves[] = {
 	&omap44xx_l3_main_1__dmm,
 	&omap44xx_mpu__dmm,
 };
 
-static struct omap_hwmod_irq_info omap44xx_dmm_irqs[] = {
+static struct omap_hwmod_irq_info __omap4_data omap44xx_dmm_irqs[] = {
 	{ .irq = 113 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod omap44xx_dmm_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_dmm_hwmod = {
 	.name		= "dmm",
 	.class		= &omap44xx_dmm_hwmod_class,
 	.slaves		= omap44xx_dmm_slaves,
@@ -102,13 +102,13 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
  * 'emif_fw' class
  * instance(s): emif_fw
  */
-static struct omap_hwmod_class omap44xx_emif_fw_hwmod_class = {
+static struct omap_hwmod_class __omap4_data omap44xx_emif_fw_hwmod_class = {
 	.name = "emif_fw",
 };
 
 /* emif_fw interface data */
 /* dmm -> emif_fw */
-static struct omap_hwmod_ocp_if omap44xx_dmm__emif_fw = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_dmm__emif_fw = {
 	.master		= &omap44xx_dmm_hwmod,
 	.slave		= &omap44xx_emif_fw_hwmod,
 	.clk		= "l3_div_ck",
@@ -116,7 +116,7 @@ static struct omap_hwmod_ocp_if omap44xx_dmm__emif_fw = {
 };
 
 /* l4_cfg -> emif_fw */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__emif_fw = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_cfg__emif_fw = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_emif_fw_hwmod,
 	.clk		= "l4_div_ck",
@@ -124,12 +124,12 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__emif_fw = {
 };
 
 /* emif_fw slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_emif_fw_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_emif_fw_slaves[] = {
 	&omap44xx_dmm__emif_fw,
 	&omap44xx_l4_cfg__emif_fw,
 };
 
-static struct omap_hwmod omap44xx_emif_fw_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_emif_fw_hwmod = {
 	.name		= "emif_fw",
 	.class		= &omap44xx_emif_fw_hwmod_class,
 	.slaves		= omap44xx_emif_fw_slaves,
@@ -141,13 +141,13 @@ static struct omap_hwmod omap44xx_emif_fw_hwmod = {
  * 'l3' class
  * instance(s): l3_instr, l3_main_1, l3_main_2, l3_main_3
  */
-static struct omap_hwmod_class omap44xx_l3_hwmod_class = {
+static struct omap_hwmod_class __omap4_data omap44xx_l3_hwmod_class = {
 	.name = "l3",
 };
 
 /* l3_instr interface data */
 /* l3_main_3 -> l3_instr */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_3__l3_instr = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l3_main_3__l3_instr = {
 	.master		= &omap44xx_l3_main_3_hwmod,
 	.slave		= &omap44xx_l3_instr_hwmod,
 	.clk		= "l3_div_ck",
@@ -155,11 +155,11 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_3__l3_instr = {
 };
 
 /* l3_instr slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_l3_instr_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_l3_instr_slaves[] = {
 	&omap44xx_l3_main_3__l3_instr,
 };
 
-static struct omap_hwmod omap44xx_l3_instr_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_l3_instr_hwmod = {
 	.name		= "l3_instr",
 	.class		= &omap44xx_l3_hwmod_class,
 	.slaves		= omap44xx_l3_instr_slaves,
@@ -168,7 +168,7 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 };
 
 /* l3_main_2 -> l3_main_1 */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_2__l3_main_1 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l3_main_2__l3_main_1 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_l3_main_1_hwmod,
 	.clk		= "l3_div_ck",
@@ -176,7 +176,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__l3_main_1 = {
 };
 
 /* l4_cfg -> l3_main_1 */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_1 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_cfg__l3_main_1 = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_l3_main_1_hwmod,
 	.clk		= "l4_div_ck",
@@ -184,7 +184,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_1 = {
 };
 
 /* mpu -> l3_main_1 */
-static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_mpu__l3_main_1 = {
 	.master		= &omap44xx_mpu_hwmod,
 	.slave		= &omap44xx_l3_main_1_hwmod,
 	.clk		= "l3_div_ck",
@@ -192,13 +192,13 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
 };
 
 /* l3_main_1 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_l3_main_1_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_l3_main_1_slaves[] = {
 	&omap44xx_l3_main_2__l3_main_1,
 	&omap44xx_l4_cfg__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
 };
 
-static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_l3_main_1_hwmod = {
 	.name		= "l3_main_1",
 	.class		= &omap44xx_l3_hwmod_class,
 	.slaves		= omap44xx_l3_main_1_slaves,
@@ -208,7 +208,7 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 
 /* l3_main_2 interface data */
 /* l3_main_1 -> l3_main_2 */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l3_main_1__l3_main_2 = {
 	.master		= &omap44xx_l3_main_1_hwmod,
 	.slave		= &omap44xx_l3_main_2_hwmod,
 	.clk		= "l3_div_ck",
@@ -216,7 +216,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 = {
 };
 
 /* l4_cfg -> l3_main_2 */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_cfg__l3_main_2 = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_l3_main_2_hwmod,
 	.clk		= "l4_div_ck",
@@ -224,12 +224,12 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
 };
 
 /* l3_main_2 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_l3_main_2_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_l3_main_2_slaves[] = {
 	&omap44xx_l3_main_1__l3_main_2,
 	&omap44xx_l4_cfg__l3_main_2,
 };
 
-static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_l3_main_2_hwmod = {
 	.name		= "l3_main_2",
 	.class		= &omap44xx_l3_hwmod_class,
 	.slaves		= omap44xx_l3_main_2_slaves,
@@ -239,7 +239,7 @@ static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
 
 /* l3_main_3 interface data */
 /* l3_main_1 -> l3_main_3 */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_3 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l3_main_1__l3_main_3 = {
 	.master		= &omap44xx_l3_main_1_hwmod,
 	.slave		= &omap44xx_l3_main_3_hwmod,
 	.clk		= "l3_div_ck",
@@ -247,7 +247,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_3 = {
 };
 
 /* l3_main_2 -> l3_main_3 */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_2__l3_main_3 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l3_main_2__l3_main_3 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_l3_main_3_hwmod,
 	.clk		= "l3_div_ck",
@@ -255,7 +255,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__l3_main_3 = {
 };
 
 /* l4_cfg -> l3_main_3 */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_3 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_cfg__l3_main_3 = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_l3_main_3_hwmod,
 	.clk		= "l4_div_ck",
@@ -263,13 +263,13 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_3 = {
 };
 
 /* l3_main_3 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_l3_main_3_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_l3_main_3_slaves[] = {
 	&omap44xx_l3_main_1__l3_main_3,
 	&omap44xx_l3_main_2__l3_main_3,
 	&omap44xx_l4_cfg__l3_main_3,
 };
 
-static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_l3_main_3_hwmod = {
 	.name		= "l3_main_3",
 	.class		= &omap44xx_l3_hwmod_class,
 	.slaves		= omap44xx_l3_main_3_slaves,
@@ -281,13 +281,13 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
  * 'l4' class
  * instance(s): l4_abe, l4_cfg, l4_per, l4_wkup
  */
-static struct omap_hwmod_class omap44xx_l4_hwmod_class = {
+static struct omap_hwmod_class __omap4_data omap44xx_l4_hwmod_class = {
 	.name = "l4",
 };
 
 /* l4_abe interface data */
 /* l3_main_1 -> l4_abe */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l4_abe = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l3_main_1__l4_abe = {
 	.master		= &omap44xx_l3_main_1_hwmod,
 	.slave		= &omap44xx_l4_abe_hwmod,
 	.clk		= "l3_div_ck",
@@ -295,7 +295,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l4_abe = {
 };
 
 /* mpu -> l4_abe */
-static struct omap_hwmod_ocp_if omap44xx_mpu__l4_abe = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_mpu__l4_abe = {
 	.master		= &omap44xx_mpu_hwmod,
 	.slave		= &omap44xx_l4_abe_hwmod,
 	.clk		= "ocp_abe_iclk",
@@ -303,12 +303,12 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l4_abe = {
 };
 
 /* l4_abe slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_l4_abe_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_l4_abe_slaves[] = {
 	&omap44xx_l3_main_1__l4_abe,
 	&omap44xx_mpu__l4_abe,
 };
 
-static struct omap_hwmod omap44xx_l4_abe_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_l4_abe_hwmod = {
 	.name		= "l4_abe",
 	.class		= &omap44xx_l4_hwmod_class,
 	.slaves		= omap44xx_l4_abe_slaves,
@@ -318,7 +318,7 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 
 /* l4_cfg interface data */
 /* l3_main_1 -> l4_cfg */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l4_cfg = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l3_main_1__l4_cfg = {
 	.master		= &omap44xx_l3_main_1_hwmod,
 	.slave		= &omap44xx_l4_cfg_hwmod,
 	.clk		= "l3_div_ck",
@@ -326,11 +326,11 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l4_cfg = {
 };
 
 /* l4_cfg slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_l4_cfg_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_l4_cfg_slaves[] = {
 	&omap44xx_l3_main_1__l4_cfg,
 };
 
-static struct omap_hwmod omap44xx_l4_cfg_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_l4_cfg_hwmod = {
 	.name		= "l4_cfg",
 	.class		= &omap44xx_l4_hwmod_class,
 	.slaves		= omap44xx_l4_cfg_slaves,
@@ -340,7 +340,7 @@ static struct omap_hwmod omap44xx_l4_cfg_hwmod = {
 
 /* l4_per interface data */
 /* l3_main_2 -> l4_per */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_2__l4_per = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l3_main_2__l4_per = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_l4_per_hwmod,
 	.clk		= "l3_div_ck",
@@ -348,11 +348,11 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__l4_per = {
 };
 
 /* l4_per slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_l4_per_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_l4_per_slaves[] = {
 	&omap44xx_l3_main_2__l4_per,
 };
 
-static struct omap_hwmod omap44xx_l4_per_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_l4_per_hwmod = {
 	.name		= "l4_per",
 	.class		= &omap44xx_l4_hwmod_class,
 	.slaves		= omap44xx_l4_per_slaves,
@@ -362,7 +362,7 @@ static struct omap_hwmod omap44xx_l4_per_hwmod = {
 
 /* l4_wkup interface data */
 /* l4_cfg -> l4_wkup */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l4_wkup = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_cfg__l4_wkup = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_l4_wkup_hwmod,
 	.clk		= "l4_div_ck",
@@ -370,11 +370,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l4_wkup = {
 };
 
 /* l4_wkup slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_l4_wkup_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_l4_wkup_slaves[] = {
 	&omap44xx_l4_cfg__l4_wkup,
 };
 
-static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_l4_wkup_hwmod = {
 	.name		= "l4_wkup",
 	.class		= &omap44xx_l4_hwmod_class,
 	.slaves		= omap44xx_l4_wkup_slaves,
@@ -387,7 +387,7 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
  * multimaster high-speed i2c controller
  */
 
-static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
+static struct omap_hwmod_class_sysconfig __omap4_data omap44xx_i2c_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0090,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
@@ -397,23 +397,23 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
+static struct omap_hwmod_class __omap4_data omap44xx_i2c_hwmod_class = {
 	.name = "i2c",
 	.sysc = &omap44xx_i2c_sysc,
 };
 
 /* i2c1 */
-static struct omap_hwmod omap44xx_i2c1_hwmod;
-static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] = {
+static struct omap_hwmod __omap4_data omap44xx_i2c1_hwmod;
+static struct omap_hwmod_irq_info __omap4_data omap44xx_i2c1_irqs[] = {
 	{ .irq = 56 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_dma_info omap44xx_i2c1_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap4_data omap44xx_i2c1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 26 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 27 + OMAP44XX_DMA_REQ_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_i2c1_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_i2c1_addrs[] = {
 	{
 		.pa_start	= 0x48070000,
 		.pa_end		= 0x480700ff,
@@ -422,7 +422,7 @@ static struct omap_hwmod_addr_space omap44xx_i2c1_addrs[] = {
 };
 
 /* l4_per -> i2c1 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c1 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_per__i2c1 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_i2c1_hwmod,
 	.clk		= "l4_div_ck",
@@ -432,11 +432,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c1 = {
 };
 
 /* i2c1 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_i2c1_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_i2c1_slaves[] = {
 	&omap44xx_l4_per__i2c1,
 };
 
-static struct omap_hwmod omap44xx_i2c1_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.flags		= HWMOD_INIT_NO_RESET,
@@ -456,17 +456,17 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 };
 
 /* i2c2 */
-static struct omap_hwmod omap44xx_i2c2_hwmod;
-static struct omap_hwmod_irq_info omap44xx_i2c2_irqs[] = {
+static struct omap_hwmod __omap4_data omap44xx_i2c2_hwmod;
+static struct omap_hwmod_irq_info __omap4_data omap44xx_i2c2_irqs[] = {
 	{ .irq = 57 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_dma_info omap44xx_i2c2_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap4_data omap44xx_i2c2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 28 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 29 + OMAP44XX_DMA_REQ_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_i2c2_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_i2c2_addrs[] = {
 	{
 		.pa_start	= 0x48072000,
 		.pa_end		= 0x480720ff,
@@ -475,7 +475,7 @@ static struct omap_hwmod_addr_space omap44xx_i2c2_addrs[] = {
 };
 
 /* l4_per -> i2c2 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c2 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_per__i2c2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_i2c2_hwmod,
 	.clk		= "l4_div_ck",
@@ -485,11 +485,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c2 = {
 };
 
 /* i2c2 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_i2c2_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_i2c2_slaves[] = {
 	&omap44xx_l4_per__i2c2,
 };
 
-static struct omap_hwmod omap44xx_i2c2_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.flags		= HWMOD_INIT_NO_RESET,
@@ -509,17 +509,17 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 };
 
 /* i2c3 */
-static struct omap_hwmod omap44xx_i2c3_hwmod;
-static struct omap_hwmod_irq_info omap44xx_i2c3_irqs[] = {
+static struct omap_hwmod __omap4_data omap44xx_i2c3_hwmod;
+static struct omap_hwmod_irq_info __omap4_data omap44xx_i2c3_irqs[] = {
 	{ .irq = 61 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_dma_info omap44xx_i2c3_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap4_data omap44xx_i2c3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 24 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 25 + OMAP44XX_DMA_REQ_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_i2c3_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_i2c3_addrs[] = {
 	{
 		.pa_start	= 0x48060000,
 		.pa_end		= 0x480600ff,
@@ -528,7 +528,7 @@ static struct omap_hwmod_addr_space omap44xx_i2c3_addrs[] = {
 };
 
 /* l4_per -> i2c3 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c3 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_per__i2c3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_i2c3_hwmod,
 	.clk		= "l4_div_ck",
@@ -538,11 +538,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c3 = {
 };
 
 /* i2c3 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_i2c3_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_i2c3_slaves[] = {
 	&omap44xx_l4_per__i2c3,
 };
 
-static struct omap_hwmod omap44xx_i2c3_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.flags		= HWMOD_INIT_NO_RESET,
@@ -562,17 +562,17 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 };
 
 /* i2c4 */
-static struct omap_hwmod omap44xx_i2c4_hwmod;
-static struct omap_hwmod_irq_info omap44xx_i2c4_irqs[] = {
+static struct omap_hwmod __omap4_data omap44xx_i2c4_hwmod;
+static struct omap_hwmod_irq_info __omap4_data omap44xx_i2c4_irqs[] = {
 	{ .irq = 62 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_dma_info omap44xx_i2c4_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap4_data omap44xx_i2c4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 123 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 124 + OMAP44XX_DMA_REQ_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_i2c4_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_i2c4_addrs[] = {
 	{
 		.pa_start	= 0x48350000,
 		.pa_end		= 0x483500ff,
@@ -581,7 +581,7 @@ static struct omap_hwmod_addr_space omap44xx_i2c4_addrs[] = {
 };
 
 /* l4_per -> i2c4 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c4 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_per__i2c4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_i2c4_hwmod,
 	.clk		= "l4_div_ck",
@@ -591,11 +591,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c4 = {
 };
 
 /* i2c4 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_i2c4_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_i2c4_slaves[] = {
 	&omap44xx_l4_per__i2c4,
 };
 
-static struct omap_hwmod omap44xx_i2c4_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_i2c4_hwmod = {
 	.name		= "i2c4",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.flags		= HWMOD_INIT_NO_RESET,
@@ -618,13 +618,13 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
  * 'mpu_bus' class
  * instance(s): mpu_private
  */
-static struct omap_hwmod_class omap44xx_mpu_bus_hwmod_class = {
+static struct omap_hwmod_class __omap4_data omap44xx_mpu_bus_hwmod_class = {
 	.name = "mpu_bus",
 };
 
 /* mpu_private interface data */
 /* mpu -> mpu_private */
-static struct omap_hwmod_ocp_if omap44xx_mpu__mpu_private = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_mpu__mpu_private = {
 	.master		= &omap44xx_mpu_hwmod,
 	.slave		= &omap44xx_mpu_private_hwmod,
 	.clk		= "l3_div_ck",
@@ -632,11 +632,11 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__mpu_private = {
 };
 
 /* mpu_private slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_mpu_private_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_mpu_private_slaves[] = {
 	&omap44xx_mpu__mpu_private,
 };
 
-static struct omap_hwmod omap44xx_mpu_private_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_mpu_private_hwmod = {
 	.name		= "mpu_private",
 	.class		= &omap44xx_mpu_bus_hwmod_class,
 	.slaves		= omap44xx_mpu_private_slaves,
@@ -649,25 +649,25 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  * mpu sub-system
  */
 
-static struct omap_hwmod_class omap44xx_mpu_hwmod_class = {
+static struct omap_hwmod_class __omap4_data omap44xx_mpu_hwmod_class = {
 	.name = "mpu",
 };
 
 /* mpu */
-static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] = {
+static struct omap_hwmod_irq_info __omap4_data omap44xx_mpu_irqs[] = {
 	{ .name = "pl310", .irq = 0 + OMAP44XX_IRQ_GIC_START },
 	{ .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
 	{ .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
 };
 
 /* mpu master ports */
-static struct omap_hwmod_ocp_if *omap44xx_mpu_masters[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_mpu_masters[] = {
 	&omap44xx_mpu__l3_main_1,
 	&omap44xx_mpu__l4_abe,
 	&omap44xx_mpu__dmm,
 };
 
-static struct omap_hwmod omap44xx_mpu_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_mpu_hwmod = {
 	.name		= "mpu",
 	.class		= &omap44xx_mpu_hwmod_class,
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
@@ -690,7 +690,7 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
  * overflow condition
  */
 
-static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
+static struct omap_hwmod_class_sysconfig __omap4_data omap44xx_wd_timer_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
@@ -705,7 +705,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
  * universal asynchronous receiver/transmitter (uart)
  */
 
-static struct omap_hwmod_class_sysconfig omap44xx_uart_sysc = {
+static struct omap_hwmod_class_sysconfig __omap4_data omap44xx_uart_sysc = {
 	.rev_offs	= 0x0050,
 	.sysc_offs	= 0x0054,
 	.syss_offs	= 0x0058,
@@ -715,18 +715,18 @@ static struct omap_hwmod_class_sysconfig omap44xx_uart_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
+static struct omap_hwmod_class __omap4_data omap44xx_wd_timer_hwmod_class = {
 	.name = "wd_timer",
 	.sysc = &omap44xx_wd_timer_sysc,
 };
 
 /* wd_timer2 */
-static struct omap_hwmod omap44xx_wd_timer2_hwmod;
-static struct omap_hwmod_irq_info omap44xx_wd_timer2_irqs[] = {
+static struct omap_hwmod __omap4_data omap44xx_wd_timer2_hwmod;
+static struct omap_hwmod_irq_info __omap4_data omap44xx_wd_timer2_irqs[] = {
 	{ .irq = 80 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_wd_timer2_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_wd_timer2_addrs[] = {
 	{
 		.pa_start	= 0x4a314000,
 		.pa_end		= 0x4a31407f,
@@ -734,23 +734,23 @@ static struct omap_hwmod_addr_space omap44xx_wd_timer2_addrs[] = {
 	},
 };
 
-static struct omap_hwmod_class omap44xx_uart_hwmod_class = {
+static struct omap_hwmod_class __omap4_data omap44xx_uart_hwmod_class = {
 	.name = "uart",
 	.sysc = &omap44xx_uart_sysc,
 };
 
 /* uart1 */
-static struct omap_hwmod omap44xx_uart1_hwmod;
-static struct omap_hwmod_irq_info omap44xx_uart1_irqs[] = {
+static struct omap_hwmod __omap4_data omap44xx_uart1_hwmod;
+static struct omap_hwmod_irq_info __omap4_data omap44xx_uart1_irqs[] = {
 	{ .irq = 72 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_dma_info omap44xx_uart1_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap4_data omap44xx_uart1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 48 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 49 + OMAP44XX_DMA_REQ_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_uart1_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_uart1_addrs[] = {
 	{
 		.pa_start	= 0x4806a000,
 		.pa_end		= 0x4806a0ff,
@@ -759,7 +759,7 @@ static struct omap_hwmod_addr_space omap44xx_uart1_addrs[] = {
 };
 
 /* l4_per -> uart1 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__uart1 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_per__uart1 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_uart1_hwmod,
 	.clk		= "l4_div_ck",
@@ -769,11 +769,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__uart1 = {
 };
 
 /* uart1 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_uart1_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_uart1_slaves[] = {
 	&omap44xx_l4_per__uart1,
 };
 
-static struct omap_hwmod omap44xx_uart1_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &omap44xx_uart_hwmod_class,
 	.mpu_irqs	= omap44xx_uart1_irqs,
@@ -792,17 +792,17 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 };
 
 /* uart2 */
-static struct omap_hwmod omap44xx_uart2_hwmod;
-static struct omap_hwmod_irq_info omap44xx_uart2_irqs[] = {
+static struct omap_hwmod __omap4_data omap44xx_uart2_hwmod;
+static struct omap_hwmod_irq_info __omap4_data omap44xx_uart2_irqs[] = {
 	{ .irq = 73 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_dma_info omap44xx_uart2_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap4_data omap44xx_uart2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 50 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 51 + OMAP44XX_DMA_REQ_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_uart2_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_uart2_addrs[] = {
 	{
 		.pa_start	= 0x4806c000,
 		.pa_end		= 0x4806c0ff,
@@ -811,7 +811,7 @@ static struct omap_hwmod_addr_space omap44xx_uart2_addrs[] = {
 };
 
 /* l4_wkup -> wd_timer2 */
-static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_wkup__wd_timer2 = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_wd_timer2_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
@@ -821,11 +821,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 = {
 };
 
 /* wd_timer2 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_wd_timer2_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_wd_timer2_slaves[] = {
 	&omap44xx_l4_wkup__wd_timer2,
 };
 
-static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_wd_timer2_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &omap44xx_wd_timer_hwmod_class,
 	.mpu_irqs	= omap44xx_wd_timer2_irqs,
@@ -842,12 +842,12 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 };
 
 /* wd_timer3 */
-static struct omap_hwmod omap44xx_wd_timer3_hwmod;
-static struct omap_hwmod_irq_info omap44xx_wd_timer3_irqs[] = {
+static struct omap_hwmod __omap4_data omap44xx_wd_timer3_hwmod;
+static struct omap_hwmod_irq_info __omap4_data omap44xx_wd_timer3_irqs[] = {
 	{ .irq = 36 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_wd_timer3_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_wd_timer3_addrs[] = {
 	{
 		.pa_start	= 0x40130000,
 		.pa_end		= 0x4013007f,
@@ -856,7 +856,7 @@ static struct omap_hwmod_addr_space omap44xx_wd_timer3_addrs[] = {
 };
 
 /* l4_per -> uart2 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__uart2 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_per__uart2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_uart2_hwmod,
 	.clk		= "l4_div_ck",
@@ -866,11 +866,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__uart2 = {
 };
 
 /* uart2 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_uart2_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_uart2_slaves[] = {
 	&omap44xx_l4_per__uart2,
 };
 
-static struct omap_hwmod omap44xx_uart2_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &omap44xx_uart_hwmod_class,
 	.mpu_irqs	= omap44xx_uart2_irqs,
@@ -889,17 +889,17 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 };
 
 /* uart3 */
-static struct omap_hwmod omap44xx_uart3_hwmod;
-static struct omap_hwmod_irq_info omap44xx_uart3_irqs[] = {
+static struct omap_hwmod __omap4_data omap44xx_uart3_hwmod;
+static struct omap_hwmod_irq_info __omap4_data omap44xx_uart3_irqs[] = {
 	{ .irq = 74 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_dma_info omap44xx_uart3_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap4_data omap44xx_uart3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 52 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 53 + OMAP44XX_DMA_REQ_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_uart3_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_uart3_addrs[] = {
 	{
 		.pa_start	= 0x48020000,
 		.pa_end		= 0x480200ff,
@@ -908,7 +908,7 @@ static struct omap_hwmod_addr_space omap44xx_uart3_addrs[] = {
 };
 
 /* l4_abe -> wd_timer3 */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_abe__wd_timer3 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_wd_timer3_hwmod,
 	.clk		= "ocp_abe_iclk",
@@ -918,7 +918,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3 = {
 };
 
 /* l4_abe -> wd_timer3 (dma) */
-static struct omap_hwmod_addr_space omap44xx_wd_timer3_dma_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_wd_timer3_dma_addrs[] = {
 	{
 		.pa_start	= 0x49030000,
 		.pa_end		= 0x4903007f,
@@ -927,7 +927,7 @@ static struct omap_hwmod_addr_space omap44xx_wd_timer3_dma_addrs[] = {
 };
 
 /* l4_per -> uart3 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__uart3 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_per__uart3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_uart3_hwmod,
 	.clk		= "l4_div_ck",
@@ -937,11 +937,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__uart3 = {
 };
 
 /* uart3 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_uart3_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_uart3_slaves[] = {
 	&omap44xx_l4_per__uart3,
 };
 
-static struct omap_hwmod omap44xx_uart3_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &omap44xx_uart_hwmod_class,
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
@@ -961,17 +961,17 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 };
 
 /* uart4 */
-static struct omap_hwmod omap44xx_uart4_hwmod;
-static struct omap_hwmod_irq_info omap44xx_uart4_irqs[] = {
+static struct omap_hwmod __omap4_data omap44xx_uart4_hwmod;
+static struct omap_hwmod_irq_info __omap4_data omap44xx_uart4_irqs[] = {
 	{ .irq = 70 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_dma_info omap44xx_uart4_sdma_reqs[] = {
+static struct omap_hwmod_dma_info __omap4_data omap44xx_uart4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 54 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 55 + OMAP44XX_DMA_REQ_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_uart4_addrs[] = {
+static struct omap_hwmod_addr_space __omap4_data omap44xx_uart4_addrs[] = {
 	{
 		.pa_start	= 0x4806e000,
 		.pa_end		= 0x4806e0ff,
@@ -979,7 +979,7 @@ static struct omap_hwmod_addr_space omap44xx_uart4_addrs[] = {
 	},
 };
 
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3_dma = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_abe__wd_timer3_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_wd_timer3_hwmod,
 	.clk		= "ocp_abe_iclk",
@@ -989,12 +989,12 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3_dma = {
 };
 
 /* wd_timer3 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_wd_timer3_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_wd_timer3_slaves[] = {
 	&omap44xx_l4_abe__wd_timer3,
 	&omap44xx_l4_abe__wd_timer3_dma,
 };
 
-static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_wd_timer3_hwmod = {
 	.name		= "wd_timer3",
 	.class		= &omap44xx_wd_timer_hwmod_class,
 	.mpu_irqs	= omap44xx_wd_timer3_irqs,
@@ -1011,7 +1011,7 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 };
 
 /* l4_per -> uart4 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__uart4 = {
+static struct omap_hwmod_ocp_if __omap4_data omap44xx_l4_per__uart4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_uart4_hwmod,
 	.clk		= "l4_div_ck",
@@ -1021,11 +1021,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__uart4 = {
 };
 
 /* uart4 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_uart4_slaves[] = {
+static struct omap_hwmod_ocp_if __omap4_data *omap44xx_uart4_slaves[] = {
 	&omap44xx_l4_per__uart4,
 };
 
-static struct omap_hwmod omap44xx_uart4_hwmod = {
+static struct omap_hwmod __omap4_data omap44xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &omap44xx_uart_hwmod_class,
 	.mpu_irqs	= omap44xx_uart4_irqs,
-- 
1.7.0.4

