From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 1/2] omap:mailbox-make mailbox reference counter atomic
Date: Tue, 20 Jul 2010 16:41:35 -0500
Message-ID: <1279662096-3121-2-git-send-email-h-kanigeri2@ti.com>
References: <1279662096-3121-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60280 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab0GTVa6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jul 2010 17:30:58 -0400
In-Reply-To: <1279662096-3121-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Hari Kanigeri <h-kanigeri2@ti.com>

Make the mailbox reference counter as atomic variable and remove
the spinlock protection surrounding it.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/plat-omap/mailbox.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index b06d3de..baac315 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -35,7 +35,7 @@ static struct omap_mbox *mboxes;
 static DEFINE_SPINLOCK(mboxes_lock);
 static bool rq_full;
 
-static int mbox_configured;
+static atomic_t mbox_refcount = ATOMIC_INIT(0);
 
 /* Mailbox FIFO handle functions */
 static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
@@ -243,16 +243,13 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	struct omap_mbox_queue *mq;
 
 	if (likely(mbox->ops->startup)) {
-		spin_lock(&mboxes_lock);
-		if (!mbox_configured)
+		if (atomic_inc_return(&mbox_refcount) == 1)
 			ret = mbox->ops->startup(mbox);
 
 		if (unlikely(ret)) {
-			spin_unlock(&mboxes_lock);
+			atomic_dec(&mbox_refcount);
 			return ret;
 		}
-		mbox_configured++;
-		spin_unlock(&mboxes_lock);
 	}
 
 	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
@@ -284,8 +281,10 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
  fail_alloc_txq:
 	free_irq(mbox->irq, mbox);
  fail_request_irq:
-	if (likely(mbox->ops->shutdown))
-		mbox->ops->shutdown(mbox);
+	if (likely(mbox->ops->shutdown)) {
+		if (atomic_dec_return(&mbox_refcount) == 0)
+			mbox->ops->shutdown(mbox);
+	}
 
 	return ret;
 }
@@ -298,12 +297,8 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	free_irq(mbox->irq, mbox);
 
 	if (likely(mbox->ops->shutdown)) {
-		spin_lock(&mboxes_lock);
-		if (mbox_configured > 0)
-			mbox_configured--;
-		if (!mbox_configured)
+		if (atomic_dec_return(&mbox_refcount) == 0)
 			mbox->ops->shutdown(mbox);
-		spin_unlock(&mboxes_lock);
 	}
 }
 
-- 
1.7.0

