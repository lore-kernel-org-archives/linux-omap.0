From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH v2 5/5] Mailbox: disable mailbox interrupt when request queue
Date: Thu, 18 Feb 2010 01:10:19 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9B2F@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39190 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab0BRHKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 02:10:30 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

>From 79f2b477b19c49b36c51e8589c0a3d52ecd9ec99 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 8 Feb 2010 13:35:40 -0600
Subject: [PATCH] Mailbox: disable mailbox interrupt when request queue

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
index 8ecb837..8d86b0b 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -30,6 +30,7 @@
 
 static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
+static bool rq_full;
 
 static int mbox_configured;
 static DEFINE_MUTEX(mbox_configured_lock);
@@ -139,6 +140,10 @@ static void mbox_rx_work(struct work_struct *work)
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
@@ -176,8 +181,11 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 
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

