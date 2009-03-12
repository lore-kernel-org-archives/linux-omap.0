From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 54/86] [ARM] OMAP3 clock: fix DPLL jitter correction and rate programming
Date: Thu, 12 Mar 2009 11:28:04 -0700
Message-ID: <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768AbZCLScd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:32:33 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:32:32 -0700 (PDT)
In-Reply-To: <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Fix DPLL jitter correction programming.  Previously,
omap3_noncore_dpll_program() stored the FREQSEL jitter correction
parameter to the wrong register.  This caused jitter correction to be set
incorrectly and also caused the DPLL divider to be programmed incorrectly.

Also, fix DPLL divider programming.  An off-by-one error existed in
omap3_noncore_dpll_program(), causing DPLLs to be programmed with a higher
divider than intended.

linux-omap source commit is 5c0ec88a2145cdf2f2c9cc5fae49635c4c2476c7.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock34xx.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index cb5e068..fdfc7d5 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -563,14 +563,17 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
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
-- 
1.6.1.2

