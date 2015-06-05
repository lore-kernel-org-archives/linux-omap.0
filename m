From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] dmaengine: ti-dma-crossbar: Add support for eDMA xbar
Date: Fri, 5 Jun 2015 18:34:34 +0300
Message-ID: <1433518474-26628-4-git-send-email-peter.ujfalusi@ti.com>
References: <1433518474-26628-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433518474-26628-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

eDMA crossbar works exactly the same way as sDMA, but sDMA
requires an offset of 1, while no offset is needed for eDMA.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  1 +
 drivers/dma/ti-dma-crossbar.c                      | 30 +++++++++++++++++-----
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
index 76a10d0724b7..da46dddc78ef 100644
--- a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
+++ b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
@@ -2,6 +2,7 @@ Texas Instruments DMA Crossbar (DMA request router)
 
 Required properties:
 - compatible:	"ti,dra7-sdma-crossbar" for DRA7xx sDMA crossbar
+		"ti,dra7-edma-crossbar" for DRA7xx eDMA crossbar
 - reg:		Memory map for accessing module
 - #dma-cells:	Should be set to <1>.
 		Clients should use the crossbar request number (input)
diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 887cfe676b6d..c21690ed954f 100644
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
 
+static const struct of_device_id ti_dma_xbar_match[] = {
+	{
+		.compatible = "ti,dra7-sdma-crossbar",
+		.data = (void *)TI_XBAR_SDMA_OFFSET,
+	},
+	{
+		.compatible = "ti,dra7-edma-crossbar",
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
@@ -108,6 +124,10 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 	if (!node)
 		return -ENODEV;
 
+	match = of_match_device(ti_dma_xbar_match, &pdev->dev);
+	if (!match)
+		return -EINVAL;
+
 	xbar = devm_kzalloc(&pdev->dev, sizeof(*xbar), GFP_KERNEL);
 	if (!xbar)
 		return -ENOMEM;
@@ -151,6 +171,7 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 
 	xbar->dmarouter.dev = &pdev->dev;
 	xbar->dmarouter.route_free = ti_dma_xbar_free;
+	xbar->dma_offset = (u32)match->data;
 
 	platform_set_drvdata(pdev, xbar);
 
@@ -169,11 +190,6 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct of_device_id ti_dma_xbar_match[] = {
-	{ .compatible = "ti,dra7-sdma-crossbar" },
-	{},
-};
-
 static struct platform_driver ti_dma_xbar_driver = {
 	.driver = {
 		.name = "ti-dma-crossbar",
-- 
2.4.2
