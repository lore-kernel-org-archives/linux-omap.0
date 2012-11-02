From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 01/15] ARM: OMAP2+: mailbox: Add an API for flushing the FIFO
Date: Fri, 2 Nov 2012 18:02:32 +0530
Message-ID: <1351859566-24818-2-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39656 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755498Ab2KBMeV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 08:34:21 -0400
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

On AM33XX, the mailbox module between the MPU and the
WKUP-M3 co-processor facilitates a one-way communication.
MPU uses the assigned mailbox sub-module to issue the
interrupt to the WKUP-M3 co-processor which then goes
and reads the the IPC data from registers in the control
module.

WKUP-M3 is in the L4_WKUP and does not have any access to
the Mailbox module. Due to this limitation, the MPU is
completely responsible for FIFO maintenance and interrupt
generation. MPU needs to ensure that the FIFO does not
overflow by reading by the assigned mailbox sub-module.

This patch adds an API in the mailbox code which the MPU
can use to empty the FIFO by issuing a readback command.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/mailbox.c             |   42 ++++++++++++++++++++---------
 arch/arm/plat-omap/include/plat/mailbox.h |    3 ++
 arch/arm/plat-omap/mailbox.c              |   35 ++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 0d97456..f38b4fa 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -123,6 +123,20 @@ static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
 	return mbox_read_reg(fifo->fifo_stat);
 }
 
+static int omap2_mbox_fifo_needs_flush(struct omap_mbox *mbox)
+{
+	struct omap_mbox2_fifo *fifo =
+		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
+	return mbox_read_reg(fifo->msg_stat);
+}
+
+static mbox_msg_t omap2_mbox_fifo_readback(struct omap_mbox *mbox)
+{
+	struct omap_mbox2_fifo *fifo =
+		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
+	return (mbox_msg_t) mbox_read_reg(fifo->msg);
+}
+
 /* Mailbox IRQ handle functions */
 static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 		omap_mbox_type_t irq)
@@ -205,19 +219,21 @@ static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
 }
 
 static struct omap_mbox_ops omap2_mbox_ops = {
-	.type		= OMAP_MBOX_TYPE2,
-	.startup	= omap2_mbox_startup,
-	.shutdown	= omap2_mbox_shutdown,
-	.fifo_read	= omap2_mbox_fifo_read,
-	.fifo_write	= omap2_mbox_fifo_write,
-	.fifo_empty	= omap2_mbox_fifo_empty,
-	.fifo_full	= omap2_mbox_fifo_full,
-	.enable_irq	= omap2_mbox_enable_irq,
-	.disable_irq	= omap2_mbox_disable_irq,
-	.ack_irq	= omap2_mbox_ack_irq,
-	.is_irq		= omap2_mbox_is_irq,
-	.save_ctx	= omap2_mbox_save_ctx,
-	.restore_ctx	= omap2_mbox_restore_ctx,
+	.type			= OMAP_MBOX_TYPE2,
+	.startup		= omap2_mbox_startup,
+	.shutdown		= omap2_mbox_shutdown,
+	.fifo_read		= omap2_mbox_fifo_read,
+	.fifo_write		= omap2_mbox_fifo_write,
+	.fifo_empty		= omap2_mbox_fifo_empty,
+	.fifo_full		= omap2_mbox_fifo_full,
+	.fifo_needs_flush	= omap2_mbox_fifo_needs_flush,
+	.fifo_readback		= omap2_mbox_fifo_readback,
+	.enable_irq		= omap2_mbox_enable_irq,
+	.disable_irq		= omap2_mbox_disable_irq,
+	.ack_irq		= omap2_mbox_ack_irq,
+	.is_irq			= omap2_mbox_is_irq,
+	.save_ctx		= omap2_mbox_save_ctx,
+	.restore_ctx		= omap2_mbox_restore_ctx,
 };
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index cc3921e..e136529 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -29,6 +29,8 @@ struct omap_mbox_ops {
 	void		(*fifo_write)(struct omap_mbox *mbox, mbox_msg_t msg);
 	int		(*fifo_empty)(struct omap_mbox *mbox);
 	int		(*fifo_full)(struct omap_mbox *mbox);
+	int		(*fifo_needs_flush)(struct omap_mbox *mbox);
+	mbox_msg_t	(*fifo_readback)(struct omap_mbox *mbox);
 	/* irq */
 	void		(*enable_irq)(struct omap_mbox *mbox,
 						omap_mbox_irq_t irq);
@@ -61,6 +63,7 @@ struct omap_mbox {
 	struct blocking_notifier_head   notifier;
 };
 
+int omap_mbox_msg_rx_flush(struct omap_mbox *mbox);
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 42377ef..cb9754a 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -59,6 +59,14 @@ static inline int mbox_fifo_full(struct omap_mbox *mbox)
 {
 	return mbox->ops->fifo_full(mbox);
 }
+static inline int mbox_fifo_needs_flush(struct omap_mbox *mbox)
+{
+	return mbox->ops->fifo_needs_flush(mbox);
+}
+static inline mbox_msg_t mbox_fifo_readback(struct omap_mbox *mbox)
+{
+	return mbox->ops->fifo_readback(mbox);
+}
 
 /* Mailbox IRQ handle functions */
 static inline void ack_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
@@ -116,6 +124,33 @@ out:
 }
 EXPORT_SYMBOL(omap_mbox_msg_send);
 
+/*
+ * Flush the Rx FIFO by reading back the messages
+ * Since the normal expectation is that the Rx will do the
+ * reading, add a debug message to indicate if we really flush
+ *
+ * Returns the no. of messages read back
+ */
+int omap_mbox_msg_rx_flush(struct omap_mbox *mbox)
+{
+	int ret = 0;
+	mbox_msg_t msg;
+
+	while (mbox_fifo_needs_flush(mbox)) {
+		msg = mbox_fifo_readback(mbox);
+		ret++;
+	}
+
+	if (ret) {
+		/* no more messages in the fifo. clear IRQ source. */
+		ack_mbox_irq(mbox, IRQ_RX);
+		pr_debug("Flushed %s Rx FIFO by reading back\n", mbox->name);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(omap_mbox_msg_rx_flush);
+
 static void mbox_tx_tasklet(unsigned long tx_data)
 {
 	struct omap_mbox *mbox = (struct omap_mbox *)tx_data;
-- 
1.7.0.4

