From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCHv2] mailbox: change full flag per mailbox queue instead of global
Date: Tue, 10 Aug 2010 20:12:49 -0500
Message-ID: <1281489169-15945-1-git-send-email-x0095840@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38125 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab0HKA7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Aug 2010 20:59:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, ohad@wizery.com, Fernando Guzman Lugo <x0095840@ti.com>

As pointed by Ohad Ben-Cohen, the variable rq_full flag is a
global variable, so if there are multiple mailbox users
there will be conflics. Now there is a full flag per
mailbox queue.

Version 2:
- Rebase to the latest.

Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    1 +
 arch/arm/plat-omap/mailbox.c              |   10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 9976565..261f6b8 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -48,6 +48,7 @@ struct omap_mbox_queue {
 	struct tasklet_struct	tasklet;
 	int	(*callback)(void *);
 	struct omap_mbox	*mbox;
+	bool	full;
 };
 
 struct omap_mbox {
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index d2fafb8..c59c9c3 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -33,7 +33,6 @@
 
 static struct workqueue_struct *mboxd;
 static struct omap_mbox **mboxes;
-static bool rq_full;
 
 static int mbox_configured;
 static DEFINE_MUTEX(mbox_configured_lock);
@@ -145,7 +144,12 @@ static void mbox_rx_work(struct work_struct *work)
 	while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
 		len = kfifo_out(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
 		WARN_ON(len != sizeof(msg));
-
+		spin_lock_irq(&mq->lock);
+		if (mq->full) {
+			omap_mbox_enable_irq(mq->mbox, IRQ_RX);
+			mq->full = false;
+		}
+		spin_unlock_irq(&mq->lock);
 		if (mq->callback)
 			mq->callback((void *)msg);
 	}
@@ -170,7 +174,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 	while (!mbox_fifo_empty(mbox)) {
 		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
 			omap_mbox_disable_irq(mbox, IRQ_RX);
-			rq_full = true;
+			mq->full = true;
 			goto nomem;
 		}
 
-- 
1.6.3.3

