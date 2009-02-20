From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 1/1] OMAP3: CLOCK: Remove few unnecessary clocks
Date: Fri, 20 Feb 2009 13:52:47 +0200
Message-ID: <1235130767-18488-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60587 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbZBTLxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 06:53:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Carlos.Chinea@nokia.com

dpllx_m2x2_ck parent is dpllx_m2_ck. So remove few useless clocks and
and use right parent for dpllx_m2x2_ck.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h |   31 ++-----------------------------
 1 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 179ea17..4f462ea 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -427,18 +427,6 @@ static struct clk dpll3_ck = {
 	.recalc		= &omap3_dpll_recalc,
 };
 
-/*
- * This virtual clock provides the CLKOUTX2 output from the DPLL if the
- * DPLL isn't bypassed
- */
-static struct clk dpll3_x2_ck = {
-	.name		= "dpll3_x2_ck",
-	.parent		= &dpll3_ck,
-	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
-	.clkdm		= { .name = "dpll3_clkdm" },
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
 static const struct clksel_rate div31_dpll3_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
 	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
@@ -505,10 +493,10 @@ static struct clk core_ck = {
 
 static struct clk dpll3_m2x2_ck = {
 	.name		= "dpll3_m2x2_ck",
-	.parent		= &dpll3_x2_ck,
+	.parent		= &dpll3_m2_ck,
 	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll3_clkdm" },
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap3_clkoutx2_recalc,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
@@ -590,19 +578,6 @@ static struct clk dpll4_ck = {
 	.recalc		= &omap3_dpll_recalc,
 };
 
-/*
- * This virtual clock provides the CLKOUTX2 output from the DPLL if the
- * DPLL isn't bypassed --
- * XXX does this serve any downstream clocks?
- */
-static struct clk dpll4_x2_ck = {
-	.name		= "dpll4_x2_ck",
-	.parent		= &dpll4_ck,
-	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
-	.clkdm		= { .name = "dpll4_clkdm" },
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
 static const struct clksel div16_dpll4_clksel[] = {
 	{ .parent = &dpll4_ck, .rates = div16_dpll_rates },
 	{ .parent = NULL }
@@ -3355,14 +3330,12 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&dpll2_m2_ck,
 	&dpll3_ck,
 	&core_ck,
-	&dpll3_x2_ck,
 	&dpll3_m2_ck,
 	&dpll3_m2x2_ck,
 	&dpll3_m3_ck,
 	&dpll3_m3x2_ck,
 	&emu_core_alwon_ck,
 	&dpll4_ck,
-	&dpll4_x2_ck,
 	&omap_96m_alwon_fck,
 	&omap_96m_fck,
 	&cm_96m_fck,
-- 
1.6.0.1

