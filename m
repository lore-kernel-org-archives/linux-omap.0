From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [Resending PATCH] Wait until DPLL1 is relocked. Re
Date: Wed, 12 Nov 2008 19:17:40 +0200
Message-ID: <1226510260-20096-1-git-send-email-peter.de-schrijver@nokia.com>
References: <alpine.DEB.2.00.0811121007550.8505@utopia.booyaka.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36458 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbYKLRSD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 12:18:03 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mACHHFsm005171
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 11:17:59 -0600
In-Reply-To: <alpine.DEB.2.00.0811121007550.8505@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

I forgot the signoff. Fixed now.

This patch causes _omap3_noncore_dpll_lock to wait for clocks marked as
WAIT_READY to be ready before continuing. This is necessary for MPU/DSP
DVFS to work correctly.

Cheers,

Peter.


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c |   19 ++++++++-----------
 arch/arm/mach-omap2/clock34xx.h |    2 +-
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 634278a..f700139 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -122,8 +122,10 @@ static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
 	}
 
 	if (i == MAX_DPLL_WAIT_TRIES) {
-		printk(KERN_ERR "clock: %s failed transition to '%s'\n",
-		       clk->name, (state) ? "locked" : "bypassed");
+		printk(KERN_DEBUG "clock: %s failed transition to '%s'\n",
+			clk->name, (state) ? "locked" : "bypassed");
+		pr_debug("clock: %s m: %d n: %d\n",
+			clk->name, clk->dpll_data->last_rounded_m, clk->dpll_data->last_rounded_n);
 	} else {
 		pr_debug("clock: %s transition to '%s' in %d loops\n",
 			 clk->name, (state) ? "locked" : "bypassed", i);
@@ -185,7 +187,7 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
 static int _omap3_noncore_dpll_lock(struct clk *clk)
 {
 	u8 ai;
-	int r;
+	int r = 0;
 
 	if (clk == &dpll3_ck)
 		return -EINVAL;
@@ -196,15 +198,16 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
 
 	_omap3_dpll_write_clken(clk, DPLL_LOCKED);
 
+	if (!ai || (clk->flags & WAIT_READY))
+		r = _omap3_wait_dpll_status(clk, 1);
+
 	if (ai) {
 		/*
 		 * If no downstream clocks are enabled, CM_IDLEST bit
 		 * may never become active, so don't wait for DPLL to lock.
 		 */
-		r = 0;
 		omap3_dpll_allow_idle(clk);
 	} else {
-		r = _omap3_wait_dpll_status(clk, 1);
 		omap3_dpll_deny_idle(clk);
 	};
 
@@ -406,12 +409,6 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 
 	_omap3_noncore_dpll_lock(clk);
 
-	/* fix somehow */
-
-	udelay(230);
-
-//pr_err("omap2_get_dpll_rate: %u\n",omap2_get_dpll_rate(clk));
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index f3eda8a..8a2bd85 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -305,7 +305,7 @@ static struct clk dpll1_ck = {
 	.parent		= &sys_ck,
 	.prcm_mod	= MPU_MOD,
 	.dpll_data	= &dpll1_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED | WAIT_READY,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.clkdm		= { .name = "dpll1_clkdm" },
-- 
1.5.6.3

