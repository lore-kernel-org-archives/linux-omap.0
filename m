From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv3 6/8] mailbox/omap: remove omap_mbox_type_t from mailbox ops
Date: Tue, 6 Aug 2013 16:40:35 -0500
Message-ID: <1375825235-18263-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44390 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756718Ab3HFVrX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Aug 2013 17:47:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>

The type definition omap_mbox_type_t used for distinguishing
OMAP1 from OMAP2+ mailboxes does not really belong to the
ops, and has been cleaned up.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/mailbox-omap1.c | 27 ++++++++++++++++++++++++---
 drivers/mailbox/mailbox-omap2.c | 11 +++++++++--
 drivers/mailbox/omap-mailbox.c  | 26 ++++----------------------
 drivers/mailbox/omap-mbox.h     |  7 +------
 4 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/mailbox/mailbox-omap1.c b/drivers/mailbox/mailbox-omap1.c
index 5e38ffc..0f874e0 100644
--- a/drivers/mailbox/mailbox-omap1.c
+++ b/drivers/mailbox/mailbox-omap1.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include "omap-mbox.h"
 
@@ -37,6 +38,7 @@ struct omap_mbox1_fifo {
 struct omap_mbox1_priv {
 	struct omap_mbox1_fifo tx_fifo;
 	struct omap_mbox1_fifo rx_fifo;
+	bool empty_flag;
 };
 
 static inline int mbox_read_reg(size_t ofs)
@@ -59,6 +61,7 @@ static mbox_msg_t omap1_mbox_fifo_read(struct omap_mbox *mbox)
 	msg = mbox_read_reg(fifo->data);
 	msg |= ((mbox_msg_t) mbox_read_reg(fifo->cmd)) << 16;
 
+	(struct omap_mbox1_priv *)(mbox->priv)->empty_flag = false;
 	return msg;
 }
 
@@ -74,7 +77,9 @@ omap1_mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
 
 static int omap1_mbox_fifo_empty(struct omap_mbox *mbox)
 {
-	return 0;
+	struct omap_mbox1_priv *priv = (struct omap_mbox1_priv *)mbox->priv;
+
+	return priv->empty_flag ? 0 : 1;
 }
 
 static int omap1_mbox_fifo_full(struct omap_mbox *mbox)
@@ -85,6 +90,18 @@ static int omap1_mbox_fifo_full(struct omap_mbox *mbox)
 	return mbox_read_reg(fifo->flag);
 }
 
+static int omap1_mbox_poll_for_space(struct omap_mbox *mbox)
+{
+	int i = 1000;
+
+	while (omap1_mbox_fifo_full(mbox)) {
+		if (--i == 0)
+			return -1;
+		udelay(1);
+	}
+	return 0;
+}
+
 /* irq */
 static void
 omap1_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
@@ -103,17 +120,21 @@ omap1_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 static int
 omap1_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
+	struct omap_mbox1_priv *priv = (struct omap_mbox1_priv *)mbox->priv;
+
 	if (irq == IRQ_TX)
 		return 0;
+	if (irq == IRQ_RX)
+		priv->empty_flag = true;
+
 	return 1;
 }
 
 static struct omap_mbox_ops omap1_mbox_ops = {
-	.type		= OMAP_MBOX_TYPE1,
 	.fifo_read	= omap1_mbox_fifo_read,
 	.fifo_write	= omap1_mbox_fifo_write,
 	.fifo_empty	= omap1_mbox_fifo_empty,
-	.fifo_full	= omap1_mbox_fifo_full,
+	.poll_for_space	= omap1_mbox_poll_for_space,
 	.enable_irq	= omap1_mbox_enable_irq,
 	.disable_irq	= omap1_mbox_disable_irq,
 	.is_irq		= omap1_mbox_is_irq,
diff --git a/drivers/mailbox/mailbox-omap2.c b/drivers/mailbox/mailbox-omap2.c
index 759f72c..fef18f4 100644
--- a/drivers/mailbox/mailbox-omap2.c
+++ b/drivers/mailbox/mailbox-omap2.c
@@ -124,6 +124,14 @@ static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
 	return mbox_read_reg(mbox->parent, fifo->fifo_stat);
 }
 
+static int omap2_mbox_poll_for_space(struct omap_mbox *mbox)
+{
+	if (omap2_mbox_fifo_full(mbox))
+		return -1;
+
+	return 0;
+}
+
 /* Mailbox IRQ handle functions */
 static void omap2_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
