From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 06/16] OMAP4: clock data: Re-order some clock nodes and structure fields
Date: Thu, 23 Jun 2011 19:43:35 +0200
Message-ID: <1308851025-26313-7-git-send-email-b-cousson@ti.com>
References: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43658 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933109Ab1FWRoX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 13:44:23 -0400
In-Reply-To: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

A couple of fields were edited manually and thus do not stick
to the template used by the generator and by other structures.

Move them to the correct location.

Fix the wrong .ops for the dpll_unipro_x2_ck node.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   66 +++++++++++++++++----------------
 1 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 52f3e39..555044d 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -53,9 +53,9 @@ static struct clk extalt_clkin_ck = {
 static struct clk pad_clks_ck = {
 	.name		= "pad_clks_ck",
 	.rate		= 12000000,
-	.ops            = &clkops_omap2_dflt,
-	.enable_reg     = OMAP4430_CM_CLKSEL_ABE,
-	.enable_bit     = OMAP4430_PAD_CLKS_GATE_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_CLKSEL_ABE,
+	.enable_bit	= OMAP4430_PAD_CLKS_GATE_SHIFT,
 };
 
 static struct clk pad_slimbus_core_clks_ck = {
@@ -73,9 +73,9 @@ static struct clk secure_32k_clk_src_ck = {
 static struct clk slimbus_clk = {
 	.name		= "slimbus_clk",
 	.rate		= 12000000,
-	.ops            = &clkops_omap2_dflt,
-	.enable_reg     = OMAP4430_CM_CLKSEL_ABE,
-	.enable_bit     = OMAP4430_SLIMBUS_CLK_GATE_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_CLKSEL_ABE,
+	.enable_bit	= OMAP4430_SLIMBUS_CLK_GATE_SHIFT,
 };
 
 static struct clk sys_32k_ck = {
@@ -278,10 +278,10 @@ static struct clk dpll_abe_ck = {
 static struct clk dpll_abe_x2_ck = {
 	.name		= "dpll_abe_x2_ck",
 	.parent		= &dpll_abe_ck,
+	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 	.flags		= CLOCK_CLKOUTX2,
 	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap3_clkoutx2_recalc,
-	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 };
 
 static const struct clksel_rate div31_1to31_rates[] = {
@@ -622,11 +622,11 @@ static struct clk dpll_core_m3x2_ck = {
 	.clksel_reg	= OMAP4430_CM_DIV_M3_DPLL_CORE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_DIV_M3_DPLL_CORE,
-	.enable_bit	= OMAP4430_DPLL_CLKOUTHIF_GATE_CTRL_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
+	.enable_reg	= OMAP4430_CM_DIV_M3_DPLL_CORE,
+	.enable_bit	= OMAP4430_DPLL_CLKOUTHIF_GATE_CTRL_SHIFT,
 };
 
 static struct clk dpll_core_m7x2_ck = {
@@ -850,10 +850,10 @@ static struct clk dpll_per_m2_ck = {
 static struct clk dpll_per_x2_ck = {
 	.name		= "dpll_per_x2_ck",
 	.parent		= &dpll_per_ck,
+	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 	.flags		= CLOCK_CLKOUTX2,
 	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap3_clkoutx2_recalc,
-	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 };
 
 static const struct clksel dpll_per_m2x2_div[] = {
@@ -880,11 +880,11 @@ static struct clk dpll_per_m3x2_ck = {
 	.clksel_reg	= OMAP4430_CM_DIV_M3_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
 	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_DIV_M3_DPLL_PER,
-	.enable_bit	= OMAP4430_DPLL_CLKOUTHIF_GATE_CTRL_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
+	.enable_reg	= OMAP4430_CM_DIV_M3_DPLL_PER,
+	.enable_bit	= OMAP4430_DPLL_CLKOUTHIF_GATE_CTRL_SHIFT,
 };
 
 static struct clk dpll_per_m4x2_ck = {
@@ -969,8 +969,9 @@ static struct clk dpll_unipro_ck = {
 static struct clk dpll_unipro_x2_ck = {
 	.name		= "dpll_unipro_x2_ck",
 	.parent		= &dpll_unipro_ck,
+	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_UNIPRO,
 	.flags		= CLOCK_CLKOUTX2,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -1035,8 +1036,8 @@ static struct clk dpll_usb_ck = {
 static struct clk dpll_usb_clkdcoldo_ck = {
 	.name		= "dpll_usb_clkdcoldo_ck",
 	.parent		= &dpll_usb_ck,
-	.ops		= &clkops_omap4_dpllmx_ops,
 	.clksel_reg	= OMAP4430_CM_CLKDCOLDO_DPLL_USB,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1846,8 +1847,8 @@ static struct clk l3_instr_ick = {
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_instr_clkdm",
 	.flags		= ENABLE_ON_INIT,
+	.clkdm_name	= "l3_instr_clkdm",
 	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
 };
@@ -1857,8 +1858,8 @@ static struct clk l3_main_3_ick = {
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_L3_3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_instr_clkdm",
 	.flags		= ENABLE_ON_INIT,
+	.clkdm_name	= "l3_instr_clkdm",
 	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
 };
@@ -2162,8 +2163,8 @@ static struct clk ocp_wp_noc_ick = {
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_instr_clkdm",
 	.flags		= ENABLE_ON_INIT,
+	.clkdm_name	= "l3_instr_clkdm",
 	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
 };
@@ -2895,6 +2896,7 @@ static struct clk auxclk2_ck = {
 	.enable_reg	= OMAP4_SCRM_AUXCLK2,
 	.enable_bit	= OMAP4_ENABLE_SHIFT,
 };
+
 static struct clk auxclk3_ck = {
 	.name		= "auxclk3_ck",
 	.parent		= &sys_clkin_ck,
@@ -3216,7 +3218,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_func48mclk",	&usb_host_hs_func48mclk,	CK_443X),
 	CLK("usbhs-omap.0",	"hs_fck",		&usb_host_hs_fck,	CK_443X),
-	CLK("usbhs-omap.0",	"usbhost_ick",		&dummy_ck,		CK_443X),
 	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk,	CK_443X),
 	CLK(NULL,	"usb_otg_hs_xclk",		&usb_otg_hs_xclk,	CK_443X),
 	CLK("musb-omap2430",	"ick",				&usb_otg_hs_ick,	CK_443X),
@@ -3225,15 +3226,25 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk,	CK_443X),
 	CLK("usbhs-omap.0",	"usbtll_ick",		&usb_tll_hs_ick,	CK_443X),
-	CLK("usbhs-omap.0",	"usbtll_fck",		&dummy_ck,	CK_443X),
 	CLK(NULL,	"usim_ck",			&usim_ck,	CK_443X),
 	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
 	CLK(NULL,	"usim_fck",			&usim_fck,	CK_443X),
 	CLK("omap_wdt",	"fck",				&wd_timer2_fck,	CK_443X),
-	CLK(NULL,	"mailboxes_ick",		&dummy_ck,	CK_443X),
 	CLK(NULL,	"wd_timer3_fck",		&wd_timer3_fck,	CK_443X),
 	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_443X),
 	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_443X),
+	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck,	CK_443X),
+	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck,	CK_443X),
+	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck,	CK_443X),
+	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck,	CK_443X),
+	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck,	CK_443X),
+	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq0_ck",		&auxclkreq0_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq1_ck",		&auxclkreq1_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq2_ck",		&auxclkreq2_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
 	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"gpt2_ick",			&dummy_ck,	CK_443X),
@@ -3250,6 +3261,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap_i2c.2",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap_i2c.3",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap_i2c.4",	"ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"mailboxes_ick",		&dummy_ck,	CK_443X),
 	CLK("omap_hsmmc.0",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap_hsmmc.1",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap_hsmmc.2",	"ick",				&dummy_ck,	CK_443X),
@@ -3267,19 +3279,9 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
+	CLK("usbhs-omap.0",	"usbhost_ick",		&dummy_ck,		CK_443X),
+	CLK("usbhs-omap.0",	"usbtll_fck",		&dummy_ck,	CK_443X),
 	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
-	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck,	CK_443X),
-	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck,	CK_443X),
-	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck,	CK_443X),
-	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck,	CK_443X),
-	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck,	CK_443X),
-	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq0_ck",		&auxclkreq0_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq1_ck",		&auxclkreq1_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq2_ck",		&auxclkreq2_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.7.0.4

