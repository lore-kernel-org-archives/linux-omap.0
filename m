From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 6/6] Mailbox: disable mailbox interrupt when request queue
 failed
Date: Fri, 12 Feb 2010 19:43:29 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA7C18DC@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52871 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab0BMBnd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 20:43:33 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

>From a7b162f3af04bbfa39c439c47b8499962410a9c9 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 8 Feb 2010 13:35:40 -0600
Subject: [PATCH] Mailbox: disable mailbox interrupt when request queue failed

when blk_get_request fails to get the request it is returning
without read the message from the mailbox fifo, then when it
leaves the isr and interruption is trigger again and again and
the workqueue which get elements from the request queue is never
executed and the kernel is stuck and shows a softlockup message.
Now the mailbox interrupt is disabled when request queue is full
and enabled when it pop a elememt form the request queue.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/mailbox.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index d8bfa45..efcf3e7 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -30,6 +30,7 @@
 
 static struct omap_mbox *mboxes;
 static DECLARE_RWSEM(mboxes_sem);
+static bool rq_full;
 
 static int mbox_configured;
 
@@ -138,6 +139,10 @@ static void mbox_rx_work(struct work_struct *work)
 	while (1) {
 		spin_lock_irqsave(q->queue_lock, flags);
 		rq = blk_fetch_request(q);
+		if (rq_full) {
+			omap_mbox_enable_irq(mbox, IRQ_RX);
+			rq_full = false;
+		}
 		spin_unlock_irqrestore(q->queue_lock, flags);
 		if (!rq)
 			break;
@@ -175,8 +180,11 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 
 	while (!mbox_fifo_empty(mbox)) {
 		rq = blk_get_request(q, WRITE, GFP_ATOMIC);
-		if (unlikely(!rq))
+		if (unlikely(!rq)) {
+			omap_mbox_disable_irq(mbox, IRQ_RX);
+			rq_full = true;
 			goto nomem;
+		}
 
 		msg = mbox_fifo_read(mbox);
 
-- 
1.6.0.4

