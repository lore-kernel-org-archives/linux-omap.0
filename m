From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv4 14/14] OMAP: dmtimer: pm_runtime support
Date: Sat, 20 Nov 2010 08:09:38 +0530
Message-ID: <1290220778-22244-15-git-send-email-tarun.kanti@ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-13-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-14-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40062 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831Ab0KSPgj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 10:36:39 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAJFaaP4024142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 09:36:38 -0600
In-Reply-To: <1290220778-22244-14-git-send-email-tarun.kanti@ti.com>
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
---
 arch/arm/plat-omap/dmtimer.c |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f9285b1..83d0b66 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -45,6 +45,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <mach/hardware.h>
+#include <linux/pm_runtime.h>
 #include <plat/dmtimer.h>
 #include <mach/irqs.h>
 #include <linux/err.h>
@@ -345,10 +346,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
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
+		dev_dbg(&timer->pdev->dev, "%s:pm_runtime_get_sync() FAILED\n",
+			__func__);
+		return;
+	}
 
 	timer->enabled = 1;
 }
@@ -356,10 +369,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
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
+		dev_dbg(&timer->pdev->dev, "%s:pm_runtime_put_sync() FAILED\n",
+			__func__);
+		return;
+	}
 
 	timer->enabled = 0;
 }
@@ -669,6 +694,8 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		if (timer->id == pdev->id) {
 			timer->pdev = pdev;
 			spin_unlock_irqrestore(&dm_timer_lock, flags);
+			pm_runtime_enable(&pdev->dev);
+			dev_dbg(&pdev->dev, "pm_runtime ENABLED\n");
 			return 0;
 		}
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
-- 
1.6.0.4

