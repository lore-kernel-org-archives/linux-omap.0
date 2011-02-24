From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP4: clock: Support divider selection for auxclks
Date: Thu, 24 Feb 2011 19:58:16 +0530
Message-ID: <1298557696-1726-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47584 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756099Ab1BXO22 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 09:28:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, gadiyar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On OMAP4 the auxclk nodes (part of SCRM) support both
divider as well as parent selection.
Supporting this requires splitting the existing nodes
(which support only parent selection) into
two nodes, one for parent and another for
divider selection.
The nodes for parent selection are named
auxclk*_src_ck and the ones for divider
selection as auxclk*_ck

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Tested-by: Anand Gadiyar <gadiyar@ti.com>
---
The only user of these auxclks' today is
USB PHY on panda board.
Thanks to Anand G for testing this works
fine with the patch,
Patch is based on 2.6.38-rc6 kernel.

 arch/arm/mach-omap2/clock44xx_data.c |  179 +++++++++++++++++++++++++++++-----
 1 files changed, 154 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index de9ec8d..af1aa93 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2842,19 +2842,39 @@ static struct clk trace_clk_div_ck = {
 
 /* SCRM aux clk nodes */
 
-static const struct clksel auxclk_sel[] = {
+static const struct clksel auxclk_src_sel[] = {
 	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
 	{ .parent = &dpll_core_m3x2_ck, .rates = div_1_1_rates },
 	{ .parent = &dpll_per_m3x2_ck, .rates = div_1_2_rates },
 	{ .parent = NULL },
 };
 
-static struct clk auxclk0_ck = {
-	.name		= "auxclk0_ck",
+static const struct clksel_rate div16_1to16_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
+	{ .div = 2, .val = 1, .flags = RATE_IN_4430 },
+	{ .div = 3, .val = 2, .flags = RATE_IN_4430 },
+	{ .div = 4, .val = 3, .flags = RATE_IN_4430 },
+	{ .div = 5, .val = 4, .flags = RATE_IN_4430 },
+	{ .div = 6, .val = 5, .flags = RATE_IN_4430 },
+	{ .div = 7, .val = 6, .flags = RATE_IN_4430 },
+	{ .div = 8, .val = 7, .flags = RATE_IN_4430 },
+	{ .div = 9, .val = 8, .flags = RATE_IN_4430 },
+	{ .div = 10, .val = 9, .flags = RATE_IN_4430 },
+	{ .div = 11, .val = 10, .flags = RATE_IN_4430 },
+	{ .div = 12, .val = 11, .flags = RATE_IN_4430 },
+	{ .div = 13, .val = 12, .flags = RATE_IN_4430 },
+	{ .div = 14, .val = 13, .flags = RATE_IN_4430 },
+	{ .div = 15, .val = 14, .flags = RATE_IN_4430 },
+	{ .div = 16, .val = 15, .flags = RATE_IN_4430 },
+	{ .div = 0 },
+};
+
+static struct clk auxclk0_src_ck = {
+	.name		= "auxclk0_src_ck",
 	.parent		= &sys_clkin_ck,
 	.init		= &omap2_init_clksel_parent,
 	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
+	.clksel		= auxclk_src_sel,
 	.clksel_reg	= OMAP4_SCRM_AUXCLK0,
 	.clksel_mask	= OMAP4_SRCSELECT_MASK,
 	.recalc		= &omap2_clksel_recalc,
@@ -2862,12 +2882,29 @@ static struct clk auxclk0_ck = {
 	.enable_bit	= OMAP4_ENABLE_SHIFT,
 };
 
-static struct clk auxclk1_ck = {
-	.name		= "auxclk1_ck",
+static const struct clksel auxclk0_sel[] = {
+	{ .parent = &auxclk0_src_ck, .rates = div16_1to16_rates },
+	{ .parent = NULL },
+};
+
+static struct clk auxclk0_ck = {
+	.name		= "auxclk0_ck",
+	.parent		= &auxclk0_src_ck,
+	.clksel		= auxclk0_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK0,
+	.clksel_mask	= OMAP4_CLKDIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk auxclk1_src_ck = {
+	.name		= "auxclk1_src_ck",
 	.parent		= &sys_clkin_ck,
 	.init		= &omap2_init_clksel_parent,
 	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
+	.clksel		= auxclk_src_sel,
 	.clksel_reg	= OMAP4_SCRM_AUXCLK1,
 	.clksel_mask	= OMAP4_SRCSELECT_MASK,
 	.recalc		= &omap2_clksel_recalc,
@@ -2875,24 +2912,59 @@ static struct clk auxclk1_ck = {
 	.enable_bit	= OMAP4_ENABLE_SHIFT,
 };
 
-static struct clk auxclk2_ck = {
-	.name		= "auxclk2_ck",
+static const struct clksel auxclk1_sel[] = {
+	{ .parent = &auxclk1_src_ck, .rates = div16_1to16_rates },
+	{ .parent = NULL },
+};
+
+static struct clk auxclk1_ck = {
+	.name		= "auxclk1_ck",
+	.parent		= &auxclk1_src_ck,
+	.clksel		= auxclk1_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK1,
+	.clksel_mask	= OMAP4_CLKDIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk auxclk2_src_ck = {
+	.name		= "auxclk2_src_ck",
 	.parent		= &sys_clkin_ck,
 	.init		= &omap2_init_clksel_parent,
 	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
+	.clksel		= auxclk_src_sel,
 	.clksel_reg	= OMAP4_SCRM_AUXCLK2,
 	.clksel_mask	= OMAP4_SRCSELECT_MASK,
 	.recalc		= &omap2_clksel_recalc,
 	.enable_reg	= OMAP4_SCRM_AUXCLK2,
 	.enable_bit	= OMAP4_ENABLE_SHIFT,
 };
-static struct clk auxclk3_ck = {
-	.name		= "auxclk3_ck",
+
+static const struct clksel auxclk2_sel[] = {
+	{ .parent = &auxclk2_src_ck, .rates = div16_1to16_rates },
+	{ .parent = NULL },
+};
+
+static struct clk auxclk2_ck = {
+	.name		= "auxclk2_ck",
+	.parent		= &auxclk2_src_ck,
+	.clksel		= auxclk2_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK2,
+	.clksel_mask	= OMAP4_CLKDIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk auxclk3_src_ck = {
+	.name		= "auxclk3_src_ck",
 	.parent		= &sys_clkin_ck,
 	.init		= &omap2_init_clksel_parent,
 	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
+	.clksel		= auxclk_src_sel,
 	.clksel_reg	= OMAP4_SCRM_AUXCLK3,
 	.clksel_mask	= OMAP4_SRCSELECT_MASK,
 	.recalc		= &omap2_clksel_recalc,
@@ -2900,12 +2972,29 @@ static struct clk auxclk3_ck = {
 	.enable_bit	= OMAP4_ENABLE_SHIFT,
 };
 
-static struct clk auxclk4_ck = {
-	.name		= "auxclk4_ck",
+static const struct clksel auxclk3_sel[] = {
+	{ .parent = &auxclk3_src_ck, .rates = div16_1to16_rates },
+	{ .parent = NULL },
+};
+
+static struct clk auxclk3_ck = {
+	.name		= "auxclk3_ck",
+	.parent		= &auxclk3_src_ck,
+	.clksel		= auxclk3_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK3,
+	.clksel_mask	= OMAP4_CLKDIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk auxclk4_src_ck = {
+	.name		= "auxclk4_src_ck",
 	.parent		= &sys_clkin_ck,
 	.init		= &omap2_init_clksel_parent,
 	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
+	.clksel		= auxclk_src_sel,
 	.clksel_reg	= OMAP4_SCRM_AUXCLK4,
 	.clksel_mask	= OMAP4_SRCSELECT_MASK,
 	.recalc		= &omap2_clksel_recalc,
@@ -2913,12 +3002,29 @@ static struct clk auxclk4_ck = {
 	.enable_bit	= OMAP4_ENABLE_SHIFT,
 };
 
-static struct clk auxclk5_ck = {
-	.name		= "auxclk5_ck",
+static const struct clksel auxclk4_sel[] = {
+	{ .parent = &auxclk4_src_ck, .rates = div16_1to16_rates },
+	{ .parent = NULL },
+};
+
+static struct clk auxclk4_ck = {
+	.name		= "auxclk4_ck",
+	.parent		= &auxclk4_src_ck,
+	.clksel		= auxclk4_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK4,
+	.clksel_mask	= OMAP4_CLKDIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk auxclk5_src_ck = {
+	.name		= "auxclk5_src_ck",
 	.parent		= &sys_clkin_ck,
 	.init		= &omap2_init_clksel_parent,
 	.ops		= &clkops_omap2_dflt,
-	.clksel		= auxclk_sel,
+	.clksel		= auxclk_src_sel,
 	.clksel_reg	= OMAP4_SCRM_AUXCLK5,
 	.clksel_mask	= OMAP4_SRCSELECT_MASK,
 	.recalc		= &omap2_clksel_recalc,
@@ -2926,6 +3032,23 @@ static struct clk auxclk5_ck = {
 	.enable_bit	= OMAP4_ENABLE_SHIFT,
 };
 
+static const struct clksel auxclk5_sel[] = {
+	{ .parent = &auxclk5_src_ck, .rates = div16_1to16_rates },
+	{ .parent = NULL },
+};
+
+static struct clk auxclk5_ck = {
+	.name		= "auxclk5_ck",
+	.parent		= &auxclk5_src_ck,
+	.clksel		= auxclk5_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK5,
+	.clksel_mask	= OMAP4_CLKDIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
 static const struct clksel auxclkreq_sel[] = {
 	{ .parent = &auxclk0_ck, .rates = div_1_0_rates },
 	{ .parent = &auxclk1_ck, .rates = div_1_1_rates },
@@ -3263,12 +3386,18 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
 	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
-	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck,	CK_443X),
-	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck,	CK_443X),
-	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck,	CK_443X),
-	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck,	CK_443X),
-	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck,	CK_443X),
-	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_443X),
+	CLK(NULL,	"auxclk0_src_ck",		&auxclk0_src_ck,	CK_443X),
+	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck,		CK_443X),
+	CLK(NULL,	"auxclk1_src_ck",		&auxclk1_src_ck,	CK_443X),
+	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck,		CK_443X),
+	CLK(NULL,	"auxclk2_src_ck",		&auxclk2_src_ck,	CK_443X),
+	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck,		CK_443X),
+	CLK(NULL,	"auxclk3_src_ck",		&auxclk3_src_ck,	CK_443X),
+	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck,		CK_443X),
+	CLK(NULL,	"auxclk4_src_ck",		&auxclk4_src_ck,	CK_443X),
+	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck,		CK_443X),
+	CLK(NULL,	"auxclk5_src_ck",		&auxclk5_src_ck,	CK_443X),
+	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,		CK_443X),
 	CLK(NULL,	"auxclkreq0_ck",		&auxclkreq0_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq1_ck",		&auxclkreq1_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq2_ck",		&auxclkreq2_ck,	CK_443X),
-- 
1.7.0.4

