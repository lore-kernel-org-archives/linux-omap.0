From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v6 10/12] OMAP: dmtimer: pm_runtime support
Date: Wed, 15 Dec 2010 09:35:08 +0530
Message-ID: <1292385910-5234-11-git-send-email-tarun.kanti@ti.com>
References: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37482 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325Ab0LNRBo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 12:01:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBEH1fT2008828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 11:01:43 -0600
In-Reply-To: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
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
 arch/arm/plat-omap/dmtimer.c |   38 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 3bae4b5..e4849b7 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -39,6 +39,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <plat/dmtimer.h>
 
@@ -293,10 +294,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
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
@@ -304,11 +317,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
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
 
+	if (pm_runtime_put_sync(&timer->pdev->dev)) {
+		dev_err(&timer->pdev->dev, "%s: pm_runtime_put_sync() FAILED\n",
+			__func__);
+		return;
+	}
 
 	timer->enabled = 0;
 }
@@ -603,11 +627,21 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/*
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
 			dev_dbg(&pdev->dev, "Regular Probed\n");
 			return 0;
 		}
-- 
1.6.0.4

