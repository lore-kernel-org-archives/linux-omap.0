From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v14 09/12] OMAP: dmtimer: use mutex instead of spinlock
Date: Mon, 11 Jul 2011 16:51:33 +0530
Message-ID: <1310383296-18956-10-git-send-email-tarun.kanti@ti.com>
References: <1310383296-18956-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50911 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756900Ab1GKMtF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 08:49:05 -0400
In-Reply-To: <1310383296-18956-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Since the spinlock is not used in any interrupt context we can
replace it with mutex instead.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f7ab92c..e7ceb5b 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,7 +43,7 @@
 #include <plat/dmtimer.h>
 
 static LIST_HEAD(omap_timer_list);
-static DEFINE_SPINLOCK(dm_timer_lock);
+static DEFINE_MUTEX(dm_timer_mutex);
 
 /**
  * omap_dm_timer_read_reg - read timer registers in posted and non-posted mode
@@ -136,9 +136,8 @@ void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
 	struct omap_dm_timer *timer = NULL, *t;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dm_timer_lock, flags);
+	mutex_lock(&dm_timer_mutex);
 	list_for_each_entry(t, &omap_timer_list, node) {
 		if (t->reserved)
 			continue;
@@ -147,7 +146,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 		timer->reserved = 1;
 		break;
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	mutex_unlock(&dm_timer_mutex);
 
 	if (timer)
 		omap_dm_timer_prepare(timer);
@@ -161,9 +160,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
 	struct omap_dm_timer *timer = NULL, *t;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dm_timer_lock, flags);
+	mutex_lock(&dm_timer_mutex);
 	list_for_each_entry(t, &omap_timer_list, node) {
 		if (t->pdev->id == id && !t->reserved) {
 			timer = t;
@@ -171,7 +169,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	mutex_unlock(&dm_timer_mutex);
 
 	if (timer)
 		omap_dm_timer_prepare(timer);
@@ -220,14 +218,13 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 {
 	int i = 0;
 	struct omap_dm_timer *timer = NULL;
-	unsigned long flags;
 
 	/* If ARMXOR cannot be idled this function call is unnecessary */
 	if (!(inputmask & (1 << 1)))
 		return inputmask;
 
 	/* If any active timer is using ARMXOR return modified mask */
-	spin_lock_irqsave(&dm_timer_lock, flags);
+	mutex_lock(&dm_timer_mutex);
 	list_for_each_entry(timer, &omap_timer_list, node) {
 		u32 l;
 
@@ -240,7 +237,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 		}
 		i++;
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	mutex_unlock(&dm_timer_mutex);
 
 	return inputmask;
 }
@@ -464,7 +461,6 @@ EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 {
 	int ret;
-	unsigned long flags;
 	struct omap_dm_timer *timer;
 	struct resource *mem, *irq, *ioarea;
 	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
@@ -529,9 +525,9 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		pm_runtime_enable(&pdev->dev);
 
 	/* add the timer element to the list */
-	spin_lock_irqsave(&dm_timer_lock, flags);
+	mutex_lock(&dm_timer_mutex);
 	list_add_tail(&timer->node, &omap_timer_list);
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	mutex_unlock(&dm_timer_mutex);
 
 	dev_dbg(&pdev->dev, "Device Probed.\n");
 
@@ -561,10 +557,9 @@ err_free_pdev:
 static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
 {
 	struct omap_dm_timer *timer, *tmp;
-	unsigned long flags;
 	int ret = -EINVAL;
 
-	spin_lock_irqsave(&dm_timer_lock, flags);
+	mutex_lock(&dm_timer_mutex);
 	list_for_each_entry_safe(timer, tmp, &omap_timer_list, node) {
 		if (timer->pdev->id == pdev->id) {
 			kfree(timer->pdev->dev.platform_data);
@@ -575,7 +570,7 @@ static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	mutex_unlock(&dm_timer_mutex);
 
 	return ret;
 }
-- 
1.6.0.4

