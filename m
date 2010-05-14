From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/17] omap: mailbox: trivial whitespace cleanups
Date: Fri, 14 May 2010 18:01:34 +0300
Message-ID: <1273849310-32169-2-git-send-email-felipe.contreras@gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:31925 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab0ENPCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 11:02:05 -0400
Received: by ey-out-2122.google.com with SMTP id d26so283220eyd.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 08:02:04 -0700 (PDT)
In-Reply-To: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

FWIW I think this should be squashed to the commits that introduced these
problems.

 arch/arm/plat-omap/mailbox.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index c549af3..8cb82c7 100644
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
 
-- 
1.7.1

