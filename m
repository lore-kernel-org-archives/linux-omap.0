From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 05/21] ARM/dmaengine: edma: Move of_dma_controller_register to
 the dmaengine driver
Date: Thu, 10 Sep 2015 11:37:34 +0300
Message-ID: <1441874270-2399-6-git-send-email-peter.ujfalusi@ti.com>
References: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If the of_dma_controller is registered in the non dmaengine driver we could
have race condition:
the of_dma_controller has been registered, but the dmaengine driver is not
yet probed. Drivers requesting DMA channels during this window will fail
since we do not yet have dmaengine drivers registered.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c | 10 ----------
 drivers/dma/edma.c     | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 72fce68a959f..dc960de1a95f 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -29,7 +29,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_dma.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
 
@@ -1191,10 +1190,6 @@ static int edma_of_parse_dt(struct device *dev,
 	return ret;
 }
 
-static struct of_dma_filter_info edma_filter_info = {
-	.filter_fn = edma_filter_fn,
-};
-
 static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 						      struct device_node *node)
 {
@@ -1209,11 +1204,6 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	dma_cap_set(DMA_SLAVE, edma_filter_info.dma_cap);
-	dma_cap_set(DMA_CYCLIC, edma_filter_info.dma_cap);
-	of_dma_controller_register(dev->of_node, of_dma_simple_xlate,
-				   &edma_filter_info);
-
 	return info;
 }
 #else
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 19fa49d6f555..fcb4680efed7 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
+#include <linux/of_dma.h>
 
 #include <linux/platform_data/edma.h>
 
@@ -987,9 +988,14 @@ static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 	INIT_LIST_HEAD(&dma->channels);
 }
 
+static struct of_dma_filter_info edma_filter_info = {
+	.filter_fn = edma_filter_fn,
+};
+
 static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_cc *ecc;
+	struct device_node *parent_node = pdev->dev.parent->of_node;
 	int ret;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -1024,6 +1030,13 @@ static int edma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ecc);
 
+	if (parent_node) {
+		dma_cap_set(DMA_SLAVE, edma_filter_info.dma_cap);
+		dma_cap_set(DMA_CYCLIC, edma_filter_info.dma_cap);
+		of_dma_controller_register(parent_node, of_dma_simple_xlate,
+					   &edma_filter_info);
+	}
+
 	dev_info(&pdev->dev, "TI EDMA DMA engine driver\n");
 
 	return 0;
@@ -1037,7 +1050,10 @@ static int edma_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct edma_cc *ecc = dev_get_drvdata(dev);
+	struct device_node *parent_node = pdev->dev.parent->of_node;
 
+	if (parent_node)
+		of_dma_controller_free(parent_node);
 	dma_async_device_unregister(&ecc->dma_slave);
 	edma_free_slot(ecc->dummy_slot);
 
-- 
2.5.1
