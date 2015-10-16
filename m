From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 10/14] dmaengine: ti-dma-crossbar: Add support for crossbar on AM33xx/AM43xx
Date: Fri, 16 Oct 2015 10:18:08 +0300
Message-ID: <1444979892-31626-11-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

The DMA event crossbar on AM33xx/AM43xx is different from the one found in
DRA7x family.
Instead of a single event crossbar it has 64 identical mux attached to each
eDMA event line. When the 0 event mux is selected, the default mapped event
is going to be routed to the corresponding eDMA event line. If different
mux is selected, then the selected event is going to be routed to the given
eDMA event.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  15 +-
 drivers/dma/ti-dma-crossbar.c                      | 251 ++++++++++++++++++---
 2 files changed, 234 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
index 63a48928f3a8..b152a75dceae 100644
--- a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
+++ b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
@@ -2,9 +2,10 @@ Texas Instruments DMA Crossbar (DMA request router)
 
 Required properties:
 - compatible:	"ti,dra7-dma-crossbar" for DRA7xx DMA crossbar
+		"ti,am335x-edma-crossbar" for AM335x and AM437x
 - reg:		Memory map for accessing module
-- #dma-cells:	Should be set to <1>.
-		Clients should use the crossbar request number (input)
+- #dma-cells:	Should be set to to match with the DMA controller's dma-cells
+		for ti,dra7-dma-crossbar and <3> for ti,am335x-edma-crossbar.
 - dma-requests:	Number of DMA requests the crossbar can receive
 - dma-masters:	phandle pointing to the DMA controller
 
@@ -14,6 +15,15 @@ The DMA controller node need to have the following poroperties:
 Optional properties:
 - ti,dma-safe-map: Safe routing value for unused request lines
 
+Notes:
+When requesting channel via ti,dra7-dma-crossbar, the DMA clinet must request
+the DMA event number as crossbar ID (input to the DMA crossbar).
+
+For ti,am335x-edma-crossbar: the meaning of parameters of dmas for clients:
+dmas = <&edma_xbar 12 0 1>; where <12> is the DMA request number, <0> is the TC
+the event should be assigned and <1> is the mux selection for in the crossbar.
+When mux 0 is used the DMA channel can be requested directly from edma node.
+
 Example:
 
 /* DMA controller */
@@ -47,6 +57,7 @@ uart1: serial@4806a000 {
 	ti,hwmods = "uart1";
 	clock-frequency = <48000000>;
 	status = "disabled";
+	/* Requesting crossbar input 49 and 50 */
 	dmas = <&sdma_xbar 49>, <&sdma_xbar 50>;
 	dma-names = "tx", "rx";
 };
diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 5cce8c9d0026..a415edbe61b1 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -17,13 +17,184 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 
-#define TI_XBAR_OUTPUTS	127
-#define TI_XBAR_INPUTS	256
+#define TI_XBAR_DRA7		0
+#define TI_XBAR_AM335X		1
+
+static const struct of_device_id ti_dma_xbar_match[] = {
+	{
+		.compatible = "ti,dra7-dma-crossbar",
+		.data = (void *)TI_XBAR_DRA7,
+	},
+	{
+		.compatible = "ti,am335x-edma-crossbar",
+		.data = (void *)TI_XBAR_AM335X,
+	},
+	{},
+};
+
+/* Crossbar on AM335x/AM437x family */
+#define TI_AM335X_XBAR_LINES	64
+
+struct ti_am335x_xbar_data {
+	void __iomem *iomem;
+
+	struct dma_router dmarouter;
+
+	u32 xbar_events; /* maximum number of events to select in xbar */
+	u32 dma_requests; /* number of DMA requests on eDMA */
+};
+
+struct ti_am335x_xbar_map {
+	u16 dma_line;
+	u16 mux_val;
+};
+
+static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u16 val)
+{
+	writeb_relaxed(val & 0x1f, iomem + event);
+}
+
+static void ti_am335x_xbar_free(struct device *dev, void *route_data)
+{
+	struct ti_am335x_xbar_data *xbar = dev_get_drvdata(dev);
+	struct ti_am335x_xbar_map *map = route_data;
+
+	dev_dbg(dev, "Unmapping XBAR event %u on channel %u\n",
+		map->mux_val, map->dma_line);
+
+	ti_am335x_xbar_write(xbar->iomem, map->dma_line, 0);
+	kfree(map);
+}
+
+static void *ti_am335x_xbar_route_allocate(struct of_phandle_args *dma_spec,
+					   struct of_dma *ofdma)
+{
+	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
+	struct ti_am335x_xbar_data *xbar = platform_get_drvdata(pdev);
+	struct ti_am335x_xbar_map *map;
+
+	if (dma_spec->args_count != 3)
+		return ERR_PTR(-EINVAL);
+
+	if (dma_spec->args[2] >= xbar->xbar_events) {
+		dev_err(&pdev->dev, "Invalid XBAR event number: %d\n",
+			dma_spec->args[2]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (dma_spec->args[0] >= xbar->dma_requests) {
+		dev_err(&pdev->dev, "Invalid DMA request line number: %d\n",
+			dma_spec->args[0]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* The of_node_put() will be done in the core for the node */
+	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
+	if (!dma_spec->np) {
+		dev_err(&pdev->dev, "Can't get DMA master\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map) {
+		of_node_put(dma_spec->np);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	map->dma_line = (u16)dma_spec->args[0];
+	map->mux_val = (u16)dma_spec->args[2];
+
+	dma_spec->args[2] = 0;
+	dma_spec->args_count = 2;
+
+	dev_dbg(&pdev->dev, "Mapping XBAR event%u to DMA%u\n",
+		map->mux_val, map->dma_line);
+
+	ti_am335x_xbar_write(xbar->iomem, map->dma_line, map->mux_val);
+
+	return map;
+}
+
+static const struct of_device_id ti_am335x_master_match[] = {
+	{ .compatible = "ti,edma3-tpcc", },
+	{},
+};
+
+static int ti_am335x_xbar_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	const struct of_device_id *match;
+	struct device_node *dma_node;
+	struct ti_am335x_xbar_data *xbar;
+	struct resource *res;
+	void __iomem *iomem;
+	int i, ret;
+
+	if (!node)
+		return -ENODEV;
+
+	xbar = devm_kzalloc(&pdev->dev, sizeof(*xbar), GFP_KERNEL);
+	if (!xbar)
+		return -ENOMEM;
+
+	dma_node = of_parse_phandle(node, "dma-masters", 0);
+	if (!dma_node) {
+		dev_err(&pdev->dev, "Can't get DMA master node\n");
+		return -ENODEV;
+	}
+
+	match = of_match_node(ti_am335x_master_match, dma_node);
+	if (!match) {
+		dev_err(&pdev->dev, "DMA master is not supported\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(dma_node, "dma-requests",
+				 &xbar->dma_requests)) {
+		dev_info(&pdev->dev,
+			 "Missing XBAR output information, using %u.\n",
+			 TI_AM335X_XBAR_LINES);
+		xbar->dma_requests = TI_AM335X_XBAR_LINES;
+	}
+	of_node_put(dma_node);
+
+	if (of_property_read_u32(node, "dma-requests", &xbar->xbar_events)) {
+		dev_info(&pdev->dev,
+			 "Missing XBAR input information, using %u.\n",
+			 TI_AM335X_XBAR_LINES);
+		xbar->xbar_events = TI_AM335X_XBAR_LINES;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	iomem = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(iomem))
+		return PTR_ERR(iomem);
+
+	xbar->iomem = iomem;
+
+	xbar->dmarouter.dev = &pdev->dev;
+	xbar->dmarouter.route_free = ti_am335x_xbar_free;
+
+	platform_set_drvdata(pdev, xbar);
+
+	/* Reset the crossbar */
+	for (i = 0; i < xbar->dma_requests; i++)
+		ti_am335x_xbar_write(xbar->iomem, i, 0);
+
+	ret = of_dma_router_register(node, ti_am335x_xbar_route_allocate,
+				     &xbar->dmarouter);
+
+	return ret;
+}
+
+/* Crossbar on DRA7xx family */
+#define TI_DRA7_XBAR_OUTPUTS	127
+#define TI_DRA7_XBAR_INPUTS	256
 
 #define TI_XBAR_EDMA_OFFSET	0
 #define TI_XBAR_SDMA_OFFSET	1
 
-struct ti_dma_xbar_data {
+struct ti_dra7_xbar_data {
 	void __iomem *iomem;
 
 	struct dma_router dmarouter;
@@ -35,35 +206,35 @@ struct ti_dma_xbar_data {
 	u32 dma_offset;
 };
 
-struct ti_dma_xbar_map {
+struct ti_dra7_xbar_map {
 	u16 xbar_in;
 	int xbar_out;
 };
 
-static inline void ti_dma_xbar_write(void __iomem *iomem, int xbar, u16 val)
+static inline void ti_dra7_xbar_write(void __iomem *iomem, int xbar, u16 val)
 {
 	writew_relaxed(val, iomem + (xbar * 2));
 }
 
-static void ti_dma_xbar_free(struct device *dev, void *route_data)
+static void ti_dra7_xbar_free(struct device *dev, void *route_data)
 {
-	struct ti_dma_xbar_data *xbar = dev_get_drvdata(dev);
-	struct ti_dma_xbar_map *map = route_data;
+	struct ti_dra7_xbar_data *xbar = dev_get_drvdata(dev);
+	struct ti_dra7_xbar_map *map = route_data;
 
 	dev_dbg(dev, "Unmapping XBAR%u (was routed to %d)\n",
 		map->xbar_in, map->xbar_out);
 
-	ti_dma_xbar_write(xbar->iomem, map->xbar_out, xbar->safe_val);
+	ti_dra7_xbar_write(xbar->iomem, map->xbar_out, xbar->safe_val);
 	idr_remove(&xbar->map_idr, map->xbar_out);
 	kfree(map);
 }
 
-static void *ti_dma_xbar_route_allocate(struct of_phandle_args *dma_spec,
-					struct of_dma *ofdma)
+static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
+					 struct of_dma *ofdma)
 {
 	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
-	struct ti_dma_xbar_data *xbar = platform_get_drvdata(pdev);
-	struct ti_dma_xbar_map *map;
+	struct ti_dra7_xbar_data *xbar = platform_get_drvdata(pdev);
+	struct ti_dra7_xbar_map *map;
 
 	if (dma_spec->args[0] >= xbar->xbar_requests) {
 		dev_err(&pdev->dev, "Invalid XBAR request number: %d\n",
@@ -93,12 +264,12 @@ static void *ti_dma_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	dev_dbg(&pdev->dev, "Mapping XBAR%u to DMA%d\n",
 		map->xbar_in, map->xbar_out);
 
-	ti_dma_xbar_write(xbar->iomem, map->xbar_out, map->xbar_in);
+	ti_dra7_xbar_write(xbar->iomem, map->xbar_out, map->xbar_in);
 
 	return map;
 }
 
-static const struct of_device_id ti_dma_master_match[] = {
+static const struct of_device_id ti_dra7_master_match[] = {
 	{
 		.compatible = "ti,omap4430-sdma",
 		.data = (void *)TI_XBAR_SDMA_OFFSET,
@@ -110,12 +281,12 @@ static const struct of_device_id ti_dma_master_match[] = {
 	{},
 };
 
-static int ti_dma_xbar_probe(struct platform_device *pdev)
+static int ti_dra7_xbar_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	const struct of_device_id *match;
 	struct device_node *dma_node;
-	struct ti_dma_xbar_data *xbar;
+	struct ti_dra7_xbar_data *xbar;
 	struct resource *res;
 	u32 safe_val;
 	void __iomem *iomem;
@@ -136,7 +307,7 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	match = of_match_node(ti_dma_master_match, dma_node);
+	match = of_match_node(ti_dra7_master_match, dma_node);
 	if (!match) {
 		dev_err(&pdev->dev, "DMA master is not supported\n");
 		return -EINVAL;
@@ -146,16 +317,16 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 				 &xbar->dma_requests)) {
 		dev_info(&pdev->dev,
 			 "Missing XBAR output information, using %u.\n",
-			 TI_XBAR_OUTPUTS);
-		xbar->dma_requests = TI_XBAR_OUTPUTS;
+			 TI_DRA7_XBAR_OUTPUTS);
+		xbar->dma_requests = TI_DRA7_XBAR_OUTPUTS;
 	}
 	of_node_put(dma_node);
 
 	if (of_property_read_u32(node, "dma-requests", &xbar->xbar_requests)) {
 		dev_info(&pdev->dev,
 			 "Missing XBAR input information, using %u.\n",
-			 TI_XBAR_INPUTS);
-		xbar->xbar_requests = TI_XBAR_INPUTS;
+			 TI_DRA7_XBAR_INPUTS);
+		xbar->xbar_requests = TI_DRA7_XBAR_INPUTS;
 	}
 
 	if (!of_property_read_u32(node, "ti,dma-safe-map", &safe_val))
@@ -169,30 +340,50 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 	xbar->iomem = iomem;
 
 	xbar->dmarouter.dev = &pdev->dev;
-	xbar->dmarouter.route_free = ti_dma_xbar_free;
+	xbar->dmarouter.route_free = ti_dra7_xbar_free;
 	xbar->dma_offset = (u32)match->data;
 
 	platform_set_drvdata(pdev, xbar);
 
 	/* Reset the crossbar */
 	for (i = 0; i < xbar->dma_requests; i++)
-		ti_dma_xbar_write(xbar->iomem, i, xbar->safe_val);
+		ti_dra7_xbar_write(xbar->iomem, i, xbar->safe_val);
 
-	ret = of_dma_router_register(node, ti_dma_xbar_route_allocate,
+	ret = of_dma_router_register(node, ti_dra7_xbar_route_allocate,
 				     &xbar->dmarouter);
 	if (ret) {
 		/* Restore the defaults for the crossbar */
 		for (i = 0; i < xbar->dma_requests; i++)
-			ti_dma_xbar_write(xbar->iomem, i, i);
+			ti_dra7_xbar_write(xbar->iomem, i, i);
 	}
 
 	return ret;
 }
 
-static const struct of_device_id ti_dma_xbar_match[] = {
-	{ .compatible = "ti,dra7-dma-crossbar" },
-	{},
-};
+static int ti_dma_xbar_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	int ret;
+
+	match = of_match_node(ti_dma_xbar_match, pdev->dev.of_node);
+	if (unlikely(!match))
+		return -EINVAL;
+
+	switch ((u32)match->data) {
+	case TI_XBAR_DRA7:
+		ret = ti_dra7_xbar_probe(pdev);
+		break;
+	case TI_XBAR_AM335X:
+		ret = ti_am335x_xbar_probe(pdev);
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported crossbar\n");
+		ret = -ENODEV;
+		break;
+	}
+
+	return ret;
+}
 
 static struct platform_driver ti_dma_xbar_driver = {
 	.driver = {
-- 
2.6.1
