From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 2/3] dmaengine: ti: edma: Correct the residue calculation
 (fix for memcpy)
Date: Tue, 16 Jul 2019 11:26:54 +0300
Message-ID: <20190716082655.1620-3-peter.ujfalusi@ti.com>
References: <20190716082655.1620-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190716082655.1620-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

For memcpy we never stored the start address of the transfer for the pset
which rendered the memcpy residue calculation completely broken.

In the edma_residue() function we also need to to some correction for the
calculations:
Instead waiting for all EDMA channels to be idle (in a busy system it can
take few iteration to hit a point when all queues are idle) wait for the
event pending on the given channel (SH_ER for hw synchronized channels,
SH_ESR for manually triggered channels).

If the position returned by EMDA is 0 it imiplies that the last paRAM set
has been consumed and we are at the closing dummy set, thus we can conclude
that the transfer is completed and we can return 0 as residue.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index a39f817b3888..5b8cbd6d7610 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -1026,6 +1026,7 @@ static int edma_config_pset(struct dma_chan *chan, struct edma_pset *epset,
 		src_cidx = cidx;
 		dst_bidx = acnt;
 		dst_cidx = cidx;
+		epset->addr = src_addr;
 	} else {
 		dev_err(dev, "%s: direction not implemented yet\n", __func__);
 		return -EINVAL;
@@ -1736,7 +1737,11 @@ static u32 edma_residue(struct edma_desc *edesc)
 	int loop_count = EDMA_MAX_TR_WAIT_LOOPS;
 	struct edma_chan *echan = edesc->echan;
 	struct edma_pset *pset = edesc->pset;
-	dma_addr_t done, pos;
+	dma_addr_t done, pos, pos_old;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	int idx = EDMA_REG_ARRAY_INDEX(channel);
+	int ch_bit = EDMA_CHANNEL_BIT(channel);
+	int event_reg;
 	int i;
 
 	/*
@@ -1749,16 +1754,20 @@ static u32 edma_residue(struct edma_desc *edesc)
 	 * "pos" may represent a transfer request that is still being
 	 * processed by the EDMACC or EDMATC. We will busy wait until
 	 * any one of the situations occurs:
-	 *   1. the DMA hardware is idle
-	 *   2. a new transfer request is setup
+	 *   1. while and event is pending for the channel
+	 *   2. a position updated
 	 *   3. we hit the loop limit
 	 */
-	while (edma_read(echan->ecc, EDMA_CCSTAT) & EDMA_CCSTAT_ACTV) {
-		/* check if a new transfer request is setup */
-		if (edma_get_position(echan->ecc,
-				      echan->slot[0], dst) != pos) {
+	if (is_slave_direction(edesc->direction))
+		event_reg = SH_ER;
+	else
+		event_reg = SH_ESR;
+
+	pos_old = pos;
+	while (edma_shadow0_read_array(echan->ecc, event_reg, idx) & ch_bit) {
+		pos = edma_get_position(echan->ecc, echan->slot[0], dst);
+		if (pos != pos_old)
 			break;
-		}
 
 		if (!--loop_count) {
 			dev_dbg_ratelimited(echan->vchan.chan.device->dev,
@@ -1783,6 +1792,12 @@ static u32 edma_residue(struct edma_desc *edesc)
 		return edesc->residue_stat;
 	}
 
+	/*
+	 * If the position is 0, then EDMA loaded the closing dummy slot, the
+	 * transfer is completed
+	 */
+	if (!pos)
+		return 0;
 	/*
 	 * For SG operation we catch up with the last processed
 	 * status.
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
