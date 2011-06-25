From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 5/7] OMAP: mailbox: implement dynamic mailbox configuration
Date: Fri, 24 Jun 2011 20:17:41 -0500
Message-ID: <1308964663-5669-6-git-send-email-omar.ramirez@ti.com>
References: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:40439 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753287Ab1FYBSR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 21:18:17 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so1674365ywe.5
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 18:18:16 -0700 (PDT)
In-Reply-To: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

So far, mailbox architecture dependent implementations have contained
static declarations for its supported mailbox and users, this has
affected the framework by extending the requests to match the hardcoded
names and only support the known users.

These changes try to provide a more generic mailbox driver which
diferentiates from its available queues instead of the name of the users
tied to a single pair.

Users of the mailbox need to supply a new struct mbox_info with the
common parameters needed by the framework to configure N number of queues.

All requests are made in function of the mailbox id needed, also a
request_byname is provided to cover the cases where there are multiple irqs
tied to a single mailbox block (i.e. OMAP2420).

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |   19 ++-
 arch/arm/plat-omap/mailbox.c              |  275 +++++++++++++++++-----------
 2 files changed, 182 insertions(+), 112 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 271905a..5b77c80 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -39,6 +39,9 @@ struct omap_mbox_ops {
 	/* ctx */
 	void		(*save_ctx)(struct omap_mbox *mbox);
 	void		(*restore_ctx)(struct omap_mbox *mbox);
+
+	void            *(*request)(u16 id, u16 owner);
+	void            (*release)(void *priv);
 };
 
 struct omap_mailbox_dev_attr {
@@ -49,6 +52,14 @@ struct omap_mailbox_platform_data {
 	u16		nr_mbox;
 };
 
+struct mbox_info {
+	struct device           *dev;
+	struct omap_mbox_ops    *ops;
+	u32			kfifo_size;
+	u32			configured;
+	u16			nr_mbox;
+};
+
 struct omap_mbox_queue {
 	spinlock_t		lock;
 	struct kfifo		fifo;
@@ -60,9 +71,9 @@ struct omap_mbox_queue {
 
 struct omap_mbox {
 	char			*name;
+	u16			id;
 	unsigned int		irq;
 	struct omap_mbox_queue	*txq, *rxq;
-	struct omap_mbox_ops	*ops;
 	struct device		*dev;
 	void			*priv;
 	int			use_count;
@@ -72,10 +83,10 @@ struct omap_mbox {
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
-struct omap_mbox *omap_mbox_get(const char *, struct notifier_block *nb);
-void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb);
+void *mbox_request(u16 id, u16 owner, struct notifier_block *nb);
+void mbox_release(struct omap_mbox *mbox, struct notifier_block *nb);
 
-int omap_mbox_register(struct device *parent, struct omap_mbox **);
+int omap_mbox_register(struct mbox_info *arch_mbi);
 int omap_mbox_unregister(void);
 
 void omap_mbox_save_ctx(struct omap_mbox *mbox);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 98b36dc..3cfb405 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -29,79 +29,76 @@
 #include <linux/kfifo.h>
 #include <linux/err.h>
 #include <linux/notifier.h>
+#include <linux/platform_device.h>
 
 #include <plat/mailbox.h>
 
+static struct mbox_info *mbi;
 static struct omap_mbox **mboxes;
 
-static int mbox_configured;
 static DEFINE_MUTEX(mbox_configured_lock);
 
-static unsigned int mbox_kfifo_size = CONFIG_OMAP_MBOX_KFIFO_SIZE;
-module_param(mbox_kfifo_size, uint, S_IRUGO);
-MODULE_PARM_DESC(mbox_kfifo_size, "Size of omap's mailbox kfifo (bytes)");
-
 /* Mailbox FIFO handle functions */
 static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
 {
-	return mbox->ops->fifo_read(mbox);
+	return mbi->ops->fifo_read(mbox);
 }
 static inline void mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
 {
-	mbox->ops->fifo_write(mbox, msg);
+	mbi->ops->fifo_write(mbox, msg);
 }
 static inline int mbox_fifo_empty(struct omap_mbox *mbox)
 {
-	return mbox->ops->fifo_empty(mbox);
+	return mbi->ops->fifo_empty(mbox);
 }
 static inline int mbox_fifo_full(struct omap_mbox *mbox)
 {
-	return mbox->ops->fifo_full(mbox);
+	return mbi->ops->fifo_full(mbox);
 }
 
 /* Mailbox IRQ handle functions */
 void omap_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
-	mbox->ops->enable_irq(mbox, irq);
+	mbi->ops->enable_irq(mbox, irq);
 }
 EXPORT_SYMBOL(omap_mbox_enable_irq);
 
 void omap_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
-	mbox->ops->disable_irq(mbox, irq);
+	mbi->ops->disable_irq(mbox, irq);
 }
 EXPORT_SYMBOL(omap_mbox_disable_irq);
 
 static inline void ack_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
-	if (mbox->ops->ack_irq)
-		mbox->ops->ack_irq(mbox, irq);
+	if (mbi->ops->ack_irq)
+		mbi->ops->ack_irq(mbox, irq);
 }
 static inline int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
-	return mbox->ops->is_irq(mbox, irq);
+	return mbi->ops->is_irq(mbox, irq);
 }
 
 /* Mailbox context functions */
 void omap_mbox_save_ctx(struct omap_mbox *mbox)
 {
-	if (!mbox->ops->save_ctx) {
+	if (!mbi->ops->save_ctx) {
 		dev_err(mbox->dev, "%s:\tno save\n", __func__);
 		return;
 	}
 
-	mbox->ops->save_ctx(mbox);
+	mbi->ops->save_ctx(mbox);
 }
 EXPORT_SYMBOL(omap_mbox_save_ctx);
 
 void omap_mbox_restore_ctx(struct omap_mbox *mbox)
 {
-	if (!mbox->ops->restore_ctx) {
+	if (!mbi->ops->restore_ctx) {
 		dev_err(mbox->dev, "%s:\tno restore\n", __func__);
 		return;
 	}
 
-	mbox->ops->restore_ctx(mbox);
+	mbi->ops->restore_ctx(mbox);
 }
 EXPORT_SYMBOL(omap_mbox_restore_ctx);
 
@@ -113,7 +110,7 @@ static int __mbox_poll_for_space(struct omap_mbox *mbox)
 	int ret = 0, i = 1000;
 
 	while (mbox_fifo_full(mbox)) {
-		if (mbox->ops->type == OMAP_MBOX_TYPE2)
+		if (mbi->ops->type == OMAP_MBOX_TYPE2)
 			return -1;
 		if (--i == 0)
 			return -1;
@@ -224,7 +221,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 		len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
 		WARN_ON(len != sizeof(msg));
 
-		if (mbox->ops->type == OMAP_MBOX_TYPE1)
+		if (mbi->ops->type == OMAP_MBOX_TYPE1)
 			break;
 	}
 
@@ -259,7 +256,7 @@ static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 
 	spin_lock_init(&mq->lock);
 
-	if (kfifo_alloc(&mq->fifo, mbox_kfifo_size, GFP_KERNEL))
+	if (kfifo_alloc(&mq->fifo, mbi->kfifo_size, GFP_KERNEL))
 		goto error;
 
 	if (work)
@@ -284,17 +281,16 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	int ret = 0;
 	struct omap_mbox_queue *mq;
 
-	mutex_lock(&mbox_configured_lock);
-	if (!mbox_configured++) {
-		if (likely(mbox->ops->startup)) {
-			ret = mbox->ops->startup(mbox);
+	if (!mbi->configured++) {
+		if (likely(mbi->ops->startup)) {
+			ret = mbi->ops->startup(mbox);
 			if (unlikely(ret))
 				goto fail_startup;
 		} else
 			goto fail_startup;
 	}
 
-	if (!mbox->use_count++) {
+	if (mbox->irq > 0) {
 		ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
 							mbox->name, mbox);
 		if (unlikely(ret)) {
@@ -302,135 +298,203 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 									ret);
 			goto fail_request_irq;
 		}
-		mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
-		if (!mq) {
-			ret = -ENOMEM;
-			goto fail_alloc_txq;
-		}
-		mbox->txq = mq;
+	}
 
-		mq = mbox_queue_alloc(mbox, mbox_rx_work, NULL);
-		if (!mq) {
-			ret = -ENOMEM;
-			goto fail_alloc_rxq;
-		}
-		mbox->rxq = mq;
-		mq->mbox = mbox;
+	mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
+	if (!mq) {
+		ret = -ENOMEM;
+		goto fail_alloc_txq;
 	}
-	mutex_unlock(&mbox_configured_lock);
+	mbox->txq = mq;
+
+	BLOCKING_INIT_NOTIFIER_HEAD(&mbox->notifier);
+	mq = mbox_queue_alloc(mbox, mbox_rx_work, NULL);
+	if (!mq) {
+		ret = -ENOMEM;
+		goto fail_alloc_rxq;
+	}
+	mbox->rxq = mq;
+	mq->mbox = mbox;
+
 	return 0;
 
 fail_alloc_rxq:
 	mbox_queue_free(mbox->txq);
 fail_alloc_txq:
-	free_irq(mbox->irq, mbox);
+	if (mbox->irq > 0)
+		free_irq(mbox->irq, mbox);
 fail_request_irq:
-	if (mbox->ops->shutdown)
-		mbox->ops->shutdown(mbox);
-	mbox->use_count--;
+	if (mbi->ops->shutdown)
+		mbi->ops->shutdown(mbox);
 fail_startup:
-	mbox_configured--;
-	mutex_unlock(&mbox_configured_lock);
+	mbi->configured--;
 	return ret;
 }
 
 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
-	mutex_lock(&mbox_configured_lock);
-
-	if (!--mbox->use_count) {
+	if (mbox->irq > 0)
 		free_irq(mbox->irq, mbox);
-		tasklet_kill(&mbox->txq->tasklet);
+
+	tasklet_kill(&mbox->txq->tasklet);
 	flush_work_sync(&mbox->rxq->work);
-		mbox_queue_free(mbox->txq);
-		mbox_queue_free(mbox->rxq);
-	}
+	mbox_queue_free(mbox->txq);
+	mbox_queue_free(mbox->rxq);
 
-	if (likely(mbox->ops->shutdown)) {
-		if (!--mbox_configured)
-			mbox->ops->shutdown(mbox);
+	if (likely(mbi->ops->shutdown)) {
+		if (!--mbi->configured)
+			mbi->ops->shutdown(mbox);
 	}
-
-	mutex_unlock(&mbox_configured_lock);
 }
 
-struct omap_mbox *omap_mbox_get(const char *name, struct notifier_block *nb)
+struct omap_mbox *_mbox_request(u16 id, u16 owner, char *name,
+				struct notifier_block *nb)
 {
-	struct omap_mbox *_mbox, *mbox = NULL;
-	int i, ret;
+	struct omap_mbox *mbox;
+	struct platform_device *pdev;
+	int ret, len;
 
-	if (!mboxes)
-		return ERR_PTR(-EINVAL);
+	if (mbi->nr_mbox <= id)
+		return ERR_PTR(-EPERM);
 
-	for (i = 0; (_mbox = mboxes[i]); i++) {
-		if (!strcmp(_mbox->name, name)) {
-			mbox = _mbox;
-			break;
-		}
+	mutex_lock(&mbox_configured_lock);
+
+	if (mboxes[id]) {
+		mbox = mboxes[id];
+		goto unlock;
+	}
+
+	mbox = kzalloc(sizeof(struct omap_mbox), GFP_KERNEL);
+	if (!mbox) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	mbox->priv = mbi->ops->request(id, owner);
+	if (!mbox->priv) {
+		ret = -ENODEV;
+		goto err2;
 	}
 
-	if (!mbox)
-		return ERR_PTR(-ENOENT);
+	mbox->dev = mbi->dev;
+	pdev = container_of(mbox->dev, struct platform_device, dev);
+
+	if (name)
+		mbox->irq = platform_get_irq_byname(pdev, name);
+	else if (owner == 0)
+		mbox->irq = platform_get_irq(pdev, owner);
+	else
+		mbox->irq = 0;
+
+	if (IS_ERR_VALUE(mbox->irq)) {
+		ret = mbox->irq;
+		goto err3;
+	}
+
+	len = snprintf(NULL, 0, "mbox%d", id);
+	mbox->name = kzalloc(len + 1, GFP_KERNEL);
+	if (!mbox->name) {
+		ret = -ENOMEM;
+		goto err3;
+	}
+	snprintf(mbox->name, len + 1, "mbox%d", id);
 
 	ret = omap_mbox_startup(mbox);
 	if (ret)
-		return ERR_PTR(-ENODEV);
+		goto err4;
 
-	if (nb)
+	mbox->id = id;
+	mboxes[id] = mbox;
+
+unlock:
+	if (nb) {
 		blocking_notifier_chain_register(&mbox->notifier, nb);
+		omap_mbox_enable_irq(mbox, IRQ_RX);
+	}
+
+	mbox->use_count++;
+
+	mutex_unlock(&mbox_configured_lock);
 
 	return mbox;
+
+err4:
+	kfree(mbox->name);
+err3:
+	mbi->ops->release(mbox->priv);
+err2:
+	kfree(mbox);
+err1:
+	mutex_unlock(&mbox_configured_lock);
+	return ERR_PTR(ret);
+}
+
+struct omap_mbox *mbox_request_byname(u16 id, char *name,
+					struct notifier_block *nb)
+{
+	return _mbox_request(id, 0, name, nb);
 }
-EXPORT_SYMBOL(omap_mbox_get);
+EXPORT_SYMBOL(mbox_request_byname);
 
-void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb)
+void *mbox_request(u16 id, u16 owner, struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&mbox->notifier, nb);
-	omap_mbox_fini(mbox);
+	return _mbox_request(id, owner, NULL, nb);
 }
-EXPORT_SYMBOL(omap_mbox_put);
+EXPORT_SYMBOL(mbox_request);
+
+void mbox_release(struct omap_mbox *mbox, struct notifier_block *nb)
+{
+	mutex_lock(&mbox_configured_lock);
+
+	if (nb)
+		blocking_notifier_chain_unregister(&mbox->notifier, nb);
+
+	if (!--mbox->use_count) {
+		omap_mbox_disable_irq(mbox, IRQ_TX);
+		omap_mbox_disable_irq(mbox, IRQ_RX);
+		omap_mbox_fini(mbox);
+
+		mbi->ops->release(mbox->priv);
+		mboxes[mbox->id] = NULL;
+		kfree(mbox->name);
+		kfree(mbox);
+	}
+
+	mutex_unlock(&mbox_configured_lock);
+}
+EXPORT_SYMBOL(mbox_release);
 
 static struct class omap_mbox_class = { .name = "mbox", };
 
-int omap_mbox_register(struct device *parent, struct omap_mbox **list)
+int omap_mbox_register(struct mbox_info *arch_mbi)
 {
-	int ret;
-	int i;
+	if (!arch_mbi)
+		return -EFAULT;
 
-	mboxes = list;
-	if (!mboxes)
-		return -EINVAL;
+	mbi = arch_mbi;
 
-	for (i = 0; mboxes[i]; i++) {
-		struct omap_mbox *mbox = mboxes[i];
-		mbox->dev = device_create(&omap_mbox_class,
-				parent, 0, mbox, "%s", mbox->name);
-		if (IS_ERR(mbox->dev)) {
-			ret = PTR_ERR(mbox->dev);
-			goto err_out;
-		}
+	/* kfifo size sanity check: alignment and minimal size */
+	mbi->kfifo_size = ALIGN(mbi->kfifo_size, sizeof(mbox_msg_t));
+	mbi->kfifo_size = max_t(unsigned int, mbi->kfifo_size,
+							sizeof(mbox_msg_t));
 
-		BLOCKING_INIT_NOTIFIER_HEAD(&mbox->notifier);
+	mboxes = kzalloc(sizeof(struct omap_mbox *) * mbi->nr_mbox, GFP_KERNEL);
+	if (!mboxes) {
+		mbi = NULL;
+		return -ENOMEM;
 	}
-	return 0;
 
-err_out:
-	while (i--)
-		device_unregister(mboxes[i]->dev);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(omap_mbox_register);
 
 int omap_mbox_unregister(void)
 {
-	int i;
-
-	if (!mboxes)
+	if (!mbi)
 		return -EINVAL;
 
-	for (i = 0; mboxes[i]; i++)
-		device_unregister(mboxes[i]->dev);
-	mboxes = NULL;
+	mbi = NULL;
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_mbox_unregister);
@@ -443,11 +507,6 @@ static int __init omap_mbox_init(void)
 	if (err)
 		return err;
 
-	/* kfifo size sanity check: alignment and minimal size */
-	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(mbox_msg_t));
-	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size,
-							sizeof(mbox_msg_t));
-
 	return 0;
 }
 subsys_initcall(omap_mbox_init);
-- 
1.7.0.4

