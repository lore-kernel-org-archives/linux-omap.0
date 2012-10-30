From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/2] ARM: OMAP: omap_device: Correct resource handling for DT boot
Date: Tue, 30 Oct 2012 12:24:56 +0100
Message-ID: <1351596296-13825-3-git-send-email-peter.ujfalusi@ti.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38217 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932708Ab2J3LZF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 07:25:05 -0400
In-Reply-To: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

When booting with DT the OF core can fill up the resources provided within
the DT blob.
The current way of handling the DT boot prevents us from removing hwmod data
for platforms only suppose to boot with DT (OMAP5 for example) since we need
to keep the whole hwmod database intact in order to have more resources in
hwmod than in DT (to be able to append the DMA resource from hwmod).

To fix this issue we just examine the OF provided resources:
If we do not have resources we use hwmod to fill them.
If we have resources we check if we already able to recive DMA resource, if
no we only append the DMA resurce from hwmod to the OF provided ones.

In this way we can start removing hwmod data for devices which have their
resources correctly configured in DT without regressions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/plat-omap/omap_device.c | 84 ++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 915cf68..d35b468 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -560,55 +560,73 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
 	od->hwmods = hwmods;
 	od->pdev = pdev;
 
-	/* Count all resources for the device */
-	res_count = omap_device_count_resources(od, IORESOURCE_IRQ |
-						    IORESOURCE_DMA |
-						    IORESOURCE_MEM);
 	/*
+	 * Non-DT Boot:
+	 *   Here, pdev->num_resources = 0, and we should get all the
+	 *   resources from hwmod.
+	 *
 	 * DT Boot:
 	 *   OF framework will construct the resource structure (currently
 	 *   does for MEM & IRQ resource) and we should respect/use these
 	 *   resources, killing hwmod dependency.
 	 *   If pdev->num_resources > 0, we assume that MEM & IRQ resources
 	 *   have been allocated by OF layer already (through DTB).
-	 *
-	 * Non-DT Boot:
-	 *   Here, pdev->num_resources = 0, and we should get all the
-	 *   resources from hwmod.
+	 *   As preparation for the future we examine the OF provided resources
+	 *   to see if we have DMA resources provided already. In this case
+	 *   there is no need to update the resources for the device, we use the
+	 *   OF provided ones.
 	 *
 	 * TODO: Once DMA resource is available from OF layer, we should
 	 *   kill filling any resources from hwmod.
 	 */
-	if (res_count > pdev->num_resources) {
-		/* Allocate resources memory to account for new resources */
-		res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
-		if (!res)
-			goto oda_exit3;
-
-		/*
-		 * If pdev->num_resources > 0, then assume that,
-		 * MEM and IRQ resources will only come from DT and only
-		 * fill DMA resource from hwmod layer.
-		 */
-		if (pdev->num_resources && pdev->resource) {
-			dev_dbg(&pdev->dev, "%s(): resources already allocated %d\n",
-				__func__, res_count);
-			memcpy(res, pdev->resource,
-			       sizeof(struct resource) * pdev->num_resources);
-			_od_fill_dma_resources(od, &res[pdev->num_resources]);
-		} else {
-			dev_dbg(&pdev->dev, "%s(): using resources from hwmod %d\n",
-				__func__, res_count);
-			omap_device_fill_resources(od, res);
+	if (!pdev->num_resources) {
+		/* Count all resources for the device */
+		res_count = omap_device_count_resources(od, IORESOURCE_IRQ |
+							    IORESOURCE_DMA |
+							    IORESOURCE_MEM);
+	} else {
+		/* Take a look if we already have DMA resource via DT */
+		for (i = 0; i < pdev->num_resources; i++) {
+			struct resource *r = &pdev->resource[i];
+
+			/* We have it, no need to touch the resources */
+			if (r->flags == IORESOURCE_DMA)
+				goto have_everything;
 		}
+		/* Count only DMA resources for the device */
+		res_count = omap_device_count_resources(od, IORESOURCE_DMA);
+		/* The device has no DMA resource, no need for update */
+		if (!res_count)
+			goto have_everything;
+	
+		res_count += pdev->num_resources;
+	}
 
-		ret = platform_device_add_resources(pdev, res, res_count);
-		kfree(res);
+	/* Allocate resources memory to account for new resources */
+	res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
+	if (!res)
+		goto oda_exit3;
 
-		if (ret)
-			goto oda_exit3;
+	if (!pdev->num_resources) {
+		dev_dbg(&pdev->dev, "%s: using %d resources from hwmod\n",
+			__func__, res_count);
+		omap_device_fill_resources(od, res);
+	} else {
+		dev_dbg(&pdev->dev,
+			"%s: appending %d DMA resources from hwmod\n",
+			__func__, res_count - pdev->num_resources);
+		memcpy(res, pdev->resource,
+		       sizeof(struct resource) * pdev->num_resources);
+		_od_fill_dma_resources(od, &res[pdev->num_resources]);
 	}
 
+	ret = platform_device_add_resources(pdev, res, res_count);
+	kfree(res);
+
+	if (ret)
+		goto oda_exit3;
+
+have_everything:
 	if (!pm_lats) {
 		pm_lats = omap_default_latency;
 		pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
-- 
1.7.12.4

