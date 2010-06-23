From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 3/4] omap mailbox: remove mbox_configured scheme
Date: Wed, 23 Jun 2010 03:11:35 +0300
Message-ID: <1277251896-6890-3-git-send-email-ohad@wizery.com>
References: <1277251896-6890-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:35608 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab0FWALs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 20:11:48 -0400
Received: by wwc33 with SMTP id 33so584176wwc.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 17:11:47 -0700 (PDT)
In-Reply-To: <1277251896-6890-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

mbox_configured is global and therefore does not support
concurrent usage of multiple mailbox instances.
Instead of fixing this, we can just eliminate mbox_configured
(and its locking) entirely, since any given mailbox instance
can only be taken by a single receiver now.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
I can also be contacted at < ohadb at ti dot com >

 arch/arm/plat-omap/mailbox.c |   24 ++++--------------------
 1 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index aafa63f..6a9dfe5 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -35,9 +35,6 @@ static struct workqueue_struct *mboxd;
 static struct omap_mbox **mboxes;
 static bool rq_full;
 
-static int mbox_configured;
-static DEFINE_MUTEX(mbox_configured_lock);
-
 static unsigned int mbox_kfifo_size = CONFIG_OMAP_MBOX_KFIFO_SIZE;
 module_param(mbox_kfifo_size, uint, S_IRUGO);
 MODULE_PARM_DESC(mbox_kfifo_size, "Size of omap's mailbox kfifo (bytes)");
@@ -240,16 +237,9 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	struct omap_mbox_queue *mq;
 
 	if (mbox->ops->startup) {
-		mutex_lock(&mbox_configured_lock);
-		if (!mbox_configured)
-			ret = mbox->ops->startup(mbox);
-
-		if (ret) {
-			mutex_unlock(&mbox_configured_lock);
+		ret = mbox->ops->startup(mbox);
+		if (ret)
 			return ret;
-		}
-		mbox_configured++;
-		mutex_unlock(&mbox_configured_lock);
 	}
 
 	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
@@ -295,14 +285,8 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	mbox_queue_free(mbox->txq);
 	mbox_queue_free(mbox->rxq);
 
-	if (mbox->ops->shutdown) {
-		mutex_lock(&mbox_configured_lock);
-		if (mbox_configured > 0)
-			mbox_configured--;
-		if (!mbox_configured)
-			mbox->ops->shutdown(mbox);
-		mutex_unlock(&mbox_configured_lock);
-	}
+	if (mbox->ops->shutdown)
+		mbox->ops->shutdown(mbox);
 }
 
 struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(void *))
-- 
1.7.0.4