@@ -208,13 +216,12 @@ static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
 }
 
 static struct omap_mbox_ops omap2_mbox_ops = {
-	.type		= OMAP_MBOX_TYPE2,
 	.startup	= omap2_mbox_startup,
 	.shutdown	= omap2_mbox_shutdown,
 	.fifo_read	= omap2_mbox_fifo_read,
 	.fifo_write	= omap2_mbox_fifo_write,
 	.fifo_empty	= omap2_mbox_fifo_empty,
-	.fifo_full	= omap2_mbox_fifo_full,
+	.poll_for_space	= omap2_mbox_poll_for_space,
 	.enable_irq	= omap2_mbox_enable_irq,
 	.disable_irq	= omap2_mbox_disable_irq,
 	.ack_irq	= omap2_mbox_ack_irq,
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 25a2da7..8329c8a 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -24,7 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/kfifo.h>
 #include <linux/err.h>
@@ -52,9 +51,9 @@ static inline int mbox_fifo_empty(struct omap_mbox *mbox)
 {
 	return mbox->ops->fifo_empty(mbox);
 }
-static inline int mbox_fifo_full(struct omap_mbox *mbox)
+static inline int mbox_poll_for_space(struct omap_mbox *mbox)
 {
-	return mbox->ops->fifo_full(mbox);
+	return mbox->ops->poll_for_space(mbox);
 }
 
 /* Mailbox IRQ handle functions */
@@ -71,20 +70,6 @@ static inline int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 /*
  * message sender
  */
-static int __mbox_poll_for_space(struct omap_mbox *mbox)
-{
-	int ret = 0, i = 1000;
-
-	while (mbox_fifo_full(mbox)) {
-		if (mbox->ops->type == OMAP_MBOX_TYPE2)
-			return -1;
-		if (--i == 0)
-			return -1;
-		udelay(1);
-	}
-	return ret;
-}
-
 int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 {
 	struct omap_mbox_queue *mq = mbox->txq;
@@ -97,7 +82,7 @@ int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 		goto out;
 	}
 
-	if (kfifo_is_empty(&mq->fifo) && !__mbox_poll_for_space(mbox)) {
+	if (kfifo_is_empty(&mq->fifo) && !mbox_poll_for_space(mbox)) {
 		mbox_fifo_write(mbox, msg);
 		goto out;
 	}
@@ -155,7 +140,7 @@ static void mbox_tx_tasklet(unsigned long tx_data)
 	int ret;
 
 	while (kfifo_len(&mq->fifo)) {
-		if (__mbox_poll_for_space(mbox)) {
+		if (mbox_poll_for_space(mbox)) {
 			omap_mbox_enable_irq(mbox, IRQ_TX);
 			break;
 		}
@@ -220,9 +205,6 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 
 		len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
 		WARN_ON(len != sizeof(msg));
-
-		if (mbox->ops->type == OMAP_MBOX_TYPE1)
-			break;
 	}
 
 	/* no more messages in the fifo. clear IRQ source. */
diff --git a/drivers/mailbox/omap-mbox.h b/drivers/mailbox/omap-mbox.h
index 6df528a..2d3cdb4 100644
--- a/drivers/mailbox/omap-mbox.h
+++ b/drivers/mailbox/omap-mbox.h
@@ -16,19 +16,14 @@
 #include <linux/workqueue.h>
 #include <linux/omap-mailbox.h>
 
-typedef int __bitwise omap_mbox_type_t;
-#define OMAP_MBOX_TYPE1 ((__force omap_mbox_type_t) 1)
-#define OMAP_MBOX_TYPE2 ((__force omap_mbox_type_t) 2)
-
 struct omap_mbox_ops {
-	omap_mbox_type_t	type;
 	int		(*startup)(struct omap_mbox *mbox);
 	void		(*shutdown)(struct omap_mbox *mbox);
 	/* fifo */
 	mbox_msg_t	(*fifo_read)(struct omap_mbox *mbox);
 	void		(*fifo_write)(struct omap_mbox *mbox, mbox_msg_t msg);
 	int		(*fifo_empty)(struct omap_mbox *mbox);
-	int		(*fifo_full)(struct omap_mbox *mbox);
+	int		(*poll_for_space)(struct omap_mbox *mbox);
 	/* irq */
 	void		(*enable_irq)(struct omap_mbox *mbox,
 						omap_mbox_irq_t irq);
-- 
1.8.3.3

