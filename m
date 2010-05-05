From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Wed,  5 May 2010 18:33:09 +0300
Message-ID: <1273073589-2485-5-git-send-email-ohad@wizery.com>
References: <1273073589-2485-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:5037 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760372Ab0EEPeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 11:34:00 -0400
Received: by fg-out-1718.google.com with SMTP id d23so23396fga.1
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 08:33:59 -0700 (PDT)
In-Reply-To: <1273073589-2485-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

The underlying buffering implementation of mailbox
is converted from block API to kfifo due to the simplicity
and speed of kfifo.

The default size of the kfifo buffer is set to 256 bytes.
This value is configurable at compile time (via
CONFIG_OMAP_MBOX_KFIFO_SIZE), and can be changed at
runtime (via the mbox_kfifo_size module parameter).

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
If you want, you can also reach me at < ohadb at ti dot com >.

 arch/arm/plat-omap/Kconfig                |    9 +++
 arch/arm/plat-omap/include/plat/mailbox.h |    4 +-
 arch/arm/plat-omap/mailbox.c              |  112 +++++++++++++---------------
 3 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6da796e..f4b0029 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -106,6 +106,15 @@ config OMAP_MBOX_FWK
 	  Say Y here if you want to use OMAP Mailbox framework support for
 	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
 
+config OMAP_MBOX_KFIFO_SIZE
+	int "Mailbox kfifo default buffer size (bytes)"
+	depends on OMAP_MBOX_FWK
+	default 256
+	help
+	  Specify the default size of mailbox's kfifo buffers (bytes).
+	  This can also be changed at runtime (via the mbox_kfifo_size
+	  module parameter).
+
 config OMAP_IOMMU
 	tristate
 
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 729166b..0c3c4a5 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -5,8 +5,8 @@
 
 #include <linux/wait.h>
 #include <linux/workqueue.h>
-#include <linux/blkdev.h>
 #include <linux/interrupt.h>
+#include <linux/kfifo.h>
 
 typedef u32 mbox_msg_t;
 struct omap_mbox;
@@ -42,7 +42,7 @@ struct omap_mbox_ops {
 
 struct omap_mbox_queue {
 	spinlock_t		lock;
-	struct request_queue	*queue;
+	struct kfifo		fifo;
 	struct work_struct	work;
 	struct tasklet_struct	tasklet;
 	int	(*callback)(void *);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 7c60550..908d9d2 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -21,11 +21,14 @@
  *
  */
 
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/kfifo.h>
+#include <linux/err.h>
 
 #include <plat/mailbox.h>
 
@@ -35,6 +38,10 @@ static DEFINE_SPINLOCK(mboxes_lock);
 
 static int mbox_configured;
 
+static unsigned int mbox_kfifo_size = CONFIG_OMAP_MBOX_KFIFO_SIZE;
+module_param(mbox_kfifo_size, uint, S_IRUGO);
+MODULE_PARM_DESC(mbox_kfifo_size, "Size of omap's mailbox kfifo (bytes)");
+
 /* Mailbox FIFO handle functions */
 static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
 {
@@ -67,7 +74,7 @@ static inline int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 /*
  * message sender
  */
-static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
+static int __mbox_poll_for_space(struct omap_mbox *mbox)
 {
 	int ret = 0, i = 1000;
 
@@ -78,49 +85,50 @@ static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
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
+	WARN_ON(len != sizeof(msg));
 
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
+		WARN_ON(ret != sizeof(msg));
+
+		mbox_fifo_write(mbox, msg);
 	}
 }
 
@@ -131,36 +139,21 @@ static void mbox_rx_work(struct work_struct *work)
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
+		WARN_ON(len != sizeof(msg));
 
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
@@ -170,19 +163,19 @@ static void __mbox_tx_interrupt(struct omap_mbox *mbox)
 
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
 
+		len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
+		WARN_ON(len != sizeof(msg));
 
-		blk_insert_request(q, rq, 0, (void *)msg);
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
+	if (kfifo_alloc(&mq->fifo, mbox_kfifo_size, GFP_KERNEL))
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
@@ -407,6 +395,10 @@ static int __init omap_mbox_init(void)
 	if (!mboxd)
 		return -ENOMEM;
 
+	/* kfifo size sanity check: alignment and minimal size */
+	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(mbox_msg_t));
+	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(mbox_msg_t));
+
 	return 0;
 }
 module_init(omap_mbox_init);
-- 
1.6.3.3

