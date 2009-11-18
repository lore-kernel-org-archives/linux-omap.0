From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/10] omap: mailbox: remove class interface
Date: Wed, 18 Nov 2009 11:20:41 -0800
Message-ID: <20091118192041.31148.19645.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50013 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932613AbZKRTUg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 14:20:36 -0500
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

It's not used at present.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    1 
 arch/arm/plat-omap/mailbox.c              |  115 ++---------------------------
 2 files changed, 9 insertions(+), 107 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index b7a6991..319306a 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -8,7 +8,6 @@
 #include <linux/blkdev.h>
 
 typedef u32 mbox_msg_t;
-typedef void (mbox_receiver_t)(mbox_msg_t msg);
 struct omap_mbox;
 
 typedef int __bitwise omap_mbox_irq_t;
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index f82810e..13ca236 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -71,7 +71,7 @@ static inline int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 /*
  * message sender
  */
-static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg, void *arg)
+static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 {
 	int ret = 0, i = 1000;
 
@@ -82,15 +82,7 @@ static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg, void *arg)
 			return -1;
 		udelay(1);
 	}
-
-	if (arg && mbox->txq->callback) {
-		ret = mbox->txq->callback(arg);
-		if (ret)
-			goto out;
-	}
-
 	mbox_fifo_write(mbox, msg);
- out:
 	return ret;
 }
 
@@ -152,7 +144,7 @@ static void mbox_tx_work(struct work_struct *work)
 
 		tx_data = rq->special;
 
-		ret = __mbox_msg_send(mbox, tx_data->msg, tx_data->arg);
+		ret = __mbox_msg_send(mbox, tx_data->msg);
 		if (ret) {
 			enable_mbox_irq(mbox, IRQ_TX);
 			spin_lock(q->queue_lock);
@@ -180,11 +172,6 @@ static void mbox_rx_work(struct work_struct *work)
 	mbox_msg_t msg;
 	unsigned long flags;
 
-	if (mbox->rxq->callback == NULL) {
-		sysfs_notify(&mbox->dev->kobj, NULL, "mbox");
-		return;
-	}
-
 	while (1) {
 		spin_lock_irqsave(q->queue_lock, flags);
 		rq = blk_fetch_request(q);
@@ -257,69 +244,6 @@ static irqreturn_t mbox_interrupt(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-/*
- * sysfs files
- */
-static ssize_t
-omap_mbox_write(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	int ret;
-	mbox_msg_t *p = (mbox_msg_t *)buf;
-	struct omap_mbox *mbox = dev_get_drvdata(dev);
-
-	for (; count >= sizeof(mbox_msg_t); count -= sizeof(mbox_msg_t)) {
-		ret = omap_mbox_msg_send(mbox, be32_to_cpu(*p), NULL);
-		if (ret)
-			return -EAGAIN;
-		p++;
-	}
-
-	return (size_t)((char *)p - buf);
-}
-
-static ssize_t
-omap_mbox_read(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	unsigned long flags;
-	struct request *rq;
-	mbox_msg_t *p = (mbox_msg_t *) buf;
-	struct omap_mbox *mbox = dev_get_drvdata(dev);
-	struct request_queue *q = mbox->rxq->queue;
-
-	while (1) {
-		spin_lock_irqsave(q->queue_lock, flags);
-		rq = blk_fetch_request(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-
-		if (!rq)
-			break;
-
-		*p = (mbox_msg_t)rq->special;
-
-		blk_end_request_all(rq, 0);
-
-		p++;
-	}
-
-	pr_debug("%02x %02x %02x %02x\n", buf[0], buf[1], buf[2], buf[3]);
-
-	return (size_t) ((char *)p - buf);
-}
-
-static DEVICE_ATTR(mbox, S_IRUGO | S_IWUSR, omap_mbox_read, omap_mbox_write);
-
-static ssize_t mbox_show(struct class *class, char *buf)
-{
-	return sprintf(buf, "mbox");
-}
-
-static CLASS_ATTR(mbox, S_IRUGO, mbox_show, NULL);
-
-static struct class omap_mbox_class = {
-	.name = "omap-mailbox",
-};
-
 static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 					request_fn_proc *proc,
 					void (*work) (struct work_struct *))
@@ -353,7 +277,7 @@ static void mbox_queue_free(struct omap_mbox_queue *q)
 	kfree(q);
 }
 
-static int omap_mbox_init(struct omap_mbox *mbox)
+static int omap_mbox_startup(struct omap_mbox *mbox)
 {
 	int ret;
 	struct omap_mbox_queue *mq;
@@ -436,7 +360,7 @@ struct omap_mbox *omap_mbox_get(const char *name)
 
 	read_unlock(&mboxes_lock);
 
-	ret = omap_mbox_init(mbox);
+	ret = omap_mbox_startup(mbox);
 	if (ret)
 		return ERR_PTR(-ENODEV);
 
@@ -460,15 +384,6 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 	if (mbox->next)
 		return -EBUSY;
 
-	mbox->dev = device_create(&omap_mbox_class,
-				  parent, 0, mbox, "%s", mbox->name);
-	if (IS_ERR(mbox->dev))
-		return PTR_ERR(mbox->dev);
-
-	ret = device_create_file(mbox->dev, &dev_attr_mbox);
-	if (ret)
-		goto err_sysfs;
-
 	write_lock(&mboxes_lock);
 	tmp = find_mboxes(mbox->name);
 	if (*tmp) {
@@ -482,9 +397,6 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 	return 0;
 
 err_find:
-	device_remove_file(mbox->dev, &dev_attr_mbox);
-err_sysfs:
-	device_unregister(mbox->dev);
 	return ret;
 }
 EXPORT_SYMBOL(omap_mbox_register);
@@ -500,8 +412,6 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 			*tmp = mbox->next;
 			mbox->next = NULL;
 			write_unlock(&mboxes_lock);
-			device_remove_file(mbox->dev, &dev_attr_mbox);
-			device_unregister(mbox->dev);
 			return 0;
 		}
 		tmp = &(*tmp)->next;
@@ -512,23 +422,16 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 }
 EXPORT_SYMBOL(omap_mbox_unregister);
 
-static int __init omap_mbox_class_init(void)
+static int __init omap_mbox_init(void)
 {
-	int ret = class_register(&omap_mbox_class);
-	if (!ret)
-		ret = class_create_file(&omap_mbox_class, &class_attr_mbox);
-
-	return ret;
+	return 0;
 }
+module_init(omap_mbox_init);
 
-static void __exit omap_mbox_class_exit(void)
+static void __exit omap_mbox_exit(void)
 {
-	class_remove_file(&omap_mbox_class, &class_attr_mbox);
-	class_unregister(&omap_mbox_class);
 }
-
-subsys_initcall(omap_mbox_class_init);
-module_exit(omap_mbox_class_exit);
+module_exit(omap_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: interrupt driven messaging");

