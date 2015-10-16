From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 01/14] dmaengine: edma: Remove alignment constraint for
 memcpy
Date: Fri, 16 Oct 2015 10:17:59 +0300
Message-ID: <1444979892-31626-2-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Despite the claim by the original commit adding the memcpy
support, eDMA does not have constraint on the alignment of src, dst
or length in increment mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 7eefbf1e1c94..b36dfa5458cb 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1324,6 +1324,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 	struct edma_desc *edesc;
 	struct device *dev = chan->device->dev;
 	struct edma_chan *echan = to_edma_chan(chan);
+	unsigned int width;
 
 	if (unlikely(!echan || !len))
 		return NULL;
@@ -1336,8 +1337,12 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 
 	edesc->pset_nr = 1;
 
+	width = 1 << __ffs((src | dest | len));
+	if (width > DMA_SLAVE_BUSWIDTH_64_BYTES)
+		width = DMA_SLAVE_BUSWIDTH_64_BYTES;
+
 	ret = edma_config_pset(chan, &edesc->pset[0], src, dest, 1,
-			       DMA_SLAVE_BUSWIDTH_4_BYTES, len, DMA_MEM_TO_MEM);
+			       width, len, DMA_MEM_TO_MEM);
 	if (ret < 0)
 		return NULL;
 
@@ -1903,12 +1908,6 @@ static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 
 	dma->dev = dev;
 
-	/*
-	 * code using dma memcpy must make sure alignment of
-	 * length is at dma->copy_align boundary.
-	 */
-	dma->copy_align = DMAENGINE_ALIGN_4_BYTES;
-
 	INIT_LIST_HEAD(&dma->channels);
 }
 
-- 
2.6.1
