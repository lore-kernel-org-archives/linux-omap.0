From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH v3 5/5] OMAP: mailbox: add notification support for multiple readers
Date: Thu, 18 Nov 2010 13:15:42 -0600
Message-ID: <1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55818 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab0KRTNv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 14:13:51 -0500
In-Reply-To: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Hari Kanigeri <h-kanigeri2@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

In the current mailbox driver, the mailbox internal pointer for
callback can be directly manipulated by the Users, so a second
User can easily corrupt the first user's callback pointer.
The initial effort to correct this issue can be referred here:
https://patchwork.kernel.org/patch/107520/

Along with fixing the above stated issue, this patch  adds the
flexibility option to register notifications from
multiple readers to the events received on a mailbox instance.
The discussion regarding this can be referred here.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30671.html

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    7 +-
 arch/arm/plat-omap/mailbox.c              |  102 ++++++++++++++++-------------
 2 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 13f2ef3..cc3921e 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -46,7 +46,6 @@ struct omap_mbox_queue {
 	struct kfifo		fifo;
 	struct work_struct	work;
 	struct tasklet_struct	tasklet;
-	int	(*callback)(void *);
 	struct omap_mbox	*mbox;
 	bool full;
 };
@@ -58,13 +57,15 @@ struct omap_mbox {
 	struct omap_mbox_ops	*ops;
 	struct device		*dev;
 	void			*priv;
+	int			use_count;
+	struct blocking_notifier_head   notifier;
 };
 
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
-struct omap_mbox *omap_mbox_get(const char *);
-void omap_mbox_put(struct omap_mbox *);
+struct omap_mbox *omap_mbox_get(const char *, struct notifier_block *nb);
+void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb);
 
 int omap_mbox_register(struct device *parent, struct omap_mbox **);
 int omap_mbox_unregister(void);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index b14bc34..b1f8f2c 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/kfifo.h>
 #include <linux/err.h>
+#include <linux/notifier.h>
 
 #include <plat/mailbox.h>
 
@@ -150,8 +151,8 @@ static void mbox_rx_work(struct work_struct *work)
 		len = kfifo_out(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
 		WARN_ON(len != sizeof(msg));
 
-		if (mq->callback)
-			mq->callback((void *)msg);
+		blocking_notifier_call_chain(&mq->mbox->notifier, len,
+							(void *)msg);
 		if (mq->full) {
 			mq->full = false;
 			omap_mbox_enable_irq(mq->mbox, IRQ_RX);
@@ -247,41 +248,40 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	int ret = 0;
 	struct omap_mbox_queue *mq;
 
-	if (mbox->ops->startup) {
-		mutex_lock(&mbox_configured_lock);
-		if (!mbox_configured)
+	mutex_lock(&mbox_configured_lock);
+	if (!mbox_configured++) {
+		if (likely(mbox->ops->startup)) {
 			ret = mbox->ops->startup(mbox);
-
-		if (ret) {
-			mutex_unlock(&mbox_configured_lock);
-			return ret;
-		}
-		mbox_configured++;
-		mutex_unlock(&mbox_configured_lock);
+			if (unlikely(ret))
+				goto fail_startup;
+		} else
+			goto fail_startup;
 	}
 
-	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
-				mbox->name, mbox);
-	if (ret) {
-		printk(KERN_ERR
-			"failed to register mailbox interrupt:%d\n", ret);
-		goto fail_request_irq;
-	}
-
-	mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
-	if (!mq) {
-		ret = -ENOMEM;
-		goto fail_alloc_txq;
-	}
-	mbox->txq = mq;
+	if (!mbox->use_count++) {
+		ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
+							mbox->name, mbox);
+		if (unlikely(ret)) {
+			pr_err("failed to register mailbox interrupt:%d\n",
+									ret);
+			goto fail_request_irq;
+		}
+		mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
+		if (!mq) {
+			ret = -ENOMEM;
+			goto fail_alloc_txq;
+		}
+		mbox->txq = mq;
 
-	mq = mbox_queue_alloc(mbox, mbox_rx_work, NULL);
-	if (!mq) {
-		ret = -ENOMEM;
-		goto fail_alloc_rxq;
+		mq = mbox_queue_alloc(mbox, mbox_rx_work, NULL);
+		if (!mq) {
+			ret = -ENOMEM;
+			goto fail_alloc_rxq;
+		}
+		mbox->rxq = mq;
+		mq->mbox = mbox;
 	}
-	mbox->rxq = mq;
-
+	mutex_unlock(&mbox_configured_lock);
 	return 0;
 
 fail_alloc_rxq:
@@ -291,29 +291,34 @@ fail_alloc_txq:
 fail_request_irq:
 	if (mbox->ops->shutdown)
 		mbox->ops->shutdown(mbox);
-
+	mbox->use_count--;
+fail_startup:
+	mbox_configured--;
+	mutex_unlock(&mbox_configured_lock);
 	return ret;
 }
 
 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
-	free_irq(mbox->irq, mbox);
-	tasklet_kill(&mbox->txq->tasklet);
-	flush_work(&mbox->rxq->work);
-	mbox_queue_free(mbox->txq);
-	mbox_queue_free(mbox->rxq);
+	mutex_lock(&mbox_configured_lock);
+
+	if (!--mbox->use_count) {
+		free_irq(mbox->irq, mbox);
+		tasklet_kill(&mbox->txq->tasklet);
+		flush_work(&mbox->rxq->work);
+		mbox_queue_free(mbox->txq);
+		mbox_queue_free(mbox->rxq);
+	}
 
-	if (mbox->ops->shutdown) {
-		mutex_lock(&mbox_configured_lock);
-		if (mbox_configured > 0)
-			mbox_configured--;
-		if (!mbox_configured)
+	if (likely(mbox->ops->shutdown)) {
+		if (!--mbox_configured)
 			mbox->ops->shutdown(mbox);
-		mutex_unlock(&mbox_configured_lock);
 	}
+
+	mutex_unlock(&mbox_configured_lock);
 }
 
-struct omap_mbox *omap_mbox_get(const char *name)
+struct omap_mbox *omap_mbox_get(const char *name, struct notifier_block *nb)
 {
 	struct omap_mbox *mbox;
 	int ret;
@@ -332,12 +337,16 @@ struct omap_mbox *omap_mbox_get(const char *name)
 	if (ret)
 		return ERR_PTR(-ENODEV);
 
+	if (nb)
+		blocking_notifier_chain_register(&mbox->notifier, nb);
+
 	return mbox;
 }
 EXPORT_SYMBOL(omap_mbox_get);
 
-void omap_mbox_put(struct omap_mbox *mbox)
+void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb)
 {
+	blocking_notifier_chain_unregister(&mbox->notifier, nb);
 	omap_mbox_fini(mbox);
 }
 EXPORT_SYMBOL(omap_mbox_put);
@@ -361,6 +370,7 @@ int omap_mbox_register(struct device *parent, struct omap_mbox **list)
 			ret = PTR_ERR(mbox->dev);
 			goto err_out;
 		}
+		BLOCKING_INIT_NOTIFIER_HEAD(&mbox->notifier);
 	}
 	return 0;
 
-- 
1.7.0

