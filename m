From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/10] omap: mailbox: Expose omap_mbox_enable()/disable_irq()
Date: Wed, 18 Nov 2009 11:21:16 -0800
Message-ID: <20091118192115.31148.73960.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50891 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932636AbZKRTVO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 14:21:14 -0500
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Expose omap_mbox_enable()/disable_irq()

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |   12 ++++++++++++
 arch/arm/plat-omap/mailbox.c              |   12 ++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 8260a3f..bf06953 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
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
index 99ecf80..e6b3115 100644
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

