From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: omap-dma: Fix dynamic lch_map alocation
Date: Mon, 2 Jan 2017 12:07:37 +0200
Message-ID: <20170102100737.11927-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi, tony@atomide.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The original patch did not done what it was supposed to be doing and even
worst it broke legacy boot (OMAP1).

The lch_map size should be the number of available logical channels in sDMA
and the od->dma_requests should store the number of available DMA request
lines usable in sDMA.

In legacy mode we do not have a way to get the DMA request count, in that
case we use OMAP_SDMA_REQUESTS (127), despite the fact that OMAP1510 have
only 31 DMA request line.

Fixes: 2d1a9a946fae ("dmaengine: omap-dma: Dynamically allocate memory for lch_map")
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org   # v4.9
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ac68666cd3f4..4ad101a47e0a 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1452,6 +1452,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	struct omap_dmadev *od;
 	struct resource *res;
 	int rc, i, irq;
+	u32 lch_count;
 
 	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
 	if (!od)
@@ -1494,20 +1495,31 @@ static int omap_dma_probe(struct platform_device *pdev)
 	spin_lock_init(&od->lock);
 	spin_lock_init(&od->irq_lock);
 
-	if (!pdev->dev.of_node) {
-		od->dma_requests = od->plat->dma_attr->lch_count;
-		if (unlikely(!od->dma_requests))
-			od->dma_requests = OMAP_SDMA_REQUESTS;
-	} else if (of_property_read_u32(pdev->dev.of_node, "dma-requests",
-					&od->dma_requests)) {
+	/* Number of DMA requests */
+	od->dma_requests = OMAP_SDMA_REQUESTS;
+	if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
+						      "dma-requests",
+						      &od->dma_requests)) {
 		dev_info(&pdev->dev,
 			 "Missing dma-requests property, using %u.\n",
 			 OMAP_SDMA_REQUESTS);
-		od->dma_requests = OMAP_SDMA_REQUESTS;
 	}
 
-	od->lch_map = devm_kcalloc(&pdev->dev, od->dma_requests,
-				   sizeof(*od->lch_map), GFP_KERNEL);
+	/* Number of available logical channels */
+	if (!pdev->dev.of_node) {
+		lch_count = od->plat->dma_attr->lch_count;
+		if (unlikely(!lch_count))
+			lch_count = OMAP_SDMA_CHANNELS;
+	} else if (of_property_read_u32(pdev->dev.of_node, "dma-channels",
+					&lch_count)) {
+		dev_info(&pdev->dev,
+			 "Missing dma-channels property, using %u.\n",
+			 OMAP_SDMA_CHANNELS);
+		lch_count = OMAP_SDMA_CHANNELS;
+	}
+
+	od->lch_map = devm_kcalloc(&pdev->dev, lch_count, sizeof(*od->lch_map),
+				   GFP_KERNEL);
 	if (!od->lch_map)
 		return -ENOMEM;
 
-- 
2.11.0
