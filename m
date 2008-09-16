From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/6] OMAP3 clock: recalculate DPLL subtree after bypass
	entry/exit
Date: Tue, 16 Sep 2008 06:16:55 -0600
Message-ID: <20080916121650.4666.40964.stgit@localhost.localdomain>
References: <20080916121521.4666.61245.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58349 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbYIPMRl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:17:41 -0400
In-Reply-To: <20080916121521.4666.61245.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

The DPLL's rate changes when it enters or leaves bypass, so the DPLL's
rate and the rates of all dependent clocks need to be recalculated
when this happens.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index a2b8d1e..6dbaac6 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -180,7 +180,7 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
 }
 
 /*
- * omap3_noncore_dpll_bypass - instruct a DPLL to bypass and wait for readiness
+ * _omap3_noncore_dpll_bypass - instruct a DPLL to bypass and wait for readiness
  * @clk: pointer to a DPLL struct clk
  *
  * Instructs a non-CORE DPLL to enter low-power bypass mode.  In
@@ -270,15 +270,21 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 static int omap3_noncore_dpll_enable(struct clk *clk)
 {
 	int r;
+	long rate;
 
 	if (clk == &dpll3_ck)
 		return -EINVAL;
 
-	if (clk->parent->rate == omap2_get_dpll_rate(clk))
+	rate = omap2_get_dpll_rate(clk);
+
+	if (clk->parent->rate == rate)
 		r = _omap3_noncore_dpll_bypass(clk);
 	else
 		r = _omap3_noncore_dpll_lock(clk);
 
+	if (!r)
+		clk->rate = rate;
+
 	return r;
 }
 
@@ -397,6 +403,8 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
 
 		ret = _omap3_noncore_dpll_bypass(clk);
+		if (!ret)
+			clk->rate = rate;
 
 	} else {
 


