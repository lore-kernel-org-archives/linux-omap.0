From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 5/8] dmaengine: omap-dma: Take DMA request number from DT if it is available
Date: Thu, 9 Apr 2015 12:35:51 +0300
Message-ID: <1428572154-3548-6-git-send-email-peter.ujfalusi@ti.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46415 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964969AbbDIJg6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Apr 2015 05:36:58 -0400
In-Reply-To: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de, maxime.ripard@free-electrons.com

Use the dma-requests property from DT to get the number of DMA requests.
In case of legacy boot or failure to find the property, use the default
127 as number of requests.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 4065963fbffb..211c9c1edf08 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -34,6 +34,7 @@ struct omap_dmadev {
 	const struct omap_dma_reg *reg_map;
 	struct omap_system_dma_plat_info *plat;
 	bool legacy;
+	unsigned dma_requests;
 	spinlock_t irq_lock;
 	uint32_t irq_enable_mask;
 	struct omap_chan *lch_map[OMAP_SDMA_CHANNELS];
@@ -1119,7 +1120,16 @@ static int omap_dma_probe(struct platform_device *pdev)
 
 	tasklet_init(&od->task, omap_dma_sched, (unsigned long)od);
 
-	for (i = 0; i < OMAP_SDMA_REQUESTS; i++) {
+	od->dma_requests = OMAP_SDMA_REQUESTS;
+	if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
+						      "dma-requests",
+						      &od->dma_requests)) {
+		dev_info(&pdev->dev,
+			 "Missing dma-requests property, using %u.\n",
+			 OMAP_SDMA_REQUESTS);
+	}
+
+	for (i = 0; i < od->dma_requests; i++) {
 		rc = omap_dma_chan_init(od, i);
 		if (rc) {
 			omap_dma_free(od);
-- 
2.3.5

