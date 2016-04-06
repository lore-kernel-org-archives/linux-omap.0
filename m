From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/4] mailbox/omap: kill omap_mbox_{save/restore}_ctx() functions
Date: Wed, 6 Apr 2016 18:37:20 -0500
Message-ID: <1459985840-1106-5-git-send-email-s-anna@ti.com>
References: <1459985840-1106-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459985840-1106-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

The omap_mbox_save_ctx() and omap_mbox_restore_ctx() API were
previously provided to OMAP mailbox clients to save and restore
the mailbox context during system suspend/resume. The save and
restore functionality is now implemented through System PM driver
callbacks, and there is no need for these functions, so kill these
API.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 51 ------------------------------------------
 include/linux/omap-mailbox.h   |  2 --
 2 files changed, 53 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index b61c6e8654b5..1e0963ed6a25 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -55,13 +55,6 @@
 #define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
 #define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
 
-#define MBOX_REG_SIZE			0x120
-
-#define OMAP4_MBOX_REG_SIZE		0x130
-
-#define MBOX_NR_REGS			(MBOX_REG_SIZE / sizeof(u32))
-#define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / sizeof(u32))
-
 /* Interrupt register configuration types */
 #define MBOX_INTR_CFG_TYPE1		(0)
 #define MBOX_INTR_CFG_TYPE2		(1)
@@ -118,7 +111,6 @@ struct omap_mbox {
 	struct omap_mbox_device *parent;
 	struct omap_mbox_fifo	tx_fifo;
 	struct omap_mbox_fifo	rx_fifo;
-	u32			ctx[OMAP4_MBOX_NR_REGS];
 	u32			intr_type;
 	struct mbox_chan	*chan;
 	bool			send_no_irq;
@@ -209,49 +201,6 @@ static int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 	return (int)(enable & status & bit);
 }
 
-void omap_mbox_save_ctx(struct mbox_chan *chan)
-{
-	int i;
-	int nr_regs;
-	struct omap_mbox *mbox = mbox_chan_to_omap_mbox(chan);
-
-	if (WARN_ON(!mbox))
-		return;
-
-	if (mbox->intr_type)
-		nr_regs = OMAP4_MBOX_NR_REGS;
-	else
-		nr_regs = MBOX_NR_REGS;
-	for (i = 0; i < nr_regs; i++) {
-		mbox->ctx[i] = mbox_read_reg(mbox->parent, i * sizeof(u32));
-
-		dev_dbg(mbox->dev, "%s: [%02x] %08x\n", __func__,
-			i, mbox->ctx[i]);
-	}
-}
-EXPORT_SYMBOL(omap_mbox_save_ctx);
-
-void omap_mbox_restore_ctx(struct mbox_chan *chan)
-{
-	int i;
-	int nr_regs;
-	struct omap_mbox *mbox = mbox_chan_to_omap_mbox(chan);
-
-	if (WARN_ON(!mbox))
-		return;
-
-	if (mbox->intr_type)
-		nr_regs = OMAP4_MBOX_NR_REGS;
-	else
-		nr_regs = MBOX_NR_REGS;
-	for (i = 0; i < nr_regs; i++) {
-		mbox_write_reg(mbox->parent, mbox->ctx[i], i * sizeof(u32));
-		dev_dbg(mbox->dev, "%s: [%02x] %08x\n", __func__,
-			i, mbox->ctx[i]);
-	}
-}
-EXPORT_SYMBOL(omap_mbox_restore_ctx);
-
 static void _omap_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	u32 l;
diff --git a/include/linux/omap-mailbox.h b/include/linux/omap-mailbox.h
index 587bbdd31f5a..c726bd833761 100644
--- a/include/linux/omap-mailbox.h
+++ b/include/linux/omap-mailbox.h
@@ -21,8 +21,6 @@ struct mbox_client;
 struct mbox_chan *omap_mbox_request_channel(struct mbox_client *cl,
 					    const char *chan_name);
 
-void omap_mbox_save_ctx(struct mbox_chan *chan);
-void omap_mbox_restore_ctx(struct mbox_chan *chan);
 void omap_mbox_enable_irq(struct mbox_chan *chan, omap_mbox_irq_t irq);
 void omap_mbox_disable_irq(struct mbox_chan *chan, omap_mbox_irq_t irq);
 
-- 
2.7.4
