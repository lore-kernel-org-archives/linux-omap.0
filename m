From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 7/9] ARM: OMAP: Remove loses_context variable from timer platform data
Date: Tue, 15 May 2012 18:36:04 -0500
Message-ID: <1337124964-20168-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52478 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966132Ab2EOXgE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 19:36:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

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
index cfc5781..638c8df 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -469,7 +469,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	struct dmtimer_platform_data *pdata;
 	struct platform_device *pdev;
 	struct omap_timer_capability_dev_attr *timer_dev_attr;
-	struct powerdomain *pwrdm;
 
 	pr_debug("%s: %s\n", __func__, oh->name);
 
@@ -502,8 +501,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	if (timer_dev_attr)
 		pdata->timer_capability = timer_dev_attr->timer_capability;
 
-	pwrdm = omap_hwmod_get_pwrdm(oh);
-	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
 #ifdef CONFIG_PM
 	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 #endif
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 30742d8e6..7aa1278 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -341,7 +341,7 @@ int omap_dm_timer_start(struct omap_dm_timer *timer)
 
 	omap_dm_timer_enable(timer);
 
-	if (timer->loses_context) {
+	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		u32 ctx_loss_cnt_after =
 			timer->get_context_loss_count(&timer->pdev->dev);
 		if (ctx_loss_cnt_after != timer->ctx_loss_count)
@@ -374,7 +374,8 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
 
 	__omap_dm_timer_stop(timer, timer->posted, rate);
 
-	if (timer->loses_context && timer->get_context_loss_count)
+	if (!(timer->capability & OMAP_TIMER_ALWON) &&
+			timer->get_context_loss_count)
 		timer->ctx_loss_count =
 			timer->get_context_loss_count(&timer->pdev->dev);
 
@@ -447,7 +448,7 @@ int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 
 	omap_dm_timer_enable(timer);
 
-	if (timer->loses_context) {
+	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		u32 ctx_loss_cnt_after =
 			timer->get_context_loss_count(&timer->pdev->dev);
 		if (ctx_loss_cnt_after != timer->ctx_loss_count)
@@ -692,7 +693,6 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
 	timer->pdev = pdev;
-	timer->loses_context = pdata->loses_context;
 	timer->get_context_loss_count = pdata->get_context_loss_count;
 	timer->capability = pdata->timer_capability;
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 2c5c155..e62208e 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -92,8 +92,6 @@ struct timer_regs {
 struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	u32 needs_manual_reset:1;
-	bool loses_context;
-
 	int (*get_context_loss_count)(struct device *dev);
 	u32 timer_capability;
 };
@@ -265,7 +263,6 @@ struct omap_dm_timer {
 	unsigned reserved:1;
 	unsigned posted:1;
 	struct timer_regs context;
-	bool loses_context;
 	int ctx_loss_count;
 	int revision;
 	u32 capability;
-- 
1.7.5.4

