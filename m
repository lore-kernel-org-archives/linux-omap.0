From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 01/17] OMAP: DSS2: DSI: change DSI bus_lock to semaphore
Date: Mon,  8 Feb 2010 17:57:25 +0200
Message-ID: <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45827 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab0BHPzK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:10 -0500
In-Reply-To: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Physical DSI bus is protected by a mutex. This patch changed the mutex to
a semaphore, so that we can lock and unlock the bus_lock from different
threads.

This is needed as the update process is started by user space program, and
thus the lock is acquired in that context, but the lock can be released in
different context, a work thread via irq.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/dsi.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 4b85ed2..74df72b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/semaphore.h>
 #include <linux/seq_file.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
@@ -227,7 +228,7 @@ static struct
 	} vc[4];
 
 	struct mutex lock;
-	struct mutex bus_lock;
+	struct semaphore bus_lock;
 
 	unsigned pll_locked;
 
@@ -298,19 +299,19 @@ void dsi_restore_context(void)
 
 void dsi_bus_lock(void)
 {
-	mutex_lock(&dsi.bus_lock);
+	down(&dsi.bus_lock);
 }
 EXPORT_SYMBOL(dsi_bus_lock);
 
 void dsi_bus_unlock(void)
 {
-	mutex_unlock(&dsi.bus_lock);
+	up(&dsi.bus_lock);
 }
 EXPORT_SYMBOL(dsi_bus_unlock);
 
 static bool dsi_bus_is_locked(void)
 {
-	return mutex_is_locked(&dsi.bus_lock);
+	return dsi.bus_lock.count == 0;
 }
 
 static inline int wait_for_bit_change(const struct dsi_reg idx, int bitnum,
@@ -3000,8 +3001,6 @@ static int dsi_update_thread(void *data)
 	u16 x, y, w, h;
 
 	while (1) {
-		bool sched;
-
 		wait_event_interruptible(dsi.waitqueue,
 				dsi.update_mode == OMAP_DSS_UPDATE_AUTO ||
 				(dsi.update_mode == OMAP_DSS_UPDATE_MANUAL &&
@@ -3087,16 +3086,9 @@ static int dsi_update_thread(void *data)
 			dsi_perf_show("L4");
 		}
 
-		sched = atomic_read(&dsi.bus_lock.count) < 0;
-
 		complete_all(&dsi.update_completion);
 
 		dsi_bus_unlock();
-
-		/* XXX We need to give others chance to get the bus lock. Is
-		 * there a better way for this? */
-		if (dsi.update_mode == OMAP_DSS_UPDATE_AUTO && sched)
-			schedule_timeout_interruptible(1);
 	}
 
 	DSSDBG("update thread exiting\n");
@@ -3796,7 +3788,7 @@ int dsi_init(struct platform_device *pdev)
 	spin_lock_init(&dsi.update_lock);
 
 	mutex_init(&dsi.lock);
-	mutex_init(&dsi.bus_lock);
+	sema_init(&dsi.bus_lock, 1);
 
 #ifdef DSI_CATCH_MISSING_TE
 	init_timer(&dsi.te_timer);
-- 
1.6.5

