From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 25/31] dmaengine: PL08x: use vchan's spinlock
Date: Thu, 07 Jun 2012 11:54:10 +0100
Message-ID: <E1ScaLy-0003m4-GA@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54255 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2FGKyQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:54:16 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Initialize the vchan struct, and use the provided spinlock rather than
our own.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/Kconfig      |    1 +
 drivers/dma/amba-pl08x.c |   45 ++++++++++++++++++++-------------------------
 2 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index eb2b60e..be0dc3b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -53,6 +53,7 @@ config AMBA_PL08X
 	bool "ARM PrimeCell PL080 or PL081 support"
 	depends on ARM_AMBA && EXPERIMENTAL
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Platform has a PL08x DMAC device
 	  which can provide DMA engine support
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 9a06428..398a5da 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -237,7 +237,6 @@ struct pl08x_dma_chan {
 	struct list_head issued_list;
 	struct list_head done_list;
 	struct pl08x_txd *at;
-	spinlock_t lock;
 	struct pl08x_driver_data *host;
 	enum pl08x_dma_chan_state state;
 	bool slave;
@@ -484,7 +483,7 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	unsigned long flags;
 	size_t bytes = 0;
 
-	spin_lock_irqsave(&plchan->lock, flags);
+	spin_lock_irqsave(&plchan->vc.lock, flags);
 	ch = plchan->phychan;
 	txd = plchan->at;
 
@@ -543,7 +542,7 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 		}
 	}
 
-	spin_unlock_irqrestore(&plchan->lock, flags);
+	spin_unlock_irqrestore(&plchan->vc.lock, flags);
 
 	return bytes;
 }
@@ -673,12 +672,12 @@ static void pl08x_phy_free(struct pl08x_dma_chan *plchan)
 		 * Eww.  We know this isn't going to deadlock
 		 * but lockdep probably doesn't.
 		 */
-		spin_lock(&next->lock);
+		spin_lock(&next->vc.lock);
 		/* Re-check the state now that we have the lock */
 		success = next->state == PL08X_CHAN_WAITING;
 		if (success)
 			pl08x_phy_reassign_start(plchan->phychan, next);
-		spin_unlock(&next->lock);
+		spin_unlock(&next->vc.lock);
 
 		/* If the state changed, try to find another channel */
 		if (!success)
@@ -1125,12 +1124,12 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 	unsigned long flags;
 	dma_cookie_t cookie;
 
-	spin_lock_irqsave(&plchan->lock, flags);
+	spin_lock_irqsave(&plchan->vc.lock, flags);
 	cookie = dma_cookie_assign(tx);
 
 	/* Put this onto the pending list */
 	list_add_tail(&txd->node, &plchan->pend_list);
-	spin_unlock_irqrestore(&plchan->lock, flags);
+	spin_unlock_irqrestore(&plchan->vc.lock, flags);
 
 	return cookie;
 }
@@ -1318,13 +1317,13 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	unsigned long flags;
 
-	spin_lock_irqsave(&plchan->lock, flags);
+	spin_lock_irqsave(&plchan->vc.lock, flags);
 	list_splice_tail_init(&plchan->pend_list, &plchan->issued_list);
 	if (!list_empty(&plchan->issued_list)) {
 		if (!plchan->phychan && plchan->state != PL08X_CHAN_WAITING)
 			pl08x_phy_alloc_and_start(plchan);
 	}
-	spin_unlock_irqrestore(&plchan->lock, flags);
+	spin_unlock_irqrestore(&plchan->vc.lock, flags);
 }
 
 static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
@@ -1337,9 +1336,9 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 	if (!num_llis) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&plchan->lock, flags);
+		spin_lock_irqsave(&plchan->vc.lock, flags);
 		pl08x_free_txd(pl08x, txd);
-		spin_unlock_irqrestore(&plchan->lock, flags);
+		spin_unlock_irqrestore(&plchan->vc.lock, flags);
 
 		return -EINVAL;
 	}
@@ -1551,9 +1550,9 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	 * Anything succeeds on channels with no physical allocation and
 	 * no queued transfers.
 	 */
-	spin_lock_irqsave(&plchan->lock, flags);
+	spin_lock_irqsave(&plchan->vc.lock, flags);
 	if (!plchan->phychan && !plchan->at) {
-		spin_unlock_irqrestore(&plchan->lock, flags);
+		spin_unlock_irqrestore(&plchan->vc.lock, flags);
 		return 0;
 	}
 
@@ -1592,7 +1591,7 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		break;
 	}
 
-	spin_unlock_irqrestore(&plchan->lock, flags);
+	spin_unlock_irqrestore(&plchan->vc.lock, flags);
 
 	return ret;
 }
@@ -1664,9 +1663,9 @@ static void pl08x_tasklet(unsigned long data)
 	unsigned long flags;
 	LIST_HEAD(head);
 
-	spin_lock_irqsave(&plchan->lock, flags);
+	spin_lock_irqsave(&plchan->vc.lock, flags);
 	list_splice_tail_init(&plchan->done_list, &head);
-	spin_unlock_irqrestore(&plchan->lock, flags);
+	spin_unlock_irqrestore(&plchan->vc.lock, flags);
 
 	while (!list_empty(&head)) {
 		struct pl08x_txd *txd = list_first_entry(&head,
@@ -1681,9 +1680,9 @@ static void pl08x_tasklet(unsigned long data)
 			pl08x_unmap_buffers(txd);
 
 		/* Free the descriptor */
-		spin_lock_irqsave(&plchan->lock, flags);
+		spin_lock_irqsave(&plchan->vc.lock, flags);
 		pl08x_free_txd(pl08x, txd);
-		spin_unlock_irqrestore(&plchan->lock, flags);
+		spin_unlock_irqrestore(&plchan->vc.lock, flags);
 
 		/* Callback to signal completion */
 		if (callback)
@@ -1724,7 +1723,7 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 				continue;
 			}
 
-			spin_lock(&plchan->lock);
+			spin_lock(&plchan->vc.lock);
 			tx = plchan->at;
 			if (tx) {
 				plchan->at = NULL;
@@ -1745,7 +1744,7 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 				else
 					pl08x_phy_free(plchan);
 			}
-			spin_unlock(&plchan->lock);
+			spin_unlock(&plchan->vc.lock);
 
 			/* Schedule tasklet on this channel */
 			tasklet_schedule(&plchan->tasklet);
@@ -1808,17 +1807,13 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			 "initialize virtual channel \"%s\"\n",
 			 chan->name);
 
-		chan->vc.chan.device = dmadev;
-		dma_cookie_init(&chan->vc.chan);
-
-		spin_lock_init(&chan->lock);
 		INIT_LIST_HEAD(&chan->pend_list);
 		INIT_LIST_HEAD(&chan->issued_list);
 		INIT_LIST_HEAD(&chan->done_list);
 		tasklet_init(&chan->tasklet, pl08x_tasklet,
 			     (unsigned long) chan);
 
-		list_add_tail(&chan->vc.chan.device_node, &dmadev->channels);
+		vchan_init(&chan->vc, dmadev);
 	}
 	dev_info(&pl08x->adev->dev, "initialized %d virtual %s channels\n",
 		 i, slave ? "slave" : "memcpy");
-- 
1.7.4.4

