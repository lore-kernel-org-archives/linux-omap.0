From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: ti: edma: Remove 'Assignment in if condition'
Date: Tue, 30 Jul 2019 16:20:06 +0300
Message-ID: <20190730132006.2790-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

While the compiler does not have problem with how it is implemented,
checkpatch does give en ERROR for this arrangement.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index fe468e2f7e67..6f2d6c592663 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -1832,7 +1832,6 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
 				      struct dma_tx_state *txstate)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
-	struct virt_dma_desc *vdesc;
 	struct dma_tx_state txstate_tmp;
 	enum dma_status ret;
 	unsigned long flags;
@@ -1846,12 +1845,18 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
 	if (!txstate)
 		txstate = &txstate_tmp;
 
-	txstate->residue = 0;
 	spin_lock_irqsave(&echan->vchan.lock, flags);
-	if (echan->edesc && echan->edesc->vdesc.tx.cookie == cookie)
+	if (echan->edesc && echan->edesc->vdesc.tx.cookie == cookie) {
 		txstate->residue = edma_residue(echan->edesc);
-	else if ((vdesc = vchan_find_desc(&echan->vchan, cookie)))
-		txstate->residue = to_edma_desc(&vdesc->tx)->residue;
+	} else {
+		struct virt_dma_desc *vdesc = vchan_find_desc(&echan->vchan,
+							      cookie);
+
+		if (vdesc)
+			txstate->residue = to_edma_desc(&vdesc->tx)->residue;
+		else
+			txstate->residue = 0;
+	}
 
 	/*
 	 * Mark the cookie completed if the residue is 0 for non cyclic
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
