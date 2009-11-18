From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/10] omap: mailbox: remove sequence bit checking
Date: Wed, 18 Nov 2009 11:20:29 -0800
Message-ID: <20091118192029.31148.36400.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49743 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624AbZKRTUY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 14:20:24 -0500
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Any protocol should be handled in the upper layer and mailbox driver
shouldn't care about the contents of messages.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mailbox.c |   70 ++----------------------------------------
 1 files changed, 4 insertions(+), 66 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 734bff3..f82810e 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -28,54 +28,9 @@
 
 #include <plat/mailbox.h>
 
-static int enable_seq_bit;
-module_param(enable_seq_bit, bool, 0);
-MODULE_PARM_DESC(enable_seq_bit, "Enable sequence bit checking.");
-
 static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
 
-/*
- * Mailbox sequence bit API
- */
-
-/* seq_rcv should be initialized with any value other than
- * 0 and 1 << 31, to allow either value for the first
- * message.  */
-static inline void mbox_seq_init(struct omap_mbox *mbox)
-{
-	if (!enable_seq_bit)
-		return;
-
-	/* any value other than 0 and 1 << 31 */
-	mbox->seq_rcv = 0xffffffff;
-}
-
-static inline void mbox_seq_toggle(struct omap_mbox *mbox, mbox_msg_t * msg)
-{
-	if (!enable_seq_bit)
-		return;
-
-	/* add seq_snd to msg */
-	*msg = (*msg & 0x7fffffff) | mbox->seq_snd;
-	/* flip seq_snd */
-	mbox->seq_snd ^= 1 << 31;
-}
-
-static inline int mbox_seq_test(struct omap_mbox *mbox, mbox_msg_t msg)
-{
-	mbox_msg_t seq;
-
-	if (!enable_seq_bit)
-		return 0;
-
-	seq = msg & (1 << 31);
-	if (seq == mbox->seq_rcv)
-		return -1;
-	mbox->seq_rcv = seq;
-	return 0;
-}
-
 /* Mailbox FIFO handle functions */
 static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
 {
@@ -113,13 +68,6 @@ static inline int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 	return mbox->ops->is_irq(mbox, irq);
 }
 
-/* Mailbox Sequence Bit function */
-void omap_mbox_init_seq(struct omap_mbox *mbox)
-{
-	mbox_seq_init(mbox);
-}
-EXPORT_SYMBOL(omap_mbox_init_seq);
-
 /*
  * message sender
  */
@@ -141,7 +89,6 @@ static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg, void *arg)
 			goto out;
 	}
 
-	mbox_seq_toggle(mbox, &msg);
 	mbox_fifo_write(mbox, msg);
  out:
 	return ret;
@@ -254,11 +201,11 @@ static void mbox_rx_work(struct work_struct *work)
 /*
  * Mailbox interrupt handler
  */
-static void mbox_txq_fn(struct request_queue * q)
+static void mbox_txq_fn(struct request_queue *q)
 {
 }
 
-static void mbox_rxq_fn(struct request_queue * q)
+static void mbox_rxq_fn(struct request_queue *q)
 {
 }
 
@@ -284,11 +231,6 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 
 		msg = mbox_fifo_read(mbox);
 
-		if (unlikely(mbox_seq_test(mbox, msg))) {
-			pr_info("mbox: Illegal seq bit!(%08x)\n", msg);
-			if (mbox->err_notify)
-				mbox->err_notify();
-		}
 
 		blk_insert_request(q, rq, 0, (void *)msg);
 		if (mbox->ops->type == OMAP_MBOX_TYPE1)
@@ -320,7 +262,7 @@ static irqreturn_t mbox_interrupt(int irq, void *p)
  */
 static ssize_t
 omap_mbox_write(struct device *dev, struct device_attribute *attr,
-		const char * buf, size_t count)
+		const char *buf, size_t count)
 {
 	int ret;
 	mbox_msg_t *p = (mbox_msg_t *)buf;
@@ -357,10 +299,6 @@ omap_mbox_read(struct device *dev, struct device_attribute *attr, char *buf)
 
 		blk_end_request_all(rq, 0);
 
-		if (unlikely(mbox_seq_test(mbox, *p))) {
-			pr_info("mbox: Illegal seq bit!(%08x) ignored\n", *p);
-			continue;
-		}
 		p++;
 	}
 
@@ -383,7 +321,7 @@ static struct class omap_mbox_class = {
 };
 
 static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
-					request_fn_proc * proc,
+					request_fn_proc *proc,
 					void (*work) (struct work_struct *))
 {
 	struct request_queue *q;

