From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 5/8] CLK: OMAP4: modify clock data layout for the new driver format
Date: Thu, 21 Mar 2013 19:35:44 +0200
Message-ID: <1363887347-4686-6-git-send-email-t-kristo@ti.com>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44977 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3CURg4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Mar 2013 13:36:56 -0400
In-Reply-To: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, khilman@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

New OMAP clock driver registration is done somewhat differently
compared to what was done previously, this patch incorporates
the changes needed by the new driver to the data. This step is
mostly scripted.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/omap/cclock44xx_data.c |  752 ++++++++++++++++--------------------
 1 files changed, 343 insertions(+), 409 deletions(-)

diff --git a/drivers/clk/omap/cclock44xx_data.c b/drivers/clk/omap/cclock44xx_data.c
index a2cc046..25285a3 100644
--- a/drivers/clk/omap/cclock44xx_data.c
+++ b/drivers/clk/omap/cclock44xx_data.c
@@ -50,39 +50,39 @@
 
 /* Root clocks */
 
-DEFINE_CLK_FIXED_RATE(extalt_clkin_ck, CLK_IS_ROOT, 59000000, 0x0);
+OMAP_CLK_FIXED_RATE(extalt_clkin_ck, CLK_IS_ROOT, 59000000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(pad_clks_src_ck, CLK_IS_ROOT, 12000000, 0x0);
+OMAP_CLK_FIXED_RATE(pad_clks_src_ck, CLK_IS_ROOT, 12000000, 0x0);
 
-DEFINE_CLK_GATE(pad_clks_ck, "pad_clks_src_ck", &pad_clks_src_ck, 0x0,
+OMAP_CLK_GATE(pad_clks_ck, "pad_clks_src_ck", &pad_clks_src_ck, 0x0,
 		OMAP4430_CM_CLKSEL_ABE, OMAP4430_PAD_CLKS_GATE_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_FIXED_RATE(pad_slimbus_core_clks_ck, CLK_IS_ROOT, 12000000, 0x0);
+OMAP_CLK_FIXED_RATE(pad_slimbus_core_clks_ck, CLK_IS_ROOT, 12000000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(secure_32k_clk_src_ck, CLK_IS_ROOT, 32768, 0x0);
+OMAP_CLK_FIXED_RATE(secure_32k_clk_src_ck, CLK_IS_ROOT, 32768, 0x0);
 
-DEFINE_CLK_FIXED_RATE(slimbus_src_clk, CLK_IS_ROOT, 12000000, 0x0);
+OMAP_CLK_FIXED_RATE(slimbus_src_clk, CLK_IS_ROOT, 12000000, 0x0);
 
-DEFINE_CLK_GATE(slimbus_clk, "slimbus_src_clk", &slimbus_src_clk, 0x0,
+OMAP_CLK_GATE(slimbus_clk, "slimbus_src_clk", &slimbus_src_clk, 0x0,
 		OMAP4430_CM_CLKSEL_ABE, OMAP4430_SLIMBUS_CLK_GATE_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_FIXED_RATE(sys_32k_ck, CLK_IS_ROOT, 32768, 0x0);
+OMAP_CLK_FIXED_RATE(sys_32k_ck, CLK_IS_ROOT, 32768, 0x0);
 
-DEFINE_CLK_FIXED_RATE(virt_12000000_ck, CLK_IS_ROOT, 12000000, 0x0);
+OMAP_CLK_FIXED_RATE(virt_12000000_ck, CLK_IS_ROOT, 12000000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(virt_13000000_ck, CLK_IS_ROOT, 13000000, 0x0);
+OMAP_CLK_FIXED_RATE(virt_13000000_ck, CLK_IS_ROOT, 13000000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(virt_16800000_ck, CLK_IS_ROOT, 16800000, 0x0);
+OMAP_CLK_FIXED_RATE(virt_16800000_ck, CLK_IS_ROOT, 16800000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(virt_19200000_ck, CLK_IS_ROOT, 19200000, 0x0);
+OMAP_CLK_FIXED_RATE(virt_19200000_ck, CLK_IS_ROOT, 19200000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(virt_26000000_ck, CLK_IS_ROOT, 26000000, 0x0);
+OMAP_CLK_FIXED_RATE(virt_26000000_ck, CLK_IS_ROOT, 26000000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(virt_27000000_ck, CLK_IS_ROOT, 27000000, 0x0);
+OMAP_CLK_FIXED_RATE(virt_27000000_ck, CLK_IS_ROOT, 27000000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(virt_38400000_ck, CLK_IS_ROOT, 38400000, 0x0);
+OMAP_CLK_FIXED_RATE(virt_38400000_ck, CLK_IS_ROOT, 38400000, 0x0);
 
 static const char *sys_clkin_ck_parents[] = {
 	"virt_12000000_ck", "virt_13000000_ck", "virt_16800000_ck",
@@ -90,19 +90,19 @@ static const char *sys_clkin_ck_parents[] = {
 	"virt_38400000_ck",
 };
 
-DEFINE_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, NULL, 0x0,
 	       OMAP4430_CM_SYS_CLKSEL, OMAP4430_SYS_CLKSEL_SHIFT,
 	       OMAP4430_SYS_CLKSEL_WIDTH, CLK_MUX_INDEX_ONE, NULL);
 
-DEFINE_CLK_FIXED_RATE(tie_low_clock_ck, CLK_IS_ROOT, 0, 0x0);
+OMAP_CLK_FIXED_RATE(tie_low_clock_ck, CLK_IS_ROOT, 0, 0x0);
 
-DEFINE_CLK_FIXED_RATE(utmi_phy_clkout_ck, CLK_IS_ROOT, 60000000, 0x0);
+OMAP_CLK_FIXED_RATE(utmi_phy_clkout_ck, CLK_IS_ROOT, 60000000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(xclk60mhsp1_ck, CLK_IS_ROOT, 60000000, 0x0);
+OMAP_CLK_FIXED_RATE(xclk60mhsp1_ck, CLK_IS_ROOT, 60000000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(xclk60mhsp2_ck, CLK_IS_ROOT, 60000000, 0x0);
+OMAP_CLK_FIXED_RATE(xclk60mhsp2_ck, CLK_IS_ROOT, 60000000, 0x0);
 
-DEFINE_CLK_FIXED_RATE(xclk60motg_ck, CLK_IS_ROOT, 60000000, 0x0);
+OMAP_CLK_FIXED_RATE(xclk60motg_ck, CLK_IS_ROOT, 60000000, 0x0);
 
 /* Module clocks and DPLL outputs */
 
@@ -110,23 +110,23 @@ static const char *abe_dpll_bypass_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "sys_32k_ck",
 };
 
-DEFINE_CLK_MUX(abe_dpll_bypass_clk_mux_ck, abe_dpll_bypass_clk_mux_ck_parents,
+OMAP_CLK_MUX(abe_dpll_bypass_clk_mux_ck, abe_dpll_bypass_clk_mux_ck_parents,
 	       NULL, 0x0, OMAP4430_CM_L4_WKUP_CLKSEL, OMAP4430_CLKSEL_SHIFT,
 	       OMAP4430_CLKSEL_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_MUX(abe_dpll_refclk_mux_ck, abe_dpll_bypass_clk_mux_ck_parents, NULL,
+OMAP_CLK_MUX(abe_dpll_refclk_mux_ck, abe_dpll_bypass_clk_mux_ck_parents, NULL,
 	       0x0, OMAP4430_CM_ABE_PLL_REF_CLKSEL, OMAP4430_CLKSEL_0_0_SHIFT,
 	       OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
 /* DPLL_ABE */
-static struct dpll_data dpll_abe_dd = {
-	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_ABE,
-	.clk_bypass	= &abe_dpll_bypass_clk_mux_ck,
-	.clk_ref	= &abe_dpll_refclk_mux_ck,
-	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_ABE,
+static struct dpll_data dpll_abe_dd __initdata = {
+	.mult_div1_reg	= { .reginfo = { OMAP4430_CM_CLKSEL_DPLL_ABE } },
+	.clk_bypass	= { .name = "abe_dpll_bypass_clk_mux_ck" },
+	.clk_ref	= { .name = "abe_dpll_refclk_mux_ck" },
+	.control_reg	= { .reginfo = { OMAP4430_CM_CLKMODE_DPLL_ABE } },
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
-	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_ABE,
-	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_ABE,
+	.autoidle_reg	= { .reginfo = { OMAP4430_CM_AUTOIDLE_DPLL_ABE } },
+	.idlest_reg	= { .reginfo = { OMAP4430_CM_IDLEST_DPLL_ABE } },
 	.mult_mask	= OMAP4430_DPLL_MULT_MASK,
 	.div1_mask	= OMAP4430_DPLL_DIV_MASK,
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
@@ -144,7 +144,6 @@ static const char *dpll_abe_ck_parents[] = {
 	"abe_dpll_refclk_mux_ck",
 };
 
-static struct clk dpll_abe_ck;
 
 static const struct clk_ops dpll_abe_ck_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
@@ -155,36 +154,29 @@ static const struct clk_ops dpll_abe_ck_ops = {
 	.get_parent	= &omap2_init_dpll_parent,
 };
 
-static struct clk_hw_omap dpll_abe_ck_hw = {
-	.hw = {
-		.clk = &dpll_abe_ck,
-	},
+static struct clk_hw_omap dpll_abe_ck_hw __initdata = {
 	.dpll_data	= &dpll_abe_dd,
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_abe_ck, dpll_abe_ck_parents, dpll_abe_ck_ops);
+OMAP_CLK(dpll_abe_ck, dpll_abe_ck_parents, dpll_abe_ck_ops);
 
 static const char *dpll_abe_x2_ck_parents[] = {
 	"dpll_abe_ck",
 };
 
-static struct clk dpll_abe_x2_ck;
 
 static const struct clk_ops dpll_abe_x2_ck_ops = {
 	.recalc_rate	= &omap3_clkoutx2_recalc,
 };
 
-static struct clk_hw_omap dpll_abe_x2_ck_hw = {
-	.hw = {
-		.clk = &dpll_abe_x2_ck,
-	},
+static struct clk_hw_omap dpll_abe_x2_ck_hw __initdata = {
 	.flags		= CLOCK_CLKOUTX2,
-	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
+	.clksel_reg	= { .reginfo = { OMAP4430_CM_DIV_M2_DPLL_ABE } },
 	.ops		= &clkhwops_omap4_dpllmx,
 };
 
-DEFINE_STRUCT_CLK(dpll_abe_x2_ck, dpll_abe_x2_ck_parents, dpll_abe_x2_ck_ops);
+OMAP_CLK(dpll_abe_x2_ck, dpll_abe_x2_ck_parents, dpll_abe_x2_ck_ops);
 
 static const struct clk_ops omap_hsdivider_ops = {
 	.set_rate	= &omap2_clksel_set_rate,
@@ -196,14 +188,14 @@ DEFINE_CLK_OMAP_HSDIVIDER(dpll_abe_m2x2_ck, "dpll_abe_x2_ck", &dpll_abe_x2_ck,
 			  0x0, OMAP4430_CM_DIV_M2_DPLL_ABE,
 			  OMAP4430_DPLL_CLKOUT_DIV_MASK);
 
-DEFINE_CLK_FIXED_FACTOR(abe_24m_fclk, "dpll_abe_m2x2_ck", &dpll_abe_m2x2_ck,
+OMAP_CLK_FIXED_FACTOR(abe_24m_fclk, "dpll_abe_m2x2_ck", &dpll_abe_m2x2_ck,
 			0x0, 1, 8);
 
-DEFINE_CLK_DIVIDER(abe_clk, "dpll_abe_m2x2_ck", &dpll_abe_m2x2_ck, 0x0,
+OMAP_CLK_DIVIDER(abe_clk, "dpll_abe_m2x2_ck", &dpll_abe_m2x2_ck, 0x0,
 		   OMAP4430_CM_CLKSEL_ABE, OMAP4430_CLKSEL_OPP_SHIFT,
 		   OMAP4430_CLKSEL_OPP_WIDTH, CLK_DIVIDER_POWER_OF_TWO, NULL);
 
-DEFINE_CLK_DIVIDER(aess_fclk, "abe_clk", &abe_clk, 0x0,
+OMAP_CLK_DIVIDER(aess_fclk, "abe_clk", &abe_clk, 0x0,
 		   OMAP4430_CM1_ABE_AESS_CLKCTRL,
 		   OMAP4430_CLKSEL_AESS_FCLK_SHIFT,
 		   OMAP4430_CLKSEL_AESS_FCLK_WIDTH,
@@ -217,20 +209,20 @@ static const char *core_hsd_byp_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "dpll_abe_m3x2_ck",
 };
 
-DEFINE_CLK_MUX(core_hsd_byp_clk_mux_ck, core_hsd_byp_clk_mux_ck_parents, NULL,
+OMAP_CLK_MUX(core_hsd_byp_clk_mux_ck, core_hsd_byp_clk_mux_ck_parents, NULL,
 	       0x0, OMAP4430_CM_CLKSEL_DPLL_CORE,
 	       OMAP4430_DPLL_BYP_CLKSEL_SHIFT, OMAP4430_DPLL_BYP_CLKSEL_WIDTH,
 	       0x0, NULL);
 
 /* DPLL_CORE */
-static struct dpll_data dpll_core_dd = {
-	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_CORE,
-	.clk_bypass	= &core_hsd_byp_clk_mux_ck,
-	.clk_ref	= &sys_clkin_ck,
-	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_CORE,
+static struct dpll_data dpll_core_dd __initdata = {
+	.mult_div1_reg	= { .reginfo = { OMAP4430_CM_CLKSEL_DPLL_CORE } },
+	.clk_bypass	= { .name = "core_hsd_byp_clk_mux_ck" },
+	.clk_ref	= { .name = "sys_clkin_ck" },
+	.control_reg	= { .reginfo = { OMAP4430_CM_CLKMODE_DPLL_CORE } },
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
-	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_CORE,
-	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_CORE,
+	.autoidle_reg	= { .reginfo = { OMAP4430_CM_AUTOIDLE_DPLL_CORE } },
+	.idlest_reg	= { .reginfo = { OMAP4430_CM_IDLEST_DPLL_CORE } },
 	.mult_mask	= OMAP4430_DPLL_MULT_MASK,
 	.div1_mask	= OMAP4430_DPLL_DIV_MASK,
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
@@ -246,36 +238,28 @@ static const char *dpll_core_ck_parents[] = {
 	"sys_clkin_ck", "core_hsd_byp_clk_mux_ck"
 };
 
-static struct clk dpll_core_ck;
 
 static const struct clk_ops dpll_core_ck_ops = {
 	.recalc_rate	= &omap3_dpll_recalc,
 	.get_parent	= &omap2_init_dpll_parent,
 };
 
-static struct clk_hw_omap dpll_core_ck_hw = {
-	.hw = {
-		.clk = &dpll_core_ck,
-	},
+static struct clk_hw_omap dpll_core_ck_hw __initdata = {
 	.dpll_data	= &dpll_core_dd,
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_core_ck, dpll_core_ck_parents, dpll_core_ck_ops);
+OMAP_CLK(dpll_core_ck, dpll_core_ck_parents, dpll_core_ck_ops);
 
 static const char *dpll_core_x2_ck_parents[] = {
 	"dpll_core_ck",
 };
 
-static struct clk dpll_core_x2_ck;
 
-static struct clk_hw_omap dpll_core_x2_ck_hw = {
-	.hw = {
-		.clk = &dpll_core_x2_ck,
-	},
+static struct clk_hw_omap dpll_core_x2_ck_hw __initdata = {
 };
 
-DEFINE_STRUCT_CLK(dpll_core_x2_ck, dpll_core_x2_ck_parents, dpll_abe_x2_ck_ops);
+OMAP_CLK(dpll_core_x2_ck, dpll_core_x2_ck_parents, dpll_abe_x2_ck_ops);
 
 DEFINE_CLK_OMAP_HSDIVIDER(dpll_core_m6x2_ck, "dpll_core_x2_ck",
 			  &dpll_core_x2_ck, 0x0, OMAP4430_CM_DIV_M6_DPLL_CORE,
@@ -285,22 +269,22 @@ DEFINE_CLK_OMAP_HSDIVIDER(dpll_core_m2_ck, "dpll_core_ck", &dpll_core_ck, 0x0,
 			  OMAP4430_CM_DIV_M2_DPLL_CORE,
 			  OMAP4430_DPLL_CLKOUT_DIV_MASK);
 
-DEFINE_CLK_FIXED_FACTOR(ddrphy_ck, "dpll_core_m2_ck", &dpll_core_m2_ck, 0x0, 1,
+OMAP_CLK_FIXED_FACTOR(ddrphy_ck, "dpll_core_m2_ck", &dpll_core_m2_ck, 0x0, 1,
 			2);
 
 DEFINE_CLK_OMAP_HSDIVIDER(dpll_core_m5x2_ck, "dpll_core_x2_ck",
 			  &dpll_core_x2_ck, 0x0, OMAP4430_CM_DIV_M5_DPLL_CORE,
 			  OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK);
 
-DEFINE_CLK_DIVIDER(div_core_ck, "dpll_core_m5x2_ck", &dpll_core_m5x2_ck, 0x0,
+OMAP_CLK_DIVIDER(div_core_ck, "dpll_core_m5x2_ck", &dpll_core_m5x2_ck, 0x0,
 		   OMAP4430_CM_CLKSEL_CORE, OMAP4430_CLKSEL_CORE_SHIFT,
 		   OMAP4430_CLKSEL_CORE_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_DIVIDER(div_iva_hs_clk, "dpll_core_m5x2_ck", &dpll_core_m5x2_ck,
+OMAP_CLK_DIVIDER(div_iva_hs_clk, "dpll_core_m5x2_ck", &dpll_core_m5x2_ck,
 		   0x0, OMAP4430_CM_BYPCLK_DPLL_IVA, OMAP4430_CLKSEL_0_1_SHIFT,
 		   OMAP4430_CLKSEL_0_1_WIDTH, CLK_DIVIDER_POWER_OF_TWO, NULL);
 
-DEFINE_CLK_DIVIDER(div_mpu_hs_clk, "dpll_core_m5x2_ck", &dpll_core_m5x2_ck,
+OMAP_CLK_DIVIDER(div_mpu_hs_clk, "dpll_core_m5x2_ck", &dpll_core_m5x2_ck,
 		   0x0, OMAP4430_CM_BYPCLK_DPLL_MPU, OMAP4430_CLKSEL_0_1_SHIFT,
 		   OMAP4430_CLKSEL_0_1_WIDTH, CLK_DIVIDER_POWER_OF_TWO, NULL);
 
@@ -308,10 +292,10 @@ DEFINE_CLK_OMAP_HSDIVIDER(dpll_core_m4x2_ck, "dpll_core_x2_ck",
 			  &dpll_core_x2_ck, 0x0, OMAP4430_CM_DIV_M4_DPLL_CORE,
 			  OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK);
 
-DEFINE_CLK_FIXED_FACTOR(dll_clk_div_ck, "dpll_core_m4x2_ck", &dpll_core_m4x2_ck,
+OMAP_CLK_FIXED_FACTOR(dll_clk_div_ck, "dpll_core_m4x2_ck", &dpll_core_m4x2_ck,
 			0x0, 1, 2);
 
-DEFINE_CLK_DIVIDER(dpll_abe_m2_ck, "dpll_abe_ck", &dpll_abe_ck, 0x0,
+OMAP_CLK_DIVIDER(dpll_abe_m2_ck, "dpll_abe_ck", &dpll_abe_ck, 0x0,
 		   OMAP4430_CM_DIV_M2_DPLL_ABE, OMAP4430_DPLL_CLKOUT_DIV_SHIFT,
 		   OMAP4430_DPLL_CLKOUT_DIV_WIDTH, CLK_DIVIDER_ONE_BASED, NULL);
 
@@ -329,9 +313,9 @@ static const char *dpll_core_m3x2_ck_parents[] = {
 	"dpll_core_x2_ck",
 };
 
-static const struct clksel dpll_core_m3x2_div[] = {
-	{ .parent = &dpll_core_x2_ck, .rates = div31_1to31_rates },
-	{ .parent = NULL },
+static struct clksel_init dpll_core_m3x2_div[] __initdata = {
+	{ .parent_name = "dpll_core_x2_ck", .rates = div31_1to31_rates },
+	{ .parent_name = NULL },
 };
 
 /* XXX Missing round_rate, set_rate in ops */
@@ -350,19 +334,19 @@ static const char *iva_hsd_byp_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "div_iva_hs_clk",
 };
 
-DEFINE_CLK_MUX(iva_hsd_byp_clk_mux_ck, iva_hsd_byp_clk_mux_ck_parents, NULL,
+OMAP_CLK_MUX(iva_hsd_byp_clk_mux_ck, iva_hsd_byp_clk_mux_ck_parents, NULL,
 	       0x0, OMAP4430_CM_CLKSEL_DPLL_IVA, OMAP4430_DPLL_BYP_CLKSEL_SHIFT,
 	       OMAP4430_DPLL_BYP_CLKSEL_WIDTH, 0x0, NULL);
 
 /* DPLL_IVA */
-static struct dpll_data dpll_iva_dd = {
-	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_IVA,
-	.clk_bypass	= &iva_hsd_byp_clk_mux_ck,
-	.clk_ref	= &sys_clkin_ck,
-	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_IVA,
+static struct dpll_data dpll_iva_dd __initdata = {
+	.mult_div1_reg	= { .reginfo = { OMAP4430_CM_CLKSEL_DPLL_IVA } },
+	.clk_bypass	= { .name = "iva_hsd_byp_clk_mux_ck" },
+	.clk_ref	= { .name = "sys_clkin_ck" },
+	.control_reg	= { .reginfo = { OMAP4430_CM_CLKMODE_DPLL_IVA } },
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
-	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_IVA,
-	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_IVA,
+	.autoidle_reg	= { .reginfo = { OMAP4430_CM_AUTOIDLE_DPLL_IVA } },
+	.idlest_reg	= { .reginfo = { OMAP4430_CM_IDLEST_DPLL_IVA } },
 	.mult_mask	= OMAP4430_DPLL_MULT_MASK,
 	.div1_mask	= OMAP4430_DPLL_DIV_MASK,
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
@@ -377,7 +361,6 @@ static const char *dpll_iva_ck_parents[] = {
 	"sys_clkin_ck", "iva_hsd_byp_clk_mux_ck"
 };
 
-static struct clk dpll_iva_ck;
 
 static const struct clk_ops dpll_ck_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
@@ -388,29 +371,22 @@ static const struct clk_ops dpll_ck_ops = {
 	.get_parent	= &omap2_init_dpll_parent,
 };
 
-static struct clk_hw_omap dpll_iva_ck_hw = {
-	.hw = {
-		.clk = &dpll_iva_ck,
-	},
+static struct clk_hw_omap dpll_iva_ck_hw __initdata = {
 	.dpll_data	= &dpll_iva_dd,
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_iva_ck, dpll_iva_ck_parents, dpll_ck_ops);
+OMAP_CLK(dpll_iva_ck, dpll_iva_ck_parents, dpll_ck_ops);
 
 static const char *dpll_iva_x2_ck_parents[] = {
 	"dpll_iva_ck",
 };
 
-static struct clk dpll_iva_x2_ck;
 
-static struct clk_hw_omap dpll_iva_x2_ck_hw = {
-	.hw = {
-		.clk = &dpll_iva_x2_ck,
-	},
+static struct clk_hw_omap dpll_iva_x2_ck_hw __initdata = {
 };
 
-DEFINE_STRUCT_CLK(dpll_iva_x2_ck, dpll_iva_x2_ck_parents, dpll_abe_x2_ck_ops);
+OMAP_CLK(dpll_iva_x2_ck, dpll_iva_x2_ck_parents, dpll_abe_x2_ck_ops);
 
 DEFINE_CLK_OMAP_HSDIVIDER(dpll_iva_m4x2_ck, "dpll_iva_x2_ck", &dpll_iva_x2_ck,
 			  0x0, OMAP4430_CM_DIV_M4_DPLL_IVA,
@@ -421,14 +397,14 @@ DEFINE_CLK_OMAP_HSDIVIDER(dpll_iva_m5x2_ck, "dpll_iva_x2_ck", &dpll_iva_x2_ck,
 			  OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK);
 
 /* DPLL_MPU */
-static struct dpll_data dpll_mpu_dd = {
-	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_MPU,
-	.clk_bypass	= &div_mpu_hs_clk,
-	.clk_ref	= &sys_clkin_ck,
-	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_MPU,
+static struct dpll_data dpll_mpu_dd __initdata = {
+	.mult_div1_reg	= { .reginfo = { OMAP4430_CM_CLKSEL_DPLL_MPU } },
+	.clk_bypass	= { .name = "div_mpu_hs_clk" },
+	.clk_ref	= { .name = "sys_clkin_ck" },
+	.control_reg	= { .reginfo = { OMAP4430_CM_CLKMODE_DPLL_MPU } },
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
-	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_MPU,
-	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_MPU,
+	.autoidle_reg	= { .reginfo = { OMAP4430_CM_AUTOIDLE_DPLL_MPU } },
+	.idlest_reg	= { .reginfo = { OMAP4430_CM_IDLEST_DPLL_MPU } },
 	.mult_mask	= OMAP4430_DPLL_MULT_MASK,
 	.div1_mask	= OMAP4430_DPLL_DIV_MASK,
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
@@ -443,44 +419,40 @@ static const char *dpll_mpu_ck_parents[] = {
 	"sys_clkin_ck", "div_mpu_hs_clk"
 };
 
-static struct clk dpll_mpu_ck;
 
-static struct clk_hw_omap dpll_mpu_ck_hw = {
-	.hw = {
-		.clk = &dpll_mpu_ck,
-	},
+static struct clk_hw_omap dpll_mpu_ck_hw __initdata = {
 	.dpll_data	= &dpll_mpu_dd,
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_mpu_ck, dpll_mpu_ck_parents, dpll_ck_ops);
+OMAP_CLK(dpll_mpu_ck, dpll_mpu_ck_parents, dpll_ck_ops);
 
-DEFINE_CLK_FIXED_FACTOR(mpu_periphclk, "dpll_mpu_ck", &dpll_mpu_ck, 0x0, 1, 2);
+OMAP_CLK_FIXED_FACTOR(mpu_periphclk, "dpll_mpu_ck", &dpll_mpu_ck, 0x0, 1, 2);
 
 DEFINE_CLK_OMAP_HSDIVIDER(dpll_mpu_m2_ck, "dpll_mpu_ck", &dpll_mpu_ck, 0x0,
 			  OMAP4430_CM_DIV_M2_DPLL_MPU,
 			  OMAP4430_DPLL_CLKOUT_DIV_MASK);
 
-DEFINE_CLK_FIXED_FACTOR(per_hs_clk_div_ck, "dpll_abe_m3x2_ck",
+OMAP_CLK_FIXED_FACTOR(per_hs_clk_div_ck, "dpll_abe_m3x2_ck",
 			&dpll_abe_m3x2_ck, 0x0, 1, 2);
 
 static const char *per_hsd_byp_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "per_hs_clk_div_ck",
 };
 
-DEFINE_CLK_MUX(per_hsd_byp_clk_mux_ck, per_hsd_byp_clk_mux_ck_parents, NULL,
+OMAP_CLK_MUX(per_hsd_byp_clk_mux_ck, per_hsd_byp_clk_mux_ck_parents, NULL,
 	       0x0, OMAP4430_CM_CLKSEL_DPLL_PER, OMAP4430_DPLL_BYP_CLKSEL_SHIFT,
 	       OMAP4430_DPLL_BYP_CLKSEL_WIDTH, 0x0, NULL);
 
 /* DPLL_PER */
-static struct dpll_data dpll_per_dd = {
-	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_PER,
-	.clk_bypass	= &per_hsd_byp_clk_mux_ck,
-	.clk_ref	= &sys_clkin_ck,
-	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_PER,
+static struct dpll_data dpll_per_dd __initdata = {
+	.mult_div1_reg	= { .reginfo = { OMAP4430_CM_CLKSEL_DPLL_PER } },
+	.clk_bypass	= { .name = "per_hsd_byp_clk_mux_ck" },
+	.clk_ref	= { .name = "sys_clkin_ck" },
+	.control_reg	= { .reginfo = { OMAP4430_CM_CLKMODE_DPLL_PER } },
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
-	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_PER,
-	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_PER,
+	.autoidle_reg	= { .reginfo = { OMAP4430_CM_AUTOIDLE_DPLL_PER } },
+	.idlest_reg	= { .reginfo = { OMAP4430_CM_IDLEST_DPLL_PER } },
 	.mult_mask	= OMAP4430_DPLL_MULT_MASK,
 	.div1_mask	= OMAP4430_DPLL_DIV_MASK,
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
@@ -495,19 +467,15 @@ static const char *dpll_per_ck_parents[] = {
 	"sys_clkin_ck", "per_hsd_byp_clk_mux_ck"
 };
 
-static struct clk dpll_per_ck;
 
-static struct clk_hw_omap dpll_per_ck_hw = {
-	.hw = {
-		.clk = &dpll_per_ck,
-	},
+static struct clk_hw_omap dpll_per_ck_hw __initdata = {
 	.dpll_data	= &dpll_per_dd,
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_per_ck, dpll_per_ck_parents, dpll_ck_ops);
+OMAP_CLK(dpll_per_ck, dpll_per_ck_parents, dpll_ck_ops);
 
-DEFINE_CLK_DIVIDER(dpll_per_m2_ck, "dpll_per_ck", &dpll_per_ck, 0x0,
+OMAP_CLK_DIVIDER(dpll_per_m2_ck, "dpll_per_ck", &dpll_per_ck, 0x0,
 		   OMAP4430_CM_DIV_M2_DPLL_PER, OMAP4430_DPLL_CLKOUT_DIV_SHIFT,
 		   OMAP4430_DPLL_CLKOUT_DIV_WIDTH, CLK_DIVIDER_ONE_BASED, NULL);
 
@@ -515,18 +483,14 @@ static const char *dpll_per_x2_ck_parents[] = {
 	"dpll_per_ck",
 };
 
-static struct clk dpll_per_x2_ck;
 
-static struct clk_hw_omap dpll_per_x2_ck_hw = {
-	.hw = {
-		.clk = &dpll_per_x2_ck,
-	},
+static struct clk_hw_omap dpll_per_x2_ck_hw __initdata = {
 	.flags		= CLOCK_CLKOUTX2,
-	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
+	.clksel_reg	= { .reginfo = { OMAP4430_CM_DIV_M2_DPLL_PER } },
 	.ops		= &clkhwops_omap4_dpllmx,
 };
 
-DEFINE_STRUCT_CLK(dpll_per_x2_ck, dpll_per_x2_ck_parents, dpll_abe_x2_ck_ops);
+OMAP_CLK(dpll_per_x2_ck, dpll_per_x2_ck_parents, dpll_abe_x2_ck_ops);
 
 DEFINE_CLK_OMAP_HSDIVIDER(dpll_per_m2x2_ck, "dpll_per_x2_ck", &dpll_per_x2_ck,
 			  0x0, OMAP4430_CM_DIV_M2_DPLL_PER,
@@ -536,9 +500,9 @@ static const char *dpll_per_m3x2_ck_parents[] = {
 	"dpll_per_x2_ck",
 };
 
-static const struct clksel dpll_per_m3x2_div[] = {
-	{ .parent = &dpll_per_x2_ck, .rates = div31_1to31_rates },
-	{ .parent = NULL },
+static struct clksel_init dpll_per_m3x2_div[] __initdata = {
+	{ .parent_name = "dpll_per_x2_ck", .rates = div31_1to31_rates },
+	{ .parent_name = NULL },
 };
 
 /* XXX Missing round_rate, set_rate in ops */
@@ -565,19 +529,19 @@ DEFINE_CLK_OMAP_HSDIVIDER(dpll_per_m7x2_ck, "dpll_per_x2_ck", &dpll_per_x2_ck,
 			  0x0, OMAP4430_CM_DIV_M7_DPLL_PER,
 			  OMAP4430_HSDIVIDER_CLKOUT4_DIV_MASK);
 
-DEFINE_CLK_FIXED_FACTOR(usb_hs_clk_div_ck, "dpll_abe_m3x2_ck",
+OMAP_CLK_FIXED_FACTOR(usb_hs_clk_div_ck, "dpll_abe_m3x2_ck",
 			&dpll_abe_m3x2_ck, 0x0, 1, 3);
 
 /* DPLL_USB */
-static struct dpll_data dpll_usb_dd = {
-	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_USB,
-	.clk_bypass	= &usb_hs_clk_div_ck,
+static struct dpll_data dpll_usb_dd __initdata = {
+	.mult_div1_reg	= { .reginfo = { OMAP4430_CM_CLKSEL_DPLL_USB } },
+	.clk_bypass	= { .name = "usb_hs_clk_div_ck" },
 	.flags		= DPLL_J_TYPE,
-	.clk_ref	= &sys_clkin_ck,
-	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_USB,
+	.clk_ref	= { .name = "sys_clkin_ck" },
+	.control_reg	= { .reginfo = { OMAP4430_CM_CLKMODE_DPLL_USB } },
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
-	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_USB,
-	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_USB,
+	.autoidle_reg	= { .reginfo = { OMAP4430_CM_AUTOIDLE_DPLL_USB } },
+	.idlest_reg	= { .reginfo = { OMAP4430_CM_IDLEST_DPLL_USB } },
 	.mult_mask	= OMAP4430_DPLL_MULT_USB_MASK,
 	.div1_mask	= OMAP4430_DPLL_DIV_0_7_MASK,
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
@@ -593,36 +557,28 @@ static const char *dpll_usb_ck_parents[] = {
 	"sys_clkin_ck", "usb_hs_clk_div_ck"
 };
 
-static struct clk dpll_usb_ck;
 
-static struct clk_hw_omap dpll_usb_ck_hw = {
-	.hw = {
-		.clk = &dpll_usb_ck,
-	},
+static struct clk_hw_omap dpll_usb_ck_hw __initdata = {
 	.dpll_data	= &dpll_usb_dd,
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_usb_ck, dpll_usb_ck_parents, dpll_ck_ops);
+OMAP_CLK(dpll_usb_ck, dpll_usb_ck_parents, dpll_ck_ops);
 
 static const char *dpll_usb_clkdcoldo_ck_parents[] = {
 	"dpll_usb_ck",
 };
 
-static struct clk dpll_usb_clkdcoldo_ck;
 
 static const struct clk_ops dpll_usb_clkdcoldo_ck_ops = {
 };
 
-static struct clk_hw_omap dpll_usb_clkdcoldo_ck_hw = {
-	.hw = {
-		.clk = &dpll_usb_clkdcoldo_ck,
-	},
-	.clksel_reg	= OMAP4430_CM_CLKDCOLDO_DPLL_USB,
+static struct clk_hw_omap dpll_usb_clkdcoldo_ck_hw __initdata = {
+	.clksel_reg	= { .reginfo = { OMAP4430_CM_CLKDCOLDO_DPLL_USB } },
 	.ops		= &clkhwops_omap4_dpllmx,
 };
 
-DEFINE_STRUCT_CLK(dpll_usb_clkdcoldo_ck, dpll_usb_clkdcoldo_ck_parents,
+OMAP_CLK(dpll_usb_clkdcoldo_ck, dpll_usb_clkdcoldo_ck_parents,
 		  dpll_usb_clkdcoldo_ck_ops);
 
 DEFINE_CLK_OMAP_HSDIVIDER(dpll_usb_m2_ck, "dpll_usb_ck", &dpll_usb_ck, 0x0,
@@ -633,17 +589,17 @@ static const char *ducati_clk_mux_ck_parents[] = {
 	"div_core_ck", "dpll_per_m6x2_ck",
 };
 
-DEFINE_CLK_MUX(ducati_clk_mux_ck, ducati_clk_mux_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(ducati_clk_mux_ck, ducati_clk_mux_ck_parents, NULL, 0x0,
 	       OMAP4430_CM_CLKSEL_DUCATI_ISS_ROOT, OMAP4430_CLKSEL_0_0_SHIFT,
 	       OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_FIXED_FACTOR(func_12m_fclk, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck,
+OMAP_CLK_FIXED_FACTOR(func_12m_fclk, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck,
 			0x0, 1, 16);
 
-DEFINE_CLK_FIXED_FACTOR(func_24m_clk, "dpll_per_m2_ck", &dpll_per_m2_ck, 0x0,
+OMAP_CLK_FIXED_FACTOR(func_24m_clk, "dpll_per_m2_ck", &dpll_per_m2_ck, 0x0,
 			1, 4);
 
-DEFINE_CLK_FIXED_FACTOR(func_24mc_fclk, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck,
+OMAP_CLK_FIXED_FACTOR(func_24mc_fclk, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck,
 			0x0, 1, 8);
 
 static const struct clk_div_table func_48m_fclk_rates[] = {
@@ -651,12 +607,12 @@ static const struct clk_div_table func_48m_fclk_rates[] = {
 	{ .div = 8, .val = 1 },
 	{ .div = 0 },
 };
-DEFINE_CLK_DIVIDER_TABLE(func_48m_fclk, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck,
+OMAP_CLK_DIVIDER_TABLE(func_48m_fclk, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck,
 			 0x0, OMAP4430_CM_SCALE_FCLK, OMAP4430_SCALE_FCLK_SHIFT,
 			 OMAP4430_SCALE_FCLK_WIDTH, 0x0, func_48m_fclk_rates,
 			 NULL);
 
-DEFINE_CLK_FIXED_FACTOR(func_48mc_fclk,	"dpll_per_m2x2_ck", &dpll_per_m2x2_ck,
+OMAP_CLK_FIXED_FACTOR(func_48mc_fclk,	"dpll_per_m2x2_ck", &dpll_per_m2x2_ck,
 			0x0, 1, 4);
 
 static const struct clk_div_table func_64m_fclk_rates[] = {
@@ -664,7 +620,7 @@ static const struct clk_div_table func_64m_fclk_rates[] = {
 	{ .div = 4, .val = 1 },
 	{ .div = 0 },
 };
-DEFINE_CLK_DIVIDER_TABLE(func_64m_fclk, "dpll_per_m4x2_ck", &dpll_per_m4x2_ck,
+OMAP_CLK_DIVIDER_TABLE(func_64m_fclk, "dpll_per_m4x2_ck", &dpll_per_m4x2_ck,
 			 0x0, OMAP4430_CM_SCALE_FCLK, OMAP4430_SCALE_FCLK_SHIFT,
 			 OMAP4430_SCALE_FCLK_WIDTH, 0x0, func_64m_fclk_rates,
 			 NULL);
@@ -674,7 +630,7 @@ static const struct clk_div_table func_96m_fclk_rates[] = {
 	{ .div = 4, .val = 1 },
 	{ .div = 0 },
 };
-DEFINE_CLK_DIVIDER_TABLE(func_96m_fclk, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck,
+OMAP_CLK_DIVIDER_TABLE(func_96m_fclk, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck,
 			 0x0, OMAP4430_CM_SCALE_FCLK, OMAP4430_SCALE_FCLK_SHIFT,
 			 OMAP4430_SCALE_FCLK_WIDTH, 0x0, func_96m_fclk_rates,
 			 NULL);
@@ -684,27 +640,27 @@ static const struct clk_div_table init_60m_fclk_rates[] = {
 	{ .div = 8, .val = 1 },
 	{ .div = 0 },
 };
-DEFINE_CLK_DIVIDER_TABLE(init_60m_fclk, "dpll_usb_m2_ck", &dpll_usb_m2_ck,
+OMAP_CLK_DIVIDER_TABLE(init_60m_fclk, "dpll_usb_m2_ck", &dpll_usb_m2_ck,
 			 0x0, OMAP4430_CM_CLKSEL_USB_60MHZ,
 			 OMAP4430_CLKSEL_0_0_SHIFT, OMAP4430_CLKSEL_0_0_WIDTH,
 			 0x0, init_60m_fclk_rates, NULL);
 
-DEFINE_CLK_DIVIDER(l3_div_ck, "div_core_ck", &div_core_ck, 0x0,
+OMAP_CLK_DIVIDER(l3_div_ck, "div_core_ck", &div_core_ck, 0x0,
 		   OMAP4430_CM_CLKSEL_CORE, OMAP4430_CLKSEL_L3_SHIFT,
 		   OMAP4430_CLKSEL_L3_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_DIVIDER(l4_div_ck, "l3_div_ck", &l3_div_ck, 0x0,
+OMAP_CLK_DIVIDER(l4_div_ck, "l3_div_ck", &l3_div_ck, 0x0,
 		   OMAP4430_CM_CLKSEL_CORE, OMAP4430_CLKSEL_L4_SHIFT,
 		   OMAP4430_CLKSEL_L4_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_FIXED_FACTOR(lp_clk_div_ck, "dpll_abe_m2x2_ck", &dpll_abe_m2x2_ck,
+OMAP_CLK_FIXED_FACTOR(lp_clk_div_ck, "dpll_abe_m2x2_ck", &dpll_abe_m2x2_ck,
 			0x0, 1, 16);
 
 static const char *l4_wkup_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "lp_clk_div_ck",
 };
 
-DEFINE_CLK_MUX(l4_wkup_clk_mux_ck, l4_wkup_clk_mux_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(l4_wkup_clk_mux_ck, l4_wkup_clk_mux_ck_parents, NULL, 0x0,
 	       OMAP4430_CM_L4_WKUP_CLKSEL, OMAP4430_CLKSEL_0_0_SHIFT,
 	       OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
@@ -713,20 +669,20 @@ static const struct clk_div_table ocp_abe_iclk_rates[] = {
 	{ .div = 1, .val = 1 },
 	{ .div = 0 },
 };
-DEFINE_CLK_DIVIDER_TABLE(ocp_abe_iclk, "aess_fclk", &aess_fclk, 0x0,
+OMAP_CLK_DIVIDER_TABLE(ocp_abe_iclk, "aess_fclk", &aess_fclk, 0x0,
 			 OMAP4430_CM1_ABE_AESS_CLKCTRL,
 			 OMAP4430_CLKSEL_AESS_FCLK_SHIFT,
 			 OMAP4430_CLKSEL_AESS_FCLK_WIDTH,
 			 0x0, ocp_abe_iclk_rates, NULL);
 
-DEFINE_CLK_FIXED_FACTOR(per_abe_24m_fclk, "dpll_abe_m2_ck", &dpll_abe_m2_ck,
+OMAP_CLK_FIXED_FACTOR(per_abe_24m_fclk, "dpll_abe_m2_ck", &dpll_abe_m2_ck,
 			0x0, 1, 4);
 
-DEFINE_CLK_DIVIDER(per_abe_nc_fclk, "dpll_abe_m2_ck", &dpll_abe_m2_ck, 0x0,
+OMAP_CLK_DIVIDER(per_abe_nc_fclk, "dpll_abe_m2_ck", &dpll_abe_m2_ck, 0x0,
 		   OMAP4430_CM_SCALE_FCLK, OMAP4430_SCALE_FCLK_SHIFT,
 		   OMAP4430_SCALE_FCLK_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_DIVIDER(syc_clk_div_ck, "sys_clkin_ck", &sys_clkin_ck, 0x0,
+OMAP_CLK_DIVIDER(syc_clk_div_ck, "sys_clkin_ck", &sys_clkin_ck, 0x0,
 		   OMAP4430_CM_ABE_DSS_SYS_CLKSEL, OMAP4430_CLKSEL_0_0_SHIFT,
 		   OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
@@ -734,26 +690,25 @@ static const char *dbgclk_mux_ck_parents[] = {
 	"sys_clkin_ck"
 };
 
-static struct clk dbgclk_mux_ck;
 DEFINE_STRUCT_CLK_HW_OMAP(dbgclk_mux_ck, NULL);
-DEFINE_STRUCT_CLK(dbgclk_mux_ck, dbgclk_mux_ck_parents,
+OMAP_CLK(dbgclk_mux_ck, dbgclk_mux_ck_parents,
 		  dpll_usb_clkdcoldo_ck_ops);
 
 /* Leaf clocks controlled by modules */
 
-DEFINE_CLK_GATE(aes1_fck, "l3_div_ck", &l3_div_ck, 0x0,
+OMAP_CLK_GATE(aes1_fck, "l3_div_ck", &l3_div_ck, 0x0,
 		OMAP4430_CM_L4SEC_AES1_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(aes2_fck, "l3_div_ck", &l3_div_ck, 0x0,
+OMAP_CLK_GATE(aes2_fck, "l3_div_ck", &l3_div_ck, 0x0,
 		OMAP4430_CM_L4SEC_AES2_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(aess_fck, "aess_fclk", &aess_fclk, 0x0,
+OMAP_CLK_GATE(aess_fck, "aess_fclk", &aess_fclk, 0x0,
 		OMAP4430_CM1_ABE_AESS_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(bandgap_fclk, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(bandgap_fclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
 		OMAP4430_OPTFCLKEN_BGAP_32K_SHIFT, 0x0, NULL);
 
@@ -763,18 +718,18 @@ static const struct clk_div_table div_ts_ck_rates[] = {
 	{ .div = 32, .val = 2 },
 	{ .div = 0 },
 };
-DEFINE_CLK_DIVIDER_TABLE(div_ts_ck, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck,
+OMAP_CLK_DIVIDER_TABLE(div_ts_ck, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck,
 			 0x0, OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
 			 OMAP4430_CLKSEL_24_25_SHIFT,
 			 OMAP4430_CLKSEL_24_25_WIDTH, 0x0, div_ts_ck_rates,
 			 NULL);
 
-DEFINE_CLK_GATE(bandgap_ts_fclk, "div_ts_ck", &div_ts_ck, 0x0,
+OMAP_CLK_GATE(bandgap_ts_fclk, "div_ts_ck", &div_ts_ck, 0x0,
 		OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
 		OMAP4460_OPTFCLKEN_TS_FCLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(des3des_fck, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(des3des_fck, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L4SEC_DES3DES_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT,
 		0x0, NULL);
@@ -783,16 +738,16 @@ static const char *dmic_sync_mux_ck_parents[] = {
 	"abe_24m_fclk", "syc_clk_div_ck", "func_24m_clk",
 };
 
-DEFINE_CLK_MUX(dmic_sync_mux_ck, dmic_sync_mux_ck_parents, NULL,
+OMAP_CLK_MUX(dmic_sync_mux_ck, dmic_sync_mux_ck_parents, NULL,
 	       0x0, OMAP4430_CM1_ABE_DMIC_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
 
-static const struct clksel func_dmic_abe_gfclk_sel[] = {
-	{ .parent = &dmic_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
+static struct clksel_init func_dmic_abe_gfclk_sel[] __initdata = {
+	{ .parent_name = "dmic_sync_mux_ck", .rates = div_1_0_rates },
+	{ .parent_name = "pad_clks_ck", .rates = div_1_1_rates },
+	{ .parent_name = "slimbus_clk", .rates = div_1_2_rates },
+	{ .parent_name = NULL },
 };
 
 static const char *dmic_fck_parents[] = {
@@ -800,7 +755,6 @@ static const char *dmic_fck_parents[] = {
 };
 
 /* Merged func_dmic_abe_gfclk into dmic */
-static struct clk dmic_fck;
 
 DEFINE_CLK_OMAP_MUX_GATE(dmic_fck, "abe_clkdm", func_dmic_abe_gfclk_sel,
 			 OMAP4430_CM1_ABE_DMIC_CLKCTRL,
@@ -809,106 +763,106 @@ DEFINE_CLK_OMAP_MUX_GATE(dmic_fck, "abe_clkdm", func_dmic_abe_gfclk_sel,
 			 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 			 dmic_fck_parents, dmic_fck_ops);
 
-DEFINE_CLK_GATE(dsp_fck, "dpll_iva_m4x2_ck", &dpll_iva_m4x2_ck, 0x0,
+OMAP_CLK_GATE(dsp_fck, "dpll_iva_m4x2_ck", &dpll_iva_m4x2_ck, 0x0,
 		OMAP4430_CM_TESLA_TESLA_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(dss_sys_clk, "syc_clk_div_ck", &syc_clk_div_ck, 0x0,
+OMAP_CLK_GATE(dss_sys_clk, "syc_clk_div_ck", &syc_clk_div_ck, 0x0,
 		OMAP4430_CM_DSS_DSS_CLKCTRL,
 		OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(dss_tv_clk, "extalt_clkin_ck", &extalt_clkin_ck, 0x0,
+OMAP_CLK_GATE(dss_tv_clk, "extalt_clkin_ck", &extalt_clkin_ck, 0x0,
 		OMAP4430_CM_DSS_DSS_CLKCTRL,
 		OMAP4430_OPTFCLKEN_TV_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(dss_dss_clk, "dpll_per_m5x2_ck", &dpll_per_m5x2_ck, 0x0,
+OMAP_CLK_GATE(dss_dss_clk, "dpll_per_m5x2_ck", &dpll_per_m5x2_ck, 0x0,
 		OMAP4430_CM_DSS_DSS_CLKCTRL, OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(dss_48mhz_clk, "func_48mc_fclk", &func_48mc_fclk, 0x0,
+OMAP_CLK_GATE(dss_48mhz_clk, "func_48mc_fclk", &func_48mc_fclk, 0x0,
 		OMAP4430_CM_DSS_DSS_CLKCTRL, OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(dss_fck, "l3_div_ck", &l3_div_ck, 0x0,
+OMAP_CLK_GATE(dss_fck, "l3_div_ck", &l3_div_ck, 0x0,
 		OMAP4430_CM_DSS_DSS_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(efuse_ctrl_cust_fck, "sys_clkin_ck", &sys_clkin_ck, 0x0,
+OMAP_CLK_GATE(efuse_ctrl_cust_fck, "sys_clkin_ck", &sys_clkin_ck, 0x0,
 		OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(emif1_fck, "ddrphy_ck", &ddrphy_ck, 0x0,
+OMAP_CLK_GATE(emif1_fck, "ddrphy_ck", &ddrphy_ck, 0x0,
 		OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(emif2_fck, "ddrphy_ck", &ddrphy_ck, 0x0,
+OMAP_CLK_GATE(emif2_fck, "ddrphy_ck", &ddrphy_ck, 0x0,
 		OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_DIVIDER(fdif_fck, "dpll_per_m4x2_ck", &dpll_per_m4x2_ck, 0x0,
+OMAP_CLK_DIVIDER(fdif_fck, "dpll_per_m4x2_ck", &dpll_per_m4x2_ck, 0x0,
 		   OMAP4430_CM_CAM_FDIF_CLKCTRL, OMAP4430_CLKSEL_FCLK_SHIFT,
 		   OMAP4430_CLKSEL_FCLK_WIDTH, CLK_DIVIDER_POWER_OF_TWO, NULL);
 
-DEFINE_CLK_GATE(fpka_fck, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(fpka_fck, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(gpio1_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(gpio1_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
 		OMAP4430_OPTFCLKEN_DBCLK_SHIFT,	0x0, NULL);
 
-DEFINE_CLK_GATE(gpio1_ick, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck, 0x0,
+OMAP_CLK_GATE(gpio1_ick, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck, 0x0,
 		OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(gpio2_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(gpio2_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_L4PER_GPIO2_CLKCTRL, OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(gpio2_ick, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(gpio2_ick, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(gpio3_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(gpio3_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
 		OMAP4430_OPTFCLKEN_DBCLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(gpio3_ick, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(gpio3_ick, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(gpio4_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(gpio4_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_L4PER_GPIO4_CLKCTRL, OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(gpio4_ick, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(gpio4_ick, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(gpio5_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(gpio5_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_L4PER_GPIO5_CLKCTRL, OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(gpio5_ick, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(gpio5_ick, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(gpio6_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(gpio6_dbclk, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_L4PER_GPIO6_CLKCTRL, OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(gpio6_ick, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(gpio6_ick, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(gpmc_ick, "l3_div_ck", &l3_div_ck, 0x0,
+OMAP_CLK_GATE(gpmc_ick, "l3_div_ck", &l3_div_ck, 0x0,
 		OMAP4430_CM_L3_2_GPMC_CLKCTRL, OMAP4430_MODULEMODE_HWCTRL_SHIFT,
 		0x0, NULL);
 
-static const struct clksel sgx_clk_mux_sel[] = {
-	{ .parent = &dpll_core_m7x2_ck, .rates = div_1_0_rates },
-	{ .parent = &dpll_per_m7x2_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
+static struct clksel_init sgx_clk_mux_sel[] __initdata = {
+	{ .parent_name = "dpll_core_m7x2_ck", .rates = div_1_0_rates },
+	{ .parent_name = "dpll_per_m7x2_ck", .rates = div_1_1_rates },
+	{ .parent_name = NULL },
 };
 
 static const char *gpu_fck_parents[] = {
@@ -923,52 +877,51 @@ DEFINE_CLK_OMAP_MUX_GATE(gpu_fck, "l3_gfx_clkdm", sgx_clk_mux_sel,
 			 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 			 gpu_fck_parents, dmic_fck_ops);
 
-DEFINE_CLK_GATE(hdq1w_fck, "func_12m_fclk", &func_12m_fclk, 0x0,
+OMAP_CLK_GATE(hdq1w_fck, "func_12m_fclk", &func_12m_fclk, 0x0,
 		OMAP4430_CM_L4PER_HDQ1W_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_DIVIDER(hsi_fck, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck, 0x0,
+OMAP_CLK_DIVIDER(hsi_fck, "dpll_per_m2x2_ck", &dpll_per_m2x2_ck, 0x0,
 		   OMAP4430_CM_L3INIT_HSI_CLKCTRL, OMAP4430_CLKSEL_24_25_SHIFT,
 		   OMAP4430_CLKSEL_24_25_WIDTH, CLK_DIVIDER_POWER_OF_TWO,
 		   NULL);
 
-DEFINE_CLK_GATE(i2c1_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
+OMAP_CLK_GATE(i2c1_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
 		OMAP4430_CM_L4PER_I2C1_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(i2c2_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
+OMAP_CLK_GATE(i2c2_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
 		OMAP4430_CM_L4PER_I2C2_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(i2c3_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
+OMAP_CLK_GATE(i2c3_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
 		OMAP4430_CM_L4PER_I2C3_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(i2c4_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
+OMAP_CLK_GATE(i2c4_fck, "func_96m_fclk", &func_96m_fclk, 0x0,
 		OMAP4430_CM_L4PER_I2C4_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(ipu_fck, "ducati_clk_mux_ck", &ducati_clk_mux_ck, 0x0,
+OMAP_CLK_GATE(ipu_fck, "ducati_clk_mux_ck", &ducati_clk_mux_ck, 0x0,
 		OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(iss_ctrlclk, "func_96m_fclk", &func_96m_fclk, 0x0,
+OMAP_CLK_GATE(iss_ctrlclk, "func_96m_fclk", &func_96m_fclk, 0x0,
 		OMAP4430_CM_CAM_ISS_CLKCTRL, OMAP4430_OPTFCLKEN_CTRLCLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(iss_fck, "ducati_clk_mux_ck", &ducati_clk_mux_ck, 0x0,
+OMAP_CLK_GATE(iss_fck, "ducati_clk_mux_ck", &ducati_clk_mux_ck, 0x0,
 		OMAP4430_CM_CAM_ISS_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(iva_fck, "dpll_iva_m5x2_ck", &dpll_iva_m5x2_ck, 0x0,
+OMAP_CLK_GATE(iva_fck, "dpll_iva_m5x2_ck", &dpll_iva_m5x2_ck, 0x0,
 		OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(kbd_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(kbd_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-static struct clk l3_instr_ick;
 
 static const char *l3_instr_ick_parent_names[] = {
 	"l3_div_ck",
@@ -981,39 +934,32 @@ static const struct clk_ops l3_instr_ick_ops = {
 	.init		= &omap2_init_clk_clkdm,
 };
 
-static struct clk_hw_omap l3_instr_ick_hw = {
-	.hw = {
-		.clk = &l3_instr_ick,
-	},
-	.enable_reg	= OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL,
+static struct clk_hw_omap l3_instr_ick_hw __initdata = {
+	.enable_reg	= { .reginfo = { OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL } },
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL_SHIFT,
 	.clkdm_name	= "l3_instr_clkdm",
 };
 
-DEFINE_STRUCT_CLK(l3_instr_ick, l3_instr_ick_parent_names, l3_instr_ick_ops);
+OMAP_CLK(l3_instr_ick, l3_instr_ick_parent_names, l3_instr_ick_ops);
 
-static struct clk l3_main_3_ick;
-static struct clk_hw_omap l3_main_3_ick_hw = {
-	.hw = {
-		.clk = &l3_main_3_ick,
-	},
-	.enable_reg	= OMAP4430_CM_L3INSTR_L3_3_CLKCTRL,
+static struct clk_hw_omap l3_main_3_ick_hw __initdata = {
+	.enable_reg	= { .reginfo = { OMAP4430_CM_L3INSTR_L3_3_CLKCTRL } },
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL_SHIFT,
 	.clkdm_name	= "l3_instr_clkdm",
 };
 
-DEFINE_STRUCT_CLK(l3_main_3_ick, l3_instr_ick_parent_names, l3_instr_ick_ops);
+OMAP_CLK(l3_main_3_ick, l3_instr_ick_parent_names, l3_instr_ick_ops);
 
-DEFINE_CLK_MUX(mcasp_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(mcasp_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
 	       OMAP4430_CM1_ABE_MCASP_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
 
-static const struct clksel func_mcasp_abe_gfclk_sel[] = {
-	{ .parent = &mcasp_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
+static struct clksel_init func_mcasp_abe_gfclk_sel[] __initdata = {
+	{ .parent_name = "mcasp_sync_mux_ck", .rates = div_1_0_rates },
+	{ .parent_name = "pad_clks_ck", .rates = div_1_1_rates },
+	{ .parent_name = "slimbus_clk", .rates = div_1_2_rates },
+	{ .parent_name = NULL },
 };
 
 static const char *mcasp_fck_parents[] = {
@@ -1028,16 +974,16 @@ DEFINE_CLK_OMAP_MUX_GATE(mcasp_fck, "abe_clkdm", func_mcasp_abe_gfclk_sel,
 			 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 			 mcasp_fck_parents, dmic_fck_ops);
 
-DEFINE_CLK_MUX(mcbsp1_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(mcbsp1_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
 	       OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
 
-static const struct clksel func_mcbsp1_gfclk_sel[] = {
-	{ .parent = &mcbsp1_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
+static struct clksel_init func_mcbsp1_gfclk_sel[] __initdata = {
+	{ .parent_name = "mcbsp1_sync_mux_ck", .rates = div_1_0_rates },
+	{ .parent_name = "pad_clks_ck", .rates = div_1_1_rates },
+	{ .parent_name = "slimbus_clk", .rates = div_1_2_rates },
+	{ .parent_name = NULL },
 };
 
 static const char *mcbsp1_fck_parents[] = {
@@ -1052,16 +998,16 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp1_fck, "abe_clkdm", func_mcbsp1_gfclk_sel,
 			 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 			 mcbsp1_fck_parents, dmic_fck_ops);
 
-DEFINE_CLK_MUX(mcbsp2_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(mcbsp2_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
 	       OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
 
-static const struct clksel func_mcbsp2_gfclk_sel[] = {
-	{ .parent = &mcbsp2_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
+static struct clksel_init func_mcbsp2_gfclk_sel[] __initdata = {
+	{ .parent_name = "mcbsp2_sync_mux_ck", .rates = div_1_0_rates },
+	{ .parent_name = "pad_clks_ck", .rates = div_1_1_rates },
+	{ .parent_name = "slimbus_clk", .rates = div_1_2_rates },
+	{ .parent_name = NULL },
 };
 
 static const char *mcbsp2_fck_parents[] = {
@@ -1076,16 +1022,16 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp2_fck, "abe_clkdm", func_mcbsp2_gfclk_sel,
 			 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 			 mcbsp2_fck_parents, dmic_fck_ops);
 
-DEFINE_CLK_MUX(mcbsp3_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(mcbsp3_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
 	       OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
 
-static const struct clksel func_mcbsp3_gfclk_sel[] = {
-	{ .parent = &mcbsp3_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
-	{ .parent = NULL },
+static struct clksel_init func_mcbsp3_gfclk_sel[] __initdata = {
+	{ .parent_name = "mcbsp3_sync_mux_ck", .rates = div_1_0_rates },
+	{ .parent_name = "pad_clks_ck", .rates = div_1_1_rates },
+	{ .parent_name = "slimbus_clk", .rates = div_1_2_rates },
+	{ .parent_name = NULL },
 };
 
 static const char *mcbsp3_fck_parents[] = {
@@ -1104,15 +1050,15 @@ static const char *mcbsp4_sync_mux_ck_parents[] = {
 	"func_96m_fclk", "per_abe_nc_fclk",
 };
 
-DEFINE_CLK_MUX(mcbsp4_sync_mux_ck, mcbsp4_sync_mux_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(mcbsp4_sync_mux_ck, mcbsp4_sync_mux_ck_parents, NULL, 0x0,
 	       OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
 
-static const struct clksel per_mcbsp4_gfclk_sel[] = {
-	{ .parent = &mcbsp4_sync_mux_ck, .rates = div_1_0_rates },
-	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
+static struct clksel_init per_mcbsp4_gfclk_sel[] __initdata = {
+	{ .parent_name = "mcbsp4_sync_mux_ck", .rates = div_1_0_rates },
+	{ .parent_name = "pad_clks_ck", .rates = div_1_1_rates },
+	{ .parent_name = NULL },
 };
 
 static const char *mcbsp4_fck_parents[] = {
@@ -1127,30 +1073,30 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp4_fck, "l4_per_clkdm", per_mcbsp4_gfclk_sel,
 			 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 			 mcbsp4_fck_parents, dmic_fck_ops);
 
-DEFINE_CLK_GATE(mcpdm_fck, "pad_clks_ck", &pad_clks_ck, 0x0,
+OMAP_CLK_GATE(mcpdm_fck, "pad_clks_ck", &pad_clks_ck, 0x0,
 		OMAP4430_CM1_ABE_PDM_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(mcspi1_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(mcspi1_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(mcspi2_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(mcspi2_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(mcspi3_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(mcspi3_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(mcspi4_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(mcspi4_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-static const struct clksel hsmmc1_fclk_sel[] = {
-	{ .parent = &func_64m_fclk, .rates = div_1_0_rates },
-	{ .parent = &func_96m_fclk, .rates = div_1_1_rates },
-	{ .parent = NULL },
+static struct clksel_init hsmmc1_fclk_sel[] __initdata = {
+	{ .parent_name = "func_64m_fclk", .rates = div_1_0_rates },
+	{ .parent_name = "func_96m_fclk", .rates = div_1_1_rates },
+	{ .parent_name = NULL },
 };
 
 static const char *mmc1_fck_parents[] = {
@@ -1171,104 +1117,100 @@ DEFINE_CLK_OMAP_MUX_GATE(mmc2_fck, "l3_init_clkdm", hsmmc1_fclk_sel,
 			 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 			 mmc1_fck_parents, dmic_fck_ops);
 
-DEFINE_CLK_GATE(mmc3_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(mmc3_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_MMCSD3_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(mmc4_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(mmc4_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_MMCSD4_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(mmc5_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(mmc5_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_MMCSD5_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(ocp2scp_usb_phy_phy_48m, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(ocp2scp_usb_phy_phy_48m, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
 		OMAP4430_OPTFCLKEN_PHY_48M_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(ocp2scp_usb_phy_ick, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(ocp2scp_usb_phy_ick, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-static struct clk ocp_wp_noc_ick;
 
-static struct clk_hw_omap ocp_wp_noc_ick_hw = {
-	.hw = {
-		.clk = &ocp_wp_noc_ick,
-	},
-	.enable_reg	= OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL,
+static struct clk_hw_omap ocp_wp_noc_ick_hw __initdata = {
+	.enable_reg	= { .reginfo = { OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL } },
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL_SHIFT,
 	.clkdm_name	= "l3_instr_clkdm",
 };
 
-DEFINE_STRUCT_CLK(ocp_wp_noc_ick, l3_instr_ick_parent_names, l3_instr_ick_ops);
+OMAP_CLK(ocp_wp_noc_ick, l3_instr_ick_parent_names, l3_instr_ick_ops);
 
-DEFINE_CLK_GATE(rng_ick, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(rng_ick, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L4SEC_RNG_CLKCTRL, OMAP4430_MODULEMODE_HWCTRL_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(sha2md5_fck, "l3_div_ck", &l3_div_ck, 0x0,
+OMAP_CLK_GATE(sha2md5_fck, "l3_div_ck", &l3_div_ck, 0x0,
 		OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(sl2if_ick, "dpll_iva_m5x2_ck", &dpll_iva_m5x2_ck, 0x0,
+OMAP_CLK_GATE(sl2if_ick, "dpll_iva_m5x2_ck", &dpll_iva_m5x2_ck, 0x0,
 		OMAP4430_CM_IVAHD_SL2_CLKCTRL, OMAP4430_MODULEMODE_HWCTRL_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(slimbus1_fclk_1, "func_24m_clk", &func_24m_clk, 0x0,
+OMAP_CLK_GATE(slimbus1_fclk_1, "func_24m_clk", &func_24m_clk, 0x0,
 		OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
 		OMAP4430_OPTFCLKEN_FCLK1_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(slimbus1_fclk_0, "abe_24m_fclk", &abe_24m_fclk, 0x0,
+OMAP_CLK_GATE(slimbus1_fclk_0, "abe_24m_fclk", &abe_24m_fclk, 0x0,
 		OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
 		OMAP4430_OPTFCLKEN_FCLK0_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(slimbus1_fclk_2, "pad_clks_ck", &pad_clks_ck, 0x0,
+OMAP_CLK_GATE(slimbus1_fclk_2, "pad_clks_ck", &pad_clks_ck, 0x0,
 		OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
 		OMAP4430_OPTFCLKEN_FCLK2_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(slimbus1_slimbus_clk, "slimbus_clk", &slimbus_clk, 0x0,
+OMAP_CLK_GATE(slimbus1_slimbus_clk, "slimbus_clk", &slimbus_clk, 0x0,
 		OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
 		OMAP4430_OPTFCLKEN_SLIMBUS_CLK_11_11_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(slimbus1_fck, "ocp_abe_iclk", &ocp_abe_iclk, 0x0,
+OMAP_CLK_GATE(slimbus1_fck, "ocp_abe_iclk", &ocp_abe_iclk, 0x0,
 		OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(slimbus2_fclk_1, "per_abe_24m_fclk", &per_abe_24m_fclk, 0x0,
+OMAP_CLK_GATE(slimbus2_fclk_1, "per_abe_24m_fclk", &per_abe_24m_fclk, 0x0,
 		OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
 		OMAP4430_OPTFCLKEN_PERABE24M_GFCLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(slimbus2_fclk_0, "func_24mc_fclk", &func_24mc_fclk, 0x0,
+OMAP_CLK_GATE(slimbus2_fclk_0, "func_24mc_fclk", &func_24mc_fclk, 0x0,
 		OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
 		OMAP4430_OPTFCLKEN_PER24MC_GFCLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(slimbus2_slimbus_clk, "pad_slimbus_core_clks_ck",
+OMAP_CLK_GATE(slimbus2_slimbus_clk, "pad_slimbus_core_clks_ck",
 		&pad_slimbus_core_clks_ck, 0x0,
 		OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
 		OMAP4430_OPTFCLKEN_SLIMBUS_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(slimbus2_fck, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(slimbus2_fck, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(smartreflex_core_fck, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck,
+OMAP_CLK_GATE(smartreflex_core_fck, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck,
 		0x0, OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(smartreflex_iva_fck, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck,
+OMAP_CLK_GATE(smartreflex_iva_fck, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck,
 		0x0, OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(smartreflex_mpu_fck, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck,
+OMAP_CLK_GATE(smartreflex_mpu_fck, "l4_wkup_clk_mux_ck", &l4_wkup_clk_mux_ck,
 		0x0, OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-static const struct clksel dmt1_clk_mux_sel[] = {
-	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
-	{ .parent = &sys_32k_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
+static struct clksel_init dmt1_clk_mux_sel[] __initdata = {
+	{ .parent_name = "sys_clkin_ck", .rates = div_1_0_rates },
+	{ .parent_name = "sys_32k_ck", .rates = div_1_1_rates },
+	{ .parent_name = NULL },
 };
 
 /* Merged dmt1_clk_mux into timer1 */
@@ -1318,10 +1260,10 @@ DEFINE_CLK_OMAP_MUX_GATE(timer4_fck, "l4_per_clkdm", dmt1_clk_mux_sel,
 			 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 			 abe_dpll_bypass_clk_mux_ck_parents, dmic_fck_ops);
 
-static const struct clksel timer5_sync_mux_sel[] = {
-	{ .parent = &syc_clk_div_ck, .rates = div_1_0_rates },
-	{ .parent = &sys_32k_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
+static struct clksel_init timer5_sync_mux_sel[] __initdata = {
+	{ .parent_name = "syc_clk_div_ck", .rates = div_1_0_rates },
+	{ .parent_name = "sys_32k_ck", .rates = div_1_1_rates },
+	{ .parent_name = NULL },
 };
 
 static const char *timer5_fck_parents[] = {
@@ -1364,23 +1306,22 @@ DEFINE_CLK_OMAP_MUX_GATE(timer9_fck, "l4_per_clkdm", dmt1_clk_mux_sel,
 			 OMAP4430_MODULEMODE_SWCTRL_SHIFT, NULL,
 			 abe_dpll_bypass_clk_mux_ck_parents, dmic_fck_ops);
 
-DEFINE_CLK_GATE(uart1_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(uart1_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_UART1_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(uart2_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(uart2_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_UART2_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(uart3_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(uart3_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_UART3_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(uart4_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
+OMAP_CLK_GATE(uart4_fck, "func_48m_fclk", &func_48m_fclk, 0x0,
 		OMAP4430_CM_L4PER_UART4_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
-static struct clk usb_host_fs_fck;
 
 static const char *usb_host_fs_fck_parent_names[] = {
 	"func_48mc_fclk",
@@ -1392,28 +1333,25 @@ static const struct clk_ops usb_host_fs_fck_ops = {
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
 };
 
-static struct clk_hw_omap usb_host_fs_fck_hw = {
-	.hw = {
-		.clk = &usb_host_fs_fck,
-	},
-	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL,
+static struct clk_hw_omap usb_host_fs_fck_hw __initdata = {
+	.enable_reg	= { .reginfo = { OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL } },
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL_SHIFT,
 	.clkdm_name	= "l3_init_clkdm",
 };
 
-DEFINE_STRUCT_CLK(usb_host_fs_fck, usb_host_fs_fck_parent_names,
+OMAP_CLK(usb_host_fs_fck, usb_host_fs_fck_parent_names,
 		  usb_host_fs_fck_ops);
 
 static const char *utmi_p1_gfclk_parents[] = {
 	"init_60m_fclk", "xclk60mhsp1_ck",
 };
 
-DEFINE_CLK_MUX(utmi_p1_gfclk, utmi_p1_gfclk_parents, NULL, 0x0,
+OMAP_CLK_MUX(utmi_p1_gfclk, utmi_p1_gfclk_parents, NULL, 0x0,
 	       OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	       OMAP4430_CLKSEL_UTMI_P1_SHIFT, OMAP4430_CLKSEL_UTMI_P1_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_GATE(usb_host_hs_utmi_p1_clk, "utmi_p1_gfclk", &utmi_p1_gfclk, 0x0,
+OMAP_CLK_GATE(usb_host_hs_utmi_p1_clk, "utmi_p1_gfclk", &utmi_p1_gfclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 		OMAP4430_OPTFCLKEN_UTMI_P1_CLK_SHIFT, 0x0, NULL);
 
@@ -1421,44 +1359,44 @@ static const char *utmi_p2_gfclk_parents[] = {
 	"init_60m_fclk", "xclk60mhsp2_ck",
 };
 
-DEFINE_CLK_MUX(utmi_p2_gfclk, utmi_p2_gfclk_parents, NULL, 0x0,
+OMAP_CLK_MUX(utmi_p2_gfclk, utmi_p2_gfclk_parents, NULL, 0x0,
 	       OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	       OMAP4430_CLKSEL_UTMI_P2_SHIFT, OMAP4430_CLKSEL_UTMI_P2_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_GATE(usb_host_hs_utmi_p2_clk, "utmi_p2_gfclk", &utmi_p2_gfclk, 0x0,
+OMAP_CLK_GATE(usb_host_hs_utmi_p2_clk, "utmi_p2_gfclk", &utmi_p2_gfclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 		OMAP4430_OPTFCLKEN_UTMI_P2_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_host_hs_utmi_p3_clk, "init_60m_fclk", &init_60m_fclk, 0x0,
+OMAP_CLK_GATE(usb_host_hs_utmi_p3_clk, "init_60m_fclk", &init_60m_fclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 		OMAP4430_OPTFCLKEN_UTMI_P3_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_host_hs_hsic480m_p1_clk, "dpll_usb_m2_ck",
+OMAP_CLK_GATE(usb_host_hs_hsic480m_p1_clk, "dpll_usb_m2_ck",
 		&dpll_usb_m2_ck, 0x0,
 		OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 		OMAP4430_OPTFCLKEN_HSIC480M_P1_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_host_hs_hsic60m_p1_clk, "init_60m_fclk",
+OMAP_CLK_GATE(usb_host_hs_hsic60m_p1_clk, "init_60m_fclk",
 		&init_60m_fclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 		OMAP4430_OPTFCLKEN_HSIC60M_P1_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_host_hs_hsic60m_p2_clk, "init_60m_fclk",
+OMAP_CLK_GATE(usb_host_hs_hsic60m_p2_clk, "init_60m_fclk",
 		&init_60m_fclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 		OMAP4430_OPTFCLKEN_HSIC60M_P2_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_host_hs_hsic480m_p2_clk, "dpll_usb_m2_ck",
+OMAP_CLK_GATE(usb_host_hs_hsic480m_p2_clk, "dpll_usb_m2_ck",
 		&dpll_usb_m2_ck, 0x0,
 		OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 		OMAP4430_OPTFCLKEN_HSIC480M_P2_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_host_hs_func48mclk, "func_48mc_fclk", &func_48mc_fclk, 0x0,
+OMAP_CLK_GATE(usb_host_hs_func48mclk, "func_48mc_fclk", &func_48mc_fclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 		OMAP4430_OPTFCLKEN_FUNC48MCLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_host_hs_fck, "init_60m_fclk", &init_60m_fclk, 0x0,
+OMAP_CLK_GATE(usb_host_hs_fck, "init_60m_fclk", &init_60m_fclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
 
@@ -1466,35 +1404,35 @@ static const char *otg_60m_gfclk_parents[] = {
 	"utmi_phy_clkout_ck", "xclk60motg_ck",
 };
 
-DEFINE_CLK_MUX(otg_60m_gfclk, otg_60m_gfclk_parents, NULL, 0x0,
+OMAP_CLK_MUX(otg_60m_gfclk, otg_60m_gfclk_parents, NULL, 0x0,
 	       OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL, OMAP4430_CLKSEL_60M_SHIFT,
 	       OMAP4430_CLKSEL_60M_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_otg_hs_xclk, "otg_60m_gfclk", &otg_60m_gfclk, 0x0,
+OMAP_CLK_GATE(usb_otg_hs_xclk, "otg_60m_gfclk", &otg_60m_gfclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
 		OMAP4430_OPTFCLKEN_XCLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_otg_hs_ick, "l3_div_ck", &l3_div_ck, 0x0,
+OMAP_CLK_GATE(usb_otg_hs_ick, "l3_div_ck", &l3_div_ck, 0x0,
 		OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_phy_cm_clk32k, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(usb_phy_cm_clk32k, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_ALWON_USBPHY_CLKCTRL,
 		OMAP4430_OPTFCLKEN_CLK32K_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_tll_hs_usb_ch2_clk, "init_60m_fclk", &init_60m_fclk, 0x0,
+OMAP_CLK_GATE(usb_tll_hs_usb_ch2_clk, "init_60m_fclk", &init_60m_fclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
 		OMAP4430_OPTFCLKEN_USB_CH2_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_tll_hs_usb_ch0_clk, "init_60m_fclk", &init_60m_fclk, 0x0,
+OMAP_CLK_GATE(usb_tll_hs_usb_ch0_clk, "init_60m_fclk", &init_60m_fclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
 		OMAP4430_OPTFCLKEN_USB_CH0_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_tll_hs_usb_ch1_clk, "init_60m_fclk", &init_60m_fclk, 0x0,
+OMAP_CLK_GATE(usb_tll_hs_usb_ch1_clk, "init_60m_fclk", &init_60m_fclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
 		OMAP4430_OPTFCLKEN_USB_CH1_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(usb_tll_hs_ick, "l4_div_ck", &l4_div_ck, 0x0,
+OMAP_CLK_GATE(usb_tll_hs_ick, "l4_div_ck", &l4_div_ck, 0x0,
 		OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
 		OMAP4430_MODULEMODE_HWCTRL_SHIFT, 0x0, NULL);
 
@@ -1503,24 +1441,24 @@ static const struct clk_div_table usim_ck_rates[] = {
 	{ .div = 18, .val = 1 },
 	{ .div = 0 },
 };
-DEFINE_CLK_DIVIDER_TABLE(usim_ck, "dpll_per_m4x2_ck", &dpll_per_m4x2_ck, 0x0,
+OMAP_CLK_DIVIDER_TABLE(usim_ck, "dpll_per_m4x2_ck", &dpll_per_m4x2_ck, 0x0,
 			 OMAP4430_CM_WKUP_USIM_CLKCTRL,
 			 OMAP4430_CLKSEL_DIV_SHIFT, OMAP4430_CLKSEL_DIV_WIDTH,
 			 0x0, usim_ck_rates, NULL);
 
-DEFINE_CLK_GATE(usim_fclk, "usim_ck", &usim_ck, 0x0,
+OMAP_CLK_GATE(usim_fclk, "usim_ck", &usim_ck, 0x0,
 		OMAP4430_CM_WKUP_USIM_CLKCTRL, OMAP4430_OPTFCLKEN_FCLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(usim_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(usim_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_WKUP_USIM_CLKCTRL, OMAP4430_MODULEMODE_HWCTRL_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(wd_timer2_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(wd_timer2_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM_WKUP_WDT2_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_GATE(wd_timer3_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
+OMAP_CLK_GATE(wd_timer3_fck, "sys_32k_ck", &sys_32k_ck, 0x0,
 		OMAP4430_CM1_ABE_WDT3_CLKCTRL, OMAP4430_MODULEMODE_SWCTRL_SHIFT,
 		0x0, NULL);
 
@@ -1529,16 +1467,16 @@ static const char *pmd_stm_clock_mux_ck_parents[] = {
 	"sys_clkin_ck", "dpll_core_m6x2_ck", "tie_low_clock_ck",
 };
 
-DEFINE_CLK_MUX(pmd_stm_clock_mux_ck, pmd_stm_clock_mux_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(pmd_stm_clock_mux_ck, pmd_stm_clock_mux_ck_parents, NULL, 0x0,
 	       OMAP4430_CM_EMU_DEBUGSS_CLKCTRL, OMAP4430_PMD_STM_MUX_CTRL_SHIFT,
 	       OMAP4430_PMD_STM_MUX_CTRL_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_MUX(pmd_trace_clk_mux_ck, pmd_stm_clock_mux_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(pmd_trace_clk_mux_ck, pmd_stm_clock_mux_ck_parents, NULL, 0x0,
 	       OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
 	       OMAP4430_PMD_TRACE_MUX_CTRL_SHIFT,
 	       OMAP4430_PMD_TRACE_MUX_CTRL_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_DIVIDER(stm_clk_div_ck, "pmd_stm_clock_mux_ck",
+OMAP_CLK_DIVIDER(stm_clk_div_ck, "pmd_stm_clock_mux_ck",
 		   &pmd_stm_clock_mux_ck, 0x0, OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
 		   OMAP4430_CLKSEL_PMD_STM_CLK_SHIFT,
 		   OMAP4430_CLKSEL_PMD_STM_CLK_WIDTH, CLK_DIVIDER_POWER_OF_TWO,
@@ -1548,12 +1486,11 @@ static const char *trace_clk_div_ck_parents[] = {
 	"pmd_trace_clk_mux_ck",
 };
 
-static const struct clksel trace_clk_div_div[] = {
-	{ .parent = &pmd_trace_clk_mux_ck, .rates = div3_1to4_rates },
-	{ .parent = NULL },
+static struct clksel_init trace_clk_div_div[] __initdata = {
+	{ .parent_name = "pmd_trace_clk_mux_ck", .rates = div3_1to4_rates },
+	{ .parent_name = NULL },
 };
 
-static struct clk trace_clk_div_ck;
 
 static const struct clk_ops trace_clk_div_ck_ops = {
 	.recalc_rate	= &omap2_clksel_recalc,
@@ -1564,26 +1501,23 @@ static const struct clk_ops trace_clk_div_ck_ops = {
 	.disable	= &omap2_clkops_disable_clkdm,
 };
 
-static struct clk_hw_omap trace_clk_div_ck_hw = {
-	.hw = {
-		.clk = &trace_clk_div_ck,
-	},
+static struct clk_hw_omap trace_clk_div_ck_hw __initdata = {
 	.clkdm_name	= "emu_sys_clkdm",
-	.clksel		= trace_clk_div_div,
-	.clksel_reg	= OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
+	.clksel		= { .init = trace_clk_div_div },
+	.clksel_reg	= { .reginfo = { OMAP4430_CM_EMU_DEBUGSS_CLKCTRL } },
 	.clksel_mask	= OMAP4430_CLKSEL_PMD_TRACE_CLK_MASK,
 };
 
-DEFINE_STRUCT_CLK(trace_clk_div_ck, trace_clk_div_ck_parents,
+OMAP_CLK(trace_clk_div_ck, trace_clk_div_ck_parents,
 		  trace_clk_div_ck_ops);
 
 /* SCRM aux clk nodes */
 
-static const struct clksel auxclk_src_sel[] = {
-	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
-	{ .parent = &dpll_core_m3x2_ck, .rates = div_1_1_rates },
-	{ .parent = &dpll_per_m3x2_ck, .rates = div_1_2_rates },
-	{ .parent = NULL },
+static struct clksel_init auxclk_src_sel[] __initdata = {
+	{ .parent_name = "sys_clkin_ck", .rates = div_1_0_rates },
+	{ .parent_name = "dpll_core_m3x2_ck", .rates = div_1_1_rates },
+	{ .parent_name = "dpll_per_m3x2_ck", .rates = div_1_2_rates },
+	{ .parent_name = NULL },
 };
 
 static const char *auxclk_src_ck_parents[] = {
@@ -1603,7 +1537,7 @@ DEFINE_CLK_OMAP_MUX_GATE(auxclk0_src_ck, NULL, auxclk_src_sel,
 			 OMAP4_SCRM_AUXCLK0, OMAP4_ENABLE_SHIFT, NULL,
 			 auxclk_src_ck_parents, auxclk_src_ck_ops);
 
-DEFINE_CLK_DIVIDER(auxclk0_ck, "auxclk0_src_ck", &auxclk0_src_ck, 0x0,
+OMAP_CLK_DIVIDER(auxclk0_ck, "auxclk0_src_ck", &auxclk0_src_ck, 0x0,
 		   OMAP4_SCRM_AUXCLK0, OMAP4_CLKDIV_SHIFT, OMAP4_CLKDIV_WIDTH,
 		   0x0, NULL);
 
@@ -1612,7 +1546,7 @@ DEFINE_CLK_OMAP_MUX_GATE(auxclk1_src_ck, NULL, auxclk_src_sel,
 			 OMAP4_SCRM_AUXCLK1, OMAP4_ENABLE_SHIFT, NULL,
 			 auxclk_src_ck_parents, auxclk_src_ck_ops);
 
-DEFINE_CLK_DIVIDER(auxclk1_ck, "auxclk1_src_ck", &auxclk1_src_ck, 0x0,
+OMAP_CLK_DIVIDER(auxclk1_ck, "auxclk1_src_ck", &auxclk1_src_ck, 0x0,
 		   OMAP4_SCRM_AUXCLK1, OMAP4_CLKDIV_SHIFT, OMAP4_CLKDIV_WIDTH,
 		   0x0, NULL);
 
@@ -1621,7 +1555,7 @@ DEFINE_CLK_OMAP_MUX_GATE(auxclk2_src_ck, NULL, auxclk_src_sel,
 			 OMAP4_SCRM_AUXCLK2, OMAP4_ENABLE_SHIFT, NULL,
 			 auxclk_src_ck_parents, auxclk_src_ck_ops);
 
-DEFINE_CLK_DIVIDER(auxclk2_ck, "auxclk2_src_ck", &auxclk2_src_ck, 0x0,
+OMAP_CLK_DIVIDER(auxclk2_ck, "auxclk2_src_ck", &auxclk2_src_ck, 0x0,
 		   OMAP4_SCRM_AUXCLK2, OMAP4_CLKDIV_SHIFT, OMAP4_CLKDIV_WIDTH,
 		   0x0, NULL);
 
@@ -1630,7 +1564,7 @@ DEFINE_CLK_OMAP_MUX_GATE(auxclk3_src_ck, NULL, auxclk_src_sel,
 			 OMAP4_SCRM_AUXCLK3, OMAP4_ENABLE_SHIFT, NULL,
 			 auxclk_src_ck_parents, auxclk_src_ck_ops);
 
-DEFINE_CLK_DIVIDER(auxclk3_ck, "auxclk3_src_ck", &auxclk3_src_ck, 0x0,
+OMAP_CLK_DIVIDER(auxclk3_ck, "auxclk3_src_ck", &auxclk3_src_ck, 0x0,
 		   OMAP4_SCRM_AUXCLK3, OMAP4_CLKDIV_SHIFT, OMAP4_CLKDIV_WIDTH,
 		   0x0, NULL);
 
@@ -1639,7 +1573,7 @@ DEFINE_CLK_OMAP_MUX_GATE(auxclk4_src_ck, NULL, auxclk_src_sel,
 			 OMAP4_SCRM_AUXCLK4, OMAP4_ENABLE_SHIFT, NULL,
 			 auxclk_src_ck_parents, auxclk_src_ck_ops);
 
-DEFINE_CLK_DIVIDER(auxclk4_ck, "auxclk4_src_ck", &auxclk4_src_ck, 0x0,
+OMAP_CLK_DIVIDER(auxclk4_ck, "auxclk4_src_ck", &auxclk4_src_ck, 0x0,
 		   OMAP4_SCRM_AUXCLK4, OMAP4_CLKDIV_SHIFT, OMAP4_CLKDIV_WIDTH,
 		   0x0, NULL);
 
@@ -1648,7 +1582,7 @@ DEFINE_CLK_OMAP_MUX_GATE(auxclk5_src_ck, NULL, auxclk_src_sel,
 			 OMAP4_SCRM_AUXCLK5, OMAP4_ENABLE_SHIFT, NULL,
 			 auxclk_src_ck_parents, auxclk_src_ck_ops);
 
-DEFINE_CLK_DIVIDER(auxclk5_ck, "auxclk5_src_ck", &auxclk5_src_ck, 0x0,
+OMAP_CLK_DIVIDER(auxclk5_ck, "auxclk5_src_ck", &auxclk5_src_ck, 0x0,
 		   OMAP4_SCRM_AUXCLK5, OMAP4_CLKDIV_SHIFT, OMAP4_CLKDIV_WIDTH,
 		   0x0, NULL);
 
@@ -1657,27 +1591,27 @@ static const char *auxclkreq_ck_parents[] = {
 	"auxclk5_ck",
 };
 
-DEFINE_CLK_MUX(auxclkreq0_ck, auxclkreq_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(auxclkreq0_ck, auxclkreq_ck_parents, NULL, 0x0,
 	       OMAP4_SCRM_AUXCLKREQ0, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq1_ck, auxclkreq_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(auxclkreq1_ck, auxclkreq_ck_parents, NULL, 0x0,
 	       OMAP4_SCRM_AUXCLKREQ1, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq2_ck, auxclkreq_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(auxclkreq2_ck, auxclkreq_ck_parents, NULL, 0x0,
 	       OMAP4_SCRM_AUXCLKREQ2, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq3_ck, auxclkreq_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(auxclkreq3_ck, auxclkreq_ck_parents, NULL, 0x0,
 	       OMAP4_SCRM_AUXCLKREQ3, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq4_ck, auxclkreq_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(auxclkreq4_ck, auxclkreq_ck_parents, NULL, 0x0,
 	       OMAP4_SCRM_AUXCLKREQ4, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq5_ck, auxclkreq_ck_parents, NULL, 0x0,
+OMAP_CLK_MUX(auxclkreq5_ck, auxclkreq_ck_parents, NULL, 0x0,
 	       OMAP4_SCRM_AUXCLKREQ5, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
@@ -1685,7 +1619,7 @@ DEFINE_CLK_MUX(auxclkreq5_ck, auxclkreq_ck_parents, NULL, 0x0,
  * clkdev
  */
 
-static struct omap_clk omap44xx_clks[] = {
+static struct omap_clk omap44xx_clks[] __initdata = {
 	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck,	CK_443X),
 	CLK(NULL,	"pad_clks_src_ck",		&pad_clks_src_ck,	CK_443X),
 	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck,	CK_443X),
@@ -1926,33 +1860,33 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"auxclk5_src_ck",		&auxclk5_src_ck,	CK_443X),
 	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
-	CLK("omap-gpmc",	"fck",			&dummy_ck,	CK_443X),
-	CLK("omap_i2c.1",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_i2c.2",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_i2c.3",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_i2c.4",	"ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"mailboxes_ick",		&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.0",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.1",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.2",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.3",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.4",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.1",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.2",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.3",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.4",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.1",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.2",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.3",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.4",	"ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
-	CLK("usbhs_omap",	"usbhost_ick",		&dummy_ck,		CK_443X),
-	CLK("usbhs_omap",	"usbtll_fck",		&dummy_ck,	CK_443X),
-	CLK("usbhs_tll",	"usbtll_fck",		&dummy_ck,	CK_443X),
-	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap-gpmc",	"fck",			&omap_dummy_ck,	CK_443X),
+	CLK("omap_i2c.1",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap_i2c.2",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap_i2c.3",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap_i2c.4",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK(NULL,	"mailboxes_ick",		&omap_dummy_ck,	CK_443X),
+	CLK("omap_hsmmc.0",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap_hsmmc.1",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap_hsmmc.2",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap_hsmmc.3",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap_hsmmc.4",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.1",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.2",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.3",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.4",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.1",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.2",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.3",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.4",	"ick",			&omap_dummy_ck,	CK_443X),
+	CLK(NULL,	"uart1_ick",			&omap_dummy_ck,	CK_443X),
+	CLK(NULL,	"uart2_ick",			&omap_dummy_ck,	CK_443X),
+	CLK(NULL,	"uart3_ick",			&omap_dummy_ck,	CK_443X),
+	CLK(NULL,	"uart4_ick",			&omap_dummy_ck,	CK_443X),
+	CLK("usbhs_omap",	"usbhost_ick",		&omap_dummy_ck,		CK_443X),
+	CLK("usbhs_omap",	"usbtll_fck",		&omap_dummy_ck,	CK_443X),
+	CLK("usbhs_tll",	"usbtll_fck",		&omap_dummy_ck,	CK_443X),
+	CLK("omap_wdt",	"ick",				&omap_dummy_ck,	CK_443X),
 	CLK(NULL,	"timer_32k_ck",	&sys_32k_ck,	CK_443X),
 	/* TODO: Remove "omap_timer.X" aliases once DT migration is complete */
 	CLK("omap_timer.1",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-- 
1.7.4.1

