From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v14 REPOST 10/12] OMAP: dmtimer: mark clocksource and clockevent timers reserved
Date: Fri, 15 Jul 2011 17:34:59 +0530
Message-ID: <1310731501-13078-11-git-send-email-tarun.kanti@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55833 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063Ab1GOMFc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 08:05:32 -0400
In-Reply-To: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

In driver probe use sys_timer_reserved to identify which all timers
have already been used for clocksource and clockevent. Mark all those
timers as reserved so that no one else can use them.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap1/timer.c  |    2 ++
 arch/arm/plat-omap/dmtimer.c |    8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index 980b23b..0b318c7 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -41,6 +41,8 @@
 
 #define OMAP1_DM_TIMER_COUNT		8
 
+u32 sys_timer_reserved;
+
 static int omap1_dm_timer_set_src(struct platform_device *pdev,
 				int source)
 {
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index be55e42..8c8cb00 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -513,10 +513,14 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->pdev = pdev;
 
-	/* Skip pm_runtime_enable for OMAP1 */
-	if (!pdata->needs_manual_reset)
+	if (!pdata->needs_manual_reset) {
 		pm_runtime_enable(&pdev->dev);
 
+		/* Mark clocksource and clockevent timers as reserved */
+		if ((sys_timer_reserved >> (pdev->id - 1)) & 0x1)
+			timer->reserved = 1;
+	}
+
 	/* add the timer element to the list */
 	mutex_lock(&dm_timer_mutex);
 	list_add_tail(&timer->node, &omap_timer_list);
-- 
1.6.0.4

