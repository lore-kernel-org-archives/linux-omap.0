From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 01/14] omap: mailbox: trivial whitespace cleanups
Date: Fri, 11 Jun 2010 18:51:36 +0300
Message-ID: <1276271509-11983-2-git-send-email-felipe.contreras@gmail.com>
References: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:41041 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508Ab0FKPwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 11:52:23 -0400
Received: by wwb18 with SMTP id 18so872602wwb.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Jun 2010 08:52:20 -0700 (PDT)
In-Reply-To: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/mailbox.c |   44 +++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 36b3aa2..38a6cb1 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -142,14 +142,14 @@ static void mbox_rx_work(struct work_struct *work)
 	struct omap_mbox_queue *mq =
 			container_of(work, struct omap_mbox_queue, work);
 	mbox_msg_t msg;
- 	int len;
-  
- 	while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
- 		len = kfifo_out(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
- 		WARN_ON(len != sizeof(msg));
-
- 		if (mq->callback)
- 			mq->callback((void *)msg);
+	int len;
+
+	while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
+		len = kfifo_out(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
+		WARN_ON(len != sizeof(msg));
+
+		if (mq->callback)
+			mq->callback((void *)msg);
 	}
 }
 
@@ -165,12 +165,12 @@ static void __mbox_tx_interrupt(struct omap_mbox *mbox)
 
 static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 {
- 	struct omap_mbox_queue *mq = mbox->rxq;
+	struct omap_mbox_queue *mq = mbox->rxq;
 	mbox_msg_t msg;
- 	int len;
+	int len;
 
 	while (!mbox_fifo_empty(mbox)) {
- 		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
+		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
 			omap_mbox_disable_irq(mbox, IRQ_RX);
 			rq_full = true;
 			goto nomem;
@@ -178,8 +178,8 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 
 		msg = mbox_fifo_read(mbox);
 
- 		len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
- 		WARN_ON(len != sizeof(msg));
+		len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
+		WARN_ON(len != sizeof(msg));
 
 		if (mbox->ops->type == OMAP_MBOX_TYPE1)
 			break;
@@ -278,11 +278,11 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 
 	return 0;
 
- fail_alloc_rxq:
+fail_alloc_rxq:
 	mbox_queue_free(mbox->txq);
- fail_alloc_txq:
+fail_alloc_txq:
 	free_irq(mbox->irq, mbox);
- fail_request_irq:
+fail_request_irq:
 	if (mbox->ops->shutdown)
 		mbox->ops->shutdown(mbox);
 
@@ -359,10 +359,10 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 	if (mbox->next)
 		return -EBUSY;
 
- 	mbox->dev = device_create(&omap_mbox_class,
- 				  parent, 0, mbox, "%s", mbox->name);
- 	if (IS_ERR(mbox->dev))
- 		return PTR_ERR(mbox->dev);
+	mbox->dev = device_create(&omap_mbox_class,
+				  parent, 0, mbox, "%s", mbox->name);
+	if (IS_ERR(mbox->dev))
+		return PTR_ERR(mbox->dev);
 
 	spin_lock(&mboxes_lock);
 	tmp = find_mboxes(mbox->name);
@@ -405,7 +405,7 @@ EXPORT_SYMBOL(omap_mbox_unregister);
 
 static int __init omap_mbox_init(void)
 {
- 	int err;
+	int err;
 
 	err = class_register(&omap_mbox_class);
 	if (err)
@@ -426,7 +426,7 @@ subsys_initcall(omap_mbox_init);
 static void __exit omap_mbox_exit(void)
 {
 	destroy_workqueue(mboxd);
- 	class_unregister(&omap_mbox_class);
+	class_unregister(&omap_mbox_class);
 }
 module_exit(omap_mbox_exit);
 
-- 
1.7.1

