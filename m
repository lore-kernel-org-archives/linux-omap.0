From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v13 07/11] OMAP: dmtimer: pm_runtime support
Date: Sat, 16 Apr 2011 21:20:59 +0530
Message-ID: <1302969063-8231-8-git-send-email-tarun.kanti@ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52817 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755798Ab1DPPu0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Apr 2011 11:50:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3GFoM5g013830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 16 Apr 2011 10:50:25 -0500
In-Reply-To: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>

Add pm_runtime feature to dmtimer whereby _get_sync() is called within
omap_dm_timer_enable(), _put_sync() is called in omap_dm_timer_disable().

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
[p-basak2@ti.com: added pm_runtime logic in probe()]
Signed-off-by: Partha Basak <p-basak2@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8cd5cf6..b61edc2 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -38,6 +38,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/err.h>
 
 #include <plat/dmtimer.h>
@@ -218,8 +219,7 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 	if (timer->enabled)
 		return;
 
-	clk_enable(timer->fclk);
-	clk_enable(timer->iclk);
+	pm_runtime_get_sync(&timer->pdev->dev);
 
 	timer->enabled = 1;
 }
@@ -230,8 +230,7 @@ void omap_dm_timer_disable(struct omap_dm_timer *timer)
 	if (!timer->enabled)
 		return;
 
-	clk_disable(timer->fclk);
-	clk_disable(timer->iclk);
+	pm_runtime_put_sync(&timer->pdev->dev);
 
 	timer->enabled = 0;
 }
@@ -561,6 +560,10 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->pdev = pdev;
 	timer->reserved = 0;
 
+	 /* Skip pm_runtime_enable for OMAP1 */
+	if (!pdata->needs_manual_reset)
+		pm_runtime_enable(&pdev->dev);
+
 	/* add the timer element to the list */
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_add_tail(&timer->node, &omap_timer_list);
-- 
1.6.0.4

