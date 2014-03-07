From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dma: omap-dma: Implement device_slave_caps callback
Date: Fri, 7 Mar 2014 15:36:44 +0200
Message-ID: <1394199404-7870-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

With the callback implemented omap-dma can provide information to client
drivers regarding to supported address widths, directions, residue
granularity, etc.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 64ceca2920b8..b19f04f4390b 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1088,6 +1088,23 @@ static void omap_dma_free(struct omap_dmadev *od)
 	}
 }
 
+#define OMAP_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
+
+static int omap_dma_device_slave_caps(struct dma_chan *dchan,
+				      struct dma_slave_caps *caps)
+{
+	caps->src_addr_widths = OMAP_DMA_BUSWIDTHS;
+	caps->dstn_addr_widths = OMAP_DMA_BUSWIDTHS;
+	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	caps->cmd_pause = true;
+	caps->cmd_terminate = true;
+	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	return 0;
+}
+
 static int omap_dma_probe(struct platform_device *pdev)
 {
 	struct omap_dmadev *od;
@@ -1118,6 +1135,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	od->ddev.device_prep_slave_sg = omap_dma_prep_slave_sg;
 	od->ddev.device_prep_dma_cyclic = omap_dma_prep_dma_cyclic;
 	od->ddev.device_control = omap_dma_control;
+	od->ddev.device_slave_caps = omap_dma_device_slave_caps;
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
 	INIT_LIST_HEAD(&od->pending);
-- 
1.9.0
