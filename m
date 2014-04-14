From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 08/10] dmaengine: edma: Prefix debug prints where the text
 were identical in prep callbacks
Date: Mon, 14 Apr 2014 14:42:03 +0300
Message-ID: <1397475725-5036-9-git-send-email-peter.ujfalusi@ti.com>
References: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dan.j.williams@intel.com, vinod.koul@intel.com, nsekhar@ti.com, joelf@ti.com
Cc: dmaengine@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

prep_slave_sg and prep_dma_cyclic callbacks have mostly same failure cases
with the same texts printed in case we hit them. It helps when debugging if
we know exactly which callback generated the errors.
At the same time change the debug level for descriptor allocation failure
from dbg to err since all other error cases are dev_err and this failure is
similarly fatal as the other ones.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 6d9edc47150d..bc8175c92e0c 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -436,14 +436,14 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 	}
 
 	if (dev_width == DMA_SLAVE_BUSWIDTH_UNDEFINED) {
-		dev_err(dev, "Undefined slave buswidth\n");
+		dev_err(dev, "%s: Undefined slave buswidth\n", __func__);
 		return NULL;
 	}
 
 	edesc = kzalloc(sizeof(*edesc) + sg_len *
 		sizeof(edesc->pset[0]), GFP_ATOMIC);
 	if (!edesc) {
-		dev_dbg(dev, "Failed to allocate a descriptor\n");
+		dev_err(dev, "%s: Failed to allocate a descriptor\n", __func__);
 		return NULL;
 	}
 
@@ -459,7 +459,8 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 						EDMA_SLOT_ANY);
 			if (echan->slot[i] < 0) {
 				kfree(edesc);
-				dev_err(dev, "Failed to allocate slot\n");
+				dev_err(dev, "%s: Failed to allocate slot\n",
+					__func__);
 				return NULL;
 			}
 		}
@@ -528,7 +529,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	}
 
 	if (dev_width == DMA_SLAVE_BUSWIDTH_UNDEFINED) {
-		dev_err(dev, "Undefined slave buswidth\n");
+		dev_err(dev, "%s: Undefined slave buswidth\n", __func__);
 		return NULL;
 	}
 
@@ -553,7 +554,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	edesc = kzalloc(sizeof(*edesc) + nslots *
 		sizeof(edesc->pset[0]), GFP_ATOMIC);
 	if (!edesc) {
-		dev_dbg(dev, "Failed to allocate a descriptor\n");
+		dev_err(dev, "%s: Failed to allocate a descriptor\n", __func__);
 		return NULL;
 	}
 
@@ -571,7 +572,8 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 						EDMA_SLOT_ANY);
 			if (echan->slot[i] < 0) {
 				kfree(edesc);
-				dev_err(dev, "Failed to allocate slot\n");
+				dev_err(dev, "%s: Failed to allocate slot\n",
+					__func__);
 				return NULL;
 			}
 		}
-- 
1.9.2
