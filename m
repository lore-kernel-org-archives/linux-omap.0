From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 5/6] Mailbox: sleeping function called from invalid context
 fix
Date: Fri, 12 Feb 2010 19:42:16 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA7C18DB@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49007 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756234Ab0BMBmV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 20:42:21 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

>From e06b2716824f225747c4dc83ed2623d0160ae132 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 29 Jan 2010 17:12:24 -0600
Subject: [PATCH] Mailbox: sleeping function called from invalid context fix

This patch fixes this bug:
BUG: sleeping function called from invalid context
Inside omap2_mbox_startup is called clk_get_sys that can sleep,
therefore omap2_mbox_startup can sleep but it is call in an atomic
context . So the spinlock is change for a semaphore.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/mailbox.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 8136ee3..d8bfa45 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -29,7 +29,7 @@
 #include <plat/mailbox.h>
 
 static struct omap_mbox *mboxes;
-static DEFINE_RWLOCK(mboxes_lock);
+static DECLARE_RWSEM(mboxes_sem);
 
 static int mbox_configured;
 
@@ -248,16 +248,16 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	struct omap_mbox_queue *mq;
 
 	if (likely(mbox->ops->startup)) {
-		write_lock(&mboxes_lock);
+		down_write(&mboxes_sem);
 		if (!mbox_configured)
 			ret = mbox->ops->startup(mbox);
 
 		if (unlikely(ret)) {
-			write_unlock(&mboxes_lock);
+			up_write(&mboxes_sem);
 			return ret;
 		}
 		mbox_configured++;
-		write_unlock(&mboxes_lock);
+		up_write(&mboxes_sem);
 	}
 
 	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
@@ -304,12 +304,12 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	mbox_queue_free(mbox->rxq);
 
 	if (unlikely(mbox->ops->shutdown)) {
-		write_lock(&mboxes_lock);
+		down_write(&mboxes_sem);
 		if (mbox_configured > 0)
 			mbox_configured--;
 		if (!mbox_configured)
 			mbox->ops->shutdown(mbox);
-		write_unlock(&mboxes_lock);
+		up_write(&mboxes_sem);
 	}
 }
 
@@ -330,14 +330,14 @@ struct omap_mbox *omap_mbox_get(const char *name)
 	struct omap_mbox *mbox;
 	int ret;
 
-	read_lock(&mboxes_lock);
+	down_read(&mboxes_sem);
 	mbox = *(find_mboxes(name));
 	if (mbox == NULL) {
-		read_unlock(&mboxes_lock);
+		up_read(&mboxes_sem);
 		return ERR_PTR(-ENOENT);
 	}
 
-	read_unlock(&mboxes_lock);
+	up_read(&mboxes_sem);
 
 	ret = omap_mbox_startup(mbox);
 	if (ret)
@@ -363,15 +363,15 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 	if (mbox->next)
 		return -EBUSY;
 
-	write_lock(&mboxes_lock);
+	down_write(&mboxes_sem);
 	tmp = find_mboxes(mbox->name);
 	if (*tmp) {
 		ret = -EBUSY;
-		write_unlock(&mboxes_lock);
+		up_write(&mboxes_sem);
 		goto err_find;
 	}
 	*tmp = mbox;
-	write_unlock(&mboxes_lock);
+	up_write(&mboxes_sem);
 
 	return 0;
 
@@ -384,18 +384,18 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 {
 	struct omap_mbox **tmp;
 
-	write_lock(&mboxes_lock);
+	down_write(&mboxes_sem);
 	tmp = &mboxes;
 	while (*tmp) {
 		if (mbox == *tmp) {
 			*tmp = mbox->next;
 			mbox->next = NULL;
-			write_unlock(&mboxes_lock);
+			up_write(&mboxes_sem);
 			return 0;
 		}
 		tmp = &(*tmp)->next;
 	}
-	write_unlock(&mboxes_lock);
+	up_write(&mboxes_sem);
 
 	return -EINVAL;
 }
-- 
1.6.0.4

