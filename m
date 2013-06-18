From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/3] mailbox/omap: add a parent structure common to all mboxes
Date: Tue, 18 Jun 2013 17:34:48 -0500
Message-ID: <1371594888-37567-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51511 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200Ab3FRWkc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jun 2013 18:40:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Suman Anna <s-anna@ti.com>

A new structure, omap_mbox_device, is added to contain
the global variables pertinent to a mailbox h/w IP block.
This enables the support for having multiple instances of
the same h/w IP block in the SoC. The startup sequence for
each mailbox is also simplified along the way, removing the
usage of single global configuration variables for all h/w
instances.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/mailbox-omap1.c | 27 +++++++++---
 drivers/mailbox/mailbox-omap2.c | 95 +++++++++++++++++++++++++----------------
 drivers/mailbox/omap-mailbox.c  | 32 ++++++--------
 drivers/mailbox/omap-mbox.h     | 10 +++++
 4 files changed, 102 insertions(+), 62 deletions(-)

diff --git a/drivers/mailbox/mailbox-omap1.c b/drivers/mailbox/mailbox-omap1.c
index 9001b76..5e38ffc 100644
--- a/drivers/mailbox/mailbox-omap1.c
+++ b/drivers/mailbox/mailbox-omap1.c
@@ -26,7 +26,7 @@
 #define MAILBOX_DSP2ARM1_Flag		0x1c
 #define MAILBOX_DSP2ARM2_Flag		0x20
 
