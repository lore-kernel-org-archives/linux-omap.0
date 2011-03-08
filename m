From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v12 9/9] OMAP: dmtimer: use mutex instead of spinlock
Date: Wed,  9 Mar 2011 05:15:48 +0530
Message-ID: <1299627948-20040-10-git-send-email-tarun.kanti@ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56499 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756745Ab1CHXnb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 18:43:31 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p28NhSxZ002469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 17:43:30 -0600
In-Reply-To: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Since the spinlock is not used in any interrupt context we can
replace it with mutex instead.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index aea0b5d..b85f89b 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -165,7 +165,7 @@
 #define MAX_WRITE_PEND_WAIT		10000 /* 10ms timeout delay */
 
 static LIST_HEAD(omap_timer_list);
-static DEFINE_SPINLOCK(dm_timer_lock);
+static DEFINE_MUTEX(dm_timer_mutex);
 
 /**
  * omap_dm_timer_read_reg - read timer registers in posted and non-posted mode
@@ -293,9 +293,8 @@ end:
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
 	struct omap_dm_timer *timer = NULL, *t;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dm_timer_lock, flags);
+	mutex_lock(&dm_timer_mutex);
 	list_for_each_entry(t, &omap_timer_list, node) {
 		if (t->reserved)
 			continue;
@@ -304,7 +303,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 		timer->reserved = 1;
 		break;
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	mutex_unlock(&dm_timer_mutex);
 
 	if (timer)
 		omap_dm_timer_prepare(timer);
@@ -318,9 +317,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
 	struct omap_dm_timer *timer = NULL, *t;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dm_timer_lock, flags);
+	mutex_lock(&dm_timer_mutex);
 	list_for_each_entry(t, &omap_timer_list, node) {
 		if (t->pdev->id == id && !t->reserved) {
 			timer = t;
@@ -328,7 +326,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	mutex_unlock(&dm_timer_mutex);
 
 	if (timer)
 		omap_dm_timer_prepare(timer);
@@ -390,14 +388,13 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
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
@@ -411,7 +408,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 		}
 		i++;
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	mutex_unlock(&dm_timer_mutex);
 
 	return inputmask;
 }
@@ -652,7 +649,6 @@ EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 {
 	int ret;
-	unsigned long flags;
 	struct omap_dm_timer *timer;
 	struct resource *mem, *irq, *ioarea;
 	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
@@ -717,9 +713,9 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		pm_runtime_enable(&pdev->dev);
 
 	/* add the timer element to the list */
-	spin_lock_irqsave(&dm_timer_lock, flags);
+	mutex_lock(&dm_timer_mutex);
 	list_add_tail(&timer->node, &omap_timer_list);
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	mutex_unlock(&dm_timer_mutex);
 
 	dev_dbg(&pdev->dev, "Device Probed.\n");
 
@@ -749,10 +745,9 @@ err_free_pdev:
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
@@ -763,7 +758,7 @@ static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
+	mutex_unlock(&dm_timer_mutex);
 
 	return ret;
 }
-- 
1.6.0.4

