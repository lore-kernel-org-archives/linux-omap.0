From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: omap-dma: Do not call omap_dma_callback() from tx_status()
Date: Thu, 25 Feb 2016 10:28:59 +0200
Message-ID: <1456388939-15722-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When based on the CCR_ENABLE bit the channel is stopped we should not call
omap_dma_callback(), only change the return value to DMA_COMPLETE. Client
drivers will do the right thing to clean up the channel after the transfer
has been completed.
Check the CCR_ENABLE only if the channel is not paused since pause in sDMA
means that the channel is stopped.
This will fix one hard to reproduce race condition when the channel is
terminated during transfer (affecting cyclic operation).

Fixes: 1a7cf7b26f25 ("dmaengine: omap-dma: Handle cases when the channel is polled for completion")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index f6bef0d93998..a6b189fdbbe6 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -671,18 +671,22 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 	struct omap_chan *c = to_omap_dma_chan(chan);
 	struct virt_dma_desc *vd;
 	enum dma_status ret;
-	uint32_t ccr;
 	unsigned long flags;
 
-	ccr = omap_dma_chan_read(c, CCR);
-	/* The channel is no longer active, handle the completion right away */
-	if (!(ccr & CCR_ENABLE))
-		omap_dma_callback(c->dma_ch, 0, c);
-
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
+	if (!c->paused) {
+		uint32_t ccr = omap_dma_chan_read(c, CCR);
+		/*
+		 * The channel is no longer active, set the return value
+		 * accordingly
+		 */
+		if (!(ccr & CCR_ENABLE))
+			ret = DMA_COMPLETE;
+	}
+
 	spin_lock_irqsave(&c->vc.lock, flags);
 	vd = vchan_find_desc(&c->vc, cookie);
 	if (vd) {
-- 
2.7.1
