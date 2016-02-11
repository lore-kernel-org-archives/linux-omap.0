From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: edma: Fetch echan->edesc while holding lock in
 edma_comletion_handler
Date: Thu, 11 Feb 2016 15:17:48 +0200
Message-ID: <1455196668-9327-1-git-send-email-peter.ujfalusi@ti.com>
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
To: vinod.koul@intel.com
Cc: lars@metafoo.de, nsekhar@ti.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In order to avoid possible race condition when client drivers are using
dmaengine_terminate_sync() call to disable the channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/dma/edma.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 290e1a721c5b..13b6a23dc06b 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1372,36 +1372,36 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 static void edma_completion_handler(struct edma_chan *echan)
 {
 	struct device *dev = echan->vchan.chan.device->dev;
-	struct edma_desc *edesc = echan->edesc;
-
-	if (!edesc)
-		return;
+	struct edma_desc *edesc;
 
 	spin_lock(&echan->vchan.lock);
-	if (edesc->cyclic) {
-		vchan_cyclic_callback(&edesc->vdesc);
-		spin_unlock(&echan->vchan.lock);
-		return;
-	} else if (edesc->processed == edesc->pset_nr) {
-		edesc->residue = 0;
-		edma_stop(echan);
-		vchan_cookie_complete(&edesc->vdesc);
-		echan->edesc = NULL;
-
-		dev_dbg(dev, "Transfer completed on channel %d\n",
-			echan->ch_num);
-	} else {
-		dev_dbg(dev, "Sub transfer completed on channel %d\n",
-			echan->ch_num);
-
-		edma_pause(echan);
-
-		/* Update statistics for tx_status */
-		edesc->residue -= edesc->sg_len;
-		edesc->residue_stat = edesc->residue;
-		edesc->processed_stat = edesc->processed;
+	edesc = echan->edesc;
+	if (edesc) {
+		if (edesc->cyclic) {
+			vchan_cyclic_callback(&edesc->vdesc);
+			spin_unlock(&echan->vchan.lock);
+			return;
+		} else if (edesc->processed == edesc->pset_nr) {
+			edesc->residue = 0;
+			edma_stop(echan);
+			vchan_cookie_complete(&edesc->vdesc);
+			echan->edesc = NULL;
+
+			dev_dbg(dev, "Transfer completed on channel %d\n",
+				echan->ch_num);
+		} else {
+			dev_dbg(dev, "Sub transfer completed on channel %d\n",
+				echan->ch_num);
+
+			edma_pause(echan);
+
+			/* Update statistics for tx_status */
+			edesc->residue -= edesc->sg_len;
+			edesc->residue_stat = edesc->residue;
+			edesc->processed_stat = edesc->processed;
+		}
+		edma_execute(echan);
 	}
-	edma_execute(echan);
 
 	spin_unlock(&echan->vchan.lock);
 }
-- 
2.7.1
