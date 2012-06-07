From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 21/31] dmaengine: PL08x: split the pend_list in two
Date: Thu, 07 Jun 2012 11:52:49 +0100
Message-ID: <E1ScaKf-0003le-L7@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54237 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760603Ab2FGKwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:52:55 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Our behaviour wasn't correct; issue_pending is supposed to be called
before any submitted descriptors are available for processing by the
DMA engine.  Split the pend_list in two, one for submitted descriptors
and another list for issued descriptors.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   41 ++++++++++++++++++++++++++++-------------
 1 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c278d23..b613284 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -217,6 +217,7 @@ enum pl08x_dma_chan_state {
  * @cd: channel platform data
  * @runtime_addr: address for RX/TX according to the runtime config
  * @pend_list: queued transactions pending on this channel
+ * @issued_list: issued transactions for this channel
  * @done_list: list of completed transactions
  * @at: active transaction on this channel
  * @lock: a lock for this channel data
@@ -235,6 +236,7 @@ struct pl08x_dma_chan {
 	const struct pl08x_channel_data *cd;
 	struct dma_slave_config cfg;
 	struct list_head pend_list;
+	struct list_head issued_list;
 	struct list_head done_list;
 	struct pl08x_txd *at;
 	spinlock_t lock;
@@ -362,7 +364,7 @@ static void pl08x_start_next_txd(struct pl08x_dma_chan *plchan)
 	struct pl08x_txd *txd;
 	u32 val;
 
-	txd = list_first_entry(&plchan->pend_list, struct pl08x_txd, node);
+	txd = list_first_entry(&plchan->issued_list, struct pl08x_txd, node);
 	list_del(&txd->node);
 
 	plchan->at = txd;
@@ -525,6 +527,15 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	}
 
 	/* Sum up all queued transactions */
+	if (!list_empty(&plchan->issued_list)) {
+		struct pl08x_txd *txdi;
+		list_for_each_entry(txdi, &plchan->issued_list, node) {
+			struct pl08x_sg *dsg;
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				bytes += dsg->len;
+		}
+	}
+
 	if (!list_empty(&plchan->pend_list)) {
 		struct pl08x_txd *txdi;
 		list_for_each_entry(txdi, &plchan->pend_list, node) {
@@ -991,16 +1002,17 @@ static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
 				struct pl08x_dma_chan *plchan)
 {
-	struct pl08x_txd *txdi = NULL;
-	struct pl08x_txd *next;
+	LIST_HEAD(head);
+	struct pl08x_txd *txd;
 
-	if (!list_empty(&plchan->pend_list)) {
-		list_for_each_entry_safe(txdi,
-					 next, &plchan->pend_list, node) {
-			pl08x_release_mux(plchan);
-			list_del(&txdi->node);
-			pl08x_free_txd(pl08x, txdi);
-		}
+	list_splice_tail_init(&plchan->issued_list, &head);
+	list_splice_tail_init(&plchan->pend_list, &head);
+
+	while (!list_empty(&head)) {
+		txd = list_first_entry(&head, struct pl08x_txd, node);
+		pl08x_release_mux(plchan);
+		list_del(&txd->node);
+		pl08x_free_txd(pl08x, txd);
 	}
 }
 
@@ -1269,6 +1281,8 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 	unsigned long flags;
 
 	spin_lock_irqsave(&plchan->lock, flags);
+	list_splice_tail_init(&plchan->pend_list, &plchan->issued_list);
+
 	/* Something is already active, or we're waiting for a channel... */
 	if (plchan->at || plchan->state == PL08X_CHAN_WAITING) {
 		spin_unlock_irqrestore(&plchan->lock, flags);
@@ -1276,7 +1290,7 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 	}
 
 	/* Take the first element in the queue and execute it */
-	if (!list_empty(&plchan->pend_list)) {
+	if (!list_empty(&plchan->issued_list)) {
 		plchan->state = PL08X_CHAN_RUNNING;
 		pl08x_start_next_txd(plchan);
 	}
@@ -1658,9 +1672,9 @@ static void pl08x_tasklet(unsigned long data)
 	list_splice_tail_init(&plchan->done_list, &head);
 
 	/* If a new descriptor is queued, set it up plchan->at is NULL here */
-	if (!list_empty(&plchan->pend_list)) {
+	if (!list_empty(&plchan->issued_list)) {
 		pl08x_start_next_txd(plchan);
-	} else if (plchan->phychan_hold) {
+	} else if (!list_empty(&plchan->pend_list) || plchan->phychan_hold) {
 		/*
 		 * This channel is still in use - we have a new txd being
 		 * prepared and will soon be queued.  Don't give up the
@@ -1841,6 +1855,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 
 		spin_lock_init(&chan->lock);
 		INIT_LIST_HEAD(&chan->pend_list);
+		INIT_LIST_HEAD(&chan->issued_list);
 		INIT_LIST_HEAD(&chan->done_list);
 		tasklet_init(&chan->tasklet, pl08x_tasklet,
 			     (unsigned long) chan);
-- 
1.7.4.4