-static void __iomem *mbox_base;
+static struct omap_mbox_device omap1_mbox_device;
 
 struct omap_mbox1_fifo {
 	unsigned long cmd;
@@ -41,12 +41,12 @@ struct omap_mbox1_priv {
 
 static inline int mbox_read_reg(size_t ofs)
 {
-	return __raw_readw(mbox_base + ofs);
+	return __raw_readw(omap1_mbox_device.mbox_base + ofs);
 }
 
 static inline void mbox_write_reg(u32 val, size_t ofs)
 {
-	__raw_writew(val, mbox_base + ofs);
+	__raw_writew(val, omap1_mbox_device.mbox_base + ofs);
 }
 
 /* msg */
@@ -139,6 +139,7 @@ static struct omap_mbox mbox_dsp_info = {
 	.name	= "dsp",
 	.ops	= &omap1_mbox_ops,
 	.priv	= &omap1_mbox_dsp_priv,
+	.parent	= &omap1_mbox_device,
 };
 
 static struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
@@ -148,6 +149,7 @@ static int omap1_mbox_probe(struct platform_device *pdev)
 	struct resource *mem;
 	int ret;
 	struct omap_mbox **list;
+	struct omap_mbox_device *mdev = &omap1_mbox_device;
 
 	list = omap1_mboxes;
 	list[0]->irq = platform_get_irq_byname(pdev, "dsp");
@@ -156,13 +158,18 @@ static int omap1_mbox_probe(struct platform_device *pdev)
 	if (!mem)
 		return -ENOENT;
 
-	mbox_base = ioremap(mem->start, resource_size(mem));
-	if (!mbox_base)
+	mdev->mbox_base = ioremap(mem->start, resource_size(mem));
+	if (!mdev->mbox_base)
 		return -ENOMEM;
+	mutex_init(&mdev->cfg_lock);
+	mdev->dev = &pdev->dev;
+	mdev->mboxes = omap1_mboxes;
+	mdev->num_users = 2;
+	mdev->num_fifos = 4;
 
 	ret = omap_mbox_register(&pdev->dev, list);
 	if (ret) {
-		iounmap(mbox_base);
+		iounmap(mdev->mbox_base);
 		return ret;
 	}
 
@@ -171,8 +178,14 @@ static int omap1_mbox_probe(struct platform_device *pdev)
 
 static int omap1_mbox_remove(struct platform_device *pdev)
 {
+	struct omap_mbox_device *mdev = &omap1_mbox_device;
+
 	omap_mbox_unregister();
-	iounmap(mbox_base);
+	iounmap(mdev->mbox_base);
+	mdev->mbox_base = NULL;
+	mdev->mboxes = NULL;
+	mdev->dev = NULL;
+
 	return 0;
 }
 
diff --git a/drivers/mailbox/mailbox-omap2.c b/drivers/mailbox/mailbox-omap2.c
index eba380d..6c0687c 100644
--- a/drivers/mailbox/mailbox-omap2.c
+++ b/drivers/mailbox/mailbox-omap2.c
@@ -42,8 +42,6 @@
 #define MBOX_NR_REGS			(MBOX_REG_SIZE / sizeof(u32))
 #define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / sizeof(u32))
 
-static void __iomem *mbox_base;
-
 struct omap_mbox2_fifo {
 	unsigned long msg;
 	unsigned long fifo_stat;
@@ -62,34 +60,38 @@ struct omap_mbox2_priv {
 	u32 intr_type;
 };
 
-static inline unsigned int mbox_read_reg(size_t ofs)
+static inline
+unsigned int mbox_read_reg(struct omap_mbox_device *mdev, size_t ofs)
 {
-	return __raw_readl(mbox_base + ofs);
+	return __raw_readl(mdev->mbox_base + ofs);
 }
 
-static inline void mbox_write_reg(u32 val, size_t ofs)
+static inline
+void mbox_write_reg(struct omap_mbox_device *mdev, u32 val, size_t ofs)
 {
-	__raw_writel(val, mbox_base + ofs);
+	__raw_writel(val, mdev->mbox_base + ofs);
 }
 
 /* Mailbox H/W preparations */
 static int omap2_mbox_startup(struct omap_mbox *mbox)
 {
-	u32 l;
-
-	pm_runtime_enable(mbox->dev->parent);
-	pm_runtime_get_sync(mbox->dev->parent);
+	pm_runtime_get_sync(mbox->parent->dev);
 
-	l = mbox_read_reg(MAILBOX_REVISION);
-	pr_debug("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
+	/*
+	 * just print the raw revision register, the format is not
+	 * uniform across all SoCs
+	 */
+	if (!mbox->use_count) {
+		u32 l = mbox_read_reg(mbox->parent, MAILBOX_REVISION);
+		pr_debug("omap mailbox rev 0x%x\n", l);
+	}
 
 	return 0;
 }
 
 static void omap2_mbox_shutdown(struct omap_mbox *mbox)
 {
-	pm_runtime_put_sync(mbox->dev->parent);
-	pm_runtime_disable(mbox->dev->parent);
+	pm_runtime_put_sync(mbox->parent->dev);
 }
 
 /* Mailbox FIFO handle functions */
@@ -97,28 +99,28 @@ static mbox_msg_t omap2_mbox_fifo_read(struct omap_mbox *mbox)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->rx_fifo;
-	return (mbox_msg_t) mbox_read_reg(fifo->msg);
+	return (mbox_msg_t) mbox_read_reg(mbox->parent, fifo->msg);
 }
 
 static void omap2_mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
-	mbox_write_reg(msg, fifo->msg);
+	mbox_write_reg(mbox->parent, msg, fifo->msg);
 }
 
 static int omap2_mbox_fifo_empty(struct omap_mbox *mbox)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->rx_fifo;
-	return (mbox_read_reg(fifo->msg_stat) == 0);
+	return (mbox_read_reg(mbox->parent, fifo->msg_stat) == 0);
 }
 
 static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
-	return mbox_read_reg(fifo->fifo_stat);
+	return mbox_read_reg(mbox->parent, fifo->fifo_stat);
 }
 
 /* Mailbox IRQ handle functions */
@@ -127,9 +129,9 @@ static void omap2_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
 
-	l = mbox_read_reg(p->irqenable);
+	l = mbox_read_reg(mbox->parent, p->irqenable);
 	l |= bit;
-	mbox_write_reg(l, p->irqenable);
+	mbox_write_reg(mbox->parent, l, p->irqenable);
 }
 
 static void omap2_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
@@ -142,9 +144,9 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 	 * OMAP4 and later SoCs have a dedicated interrupt disabling register.
 	 */
 	if (!p->intr_type)
-		bit = mbox_read_reg(p->irqdisable) & ~bit;
+		bit = mbox_read_reg(mbox->parent, p->irqdisable) & ~bit;
 
-	mbox_write_reg(bit, p->irqdisable);
+	mbox_write_reg(mbox->parent, bit, p->irqdisable);
 }
 
 static void omap2_mbox_ack_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
@@ -152,18 +154,18 @@ static void omap2_mbox_ack_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
 
