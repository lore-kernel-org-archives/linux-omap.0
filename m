From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 clock: put DPLL into bypass if bypass rate = clk->rate,
 not hardware rate
Date: Thu, 25 Sep 2008 08:38:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0809250837350.14535@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44855 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbYIYOir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 10:38:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tero.kristo@nokia.com, rnayak@ti.com


When a non-CORE DPLL is enabled via omap3_noncore_dpll_enable(), use
the user's desired rate in clk->rate to determine whether to put the
DPLL into bypass or lock mode, rather than reading the DPLL's current
idle state from its hardware registers.

This fixes a bug observed when leaving retention. Non-CORE DPLLs were
not being relocked when downstream clocks re-enabled; rather, the DPLL
entered bypass mode.

Problem reported by Tero Kristo <tero.kristo@nokia.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index c89d6bc..df258f7 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -281,9 +281,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 	if (!dd)
 		return -EINVAL;
 
-	rate = omap2_get_dpll_rate(clk);
-
-	if (dd->bypass_clk->rate == rate)
+	if (clk->rate == dd->bypass_clk->rate)
 		r = _omap3_noncore_dpll_bypass(clk);
 	else
 		r = _omap3_noncore_dpll_lock(clk);
