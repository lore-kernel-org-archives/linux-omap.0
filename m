From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/7] dmaengine: omap-dma: Dynamically allocate memory for lch_map
Date: Thu, 14 Jul 2016 15:42:39 +0300
Message-ID: <20160714124242.7579-5-peter.ujfalusi@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On OMAP1 platforms we do not have 32 channels available. Allocate the
lch_map based on the available channels. This way we are not going to have
more visible channels then it is available on the platform.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 6d134252ed61..c026642fc66a 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -35,7 +35,7 @@ struct omap_dmadev {
 	unsigned dma_requests;
 	spinlock_t irq_lock;
 	uint32_t irq_enable_mask;
-	struct omap_chan *lch_map[OMAP_SDMA_CHANNELS];
+	struct omap_chan **lch_map;
 };
 
 struct omap_chan {
@@ -1223,16 +1223,24 @@ static int omap_dma_probe(struct platform_device *pdev)
 	spin_lock_init(&od->lock);
 	spin_lock_init(&od->irq_lock);
 
-	od->dma_requests = OMAP_SDMA_REQUESTS;
-	if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
-						      "dma-requests",
-						      &od->dma_requests)) {
+	if (!pdev->dev.of_node) {
+		od->dma_requests = od->plat->dma_attr->lch_count;
+		if (unlikely(!od->dma_requests))
+			od->dma_requests = OMAP_SDMA_REQUESTS;
+	} else if (of_property_read_u32(pdev->dev.of_node, "dma-requests",
+					&od->dma_requests)) {
 		dev_info(&pdev->dev,
 			 "Missing dma-requests property, using %u.\n",
 			 OMAP_SDMA_REQUESTS);
+		od->dma_requests = OMAP_SDMA_REQUESTS;
 	}
 
-	for (i = 0; i < OMAP_SDMA_CHANNELS; i++) {
+	od->lch_map = devm_kcalloc(&pdev->dev, od->dma_requests,
+				   sizeof(*od->lch_map), GFP_KERNEL);
+	if (!od->lch_map)
+		return -ENOMEM;
+
+	for (i = 0; i < od->dma_requests; i++) {
 		rc = omap_dma_chan_init(od);
 		if (rc) {
 			omap_dma_free(od);
-- 
2.9.1
