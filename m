From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 5/7] omap:mailbox-resolve multiple receiver problem
Date: Thu, 14 Oct 2010 21:13:26 -0500
Message-ID: <1287108808-32119-6-git-send-email-h-kanigeri2@ti.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59507 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755839Ab0JOCN0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Oct 2010 22:13:26 -0400
In-Reply-To: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Hari Kanigeri <h-kanigeri2@ti.com>, Ramesh Gupta <grgupta@ti.com>, "Subramaniam C.A" <subramaniam.ca@ti.com>

OMAP4 shares one interrupt line for all the mailbox instances.
The ISR is handling only the mailbox instance that was registered last.
So if both mailbox instances are running at the same time, the first mailbox
that registered wouldn't get the mailbox message. The same issue is present
in Transmit Interrupt case too. Only the last registered mailbox is handled.

The fix is to iterate through the list of mailboxes that were registered
checking for the mailbox TX and RX interrupt source.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Ramesh Gupta <grgupta@ti.com>
Signed-off-by: Subramaniam C.A <subramaniam.ca@ti.com>
---
 arch/arm/plat-omap/mailbox.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index a4170c7..1727548 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -174,6 +174,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 	struct omap_mbox_queue *mq = mbox->rxq;
 	mbox_msg_t msg;
 	int len;
+	bool msg_rx = false;
 
 	while (!mbox_fifo_empty(mbox)) {
 		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
@@ -181,7 +182,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 			mq->full = true;
 			goto nomem;
 		}
-
+		msg_rx = true;
 		msg = mbox_fifo_read(mbox);
 
 		len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
@@ -192,21 +193,25 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 	}
 
 	/* no more messages in the fifo. clear IRQ source. */
-	ack_mbox_irq(mbox, IRQ_RX);
+	if (msg_rx)
+		ack_mbox_irq(mbox, IRQ_RX);
 nomem:
-	queue_work(mboxd, &mbox->rxq->work);
+	if (msg_rx)
+		queue_work(mboxd, &mbox->rxq->work);
 }
 
 static irqreturn_t mbox_interrupt(int irq, void *p)
 {
 	struct omap_mbox *mbox = p;
 
-	if (is_mbox_irq(mbox, IRQ_TX))
-		__mbox_tx_interrupt(mbox);
-
-	if (is_mbox_irq(mbox, IRQ_RX))
-		__mbox_rx_interrupt(mbox);
+	for (i = 0; mboxes[i]; i++)  {
+		struct omap_mbox *mbox = mboxes[i];
+		if (is_mbox_irq(mbox, IRQ_TX))
+			__mbox_tx_interrupt(mbox);
 
+		if (is_mbox_irq(mbox, IRQ_RX))
+			__mbox_rx_interrupt(mbox);
+	}
 	return IRQ_HANDLED;
 }
 
-- 
1.7.0

