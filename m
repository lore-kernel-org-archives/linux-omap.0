From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 09/11] ARM: OMAP: Remove timer function pointer for context loss counter
Date: Mon, 4 Jun 2012 12:22:33 -0500
Message-ID: <1338830555-20469-10-git-send-email-jon-hunter@ti.com>
References: <1338830555-20469-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44888 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab2FDRXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 13:23:40 -0400
In-Reply-To: <1338830555-20469-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

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
 arch/arm/mach-omap1/timer.c               |    4 ++--
 arch/arm/mach-omap2/timer.c               |    3 ---
 arch/arm/plat-omap/dmtimer.c              |   26 ++++++++++----------------
 arch/arm/plat-omap/include/plat/dmtimer.h |    4 +---
 4 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index b4bf48c..aa81593 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -140,8 +140,8 @@ static int __init omap1_dm_timer_init(void)
 		}
 
 		pdata->set_timer_src = omap1_dm_timer_set_src;
-		pdata->needs_manual_reset = 1;
-		pdata->timer_capability = OMAP_TIMER_ALWON;
+		pdata->timer_capability = OMAP_TIMER_ALWON |
+				OMAP_TIMER_NEEDS_RESET;
 
 		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
 		if (ret) {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 99e6a93..9963b56 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -495,9 +495,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	if (timer_dev_attr)
 		pdata->timer_capability = timer_dev_attr->timer_capability;
 
-#ifdef CONFIG_PM
-	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
-#endif
 	pdev = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
 				 NULL, 0, 0);
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 823c80e..6510e5e 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -42,6 +42,7 @@
 #include <linux/pm_runtime.h>
 
 #include <plat/dmtimer.h>
+#include <plat/omap-pm.h>
 
 #include <mach/hardware.h>
 
@@ -134,7 +135,6 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 	int ret;
 
 	/*
@@ -150,7 +150,7 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 		}
 	}
 
-	if (pdata->needs_manual_reset)
+	if (timer->capability & OMAP_TIMER_NEEDS_RESET)
 		omap_dm_timer_reset(timer);
 
 	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
@@ -348,9 +348,8 @@ int omap_dm_timer_start(struct omap_dm_timer *timer)
 	omap_dm_timer_enable(timer);
 
 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
-		u32 ctx_loss_cnt_after =
-			timer->get_context_loss_count(&timer->pdev->dev);
-		if (ctx_loss_cnt_after != timer->ctx_loss_count)
+		if (omap_pm_get_dev_context_loss_count(&timer->pdev->dev) !=
+				timer->ctx_loss_count)
 			omap_timer_restore_context(timer);
 	}
 
@@ -369,21 +368,18 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 int omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
 	unsigned long rate = 0;
-	struct dmtimer_platform_data *pdata;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	pdata = timer->pdev->dev.platform_data;
-	if (!pdata->needs_manual_reset)
+	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET))
 		rate = clk_get_rate(timer->fclk);
 
 	__omap_dm_timer_stop(timer, timer->posted, rate);
 
-	if (!(timer->capability & OMAP_TIMER_ALWON) &&
-			timer->get_context_loss_count)
+	if (!(timer->capability & OMAP_TIMER_ALWON))
 		timer->ctx_loss_count =
-			timer->get_context_loss_count(&timer->pdev->dev);
+			omap_pm_get_dev_context_loss_count(&timer->pdev->dev);
 
 	/*
 	 * Since the register values are computed and written within
@@ -455,9 +451,8 @@ int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_enable(timer);
 
 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
-		u32 ctx_loss_cnt_after =
-			timer->get_context_loss_count(&timer->pdev->dev);
-		if (ctx_loss_cnt_after != timer->ctx_loss_count)
+		if (omap_pm_get_dev_context_loss_count(&timer->pdev->dev) !=
+				timer->ctx_loss_count)
 			omap_timer_restore_context(timer);
 	}
 
@@ -699,11 +694,10 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
 	timer->pdev = pdev;
-	timer->get_context_loss_count = pdata->get_context_loss_count;
 	timer->capability = pdata->timer_capability;
 
 	/* Skip pm_runtime_enable for OMAP1 */
-	if (!pdata->needs_manual_reset) {
+	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
 		pm_runtime_enable(&pdev->dev);
 		pm_runtime_irq_safe(&pdev->dev);
 	}
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 0a7ed31..4a35b23 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -59,6 +59,7 @@
 #define OMAP_TIMER_SECURE				0x80000000
 #define OMAP_TIMER_ALWON				0x40000000
 #define OMAP_TIMER_HAS_PWM				0x20000000
+#define OMAP_TIMER_NEEDS_RESET				0x10000000
 
 struct omap_timer_capability_dev_attr {
 	u32 timer_capability;
@@ -91,7 +92,6 @@ struct timer_regs {
 struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	u32 needs_manual_reset:1;
-	int (*get_context_loss_count)(struct device *dev);
 	u32 timer_capability;
 };
 
@@ -267,8 +267,6 @@ struct omap_dm_timer {
 	u32 capability;
 	struct platform_device *pdev;
 	struct list_head node;
-
-	int (*get_context_loss_count)(struct device *dev);
 };
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer);
-- 
1.7.9.5

