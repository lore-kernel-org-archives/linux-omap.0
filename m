From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 14/21] dmaengine: edma: Cleanup regarding the use of dev
 around the code
Date: Thu, 10 Sep 2015 11:37:43 +0300
Message-ID: <1441874270-2399-15-git-send-email-peter.ujfalusi@ti.com>
References: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Be consistent and do not mix the use of dev, &pdev->dev, etc in the
functions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 0b46d4263ec6..71de1c843bb4 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1177,7 +1177,7 @@ static void edma_execute(struct edma_chan *echan)
 		j = i + edesc->processed;
 		edma_write_slot(ecc, echan->slot[i], &edesc->pset[j].param);
 		edesc->sg_len += edesc->pset[j].len;
-		dev_vdbg(echan->vchan.chan.device->dev,
+		dev_vdbg(dev,
 			"\n pset[%d]:\n"
 			"  chnum\t%d\n"
 			"  slot\t%d\n"
@@ -1828,7 +1828,6 @@ err_no_chan:
 static void edma_free_chan_resources(struct dma_chan *chan)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
-	struct device *dev = chan->device->dev;
 	int i;
 
 	/* Terminate transfers */
@@ -1850,7 +1849,7 @@ static void edma_free_chan_resources(struct dma_chan *chan)
 		echan->alloced = false;
 	}
 
-	dev_dbg(dev, "freeing channel for %u\n", echan->ch_num);
+	dev_dbg(chan->device->dev, "freeing channel for %u\n", echan->ch_num);
 }
 
 /* Send pending descriptor to hardware */
@@ -2174,13 +2173,13 @@ static int edma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-	ecc = devm_kzalloc(&pdev->dev, sizeof(*ecc), GFP_KERNEL);
+	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
 	if (!ecc) {
-		dev_err(&pdev->dev, "Can't allocate controller\n");
+		dev_err(dev, "Can't allocate controller\n");
 		return -ENOMEM;
 	}
 
@@ -2325,7 +2324,7 @@ static int edma_probe(struct platform_device *pdev)
 
 	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
 	if (ecc->dummy_slot < 0) {
-		dev_err(&pdev->dev, "Can't allocate PaRAM dummy slot\n");
+		dev_err(dev, "Can't allocate PaRAM dummy slot\n");
 		return ecc->dummy_slot;
 	}
 
@@ -2334,7 +2333,7 @@ static int edma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_CYCLIC, ecc->dma_slave.cap_mask);
 	dma_cap_set(DMA_MEMCPY, ecc->dma_slave.cap_mask);
 
-	edma_dma_init(ecc, &ecc->dma_slave, &pdev->dev);
+	edma_dma_init(ecc, &ecc->dma_slave, dev);
 
 	edma_chan_init(ecc, &ecc->dma_slave, ecc->slave_chans);
 
@@ -2346,7 +2345,7 @@ static int edma_probe(struct platform_device *pdev)
 		of_dma_controller_register(node, of_dma_xlate_by_chan_id,
 					   &ecc->dma_slave);
 
-	dev_info(&pdev->dev, "TI EDMA DMA engine driver\n");
+	dev_info(dev, "TI EDMA DMA engine driver\n");
 
 	return 0;
 
@@ -2360,8 +2359,8 @@ static int edma_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct edma_cc *ecc = dev_get_drvdata(dev);
 
-	if (pdev->dev.of_node)
-		of_dma_controller_free(pdev->dev.of_node);
+	if (dev->of_node)
+		of_dma_controller_free(dev->of_node);
 	dma_async_device_unregister(&ecc->dma_slave);
 	edma_free_slot(ecc, ecc->dummy_slot);
 
-- 
2.5.1
