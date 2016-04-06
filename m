From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RESEND 2/2] dmaengine: edma: special case slot limit workaround
Date: Wed, 6 Apr 2016 13:01:47 +0300
Message-ID: <1459936907-23920-3-git-send-email-peter.ujfalusi@ti.com>
References: <1459936907-23920-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1459936907-23920-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: john.ogness@linutronix.de, tony@atomide.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

Currently drivers are limited to 19 slots for cyclic transfers.
However, if the DMA burst size is the same as the period size,
the period size can be changed to the full buffer size and
intermediate interrupts activated. Since intermediate interrupts
will trigger for each burst and the burst size is the same as
the period size, the driver will get interrupts each period as
expected. This has the benefit of allowing the functionality of
many more slots, but only uses 2 slots.

This workaround is only active if more than 19 slots are needed
and the burst size matches the period size.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/dma/edma.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 13b6a23dc06b..04070baab78a 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1238,6 +1238,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	struct edma_desc *edesc;
 	dma_addr_t src_addr, dst_addr;
 	enum dma_slave_buswidth dev_width;
+	bool use_intermediate = false;
 	u32 burst;
 	int i, ret, nslots;
 
@@ -1279,8 +1280,21 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	 * but the synchronization is difficult to achieve with Cyclic and
 	 * cannot be guaranteed, so we error out early.
 	 */
-	if (nslots > MAX_NR_SG)
-		return NULL;
+	if (nslots > MAX_NR_SG) {
+		/*
+		 * If the burst and period sizes are the same, we can put
+		 * the full buffer into a single period and activate
+		 * intermediate interrupts. This will produce interrupts
+		 * after each burst, which is also after each desired period.
+		 */
+		if (burst == period_len) {
+			period_len = buf_len;
+			nslots = 2;
+			use_intermediate = true;
+		} else {
+			return NULL;
+		}
+	}
 
 	edesc = kzalloc(sizeof(*edesc) + nslots * sizeof(edesc->pset[0]),
 			GFP_ATOMIC);
@@ -1358,8 +1372,13 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		/*
 		 * Enable period interrupt only if it is requested
 		 */
-		if (tx_flags & DMA_PREP_INTERRUPT)
+		if (tx_flags & DMA_PREP_INTERRUPT) {
 			edesc->pset[i].param.opt |= TCINTEN;
+
+			/* Also enable intermediate interrupts if necessary */
+			if (use_intermediate)
+				edesc->pset[i].param.opt |= ITCINTEN;
+		}
 	}
 
 	/* Place the cyclic channel to highest priority queue */
-- 
2.8.0
