From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: OMAP: dpll: enable bypass clock only when attempting dpll bypass
Date: Thu, 28 Mar 2013 16:29:41 +0530
Message-ID: <1364468381-10560-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50832 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214Ab3C1LAA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 07:00:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com, Rajendra Nayak <rnayak@ti.com>

omap3_noncore_dpll_set_rate() attempts an enable of bypass clk as well
as ref clk for every .set_rate attempt on a noncore DPLL, regardless of
whether the .set_rate results in the DPLL being locked or put in bypass.
Early at boot, while some of these DPLLs are programmed and locked
(using .set_rate for the DPLL), this causes an ordering issue.

For instance, on OMAP5, the USB DPLL derives its bypass clk from ABE DPLL.
If a .set_rate of USB DPLL which programmes the M,N and locks it is called
before the one for ABE, the enable of USB bypass clk (derived from ABE DPLL)
then attempts to lock the ABE DPLL and fails as the M,N values for ABE
are yet to be programmed.

To get rid of this ordering needs, enable bypass clk for a DPLL as part
of its .set_rate only when its being put in bypass, and only enable the
ref clk when its locked.

Reported-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 3aed4b0..6e9873f 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -480,20 +480,22 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!dd)
 		return -EINVAL;
 
-	__clk_prepare(dd->clk_bypass);
-	clk_enable(dd->clk_bypass);
-	__clk_prepare(dd->clk_ref);
-	clk_enable(dd->clk_ref);
-
 	if (__clk_get_rate(dd->clk_bypass) == rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
 		pr_debug("%s: %s: set rate: entering bypass.\n",
 			 __func__, __clk_get_name(hw->clk));
 
+		__clk_prepare(dd->clk_bypass);
+		clk_enable(dd->clk_bypass);
 		ret = _omap3_noncore_dpll_bypass(clk);
 		if (!ret)
 			new_parent = dd->clk_bypass;
+		clk_disable(dd->clk_bypass);
+		__clk_unprepare(dd->clk_bypass);
 	} else {
+		__clk_prepare(dd->clk_ref);
+		clk_enable(dd->clk_ref);
+
 		if (dd->last_rounded_rate != rate)
 			rate = __clk_round_rate(hw->clk, rate);
 
@@ -514,6 +516,8 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 		ret = omap3_noncore_dpll_program(clk, freqsel);
 		if (!ret)
 			new_parent = dd->clk_ref;
+		clk_disable(dd->clk_ref);
+		__clk_unprepare(dd->clk_ref);
 	}
 	/*
 	* FIXME - this is all wrong.  common code handles reparenting and
@@ -525,11 +529,6 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!ret)
 		__clk_reparent(hw->clk, new_parent);
 
-	clk_disable(dd->clk_ref);
-	__clk_unprepare(dd->clk_ref);
-	clk_disable(dd->clk_bypass);
-	__clk_unprepare(dd->clk_bypass);
-
 	return 0;
 }
 
-- 
1.7.9.5

