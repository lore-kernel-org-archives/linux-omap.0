From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 12/13] ARM: OMAP: Remove unnecessary call to clk_get()
Date: Mon, 12 Nov 2012 12:20:43 -0600
Message-ID: <1352744444-2633-13-git-send-email-jon-hunter@ti.com>
References: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54565 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab2KLSVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 13:21:08 -0500
In-Reply-To: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Whenever we call the function omap_dm_timer_set_source() to set the clock
source of a dmtimer we look-up the dmtimer functional clock source by
calling clk_get(). This is not necessary because on requesting a dmtimer
we look-up the functional clock source and store it in the omap_dm_timer
structure. So instead of looking up the clock again used the clock handle
that stored in the omap_dm_timer structure.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index b4e6634..305faf5 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -448,7 +448,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret;
 	char *parent_name = NULL;
-	struct clk *fclk, *parent;
+	struct clk *parent;
 	struct dmtimer_platform_data *pdata;
 
 	if (unlikely(!timer))
@@ -467,11 +467,8 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (pdata && pdata->set_timer_src)
 		return pdata->set_timer_src(timer->pdev, source);
 
-	fclk = clk_get(&timer->pdev->dev, "fck");
-	if (IS_ERR_OR_NULL(fclk)) {
-		pr_err("%s: fck not found\n", __func__);
+	if (!timer->fclk)
 		return -EINVAL;
-	}
 
 	switch (source) {
 	case OMAP_TIMER_SRC_SYS_CLK:
@@ -490,18 +487,15 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	parent = clk_get(&timer->pdev->dev, parent_name);
 	if (IS_ERR_OR_NULL(parent)) {
 		pr_err("%s: %s not found\n", __func__, parent_name);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
-	ret = clk_set_parent(fclk, parent);
+	ret = clk_set_parent(timer->fclk, parent);
 	if (IS_ERR_VALUE(ret))
 		pr_err("%s: failed to set %s as parent\n", __func__,
 			parent_name);
 
 	clk_put(parent);
-out:
-	clk_put(fclk);
 
 	return ret;
 }
-- 
1.7.9.5

