From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 clock: fix DPLL jitter correction and rate
 programming
Date: Tue, 24 Jun 2008 01:11:21 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806240109440.9741@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44580 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbYFXHLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 03:11:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Fix DPLL jitter correction programming.  Previously, 
omap3_noncore_dpll_program() stored the FREQSEL jitter correction 
parameter to the wrong register.  This caused jitter correction to be set 
incorrectly and also caused the DPLL divider to be programmed incorrectly.

Also, fix DPLL divider programming.  An off-by-one error existed in 
omap3_noncore_dpll_program(), causing DPLLs to be programmed with a higher 
divider than intended.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock34xx.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 408b51a..8fdf8f3 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -346,14 +346,17 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
 	_omap3_noncore_dpll_bypass(clk);
 
+	/* Set jitter correction */
+	v = __raw_readl(dd->control_reg);
+	v &= ~dd->freqsel_mask;
+	v |= freqsel << __ffs(dd->freqsel_mask);
+	__raw_writel(v, dd->control_reg);
+
+	/* Set DPLL multiplier, divider */
 	v = __raw_readl(dd->mult_div1_reg);
 	v &= ~(dd->mult_mask | dd->div1_mask);
-
-	/* Set mult (M), div1 (N), freqsel */
 	v |= m << __ffs(dd->mult_mask);
-	v |= n << __ffs(dd->div1_mask);
-	v |= freqsel << __ffs(dd->freqsel_mask);
-
+	v |= (n - 1) << __ffs(dd->div1_mask);
 	__raw_writel(v, dd->mult_div1_reg);
 
 	/* We let the clock framework set the other output dividers later */
