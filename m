From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 4/7] OMAP: mailbox: move framework functions under header file
Date: Fri, 24 Jun 2011 20:17:40 -0500
Message-ID: <1308964663-5669-5-git-send-email-omar.ramirez@ti.com>
References: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41434 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753232Ab1FYBSR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 21:18:17 -0400
Received: by gya6 with SMTP id 6so1920641gya.31
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 18:18:14 -0700 (PDT)
In-Reply-To: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Move API functions to common framework like save/restore_ctx,
enable/disable_irq instead of being under a header file. While
at it dropping their static inline declarations.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |   35 +++-------------------------
 arch/arm/plat-omap/mailbox.c              |   35 +++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 337b93c..271905a 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -78,36 +78,9 @@ void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb);
 int omap_mbox_register(struct device *parent, struct omap_mbox **);
 int omap_mbox_unregister(void);
 
-static inline void omap_mbox_save_ctx(struct omap_mbox *mbox)
-{
-	if (!mbox->ops->save_ctx) {
-		dev_err(mbox->dev, "%s:\tno save\n", __func__);
-		return;
-	}
-
-	mbox->ops->save_ctx(mbox);
-}
-
-static inline void omap_mbox_restore_ctx(struct omap_mbox *mbox)
-{
-	if (!mbox->ops->restore_ctx) {
-		dev_err(mbox->dev, "%s:\tno restore\n", __func__);
-		return;
-	}
-
-	mbox->ops->restore_ctx(mbox);
-}
-
-static inline void omap_mbox_enable_irq(struct omap_mbox *mbox,
-					omap_mbox_irq_t irq)
-{
-	mbox->ops->enable_irq(mbox, irq);
-}
-
-static inline void omap_mbox_disable_irq(struct omap_mbox *mbox,
-					 omap_mbox_irq_t irq)
-{
-	mbox->ops->disable_irq(mbox, irq);
-}
+void omap_mbox_save_ctx(struct omap_mbox *mbox);
+void omap_mbox_restore_ctx(struct omap_mbox *mbox);
+void omap_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq);
+void omap_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq);
 
 #endif /* MAILBOX_H */
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 69ddc9f..98b36dc 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -60,6 +60,18 @@ static inline int mbox_fifo_full(struct omap_mbox *mbox)
 }
 
 /* Mailbox IRQ handle functions */
+void omap_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
+{
+	mbox->ops->enable_irq(mbox, irq);
+}
+EXPORT_SYMBOL(omap_mbox_enable_irq);
+
+void omap_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
+{
+	mbox->ops->disable_irq(mbox, irq);
+}
+EXPORT_SYMBOL(omap_mbox_disable_irq);
+
 static inline void ack_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	if (mbox->ops->ack_irq)
@@ -70,6 +82,29 @@ static inline int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 	return mbox->ops->is_irq(mbox, irq);
 }
 
+/* Mailbox context functions */
+void omap_mbox_save_ctx(struct omap_mbox *mbox)
+{
+	if (!mbox->ops->save_ctx) {
+		dev_err(mbox->dev, "%s:\tno save\n", __func__);
+		return;
+	}
+
+	mbox->ops->save_ctx(mbox);
+}
+EXPORT_SYMBOL(omap_mbox_save_ctx);
+
+void omap_mbox_restore_ctx(struct omap_mbox *mbox)
+{
+	if (!mbox->ops->restore_ctx) {
+		dev_err(mbox->dev, "%s:\tno restore\n", __func__);
+		return;
+	}
+
+	mbox->ops->restore_ctx(mbox);
+}
+EXPORT_SYMBOL(omap_mbox_restore_ctx);
+
 /*
  * message sender
  */
-- 
1.7.0.4

