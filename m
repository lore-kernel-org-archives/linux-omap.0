From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/10] OMAP2430: clock: add MCBSP_CLKS node and clkdev aliases
Date: Fri, 01 Oct 2010 15:35:00 -0600
Message-ID: <20101001213459.1408.11610.stgit@twilight.localdomain>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49831 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023Ab0JAVlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:41:25 -0400
In-Reply-To: <20101001213119.1408.65395.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add the MCBSP_CLKS clock and the clksel structures needed to support clock
framework-based source switching for McBSPs 1-5.  Also, add clkdev
aliases on the parent clocks for the McBSP source switching code, added
in a subsequent patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2430_data.c |   64 +++++++++++++++++++++++++++++++---
 1 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 701a171..4548319 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -18,6 +18,7 @@
 #include <linux/list.h>
 
 #include <plat/clkdev_omap.h>
+#include <plat/control.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
@@ -89,6 +90,12 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.clkdm_name	= "wkup_clkdm",
 };
 
+/* Optional external clock input for McBSP CLKS */
+static struct clk mcbsp_clks = {
+	.name		= "mcbsp_clks",
+	.ops		= &clkops_null,
+};
+
 /*
  * Analog domain root source clocks
  */
@@ -1123,14 +1130,34 @@ static struct clk mcbsp1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static const struct clksel_rate common_mcbsp_96m_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate common_mcbsp_mcbsp_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 0 }
+};
+
+static const struct clksel mcbsp_fck_clksel[] = {
+	{ .parent = &func_96m_ck,  .rates = common_mcbsp_96m_rates },
+	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
+	{ .parent = NULL }
+};
+
 static struct clk mcbsp1_fck = {
 	.name		= "mcbsp1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
+	.init		= &omap2_init_clksel_parent,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
-	.recalc		= &followparent_recalc,
+	.clksel_reg	= OMAP243X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
+	.clksel_mask	= OMAP2_MCBSP1_CLKS_MASK,
+	.clksel		= mcbsp_fck_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk mcbsp2_ick = {
@@ -1147,10 +1174,14 @@ static struct clk mcbsp2_fck = {
 	.name		= "mcbsp2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
+	.init		= &omap2_init_clksel_parent,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
-	.recalc		= &followparent_recalc,
+	.clksel_reg	= OMAP243X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
+	.clksel_mask	= OMAP2_MCBSP2_CLKS_MASK,
+	.clksel		= mcbsp_fck_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk mcbsp3_ick = {
@@ -1167,10 +1198,14 @@ static struct clk mcbsp3_fck = {
 	.name		= "mcbsp3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
+	.init		= &omap2_init_clksel_parent,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
-	.recalc		= &followparent_recalc,
+	.clksel_reg	= OMAP243X_CTRL_REGADDR(OMAP243X_CONTROL_DEVCONF1),
+	.clksel_mask	= OMAP2_MCBSP3_CLKS_MASK,
+	.clksel		= mcbsp_fck_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk mcbsp4_ick = {
@@ -1187,10 +1222,14 @@ static struct clk mcbsp4_fck = {
 	.name		= "mcbsp4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
+	.init		= &omap2_init_clksel_parent,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
-	.recalc		= &followparent_recalc,
+	.clksel_reg	= OMAP243X_CTRL_REGADDR(OMAP243X_CONTROL_DEVCONF1),
+	.clksel_mask	= OMAP2_MCBSP4_CLKS_MASK,
+	.clksel		= mcbsp_fck_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk mcbsp5_ick = {
@@ -1207,10 +1246,14 @@ static struct clk mcbsp5_fck = {
 	.name		= "mcbsp5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
+	.init		= &omap2_init_clksel_parent,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
-	.recalc		= &followparent_recalc,
+	.clksel_reg	= OMAP243X_CTRL_REGADDR(OMAP243X_CONTROL_DEVCONF1),
+	.clksel_mask	= OMAP2_MCBSP5_CLKS_MASK,
+	.clksel		= mcbsp_fck_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk mcspi1_ick = {
@@ -1808,6 +1851,12 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X),
 	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X),
 	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap-mcbsp.1",	"pad_fck",	&mcbsp_clks,	CK_243X),
+	CLK("omap-mcbsp.2",	"pad_fck",	&mcbsp_clks,	CK_243X),
+	CLK("omap-mcbsp.3",	"pad_fck",	&mcbsp_clks,	CK_243X),
+	CLK("omap-mcbsp.4",	"pad_fck",	&mcbsp_clks,	CK_243X),
+	CLK("omap-mcbsp.5",	"pad_fck",	&mcbsp_clks,	CK_243X),
+	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_243X),
 	/* internal analog sources */
 	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_243X),
 	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_243X),
@@ -1815,6 +1864,11 @@ static struct omap_clk omap2430_clks[] = {
 	/* internal prcm root sources */
 	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_243X),
 	CLK(NULL,	"core_ck",	&core_ck,	CK_243X),
+	CLK("omap-mcbsp.1",	"prcm_fck",	&func_96m_ck,	CK_243X),
+	CLK("omap-mcbsp.2",	"prcm_fck",	&func_96m_ck,	CK_243X),
+	CLK("omap-mcbsp.3",	"prcm_fck",	&func_96m_ck,	CK_243X),
+	CLK("omap-mcbsp.4",	"prcm_fck",	&func_96m_ck,	CK_243X),
+	CLK("omap-mcbsp.5",	"prcm_fck",	&func_96m_ck,	CK_243X),
 	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_243X),
 	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_243X),
 	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_243X),


