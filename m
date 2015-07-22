From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/2] dmaengine: ti-dma-crossbar: Add support for eDMA
Date: Wed, 22 Jul 2015 11:48:10 +0300
Message-ID: <1437554890-2088-3-git-send-email-peter.ujfalusi@ti.com>
References: <1437554890-2088-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437554890-2088-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, tony@atomide.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

The crossbar for eDMA works exactly the same way as sDMA, but sDMA
requires an offset of 1, while no offset is needed for eDMA.

Based on the patch from Misael Lopez Cruz <misael.lopez@ti.com>

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Misael Lopez Cruz <misael.lopez@ti.com>
---
 drivers/dma/ti-dma-crossbar.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 1fd3fb73d6e8..10487d91e60d 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -20,6 +20,9 @@
 #define TI_XBAR_OUTPUTS	127
 #define TI_XBAR_INPUTS	256
 
+#define TI_XBAR_EDMA_OFFSET	0
+#define TI_XBAR_SDMA_OFFSET	1
+
 struct ti_dma_xbar_data {
 	void __iomem *iomem;
 
@@ -29,6 +32,7 @@ struct ti_dma_xbar_data {
 	u16 safe_val; /* Value to rest the crossbar lines */
 	u32 xbar_requests; /* number of DMA requests connected to XBAR */
 	u32 dma_requests; /* number of DMA requests forwarded to DMA */
+	u32 dma_offset;
 };
 
 struct ti_dma_xbar_map {
@@ -84,8 +88,7 @@ static void *ti_dma_xbar_route_allocate(struct of_phandle_args *dma_spec,
 				  GFP_KERNEL);
 	map->xbar_in = (u16)dma_spec->args[0];
 
-	/* The DMA request is 1 based in sDMA */
-	dma_spec->args[0] = map->xbar_out + 1;
+	dma_spec->args[0] = map->xbar_out + xbar->dma_offset;
 
 	dev_dbg(&pdev->dev, "Mapping XBAR%u to DMA%d\n",
 		map->xbar_in, map->xbar_out);
@@ -95,9 +98,22 @@ static void *ti_dma_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	return map;
 }
 
+static const struct of_device_id ti_dma_master_match[] = {
+	{
+		.compatible = "ti,omap4430-sdma",
+		.data = (void *)TI_XBAR_SDMA_OFFSET,
+	},
+	{
+		.compatible = "ti,edma3",
+		.data = (void *)TI_XBAR_EDMA_OFFSET,
+	},
+	{},
+};
+
 static int ti_dma_xbar_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	const struct of_device_id *match;
 	struct device_node *dma_node;
 	struct ti_dma_xbar_data *xbar;
 	struct resource *res;
@@ -120,6 +136,12 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	match = of_match_node(ti_dma_master_match, dma_node);
+	if (!match) {
+		dev_err(&pdev->dev, "DMA master is not supported\n");
+		return -EINVAL;
+	}
+
 	if (of_property_read_u32(dma_node, "dma-requests",
 				 &xbar->dma_requests)) {
 		dev_info(&pdev->dev,
@@ -151,6 +173,7 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 
 	xbar->dmarouter.dev = &pdev->dev;
 	xbar->dmarouter.route_free = ti_dma_xbar_free;
+	xbar->dma_offset = (u32)match->data;
 
 	platform_set_drvdata(pdev, xbar);
 
-- 
2.4.5
