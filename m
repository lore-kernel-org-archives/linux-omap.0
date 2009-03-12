From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 61/86] [ARM] OMAP2/3 clock: clean up mach-omap2/clock.c
Date: Thu, 12 Mar 2009 11:28:11 -0700
Message-ID: <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbZCLSdB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:33:01 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:32:59 -0700 (PDT)
In-Reply-To: <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

This patch rolls up several cleanup patches.

1. Some unnecessarily verbose variable names are used in several clock.c
functions; clean these up per CodingStyle.

2. Remove omap2_get_clksel() and just use clk->clksel_reg and
clk->clksel_mask directly.

3. Get rid of void __iomem * usage in omap2_clksel_get_src_field.
Prepend the function name with an underscore to highlight that it is a
static function.

linux-omap source commits are 7fa95e007ea2f3c4d0ecd2779d809756e7775894,
af0ea23f1ee4a5bea3b026e38761b47089f9048a, and
91c0c979b47c44b08f80e4f8d4c990fb158d82c4.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c |   98 +++++++++++++++---------------------------
 1 files changed, 35 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 752e347..5d7d4c5 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -298,7 +298,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
 
 static int omap2_dflt_clk_enable(struct clk *clk)
 {
-	u32 regval32;
+	u32 v;
 
 	if (unlikely(clk->enable_reg == NULL)) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
@@ -306,12 +306,12 @@ static int omap2_dflt_clk_enable(struct clk *clk)
 		return 0; /* REVISIT: -EINVAL */
 	}
 
-	regval32 = __raw_readl(clk->enable_reg);
+	v = __raw_readl(clk->enable_reg);
 	if (clk->flags & INVERT_ENABLE)
-		regval32 &= ~(1 << clk->enable_bit);
+		v &= ~(1 << clk->enable_bit);
 	else
-		regval32 |= (1 << clk->enable_bit);
-	__raw_writel(regval32, clk->enable_reg);
+		v |= (1 << clk->enable_bit);
+	__raw_writel(v, clk->enable_reg);
 	wmb();
 
 	return 0;
@@ -335,7 +335,7 @@ static int omap2_dflt_clk_enable_wait(struct clk *clk)
 
 static void omap2_dflt_clk_disable(struct clk *clk)
 {
-	u32 regval32;
+	u32 v;
 
 	if (!clk->enable_reg) {
 		/*
@@ -347,12 +347,12 @@ static void omap2_dflt_clk_disable(struct clk *clk)
 		return;
 	}
 
-	regval32 = __raw_readl(clk->enable_reg);
+	v = __raw_readl(clk->enable_reg);
 	if (clk->flags & INVERT_ENABLE)
-		regval32 |= (1 << clk->enable_bit);
+		v |= (1 << clk->enable_bit);
 	else
-		regval32 &= ~(1 << clk->enable_bit);
-	__raw_writel(regval32, clk->enable_reg);
+		v &= ~(1 << clk->enable_bit);
+	__raw_writel(v, clk->enable_reg);
 	wmb();
 }
 
@@ -644,23 +644,6 @@ u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
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
-	if (!clk->clksel_reg || (clk->clksel_mask == 0))
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
@@ -668,40 +651,36 @@ static void __iomem *omap2_get_clksel(struct clk *clk, u32 *field_mask)
  */
 u32 omap2_clksel_get_divisor(struct clk *clk)
 {
-	u32 field_mask, field_val;
-	void __iomem *div_addr;
+	u32 v;
 
-	div_addr = omap2_get_clksel(clk, &field_mask);
-	if (!div_addr)
+	if (!clk->clksel_mask)
 		return 0;
 
-	field_val = __raw_readl(div_addr) & field_mask;
-	field_val >>= __ffs(field_mask);
+	v = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
+	v >>= __ffs(clk->clksel_mask);
 
-	return omap2_clksel_to_divisor(clk, field_val);
+	return omap2_clksel_to_divisor(clk, v);
 }
 
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 {
-	u32 field_mask, field_val, reg_val, validrate, new_div = 0;
-	void __iomem *div_addr;
+	u32 v, field_val, validrate, new_div = 0;
 
-	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
-	if (validrate != rate)
+	if (!clk->clksel_mask)
 		return -EINVAL;
 
-	div_addr = omap2_get_clksel(clk, &field_mask);
-	if (!div_addr)
+	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
+	if (validrate != rate)
 		return -EINVAL;
 
 	field_val = omap2_divisor_to_clksel(clk, new_div);
 	if (field_val == ~0)
 		return -EINVAL;
 
-	reg_val = __raw_readl(div_addr);
-	reg_val &= ~field_mask;
-	reg_val |= (field_val << __ffs(field_mask));
-	__raw_writel(reg_val, div_addr);
+	v = __raw_readl(clk->clksel_reg);
+	v &= ~clk->clksel_mask;
+	v |= field_val << __ffs(clk->clksel_mask);
+	__raw_writel(v, clk->clksel_reg);
 	wmb();
 
 	clk->rate = clk->parent->rate / new_div;
@@ -737,18 +716,14 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
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
@@ -768,17 +743,14 @@ static u32 omap2_clksel_get_src_field(void __iomem **src_addr,
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
-	u32 field_val, field_mask, reg_val, parent_div;
+	u32 field_val, v, parent_div;
 
 	if (clk->flags & CONFIG_PARTICIPANT)
 		return -EINVAL;
@@ -786,18 +758,18 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	if (!clk->clksel)
 		return -EINVAL;
 
-	field_val = omap2_clksel_get_src_field(&src_addr, new_parent,
-					       &field_mask, clk, &parent_div);
-	if (!src_addr)
+	parent_div = _omap2_clksel_get_src_field(new_parent, clk, &field_val);
+	if (!parent_div)
 		return -EINVAL;
 
 	if (clk->usecount > 0)
 		_omap2_clk_disable(clk);
 
 	/* Set new source value (previous dividers if any in effect) */
-	reg_val = __raw_readl(src_addr) & ~field_mask;
-	reg_val |= (field_val << __ffs(field_mask));
-	__raw_writel(reg_val, src_addr);
+	v = __raw_readl(clk->clksel_reg);
+	v &= ~clk->clksel_mask;
+	v |= field_val << __ffs(clk->clksel_mask);
+	__raw_writel(v, clk->clksel_reg);
 	wmb();
 
 	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
-- 
1.6.1.2

