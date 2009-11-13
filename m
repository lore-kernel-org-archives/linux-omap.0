From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 5/10] omap: mailbox: remove disable_/enable_mbox_irq in isr
Date: Fri, 13 Nov 2009 18:01:11 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C4994@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49629 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbZKMMay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 07:30:54 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>

>From 977b46afb3d52422d486458c6c7889c9ce906b3d Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Thu, 12 Nov 2009 16:18:05 -0800
Subject: [PATCH 5/10] omap: mailbox: remove disable_/enable_mbox_irq in isr

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
-- 
1.5.3.2
