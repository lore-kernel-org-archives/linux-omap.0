From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] OMAP2/3 clock: shorten some variable names in clock.c for
	legibility
Date: Tue, 16 Sep 2008 08:18:44 -0600
Message-ID: <20080916141843.13182.82339.stgit@localhost.localdomain>
References: <20080916141809.13182.31144.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54879 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYIPOUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 10:20:05 -0400
In-Reply-To: <20080916141809.13182.31144.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Some unnecessarily verbose variable names are used in several clock.c
functions; clean these up per CodingStyle.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index a2211fb..a604c38 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -351,7 +351,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
  */
 static int _omap2_clk_enable(struct clk *clk)
 {
-	u32 regval32;
+	u32 v;
 
 	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return 0;
@@ -365,11 +365,11 @@ static int _omap2_clk_enable(struct clk *clk)
 		return 0; /* REVISIT: -EINVAL */
 	}
 
-	regval32 = __raw_readl(clk->enable_reg);
+	v = __raw_readl(clk->enable_reg);
 	if (clk->flags & INVERT_ENABLE)
-		regval32 &= ~(1 << clk->enable_bit);
+		v &= ~(1 << clk->enable_bit);
 	else
-		regval32 |= (1 << clk->enable_bit);
+		v |= (1 << clk->enable_bit);
 	__raw_writel(regval32, clk->enable_reg);
 	wmb();
 
@@ -381,7 +381,7 @@ static int _omap2_clk_enable(struct clk *clk)
 /* Disables clock without considering parent dependencies or use count */
 static void _omap2_clk_disable(struct clk *clk)
 {
-	u32 regval32;
+	u32 v;
 
 	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return;
@@ -401,12 +401,12 @@ static void _omap2_clk_disable(struct clk *clk)
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
 


