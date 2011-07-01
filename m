From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 11/18] OMAP4: clock data: Add missing divider selection for auxclks
Date: Fri, 1 Jul 2011 22:41:34 +0200
Message-ID: <1309552901-8944-12-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57601 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755723Ab1GAUmK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:42:10 -0400
In-Reply-To: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

On OMAP4 the auxclk nodes (part of SCRM) support both
divider as well as parent selection.
Supporting this requires splitting the existing nodes
(which support only parent selection) into two nodes,
one for parent and another for divider selection.
The nodes for parent selection are named auxclk*_src_ck
and the ones for divider selection as auxclk*_ck.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[b-cousson@ti.com: Rebase on top of clock cleanup
and autogen alignement]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |  176 +++++++++++++++++++++++++++++-----
 1 files changed, 152 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2f7b5e6..8dd3e03 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2773,19 +2773,39 @@ static struct clk trace_clk_div_ck = {
 
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
+	{ .div = 1, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 2, .val = 1, .flags = RATE_IN_44XX },
+	{ .div = 3, .val = 2, .flags = RATE_IN_44XX },
+	{ .div = 4, .val = 3, .flags = RATE_IN_44XX },
+	{ .div = 5, .val = 4, .flags = RATE_IN_44XX },
+	{ .div = 6, .val = 5, .flags = RATE_IN_44XX },
+	{ .div = 7, .val = 6, .flags = RATE_IN_44XX },
+	{ .div = 8, .val = 7, .flags = RATE_IN_44XX },
+	{ .div = 9, .val = 8, .flags = RATE_IN_44XX },
+	{ .div = 10, .val = 9, .flags = RATE_IN_44XX },
+	{ .div = 11, .val = 10, .flags = RATE_IN_44XX },
+	{ .div = 12, .val = 11, .flags = RATE_IN_44XX },
+	{ .div = 13, .val = 12, .flags = RATE_IN_44XX },
+	{ .div = 14, .val = 13, .flags = RATE_IN_44XX },
+	{ .div = 15, .val = 14, .flags = RATE_IN_44XX },
+	{ .div = 16, .val = 15, .flags = RATE_IN_44XX },
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
@@ -2793,12 +2813,29 @@ static struct clk auxclk0_ck = {
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
@@ -2806,12 +2843,29 @@ static struct clk auxclk1_ck = {
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
@@ -2819,12 +2873,29 @@ static struct clk auxclk2_ck = {
 	.enable_bit	= OMAP4_ENABLE_SHIFT,
 };
 
-static struct clk auxclk3_ck = {
-	.name		= "auxclk3_ck",
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
@@ -2832,12 +2903,29 @@ static struct clk auxclk3_ck = {
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
@@ -2845,12 +2933,29 @@ static struct clk auxclk4_ck = {
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
@@ -2858,6 +2963,23 @@ static struct clk auxclk5_ck = {
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
@@ -3149,17 +3271,23 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"wd_timer3_fck",		&wd_timer3_fck,	CK_44XX),
 	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_44XX),
 	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_44XX),
+	CLK(NULL,	"auxclk0_src_ck",		&auxclk0_src_ck,	CK_44XX),
 	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck,	CK_44XX),
-	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck,	CK_44XX),
-	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck,	CK_44XX),
-	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck,	CK_44XX),
-	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck,	CK_44XX),
-	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_44XX),
 	CLK(NULL,	"auxclkreq0_ck",		&auxclkreq0_ck,	CK_44XX),
+	CLK(NULL,	"auxclk1_src_ck",		&auxclk1_src_ck,	CK_44XX),
+	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck,	CK_44XX),
 	CLK(NULL,	"auxclkreq1_ck",		&auxclkreq1_ck,	CK_44XX),
+	CLK(NULL,	"auxclk2_src_ck",		&auxclk2_src_ck,	CK_44XX),
+	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck,	CK_44XX),
 	CLK(NULL,	"auxclkreq2_ck",		&auxclkreq2_ck,	CK_44XX),
+	CLK(NULL,	"auxclk3_src_ck",		&auxclk3_src_ck,	CK_44XX),
+	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck,	CK_44XX),
 	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_44XX),
+	CLK(NULL,	"auxclk4_src_ck",		&auxclk4_src_ck,	CK_44XX),
+	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck,	CK_44XX),
 	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_44XX),
+	CLK(NULL,	"auxclk5_src_ck",		&auxclk5_src_ck,	CK_44XX),
+	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_44XX),
 	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_44XX),
 	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_44XX),
 	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_44XX),
-- 
1.7.0.4

