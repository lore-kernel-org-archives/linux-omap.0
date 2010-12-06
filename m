From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v5 11/12] OMAP: dmtimer: pm_runtime support
Date: Tue,  7 Dec 2010 05:14:18 +0530
Message-ID: <1291679059-13419-12-git-send-email-tarun.kanti@ti.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38875 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab0LFMko (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 07:40:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB6CefRQ002482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 6 Dec 2010 06:40:43 -0600
In-Reply-To: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
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
Acked-by: Cousson, Benoit <b-cousson@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index ee35a32..d51a459 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -44,6 +44,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <mach/hardware.h>
 #include <plat/dmtimer.h>
@@ -353,10 +354,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
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
+	if (pm_runtime_get_sync(&timer->pdev->dev)) {
+		dev_err(&timer->pdev->dev, "%s: pm_runtime_get_sync() FAILED\n",
+			__func__);
+		return;
+	}
 
 	timer->enabled = 1;
 }
@@ -364,10 +377,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
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
+	if (pm_runtime_put_sync(&timer->pdev->dev)) {
+		dev_err(&timer->pdev->dev, "%s: pm_runtime_put_sync() FAILED\n",
+			__func__);
+		return;
+	}
 
 	timer->enabled = 0;
 }
@@ -662,11 +687,22 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/*
+	 * Early timers are already registered and in list.
+	 * What we need to do during second phase of probe
+	 * is to assign the newly allocated/configured pdev
+	 * to already registered timer->pdev. We also call
+	 * pm_runtime_enable() for each device because it
+	 * could not be called during early boot because
+	 * pm_runtime framework was not yet up and running.
+	 */
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_for_each_entry(timer, &omap_timer_list, node)
 		if (timer->pdev->id == pdev->id) {
 			timer->pdev = pdev;
 			spin_unlock_irqrestore(&dm_timer_lock, flags);
+			pm_runtime_enable(&pdev->dev);
+			dev_dbg(&pdev->dev, "pm_runtime ENABLED\n");
 			return 0;
 		}
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
-- 
1.6.0.4

