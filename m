From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 10/10] omap mailbox: OMAP4 Mailbox-driver Patch to support
 tasklet implementation
Date: Fri, 4 Sep 2009 17:18:45 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108F6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32994 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756727AbZIDLr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 07:47:59 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

>From e759173e77f73fabce5177b4f685df20b16c6922 Mon Sep 17 00:00:00 2001
From: C A Subramaniam <subramaniam.ca@ti.com>
Date: Thu, 3 Sep 2009 17:42:35 +0530
Subject: [PATCH 10/10] omap mailbox: OMAP4 Mailbox-driver Patch to support tasklet
   implementation

This patch uses a tasklet implementation for
sending mailbox messages.

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/mach-omap2/mailbox.c             |   43 ++++++++++-----
 arch/arm/plat-omap/include/mach/mailbox.h |   16 +++++-
 arch/arm/plat-omap/mailbox.c              |   80 ++++++++++++++---------------
 3 files changed, 81 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 52a1670..45aea98 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -236,6 +237,17 @@ static struct omap_mbox_ops omap2_mbox_ops = {
 	.restore_ctx	= omap2_mbox_restore_ctx,
 };
 
+
+static struct omap_mbox_task omap_mbox_1_tasklet = {
+	.arg	= NULL,
+};
+
+static struct omap_mbox_task omap_mbox_2_tasklet = {
+	.arg	= NULL,
+};
+
+
+
 /*
  * MAILBOX 0: ARM -> DSP,
  * MAILBOX 1: ARM <- DSP.
@@ -272,6 +284,7 @@ struct omap_mbox mbox_1_info = {
 	.name	= "mailbox-1",
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_1_priv,
+	.tx_tasklet = &omap_mbox_1_tasklet,
 };
 EXPORT_SYMBOL(mbox_1_info);
 #else
@@ -305,8 +318,10 @@ struct omap_mbox mbox_2_info = {
 	.name	= "mailbox-2",
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_2_priv,
+	.tx_tasklet = &omap_mbox_2_tasklet,
 };
 EXPORT_SYMBOL(mbox_2_info);
+
 #endif
 
 
diff --git a/arch/arm/plat-omap/include/mach/mailbox.h b/arch/arm/plat-omap/include/mach/mailbox.h
index bf06953..5271345 100644
--- a/arch/arm/plat-omap/include/mach/mailbox.h
+++ b/arch/arm/plat-omap/include/mach/mailbox.h
@@ -28,8 +28,10 @@ struct omap_mbox_ops {
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
@@ -45,12 +47,22 @@ struct omap_mbox_queue {
 	struct omap_mbox	*mbox;
 };
 
+struct omap_mbox_task{
+	spinlock_t		lock;
+	struct tasklet_struct	*t;
+	mbox_msg_t		msg;
+	void			*arg;
+};
+
+
 struct omap_mbox {
 	char			*name;
 	unsigned int		irq;
 
 	struct omap_mbox_queue	*txq, *rxq;
 
+	struct omap_mbox_task	*tx_tasklet;
+
 	struct omap_mbox_ops	*ops;
 
 	mbox_msg_t		seq_snd, seq_rcv;
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 84cf6af..b5e53d4 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -63,60 +63,49 @@ static inline int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 /*
  * message sender
  */
-static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
+static void __mbox_msg_send(unsigned long tx)
 {
+	struct omap_mbox_task *tx_data  =  (struct omap_mbox_task *)tx;
+	struct omap_mbox *mbox = (struct omap_mbox *)tx_data->arg;
+	mbox_msg_t msg = tx_data->msg;
 	int ret = 0, i = 1000;
 
 	while (mbox_fifo_full(mbox)) {
-		if (mbox->ops->type == OMAP_MBOX_TYPE2)
-			return -1;
-		if (--i == 0)
-			return -1;
+		if (mbox->ops->type == OMAP_MBOX_TYPE2) {
+			printk(KERN_ERR "Invalid mailbox type\n");
+			return ;
+		}
+		if (--i == 0) {
+			printk(KERN_ERR "Time out writing to mailbox\n");
+			return ;
+		}
 		udelay(1);
 	}
 	mbox_fifo_write(mbox, msg);
-	return ret;
-}
-
-struct omap_msg_tx_data {
-	mbox_msg_t	msg;
-	void		*arg;
-};
+	tx_data->arg = NULL;
+	spin_unlock(&(mbox->tx_tasklet->lock));
 
