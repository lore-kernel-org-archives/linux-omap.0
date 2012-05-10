From: Juan Gutierrez <jgutierrez@ti.com>
Subject: [PATCH v4 1/2] omap: mailbox: enable mailbox irq per instance
Date: Thu, 10 May 2012 15:09:47 -0500
Message-ID: <1336680588-8572-2-git-send-email-jgutierrez@ti.com>
References: <1336680588-8572-1-git-send-email-jgutierrez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58186 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752801Ab2EJUKE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 16:10:04 -0400
Received: by qcse1 with SMTP id e1so1868828qcs.37
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 13:10:02 -0700 (PDT)
In-Reply-To: <1336680588-8572-1-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ohad@wizery.com
Cc: Juan Gutierrez <jgutierrez@ti.com>, Suman Anna <s-anna@ti.com>

The machine-specific omap2_mbox_startup is called only once
to initialize the whole mbox module. Enabling mbox irq at
startup is only enabling the irq of the very first mailbox
instance created.

The enable_irq function should be called every time a
new mbox instance is created/opened, in the generic
platform mailbox layer.

Also, the notifier_block registration is called before
enabling the mbox's irq to avoid possible race of receiving
an interrupt without invoking the user's notifier callback.

Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 --
 arch/arm/plat-omap/mailbox.c  |   13 +++++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 415a6f1..f727034 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -83,8 +83,6 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 	l = mbox_read_reg(MAILBOX_REVISION);
 	pr_debug("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
 
-	omap2_mbox_enable_irq(mbox, IRQ_RX);
-
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index ad32621..5e13c38 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -282,6 +282,8 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 		}
 		mbox->rxq = mq;
 		mq->mbox = mbox;
+
+		omap_mbox_enable_irq(mbox, IRQ_RX);
 	}
 	mutex_unlock(&mbox_configured_lock);
 	return 0;
@@ -305,6 +307,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	mutex_lock(&mbox_configured_lock);
 
 	if (!--mbox->use_count) {
+		omap_mbox_disable_irq(mbox, IRQ_RX);
 		free_irq(mbox->irq, mbox);
 		tasklet_kill(&mbox->txq->tasklet);
 		flush_work_sync(&mbox->rxq->work);
@@ -338,13 +341,15 @@ struct omap_mbox *omap_mbox_get(const char *name, struct notifier_block *nb)
 	if (!mbox)
 		return ERR_PTR(-ENOENT);
 
-	ret = omap_mbox_startup(mbox);
-	if (ret)
-		return ERR_PTR(-ENODEV);
-
 	if (nb)
 		blocking_notifier_chain_register(&mbox->notifier, nb);
 
+	ret = omap_mbox_startup(mbox);
+	if (ret) {
+		blocking_notifier_chain_unregister(&mbox->notifier, nb);
+		return ERR_PTR(-ENODEV);
+	}
+
 	return mbox;
 }
 EXPORT_SYMBOL(omap_mbox_get);
-- 
1.7.1

