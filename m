From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: ti: omap-dma: Remove 'Assignment in if condition'
Date: Tue, 30 Jul 2019 16:20:15 +0300
Message-ID: <20190730132015.2863-1-peter.ujfalusi@ti.com>
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
 drivers/dma/ti/omap-dma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index a4a63425dc0b..3b57b68df896 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -814,7 +814,6 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 	dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
 	struct omap_chan *c = to_omap_dma_chan(chan);
-	struct virt_dma_desc *vd;
 	enum dma_status ret;
 	unsigned long flags;
 	struct omap_desc *d = NULL;
@@ -841,10 +840,14 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 			pos = 0;
 
 		txstate->residue = omap_dma_desc_size_pos(d, pos);
-	} else if ((vd = vchan_find_desc(&c->vc, cookie))) {
-		txstate->residue = omap_dma_desc_size(to_omap_dma_desc(&vd->tx));
 	} else {
-		txstate->residue = 0;
+		struct virt_dma_desc *vd = vchan_find_desc(&c->vc, cookie);
+
+		if (vd)
+			txstate->residue = omap_dma_desc_size(
+						to_omap_dma_desc(&vd->tx));
+		else
+			txstate->residue = 0;
 	}
 
 out:
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
