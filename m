From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/10] omap: mailbox: OMAP4 Mailbox-driver Patch to support
	tasklet implementation
Date: Wed, 18 Nov 2009 11:21:52 -0800
Message-ID: <20091118192152.31148.69206.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51781 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394AbZKRTVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 14:21:50 -0500
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ramesh Gupta G <grgupta@ti.com>, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, C A Subramaniam <subramaniam.ca@ti.com>

From: C A Subramaniam <subramaniam.ca@ti.com>

This patch uses a tasklet implementation for
sending mailbox messages.

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    8 +++-
 arch/arm/plat-omap/mailbox.c              |   59 ++++++++---------------------
 2 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index bf06953..729166b 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -6,6 +6,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/blkdev.h>
+#include <linux/interrupt.h>
 
 typedef u32 mbox_msg_t;
 struct omap_mbox;
@@ -28,8 +29,10 @@ struct omap_mbox_ops {
 	int		(*fifo_empty)(struct omap_mbox *mbox);
 	int		(*fifo_full)(struct omap_mbox *mbox);
 	/* irq */
-	void		(*enable_irq)(struct omap_mbox *mbox, omap_mbox_irq_t irq);
-	void		(*disable_irq)(struct omap_mbox *mbox, omap_mbox_irq_t irq);
+	void		(*enable_irq)(struct omap_mbox *mbox,
+						omap_mbox_irq_t irq);
+	void		(*disable_irq)(struct omap_mbox *mbox,
+						omap_mbox_irq_t irq);
 	void		(*ack_irq)(struct omap_mbox *mbox, omap_mbox_irq_t irq);
 	int		(*is_irq)(struct omap_mbox *mbox, omap_mbox_irq_t irq);
 	/* ctx */
@@ -41,6 +44,7 @@ struct omap_mbox_queue {
 	spinlock_t		lock;
 	struct request_queue	*queue;
 	struct work_struct	work;
+	struct tasklet_struct	tasklet;
 	int	(*callback)(void *);
 	struct omap_mbox	*mbox;
 };
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 4d7947e..8e90633 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -80,74 +80,45 @@ static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 	return ret;
 }
 
-struct omap_msg_tx_data {
-	mbox_msg_t	msg;
-};
-
-static void omap_msg_tx_end_io(struct request *rq, int error)
-{
-	kfree(rq->special);
-	__blk_put_request(rq->q, rq);
-}
 
 int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 {
-	struct omap_msg_tx_data *tx_data;
+
 	struct request *rq;
 	struct request_queue *q = mbox->txq->queue;
 
-	tx_data = kmalloc(sizeof(*tx_data), GFP_ATOMIC);
-	if (unlikely(!tx_data))
-		return -ENOMEM;
-
 	rq = blk_get_request(q, WRITE, GFP_ATOMIC);
-	if (unlikely(!rq)) {
-		kfree(tx_data);
+	if (unlikely(!rq))
 		return -ENOMEM;
-	}
 
-	tx_data->msg = msg;
-	rq->end_io = omap_msg_tx_end_io;
-	blk_insert_request(q, rq, 0, tx_data);
+	blk_insert_request(q, rq, 0, (void *) msg);
+	tasklet_schedule(&mbox->txq->tasklet);
 
-	schedule_work(&mbox->txq->work);
 	return 0;
 }
 EXPORT_SYMBOL(omap_mbox_msg_send);
 
-static void mbox_tx_work(struct work_struct *work)
+static void mbox_tx_tasklet(unsigned long tx_data)
 {
 	int ret;
 	struct request *rq;
-	struct omap_mbox_queue *mq = container_of(work,
-				struct omap_mbox_queue, work);
-	struct omap_mbox *mbox = mq->queue->queuedata;
+	struct omap_mbox *mbox = (struct omap_mbox *)tx_data;
 	struct request_queue *q = mbox->txq->queue;
 
 	while (1) {
-		struct omap_msg_tx_data *tx_data;
 
-		spin_lock(q->queue_lock);
 		rq = blk_fetch_request(q);
-		spin_unlock(q->queue_lock);
 
 		if (!rq)
 			break;
 
-		tx_data = rq->special;
-
-		ret = __mbox_msg_send(mbox, tx_data->msg);
+		ret = __mbox_msg_send(mbox, (mbox_msg_t)rq->special);
 		if (ret) {
 			omap_mbox_enable_irq(mbox, IRQ_TX);
-			spin_lock(q->queue_lock);
 			blk_requeue_request(q, rq);
-			spin_unlock(q->queue_lock);
 			return;
 		}
-
-		spin_lock(q->queue_lock);
-		__blk_end_request_all(rq, 0);
-		spin_unlock(q->queue_lock);
+		blk_end_request_all(rq, 0);
 	}
 }
 
@@ -192,7 +163,7 @@ static void __mbox_tx_interrupt(struct omap_mbox *mbox)
 {
 	omap_mbox_disable_irq(mbox, IRQ_TX);
 	ack_mbox_irq(mbox, IRQ_TX);
-	schedule_work(&mbox->txq->work);
+	tasklet_schedule(&mbox->txq->tasklet);
 }
 
 static void __mbox_rx_interrupt(struct omap_mbox *mbox)
@@ -235,7 +206,8 @@ static irqreturn_t mbox_interrupt(int irq, void *p)
 
 static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 					request_fn_proc *proc,
-					void (*work) (struct work_struct *))
+					void (*work) (struct work_struct *),
+					void (*tasklet)(unsigned long))
 {
 	struct request_queue *q;
 	struct omap_mbox_queue *mq;
@@ -252,8 +224,11 @@ static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 	q->queuedata = mbox;
 	mq->queue = q;
 
-	INIT_WORK(&mq->work, work);
+	if (work)
+		INIT_WORK(&mq->work, work);
 
+	if (tasklet)
+		tasklet_init(&mq->tasklet, tasklet, (unsigned long)mbox);
 	return mq;
 error:
 	kfree(mq);
@@ -292,14 +267,14 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 		goto fail_request_irq;
 	}
 
-	mq = mbox_queue_alloc(mbox, mbox_txq_fn, mbox_tx_work);
+	mq = mbox_queue_alloc(mbox, mbox_txq_fn, NULL, mbox_tx_tasklet);
 	if (!mq) {
 		ret = -ENOMEM;
 		goto fail_alloc_txq;
 	}
 	mbox->txq = mq;
 
-	mq = mbox_queue_alloc(mbox, mbox_rxq_fn, mbox_rx_work);
+	mq = mbox_queue_alloc(mbox, mbox_rxq_fn, mbox_rx_work, NULL);
 	if (!mq) {
 		ret = -ENOMEM;
 		goto fail_alloc_rxq;

