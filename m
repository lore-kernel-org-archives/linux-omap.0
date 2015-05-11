From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 26/27] ARM: OMAP2+: clock: remove legacy omap2_clk_readl/writel APIs
Date: Mon, 11 May 2015 11:54:52 +0300
Message-ID: <1431334493-24455-27-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45787 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329AbbEKIzy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 04:55:54 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

As most of the clock driver code has migrated, these are no longer used
for anything. Thus remove these APIs completely.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   16 ----------------
 arch/arm/mach-omap2/clock.h |    3 ---
 2 files changed, 19 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 40a88c2..79cec5f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -87,22 +87,6 @@ static u32 clk_memmap_readl(void __iomem *reg)
 	return val;
 }
 
-void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
-{
-	if (WARN_ON_ONCE(!(clk->flags & MEMMAP_ADDRESSING)))
-		writel_relaxed(val, reg);
-	else
-		clk_memmap_writel(val, reg);
-}
-
-u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
-{
-	if (WARN_ON_ONCE(!(clk->flags & MEMMAP_ADDRESSING)))
-		return readl_relaxed(reg);
-	else
-		return clk_memmap_readl(reg);
-}
-
 static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clk_readl = clk_memmap_readl,
 	.clk_writel = clk_memmap_writel,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index a7051d6..f3dc04c 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -68,9 +68,6 @@ void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
 			       const char *mpu_ck_name);
 
-u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg);
-void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg);
-
 extern u16 cpu_mask;
 
 extern const struct clkops clkops_omap2_dflt_wait;
-- 
1.7.9.5

