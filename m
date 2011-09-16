From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH v3 3/6] OMAP3+: use DPLL's round_rate when setting rate
Date: Fri, 16 Sep 2011 12:48:01 -0500
Message-ID: <1316195281-14988-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34714 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab1IPRsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 13:48:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Mike Turquette <mturquette@ti.com>

omap3_noncore_dpll_set_rate uses omap2_dpll_round_rate explicitly.  Instead
use the struct clk pointer's round_rate function to allow for DPLL's with
special needs.

Also the rounded rate can differ from target rate, so to better reflect
reality set clk->rate equal to the rounded rate when setting DPLL frequency.
This avoids issues where the DPLL frequency is slightly different than what
debugfs clock tree reports using the old target rate.

An example of both of these needs is DPLL_ABE on OMAP4 which can have a 4x
multiplier on top of the usual MN dividers depending on register settings.
This requires a special round_rate function that might yield a rate
different from the initial target.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f77022b..73a1595 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -455,7 +455,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 			new_parent = dd->clk_bypass;
 	} else {
 		if (dd->last_rounded_rate != rate)
-			omap2_dpll_round_rate(clk, rate);
+			rate = clk->round_rate(clk, rate);
 
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
-- 
1.7.4.1

