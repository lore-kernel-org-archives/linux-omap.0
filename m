From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 3/3] dmaengine: ti: edma: Support for polled (memcpy)
 completion
Date: Tue, 16 Jul 2019 11:26:55 +0300
Message-ID: <20190716082655.1620-4-peter.ujfalusi@ti.com>
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

When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
does not want to use interrupts for DMA completion or because it can not
rely on DMA interrupts due to executing the memcpy when interrupts are
disabled it will poll the status of the transfer.

Since we can not tell from any EDMA register that the transfer is
completed, we can only know that the paRAM set has been sent to TPTC for
processing we need to check the residue of the transfer, if it is 0 then
the transfer is completed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 5b8cbd6d7610..bcd431283d8a 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -180,6 +180,7 @@ struct edma_desc {
 	struct list_head		node;
 	enum dma_transfer_direction	direction;
 	int				cyclic;
+	bool				polled;
 	int				absync;
 	int				pset_nr;
 	struct edma_chan		*echan;
@@ -1227,8 +1228,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 
 	edesc->pset[0].param.opt |= ITCCHEN;
 	if (nslots == 1) {
-		/* Enable transfer complete interrupt */
-		edesc->pset[0].param.opt |= TCINTEN;
+		/* Enable transfer complete interrupt if requested */
+		if (tx_flags & DMA_PREP_INTERRUPT)
+			edesc->pset[0].param.opt |= TCINTEN;
 	} else {
 		/* Enable transfer complete chaining for the first slot */
 		edesc->pset[0].param.opt |= TCCHEN;
@@ -1255,9 +1257,14 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 		}
 
 		edesc->pset[1].param.opt |= ITCCHEN;
-		edesc->pset[1].param.opt |= TCINTEN;
+		/* Enable transfer complete interrupt if requested */
+		if (tx_flags & DMA_PREP_INTERRUPT)
+			edesc->pset[1].param.opt |= TCINTEN;
 	}
 
+	if (!(tx_flags & DMA_PREP_INTERRUPT))
+		edesc->polled = true;
+
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
 
@@ -1827,18 +1834,40 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
 {
 	struct edma_chan *echan = to_edma_chan(chan);
 	struct virt_dma_desc *vdesc;
+	struct dma_tx_state txstate_tmp;
 	enum dma_status ret;
 	unsigned long flags;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE || !txstate)
+
+	if (ret == DMA_COMPLETE)
 		return ret;
 
+	/* Provide a dummy dma_tx_state for completion checking */
+	if (!txstate)
+		txstate = &txstate_tmp;
+
+	txstate->residue = 0;
 	spin_lock_irqsave(&echan->vchan.lock, flags);
 	if (echan->edesc && echan->edesc->vdesc.tx.cookie == cookie)
 		txstate->residue = edma_residue(echan->edesc);
 	else if ((vdesc = vchan_find_desc(&echan->vchan, cookie)))
 		txstate->residue = to_edma_desc(&vdesc->tx)->residue;
+
+	/*
+	 * Mark the cookie completed if the residue is 0 for non cyclic
+	 * transfers
+	 */
+	if (ret != DMA_COMPLETE && !txstate->residue &&
+	    echan->edesc && echan->edesc->polled &&
+	    echan->edesc->vdesc.tx.cookie == cookie) {
+		edma_stop(echan);
+		vchan_cookie_complete(&echan->edesc->vdesc);
+		echan->edesc = NULL;
+		edma_execute(echan);
+		ret = DMA_COMPLETE;
+	}
+
 	spin_unlock_irqrestore(&echan->vchan.lock, flags);
 
 	return ret;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
