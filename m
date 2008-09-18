From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 09/11] OMAP2/3 clock: remove omap2_get_clksel()
Date: Thu, 18 Sep 2008 11:47:18 -0600
Message-ID: <20080918174715.7146.87010.stgit@localhost.localdomain>
References: <20080918174432.7146.21366.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55124 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313AbYIRRsK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 13:48:10 -0400
In-Reply-To: <20080918174432.7146.21366.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Remove omap2_get_clksel() and just use clk->clksel_reg and
clk->clksel_mask directly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   46 +++++++++++--------------------------------
 1 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index b2478b7..062c034 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -727,23 +727,6 @@ u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
 }
 
 /**
- * omap2_get_clksel - find clksel register addr & field mask for a clk
- * @clk: struct clk to use
- * @field_mask: ptr to u32 to store the register field mask
- *
- * Returns the address of the clksel register upon success or NULL on error.
- */
-static void __iomem *omap2_get_clksel(struct clk *clk, u32 *field_mask)
-{
-	if (unlikely((clk->clksel_reg == NULL) || (clk->clksel_mask == NULL)))
-		return NULL;
-
-	*field_mask = clk->clksel_mask;
-
-	return clk->clksel_reg;
-}
-
-/**
  * omap2_clksel_get_divisor - get current divider applied to parent clock.
  * @clk: OMAP struct clk to use.
  *
@@ -751,41 +734,36 @@ static void __iomem *omap2_get_clksel(struct clk *clk, u32 *field_mask)
  */
 u32 omap2_clksel_get_divisor(struct clk *clk)
 {
-	u32 field_mask, v;
-	void __iomem *div_addr;
+	u32 v;
 
-	div_addr = omap2_get_clksel(clk, &field_mask);
-	if (div_addr == NULL)
+	if (!clk->clksel_mask)
 		return 0;
 
-	v = __raw_readl(div_addr) & field_mask;
-	v >>= __ffs(field_mask);
+	v = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
+	v >>= __ffs(clk->clksel_mask);
 
 	return omap2_clksel_to_divisor(clk, v);
 }
 
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 {
-	u32 field_mask, field_val, validrate, new_div = 0;
-	void __iomem *div_addr;
-	u32 v;
+	u32 v, field_val, validrate, new_div = 0;
 
-	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
-	if (validrate != rate)
+	if (!clk->clksel_mask)
 		return -EINVAL;
 
-	div_addr = omap2_get_clksel(clk, &field_mask);
-	if (div_addr == NULL)
+	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
+	if (validrate != rate)
 		return -EINVAL;
 
 	field_val = omap2_divisor_to_clksel(clk, new_div);
 	if (field_val == ~0)
 		return -EINVAL;
 
-	v = __raw_readl(div_addr);
-	v &= ~field_mask;
-	v |= field_val << __ffs(field_mask);
-	__raw_writel(v, div_addr);
+	v = __raw_readl(clk->clksel_reg);
+	v &= ~clk->clksel_mask;
+	v |= field_val << __ffs(clk->clksel_mask);
+	__raw_writel(v, clk->clksel_reg);
 
 	wmb();
 


