From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 8/9] ARM: OMAP: Remove timer function pointer for context loss counter
Date: Tue, 15 May 2012 18:36:11 -0500
Message-ID: <1337124971-20203-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48764 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966132Ab2EOXgK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 19:36:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

For OMAP2+ devices, a function pointer that returns the number of times a timer
power domain has lost context is passed to the dmtimer driver. This function
pointer is only populated for OMAP2+ devices and it is pointing to a platform
function. Given that this is a platform function, we can simplify the code by
removing the function pointer and referencing the function directly. We can use
the OMAP_TIMER_ALWON flag to determine if we need to call this function for
OMAP1 and OMAP2+ devices.

The benefit of this change is the we can remove the function pointer from the
platform data and simplifies the dmtimer migration to device-tree.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |    3 ---
 arch/arm/plat-omap/dmtimer.c              |   17 +++++++----------
 arch/arm/plat-omap/include/plat/dmtimer.h |    3 ---
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 638c8df..52bc4c4 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -501,9 +501,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	if (timer_dev_attr)
 		pdata->timer_capability = timer_dev_attr->timer_capability;
 
-#ifdef CONFIG_PM
-	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
-#endif
 	pdev = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
 				 NULL, 0, 0);
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7aa1278..7875eef 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -42,6 +42,7 @@
 #include <linux/pm_runtime.h>
 
 #include <plat/dmtimer.h>
+#include <plat/omap-pm.h>
 
 #include <mach/hardware.h>
 
@@ -342,9 +343,8 @@ int omap_dm_timer_start(struct omap_dm_timer *timer)
 	omap_dm_timer_enable(timer);
 
 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
-		u32 ctx_loss_cnt_after =
-			timer->get_context_loss_count(&timer->pdev->dev);
-		if (ctx_loss_cnt_after != timer->ctx_loss_count)
+		if (omap_pm_get_dev_context_loss_count(&timer->pdev->dev) !=
+				timer->ctx_loss_count)
 			omap_timer_restore_context(timer);
 	}
 
@@ -374,10 +374,9 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
 
 	__omap_dm_timer_stop(timer, timer->posted, rate);
 
-	if (!(timer->capability & OMAP_TIMER_ALWON) &&
-			timer->get_context_loss_count)
+	if (!(timer->capability & OMAP_TIMER_ALWON))
 		timer->ctx_loss_count =
-			timer->get_context_loss_count(&timer->pdev->dev);
+			omap_pm_get_dev_context_loss_count(&timer->pdev->dev);
 
 	/*
 	 * Since the register values are computed and written within
@@ -449,9 +448,8 @@ int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_enable(timer);
 
 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
-		u32 ctx_loss_cnt_after =
-			timer->get_context_loss_count(&timer->pdev->dev);
-		if (ctx_loss_cnt_after != timer->ctx_loss_count)
+		if (omap_pm_get_dev_context_loss_count(&timer->pdev->dev) !=
+				timer->ctx_loss_count)
 			omap_timer_restore_context(timer);
 	}
 
@@ -693,7 +691,6 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
 	timer->pdev = pdev;
-	timer->get_context_loss_count = pdata->get_context_loss_count;
 	timer->capability = pdata->timer_capability;
 
 	/* Skip pm_runtime_enable for OMAP1 */
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index e62208e..1828b04 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -92,7 +92,6 @@ struct timer_regs {
 struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	u32 needs_manual_reset:1;
-	int (*get_context_loss_count)(struct device *dev);
 	u32 timer_capability;
 };
 
@@ -268,8 +267,6 @@ struct omap_dm_timer {
 	u32 capability;
 	struct platform_device *pdev;
 	struct list_head node;
-
-	int (*get_context_loss_count)(struct device *dev);
 };
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer);
-- 
1.7.5.4

