From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] dmaengine: ti: omap-dma: Readability cleanup in
 omap_dma_tx_status()
Date: Tue, 16 Jul 2019 11:24:58 +0300
Message-ID: <20190716082459.1222-2-peter.ujfalusi@ti.com>
References: <20190716082459.1222-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190716082459.1222-1-peter.ujfalusi@ti.com>
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

The tx_status is most likely going to be asked for the current transfer, so
check that first then try to fall back to lookup of non started transfers.

In this way the code is a bit more readable and in most cases we will avoid
to run vchan_find_desc() all the time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/omap-dma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index ba2489d4ea24..029c0bd550d5 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -832,10 +832,8 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 		return ret;
 
 	spin_lock_irqsave(&c->vc.lock, flags);
-	vd = vchan_find_desc(&c->vc, cookie);
-	if (vd) {
-		txstate->residue = omap_dma_desc_size(to_omap_dma_desc(&vd->tx));
-	} else if (c->desc && c->desc->vd.tx.cookie == cookie) {
+
+	if (c->desc && c->desc->vd.tx.cookie == cookie) {
 		struct omap_desc *d = c->desc;
 		dma_addr_t pos;
 
@@ -847,11 +845,15 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 			pos = 0;
 
 		txstate->residue = omap_dma_desc_size_pos(d, pos);
+	} else if ((vd = vchan_find_desc(&c->vc, cookie))) {
+		txstate->residue = omap_dma_desc_size(to_omap_dma_desc(&vd->tx));
 	} else {
 		txstate->residue = 0;
 	}
+
 	if (ret == DMA_IN_PROGRESS && c->paused)
 		ret = DMA_PAUSED;
+
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
 	return ret;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