-	mbox_write_reg(bit, p->irqstatus);
+	mbox_write_reg(mbox->parent, bit, p->irqstatus);
 
 	/* Flush posted write for irq status to avoid spurious interrupts */
-	mbox_read_reg(p->irqstatus);
+	mbox_read_reg(mbox->parent, p->irqstatus);
 }
 
 static int omap2_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
-	u32 enable = mbox_read_reg(p->irqenable);
-	u32 status = mbox_read_reg(p->irqstatus);
+	u32 enable = mbox_read_reg(mbox->parent, p->irqenable);
+	u32 status = mbox_read_reg(mbox->parent, p->irqstatus);
 
 	return (int)(enable & status & bit);
 }
@@ -179,7 +181,7 @@ static void omap2_mbox_save_ctx(struct omap_mbox *mbox)
 	else
 		nr_regs = MBOX_NR_REGS;
 	for (i = 0; i < nr_regs; i++) {
-		p->ctx[i] = mbox_read_reg(i * sizeof(u32));
+		p->ctx[i] = mbox_read_reg(mbox->parent, i * sizeof(u32));
 
 		dev_dbg(mbox->dev, "%s: [%02x] %08x\n", __func__,
 			i, p->ctx[i]);
@@ -197,7 +199,7 @@ static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
 	else
 		nr_regs = MBOX_NR_REGS;
 	for (i = 0; i < nr_regs; i++) {
-		mbox_write_reg(p->ctx[i], i * sizeof(u32));
+		mbox_write_reg(mbox->parent, p->ctx[i], i * sizeof(u32));
 
 		dev_dbg(mbox->dev, "%s: [%02x] %08x\n", __func__,
 			i, p->ctx[i]);
@@ -228,6 +230,7 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 	struct omap_mbox2_priv *priv, *privblk;
 	struct omap_mbox_pdata *pdata = pdev->dev.platform_data;
 	struct omap_mbox_dev_info *info;
+	struct omap_mbox_device *mdev;
 	int i;
 
 	if (!pdata || !pdata->info_cnt || !pdata->info) {
@@ -235,10 +238,16 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
+	if (!mdev)
+		return -ENOMEM;
+
 	/* allocate one extra for marking end of list */
 	list = kzalloc((pdata->info_cnt + 1) * sizeof(*list), GFP_KERNEL);
-	if (!list)
-		return -ENOMEM;
+	if (!list) {
+		ret = -ENOMEM;
+		goto free_mdev;
+	}
 
 	mboxblk = mbox = kzalloc(pdata->info_cnt * sizeof(*mbox), GFP_KERNEL);
 	if (!mboxblk) {
@@ -273,6 +282,7 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 		priv->intr_type = pdata->intr_type;
 
 		mbox->priv = priv;
+		mbox->parent = mdev;
 		mbox->name = info->name;
 		mbox->ops = &omap2_mbox_ops;
 		mbox->irq = platform_get_irq(pdev, info->irq_id);
@@ -289,42 +299,55 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 		goto free_privblk;
 	}
 
-	mbox_base = ioremap(mem->start, resource_size(mem));
-	if (!mbox_base) {
+	mdev->mbox_base = ioremap(mem->start, resource_size(mem));
+	if (!mdev->mbox_base) {
 		ret = -ENOMEM;
 		goto free_privblk;
 	}
 
+	mutex_init(&mdev->cfg_lock);
+	mdev->dev = &pdev->dev;
+	mdev->num_users = pdata->num_users;
+	mdev->num_fifos = pdata->num_fifos;
+	mdev->mboxes = list;
 	ret = omap_mbox_register(&pdev->dev, list);
 	if (ret)
 		goto unmap_mbox;
-	platform_set_drvdata(pdev, list);
+	platform_set_drvdata(pdev, mdev);
+
+	pm_runtime_enable(mdev->dev);
 
 	return 0;
 
 unmap_mbox:
-	iounmap(mbox_base);
+	iounmap(mdev->mbox_base);
 free_privblk:
 	kfree(privblk);
 free_mboxblk:
 	kfree(mboxblk);
 free_list:
 	kfree(list);
+free_mdev:
+	kfree(mdev);
 	return ret;
 }
 
 static int omap2_mbox_remove(struct platform_device *pdev)
 {
 	struct omap_mbox2_priv *privblk;
-	struct omap_mbox **list = platform_get_drvdata(pdev);
+	struct omap_mbox_device *mdev = platform_get_drvdata(pdev);
+	struct omap_mbox **list = mdev->mboxes;
 	struct omap_mbox *mboxblk = list[0];
 
+	pm_runtime_disable(mdev->dev);
+
 	privblk = mboxblk->priv;
 	omap_mbox_unregister();
-	iounmap(mbox_base);
+	iounmap(mdev->mbox_base);
 	kfree(privblk);
 	kfree(mboxblk);
 	kfree(list);
+	kfree(mdev);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index d79a646..25a2da7 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -35,9 +35,6 @@
 
 static struct omap_mbox **mboxes;
 
-static int mbox_configured;
-static DEFINE_MUTEX(mbox_configured_lock);
-
 static unsigned int mbox_kfifo_size = CONFIG_OMAP_MBOX_KFIFO_SIZE;
 module_param(mbox_kfifo_size, uint, S_IRUGO);
 MODULE_PARM_DESC(mbox_kfifo_size, "Size of omap's mailbox kfifo (bytes)");
@@ -283,14 +280,12 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 {
 	int ret = 0;
 	struct omap_mbox_queue *mq;
+	struct omap_mbox_device *mdev = mbox->parent;
 
-	mutex_lock(&mbox_configured_lock);
-	if (!mbox_configured++) {
-		if (likely(mbox->ops->startup)) {
-			ret = mbox->ops->startup(mbox);
-			if (unlikely(ret))
-				goto fail_startup;
-		} else
+	mutex_lock(&mdev->cfg_lock);
+	if (mbox->ops->startup) {
+		ret = mbox->ops->startup(mbox);
+		if (ret)
 			goto fail_startup;
 	}
 
@@ -319,7 +314,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 
 		omap_mbox_enable_irq(mbox, IRQ_RX);
 	}
-	mutex_unlock(&mbox_configured_lock);
+	mutex_unlock(&mdev->cfg_lock);
 	return 0;
 
 fail_request_irq:
@@ -331,14 +326,15 @@ fail_alloc_txq:
 		mbox->ops->shutdown(mbox);
 	mbox->use_count--;
 fail_startup:
-	mbox_configured--;
-	mutex_unlock(&mbox_configured_lock);
+	mutex_unlock(&mdev->cfg_lock);
 	return ret;
 }
 
 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
-	mutex_lock(&mbox_configured_lock);
+	struct omap_mbox_device *mdev = mbox->parent;
+
+	mutex_lock(&mdev->cfg_lock);
 
 	if (!--mbox->use_count) {
 		omap_mbox_disable_irq(mbox, IRQ_RX);
@@ -349,12 +345,10 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 		mbox_queue_free(mbox->rxq);
 	}
 
-	if (likely(mbox->ops->shutdown)) {
-		if (!--mbox_configured)
-			mbox->ops->shutdown(mbox);
-	}
+	if (mbox->ops->shutdown)
+		mbox->ops->shutdown(mbox);
 
-	mutex_unlock(&mbox_configured_lock);
+	mutex_unlock(&mdev->cfg_lock);
 }
 
 struct omap_mbox *omap_mbox_get(const char *name, struct notifier_block *nb)
diff --git a/drivers/mailbox/omap-mbox.h b/drivers/mailbox/omap-mbox.h
index 6cd38fc..6df528a 100644
--- a/drivers/mailbox/omap-mbox.h
+++ b/drivers/mailbox/omap-mbox.h
@@ -50,12 +50,22 @@ struct omap_mbox_queue {
 	bool full;
 };
 
+struct omap_mbox_device {
+	struct device *dev;
+	struct mutex cfg_lock;
+	void __iomem *mbox_base;
+	u32 num_users;
+	u32 num_fifos;
+	struct omap_mbox **mboxes;
+};
+
 struct omap_mbox {
 	const char		*name;
 	unsigned int		irq;
 	struct omap_mbox_queue	*txq, *rxq;
 	struct omap_mbox_ops	*ops;
 	struct device		*dev;
+	struct omap_mbox_device *parent;
 	void			*priv;
 	int			use_count;
 	struct blocking_notifier_head	notifier;
-- 
1.8.3.1

