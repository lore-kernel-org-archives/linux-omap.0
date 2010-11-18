From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH v3 1/5] OMAP: mailbox: change full flag per mailbox queue instead of global
Date: Thu, 18 Nov 2010 13:15:38 -0600
Message-ID: <1290107742-16760-2-git-send-email-h-kanigeri2@ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43244 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab0KRTNs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 14:13:48 -0500
In-Reply-To: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

As pointed by Ohad Ben-Cohen, the variable rq_full flag is a
global variable, so if there are multiple mailbox users
there will be conflics. Now there is a full flag per
mailbox queue.

Version 2:
- Rebase to the latest.
Version 3:
- Remove spin_lock protection. When the full flag is
true the interrupt for that mailbox is disabled. So there
is no race condition if full flag is modified before
calling omap_mbox_enable_irq.

Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    1 +
 arch/arm/plat-omap/mailbox.c              |    7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 9976565..13f2ef3 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -48,6 +48,7 @@ struct omap_mbox_queue {
 	struct tasklet_struct	tasklet;
 	int	(*callback)(void *);
 	struct omap_mbox	*mbox;
+	bool full;
 };
 
 struct omap_mbox {
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index d2fafb8..9ce3570 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -33,7 +33,6 @@
 
 static struct workqueue_struct *mboxd;
 static struct omap_mbox **mboxes;
-static bool rq_full;
 
 static int mbox_configured;
 static DEFINE_MUTEX(mbox_configured_lock);
@@ -148,6 +147,10 @@ static void mbox_rx_work(struct work_struct *work)
 
 		if (mq->callback)
 			mq->callback((void *)msg);
+		if (mq->full) {
+			mq->full = false;
+			omap_mbox_enable_irq(mq->mbox, IRQ_RX);
+		}
 	}
 }
 
@@ -170,7 +173,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 	while (!mbox_fifo_empty(mbox)) {
 		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
 			omap_mbox_disable_irq(mbox, IRQ_RX);
-			rq_full = true;
+			mq->full = true;
 			goto nomem;
 		}
 
-- 
1.7.0

