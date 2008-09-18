From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 02/11] OMAP2/3 clock: shorten some variable names in
	clock.c for legibility
Date: Thu, 18 Sep 2008 11:46:57 -0600
Message-ID: <20080918174654.7146.58094.stgit@localhost.localdomain>
References: <20080918174432.7146.21366.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55096 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbYIRRsH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 13:48:07 -0400
In-Reply-To: <20080918174432.7146.21366.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Some unnecessarily verbose variable names are used in several clock.c
functions; clean these up per CodingStyle.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 16cedb2..56065aa 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -219,8 +219,7 @@ void omap2_fixed_divisor_recalc(struct clk *clk)
  */
 int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
 {
-	int i = 0;
-	int ena = 0;
+	int i = 0, ena = 0;
 
 	/*
 	 * 24xx uses 0 to indicate not ready, and 1 to indicate ready.
@@ -351,7 +350,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
  */
 static int _omap2_clk_enable(struct clk *clk)
 {
-	u32 regval32;
+	u32 v;
 
 	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return 0;
@@ -365,12 +364,12 @@ static int _omap2_clk_enable(struct clk *clk)
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
 
 	omap2_clk_wait_ready(clk);
@@ -381,7 +380,7 @@ static int _omap2_clk_enable(struct clk *clk)
 /* Disables clock without considering parent dependencies or use count */
 static void _omap2_clk_disable(struct clk *clk)
 {
-	u32 regval32;
+	u32 v;
 
 	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return;
@@ -401,12 +400,12 @@ static void _omap2_clk_disable(struct clk *clk)
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
 
@@ -701,17 +700,17 @@ static void __iomem *omap2_get_clksel(struct clk *clk, u32 *field_mask)
  */
 u32 omap2_clksel_get_divisor(struct clk *clk)
 {
-	u32 field_mask, field_val;
+	u32 field_mask, v;
 	void __iomem *div_addr;
 
 	div_addr = omap2_get_clksel(clk, &field_mask);
 	if (div_addr == NULL)
 		return 0;
 
-	field_val = __raw_readl(div_addr) & field_mask;
-	field_val >>= __ffs(field_mask);
+	v = __raw_readl(div_addr) & field_mask;
+	v >>= __ffs(field_mask);
 
-	return omap2_clksel_to_divisor(clk, field_val);
+	return omap2_clksel_to_divisor(clk, v);
 }
 
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
@@ -816,7 +815,7 @@ static u32 omap2_clksel_get_src_field(void __iomem **src_addr,
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
 	void __iomem *src_addr;
-	u32 field_val, field_mask, reg_val, parent_div;
+	u32 field_val, field_mask, v, parent_div;
 
 	if (clk->flags & CONFIG_PARTICIPANT)
 		return -EINVAL;
@@ -833,9 +832,9 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 		_omap2_clk_disable(clk);
 
 	/* Set new source value (previous dividers if any in effect) */
-	reg_val = __raw_readl(src_addr) & ~field_mask;
-	reg_val |= (field_val << __ffs(field_mask));
-	__raw_writel(reg_val, src_addr);
+	v = __raw_readl(src_addr) & ~field_mask;
+	v |= (field_val << __ffs(field_mask));
+	__raw_writel(v, src_addr);
 	wmb();
 
 	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {


