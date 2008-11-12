From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Wait until DPLL1 is relocked.
Date: Wed, 12 Nov 2008 18:54:11 +0200
Message-ID: <1226508851-18663-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32846 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbYKLQyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 11:54:19 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mACGsD5i032256
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 18:54:16 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch causes _omap3_noncore_dpll_lock to wait for clocks marked as
WAIT_READY to be ready before continuing. This is necessary for MPU/DSP
DVFS to work correctly.

Cheers,

Peter.

---
 arch/arm/mach-omap2/clock34xx.c |   19 ++++++++-----------
 arch/arm/mach-omap2/clock34xx.h |    2 +-
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 634278a..f700139 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
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

