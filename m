From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 18/31] dmaengine: PL08x: move DMA signal muxing into slave
 prepare code
Date: Thu, 07 Jun 2012 11:51:48 +0100
Message-ID: <E1ScaJg-0003lN-SY@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54225 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760603Ab2FGKvz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:51:55 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Move the DMA request muxing into the slave prepare code and txd
release/completion code.  This means we only hold the DMA request
mux while there are descriptors waiting to be started or are in
progress.

This leaves txd->direction as a write-only variable; remove it.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   79 ++++++++++++++++++---------------------------
 1 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 54e3eb0..e04ca0b 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -168,7 +168,6 @@ struct pl08x_sg {
  * @tx: async tx descriptor
  * @node: node for txd list for channels
  * @dsg_list: list of children sg's
- * @direction: direction of transfer
  * @llis_bus: DMA memory address (physical) start for the LLIs
  * @llis_va: virtual memory address start for the LLIs
  * @cctl: control reg values for current txd
@@ -178,7 +177,6 @@ struct pl08x_txd {
 	struct dma_async_tx_descriptor tx;
 	struct list_head node;
 	struct list_head dsg_list;
-	enum dma_transfer_direction direction;
 	dma_addr_t llis_bus;
 	struct pl08x_lli *llis_va;
 	/* Default cctl value for LLIs */
@@ -997,6 +995,7 @@ static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
 	if (!list_empty(&plchan->pend_list)) {
 		list_for_each_entry_safe(txdi,
 					 next, &plchan->pend_list, node) {
+			pl08x_release_mux(plchan);
 			list_del(&txdi->node);
 			pl08x_free_txd(pl08x, txdi);
 		}
@@ -1018,12 +1017,10 @@ static void pl08x_free_chan_resources(struct dma_chan *chan)
 /*
  * This should be called with the channel plchan->lock held
  */
-static int prep_phy_channel(struct pl08x_dma_chan *plchan,
-			    struct pl08x_txd *txd)
+static int prep_phy_channel(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_phy_chan *ch;
-	int ret;
 
 	/* Check if we already have a channel */
 	if (plchan->phychan) {
@@ -1038,36 +1035,11 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 		return -EBUSY;
 	}
 
-	/*
-	 * OK we have a physical channel: for memcpy() this is all we
-	 * need, but for slaves the physical signals may be muxed!
-	 * Can the platform allow us to use this channel?
-	 */
-	if (plchan->slave) {
-		ret = pl08x_request_mux(plchan);
-		if (ret < 0) {
-			dev_dbg(&pl08x->adev->dev,
-				"unable to use physical channel %d for transfer on %s due to platform restrictions\n",
-				ch->id, plchan->name);
-			/* Release physical channel & return */
-			pl08x_put_phy_channel(pl08x, ch);
-			return -EBUSY;
-		}
-	}
-
 	plchan->phychan = ch;
-	dev_dbg(&pl08x->adev->dev, "allocated physical channel %d and signal %d for xfer on %s\n",
-		 ch->id,
-		 plchan->signal,
-		 plchan->name);
+	dev_dbg(&pl08x->adev->dev, "allocated physical channel %d for xfer on %s\n",
+		 ch->id, plchan->name);
 
 got_channel:
-	/* Assign the flow control signal to this channel */
-	if (txd->direction == DMA_MEM_TO_DEV)
-		txd->ccfg |= plchan->signal << PL080_CONFIG_DST_SEL_SHIFT;
-	else if (txd->direction == DMA_DEV_TO_MEM)
-		txd->ccfg |= plchan->signal << PL080_CONFIG_SRC_SEL_SHIFT;
-
 	plchan->phychan_hold++;
 
 	return 0;
@@ -1077,7 +1049,6 @@ static void release_phy_channel(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_driver_data *pl08x = plchan->host;
 
-	pl08x_release_mux(plchan);
 	pl08x_put_phy_channel(pl08x, plchan->phychan);
 	plchan->phychan = NULL;
 }
@@ -1340,19 +1311,12 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 	 * See if we already have a physical channel allocated,
 	 * else this is the time to try to get one.
 	 */
-	ret = prep_phy_channel(plchan, txd);
+	ret = prep_phy_channel(plchan);
 	if (ret) {
 		/*
 		 * No physical channel was available.
 		 *
 		 * memcpy transfers can be sorted out at submission time.
-		 *
-		 * Slave transfers may have been denied due to platform
-		 * channel muxing restrictions.  Since there is no guarantee
-		 * that this will ever be resolved, and the signal must be
-		 * acquired AFTER acquiring the physical channel, we will let
-		 * them be NACK:ed with -EBUSY here. The drivers can retry
-		 * the prep() call if they are eager on doing this using DMA.
 		 */
 		if (plchan->slave) {
 			pl08x_free_txd_list(pl08x, plchan);
@@ -1423,7 +1387,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	}
 	list_add_tail(&dsg->node, &txd->dsg_list);
 
-	txd->direction = DMA_MEM_TO_MEM;
 	dsg->src_addr = src;
 	dsg->dst_addr = dest;
 	dsg->len = len;
@@ -1477,8 +1440,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	 * will take precedence since this may configure the
 	 * channel target address dynamically at runtime.
 	 */
-	txd->direction = direction;
-
 	if (direction == DMA_MEM_TO_DEV) {
 		cctl = PL080_CONTROL_SRC_INCR;
 		slave_addr = plchan->cfg.dst_addr;
@@ -1519,9 +1480,28 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 
 	txd->ccfg |= tmp << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 
+	ret = pl08x_request_mux(plchan);
+	if (ret < 0) {
+		pl08x_free_txd(pl08x, txd);
+		dev_dbg(&pl08x->adev->dev,
+			"unable to mux for transfer on %s due to platform restrictions\n",
+			plchan->name);
+		return NULL;
+	}
+
+	dev_dbg(&pl08x->adev->dev, "allocated DMA request signal %d for xfer on %s\n",
+		 plchan->signal, plchan->name);
+
+	/* Assign the flow control signal to this channel */
+	if (direction == DMA_MEM_TO_DEV)
+		txd->ccfg |= plchan->signal << PL080_CONFIG_DST_SEL_SHIFT;
+	else
+		txd->ccfg |= plchan->signal << PL080_CONFIG_SRC_SEL_SHIFT;
+
 	for_each_sg(sgl, sg, sg_len, tmp) {
 		dsg = kzalloc(sizeof(struct pl08x_sg), GFP_NOWAIT);
 		if (!dsg) {
+			pl08x_release_mux(plchan);
 			pl08x_free_txd(pl08x, txd);
 			dev_err(&pl08x->adev->dev, "%s no mem for pl080 sg\n",
 					__func__);
@@ -1586,6 +1566,8 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		}
 		/* Dequeue jobs and free LLIs */
 		if (plchan->at) {
+			/* Killing this one off, release its mux */
+			pl08x_release_mux(plchan);
 			pl08x_free_txd(pl08x, plchan->at);
 			plchan->at = NULL;
 		}
@@ -1702,7 +1684,6 @@ static void pl08x_tasklet(unsigned long data)
 
 		/*
 		 * No more jobs, so free up the physical channel
-		 * Free any allocated signal on slave transfers too
 		 */
 		release_phy_channel(plchan);
 		plchan->state = PL08X_CHAN_IDLE;
@@ -1720,8 +1701,7 @@ static void pl08x_tasklet(unsigned long data)
 				int ret;
 
 				/* This should REALLY not fail now */
-				ret = prep_phy_channel(waiting,
-						       waiting->waiting);
+				ret = prep_phy_channel(waiting);
 				BUG_ON(ret);
 				waiting->phychan_hold--;
 				waiting->state = PL08X_CHAN_RUNNING;
@@ -1794,6 +1774,11 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 			tx = plchan->at;
 			if (tx) {
 				plchan->at = NULL;
+				/*
+				 * This descriptor is done, release its mux
+				 * reservation.
+				 */
+				pl08x_release_mux(plchan);
 				dma_cookie_complete(&tx->tx);
 				list_add_tail(&tx->node, &plchan->done_list);
 			}
-- 
1.7.4.4

