From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 17/17] omap: mailbox: don't export register/unregister
Date: Fri, 14 May 2010 18:01:50 +0300
Message-ID: <1273849310-32169-18-git-send-email-felipe.contreras@gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:44846 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915Ab0ENPCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 11:02:36 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so902320ewy.28
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 08:02:35 -0700 (PDT)
In-Reply-To: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

No need for that now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    3 ---
 arch/arm/plat-omap/mailbox.c              |    6 ++----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index cbde52a..e01be54 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -78,9 +78,6 @@ void omap_mbox_init_seq(struct omap_mbox *);
 struct omap_mbox *omap_mbox_get(const char *);
 void omap_mbox_put(struct omap_mbox *);
 
-int omap_mbox_register(struct device *parent, struct omap_mbox *);
-int omap_mbox_unregister(struct omap_mbox *);
-
 static inline void omap_mbox_save_ctx(struct omap_mbox *mbox)
 {
 	if (!mbox->ops->save_ctx) {
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index c7d28fa..88d67c4 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -347,7 +347,7 @@ void omap_mbox_put(struct omap_mbox *mbox)
 }
 EXPORT_SYMBOL(omap_mbox_put);
 
-int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
+static int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 {
 	int ret = 0;
 	struct omap_mbox **tmp;
@@ -372,9 +372,8 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 err_find:
 	return ret;
 }
-EXPORT_SYMBOL(omap_mbox_register);
 
-int omap_mbox_unregister(struct omap_mbox *mbox)
+static int omap_mbox_unregister(struct omap_mbox *mbox)
 {
 	struct omap_mbox **tmp;
 
@@ -393,7 +392,6 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL(omap_mbox_unregister);
 
 static int __devinit omap_mbox_probe(struct platform_device *pdev)
 {
-- 
1.7.1

