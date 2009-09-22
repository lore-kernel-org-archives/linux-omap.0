From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 7/10] omap mailbox: expose omap_mbox_enable()/disable_irq()
Date: Tue, 22 Sep 2009 20:02:43 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921E2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39803 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756656AbZIVOcm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 10:32:42 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

>From 1ba55e567917b48afc64a14202fd860b3332056d Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Wed, 2 Sep 2009 20:18:53 +0530
Subject: [PATCH 7/10] omap mailbox: expose omap_mbox_enable()/disable_irq()

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/mach/mailbox.h |   12 ++++++++++++
 arch/arm/plat-omap/mailbox.c              |   12 ++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mailbox.h b/arch/arm/plat-omap/include/mach/mailbox.h
index 8260a3f..bf06953 100644
--- a/arch/arm/plat-omap/include/mach/mailbox.h
+++ b/arch/arm/plat-omap/include/mach/mailbox.h
@@ -92,4 +92,16 @@ static inline void omap_mbox_restore_ctx(struct omap_mbox *mbox)
 	mbox->ops->restore_ctx(mbox);
 }
 
+static inline void omap_mbox_enable_irq(struct omap_mbox *mbox,
+					omap_mbox_irq_t irq)
+{
+	mbox->ops->enable_irq(mbox, irq);
+}
+
+static inline void omap_mbox_disable_irq(struct omap_mbox *mbox,
+					 omap_mbox_irq_t irq)
+{
+	mbox->ops->disable_irq(mbox, irq);
+}
+
 #endif /* MAILBOX_H */
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 2899255..032f1fe 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -50,14 +50,6 @@ static inline int mbox_fifo_full(struct omap_mbox *mbox)
 }
 
 /* Mailbox IRQ handle functions */
-static inline void enable_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
-{
-	mbox->ops->enable_irq(mbox, irq);
-}
-static inline void disable_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
-{
-	mbox->ops->disable_irq(mbox, irq);
-}
 static inline void ack_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	if (mbox->ops->ack_irq)
@@ -144,7 +136,7 @@ static void mbox_tx_work(struct work_struct *work)
 
 		ret = __mbox_msg_send(mbox, tx_data->msg);
 		if (ret) {
-			enable_mbox_irq(mbox, IRQ_TX);
+			omap_mbox_enable_irq(mbox, IRQ_TX);
 			spin_lock(q->queue_lock);
 			blk_requeue_request(q, rq);
 			spin_unlock(q->queue_lock);
@@ -196,7 +188,7 @@ static void mbox_rxq_fn(struct request_queue *q)
 
 static void __mbox_tx_interrupt(struct omap_mbox *mbox)
 {
-	disable_mbox_irq(mbox, IRQ_TX);
+	omap_mbox_disable_irq(mbox, IRQ_TX);
 	ack_mbox_irq(mbox, IRQ_TX);
 	schedule_work(&mbox->txq->work);
 }
-- 
1.5.3.2
