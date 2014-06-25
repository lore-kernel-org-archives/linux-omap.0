From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 6/7] mailbox/omap: remove the private mailbox structure
Date: Tue, 24 Jun 2014 19:43:42 -0500
Message-ID: <1403657023-53897-7-git-send-email-s-anna@ti.com>
References: <1403657023-53897-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54306 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbaFYApI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2014 20:45:08 -0400
In-Reply-To: <1403657023-53897-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The structure omap_mbox_priv is used previously to store arch
specific (OMAP1 vs OMAP2+) data, and is no longer required to be
maintained separately. Instead, absorb its elements into either
the sub-mailbox device structure, omap_mbox, or the individual
fifo descriptor structure, omap_mbox_fifo.

The newmsg_bit and notfull_bit used on Rx and Tx fifos respectively
are represented by the new intr_bit field in the fifo descriptor
structure. The interrupt configuration registers are also moved
into the fifo descriptor structure to allow the Rx and Tx fifos
to use different interrupt lines/users.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 126 ++++++++++++++++++++---------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 66b02ab..d9a5039 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -69,18 +69,10 @@ struct omap_mbox_fifo {
 	unsigned long msg;
 	unsigned long fifo_stat;
 	unsigned long msg_stat;
-};
-
-struct omap_mbox_priv {
-	struct omap_mbox_fifo tx_fifo;
-	struct omap_mbox_fifo rx_fifo;
 	unsigned long irqenable;
 	unsigned long irqstatus;
-	u32 newmsg_bit;
-	u32 notfull_bit;
-	u32 ctx[OMAP4_MBOX_NR_REGS];
 	unsigned long irqdisable;
-	u32 intr_type;
+	u32 intr_bit;
 };
 
 struct omap_mbox_queue {
@@ -97,7 +89,10 @@ struct omap_mbox {
 	int			irq;
 	struct omap_mbox_queue	*txq, *rxq;
 	struct device		*dev;
-	void			*priv;
+	struct omap_mbox_fifo	tx_fifo;
+	struct omap_mbox_fifo	rx_fifo;
+	u32			ctx[OMAP4_MBOX_NR_REGS];
+	u32			intr_type;
 	int			use_count;
 	struct blocking_notifier_head	notifier;
 };
@@ -124,50 +119,52 @@ static inline void mbox_write_reg(u32 val, size_t ofs)
 /* Mailbox FIFO handle functions */
 static mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
 {
-	struct omap_mbox_fifo *fifo =
-		&((struct omap_mbox_priv *)mbox->priv)->rx_fifo;
+	struct omap_mbox_fifo *fifo = &mbox->rx_fifo;
 	return (mbox_msg_t) mbox_read_reg(fifo->msg);
 }
 
 static void mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
 {
-	struct omap_mbox_fifo *fifo =
-		&((struct omap_mbox_priv *)mbox->priv)->tx_fifo;
+	struct omap_mbox_fifo *fifo = &mbox->tx_fifo;
 	mbox_write_reg(msg, fifo->msg);
 }
 
 static int mbox_fifo_empty(struct omap_mbox *mbox)
 {
-	struct omap_mbox_fifo *fifo =
-		&((struct omap_mbox_priv *)mbox->priv)->rx_fifo;
+	struct omap_mbox_fifo *fifo = &mbox->rx_fifo;
 	return (mbox_read_reg(fifo->msg_stat) == 0);
 }
 
 static int mbox_fifo_full(struct omap_mbox *mbox)
 {
-	struct omap_mbox_fifo *fifo =
-		&((struct omap_mbox_priv *)mbox->priv)->tx_fifo;
+	struct omap_mbox_fifo *fifo = &mbox->tx_fifo;
 	return mbox_read_reg(fifo->fifo_stat);
 }
 
 /* Mailbox IRQ handle functions */
 static void ack_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
-	struct omap_mbox_priv *p = mbox->priv;
-	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
+	struct omap_mbox_fifo *fifo = (irq == IRQ_TX) ?
+				&mbox->tx_fifo : &mbox->rx_fifo;
+	u32 bit = fifo->intr_bit;
+	u32 irqstatus = fifo->irqstatus;
 
-	mbox_write_reg(bit, p->irqstatus);
+	mbox_write_reg(bit, irqstatus);
 
 	/* Flush posted write for irq status to avoid spurious interrupts */
-	mbox_read_reg(p->irqstatus);
+	mbox_read_reg(irqstatus);
 }
 
 static int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
