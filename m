From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2t2 01/17] omap: mailbox: trivial whitespace cleanups
Date: Sat, 22 May 2010 00:44:33 +0300
Message-ID: <1274478289-22188-2-git-send-email-felipe.contreras@gmail.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40510 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab0EUVo5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 17:44:57 -0400
Received: by fxm5 with SMTP id 5so1251271fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 14:44:56 -0700 (PDT)
In-Reply-To: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/mailbox.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 36b3aa2..7877bbb 100644
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

