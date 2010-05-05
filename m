From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 1/4] omap: mailbox: convert rwlocks to spinlock
Date: Wed,  5 May 2010 18:33:06 +0300
Message-ID: <1273073589-2485-2-git-send-email-ohad@wizery.com>
References: <1273073589-2485-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41950 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760569Ab0EEPdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 11:33:36 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so4345399fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 08:33:36 -0700 (PDT)
In-Reply-To: <1273073589-2485-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

rwlocks are slower and have potential starvation issues
therefore spinlocks are generally preferred.

see also: http://lwn.net/Articles/364583/

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Kanigeri Hari <h-kanigeri2@ti.com>
---
If you want, you can also reach me at < ohadb at ti dot com >.

 arch/arm/plat-omap/mailbox.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 08a2df7..af3a6ac 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -31,7 +31,7 @@
 
 static struct workqueue_struct *mboxd;
 static struct omap_mbox *mboxes;
-static DEFINE_RWLOCK(mboxes_lock);
+static DEFINE_SPINLOCK(mboxes_lock);
 
 static int mbox_configured;
 
@@ -249,16 +249,16 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	struct omap_mbox_queue *mq;
 
 	if (likely(mbox->ops->startup)) {
-		write_lock(&mboxes_lock);
+		spin_lock(&mboxes_lock);
 		if (!mbox_configured)
 			ret = mbox->ops->startup(mbox);
 
 		if (unlikely(ret)) {
-			write_unlock(&mboxes_lock);
+			spin_unlock(&mboxes_lock);
 			return ret;
 		}
 		mbox_configured++;
-		write_unlock(&mboxes_lock);
+		spin_unlock(&mboxes_lock);
 	}
 
 	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
@@ -304,12 +304,12 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	free_irq(mbox->irq, mbox);
 
 	if (unlikely(mbox->ops->shutdown)) {
-		write_lock(&mboxes_lock);
+		spin_lock(&mboxes_lock);
 		if (mbox_configured > 0)
 			mbox_configured--;
 		if (!mbox_configured)
 			mbox->ops->shutdown(mbox);
-		write_unlock(&mboxes_lock);
+		spin_unlock(&mboxes_lock);
 	}
 }
 
@@ -330,14 +330,14 @@ struct omap_mbox *omap_mbox_get(const char *name)
 	struct omap_mbox *mbox;
 	int ret;
 
-	read_lock(&mboxes_lock);
+	spin_lock(&mboxes_lock);
 	mbox = *(find_mboxes(name));
 	if (mbox == NULL) {
-		read_unlock(&mboxes_lock);
+		spin_unlock(&mboxes_lock);
 		return ERR_PTR(-ENOENT);
 	}
 
-	read_unlock(&mboxes_lock);
+	spin_unlock(&mboxes_lock);
 
 	ret = omap_mbox_startup(mbox);
 	if (ret)
@@ -363,15 +363,15 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 	if (mbox->next)
 		return -EBUSY;
 
-	write_lock(&mboxes_lock);
+	spin_lock(&mboxes_lock);
 	tmp = find_mboxes(mbox->name);
 	if (*tmp) {
 		ret = -EBUSY;
-		write_unlock(&mboxes_lock);
+		spin_unlock(&mboxes_lock);
 		goto err_find;
 	}
 	*tmp = mbox;
-	write_unlock(&mboxes_lock);
+	spin_unlock(&mboxes_lock);
 
 	return 0;
 
@@ -384,18 +384,18 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 {
 	struct omap_mbox **tmp;
 
-	write_lock(&mboxes_lock);
+	spin_lock(&mboxes_lock);
 	tmp = &mboxes;
 	while (*tmp) {
 		if (mbox == *tmp) {
 			*tmp = mbox->next;
 			mbox->next = NULL;
-			write_unlock(&mboxes_lock);
+			spin_unlock(&mboxes_lock);
 			return 0;
 		}
 		tmp = &(*tmp)->next;
 	}
-	write_unlock(&mboxes_lock);
+	spin_unlock(&mboxes_lock);
 
 	return -EINVAL;
 }
-- 
1.6.3.3

