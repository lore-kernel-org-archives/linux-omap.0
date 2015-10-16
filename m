From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 07/14] dmaengine: edma: Refactor the dma device and channel struct initialization
Date: Fri, 16 Oct 2015 10:18:05 +0300
Message-ID: <1444979892-31626-8-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Move all code under one function to do the dma device and eDMA channel
related setup so they are not scattered around the driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 79 +++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index ea851ab05c8e..e1b0e6864f27 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1756,18 +1756,49 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
 	return ret;
 }
 
-static void __init edma_chan_init(struct edma_cc *ecc, struct dma_device *dma,
-				  struct edma_chan *echans)
+#define EDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
+
+static void edma_dma_init(struct edma_cc *ecc)
 {
+	struct dma_device *ddev = &ecc->dma_slave;
 	int i, j;
 
+	dma_cap_zero(ddev->cap_mask);
+	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
+	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
+	dma_cap_set(DMA_MEMCPY, ddev->cap_mask);
+
+	ddev->device_prep_slave_sg = edma_prep_slave_sg;
+	ddev->device_prep_dma_cyclic = edma_prep_dma_cyclic;
+	ddev->device_prep_dma_memcpy = edma_prep_dma_memcpy;
+	ddev->device_alloc_chan_resources = edma_alloc_chan_resources;
+	ddev->device_free_chan_resources = edma_free_chan_resources;
+	ddev->device_issue_pending = edma_issue_pending;
+	ddev->device_tx_status = edma_tx_status;
+	ddev->device_config = edma_slave_config;
+	ddev->device_pause = edma_dma_pause;
+	ddev->device_resume = edma_dma_resume;
+	ddev->device_terminate_all = edma_terminate_all;
+
+	ddev->src_addr_widths = EDMA_DMA_BUSWIDTHS;
+	ddev->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
+	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	ddev->dev = ecc->dev;
+
+	INIT_LIST_HEAD(&ddev->channels);
+
 	for (i = 0; i < ecc->num_channels; i++) {
-		struct edma_chan *echan = &echans[i];
+		struct edma_chan *echan = &ecc->slave_chans[i];
 		echan->ch_num = EDMA_CTLR_CHAN(ecc->id, i);
 		echan->ecc = ecc;
 		echan->vchan.desc_free = edma_desc_free;
 
-		vchan_init(&echan->vchan, dma);
+		vchan_init(&echan->vchan, ddev);
 
 		INIT_LIST_HEAD(&echan->node);
 		for (j = 0; j < EDMA_MAX_SLOTS; j++)
@@ -1775,36 +1806,6 @@ static void __init edma_chan_init(struct edma_cc *ecc, struct dma_device *dma,
 	}
 }
 
-#define EDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
-
-static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
-			  struct device *dev)
-{
-	dma->device_prep_slave_sg = edma_prep_slave_sg;
-	dma->device_prep_dma_cyclic = edma_prep_dma_cyclic;
-	dma->device_prep_dma_memcpy = edma_prep_dma_memcpy;
-	dma->device_alloc_chan_resources = edma_alloc_chan_resources;
-	dma->device_free_chan_resources = edma_free_chan_resources;
-	dma->device_issue_pending = edma_issue_pending;
-	dma->device_tx_status = edma_tx_status;
-	dma->device_config = edma_slave_config;
-	dma->device_pause = edma_dma_pause;
-	dma->device_resume = edma_dma_resume;
-	dma->device_terminate_all = edma_terminate_all;
-
-	dma->src_addr_widths = EDMA_DMA_BUSWIDTHS;
-	dma->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
-	dma->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
-
-	dma->dev = dev;
-
-	INIT_LIST_HEAD(&dma->channels);
-}
-
 static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 			      struct edma_cc *ecc)
 {
@@ -2137,14 +2138,8 @@ static int edma_probe(struct platform_device *pdev)
 	}
 	ecc->info = info;
 
-	dma_cap_zero(ecc->dma_slave.cap_mask);
-	dma_cap_set(DMA_SLAVE, ecc->dma_slave.cap_mask);
-	dma_cap_set(DMA_CYCLIC, ecc->dma_slave.cap_mask);
-	dma_cap_set(DMA_MEMCPY, ecc->dma_slave.cap_mask);
-
-	edma_dma_init(ecc, &ecc->dma_slave, dev);
-
-	edma_chan_init(ecc, &ecc->dma_slave, ecc->slave_chans);
+	/* Init the dma device and channels */
+	edma_dma_init(ecc);
 
 	for (i = 0; i < ecc->num_channels; i++) {
 		/* Assign all channels to the default queue */
-- 
2.6.1
