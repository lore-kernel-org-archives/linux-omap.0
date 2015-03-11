From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/7] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Wed, 11 Mar 2015 15:23:26 +0200
Message-ID: <1426080210-841-4-git-send-email-peter.ujfalusi@ti.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46226 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbbCKNYZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2015 09:24:25 -0400
In-Reply-To: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com

The DRA7x has more peripherals with DMA requests than the sDMA can handle:
205 vs 127. All DMA requests are routed through the DMA crossbar, which can
be configured to route selected incoming DMA requests to specific sDMA
request.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/Kconfig           |   4 +
 drivers/dma/Makefile          |   1 +
 drivers/dma/ti-dma-crossbar.c | 190 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/dma/ti-dma-crossbar.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 074ffad334a7..519657a37ca1 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -247,6 +247,9 @@ config TI_EDMA
 	  Enable support for the TI EDMA controller. This DMA
 	  engine is found on TI DaVinci and AM33xx parts.
 
+config TI_DMA_CROSSBAR
+	bool
+
 config ARCH_HAS_ASYNC_TX_FIND_CHANNEL
 	bool
 
@@ -332,6 +335,7 @@ config DMA_OMAP
 	depends on ARCH_OMAP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
+	select TI_DMA_CROSSBAR if SOC_DRA7XX
 
 config DMA_BCM2835
 	tristate "BCM2835 DMA engine support"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index bf4485800c60..6ec7af6a416c 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
 obj-$(CONFIG_MMP_TDMA) += mmp_tdma.o
 obj-$(CONFIG_DMA_OMAP) += omap-dma.o
+obj-$(CONFIG_TI_DMA_CROSSBAR) += ti-dma-crossbar.o
 obj-$(CONFIG_DMA_BCM2835) += bcm2835-dma.o
 obj-$(CONFIG_MMP_PDMA) += mmp_pdma.o
 obj-$(CONFIG_DMA_JZ4740) += dma-jz4740.o
diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
new file mode 100644
index 000000000000..591307bd4370
--- /dev/null
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -0,0 +1,190 @@
+/*
+ *  Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/idr.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+
+#define TI_XBAR_OUTPUTS	127
+#define TI_XBAR_INPUTS	256
+
+static DEFINE_IDR(map_idr);
+
+struct ti_dma_xbar_data {
+	struct dma_router dmarouter;
+	struct regmap *regmap;
+
+	uint safe_val; /* Value to rest the crossbar lines */
+	uint xbar_requests; /* number of DMA requests connected to XBAR */
+	uint dma_requests; /* number of DMA requests forwarded to DMA */
+
+	void __iomem *iomem;
+};
+
+struct ti_dma_xbar_map {
+	int xbar_in;
+	int xbar_out;
+};
+
+static void ti_dma_xbar_free(struct device *dev, void *route_data)
+{
+	struct ti_dma_xbar_data *xbar = dev_get_drvdata(dev);
+	struct ti_dma_xbar_map *map = route_data;
+
+	dev_dbg(dev, "Unmapping XBAR%d (was routed to %d)\n",
+		map->xbar_in, map->xbar_out);
+
+	regmap_write(xbar->regmap, map->xbar_out * 2, 0);
+	idr_remove(&map_idr, map->xbar_out);
+	kfree(map);
+}
+
+static void *ti_dma_xbar_route_allocate(struct of_phandle_args *dma_spec,
+					struct of_dma *ofdma)
+{
+	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
+	struct ti_dma_xbar_data *xbar = platform_get_drvdata(pdev);
+	struct ti_dma_xbar_map *map;
+
+	if (dma_spec->args[0] >= xbar->xbar_requests) {
+		dev_err(&pdev->dev, "Invalid XBAR request number: %d\n",
+			dma_spec->args[0]);
+		return NULL;
+	}
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return NULL;
+
+	map->xbar_out = idr_alloc(&map_idr, NULL, 0, xbar->dma_requests,
+				  GFP_KERNEL);
+	map->xbar_in = dma_spec->args[0];
+
+	/* The DMA request is 1 based in sDMA */
+	dma_spec->args[0] = map->xbar_out + 1;
+
+	dev_dbg(&pdev->dev, "Mapping XBAR%d to DMA%d\n",
+		map->xbar_in, map->xbar_out);
+
+	regmap_write(xbar->regmap, map->xbar_out * 2, map->xbar_in);
+
+	return map;
+}
+
+static const struct regmap_config ti_dma_xbar_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.max_register = 0xfc,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int ti_dma_xbar_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *dma_node;
+	struct ti_dma_xbar_data *xbar;
+	struct resource *res;
+	void __iomem *iomem;
+	int i, ret;
+
+	if (!node)
+		return -ENODEV;
+
+	dma_node = of_parse_phandle(node, "dma-device", 0);
+	if (!dma_node) {
+		dev_err(&pdev->dev, "Can't get target DMA node\n");
+		return -ENODEV;
+	}
+
+	xbar = devm_kzalloc(&pdev->dev, sizeof(*xbar), GFP_KERNEL);
+	if (!xbar)
+		return -ENOMEM;
+
+	if (of_property_read_u32(dma_node, "dma-requests",
+				 &xbar->dma_requests)) {
+		dev_info(&pdev->dev,
+			 "Missing XBAR output information, using %u.\n",
+			 TI_XBAR_OUTPUTS);
+		xbar->dma_requests = TI_XBAR_OUTPUTS;
+	}
+	of_node_put(dma_node);
+
+	if (of_property_read_u32(node, "dma-requests", &xbar->xbar_requests)) {
+		dev_info(&pdev->dev,
+			 "Missing XBAR input information, using %u.\n",
+			 TI_XBAR_INPUTS);
+		xbar->xbar_requests = TI_XBAR_INPUTS;
+	}
+
+	if (of_property_read_u32(node, "ti,dma-safe-map", &xbar->safe_val))
+		xbar->safe_val = 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
+				     dev_name(&pdev->dev)))
+		return -ENODEV;
+
+	iomem = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!iomem)
+		return -ENOMEM;
+
+	xbar->regmap = devm_regmap_init_mmio(&pdev->dev, iomem,
+					    &ti_dma_xbar_regmap_config);
+	if (IS_ERR(xbar->regmap)) {
+		dev_err(&pdev->dev, "regmap init failed\n");
+		return PTR_ERR(xbar->regmap);
+	}
+	xbar->iomem = iomem;
+
+	xbar->dmarouter.dev = &pdev->dev;
+	xbar->dmarouter.route_free = ti_dma_xbar_free;
+
+	platform_set_drvdata(pdev, xbar);
+
+	ret = of_dma_router_register(node, ti_dma_xbar_route_allocate,
+				     &xbar->dmarouter);
+	if (ret)
+		return -ENODEV;
+
+	/* Reset the crossbar */
+	for (i = 0; i < xbar->dma_requests; i++)
+		regmap_write(xbar->regmap, i * 2, xbar->safe_val);
+
+	return 0;
+}
+
+static const struct of_device_id ti_dma_xbar_match[] = {
+	{ .compatible = "ti,dra7-dma-crossbar" },
+	{},
+};
+
+static struct platform_driver ti_dma_xbar_driver = {
+	.driver = {
+		.name = "ti-dma-crossbar",
+		.of_match_table = of_match_ptr(ti_dma_xbar_match),
+	},
+	.probe	= ti_dma_xbar_probe,
+};
+
+int omap_dmaxbar_init(void)
+{
+	return platform_driver_register(&ti_dma_xbar_driver);
+}
+arch_initcall(omap_dmaxbar_init);
-- 
2.3.0

