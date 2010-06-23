From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 1/4] omap mailbox: extend API to take a callback param
Date: Wed, 23 Jun 2010 03:11:33 +0300
Message-ID: <1277251896-6890-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59612 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657Ab0FWALp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 20:11:45 -0400
Received: by wyi11 with SMTP id 11so338208wyi.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 17:11:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Let mailbox users set the callback pointer via the
omap_mbox_get API, instead of having users directly
manipulating the mailbox structures.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
I can also be contacted at < ohadb at ti dot com >

 arch/arm/plat-omap/include/plat/mailbox.h |    2 +-
 arch/arm/plat-omap/mailbox.c              |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 9976565..0b45664 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -62,7 +62,7 @@ struct omap_mbox {
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
-struct omap_mbox *omap_mbox_get(const char *);
+struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(void *));
 void omap_mbox_put(struct omap_mbox *);
 
 int omap_mbox_register(struct device *parent, struct omap_mbox **);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index d2fafb8..14b716d 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -305,7 +305,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	}
 }
 
-struct omap_mbox *omap_mbox_get(const char *name)
+struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(void *))
 {
 	struct omap_mbox *mbox;
 	int ret;
@@ -324,6 +324,8 @@ struct omap_mbox *omap_mbox_get(const char *name)
 	if (ret)
 		return ERR_PTR(-ENODEV);
 
+	mbox->rxq->callback = callback;
+
 	return mbox;
 }
 EXPORT_SYMBOL(omap_mbox_get);
-- 
1.7.0.4

