From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] clock34xx.c: fix spinlock reentry in
 omap3_noncore_dpll_enable()
Date: Thu, 15 May 2008 14:48:20 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0805151445220.29298@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56403 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760970AbYEOUsV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 16:48:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


omap3_noncore_dpll_enable() calls clk_get_rate(), which causes an attempt 
to re-enter the clockfw_lock spinlock.  Fix by calling 
omap2_get_dpll_rate() instead.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 670c945..71357db 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -273,7 +273,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 	if (clk == &dpll3_ck)
 		return -EINVAL;
 
-	if (clk->parent->rate == clk_get_rate(clk))
+	if (clk->parent->rate == omap2_get_dpll_rate(clk))
 		r = _omap3_noncore_dpll_bypass(clk);
 	else
 		r = _omap3_noncore_dpll_lock(clk);
