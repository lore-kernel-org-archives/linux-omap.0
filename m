From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 07/10] dmaengine: edma: Reduce debug print verbosity for
 non verbose debugging
Date: Mon, 14 Apr 2014 14:42:02 +0300
Message-ID: <1397475725-5036-8-git-send-email-peter.ujfalusi@ti.com>
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

Do not print the paRAM information when verbose debugging is not asked and
also reduce the number of lines printed in edma_prep_dma_cyclic()

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 2f58c04cbcb1..6d9edc47150d 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -141,7 +141,7 @@ static void edma_execute(struct edma_chan *echan)
 	for (i = 0; i < nslots; i++) {
 		j = i + edesc->processed;
 		edma_write_slot(echan->slot[i], &edesc->pset[j]);
-		dev_dbg(echan->vchan.chan.device->dev,
+		dev_vdbg(echan->vchan.chan.device->dev,
 			"\n pset[%d]:\n"
 			"  chnum\t%d\n"
 			"  slot\t%d\n"
@@ -560,9 +560,8 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	edesc->cyclic = 1;
 	edesc->pset_nr = nslots;
 
-	dev_dbg(dev, "%s: nslots=%d\n", __func__, nslots);
-	dev_dbg(dev, "%s: period_len=%d\n", __func__, period_len);
-	dev_dbg(dev, "%s: buf_len=%d\n", __func__, buf_len);
+	dev_dbg(dev, "%s: channel=%d nslots=%d period_len=%zu buf_len=%zu\n",
+		__func__, echan->ch_num, nslots, period_len, buf_len);
 
 	for (i = 0; i < nslots; i++) {
 		/* Allocate a PaRAM slot, if needed */
@@ -596,8 +595,8 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		else
 			src_addr += period_len;
 
-		dev_dbg(dev, "%s: Configure period %d of buf:\n", __func__, i);
-		dev_dbg(dev,
+		dev_vdbg(dev, "%s: Configure period %d of buf:\n", __func__, i);
+		dev_vdbg(dev,
 			"\n pset[%d]:\n"
 			"  chnum\t%d\n"
 			"  slot\t%d\n"
-- 
1.9.2
