From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv3 14/17] dmtimer pm_runtime support
Date: Tue, 21 Sep 2010 14:25:47 +0530
Message-ID: <1285059347-26643-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43132 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab0ITVyy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 17:54:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Partha Basak <p-basak2@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch adds pm_runtime support to dmtimer.
Since dmtimer is used during early boot before
pm_runtime is initialized completely there are
provisions to enable / disable clocks directly
in the code during early boot.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |   69 +++++++++++++++++++++++++++++-------------
 1 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 360a751..9da527f 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -351,18 +351,28 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 	struct clk *timer_clk;
 
 	if (timer->enabled)
 		return;
 
-	timer_clk = clk_get(&timer->pdev->dev, "fck");
-	if (IS_ERR(timer_clk)) {
-		dev_err(&timer->pdev->dev,
-		"ERROR: no clk pointer to enable\n");
-		return;
-	} else
-		clk_enable(timer_clk);
+	if (unlikely(pdata->is_early_init)) {
+		timer_clk = clk_get(&timer->pdev->dev, "fck");
+		if (IS_ERR(timer_clk)) {
+			dev_err(&timer->pdev->dev,
+			"ERROR: no clk pointer to enable\n");
+			return;
+		} else
+			clk_enable(timer_clk);
+	} else {
+		if (pm_runtime_get_sync(&timer->pdev->dev)) {
+			dev_warn(&timer->pdev->dev,
+			"%s: pm_runtime_get_sync FAILED\n",
+			__func__);
+			return;
+		}
+	}
 
 	timer->enabled = 1;
 }
@@ -370,18 +380,28 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 	struct clk *timer_clk;
 
 	if (!timer->enabled)
 		return;
 
-	timer_clk = clk_get(&timer->pdev->dev, "fck");
-	if (IS_ERR(timer_clk)) {
-		dev_err(&timer->pdev->dev,
-		"ERROR: no clk pointer to disable\n");
-		return;
-	} else
-		clk_disable(timer_clk);
+	if (unlikely(pdata->is_early_init)) {
+		timer_clk = clk_get(&timer->pdev->dev, "fck");
+		if (IS_ERR(timer_clk)) {
+			dev_err(&timer->pdev->dev,
+			"ERROR: no clk pointer to disable\n");
+			return;
+		} else
+			clk_disable(timer_clk);
+	} else {
+		if (pm_runtime_put_sync(&timer->pdev->dev)) {
+			dev_warn(&timer->pdev->dev,
+			"%s: pm_runtime_put_sync FAILED\n",
+			__func__);
+			return;
+		}
+	}
 
 	timer->enabled = 0;
 }
@@ -503,13 +523,20 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (source < 0 || source >= NR_CLK_SOURCES)
 		return -EINVAL;
 
-	timer_clk = clk_get(&timer->pdev->dev, "fck");
-	if (IS_ERR(timer_clk)) {
-		dev_err(&timer->pdev->dev,
-		"ERROR: no clk pointer to disable\n");
-		return -EINVAL;
-	} else
-		clk_disable(timer_clk); /* enabled in hwmod */
+	if (unlikely(pdata->is_early_init)) {
+		timer_clk = clk_get(&timer->pdev->dev, "fck");
+		if (IS_ERR(timer_clk)) {
+			dev_err(&timer->pdev->dev,
+			"ERROR: no clk pointer to disable\n");
+			return -EINVAL;
+		} else
+			clk_disable(timer_clk); /* enabled in hwmod */
+	} else {
+		if (pm_runtime_put_sync(&timer->pdev->dev))
+			dev_warn(&timer->pdev->dev,
+			"%s: pm_runtime_put_sync FAILED\n",
+			__func__);
+	}
 
 	/*
 	 * change the timer clock source and
-- 
1.6.0.4

