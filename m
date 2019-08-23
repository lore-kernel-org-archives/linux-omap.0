From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/5] dmaengine: ti: edma: Do not reset reserved paRAM slots
Date: Fri, 23 Aug 2019 15:56:14 +0300
Message-ID: <20190823125618.8133-2-peter.ujfalusi@ti.com>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190823125618.8133-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, robh+dt@kernel.org
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Skip resetting paRAM slots marked as reserved as they might be used by
other cores.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 54895112ba59..1aae95cc0d4b 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2338,9 +2338,6 @@ static int edma_probe(struct platform_device *pdev)
 
 	ecc->default_queue = info->default_queue;
 
-	for (i = 0; i < ecc->num_slots; i++)
-		edma_write_slot(ecc, i, &dummy_paramset);
-
 	if (info->rsv) {
 		/* Set the reserved slots in inuse list */
 		rsv_slots = info->rsv->rsv_slots;
@@ -2353,6 +2350,12 @@ static int edma_probe(struct platform_device *pdev)
 		}
 	}
 
+	for (i = 0; i < ecc->num_slots; i++) {
+		/* Reset only unused - not reserved - paRAM slots */
+		if (!test_bit(i, ecc->slot_inuse))
+			edma_write_slot(ecc, i, &dummy_paramset);
+	}
+
 	/* Clear the xbar mapped channels in unused list */
 	xbar_chans = info->xbar_chans;
 	if (xbar_chans) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
