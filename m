From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 10/12] ARM: OMAP: Add flag to indicate if a timer needs a manual reset
Date: Mon, 4 Jun 2012 14:41:47 -0500
Message-ID: <1338838909-25356-11-git-send-email-jon-hunter@ti.com>
References: <1338838909-25356-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40723 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340Ab2FDTmU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 15:42:20 -0400
In-Reply-To: <1338838909-25356-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

For OMAP1 devices, it is necessary to perform a manual reset of the timer.
Currently, this is indicating by setting the "needs_manual_reset" variable in
the platform data. Instead of using an extra variable to indicate this add a new
timer capabilities flag to indicate this and remove the "needs_manual_reset"
member from the platform data.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap1/timer.c               |    4 ++--
 arch/arm/plat-omap/dmtimer.c              |    9 +++------
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
 3 files changed, 6 insertions(+), 8 deletions(-)

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
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f278bd0..6510e5e 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -135,7 +135,6 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 	int ret;
 
 	/*
@@ -151,7 +150,7 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 		}
 	}
 
-	if (pdata->needs_manual_reset)
+	if (timer->capability & OMAP_TIMER_NEEDS_RESET)
 		omap_dm_timer_reset(timer);
 
 	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
@@ -369,13 +368,11 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_start);
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
@@ -700,7 +697,7 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->capability = pdata->timer_capability;
 
 	/* Skip pm_runtime_enable for OMAP1 */
-	if (!pdata->needs_manual_reset) {
+	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
 		pm_runtime_enable(&pdev->dev);
 		pm_runtime_irq_safe(&pdev->dev);
 	}
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index e11c9ea..4a35b23 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -59,6 +59,7 @@
 #define OMAP_TIMER_SECURE				0x80000000
 #define OMAP_TIMER_ALWON				0x40000000
 #define OMAP_TIMER_HAS_PWM				0x20000000
+#define OMAP_TIMER_NEEDS_RESET				0x10000000
 
 struct omap_timer_capability_dev_attr {
 	u32 timer_capability;
-- 
1.7.9.5