-	struct omap_mbox_priv *p = mbox->priv;
-	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
-	u32 enable = mbox_read_reg(p->irqenable);
-	u32 status = mbox_read_reg(p->irqstatus);
+	struct omap_mbox_fifo *fifo = (irq == IRQ_TX) ?
+				&mbox->tx_fifo : &mbox->rx_fifo;
+	u32 bit = fifo->intr_bit;
+	u32 irqenable = fifo->irqenable;
+	u32 irqstatus = fifo->irqstatus;
+
+	u32 enable = mbox_read_reg(irqenable);
+	u32 status = mbox_read_reg(irqstatus);
 
 	return (int)(enable & status & bit);
 }
@@ -206,18 +203,17 @@ EXPORT_SYMBOL(omap_mbox_msg_send);
 void omap_mbox_save_ctx(struct omap_mbox *mbox)
 {
 	int i;
-	struct omap_mbox_priv *p = mbox->priv;
 	int nr_regs;
 
-	if (p->intr_type)
+	if (mbox->intr_type)
 		nr_regs = OMAP4_MBOX_NR_REGS;
 	else
 		nr_regs = MBOX_NR_REGS;
 	for (i = 0; i < nr_regs; i++) {
-		p->ctx[i] = mbox_read_reg(i * sizeof(u32));
+		mbox->ctx[i] = mbox_read_reg(i * sizeof(u32));
 
 		dev_dbg(mbox->dev, "%s: [%02x] %08x\n", __func__,
-			i, p->ctx[i]);
+			i, mbox->ctx[i]);
 	}
 }
 EXPORT_SYMBOL(omap_mbox_save_ctx);
@@ -225,46 +221,50 @@ EXPORT_SYMBOL(omap_mbox_save_ctx);
 void omap_mbox_restore_ctx(struct omap_mbox *mbox)
 {
 	int i;
-	struct omap_mbox_priv *p = mbox->priv;
 	int nr_regs;
 
-	if (p->intr_type)
+	if (mbox->intr_type)
 		nr_regs = OMAP4_MBOX_NR_REGS;
 	else
 		nr_regs = MBOX_NR_REGS;
 	for (i = 0; i < nr_regs; i++) {
-		mbox_write_reg(p->ctx[i], i * sizeof(u32));
+		mbox_write_reg(mbox->ctx[i], i * sizeof(u32));
 
 		dev_dbg(mbox->dev, "%s: [%02x] %08x\n", __func__,
-			i, p->ctx[i]);
+			i, mbox->ctx[i]);
 	}
 }
 EXPORT_SYMBOL(omap_mbox_restore_ctx);
 
 void omap_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
-	struct omap_mbox_priv *p = mbox->priv;
-	u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
+	u32 l;
+	struct omap_mbox_fifo *fifo = (irq == IRQ_TX) ?
+				&mbox->tx_fifo : &mbox->rx_fifo;
+	u32 bit = fifo->intr_bit;
+	u32 irqenable = fifo->irqenable;
 
-	l = mbox_read_reg(p->irqenable);
+	l = mbox_read_reg(irqenable);
 	l |= bit;
-	mbox_write_reg(l, p->irqenable);
+	mbox_write_reg(l, irqenable);
 }
 EXPORT_SYMBOL(omap_mbox_enable_irq);
 
 void omap_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
-	struct omap_mbox_priv *p = mbox->priv;
-	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
+	struct omap_mbox_fifo *fifo = (irq == IRQ_TX) ?
+				&mbox->tx_fifo : &mbox->rx_fifo;
+	u32 bit = fifo->intr_bit;
+	u32 irqdisable = fifo->irqdisable;
 
 	/*
 	 * Read and update the interrupt configuration register for pre-OMAP4.
 	 * OMAP4 and later SoCs have a dedicated interrupt disabling register.
 	 */
