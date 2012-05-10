From: Juan Gutierrez <jgutierrez@ti.com>
Subject: [PATCH v3 1/2] omap: mailbox: enable mailbox irq per instance
Date: Wed,  9 May 2012 21:19:29 -0500
Message-ID: <1336616370-28268-2-git-send-email-jgutierrez@ti.com>
References: <1336616370-28268-1-git-send-email-jgutierrez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37216 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752532Ab2EJCTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 22:19:49 -0400
Received: by obbuo19 with SMTP id uo19so1323797obb.40
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 19:19:48 -0700 (PDT)
In-Reply-To: <1336616370-28268-1-git-send-email-jgutierrez@ti.com>
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
 arch/arm/plat-omap/mailbox.c  |    9 ++++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

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
index ad32621..233f85d 100644
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
@@ -338,13 +341,13 @@ struct omap_mbox *omap_mbox_get(const char *name, struct notifier_block *nb)
 	if (!mbox)
 		return ERR_PTR(-ENOENT);
 
+	if (nb)
+		blocking_notifier_chain_register(&mbox->notifier, nb);
+
 	ret = omap_mbox_startup(mbox);
 	if (ret)
 		return ERR_PTR(-ENODEV);
 
-	if (nb)
-		blocking_notifier_chain_register(&mbox->notifier, nb);
-
 	return mbox;
 }
 EXPORT_SYMBOL(omap_mbox_get);
-- 
1.7.5.4

