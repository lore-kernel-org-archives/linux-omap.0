From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 10/18] dma: edma: Reduce debug print verbosity for non verbose debugging
Date: Thu, 13 Mar 2014 11:18:32 +0200
Message-ID: <1394702320-21743-11-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, joelf@ti.com, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, mporter@linaro.org, vinod.koul@intel.com, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

Do not print the paRAM information when verbose debugging is not asked and
also reduce the number of lines printed in edma_prep_dma_cyclic()

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index e4f4a0cef58c..e2aa42b8342f 100644
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
@@ -554,9 +554,8 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	edesc->cyclic = 1;
 	edesc->pset_nr = nslots;
 
-	dev_dbg(dev, "%s: nslots=%d\n", __func__, nslots);
-	dev_dbg(dev, "%s: period_len=%d\n", __func__, period_len);
-	dev_dbg(dev, "%s: buf_len=%d\n", __func__, buf_len);
+	dev_dbg(dev, "%s: channel=%d nslots=%d period_len=%d buf_len=%d\n",
+		__func__, echan->ch_num, nslots, period_len, buf_len);
 
 	for (i = 0; i < nslots; i++) {
 		/* Allocate a PaRAM slot, if needed */
@@ -590,8 +589,8 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
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
1.9.0
