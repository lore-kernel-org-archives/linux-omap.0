From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 07/10] omap mailbox: add save_/restore_ctx() for PM
Date: Tue, 25 Nov 2008 11:39:55 +0200
Message-ID: <1227605998-13531-8-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1227605998-13531-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-4-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-5-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-6-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-7-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34857 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbYKYJkS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 04:40:18 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAP9e171029701
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:40:15 +0200
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAP9dxQT016088
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:39:59 +0200
In-Reply-To: <1227605998-13531-7-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

To preserve the registers during off-mode

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/mailbox.c             |   35 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mailbox.h |    6 +++++
 arch/arm/plat-omap/mailbox.c              |   18 +++++++++++++++
 3 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 12715d8..c29015f 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -32,6 +32,8 @@
 #define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
 #define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
 
+#define MBOX_REG_SIZE			0x120
+
 static void __iomem *mbox_base;
 
 struct omap_mbox2_fifo {
@@ -47,6 +49,7 @@ struct omap_mbox2_priv {
 	unsigned long irqstatus;
 	u32 newmsg_bit;
 	u32 notfull_bit;
+	char ctx[MBOX_REG_SIZE];
 };
 
 static struct clk *mbox_ick_handle;
@@ -167,6 +170,36 @@ static int omap2_mbox_is_irq(struct omap_mbox *mbox,
 	return (enable & status & bit);
 }
 
+static void omap2_mbox_save_ctx(struct omap_mbox *mbox)
+{
+	int i;
+	struct omap_mbox2_priv *p = mbox->priv;
+
+	for (i = 0; i < MBOX_REG_SIZE; i += sizeof(u32)) {
+		u32 val;
+
+		val = mbox_read_reg(i);
+		*(u32 *)(p->ctx + i) = val;
+
+		dev_dbg(mbox->dev, "%s\t[%02d] %08x\n", __func__, i, val);
+	}
+}
+
+static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
+{
+	int i;
+	struct omap_mbox2_priv *p = mbox->priv;
+
+	for (i = 0; i < MBOX_REG_SIZE; i += sizeof(u32)) {
+		u32 val;
+
+		val = *(u32 *)(p->ctx + i);
+		mbox_write_reg(val, i);
+
+		dev_dbg(mbox->dev, "%s\t[%02d] %08x\n", __func__, i, val);
+	}
+}
+
 static struct omap_mbox_ops omap2_mbox_ops = {
 	.type		= OMAP_MBOX_TYPE2,
 	.startup	= omap2_mbox_startup,
@@ -179,6 +212,8 @@ static struct omap_mbox_ops omap2_mbox_ops = {
 	.disable_irq	= omap2_mbox_disable_irq,
 	.ack_irq	= omap2_mbox_ack_irq,
 	.is_irq		= omap2_mbox_is_irq,
+	.save_ctx	= omap2_mbox_save_ctx,
+	.restore_ctx	= omap2_mbox_restore_ctx,
 };
 
 /*
diff --git a/arch/arm/plat-omap/include/mach/mailbox.h b/arch/arm/plat-omap/include/mach/mailbox.h
index b81df6a..bca34d7 100644
--- a/arch/arm/plat-omap/include/mach/mailbox.h
+++ b/arch/arm/plat-omap/include/mach/mailbox.h
@@ -33,6 +33,9 @@ struct omap_mbox_ops {
 	void		(*disable_irq)(struct omap_mbox *mbox, omap_mbox_irq_t irq);
 	void		(*ack_irq)(struct omap_mbox *mbox, omap_mbox_irq_t irq);
 	int		(*is_irq)(struct omap_mbox *mbox, omap_mbox_irq_t irq);
+	/* ctx */
+	void		(*save_ctx)(struct omap_mbox *mbox);
+	void		(*restore_ctx)(struct omap_mbox *mbox);
 };
 
 struct omap_mbox_queue {
@@ -72,4 +75,7 @@ void omap_mbox_put(struct omap_mbox *);
 int omap_mbox_register(struct device *parent, struct omap_mbox *);
 int omap_mbox_unregister(struct omap_mbox *);
 
+void omap_mbox_save_ctx(struct omap_mbox *);
+void omap_mbox_restore_ctx(struct omap_mbox *);
+
 #endif /* MAILBOX_H */
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 5e8cd65..7b55f2f 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -36,6 +36,24 @@
 static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
 
+void omap_mbox_save_ctx(struct omap_mbox *mbox)
+{
+	if (!mbox->ops->save_ctx)
+		dev_err(mbox->dev, "%s:\tno save\n", __func__);
+
+	mbox->ops->save_ctx(mbox);
+}
+EXPORT_SYMBOL_GPL(omap_mbox_save_ctx);
+
+void omap_mbox_restore_ctx(struct omap_mbox *mbox)
+{
+	if (!mbox->ops->restore_ctx)
+		dev_err(mbox->dev, "%s:\tno restore\n", __func__);
+
+	mbox->ops->restore_ctx(mbox);
+}
+EXPORT_SYMBOL_GPL(omap_mbox_restore_ctx);
+
 /* Mailbox Sequence Bit function */
 void omap_mbox_init_seq(struct omap_mbox *mbox)
 {
-- 
1.6.0.3.613.g9f8f13

