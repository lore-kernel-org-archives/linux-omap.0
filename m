From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 1/4] omap: mailbox cleanup: convert rwlocks to spinlock
Date: Tue, 27 Apr 2010 20:56:19 +0300
Message-ID: <1272390982-14882-2-git-send-email-ohad@wizery.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:4458 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab0D0R6i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 13:58:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2795216fgg.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 10:58:37 -0700 (PDT)
In-Reply-To: <1272390982-14882-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

rwlocks are slower and have potential starvation issues so spinlocks are
generally preferred

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/plat-omap/mailbox.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 08a2df7..d73d51a 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -31,7 +31,7 @@
 
 static struct workqueue_struct *mboxd;
 static struct omap_mbox *mboxes;
-static DEFINE_RWLOCK(mboxes_lock);
+static DEFINE_SPINLOCK(mboxes_lock);
 
 static int mbox_configured;
 
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

