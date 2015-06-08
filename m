From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] dmaengine: ti-dma-crossbar: Make idr xbar instance-specific
Date: Mon, 8 Jun 2015 16:22:41 +0300
Message-ID: <1433769762-31827-2-git-send-email-peter.ujfalusi@ti.com>
References: <1433769762-31827-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433769762-31827-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

In preparation for supporting multiple DMA crossbar instances,
make the idr xbar instance specific.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti-dma-crossbar.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 24f5ca2356bf..1fd3fb73d6e8 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -20,12 +20,11 @@
 #define TI_XBAR_OUTPUTS	127
 #define TI_XBAR_INPUTS	256
 
-static DEFINE_IDR(map_idr);
-
 struct ti_dma_xbar_data {
 	void __iomem *iomem;
 
 	struct dma_router dmarouter;
+	struct idr map_idr;
 
 	u16 safe_val; /* Value to rest the crossbar lines */
 	u32 xbar_requests; /* number of DMA requests connected to XBAR */
@@ -51,7 +50,7 @@ static void ti_dma_xbar_free(struct device *dev, void *route_data)
 		map->xbar_in, map->xbar_out);
 
 	ti_dma_xbar_write(xbar->iomem, map->xbar_out, xbar->safe_val);
-	idr_remove(&map_idr, map->xbar_out);
+	idr_remove(&xbar->map_idr, map->xbar_out);
 	kfree(map);
 }
 
@@ -81,7 +80,7 @@ static void *ti_dma_xbar_route_allocate(struct of_phandle_args *dma_spec,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	map->xbar_out = idr_alloc(&map_idr, NULL, 0, xbar->dma_requests,
+	map->xbar_out = idr_alloc(&xbar->map_idr, NULL, 0, xbar->dma_requests,
 				  GFP_KERNEL);
 	map->xbar_in = (u16)dma_spec->args[0];
 
@@ -113,6 +112,8 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 	if (!xbar)
 		return -ENOMEM;
 
+	idr_init(&xbar->map_idr);
+
 	dma_node = of_parse_phandle(node, "dma-masters", 0);
 	if (!dma_node) {
 		dev_err(&pdev->dev, "Can't get DMA master node\n");
-- 
2.4.2
