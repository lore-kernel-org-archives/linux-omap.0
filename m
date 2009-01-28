From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH C 07/13] OMAP3 clock: recalculate DPLL subtree after bypass
	entry/exit
Date: Wed, 28 Jan 2009 12:08:29 -0700
Message-ID: <20090128190826.12092.12778.stgit@localhost.localdomain>
References: <20090128190724.12092.22239.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60419 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbZA1UZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:25:19 -0500
In-Reply-To: <20090128190724.12092.22239.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

The DPLL's rate changes when it enters or leaves bypass, so the DPLL's
rate and the rates of all dependent clocks need to be recalculated
when this happens.

Also, fix test for bypass to test against the appropriate bypass clock,
rather than the parent clock (which is not the bypass clock for DPLL1
and DPLL2).

linux-omap source commit is 5c6497bc6f4d2d629efa2bcfa6486539e4b5a797.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock34xx.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 0f058c3..844fe82 100644
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
@@ -270,15 +270,26 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 static int omap3_noncore_dpll_enable(struct clk *clk)
 {
 	int r;
+	long rate;
+	struct dpll_data *dd;
 
 	if (clk == &dpll3_ck)
 		return -EINVAL;
 
-	if (clk->parent->rate == omap2_get_dpll_rate(clk))
+	dd = clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	rate = omap2_get_dpll_rate(clk);
+
+	if (dd->bypass_clk->rate == rate)
 		r = _omap3_noncore_dpll_bypass(clk);
 	else
 		r = _omap3_noncore_dpll_lock(clk);
 
+	if (!r)
+		clk->rate = rate;
+
 	return r;
 }
 
@@ -399,6 +410,8 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		pr_debug("clock: %s: set rate: entering bypass.\n", clk->name);
 
 		ret = _omap3_noncore_dpll_bypass(clk);
+		if (!ret)
+			clk->rate = rate;
 
 	} else {
 


