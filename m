From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] OMAP4: clocks: Fix ES2 clock issues
Date: Wed, 22 Sep 2010 17:40:05 +0200
Message-ID: <1285170005-2157-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48600 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029Ab0IVPkJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 11:40:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

- usim optional clock are its parent had the same name, rename the parent
usim_fclk -> usim_ck

- OPTFCLKEN_CLK32K is not handled anymore by the USBPHYOCP2SCP module in ES2
Create a new clock that belongs to CM_ALWON_USBPHY_CLKCTRL register

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   88 +++++++++++++++++++++-------------
 1 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index d612e55..edf2c28 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2033,23 +2033,23 @@ static struct clk mmc5_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ocp2scp_usb_phy_clk32k = {
-	.name		= "ocp2scp_usb_phy_clk32k",
+static struct clk ocp2scp_usb_phy_phy_48m = {
+	.name		= "ocp2scp_usb_phy_phy_48m",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_CLK32K_SHIFT,
+	.enable_bit	= OMAP4430_OPTFCLKEN_PHY_48M_SHIFT,
 	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &sys_32k_ck,
+	.parent		= &func_48m_fclk,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ocp2scp_usb_phy_phy_48m = {
-	.name		= "ocp2scp_usb_phy_phy_48m",
+static struct clk ocp2scp_usb_phy_ick = {
+	.name		= "ocp2scp_usb_phy_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-	.enable_bit	= OMAP4430_OPTFCLKEN_PHY_48M_SHIFT,
+	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &func_48m_fclk,
+	.parent		= &l4_div_ck,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2595,6 +2595,16 @@ static struct clk usb_otg_hs_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk usb_phy_cm_clk32k = {
+	.name		= "usb_phy_cm_clk32k",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_ALWON_USBPHY_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_CLK32K_SHIFT,
+	.clkdm_name	= "l4_ao_clkdm",
+	.parent		= &sys_32k_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk usb_tll_hs_usb_ch2_clk = {
 	.name		= "usb_tll_hs_usb_ch2_clk",
 	.ops		= &clkops_omap2_dflt,
@@ -2635,6 +2645,39 @@ static struct clk usb_tll_hs_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static const struct clksel_rate div2_14to18_rates[] = {
+	{ .div = 14, .val = 0, .flags = RATE_IN_4430 },
+	{ .div = 18, .val = 1, .flags = RATE_IN_4430 },
+	{ .div = 0 },
+};
+
+static const struct clksel usim_fclk_div[] = {
+	{ .parent = &dpll_per_m4_ck, .rates = div2_14to18_rates },
+	{ .parent = NULL },
+};
+
+static struct clk usim_ck = {
+	.name		= "usim_ck",
+	.parent		= &dpll_per_m4_ck,
+	.clksel		= usim_fclk_div,
+	.clksel_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_DIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk usim_fclk = {
+	.name		= "usim_fclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
+	.enable_bit	= OMAP4430_OPTFCLKEN_FCLK_SHIFT,
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &usim_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk usim_fck = {
 	.name		= "usim_fck",
 	.ops		= &clkops_omap2_dflt,
@@ -2700,29 +2743,6 @@ static struct clk trace_clk_div_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static const struct clksel_rate div2_14to18_rates[] = {
-	{ .div = 14, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 18, .val = 1, .flags = RATE_IN_4430 },
-	{ .div = 0 },
-};
-
-static const struct clksel usim_fclk_div[] = {
-	{ .parent = &dpll_per_m4_ck, .rates = div2_14to18_rates },
-	{ .parent = NULL },
-};
-
-static struct clk usim_fclk = {
-	.name		= "usim_fclk",
-	.parent		= &dpll_per_m4_ck,
-	.clksel		= usim_fclk_div,
-	.clksel_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_DIV_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-};
-
 /*
  * clkdev
  */
@@ -2879,8 +2899,8 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("mmci-omap-hs.2",	"fck",				&mmc3_fck,	CK_443X),
 	CLK("mmci-omap-hs.3",	"fck",				&mmc4_fck,	CK_443X),
 	CLK("mmci-omap-hs.4",	"fck",				&mmc5_fck,	CK_443X),
-	CLK(NULL,	"ocp2scp_usb_phy_clk32k",	&ocp2scp_usb_phy_clk32k,	CK_443X),
 	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",	&ocp2scp_usb_phy_phy_48m,	CK_443X),
+	CLK(NULL,	"ocp2scp_usb_phy_ick",		&ocp2scp_usb_phy_ick,	CK_443X),
 	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_443X),
 	CLK("omap_rng",	"ick",				&rng_ick,	CK_443X),
 	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_443X),
@@ -2927,16 +2947,18 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk,	CK_443X),
 	CLK(NULL,	"usb_otg_hs_xclk",		&usb_otg_hs_xclk,	CK_443X),
 	CLK("musb_hdrc",	"ick",				&usb_otg_hs_ick,	CK_443X),
+	CLK(NULL,	"usb_phy_cm_clk32k",		&usb_phy_cm_clk32k,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",	&usb_tll_hs_usb_ch2_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick,	CK_443X),
+	CLK(NULL,	"usim_ck",			&usim_ck,	CK_443X),
+	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
 	CLK(NULL,	"usim_fck",			&usim_fck,	CK_443X),
 	CLK("omap_wdt",	"fck",				&wd_timer2_fck,	CK_443X),
 	CLK(NULL,	"wd_timer3_fck",		&wd_timer3_fck,	CK_443X),
 	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_443X),
 	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_443X),
-	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
 	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"gpt2_ick",			&dummy_ck,	CK_443X),
-- 
1.6.0.4

