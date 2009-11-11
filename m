From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 1/1]: Thaws refrigerated bdi flusher threads before
 invoking kthread_stop on them
Date: Wed, 11 Nov 2009 14:00:16 +0530
Message-ID: <1257928216.15415.57.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757102AbZKKIax@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jens.axboe@oracle.com, rjw@sisk.pl, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Kicks out frozen bdi flusher task out of the refrigerator when the flusher task
needs to exit.
Signed-off-by: Romit Dasgupta <romit@ti.com>
---
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 5a37e20..c757b05 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -606,8 +606,11 @@ static void bdi_wb_shutdown(struct backing_dev_info *bdi)
 	 * Finally, kill the kernel threads. We don't need to be RCU
 	 * safe anymore, since the bdi is gone from visibility.
 	 */
-	list_for_each_entry(wb, &bdi->wb_list, list)
+	list_for_each_entry(wb, &bdi->wb_list, list) {
+		if (unlikely(frozen(wb->task)))
+			wb->task->flags &= ~PF_FROZEN;
 		kthread_stop(wb->task);
+	}
 }
 
 void bdi_unregister(struct backing_dev_info *bdi)
