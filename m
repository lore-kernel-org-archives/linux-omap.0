From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2 2/2] dmaengine: OMAP: Register SDMA controller with Device
 Tree DMA driver
Date: Thu, 7 Feb 2013 19:05:06 -0600
Message-ID: <1360285506-22354-3-git-send-email-jon-hunter@ti.com>
References: <1360285506-22354-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1360285506-22354-1-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

If the device-tree blob is present during boot, then register the SDMA
controller with the device-tree DMA driver so that we can use device-tree
to look-up DMA client information.

Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/dma.c |    4 ++++
 drivers/dma/omap-dma.c    |   37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 5cd8d76..71dadff 100644
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
index c4b4fd2..0067bd0 100644
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
@@ -621,8 +625,23 @@ static int omap_dma_probe(struct platform_device *pdev)
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
 	}
 
 	dev_info(&pdev->dev, "OMAP DMA engine driver\n");
@@ -634,18 +653,32 @@ static int omap_dma_remove(struct platform_device *pdev)
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
