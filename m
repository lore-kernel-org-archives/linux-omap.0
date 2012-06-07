From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 28/31] dmaengine: PL08x: fix tx_status function to return
 correct residue
Date: Thu, 07 Jun 2012 11:55:10 +0100
Message-ID: <E1ScaMw-0003mK-ST@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54271 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab2FGKzP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:55:15 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Now that we're converted to use the generic vchan support, we can fix
the residue return from tx_status to be compliant with dmaengine.  This
returns the number of bytes remaining for the _specified_ cookie, not
the number of bytes in all pending transfers on the channel.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   61 +++++++++++++++++++++++++--------------------
 1 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 6a35e37..c42c7ef 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -473,10 +473,8 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_phy_chan *ch;
 	struct pl08x_txd *txd;
-	unsigned long flags;
 	size_t bytes = 0;
 
-	spin_lock_irqsave(&plchan->vc.lock, flags);
 	ch = plchan->phychan;
 	txd = plchan->at;
 
@@ -516,27 +514,6 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 		}
 	}
 
-	/* Sum up all queued transactions */
-	if (!list_empty(&plchan->vc.desc_issued)) {
-		struct pl08x_txd *txdi;
-		list_for_each_entry(txdi, &plchan->vc.desc_issued, vd.node) {
-			struct pl08x_sg *dsg;
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				bytes += dsg->len;
-		}
-	}
-
-	if (!list_empty(&plchan->vc.desc_submitted)) {
-		struct pl08x_txd *txdi;
-		list_for_each_entry(txdi, &plchan->vc.desc_submitted, vd.node) {
-			struct pl08x_sg *dsg;
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				bytes += dsg->len;
-		}
-	}
-
-	spin_unlock_irqrestore(&plchan->vc.lock, flags);
-
 	return bytes;
 }
 
@@ -1171,23 +1148,53 @@ static enum dma_status pl08x_dma_tx_status(struct dma_chan *chan,
 		dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	struct virt_dma_desc *vd;
+	unsigned long flags;
 	enum dma_status ret;
+	size_t bytes = 0;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_SUCCESS)
 		return ret;
 
 	/*
+	 * There's no point calculating the residue if there's
+	 * no txstate to store the value.
+	 */
+	if (!txstate) {
+		if (plchan->state == PL08X_CHAN_PAUSED)
+			ret = DMA_PAUSED;
+		return ret;
+	}
+
+	spin_lock_irqsave(&plchan->vc.lock, flags);
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret != DMA_SUCCESS) {
+		vd = vchan_find_desc(&plchan->vc, cookie);
+		if (vd) {
+			/* On the issued list, so hasn't been processed yet */
+			struct pl08x_txd *txd = to_pl08x_txd(&vd->tx);
+			struct pl08x_sg *dsg;
+
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				bytes += dsg->len;
+		} else {
+			bytes = pl08x_getbytes_chan(plchan);
+		}
+	}
+	spin_unlock_irqrestore(&plchan->vc.lock, flags);
+
+	/*
 	 * This cookie not complete yet
 	 * Get number of bytes left in the active transactions and queue
 	 */
-	dma_set_residue(txstate, pl08x_getbytes_chan(plchan));
+	dma_set_residue(txstate, bytes);
 
-	if (plchan->state == PL08X_CHAN_PAUSED)
-		return DMA_PAUSED;
+	if (plchan->state == PL08X_CHAN_PAUSED && ret == DMA_IN_PROGRESS)
+		ret = DMA_PAUSED;
 
 	/* Whether waiting or running, we're in progress */
-	return DMA_IN_PROGRESS;
+	return ret;
 }
 
 /* PrimeCell DMA extension */
-- 
1.7.4.4

