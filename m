From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with Device Tree DMA driver
Date: Wed, 6 Feb 2013 15:03:16 -0600
Message-ID: <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54424 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757864Ab3BFVDz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 16:03:55 -0500
In-Reply-To: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Matt Porter <mporter@ti.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Balaji T K <balajitk@ti.com>, Jon Hunter <jon-hunter@ti.com>

If the device-tree blob is present during boot, then register the SDMA
controller with the device-tree DMA driver so that we can use device-tree
to look-up DMA client information.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/dma/omap-dma.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 5a31264..a32d81b 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/of_dma.h>
+#include <linux/of_device.h>
 
 #include "virt-dma.h"
 
@@ -67,6 +69,8 @@ static const unsigned es_bytes[] = {
 	[OMAP_DMA_DATA_TYPE_S32] = 4,
 };
 
+static struct of_dma_filter_info info;
+
 static inline struct omap_dmadev *to_omap_dma_dev(struct dma_device *d)
 {
 	return container_of(d, struct omap_dmadev, ddev);
@@ -621,10 +625,25 @@ static int omap_dma_probe(struct platform_device *pdev)
 		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
 			rc);
 		omap_dma_free(od);
+		return rc;
 	} else {
 		platform_set_drvdata(pdev, od);
 	}
 
+	if (pdev->dev.of_node) {
+		info.dma_cap = od->ddev.cap_mask;
+		info.filter_fn = omap_dma_filter_fn;
+
+		/* Device-tree DMA controller registration */
+		rc = of_dma_controller_register(pdev->dev.of_node,
+				of_dma_simple_xlate, &info);
+		if (rc) {
+			pr_warn("OMAP-DMA: failed to register DMA controller\n");
+			dma_async_device_unregister(&od->ddev);
+			omap_dma_free(od);
+		}
+	}
+
 	dev_info(&pdev->dev, "OMAP DMA engine driver\n");
 
 	return rc;
@@ -634,18 +653,28 @@ static int omap_dma_remove(struct platform_device *pdev)
 {
 	struct omap_dmadev *od = platform_get_drvdata(pdev);
 
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
+
 	dma_async_device_unregister(&od->ddev);
 	omap_dma_free(od);
 
 	return 0;
 }
 
+static const struct of_device_id omap_dma_match[] = {
+	{ .compatible = "ti,omap-sdma", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_dma_match);
+
 static struct platform_driver omap_dma_driver = {
 	.probe	= omap_dma_probe,
 	.remove	= omap_dma_remove,
 	.driver = {
 		.name = "omap-dma-engine",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(omap_dma_match)
 	},
 };
 
@@ -673,7 +702,7 @@ static int omap_dma_init(void)
 {
 	int rc = platform_driver_register(&omap_dma_driver);
 
-	if (rc == 0) {
+	if ((rc == 0) && (!of_have_populated_dt())) {
 		pdev = platform_device_register_full(&omap_dma_dev_info);
 		if (IS_ERR(pdev)) {
 			platform_driver_unregister(&omap_dma_driver);
-- 
1.7.10.4

