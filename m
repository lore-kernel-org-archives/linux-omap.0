From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/12] OMAP4: clocks: Fix ES2 clock issues
Date: Fri, 24 Sep 2010 01:08:20 -0600
Message-ID: <20100924070817.14014.60205.stgit@twilight.localdomain>
References: <20100924070643.14014.11359.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33656 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744Ab0IXHJF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 03:09:05 -0400
In-Reply-To: <20100924070643.14014.11359.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

Fix a few OMAP4430 clock tree problems after the recent manual merge of the
various ES2 clock patches:

- usim optional clock and its parent had the same name, rename the parent
usim_fclk -> usim_ck

- OPTFCLKEN_CLK32K is not handled anymore by the USBPHYOCP2SCP module in ES2
Create a new clock that belongs to CM_ALWON_USBPHY_CLKCTRL register

This patch depends on some of the PRCM macro updates from Rajendra.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
[paul@pwsan.com: tweaked patch description]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   88 +++++++++++++++++++++-------------
 1 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index b94f21a..67fac44 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2037,23 +2037,23 @@ static struct clk mmc5_fck = {
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
 
@@ -2599,6 +2599,16 @@ static struct clk usb_otg_hs_ick = {
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
@@ -2639,6 +2649,39 @@ static struct clk usb_tll_hs_ick = {
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
@@ -2704,29 +2747,6 @@ static struct clk trace_clk_div_ck = {
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
@@ -2883,8 +2903,8 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("mmci-omap-hs.2",	"fck",				&mmc3_fck,	CK_443X),
 	CLK("mmci-omap-hs.3",	"fck",				&mmc4_fck,	CK_443X),
 	CLK("mmci-omap-hs.4",	"fck",				&mmc5_fck,	CK_443X),
-	CLK(NULL,	"ocp2scp_usb_phy_clk32k",	&ocp2scp_usb_phy_clk32k,	CK_443X),
 	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",	&ocp2scp_usb_phy_phy_48m,	CK_443X),
+	CLK(NULL,	"ocp2scp_usb_phy_ick",		&ocp2scp_usb_phy_ick,	CK_443X),
 	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_443X),
 	CLK("omap_rng",	"ick",				&rng_ick,	CK_443X),
 	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_443X),
@@ -2931,16 +2951,18 @@ static struct omap_clk omap44xx_clks[] = {
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


