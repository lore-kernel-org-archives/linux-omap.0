From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 26/31] dmaengine: PL08x: convert to use vchan submitted/issued
 lists
Date: Thu, 07 Jun 2012 11:54:30 +0100
Message-ID: <E1ScaMI-0003m8-KA@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54263 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2FGKyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:54:35 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Convert to use the virtual dma channel submitted/issued descriptor
lists rather than our own private lists, and use the virtual dma
channel support functions to manage these lists.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   64 ++++++++++++---------------------------------
 1 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 398a5da..5333a91 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -215,8 +215,6 @@ enum pl08x_dma_chan_state {
  * @name: name of channel
  * @cd: channel platform data
  * @runtime_addr: address for RX/TX according to the runtime config
- * @pend_list: queued transactions pending on this channel
- * @issued_list: issued transactions for this channel
  * @done_list: list of completed transactions
  * @at: active transaction on this channel
  * @lock: a lock for this channel data
@@ -233,8 +231,6 @@ struct pl08x_dma_chan {
 	const char *name;
 	const struct pl08x_channel_data *cd;
 	struct dma_slave_config cfg;
-	struct list_head pend_list;
-	struct list_head issued_list;
 	struct list_head done_list;
 	struct pl08x_txd *at;
 	struct pl08x_driver_data *host;
@@ -357,12 +353,12 @@ static void pl08x_start_next_txd(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_phy_chan *phychan = plchan->phychan;
+	struct virt_dma_desc *vd = vchan_next_desc(&plchan->vc);
+	struct pl08x_txd *txd = to_pl08x_txd(&vd->tx);
 	struct pl08x_lli *lli;
-	struct pl08x_txd *txd;
 	u32 val;
 
-	txd = list_first_entry(&plchan->issued_list, struct pl08x_txd, node);
-	list_del(&txd->node);
+	list_del(&txd->vd.node);
 
 	plchan->at = txd;
 
@@ -524,18 +520,18 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	}
 
 	/* Sum up all queued transactions */
-	if (!list_empty(&plchan->issued_list)) {
+	if (!list_empty(&plchan->vc.desc_issued)) {
 		struct pl08x_txd *txdi;
-		list_for_each_entry(txdi, &plchan->issued_list, node) {
+		list_for_each_entry(txdi, &plchan->vc.desc_issued, vd.node) {
 			struct pl08x_sg *dsg;
 			list_for_each_entry(dsg, &txd->dsg_list, node)
 				bytes += dsg->len;
 		}
 	}
 
-	if (!list_empty(&plchan->pend_list)) {
+	if (!list_empty(&plchan->vc.desc_submitted)) {
 		struct pl08x_txd *txdi;
-		list_for_each_entry(txdi, &plchan->pend_list, node) {
+		list_for_each_entry(txdi, &plchan->vc.desc_submitted, vd.node) {
 			struct pl08x_sg *dsg;
 			list_for_each_entry(dsg, &txd->dsg_list, node)
 				bytes += dsg->len;
@@ -1094,13 +1090,12 @@ static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
 	LIST_HEAD(head);
 	struct pl08x_txd *txd;
 
-	list_splice_tail_init(&plchan->issued_list, &head);
-	list_splice_tail_init(&plchan->pend_list, &head);
+	vchan_get_all_descriptors(&plchan->vc, &head);
 
 	while (!list_empty(&head)) {
-		txd = list_first_entry(&head, struct pl08x_txd, node);
+		txd = list_first_entry(&head, struct pl08x_txd, vd.node);
 		pl08x_release_mux(plchan);
-		list_del(&txd->node);
+		list_del(&txd->vd.node);
 		pl08x_free_txd(pl08x, txd);
 	}
 }
@@ -1117,23 +1112,6 @@ static void pl08x_free_chan_resources(struct dma_chan *chan)
 {
 }
 
-static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
-{
-	struct pl08x_dma_chan *plchan = to_pl08x_chan(tx->chan);
-	struct pl08x_txd *txd = to_pl08x_txd(tx);
-	unsigned long flags;
-	dma_cookie_t cookie;
-
-	spin_lock_irqsave(&plchan->vc.lock, flags);
-	cookie = dma_cookie_assign(tx);
-
-	/* Put this onto the pending list */
-	list_add_tail(&txd->node, &plchan->pend_list);
-	spin_unlock_irqrestore(&plchan->vc.lock, flags);
-
-	return cookie;
-}
-
 static struct dma_async_tx_descriptor *pl08x_prep_dma_interrupt(
 		struct dma_chan *chan, unsigned long flags)
 {
@@ -1318,8 +1296,7 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 	unsigned long flags;
 
 	spin_lock_irqsave(&plchan->vc.lock, flags);
-	list_splice_tail_init(&plchan->pend_list, &plchan->issued_list);
-	if (!list_empty(&plchan->issued_list)) {
+	if (vchan_issue_pending(&plchan->vc)) {
 		if (!plchan->phychan && plchan->state != PL08X_CHAN_WAITING)
 			pl08x_phy_alloc_and_start(plchan);
 	}
@@ -1345,16 +1322,11 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 	return 0;
 }
 
-static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan,
-	unsigned long flags)
+static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_txd *txd = kzalloc(sizeof(*txd), GFP_NOWAIT);
 
 	if (txd) {
-		dma_async_tx_descriptor_init(&txd->vd.tx, &plchan->vc.chan);
-		txd->vd.tx.flags = flags;
-		txd->vd.tx.tx_submit = pl08x_tx_submit;
-		INIT_LIST_HEAD(&txd->node);
 		INIT_LIST_HEAD(&txd->dsg_list);
 
 		/* Always enable error and terminal interrupts */
@@ -1377,7 +1349,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	struct pl08x_sg *dsg;
 	int ret;
 
-	txd = pl08x_get_txd(plchan, flags);
+	txd = pl08x_get_txd(plchan);
 	if (!txd) {
 		dev_err(&pl08x->adev->dev,
 			"%s no memory for descriptor\n", __func__);
@@ -1413,7 +1385,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	if (ret)
 		return NULL;
 
-	return &txd->vd.tx;
+	return vchan_tx_prep(&plchan->vc, &txd->vd, flags);
 }
 
 static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
@@ -1435,7 +1407,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	dev_dbg(&pl08x->adev->dev, "%s prepare transaction of %d bytes from %s\n",
 			__func__, sg_dma_len(sgl), plchan->name);
 
-	txd = pl08x_get_txd(plchan, flags);
+	txd = pl08x_get_txd(plchan);
 	if (!txd) {
 		dev_err(&pl08x->adev->dev, "%s no txd\n", __func__);
 		return NULL;
@@ -1529,7 +1501,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	if (ret)
 		return NULL;
 
-	return &txd->vd.tx;
+	return vchan_tx_prep(&plchan->vc, &txd->vd, flags);
 }
 
 static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
@@ -1739,7 +1711,7 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 				 * And start the next descriptor (if any),
 				 * otherwise free this channel.
 				 */
-				if (!list_empty(&plchan->issued_list))
+				if (vchan_next_desc(&plchan->vc))
 					pl08x_start_next_txd(plchan);
 				else
 					pl08x_phy_free(plchan);
@@ -1807,8 +1779,6 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			 "initialize virtual channel \"%s\"\n",
 			 chan->name);
 
-		INIT_LIST_HEAD(&chan->pend_list);
-		INIT_LIST_HEAD(&chan->issued_list);
 		INIT_LIST_HEAD(&chan->done_list);
 		tasklet_init(&chan->tasklet, pl08x_tasklet,
 			     (unsigned long) chan);
-- 
1.7.4.4

