From: Nishanth Menon <nm@ti.com>
Subject: [RFC][PATCH 6/9] OMAP4: clocks: Update the clock tree with 4460 clock nodes
Date: Wed, 25 May 2011 18:56:53 -0700
Message-ID: <1306375016-707-7-git-send-email-nm@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:39996 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757036Ab1EZB51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 21:57:27 -0400
Received: by mail-yx0-f177.google.com with SMTP id 35so124842yxh.36
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 18:57:26 -0700 (PDT)
In-Reply-To: <1306375016-707-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

OMAP4460 platform has a few clock nodes which are added
and a few which are missing (compared to the 4430 platform)
Update the clock tree accordingly and handle these nodes
using the clock flags (CK_*).

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 96c0e3e..b10649d 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1264,6 +1264,13 @@ static struct clk l4_wkup_clk_mux_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk div_ts_ck = {
+	.name		= "div_ts_ck",
+	.parent		= &l4_wkup_clk_mux_ck,
+	.ops		= &clkops_null,
+	.recalc		= &followparent_recalc,
+};
+
 static const struct clksel per_abe_nc_fclk_div[] = {
 	{ .parent = &dpll_abe_m2_ck, .rates = div2_1to2_rates },
 	{ .parent = NULL },
@@ -1396,6 +1403,16 @@ static struct clk bandgap_fclk = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk bandgap_ts_fclk = {
+	.name		= "bandgap_ts_fclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+	.enable_bit	= OMAP4460_OPTFCLKEN_TS_FCLK_SHIFT,
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &div_ts_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk des3des_fck = {
 	.name		= "des3des_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -3098,6 +3115,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"l4_div_ck",			&l4_div_ck,	CK_44XX),
 	CLK(NULL,	"lp_clk_div_ck",		&lp_clk_div_ck,	CK_44XX),
 	CLK(NULL,	"l4_wkup_clk_mux_ck",		&l4_wkup_clk_mux_ck,	CK_44XX),
+	CLK(NULL,	"div_ts_ck",			&div_ts_ck,	CK_446X),
 	CLK(NULL,	"per_abe_nc_fclk",		&per_abe_nc_fclk,	CK_44XX),
 	CLK(NULL,	"mcasp2_fclk",			&mcasp2_fclk,	CK_44XX),
 	CLK(NULL,	"mcasp3_fclk",			&mcasp3_fclk,	CK_44XX),
@@ -3109,7 +3127,8 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"aes1_fck",			&aes1_fck,	CK_44XX),
 	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_44XX),
 	CLK(NULL,	"aess_fck",			&aess_fck,	CK_44XX),
-	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_44XX),
+	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_443X),
+	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk,	CK_446X),
 	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_44XX),
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_44XX),
 	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_44XX),
-- 
1.7.1