-	if (!p->intr_type)
-		bit = mbox_read_reg(p->irqdisable) & ~bit;
+	if (!mbox->intr_type)
+		bit = mbox_read_reg(irqdisable) & ~bit;
 
-	mbox_write_reg(bit, p->irqdisable);
+	mbox_write_reg(bit, irqdisable);
 }
 EXPORT_SYMBOL(omap_mbox_disable_irq);
 
@@ -548,9 +548,9 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	struct resource *mem;
 	int ret;
 	struct omap_mbox **list, *mbox, *mboxblk;
-	struct omap_mbox_priv *priv, *privblk;
 	struct omap_mbox_pdata *pdata = pdev->dev.platform_data;
 	struct omap_mbox_dev_info *info;
+	struct omap_mbox_fifo *fifo;
 	u32 intr_type;
 	u32 l;
 	int i;
@@ -571,28 +571,28 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	if (!mboxblk)
 		return -ENOMEM;
 
-	privblk = devm_kzalloc(&pdev->dev, pdata->info_cnt * sizeof(*priv),
-			       GFP_KERNEL);
-	if (!privblk)
-		return -ENOMEM;
-
 	info = pdata->info;
 	intr_type = pdata->intr_type;
 	mbox = mboxblk;
-	priv = privblk;
-	for (i = 0; i < pdata->info_cnt; i++, info++, priv++) {
-		priv->tx_fifo.msg = MAILBOX_MESSAGE(info->tx_id);
-		priv->tx_fifo.fifo_stat = MAILBOX_FIFOSTATUS(info->tx_id);
-		priv->rx_fifo.msg =  MAILBOX_MESSAGE(info->rx_id);
-		priv->rx_fifo.msg_stat =  MAILBOX_MSGSTATUS(info->rx_id);
-		priv->notfull_bit = MAILBOX_IRQ_NOTFULL(info->tx_id);
-		priv->newmsg_bit = MAILBOX_IRQ_NEWMSG(info->rx_id);
-		priv->irqenable = MAILBOX_IRQENABLE(intr_type, info->usr_id);
-		priv->irqstatus = MAILBOX_IRQSTATUS(intr_type, info->usr_id);
-		priv->irqdisable = MAILBOX_IRQDISABLE(intr_type, info->usr_id);
-		priv->intr_type = intr_type;
-
-		mbox->priv = priv;
+	for (i = 0; i < pdata->info_cnt; i++, info++) {
+		fifo = &mbox->tx_fifo;
+		fifo->msg = MAILBOX_MESSAGE(info->tx_id);
+		fifo->fifo_stat = MAILBOX_FIFOSTATUS(info->tx_id);
+		fifo->intr_bit = MAILBOX_IRQ_NOTFULL(info->tx_id);
+		fifo->irqenable = MAILBOX_IRQENABLE(intr_type, info->usr_id);
+		fifo->irqstatus = MAILBOX_IRQSTATUS(intr_type, info->usr_id);
+		fifo->irqdisable = MAILBOX_IRQDISABLE(intr_type, info->usr_id);
+
+		fifo = &mbox->rx_fifo;
+		fifo->msg =  MAILBOX_MESSAGE(info->rx_id);
+		fifo->msg_stat =  MAILBOX_MSGSTATUS(info->rx_id);
+		fifo->intr_bit = MAILBOX_IRQ_NEWMSG(info->rx_id);
+		fifo->irqenable = MAILBOX_IRQENABLE(intr_type, info->usr_id);
+		fifo->irqstatus = MAILBOX_IRQSTATUS(intr_type, info->usr_id);
+		fifo->irqdisable = MAILBOX_IRQDISABLE(intr_type, info->usr_id);
+
+		mbox->intr_type = intr_type;
+
 		mbox->name = info->name;
 		mbox->irq = platform_get_irq(pdev, info->irq_id);
 		if (mbox->irq < 0)
-- 
2.0.0

