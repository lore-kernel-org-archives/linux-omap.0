From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v14 07/12] OMAP: dmtimer: pm_runtime support
Date: Mon, 11 Jul 2011 16:59:14 +0530
Message-ID: <1310383759-19059-8-git-send-email-tarun.kanti@ti.com>
References: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50857 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316Ab1GKMsp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 08:48:45 -0400
In-Reply-To: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>

Add pm_runtime feature to dmtimer whereby _get_sync() is called within
omap_dm_timer_enable(), _put_sync() is called in omap_dm_timer_disable().

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
[p-basak2@ti.com: added pm_runtime logic in probe()]
Signed-off-by: Partha Basak <p-basak2@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   31 +++++++---------------------
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index d46efb4..f7ab92c 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -38,6 +38,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/dmtimer.h>
 
@@ -193,33 +194,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-
-	if (timer->enabled)
-		return;
-
-	if (!pdata->needs_manual_reset) {
-		clk_enable(timer->fclk);
-		clk_enable(timer->iclk);
-	}
-
-	timer->enabled = 1;
+	pm_runtime_get_sync(&timer->pdev->dev);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-
-	if (!timer->enabled)
-		return;
-
-	if (!pdata->needs_manual_reset) {
-		clk_disable(timer->iclk);
-		clk_disable(timer->fclk);
-	}
-
-	timer->enabled = 0;
+	pm_runtime_put_sync(&timer->pdev->dev);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
 
@@ -461,7 +442,7 @@ int omap_dm_timers_active(void)
 	struct omap_dm_timer *timer;
 
 	list_for_each_entry(timer, &omap_timer_list, node) {
-		if (!timer->enabled)
+		if (!timer->reserved)
 			continue;
 
 		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG) &
@@ -543,6 +524,10 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->pdev = pdev;
 	timer->reserved = 0;
 
+	/* Skip pm_runtime_enable for OMAP1 */
+	if (!pdata->needs_manual_reset)
+		pm_runtime_enable(&pdev->dev);
+
 	/* add the timer element to the list */
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_add_tail(&timer->node, &omap_timer_list);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 90a504a..53d5da6 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -238,7 +238,6 @@ struct omap_dm_timer {
 	void __iomem *io_base;
 	unsigned long rate;
 	unsigned reserved:1;
-	unsigned enabled:1;
 	unsigned posted:1;
 	u8 func_offset;
 	u8 intr_offset;
-- 
1.6.0.4

