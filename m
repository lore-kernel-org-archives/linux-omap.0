From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 06/10] omap: mailbox: convert rwlocks to spinlock
Date: Thu,  3 Jun 2010 09:34:14 +0300
Message-ID: <1275546858-29507-7-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34527 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933189Ab0FCGe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 02:34:56 -0400
In-Reply-To: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Ohad Ben-Cohen <ohad@wizery.com>

rwlocks are slower and have potential starvation issues
therefore spinlocks are generally preferred.

see also: http://lwn.net/Articles/364583/

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Kanigeri Hari <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index c340216..fafe47b 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -31,7 +31,7 @@
 
 static struct workqueue_struct *mboxd;
 static struct omap_mbox *mboxes;
-static DEFINE_RWLOCK(mboxes_lock);
+static DEFINE_SPINLOCK(mboxes_lock);
 static bool rq_full;
 
 static int mbox_configured;
@@ -341,14 +341,14 @@ struct omap_mbox *omap_mbox_get(const char *name)
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
@@ -374,15 +374,15 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
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
 
@@ -395,18 +395,18 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
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
1.7.1.rc1

