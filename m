From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 05/10] Mailbox: disable mailbox interrupt when request queue
Date: Thu,  3 Jun 2010 09:34:13 +0300
Message-ID: <1275546858-29507-6-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35450 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933385Ab0FCGfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 02:35:22 -0400
In-Reply-To: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

when blk_get_request fails to get the request it is returning
without read the message from the mailbox fifo, then when it
leaves the isr and interruption is trigger again and again and
the workqueue which get elements from the request queue is never
executed and the kernel is stuck and shows a softlockup message.
Now the mailbox interrupt is disabled when request queue is full
and enabled when it pop a elememt form the request queue.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 986002b..c340216 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -32,6 +32,7 @@
 static struct workqueue_struct *mboxd;
 static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
+static bool rq_full;
 
 static int mbox_configured;
 static DEFINE_MUTEX(mbox_configured_lock);
@@ -141,6 +142,10 @@ static void mbox_rx_work(struct work_struct *work)
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
@@ -178,8 +183,11 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 
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
1.7.1.rc1

