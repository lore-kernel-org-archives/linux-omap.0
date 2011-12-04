From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ARM: OMAP1: Always reprogramme dpll1 rate at boot.
Date: Sun,  4 Dec 2011 16:07:47 +0100
Message-ID: <1323011267-22190-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1322364751-29980-1-git-send-email-jkrzyszt@tis.icnet.pl> <1322364751-29980-4-git-send-email-jkrzyszt@tis.icnet.pl> <20111128174616.GP31337@atomide.com> <20111201190455.GV31337@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49101 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab1LDPI5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Dec 2011 10:08:57 -0500
In-Reply-To: <20111201190455.GV31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

DPLL1 reprogramming to a different rate is actually blocked inside
omap1_select_table_rate(). However, it is already forced at boot, for
boards which boot at unusable clock rates, and this seems to work
correctly.

OTOH, we now have a fine, run time performed clock selection algorithm
implemented, which prevents less powerfull SoCs from being overclocked
unintentionally.

Allow reprogramming of dpll1 by default, and use it for switching to the
higest supported clock rate with all boards, including those already
booting at a usable rate of 60 MHz or above.

Created against linux-omap/master tip as of Thu Dec 1,
commit f83c2a8cbb59981722d1ab610c79adfd034a2667. Requires the just
submitted patch "ARM: OMAP1: Move dpll1 rates selection from config to
runtime" to prevent from unintentional overclocking. Tested on Amstrad
Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap1/clock.c      |    4 ----
 arch/arm/mach-omap1/clock_data.c |    6 ------
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 84ef704..6993cd0 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -200,10 +200,6 @@ int omap1_select_table_rate(struct clk *clk, unsigned long rate)
 		if (ptr->xtal != ref_rate)
 			continue;
 
-		/* DPLL1 cannot be reprogrammed without risking system crash */
-		if (likely(dpll1_rate != 0) && ptr->pll_rate != dpll1_rate)
-			continue;
-
 		/* Can check only after xtal frequency check */
 		if (ptr->rate <= rate)
 			break;
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 9ff90a7..8629178 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -931,12 +931,6 @@ void __init omap1_clk_late_init(void)
 {
 	unsigned long rate = ck_dpll1.rate;
 
-	if (rate >= OMAP1_DPLL1_SANE_VALUE)
-		return;
-
-	/* System booting at unusable rate, force reprogramming of DPLL1 */
-	ck_dpll1_p->rate = 0;
-
 	/* Find the highest supported frequency and enable it */
 	if (omap1_select_table_rate(&virtual_ck_mpu, ~0)) {
 		pr_err("System frequencies not set, using default. Check your config.\n");
-- 
1.7.3.4

