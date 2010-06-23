From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 2/4] omap mailbox: prevent multiple concurrent receivers race
Date: Wed, 23 Jun 2010 03:11:34 +0300
Message-ID: <1277251896-6890-2-git-send-email-ohad@wizery.com>
References: <1277251896-6890-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40371 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab0FWALq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 20:11:46 -0400
Received: by wyi11 with SMTP id 11so338218wyi.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 17:11:45 -0700 (PDT)
In-Reply-To: <1277251896-6890-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

We currently maintain only a single mailbox receiver callback.
To prevent multiple receivers race scenarios (in which receivers
will end up overwriting each other's callback pointers), we make
sure that mailbox instances cannot be taken by more than
one receiver at the same time.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
I can also be contacted at < ohadb at ti dot com >

 arch/arm/plat-omap/include/plat/mailbox.h |    1 +
 arch/arm/plat-omap/mailbox.c              |   12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 0b45664..5df35b4 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -57,6 +57,7 @@ struct omap_mbox {
 	struct omap_mbox_ops	*ops;
 	struct device		*dev;
 	void			*priv;
+	atomic_t		count;
 };
 
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 14b716d..aafa63f 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -320,9 +320,17 @@ struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(void *))
 	if (!mbox)
 		return ERR_PTR(-ENOENT);
 
+	if (atomic_inc_return(&mbox->count) > 1) {
+		pr_err("%s: mbox %s already in use\n", __func__, name);
+		atomic_dec(&mbox->count);
+		return ERR_PTR(-EBUSY);
+	}
+
 	ret = omap_mbox_startup(mbox);
-	if (ret)
+	if (ret) {
+		atomic_dec(&mbox->count);
 		return ERR_PTR(-ENODEV);
+	}
 
 	mbox->rxq->callback = callback;
 
@@ -333,6 +341,7 @@ EXPORT_SYMBOL(omap_mbox_get);
 void omap_mbox_put(struct omap_mbox *mbox)
 {
 	omap_mbox_fini(mbox);
+	atomic_dec(&mbox->count);
 }
 EXPORT_SYMBOL(omap_mbox_put);
 
@@ -349,6 +358,7 @@ int omap_mbox_register(struct device *parent, struct omap_mbox **list)
 
 	for (i = 0; mboxes[i]; i++) {
 		struct omap_mbox *mbox = mboxes[i];
+		atomic_set(&mbox->count, 0);
 		mbox->dev = device_create(&omap_mbox_class,
 				parent, 0, mbox, "%s", mbox->name);
 		if (IS_ERR(mbox->dev)) {
-- 
1.7.0.4

