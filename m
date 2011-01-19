From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 3/3] OMAP4: clocks: Remove unused clksel definitions
Date: Wed, 19 Jan 2011 19:44:26 +0530
Message-ID: <1295446466-23655-4-git-send-email-rnayak@ti.com>
References: <1295446466-23655-1-git-send-email-rnayak@ti.com>
 <1295446466-23655-2-git-send-email-rnayak@ti.com>
 <1295446466-23655-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50708 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348Ab1ASOOg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 09:14:36 -0500
In-Reply-To: <1295446466-23655-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>

Trivial fix to remove a couple of unused
clksel definitions for OMAP4

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index b02bfae..02e0723 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -472,12 +472,6 @@ static struct clk dpll_core_m6x2_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-static struct clksel dbgclk_mux_sel[] = {
-	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
-	{ .parent = &dpll_core_m6x2_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
-
 static struct clk dbgclk_mux_ck = {
 	.name		= "dbgclk_mux_ck",
 	.parent		= &sys_clkin_ck,
@@ -1309,13 +1303,6 @@ static struct clk per_abe_24m_fclk = {
 	.recalc		= &omap_fixed_divisor_recalc,
 };
 
-static struct clksel pmd_stm_clock_mux_sel[] = {
-	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
-	{ .parent = &dpll_core_m6x2_ck, .rates = div_1_1_rates },
-	{ .parent = &tie_low_clock_ck, .rates = div_1_2_rates },
-	{ .parent = NULL },
-};
-
 static struct clk pmd_stm_clock_mux_ck = {
 	.name		= "pmd_stm_clock_mux_ck",
 	.parent		= &sys_clkin_ck,
-- 
1.7.0.4

