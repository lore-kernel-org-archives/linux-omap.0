From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/10] omap: mailbox: remove disable_/enable_mbox_irq in isr
Date: Wed, 18 Nov 2009 11:20:52 -0800
Message-ID: <20091118192052.31148.94100.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50311 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932559AbZKRTUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 14:20:49 -0500
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

No need to handle it in isr, since irq won't happen during isr.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mailbox.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 13ca236..b49bb29 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -209,8 +209,6 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 	mbox_msg_t msg;
 	struct request_queue *q = mbox->rxq->queue;
 
-	disable_mbox_irq(mbox, IRQ_RX);
-
 	while (!mbox_fifo_empty(mbox)) {
 		rq = blk_get_request(q, WRITE, GFP_ATOMIC);
 		if (unlikely(!rq))
@@ -226,7 +224,6 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 
 	/* no more messages in the fifo. clear IRQ source. */
 	ack_mbox_irq(mbox, IRQ_RX);
-	enable_mbox_irq(mbox, IRQ_RX);
 nomem:
 	schedule_work(&mbox->rxq->work);
 }

