From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/12] OMAP4: clock data: Add SCRM auxiliary clock nodes
Date: Mon, 13 Dec 2010 23:34:49 -0700
Message-ID: <20101214063448.21555.41295.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50279 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab0LNGf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 01:35:27 -0500
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Add support for auxiliary clocks nodes which are part of SCRM.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |  175 ++++++++++++++++++++++++++++++++++
 1 files changed, 175 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 421103c..80a1898 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -35,6 +35,7 @@
 #include "prm.h"
 #include "prm-regbits-44xx.h"
 #include "control.h"
+#include "scrm44xx.h"
 
 /* Root clocks */
 
@@ -2822,6 +2823,168 @@ static struct clk trace_clk_div_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
+/* SCRM aux clk nodes */
+
+static const struct clksel auxclk_sel[] = {
+	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
+	{ .parent = &dpll_core_m3x2_ck, .rates = div_1_1_rates },
+	{ .parent = &dpll_per_m3x2_ck, .rates = div_1_2_rates },
+	{ .parent = NULL },
+};
+
+static struct clk auxclk0_ck = {
+	.name		= "auxclk0_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK0,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK0,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+
+static struct clk auxclk1_ck = {
+	.name		= "auxclk1_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK1,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK1,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+
+static struct clk auxclk2_ck = {
+	.name		= "auxclk2_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK2,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK2,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+static struct clk auxclk3_ck = {
+	.name		= "auxclk3_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK3,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK3,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+
+static struct clk auxclk4_ck = {
+	.name		= "auxclk4_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK4,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK4,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+
+static struct clk auxclk5_ck = {
+	.name		= "auxclk5_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK5,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK5,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+
+static const struct clksel auxclkreq_sel[] = {
+	{ .parent = &auxclk0_ck, .rates = div_1_0_rates },
+	{ .parent = &auxclk1_ck, .rates = div_1_1_rates },
+	{ .parent = &auxclk2_ck, .rates = div_1_2_rates },
+	{ .parent = &auxclk3_ck, .rates = div_1_3_rates },
+	{ .parent = &auxclk4_ck, .rates = div_1_4_rates },
+	{ .parent = &auxclk5_ck, .rates = div_1_5_rates },
+	{ .parent = NULL },
+};
+
+static struct clk auxclkreq0_ck = {
+	.name		= "auxclkreq0_ck",
+	.parent		= &auxclk0_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ0,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk auxclkreq1_ck = {
+	.name		= "auxclkreq1_ck",
+	.parent		= &auxclk1_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ1,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk auxclkreq2_ck = {
+	.name		= "auxclkreq2_ck",
+	.parent		= &auxclk2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ2,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk auxclkreq3_ck = {
+	.name		= "auxclkreq3_ck",
+	.parent		= &auxclk3_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ3,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk auxclkreq4_ck = {
+	.name		= "auxclkreq4_ck",
+	.parent		= &auxclk4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ4,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk auxclkreq5_ck = {
+	.name		= "auxclkreq5_ck",
+	.parent		= &auxclk5_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ5,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /*
  * clkdev
  */
@@ -3083,6 +3246,18 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
 	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
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
 };
 
 int __init omap4xxx_clk_init(void)


