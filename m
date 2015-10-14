From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/13] dmaengine: edma: Refactor the dma device and channel
 struct initialization
Date: Wed, 14 Oct 2015 16:12:18 +0300
Message-ID: <1444828344-21378-8-git-send-email-peter.ujfalusi@ti.com>
References: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, arnd@arndb.de, tony@atomide.com, r.schwebel@pengutronix.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Move all code under one function to do the dma device and eDMA channel
related setup so they are not scattered around the driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 79 +++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d064fbc47351..53188b9383a6 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1750,18 +1750,49 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
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
@@ -1769,36 +1800,6 @@ static void __init edma_chan_init(struct edma_cc *ecc, struct dma_device *dma,
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
@@ -2131,14 +2132,8 @@ static int edma_probe(struct platform_device *pdev)
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
