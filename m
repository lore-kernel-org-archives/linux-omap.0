From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/5] ARM: OMAP2+: Remove omap2_clk_set_parent function
Date: Tue, 22 May 2012 15:17:34 -0500
Message-ID: <1337717854-20608-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60133 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932334Ab2EVURg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 16:17:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tarun Kanti <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

The function omap2_clk_set_parent is just a wrapper for the
omap_clksel_set_parent() function. Now we have moved the
omap_clksel_set_parent() function into the plat-omap directory for all OMAP
devices to use, we should just use this function directly and we can eliminate
the OMAP2 function.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clock.c      |   13 +------------
 arch/arm/plat-omap/clkt_clksel.c |    3 +++
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 2049cb2..b17d539 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -385,17 +385,6 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 	return ret;
 }
 
-int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
-{
-	if (!clk->clksel)
-		return -EINVAL;
-
-	if (clk->parent == new_parent)
-		return 0;
-
-	return omap_clksel_set_parent(clk, new_parent);
-}
-
 /* OMAP3/4 non-CORE DPLL clkops */
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
@@ -532,7 +521,7 @@ struct clk_functions omap2_clk_functions = {
 	.clk_disable		= omap2_clk_disable,
 	.clk_round_rate		= omap2_clk_round_rate,
 	.clk_set_rate		= omap2_clk_set_rate,
-	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_set_parent		= omap_clksel_set_parent,
 	.clk_disable_unused	= omap2_clk_disable_unused,
 };
 
diff --git a/arch/arm/plat-omap/clkt_clksel.c b/arch/arm/plat-omap/clkt_clksel.c
index 85622f8..e47b704 100644
--- a/arch/arm/plat-omap/clkt_clksel.c
+++ b/arch/arm/plat-omap/clkt_clksel.c
@@ -484,6 +484,9 @@ int omap_clksel_set_parent(struct clk *clk, struct clk *new_parent)
 	if (!clk->clksel || !clk->clksel_mask)
 		return -EINVAL;
 
+	if (clk->parent == new_parent)
+		return 0;
+
 	parent_div = _get_div_and_fieldval(new_parent, clk, &field_val);
 	if (!parent_div)
 		return -EINVAL;
-- 
1.7.9.5

