From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 08/11] ARM: OMAP: Remove loses_context variable from timer platform data
Date: Mon, 4 Jun 2012 12:22:32 -0500
Message-ID: <1338830555-20469-9-git-send-email-jon-hunter@ti.com>
References: <1338830555-20469-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52283 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999Ab2FDRXe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 13:23:34 -0400
In-Reply-To: <1338830555-20469-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

The platform data variable loses_context is used to determine if the timer may
lose its logic state during power transitions and so needs to be restored. This
information is also provided in the HWMOD device attributes for OMAP2+ devices
via the OMAP_TIMER_ALWON flag. When this flag is set the timer will not lose
context. So use the HWMOD device attributes to determine this.

For OMAP1 devices, loses_context is never set and so set the OMAP_TIMER_ALWON
flag for OMAP1 timers to ensure that code is equivalent.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap1/timer.c               |    1 +
 arch/arm/mach-omap2/timer.c               |    3 ---
 arch/arm/plat-omap/dmtimer.c              |    8 ++++----
 arch/arm/plat-omap/include/plat/dmtimer.h |    3 ---
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index 64c65bc..b4bf48c 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -141,6 +141,7 @@ static int __init omap1_dm_timer_init(void)
 
 		pdata->set_timer_src = omap1_dm_timer_set_src;
 		pdata->needs_manual_reset = 1;
+		pdata->timer_capability = OMAP_TIMER_ALWON;
 
 		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
 		if (ret) {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index a89f5f4..99e6a93 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -463,7 +463,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	struct dmtimer_platform_data *pdata;
 	struct platform_device *pdev;
 	struct omap_timer_capability_dev_attr *timer_dev_attr;
-	struct powerdomain *pwrdm;
 
 	pr_debug("%s: %s\n", __func__, oh->name);
 
@@ -496,8 +495,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	if (timer_dev_attr)
 		pdata->timer_capability = timer_dev_attr->timer_capability;
 
-	pwrdm = omap_hwmod_get_pwrdm(oh);
-	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
 #ifdef CONFIG_PM
 	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 #endif
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index d284b5d..823c80e 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -347,7 +347,7 @@ int omap_dm_timer_start(struct omap_dm_timer *timer)
 
 	omap_dm_timer_enable(timer);
 
-	if (timer->loses_context) {
+	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		u32 ctx_loss_cnt_after =
 			timer->get_context_loss_count(&timer->pdev->dev);
 		if (ctx_loss_cnt_after != timer->ctx_loss_count)
@@ -380,7 +380,8 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
 
 	__omap_dm_timer_stop(timer, timer->posted, rate);
 
-	if (timer->loses_context && timer->get_context_loss_count)
+	if (!(timer->capability & OMAP_TIMER_ALWON) &&
+			timer->get_context_loss_count)
 		timer->ctx_loss_count =
 			timer->get_context_loss_count(&timer->pdev->dev);
 
@@ -453,7 +454,7 @@ int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 
 	omap_dm_timer_enable(timer);
 
-	if (timer->loses_context) {
+	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		u32 ctx_loss_cnt_after =
 			timer->get_context_loss_count(&timer->pdev->dev);
 		if (ctx_loss_cnt_after != timer->ctx_loss_count)
@@ -698,7 +699,6 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
 	timer->pdev = pdev;
-	timer->loses_context = pdata->loses_context;
 	timer->get_context_loss_count = pdata->get_context_loss_count;
 	timer->capability = pdata->timer_capability;
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 362cf97..0a7ed31 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -91,8 +91,6 @@ struct timer_regs {
 struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	u32 needs_manual_reset:1;
-	bool loses_context;
-
 	int (*get_context_loss_count)(struct device *dev);
 	u32 timer_capability;
 };
@@ -264,7 +262,6 @@ struct omap_dm_timer {
 	unsigned reserved:1;
 	unsigned posted:1;
 	struct timer_regs context;
-	bool loses_context;
 	int ctx_loss_count;
 	int revision;
 	u32 capability;
-- 
1.7.9.5

