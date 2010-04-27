From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 27 Apr 2010 20:56:22 +0300
Message-ID: <1272390982-14882-5-git-send-email-ohad@wizery.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:4458 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410Ab0D0R6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 13:58:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2795216fgg.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 10:58:47 -0700 (PDT)
In-Reply-To: <1272390982-14882-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

The underlying buffering implementation of mailbox
is converted from block API to kfifo due to the simplicity
and speed of kfifo.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    5 +-
 arch/arm/plat-omap/mailbox.c              |  108 +++++++++++++----------------
 2 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 729166b..014cc58 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -7,6 +7,7 @@
 #include <linux/workqueue.h>
 #include <linux/blkdev.h>
 #include <linux/interrupt.h>
+#include <linux/kfifo.h>
 
 typedef u32 mbox_msg_t;
 struct omap_mbox;
@@ -19,6 +20,8 @@ typedef int __bitwise omap_mbox_type_t;
 #define OMAP_MBOX_TYPE1 ((__force omap_mbox_type_t) 1)
 #define OMAP_MBOX_TYPE2 ((__force omap_mbox_type_t) 2)
 
+#define MBOX_KFIFO_SIZE	(256)
+
 struct omap_mbox_ops {
 	omap_mbox_type_t	type;
 	int		(*startup)(struct omap_mbox *mbox);
@@ -42,7 +45,7 @@ struct omap_mbox_ops {
 
 struct omap_mbox_queue {
 	spinlock_t		lock;
-	struct request_queue	*queue;
+	struct kfifo		fifo;
 	struct work_struct	work;
 	struct tasklet_struct	tasklet;
 	int	(*callback)(void *);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 72b17ad..b1324f3 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/kfifo.h>
 
 #include <plat/mailbox.h>
 
@@ -67,7 +68,7 @@ static inline int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 /*
  * message sender
  */
-static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
+static int __mbox_poll_for_space(struct omap_mbox *mbox)
 {
 	int ret = 0, i = 1000;
 
@@ -78,49 +79,54 @@ static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 			return -1;
 		udelay(1);
 	}
-	mbox_fifo_write(mbox, msg);
 	return ret;
 }
 
-
 int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 {
+	struct omap_mbox_queue *mq = mbox->txq;
+	int ret = 0, len;
 
-	struct request *rq;
-	struct request_queue *q = mbox->txq->queue;
+	spin_lock(&mq->lock);
 
-	rq = blk_get_request(q, WRITE, GFP_ATOMIC);
-	if (unlikely(!rq))
-		return -ENOMEM;
+	if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
+	if (unlikely(len != sizeof(msg))) {
+		pr_err("%s: kfifo_in anomaly\n", __func__);
+		ret = -ENOMEM;
+	}
 
-	blk_insert_request(q, rq, 0, (void *) msg);
 	tasklet_schedule(&mbox->txq->tasklet);
 
-	return 0;
+out:
+	spin_unlock(&mq->lock);
+	return ret;
 }
 EXPORT_SYMBOL(omap_mbox_msg_send);
 
 static void mbox_tx_tasklet(unsigned long tx_data)
 {
-	int ret;
-	struct request *rq;
 	struct omap_mbox *mbox = (struct omap_mbox *)tx_data;
-	struct request_queue *q = mbox->txq->queue;
-
-	while (1) {
-
-		rq = blk_fetch_request(q);
-
-		if (!rq)
-			break;
+	struct omap_mbox_queue *mq = mbox->txq;
+	mbox_msg_t msg;
+	int ret;
 
-		ret = __mbox_msg_send(mbox, (mbox_msg_t)rq->special);
-		if (ret) {
+	while (kfifo_len(&mq->fifo)) {
+		if (__mbox_poll_for_space(mbox)) {
 			omap_mbox_enable_irq(mbox, IRQ_TX);
-			blk_requeue_request(q, rq);
-			return;
+			break;
 		}
-		blk_end_request_all(rq, 0);
+
+		ret = kfifo_out(&mq->fifo, (unsigned char *)&msg,
+								sizeof(msg));
+		if (unlikely(ret != sizeof(msg)))
+			pr_err("%s: kfifo_out anomaly\n", __func__);
+
+		mbox_fifo_write(mbox, msg);
 	}
 }
 
@@ -131,36 +137,22 @@ static void mbox_rx_work(struct work_struct *work)
 {
 	struct omap_mbox_queue *mq =
 			container_of(work, struct omap_mbox_queue, work);
-	struct omap_mbox *mbox = mq->queue->queuedata;
-	struct request_queue *q = mbox->rxq->queue;
-	struct request *rq;
 	mbox_msg_t msg;
-	unsigned long flags;
+	int len;
 
-	while (1) {
-		spin_lock_irqsave(q->queue_lock, flags);
-		rq = blk_fetch_request(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-		if (!rq)
-			break;
+	while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
+		len = kfifo_out(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
+		if (unlikely(len != sizeof(msg)))
+			pr_err("%s: kfifo_out anomaly detected\n", __func__);
 
-		msg = (mbox_msg_t)rq->special;
-		blk_end_request_all(rq, 0);
-		mbox->rxq->callback((void *)msg);
+		if (mq->callback)
+			mq->callback((void *)msg);
 	}
 }
 
 /*
  * Mailbox interrupt handler
  */
-static void mbox_txq_fn(struct request_queue *q)
-{
-}
-
-static void mbox_rxq_fn(struct request_queue *q)
-{
-}
-
 static void __mbox_tx_interrupt(struct omap_mbox *mbox)
 {
 	omap_mbox_disable_irq(mbox, IRQ_TX);
@@ -170,19 +162,20 @@ static void __mbox_tx_interrupt(struct omap_mbox *mbox)
 
 static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 {
-	struct request *rq;
+	struct omap_mbox_queue *mq = mbox->rxq;
 	mbox_msg_t msg;
-	struct request_queue *q = mbox->rxq->queue;
+	int len;
 
 	while (!mbox_fifo_empty(mbox)) {
-		rq = blk_get_request(q, WRITE, GFP_ATOMIC);
-		if (unlikely(!rq))
+		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg)))
 			goto nomem;
 
 		msg = mbox_fifo_read(mbox);
 
 
-		blk_insert_request(q, rq, 0, (void *)msg);
+		len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
+		if (unlikely(len != sizeof(msg)))
+			pr_err("%s: kfifo_in anomaly detected\n", __func__);
 		if (mbox->ops->type == OMAP_MBOX_TYPE1)
 			break;
 	}
@@ -207,11 +200,9 @@ static irqreturn_t mbox_interrupt(int irq, void *p)
 }
 
 static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
-					request_fn_proc *proc,
 					void (*work) (struct work_struct *),
 					void (*tasklet)(unsigned long))
 {
-	struct request_queue *q;
 	struct omap_mbox_queue *mq;
 
 	mq = kzalloc(sizeof(struct omap_mbox_queue), GFP_KERNEL);
@@ -220,11 +211,8 @@ static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 
 	spin_lock_init(&mq->lock);
 
-	q = blk_init_queue(proc, &mq->lock);
-	if (!q)
+	if (kfifo_alloc(&mq->fifo, MBOX_KFIFO_SIZE, GFP_KERNEL))
 		goto error;
-	q->queuedata = mbox;
-	mq->queue = q;
 
 	if (work)
 		INIT_WORK(&mq->work, work);
@@ -239,7 +227,7 @@ error:
 
 static void mbox_queue_free(struct omap_mbox_queue *q)
 {
-	blk_cleanup_queue(q->queue);
+	kfifo_free(&q->fifo);
 	kfree(q);
 }
 
@@ -269,14 +257,14 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 		goto fail_request_irq;
 	}
 
-	mq = mbox_queue_alloc(mbox, mbox_txq_fn, NULL, mbox_tx_tasklet);
+	mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
 	if (!mq) {
 		ret = -ENOMEM;
 		goto fail_alloc_txq;
 	}
 	mbox->txq = mq;
 
-	mq = mbox_queue_alloc(mbox, mbox_rxq_fn, mbox_rx_work, NULL);
+	mq = mbox_queue_alloc(mbox, mbox_rx_work, NULL);
 	if (!mq) {
 		ret = -ENOMEM;
 		goto fail_alloc_rxq;
-- 
1.6.3.3

