From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH v2 4/6] OMAP3+: use DPLLs recalc function instead of omap2_get_dpll_rate
Date: Fri, 16 Sep 2011 12:48:21 -0500
Message-ID: <1316195301-15025-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42485 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755615Ab1IPRsf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 13:48:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

This is a continuation of Mike Turquette's patch "OMAP3+: use
DPLL's round_rate when setting rate".

omap3_noncore_dpll_set_rate() and omap3_noncore_dpll_enable() call
omap2_get_dpll_rate() explicitly. It may be necessary for some
DPLLs to use a different function and so use the DPLLs recalc()
function pointer instead.

An example is the DPLL_ABE on OMAP4 which can have a 4X multiplier
in addition to the usual MN multipler and dividers and therefore
uses a different round_rate and recalc function.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 73a1595..7916f66 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -390,7 +390,7 @@ int omap3_noncore_dpll_enable(struct clk *clk)
 	 * propagating?
 	 */
 	if (!r)
-		clk->rate = omap2_get_dpll_rate(clk);
+		clk->rate = clk->recalc(clk);
 
 	return r;
 }
@@ -435,7 +435,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	if (!dd)
 		return -EINVAL;
 
-	if (rate == omap2_get_dpll_rate(clk))
+	if (rate == clk->recalc(clk))
 		return 0;
 
 	/*
-- 
1.7.4.1

