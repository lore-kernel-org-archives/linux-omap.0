From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: [PATCH] omap: mailbox - Enable IRQ after allocating queues
Date: Mon,  8 Nov 2010 22:44:52 -0600
Message-ID: <1289277892-16854-1-git-send-email-deepak.chitriki@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37986 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418Ab0KIEo7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 23:44:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, fernando.lugo@ti.com, Deepak Chitriki <deepak.chitriki@ti.com>

Currently we are enabling the IRQ before queue's are allocated.But in some
corner cases as soon as we enable the interruption,the ISR will be executed
but the queue's wont be ready.Because of this we may be reading some garbage
message in the mailbox which may lead to panic.

This patch is based on the analysis of Fernando Guzman Lugo.

Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
---
 arch/arm/plat-omap/mailbox.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index c59c9c3..1513e16 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -256,14 +256,6 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 		mutex_unlock(&mbox_configured_lock);
 	}
 
-	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
-				mbox->name, mbox);
-	if (ret) {
-		printk(KERN_ERR
-			"failed to register mailbox interrupt:%d\n", ret);
-		goto fail_request_irq;
-	}
-
 	mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
 	if (!mq) {
 		ret = -ENOMEM;
@@ -278,13 +270,21 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	}
 	mbox->rxq = mq;
 
+	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
+				mbox->name, mbox);
+	if (ret) {
+		printk(KERN_ERR
+			"failed to register mailbox interrupt:%d\n", ret);
+		goto fail_request_irq;
+	}
+
 	return 0;
 
- fail_alloc_rxq:
+fail_request_irq:
+	mbox_queue_free(mbox->rxq);
+fail_alloc_rxq:
 	mbox_queue_free(mbox->txq);
- fail_alloc_txq:
-	free_irq(mbox->irq, mbox);
- fail_request_irq:
+fail_alloc_txq:
 	if (mbox->ops->shutdown)
 		mbox->ops->shutdown(mbox);
 
-- 
1.7.0.4

