From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: edma: Use early completion for intermediate paRAM set in slave_sg
Date: Tue, 7 Jun 2016 11:19:44 +0300
Message-ID: <20160607081944.21447-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

The driver limits the physical number of paRAM slots to be used by channels.
If the transfer needs more slots (more SGs) then the transfer is broken up
to smaller chunks. When the chunk is finished the driver will rewrite the
physical slots and continues the transfer. This set up time can take some
time and we might miss DMA events. If the intermediate set completion is
using early completion (the interrupt will happen when the last slot is
issued to the TPTC and not when the transfer is finished by the TPTC) we
will have a bit more time to update the paRAM slots and less likely to have
missed events.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 8181ed131386..7c76b558cf82 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1114,14 +1114,17 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 		edesc->absync = ret;
 		edesc->residue += sg_dma_len(sg);
 
-		/* If this is the last in a current SG set of transactions,
-		   enable interrupts so that next set is processed */
-		if (!((i+1) % MAX_NR_SG))
-			edesc->pset[i].param.opt |= TCINTEN;
-
-		/* If this is the last set, enable completion interrupt flag */
 		if (i == sg_len - 1)
+			/* Enable completion interrupt */
 			edesc->pset[i].param.opt |= TCINTEN;
+		else if (!((i+1) % MAX_NR_SG))
+			/*
+			 * Enable early completion interrupt for the
+			 * intermediateset. In this case the driver will be
+			 * notified when the paRAM set is submitted to TC. This
+			 * will allow more time to set up the next set of slots.
+			 */
+			edesc->pset[i].param.opt |= (TCINTEN | TCCMODE);
 	}
 	edesc->residue_stat = edesc->residue;
 
-- 
2.8.3
