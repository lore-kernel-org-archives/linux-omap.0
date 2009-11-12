From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 1/1]: Thaws refrigerated bdi flusher threads before
 invoking kthread_stop on them
Date: Thu, 12 Nov 2009 17:22:06 +0530
Message-ID: <1258026726.2341.1.camel@boson>
References: <1257928216.15415.57.camel@boson>
	 <200911111230.58479.rjw@sisk.pl> <20091111193719.GR8742@kernel.dk>
	 <200911112141.12437.rjw@sisk.pl>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752849AbZKLLwx@vger.kernel.org>
In-Reply-To: <200911112141.12437.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jens Axboe <jens.axboe@oracle.com>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Resubmitting after incorporationg the suggestions:
> 
> Romit, please rework as suggested by Jens and resubmit.

Unfreezes the bdi flusher task when the said task needs to exit.

Steps to reproduce this.
1) Mount a file system from MMC/SD card.
2) Unmount the file system. This creates a flusher task.
3) Attempt suspend to RAM. System is unresponsive.

This is because the bdi flusher thread is already in the refrigerator and will
remain so until it is thawed. The MMC driver suspend routine call stack will
ultimately issue a 'kthread_stop' on the bdi flusher thread and will block
until the flusher thread is exited. Since the bdi flusher thread is in the
refrigerator it never cleans up until thawed.

Signed-off-by: Romit Dasgupta <romit@ti.com>
---
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 5a37e20..5a9ab6f 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -603,11 +603,15 @@ static void bdi_wb_shutdown(struct backing_dev_info *bdi)
 	bdi_remove_from_list(bdi);
 
 	/*
+	 * Force unfreeze of bdi threads before stopping it, otherwise
+	 * it would never exit if it is stuck in the refrigerator.
 	 * Finally, kill the kernel threads. We don't need to be RCU
 	 * safe anymore, since the bdi is gone from visibility.
 	 */
-	list_for_each_entry(wb, &bdi->wb_list, list)
+	list_for_each_entry(wb, &bdi->wb_list, list) {
+		wb->task->flags &= ~PF_FROZEN;
 		kthread_stop(wb->task);
+	}
 }
 
 void bdi_unregister(struct backing_dev_info *bdi)
