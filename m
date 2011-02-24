From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v11 7/8] OMAP: dmtimer: pm_runtime support
Date: Thu, 24 Feb 2011 16:56:50 +0530
Message-ID: <1298546811-27055-8-git-send-email-tarun.kanti@ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46560 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756179Ab1BXLYo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 06:24:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1OBOfjY008298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 05:24:44 -0600
In-Reply-To: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>

Add pm_runtime support to dmtimer. Since dmtimer is used during
early boot before pm_runtime is initialized completely there are
provisions to enable/disable clocks directly in the code during
early boot.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
[p-basak2@ti.com: added pm_runtime logic in probe()]
Signed-off-by: Partha Basak <p-basak2@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   63 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 53f5205..fcac422 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -39,6 +39,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <plat/dmtimer.h>
@@ -211,13 +212,16 @@ static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 
-	timer->fclk = clk_get(&timer->pdev->dev, "fck");
-	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
-		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
-		return;
+	if (!pdata->is_omap16xx) {
+		timer->fclk = clk_get(&timer->pdev->dev, "fck");
+		if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
+			dev_err(&timer->pdev->dev, ": No fclk handle.\n");
+			return;
+		}
 	}
 
-	omap_dm_timer_enable(timer);
+	if (!pdata->is_omap16xx)
+		omap_dm_timer_enable(timer);
 
 	if (pdata->dm_timer_reset)
 		pdata->dm_timer_reset(timer);
@@ -292,10 +296,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (timer->enabled)
 		return;
 
-	clk_enable(timer->fclk);
+	if (unlikely(pdata->is_early_init)) {
+		clk_enable(timer->fclk);
+		timer->enabled = 1;
+		return;
+	}
+
+	if (pm_runtime_get_sync(&timer->pdev->dev) < 0) {
+		dev_err(&timer->pdev->dev, "%s: pm_runtime_get_sync() FAILED\n",
+			__func__);
+		return;
+	}
 
 	timer->enabled = 1;
 }
@@ -303,10 +319,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (!timer->enabled)
 		return;
 
-	clk_disable(timer->fclk);
+	if (unlikely(pdata->is_early_init)) {
+		clk_disable(timer->fclk);
+		timer->enabled = 0;
+		return;
+	}
+
+	if (pm_runtime_put_sync(&timer->pdev->dev) < 0) {
+		dev_err(&timer->pdev->dev, "%s: pm_runtime_put_sync() FAILED\n",
+			__func__);
+		return;
+	}
 
 	timer->enabled = 0;
 }
@@ -425,10 +453,12 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (source < 0 || source >= 3)
 		return -EINVAL;
 
-	omap_dm_timer_disable(timer);
+	if (!pdata->is_omap16xx)
+		omap_dm_timer_disable(timer);
 	/* change the timer clock source */
 	ret = pdata->set_timer_src(timer->pdev, source);
-	omap_dm_timer_enable(timer);
+	if (!pdata->is_omap16xx)
+		omap_dm_timer_enable(timer);
 
 	/*
 	 * When the functional clock disappears, too quick writes seem
@@ -600,11 +630,26 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/*
+	 * OMAP2+
+	 * Early timers are already registered and in list.
+	 * What we need to do during second phase of probe
+	 * is to assign the newly allocated/configured pdev
+	 * to timer->pdev. We also call pm_runtime_enable()
+	 * for each device because it could not be called
+	 * during early boot because pm_runtime framework
+	 * was not yet up and running.
+	 */
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_for_each_entry(timer, &omap_timer_list, node)
 		if (!pdata->is_early_init && timer->id == pdev->id) {
 			timer->pdev = pdev;
 			spin_unlock_irqrestore(&dm_timer_lock, flags);
+			pm_runtime_enable(&pdev->dev);
+			/* update PM runtime for active early timers */
+			if (timer->reserved)
+				pm_runtime_get_sync(&pdev->dev);
+
 			dev_dbg(&pdev->dev, "Regular Probed\n");
 			return 0;
 		}
-- 
1.6.0.4

