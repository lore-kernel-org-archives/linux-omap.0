From: "Anna, Suman" <s-anna@ti.com>
Subject: [PATCH 4/5] omap2/3/4: mailbox: use dedicated work queue for
 handling mailbox rx interrupt
Date: Thu, 18 Feb 2010 15:07:27 -0600
Message-ID: <2C1563023E232C49B9F505633D57C2DA2640D0235F@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53139 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab0BRVHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:07:33 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Clark, Rob" <rob@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

>From 7410bf2d5c569c83a594b99a62d03b939e4f10b8 Mon Sep 17 00:00:00 2001
From: Rob Clark <rob@ti.com>
Date: Mon, 4 Jan 2010 19:22:03 +0530
Subject: [PATCH 4/5] omap2/3/4: mailbox: use dedicated work queue for handling mailbox rx interrupt

keventd_wq is a shared work-queue, and should not be used when we
need fast deterministic response.  Instead mailbox driver should
use it's own private work-queue, with it's own thread, to ensure
that handling of RX interrupts are not delayed by other drivers.

The tasklet is still used for transmission of mbox messages.

Signed-off-by: Rob Clark <rob@ti.com>
Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 8e90633..4229cec 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -28,6 +28,7 @@
 
 #include <plat/mailbox.h>
 
+static struct workqueue_struct *mboxd;
 static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
 
@@ -188,7 +189,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 	/* no more messages in the fifo. clear IRQ source. */
 	ack_mbox_irq(mbox, IRQ_RX);
 nomem:
-	schedule_work(&mbox->rxq->work);
+	queue_work(mboxd, &mbox->rxq->work);
 }
 
 static irqreturn_t mbox_interrupt(int irq, void *p)
@@ -401,12 +402,17 @@ EXPORT_SYMBOL(omap_mbox_unregister);
 
 static int __init omap_mbox_init(void)
 {
+	mboxd = create_workqueue("mboxd");
+	if (!mboxd)
+		return -ENOMEM;
+
 	return 0;
 }
 module_init(omap_mbox_init);
 
 static void __exit omap_mbox_exit(void)
 {
+	destroy_workqueue(mboxd);
 }
 module_exit(omap_mbox_exit);
 
-- 
1.6.6.2
