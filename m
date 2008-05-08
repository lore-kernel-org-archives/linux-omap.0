From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/11] ARM: OMAP: Fix Unbalanced enable for IRQ in omap mailbox
Date: Thu,  8 May 2008 15:49:29 -0700
Message-ID: <1210286975-29506-6-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
 <1210286975-29506-1-git-send-email-tony@atomide.com>
 <1210286975-29506-2-git-send-email-tony@atomide.com>
 <1210286975-29506-3-git-send-email-tony@atomide.com>
 <1210286975-29506-4-git-send-email-tony@atomide.com>
 <1210286975-29506-5-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:52003 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761633AbYEHWtq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 18:49:46 -0400
In-Reply-To: <1210286975-29506-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Tony Lindgren <tony@atomide.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mailbox.c |   25 +++++++++++++++----------
 arch/arm/plat-omap/mailbox.c  |    1 -
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index b03cd06..4799561 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -70,6 +70,9 @@ struct omap_mbox2_priv {
 
 static struct clk *mbox_ick_handle;
 
+static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
+				  omap_mbox_type_t irq);
+
 static inline unsigned int mbox_read_reg(unsigned int reg)
 {
 	return __raw_readl(mbox_base + reg);
@@ -81,7 +84,7 @@ static inline void mbox_write_reg(unsigned int val, unsigned int reg)
 }
 
 /* Mailbox H/W preparations */
-static inline int omap2_mbox_startup(struct omap_mbox *mbox)
+static int omap2_mbox_startup(struct omap_mbox *mbox)
 {
 	unsigned int l;
 
@@ -97,38 +100,40 @@ static inline int omap2_mbox_startup(struct omap_mbox *mbox)
 	l |= 0x00000011;
 	mbox_write_reg(l, MAILBOX_SYSCONFIG);
 
+	omap2_mbox_enable_irq(mbox, IRQ_RX);
+
 	return 0;
 }
 
-static inline void omap2_mbox_shutdown(struct omap_mbox *mbox)
+static void omap2_mbox_shutdown(struct omap_mbox *mbox)
 {
 	clk_disable(mbox_ick_handle);
 	clk_put(mbox_ick_handle);
 }
 
 /* Mailbox FIFO handle functions */
-static inline mbox_msg_t omap2_mbox_fifo_read(struct omap_mbox *mbox)
+static mbox_msg_t omap2_mbox_fifo_read(struct omap_mbox *mbox)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->rx_fifo;
 	return (mbox_msg_t) mbox_read_reg(fifo->msg);
 }
 
-static inline void omap2_mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
+static void omap2_mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
 	mbox_write_reg(msg, fifo->msg);
 }
 
-static inline int omap2_mbox_fifo_empty(struct omap_mbox *mbox)
+static int omap2_mbox_fifo_empty(struct omap_mbox *mbox)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->rx_fifo;
 	return (mbox_read_reg(fifo->msg_stat) == 0);
 }
 
-static inline int omap2_mbox_fifo_full(struct omap_mbox *mbox)
+static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
@@ -136,7 +141,7 @@ static inline int omap2_mbox_fifo_full(struct omap_mbox *mbox)
 }
 
 /* Mailbox IRQ handle functions */
-static inline void omap2_mbox_enable_irq(struct omap_mbox *mbox,
+static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 		omap_mbox_type_t irq)
 {
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
@@ -147,7 +152,7 @@ static inline void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 	mbox_write_reg(l, p->irqenable);
 }
 
-static inline void omap2_mbox_disable_irq(struct omap_mbox *mbox,
+static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 		omap_mbox_type_t irq)
 {
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
@@ -158,7 +163,7 @@ static inline void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 	mbox_write_reg(l, p->irqenable);
 }
 
-static inline void omap2_mbox_ack_irq(struct omap_mbox *mbox,
+static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
 		omap_mbox_type_t irq)
 {
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
@@ -167,7 +172,7 @@ static inline void omap2_mbox_ack_irq(struct omap_mbox *mbox,
 	mbox_write_reg(bit, p->irqstatus);
 }
 
-static inline int omap2_mbox_is_irq(struct omap_mbox *mbox,
+static int omap2_mbox_is_irq(struct omap_mbox *mbox,
 		omap_mbox_type_t irq)
 {
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 1945ddf..6f33f58 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -355,7 +355,6 @@ static int omap_mbox_init(struct omap_mbox *mbox)
 			"failed to register mailbox interrupt:%d\n", ret);
 		goto fail_request_irq;
 	}
-	enable_mbox_irq(mbox, IRQ_RX);
 
 	mq = mbox_queue_alloc(mbox, mbox_txq_fn, mbox_tx_work);
 	if (!mq) {
-- 
1.5.3.6

