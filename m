From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 2/2] dmaengine: OMAP: Register SDMA controller with Device Tree DMA driver
Date: Tue, 26 Feb 2013 12:27:24 -0600
Message-ID: <1361903244-19837-3-git-send-email-jon-hunter@ti.com>
References: <1361903244-19837-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49627 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759729Ab3BZS1w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Feb 2013 13:27:52 -0500
In-Reply-To: <1361903244-19837-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

If the device-tree blob is present during boot, then register the SDMA
controller with the device-tree DMA driver so that we can use device-tree
to look-up DMA client information.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/dma.c |    4 ++++
 drivers/dma/omap-dma.c    |   38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index dab9fc0..49fd0d5 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
 #include <linux/omap-dma.h>
 
 #include "soc.h"
@@ -304,6 +305,9 @@ static int __init omap2_system_dma_init(void)
 	if (res)
 		return res;
 
+	if (of_have_populated_dt())
+		return res;
+
 	pdev = platform_device_register_full(&omap_dma_dev_info);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index c4b4fd2..2ea3d7e 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/of_dma.h>
+#include <linux/of_device.h>
 
 #include "virt-dma.h"
 
@@ -67,6 +69,10 @@ static const unsigned es_bytes[] = {
 	[OMAP_DMA_DATA_TYPE_S32] = 4,
 };
 
+static struct of_dma_filter_info omap_dma_info = {
+	.filter_fn = omap_dma_filter_fn,
+};
+
 static inline struct omap_dmadev *to_omap_dma_dev(struct dma_device *d)
 {
 	return container_of(d, struct omap_dmadev, ddev);
@@ -621,8 +627,22 @@ static int omap_dma_probe(struct platform_device *pdev)
 		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
 			rc);
 		omap_dma_free(od);
-	} else {
-		platform_set_drvdata(pdev, od);
+		return rc;
+	}
+
+	platform_set_drvdata(pdev, od);
+
+	if (pdev->dev.of_node) {
+		omap_dma_info.dma_cap = od->ddev.cap_mask;
+
+		/* Device-tree DMA controller registration */
+		rc = of_dma_controller_register(pdev->dev.of_node,
+				of_dma_simple_xlate, &omap_dma_info);
+		if (rc) {
+			pr_warn("OMAP-DMA: failed to register DMA controller\n");
+			dma_async_device_unregister(&od->ddev);
+			omap_dma_free(od);
+		}
 	}
 
 	dev_info(&pdev->dev, "OMAP DMA engine driver\n");
@@ -634,18 +654,32 @@ static int omap_dma_remove(struct platform_device *pdev)
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
+	{ .compatible = "ti,omap2420-sdma", },
+	{ .compatible = "ti,omap2430-sdma", },
+	{ .compatible = "ti,omap3430-sdma", },
+	{ .compatible = "ti,omap3630-sdma", },
+	{ .compatible = "ti,omap4430-sdma", },
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
+		.of_match_table = of_match_ptr(omap_dma_match),
 	},
 };
 
-- 
1.7.10.4

