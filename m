From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] dmaengine: edma: re-initialize dummy slot during system resume
Date: Wed, 23 Nov 2016 14:57:55 +0530
Message-ID: <20161123092755.8522-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

The last param set in a transfer should always be pointing to dummy
param set in non-cyclic mode. When system wakes from low power state
EDMA PARAM slots may be reset to random values. Hence, re-initialize
dummy slot to dummy param set on system resume.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 77242b37ef87..3879f80a4815 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2451,6 +2451,9 @@ static int edma_pm_resume(struct device *dev)
 	int i;
 	s8 (*queue_priority_mapping)[2];
 
+	/* re initialize dummy slot to dummy param set */
+	edma_write_slot(ecc, ecc->dummy_slot, &dummy_paramset);
+
 	queue_priority_mapping = ecc->info->queue_priority_mapping;
 
 	/* Event queue priority mapping */
-- 
2.10.2
