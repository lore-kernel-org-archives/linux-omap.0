From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 clock: fix non-CORE DPLL rate assignment bugs
Date: Fri, 17 Oct 2008 16:18:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810171617420.3833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48429 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYJQWSo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 18:18:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, rick@efn.org, timo.t.kokkonen@nokia.com, sakari.poussa@nokia.com


Commit 8b1f0bd44fe490ec631230c8c040753a2bda8caa introduced a bug that
caused non-CORE DPLL rates to be incorrectly set on boot in
omap3_noncore_dpll_enable().  Debugged by Tomi Valkeinen
<tomi.valkeinen@nokia.com> - thanks Tomi.

Also fix omap3_noncore_dpll_set_rate() to assign clk->rate after a
DPLL reprogram.

Tested on 3430SDP.


Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Rick Bronson <rick@efn.org>
Cc: Timo Kokkonen <timo.t.kokkonen@nokia.com>
Cc: Sakari Poussa <sakari.poussa@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index df258f7..cc43f4f 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -271,7 +271,6 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 static int omap3_noncore_dpll_enable(struct clk *clk)
 {
 	int r;
-	long rate;
 	struct dpll_data *dd;
 
 	if (clk == &dpll3_ck)
@@ -287,7 +286,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 		r = _omap3_noncore_dpll_lock(clk);
 
 	if (!r)
-		clk->rate = rate;
+		clk->rate = omap2_get_dpll_rate(clk);
 
 	return r;
 }
@@ -430,6 +429,9 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		ret = omap3_noncore_dpll_program(clk, dd->last_rounded_m,
 						 dd->last_rounded_n, freqsel);
 
+		if (!ret)
+			clk->rate = rate;
+
 	}
 
 	omap3_dpll_recalc(clk);
