From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 5/7] OMAP3 clock: omap3_clkoutx2_recalc() should test DPLL
	IDLEST to determine if DPLL is bypassed
Date: Thu, 18 Sep 2008 10:30:28 -0600
Message-ID: <20080918163024.9452.42914.stgit@localhost.localdomain>
References: <20080918162835.9452.71873.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58244 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbYIRQ4V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 12:56:21 -0400
In-Reply-To: <20080918162835.9452.71873.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Convert the DPLL bypass test in omap3_clkoutx2_recalc() to test DPLL IDLEST
bits rather than the CM_CLKEN register.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index c5765bf..6963f2e 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -577,11 +577,10 @@ static void omap3_clkoutx2_recalc(struct clk *clk)
 
 	dd = pclk->dpll_data;
 
-	WARN_ON(!dd->control_reg || !dd->enable_mask);
+	WARN_ON(!dd->idlest_reg || !dd->idlest_mask);
 
-	v = __raw_readl(dd->control_reg) & dd->enable_mask;
-	v >>= __ffs(dd->enable_mask);
-	if (v != DPLL_LOCKED)
+	v = __raw_readl(dd->idlest_reg) & dd->idlest_mask;
+	if (!v)
 		clk->rate = clk->parent->rate;
 	else
 		clk->rate = clk->parent->rate * 2;