-static void omap_msg_tx_end_io(struct request *rq, int error)
-{
-	kfree(rq->special);
-	__blk_put_request(rq->q, rq);
+	return;
 }
 
+
 int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 {
-	struct omap_msg_tx_data *tx_data;
-	struct request *rq;
-	struct request_queue *q = mbox->txq->queue;
+	struct omap_mbox_task *tx_task = mbox->tx_tasklet;
 
-	tx_data = kmalloc(sizeof(*tx_data), GFP_ATOMIC);
-	if (unlikely(!tx_data))
-		return -ENOMEM;
-
-	rq = blk_get_request(q, WRITE, GFP_ATOMIC);
-	if (unlikely(!rq)) {
-		kfree(tx_data);
-		return -ENOMEM;
-	}
+	spin_lock(&(mbox->tx_tasklet->lock));
+	tx_task->arg = (void *)mbox;
+	tx_task->msg = msg;
 
-	tx_data->msg = msg;
-	rq->end_io = omap_msg_tx_end_io;
-	blk_insert_request(q, rq, 0, tx_data);
+	tasklet_schedule(tx_task->t);
 
-	schedule_work(&mbox->txq->work);
 	return 0;
 }
 EXPORT_SYMBOL(omap_mbox_msg_send);
 
 static void mbox_tx_work(struct work_struct *work)
 {
-	int ret;
+	int ret = 0;
 	struct request *rq;
 	struct omap_mbox_queue *mq = container_of(work,
 				struct omap_mbox_queue, work);
@@ -124,8 +113,6 @@ static void mbox_tx_work(struct work_struct *work)
 	struct request_queue *q = mbox->txq->queue;
 
 	while (1) {
-		struct omap_msg_tx_data *tx_data;
-
 		spin_lock(q->queue_lock);
 		rq = blk_fetch_request(q);
 		spin_unlock(q->queue_lock);
@@ -133,9 +120,6 @@ static void mbox_tx_work(struct work_struct *work)
 		if (!rq)
 			break;
 
-		tx_data = rq->special;
-
-		ret = __mbox_msg_send(mbox, tx_data->msg);
 		if (ret) {
 			omap_mbox_enable_irq(mbox, IRQ_TX);
 			spin_lock(q->queue_lock);
@@ -206,7 +190,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 			goto nomem;
 
 		msg = mbox_fifo_read(mbox);
-
+		rq->special = (void *)msg;
 
 		blk_insert_request(q, rq, 0, (void *)msg);
 		if (mbox->ops->type == OMAP_MBOX_TYPE1)
@@ -298,13 +282,25 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	}
 	mbox->rxq = mq;
 
+	mbox->tx_tasklet->t =  kzalloc(sizeof(struct tasklet_struct),
+					GFP_KERNEL);
+	if (!mbox->tx_tasklet->t) {
+		ret = -ENOMEM;
+		goto fail_alloc_tasklet;
+	}
+	spin_lock_init(&mbox->tx_tasklet->lock);
+	tasklet_init(mbox->tx_tasklet->t, __mbox_msg_send,
+				(unsigned long)mbox->tx_tasklet);
+
 	return 0;
 
- fail_alloc_rxq:
+fail_alloc_tasklet:
+	mbox_queue_free(mbox->rxq);
+fail_alloc_rxq:
 	mbox_queue_free(mbox->txq);
- fail_alloc_txq:
+fail_alloc_txq:
 	free_irq(mbox->irq, mbox);
- fail_request_irq:
+fail_request_irq:
 	if (unlikely(mbox->ops->shutdown))
 		mbox->ops->shutdown(mbox);
 
-- 
1.5.3.2
