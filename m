From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v12 7/9] OMAP: dmtimer: pm_runtime support
Date: Wed,  9 Mar 2011 05:15:46 +0530
Message-ID: <1299627948-20040-8-git-send-email-tarun.kanti@ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51428 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756734Ab1CHXnb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 18:43:31 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p28NhSaF025333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 17:43:30 -0600
In-Reply-To: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>

Add pm_runtime feature to dmtimer whereby _get_sync() is called within
omap_dm_timer_enable(), _put_sync() is called in omap_dm_timer_disable().
As part of this, I am getting rid of the 'enabled' flag since this is
no longer needed. This has been replaced by pm_runtime_suspended() check.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
[p-basak2@ti.com: added pm_runtime logic in probe()]
Signed-off-by: Partha Basak <p-basak2@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 6ac6ce7..29d675e 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -39,6 +39,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 
@@ -335,7 +336,7 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 	if (timer->enabled)
 		return;
 
-	clk_enable(timer->fclk);
+	pm_runtime_get_sync(&timer->pdev->dev);
 
 	timer->enabled = 1;
 }
@@ -346,7 +347,7 @@ void omap_dm_timer_disable(struct omap_dm_timer *timer)
 	if (!timer->enabled)
 		return;
 
-	clk_disable(timer->fclk);
+	pm_runtime_put_sync(&timer->pdev->dev);
 
 	timer->enabled = 0;
 }
@@ -690,6 +691,10 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->pdev = pdev;
 	timer->reserved = 0;
 
+	 /* Skip pm_runtime_enable during early boot and for OMAP1 */
+	if (!pdata->is_early_init && !pdata->needs_manual_reset)
+		pm_runtime_enable(&pdev->dev);
+
 	/* add the timer element to the list */
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_add_tail(&timer->node, &omap_timer_list);
-- 
1.6.0.4

