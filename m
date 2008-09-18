From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 10/11] OMAP2/3 clock: simplify omap2_clksel_get_src_field()
Date: Thu, 18 Sep 2008 11:47:21 -0600
Message-ID: <20080918174718.7146.88883.stgit@localhost.localdomain>
References: <20080918174432.7146.21366.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55122 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285AbYIRRsK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 13:48:10 -0400
In-Reply-To: <20080918174432.7146.21366.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Get rid of void __iomem * usage in omap2_clksel_get_src_field.
Prepend the function name with an underscore to highlight that it is a
static function.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 062c034..621babc 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -803,18 +803,14 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
 /*
  * Converts encoded control register address into a full address
- * On error, *src_addr will be returned as 0.
+ * On error, the return value (parent_div) will be 0.
  */
-static u32 omap2_clksel_get_src_field(void __iomem **src_addr,
-				      struct clk *src_clk, u32 *field_mask,
-				      struct clk *clk, u32 *parent_div)
+static u32 _omap2_clksel_get_src_field(struct clk *src_clk, struct clk *clk,
+				       u32 *field_val)
 {
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
 
-	*parent_div = 0;
-	*src_addr = NULL;
-
 	clks = omap2_get_clksel_by_parent(clk, src_clk);
 	if (!clks)
 		return 0;
@@ -834,17 +830,14 @@ static u32 omap2_clksel_get_src_field(void __iomem **src_addr,
 	/* Should never happen.  Add a clksel mask to the struct clk. */
 	WARN_ON(clk->clksel_mask == 0);
 
-	*field_mask = clk->clksel_mask;
-	*src_addr = clk->clksel_reg;
-	*parent_div = clkr->div;
+	*field_val = clkr->val;
 
-	return clkr->val;
+	return clkr->div;
 }
 
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
-	void __iomem *src_addr;
-	u32 field_val, field_mask, v, parent_div;
+	u32 field_val, v, parent_div;
 
 	if (clk->flags & CONFIG_PARTICIPANT)
 		return -EINVAL;
@@ -852,18 +845,18 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	if (!clk->clksel)
 		return -EINVAL;
 
-	field_val = omap2_clksel_get_src_field(&src_addr, new_parent,
-					       &field_mask, clk, &parent_div);
-	if (src_addr == NULL)
+	parent_div = _omap2_clksel_get_src_field(new_parent, clk, &field_val);
+	if (!parent_div)
 		return -EINVAL;
 
 	if (clk->usecount > 0)
 		_omap2_clk_disable(clk);
 
 	/* Set new source value (previous dividers if any in effect) */
-	v = __raw_readl(src_addr) & ~field_mask;
-	v |= (field_val << __ffs(field_mask));
-	__raw_writel(v, src_addr);
+	v = __raw_readl(clk->clksel_reg);
+	v &= ~clk->clksel_mask;
+	v |= field_val << __ffs(clk->clksel_mask);
+	__raw_writel(v, clk->clksel_reg);
 	wmb();
 
 	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {


