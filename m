From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 5/10] omap mailbox: remove disalbe_/enable_mbox_irq in isr
Date: Fri, 4 Sep 2009 17:18:01 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108EF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58014 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755965AbZIDLrT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 07:47:19 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

>From 20a90cfa9b06b70c495f1699825dd9fded381949 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Wed, 2 Sep 2009 20:06:38 +0530
Subject: [PATCH 5/10] omap mailbox: remove disalbe_/enable_mbox_irq in isr

No need to handle it in isr, since irq won't happen during isr.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 6e713a7..8a6d087 100644
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
