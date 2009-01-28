From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH C 09/13] OMAP3 clock: fix non-CORE DPLL rate assignment bugs
Date: Wed, 28 Jan 2009 12:08:35 -0700
Message-ID: <20090128190832.12092.37861.stgit@localhost.localdomain>
References: <20090128190724.12092.22239.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60471 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbZA1UZ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:25:26 -0500
In-Reply-To: <20090128190724.12092.22239.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Rick Bronson <rick@efn.org>, Timo Kokkonen <timo.t.kokkonen@nokia.com>, Sakari Poussa <sakari.poussa@nokia.com>, Tony Lindgren <tony@atomide.com>

Commit 8b1f0bd44fe490ec631230c8c040753a2bda8caa introduced a bug that
caused non-CORE DPLL rates to be incorrectly set on boot in
omap3_noncore_dpll_enable().  Debugged by Tomi Valkeinen
<tomi.valkeinen@nokia.com> - thanks Tomi.

Also fix omap3_noncore_dpll_set_rate() to assign clk->rate after a
DPLL reprogram.

Tested on 3430SDP.

linux-omap source commit is 2ac1da8c787f73f067e717408e631501ba60aabc.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Rick Bronson <rick@efn.org>
Cc: Timo Kokkonen <timo.t.kokkonen@nokia.com>
Cc: Sakari Poussa <sakari.poussa@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock34xx.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 424eed6..c943043 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -270,7 +270,6 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 static int omap3_noncore_dpll_enable(struct clk *clk)
 {
 	int r;
-	long rate;
 	struct dpll_data *dd;
 
 	if (clk == &dpll3_ck)
@@ -286,7 +285,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 		r = _omap3_noncore_dpll_lock(clk);
 
 	if (!r)
-		clk->rate = rate;
+		clk->rate = omap2_get_dpll_rate(clk);
 
 	return r;
 }
@@ -429,6 +428,9 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		ret = omap3_noncore_dpll_program(clk, dd->last_rounded_m,
 						 dd->last_rounded_n, freqsel);
 
+		if (!ret)
+			clk->rate = rate;
+
 	}
 
 	omap3_dpll_recalc(clk);


