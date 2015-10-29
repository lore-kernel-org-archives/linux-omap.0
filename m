From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] dmaengine: ti-dma-crossbar: dra7: Use bitops instead of
 idr
Date: Thu, 29 Oct 2015 10:28:49 +0200
Message-ID: <1446107331-30041-2-git-send-email-peter.ujfalusi@ti.com>
References: <1446107331-30041-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446107331-30041-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The use of idr was nice, but it was a bit heavy and we did not need the
features it provides. Using simple bitmap to track allocated DMA channels
is adequate here and it will be easier to add support for reserving
channels later on.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti-dma-crossbar.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index a415edbe61b1..5fe1909d4ec4 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
-#include <linux/idr.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
@@ -198,7 +197,8 @@ struct ti_dra7_xbar_data {
 	void __iomem *iomem;
 
 	struct dma_router dmarouter;
-	struct idr map_idr;
+	struct mutex mutex;
+	unsigned long *dma_inuse;
 
 	u16 safe_val; /* Value to rest the crossbar lines */
 	u32 xbar_requests; /* number of DMA requests connected to XBAR */
@@ -225,7 +225,9 @@ static void ti_dra7_xbar_free(struct device *dev, void *route_data)
 		map->xbar_in, map->xbar_out);
 
 	ti_dra7_xbar_write(xbar->iomem, map->xbar_out, xbar->safe_val);
-	idr_remove(&xbar->map_idr, map->xbar_out);
+	mutex_lock(&xbar->mutex);
+	clear_bit(map->xbar_out, xbar->dma_inuse);
+	mutex_unlock(&xbar->mutex);
 	kfree(map);
 }
 
@@ -255,8 +257,17 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	map->xbar_out = idr_alloc(&xbar->map_idr, NULL, 0, xbar->dma_requests,
-				  GFP_KERNEL);
+	mutex_lock(&xbar->mutex);
+	map->xbar_out = find_next_zero_bit(xbar->dma_inuse, xbar->dma_requests,
+					   0);
+	mutex_unlock(&xbar->mutex);
+	if (map->xbar_out) {
+		dev_err(&pdev->dev, "Run out of free DMA requests\n");
+		kfree(map);
+		return ERR_PTR(-ENOMEM);
+	}
+	set_bit(map->xbar_out, xbar->dma_inuse);
+
 	map->xbar_in = (u16)dma_spec->args[0];
 
 	dma_spec->args[0] = map->xbar_out + xbar->dma_offset;
@@ -299,8 +310,6 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 	if (!xbar)
 		return -ENOMEM;
 
-	idr_init(&xbar->map_idr);
-
 	dma_node = of_parse_phandle(node, "dma-masters", 0);
 	if (!dma_node) {
 		dev_err(&pdev->dev, "Can't get DMA master node\n");
@@ -322,6 +331,12 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 	}
 	of_node_put(dma_node);
 
+	xbar->dma_inuse = devm_kcalloc(&pdev->dev,
+				       BITS_TO_LONGS(xbar->dma_requests),
+				       sizeof(unsigned long), GFP_KERNEL);
+	if (!xbar->dma_inuse)
+		return -ENOMEM;
+
 	if (of_property_read_u32(node, "dma-requests", &xbar->xbar_requests)) {
 		dev_info(&pdev->dev,
 			 "Missing XBAR input information, using %u.\n",
@@ -343,6 +358,7 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 	xbar->dmarouter.route_free = ti_dra7_xbar_free;
 	xbar->dma_offset = (u32)match->data;
 
+	mutex_init(&xbar->mutex);
 	platform_set_drvdata(pdev, xbar);
 
 	/* Reset the crossbar */
-- 
2.6.1
