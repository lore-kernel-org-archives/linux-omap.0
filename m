From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 8/8] OMAP4: clock data: Add missing fixed divisors
Date: Thu, 9 Dec 2010 23:13:40 +0100
Message-ID: <1291932820-11163-9-git-send-email-b-cousson@ti.com>
References: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48597 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757379Ab0LIWOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 17:14:12 -0500
In-Reply-To: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

The following OMAP4 clocks have the following fixed divisors that
determine the frequency at which these clocks operate. These
dividers are defined by the PRCM specification and without these
dividers the rates of the below clocks are calculated incorrectly.
This may cause internal peripherals using these clocks to operate
at the wrong frequency.

- abe_24m_fclk (freq = divided-by-8)
- ddrphy_ck (freq = parent divided-by-2)
- dll_clk_div_ck (freq = parent divided-by-2)
- per_hs_clk_div_ck (freq = parent divided-by-2)
- usb_hs_clk_div_ck (freq = parent divided-by-3)
- func_12m_fclk (freq = parent divided-by-16)
- func_24m_clk (freq = parent divided-by-4)
- func_24mc_fclk (freq = parent divided-by-8)
- func_48mc_fclk (freq = divided-by-4)
- lp_clk_div_ck (freq = divided-by-16)
- per_abe_24m_fclk (freq = divided-by-4)

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 51f28a0..953d97e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -333,7 +333,8 @@ static struct clk abe_24m_fclk = {
 	.name		= "abe_24m_fclk",
 	.parent		= &dpll_abe_m2x2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 8,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static const struct clksel_rate div3_1to4_rates[] = {
@@ -499,7 +500,8 @@ static struct clk ddrphy_ck = {
 	.name		= "ddrphy_ck",
 	.parent		= &dpll_core_m2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 2,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static struct clk dpll_core_m5x2_ck = {
@@ -584,7 +586,8 @@ static struct clk dll_clk_div_ck = {
 	.name		= "dll_clk_div_ck",
 	.parent		= &dpll_core_m4x2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 2,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static const struct clksel dpll_abe_m2_div[] = {
@@ -773,7 +776,8 @@ static struct clk per_hs_clk_div_ck = {
 	.name		= "per_hs_clk_div_ck",
 	.parent		= &dpll_abe_m3x2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 2,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static const struct clksel per_hsd_byp_clk_mux_sel[] = {
@@ -986,7 +990,8 @@ static struct clk usb_hs_clk_div_ck = {
 	.name		= "usb_hs_clk_div_ck",
 	.parent		= &dpll_abe_m3x2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 3,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 /* DPLL_USB */
@@ -1066,21 +1071,24 @@ static struct clk func_12m_fclk = {
 	.name		= "func_12m_fclk",
 	.parent		= &dpll_per_m2x2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 16,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static struct clk func_24m_clk = {
 	.name		= "func_24m_clk",
 	.parent		= &dpll_per_m2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 4,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static struct clk func_24mc_fclk = {
 	.name		= "func_24mc_fclk",
 	.parent		= &dpll_per_m2x2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 8,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static const struct clksel_rate div2_4to8_rates[] = {
@@ -1110,7 +1118,8 @@ static struct clk func_48mc_fclk = {
 	.name		= "func_48mc_fclk",
 	.parent		= &dpll_per_m2x2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 4,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static const struct clksel_rate div2_2to4_rates[] = {
@@ -1227,7 +1236,8 @@ static struct clk lp_clk_div_ck = {
 	.name		= "lp_clk_div_ck",
 	.parent		= &dpll_abe_m2x2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 16,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static const struct clksel l4_wkup_clk_mux_sel[] = {
@@ -1295,7 +1305,8 @@ static struct clk per_abe_24m_fclk = {
 	.name		= "per_abe_24m_fclk",
 	.parent		= &dpll_abe_m2_ck,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.fixed_div	= 4,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static const struct clksel pmd_stm_clock_mux_sel[] = {
-- 
1.7.0.4

