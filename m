From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 14/24] dmaengine: edma: Cleanup regarding the use of dev around the code
Date: Wed, 14 Oct 2015 14:42:56 +0300
Message-ID: <1444822986-20562-15-git-send-email-peter.ujfalusi@ti.com>
References: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Be consistent and do not mix the use of dev, &pdev->dev, etc in the
functions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 61 +++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 95c10373168d..a9fe5c92451d 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1198,27 +1198,27 @@ static void edma_execute(struct edma_chan *echan)
 		j = i + edesc->processed;
 		edma_write_slot(ecc, echan->slot[i], &edesc->pset[j].param);
 		edesc->sg_len += edesc->pset[j].len;
-		dev_vdbg(echan->vchan.chan.device->dev,
-			"\n pset[%d]:\n"
-			"  chnum\t%d\n"
-			"  slot\t%d\n"
-			"  opt\t%08x\n"
-			"  src\t%08x\n"
-			"  dst\t%08x\n"
-			"  abcnt\t%08x\n"
-			"  ccnt\t%08x\n"
-			"  bidx\t%08x\n"
-			"  cidx\t%08x\n"
-			"  lkrld\t%08x\n",
-			j, echan->ch_num, echan->slot[i],
-			edesc->pset[j].param.opt,
-			edesc->pset[j].param.src,
-			edesc->pset[j].param.dst,
-			edesc->pset[j].param.a_b_cnt,
-			edesc->pset[j].param.ccnt,
-			edesc->pset[j].param.src_dst_bidx,
-			edesc->pset[j].param.src_dst_cidx,
-			edesc->pset[j].param.link_bcntrld);
+		dev_vdbg(dev,
+			 "\n pset[%d]:\n"
+			 "  chnum\t%d\n"
+			 "  slot\t%d\n"
+			 "  opt\t%08x\n"
+			 "  src\t%08x\n"
+			 "  dst\t%08x\n"
+			 "  abcnt\t%08x\n"
+			 "  ccnt\t%08x\n"
+			 "  bidx\t%08x\n"
+			 "  cidx\t%08x\n"
+			 "  lkrld\t%08x\n",
+			 j, echan->ch_num, echan->slot[i],
+			 edesc->pset[j].param.opt,
+			 edesc->pset[j].param.src,
+			 edesc->pset[j].param.dst,
+			 edesc->pset[j].param.a_b_cnt,
+			 edesc->pset[j].param.ccnt,
+			 edesc->pset[j].param.src_dst_bidx,
+			 edesc->pset[j].param.src_dst_cidx,
+			 edesc->pset[j].param.link_bcntrld);
 		/* Link to the previous slot if not the last set */
 		if (i != (nslots - 1))
 			edma_link(ecc, echan->slot[i], echan->slot[i + 1]);
@@ -1849,7 +1849,6 @@ err_no_chan:
 static void edma_free_chan_resources(struct dma_chan *chan)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
-	struct device *dev = chan->device->dev;
 	int i;
 
 	/* Terminate transfers */
@@ -1871,7 +1870,7 @@ static void edma_free_chan_resources(struct dma_chan *chan)
 		echan->alloced = false;
 	}
 
-	dev_dbg(dev, "freeing channel for %u\n", echan->ch_num);
+	dev_dbg(chan->device->dev, "freeing channel for %u\n", echan->ch_num);
 }
 
 /* Send pending descriptor to hardware */
@@ -2196,13 +2195,13 @@ static int edma_probe(struct platform_device *pdev)
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
 
@@ -2345,7 +2344,7 @@ static int edma_probe(struct platform_device *pdev)
 
 	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
 	if (ecc->dummy_slot < 0) {
-		dev_err(&pdev->dev, "Can't allocate PaRAM dummy slot\n");
+		dev_err(dev, "Can't allocate PaRAM dummy slot\n");
 		return ecc->dummy_slot;
 	}
 
@@ -2354,7 +2353,7 @@ static int edma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_CYCLIC, ecc->dma_slave.cap_mask);
 	dma_cap_set(DMA_MEMCPY, ecc->dma_slave.cap_mask);
 
-	edma_dma_init(ecc, &ecc->dma_slave, &pdev->dev);
+	edma_dma_init(ecc, &ecc->dma_slave, dev);
 
 	edma_chan_init(ecc, &ecc->dma_slave, ecc->slave_chans);
 
@@ -2366,7 +2365,7 @@ static int edma_probe(struct platform_device *pdev)
 		of_dma_controller_register(node, of_dma_xlate_by_chan_id,
 					   &ecc->dma_slave);
 
-	dev_info(&pdev->dev, "TI EDMA DMA engine driver\n");
+	dev_info(dev, "TI EDMA DMA engine driver\n");
 
 	return 0;
 
@@ -2380,8 +2379,8 @@ static int edma_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct edma_cc *ecc = dev_get_drvdata(dev);
 
-	if (pdev->dev.of_node)
-		of_dma_controller_free(pdev->dev.of_node);
+	if (dev->of_node)
+		of_dma_controller_free(dev->of_node);
 	dma_async_device_unregister(&ecc->dma_slave);
 	edma_free_slot(ecc, ecc->dummy_slot);
 
-- 
2.6.1
