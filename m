From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 27/31] dmaengine: PL08x: convert to use vchan done list
Date: Thu, 07 Jun 2012 11:54:50 +0100
Message-ID: <E1ScaMc-0003mC-OR@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54267 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664Ab2FGKy4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:54:56 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Convert to use the virtual dma channel done list, tasklet, and
descriptor freeing.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |  135 ++++++++++++++++++---------------------------
 1 files changed, 54 insertions(+), 81 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 5333a91..6a35e37 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -167,16 +167,16 @@ struct pl08x_sg {
 /**
  * struct pl08x_txd - wrapper for struct dma_async_tx_descriptor
  * @vd: virtual DMA descriptor
- * @node: node for txd list for channels
  * @dsg_list: list of children sg's
  * @llis_bus: DMA memory address (physical) start for the LLIs
  * @llis_va: virtual memory address start for the LLIs
  * @cctl: control reg values for current txd
  * @ccfg: config reg values for current txd
+ * @done: this marks completed descriptors, which should not have their
+ *   mux released.
  */
 struct pl08x_txd {
 	struct virt_dma_desc vd;
-	struct list_head node;
 	struct list_head dsg_list;
 	dma_addr_t llis_bus;
 	struct pl08x_lli *llis_va;
@@ -187,6 +187,7 @@ struct pl08x_txd {
 	 * trigger this txd.  Other registers are in llis_va[0].
 	 */
 	u32 ccfg;
+	bool done;
 };
 
 /**
@@ -211,11 +212,9 @@ enum pl08x_dma_chan_state {
  * struct pl08x_dma_chan - this structure wraps a DMA ENGINE channel
  * @vc: wrappped virtual channel
  * @phychan: the physical channel utilized by this channel, if there is one
- * @tasklet: tasklet scheduled by the IRQ to handle actual work etc
  * @name: name of channel
  * @cd: channel platform data
  * @runtime_addr: address for RX/TX according to the runtime config
- * @done_list: list of completed transactions
  * @at: active transaction on this channel
  * @lock: a lock for this channel data
  * @host: a pointer to the host (internal use)
@@ -227,11 +226,9 @@ enum pl08x_dma_chan_state {
 struct pl08x_dma_chan {
 	struct virt_dma_chan vc;
 	struct pl08x_phy_chan *phychan;
-	struct tasklet_struct tasklet;
 	const char *name;
 	const struct pl08x_channel_data *cd;
 	struct dma_slave_config cfg;
-	struct list_head done_list;
 	struct pl08x_txd *at;
 	struct pl08x_driver_data *host;
 	enum pl08x_dma_chan_state state;
@@ -1084,6 +1081,52 @@ static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 	kfree(txd);
 }
 
+static void pl08x_unmap_buffers(struct pl08x_txd *txd)
+{
+	struct device *dev = txd->vd.tx.chan->device->dev;
+	struct pl08x_sg *dsg;
+
+	if (!(txd->vd.tx.flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
+		if (txd->vd.tx.flags & DMA_COMPL_SRC_UNMAP_SINGLE)
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				dma_unmap_single(dev, dsg->src_addr, dsg->len,
+						DMA_TO_DEVICE);
+		else {
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				dma_unmap_page(dev, dsg->src_addr, dsg->len,
+						DMA_TO_DEVICE);
+		}
+	}
+	if (!(txd->vd.tx.flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
+		if (txd->vd.tx.flags & DMA_COMPL_DEST_UNMAP_SINGLE)
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				dma_unmap_single(dev, dsg->dst_addr, dsg->len,
+						DMA_FROM_DEVICE);
+		else
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				dma_unmap_page(dev, dsg->dst_addr, dsg->len,
+						DMA_FROM_DEVICE);
+	}
+}
+
+static void pl08x_desc_free(struct virt_dma_desc *vd)
+{
+	struct pl08x_txd *txd = to_pl08x_txd(&vd->tx);
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(vd->tx.chan);
+	struct pl08x_driver_data *pl08x = plchan->host;
+	unsigned long flags;
+
+	if (!plchan->slave)
+		pl08x_unmap_buffers(txd);
+
+	if (!txd->done)
+		pl08x_release_mux(plchan);
+
+	spin_lock_irqsave(&pl08x->lock, flags);
+	pl08x_free_txd(plchan->host, txd);
+	spin_unlock_irqrestore(&pl08x->lock, flags);
+}
+
 static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
 				struct pl08x_dma_chan *plchan)
 {
@@ -1094,9 +1137,8 @@ static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
 
 	while (!list_empty(&head)) {
 		txd = list_first_entry(&head, struct pl08x_txd, vd.node);
-		pl08x_release_mux(plchan);
 		list_del(&txd->vd.node);
-		pl08x_free_txd(pl08x, txd);
+		pl08x_desc_free(&txd->vd);
 	}
 }
 
@@ -1541,9 +1583,7 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		}
 		/* Dequeue jobs and free LLIs */
 		if (plchan->at) {
-			/* Killing this one off, release its mux */
-			pl08x_release_mux(plchan);
-			pl08x_free_txd(pl08x, plchan->at);
+			pl08x_desc_free(&plchan->at->vd);
 			plchan->at = NULL;
 		}
 		/* Dequeue jobs not yet fired as well */
@@ -1600,68 +1640,6 @@ static void pl08x_ensure_on(struct pl08x_driver_data *pl08x)
 	writel(PL080_CONFIG_ENABLE, pl08x->base + PL080_CONFIG);
 }
 
-static void pl08x_unmap_buffers(struct pl08x_txd *txd)
-{
-	struct device *dev = txd->vd.tx.chan->device->dev;
-	struct pl08x_sg *dsg;
-
-	if (!(txd->vd.tx.flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
-		if (txd->vd.tx.flags & DMA_COMPL_SRC_UNMAP_SINGLE)
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				dma_unmap_single(dev, dsg->src_addr, dsg->len,
-						DMA_TO_DEVICE);
-		else {
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				dma_unmap_page(dev, dsg->src_addr, dsg->len,
-						DMA_TO_DEVICE);
-		}
-	}
-	if (!(txd->vd.tx.flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
-		if (txd->vd.tx.flags & DMA_COMPL_DEST_UNMAP_SINGLE)
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				dma_unmap_single(dev, dsg->dst_addr, dsg->len,
-						DMA_FROM_DEVICE);
-		else
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				dma_unmap_page(dev, dsg->dst_addr, dsg->len,
-						DMA_FROM_DEVICE);
-	}
-}
-
-static void pl08x_tasklet(unsigned long data)
-{
-	struct pl08x_dma_chan *plchan = (struct pl08x_dma_chan *) data;
-	struct pl08x_driver_data *pl08x = plchan->host;
-	unsigned long flags;
-	LIST_HEAD(head);
-
-	spin_lock_irqsave(&plchan->vc.lock, flags);
-	list_splice_tail_init(&plchan->done_list, &head);
-	spin_unlock_irqrestore(&plchan->vc.lock, flags);
-
-	while (!list_empty(&head)) {
-		struct pl08x_txd *txd = list_first_entry(&head,
-						struct pl08x_txd, node);
-		dma_async_tx_callback callback = txd->vd.tx.callback;
-		void *callback_param = txd->vd.tx.callback_param;
-
-		list_del(&txd->node);
-
-		/* Don't try to unmap buffers on slave channels */
-		if (!plchan->slave)
-			pl08x_unmap_buffers(txd);
-
-		/* Free the descriptor */
-		spin_lock_irqsave(&plchan->vc.lock, flags);
-		pl08x_free_txd(pl08x, txd);
-		spin_unlock_irqrestore(&plchan->vc.lock, flags);
-
-		/* Callback to signal completion */
-		if (callback)
-			callback(callback_param);
-	}
-}
-
 static irqreturn_t pl08x_irq(int irq, void *dev)
 {
 	struct pl08x_driver_data *pl08x = dev;
@@ -1704,8 +1682,8 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 				 * reservation.
 				 */
 				pl08x_release_mux(plchan);
-				dma_cookie_complete(&tx->vd.tx);
-				list_add_tail(&tx->node, &plchan->done_list);
+				tx->done = true;
+				vchan_cookie_complete(&tx->vd);
 
 				/*
 				 * And start the next descriptor (if any),
@@ -1718,8 +1696,6 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 			}
 			spin_unlock(&plchan->vc.lock);
 
-			/* Schedule tasklet on this channel */
-			tasklet_schedule(&plchan->tasklet);
 			mask |= (1 << i);
 		}
 	}
@@ -1779,10 +1755,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			 "initialize virtual channel \"%s\"\n",
 			 chan->name);
 
-		INIT_LIST_HEAD(&chan->done_list);
-		tasklet_init(&chan->tasklet, pl08x_tasklet,
-			     (unsigned long) chan);
-
+		chan->vc.desc_free = pl08x_desc_free;
 		vchan_init(&chan->vc, dmadev);
 	}
 	dev_info(&pl08x->adev->dev, "initialized %d virtual %s channels\n",
-- 
1.7.4.4

