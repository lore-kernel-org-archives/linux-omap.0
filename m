From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/5] dmaengine: ti: edma: Only reset region0 access registers
Date: Fri, 23 Aug 2019 15:56:15 +0300
Message-ID: <20190823125618.8133-3-peter.ujfalusi@ti.com>
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

Region0 is used by Linux, do not reset other registers controlling access
for other shadow regions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 1aae95cc0d4b..87450431f336 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2434,11 +2434,10 @@ static int edma_probe(struct platform_device *pdev)
 		edma_assign_priority_to_queue(ecc, queue_priority_mapping[i][0],
 					      queue_priority_mapping[i][1]);
 
-	for (i = 0; i < ecc->num_region; i++) {
-		edma_write_array2(ecc, EDMA_DRAE, i, 0, 0x0);
-		edma_write_array2(ecc, EDMA_DRAE, i, 1, 0x0);
-		edma_write_array(ecc, EDMA_QRAE, i, 0x0);
-	}
+	edma_write_array2(ecc, EDMA_DRAE, 0, 0, 0x0);
+	edma_write_array2(ecc, EDMA_DRAE, 0, 1, 0x0);
+	edma_write_array(ecc, EDMA_QRAE, 0, 0x0);
+
 	ecc->info = info;
 
 	/* Init the dma device and channels */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
