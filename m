From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 10/11] mtd: omap2: remove private DMA API implementation
Date: Thu, 07 Jun 2012 12:09:36 +0100
Message-ID: <E1Scaau-0003uF-5K@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54337 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab2FGLJn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 07:09:43 -0400
In-Reply-To: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org

Remove the private DMA API implementation from nand/omap2.c
making it use entirely the DMA engine API.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mtd/nand/omap2.c |  136 +++++++++-------------------------------------
 1 files changed, 26 insertions(+), 110 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 2912d6c..e9309b3 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -126,7 +126,6 @@ struct omap_nand_info {
 	unsigned long			phys_base;
 	struct completion		comp;
 	struct dma_chan			*dma;
-	int				dma_ch;
 	int				gpmc_irq;
 	enum {
 		OMAP_NAND_IO_READ = 0,	/* read */
@@ -339,15 +338,9 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 }
 
 /*
- * omap_nand_dma_cb: callback on the completion of dma transfer
- * @lch: logical channel
- * @ch_satuts: channel status
+ * omap_nand_dma_callback: callback on the completion of dma transfer
  * @data: pointer to completion data structure
  */
-static void omap_nand_dma_cb(int lch, u16 ch_status, void *data)
-{
-	complete((struct completion *) data);
-}
 static void omap_nand_dma_callback(void *data)
 {
 	complete((struct completion *) data);
@@ -365,17 +358,13 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 {
 	struct omap_nand_info *info = container_of(mtd,
 					struct omap_nand_info, mtd);
+	struct dma_async_tx_descriptor *tx;
 	enum dma_data_direction dir = is_write ? DMA_TO_DEVICE :
 							DMA_FROM_DEVICE;
-	dma_addr_t dma_addr;
-	int ret;
+	struct scatterlist sg;
 	unsigned long tim, limit;
-
-	/* The fifo depth is 64 bytes max.
-	 * But configure the FIFO-threahold to 32 to get a sync at each frame
-	 * and frame length is 32 bytes.
-	 */
-	int buf_len = len >> 6;
+	unsigned n;
+	int ret;
 
 	if (addr >= high_memory) {
 		struct page *p1;
@@ -389,89 +378,33 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 		addr = page_address(p1) + ((size_t)addr & ~PAGE_MASK);
 	}
 
-	if (info->dma) {
-		struct dma_async_tx_descriptor *tx;
-		struct scatterlist sg;
-		unsigned n;
-
-		sg_init_one(&sg, addr, len);
-		n = dma_map_sg(info->dma->device->dev, &sg, 1, dir);
-		if (n == 0) {
-			dev_err(&info->pdev->dev,
-				"Couldn't DMA map a %d byte buffer\n", len);
-			goto out_copy;
-		}
-
-		tx = dmaengine_prep_slave_sg(info->dma, &sg, n,
-			is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
-			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!tx) {
-			dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
-			goto out_copy;
-		}
-		tx->callback = omap_nand_dma_callback;
-		tx->callback_param = &info->comp;
-		dmaengine_submit(tx);
-
-		/*  configure and start prefetch transfer */
-		ret = gpmc_prefetch_enable(info->gpmc_cs,
-			PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write);
-		if (ret) {
-			/* PFPW engine is busy, use cpu copy method */
-			dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
-			goto out_copy;
-		}
-
-		init_completion(&info->comp);
-		dma_async_issue_pending(info->dma);
-
-		/* setup and start DMA using dma_addr */
-		wait_for_completion(&info->comp);
-		tim = 0;
-		limit = (loops_per_jiffy * msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
-		while (gpmc_read_status(GPMC_PREFETCH_COUNT) && (tim++ < limit))
-			cpu_relax();
-
-		/* disable and stop the PFPW engine */
-		gpmc_prefetch_reset(info->gpmc_cs);
-
-		dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
-		return 0;
-	}
-
-	dma_addr = dma_map_single(&info->pdev->dev, addr, len, dir);
-	if (dma_mapping_error(&info->pdev->dev, dma_addr)) {
+	sg_init_one(&sg, addr, len);
+	n = dma_map_sg(info->dma->device->dev, &sg, 1, dir);
+	if (n == 0) {
 		dev_err(&info->pdev->dev,
 			"Couldn't DMA map a %d byte buffer\n", len);
 		goto out_copy;
 	}
 
-	if (is_write) {
-	    omap_set_dma_dest_params(info->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-						info->phys_base, 0, 0);
-	    omap_set_dma_src_params(info->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
-							dma_addr, 0, 0);
-	    omap_set_dma_transfer_params(info->dma_ch, OMAP_DMA_DATA_TYPE_S32,
-					0x10, buf_len, OMAP_DMA_SYNC_FRAME,
-					OMAP24XX_DMA_GPMC, OMAP_DMA_DST_SYNC);
-	} else {
-	    omap_set_dma_src_params(info->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-						info->phys_base, 0, 0);
-	    omap_set_dma_dest_params(info->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
-							dma_addr, 0, 0);
-	    omap_set_dma_transfer_params(info->dma_ch, OMAP_DMA_DATA_TYPE_S32,
-					0x10, buf_len, OMAP_DMA_SYNC_FRAME,
-					OMAP24XX_DMA_GPMC, OMAP_DMA_SRC_SYNC);
-	}
-	/*  configure and start prefetch transfer */
+	tx = dmaengine_prep_slave_sg(info->dma, &sg, n,
+		is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
+		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!tx)
+		goto out_copy_unmap;
+
+	tx->callback = omap_nand_dma_callback;
+	tx->callback_param = &info->comp;
+	dmaengine_submit(tx);
+
+	/* configure and start prefetch transfer */
 	ret = gpmc_prefetch_enable(info->gpmc_cs,
-			PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write);
+		PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy method */
 		goto out_copy_unmap;
 
 	init_completion(&info->comp);
-	omap_start_dma(info->dma_ch);
+	dma_async_issue_pending(info->dma);
 
 	/* setup and start DMA using dma_addr */
 	wait_for_completion(&info->comp);
@@ -483,11 +416,11 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	/* disable and stop the PFPW engine */
 	gpmc_prefetch_reset(info->gpmc_cs);
 
-	dma_unmap_single(&info->pdev->dev, dma_addr, len, dir);
+	dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
 	return 0;
 
 out_copy_unmap:
-	dma_unmap_single(&info->pdev->dev, dma_addr, len, dir);
+	dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
 out_copy:
 	if (info->nand.options & NAND_BUSWIDTH_16)
 		is_write == 0 ? omap_read_buf16(mtd, (u_char *) addr, len)
@@ -1307,7 +1240,9 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		sig = OMAP24XX_DMA_GPMC;
 		info->dma = dma_request_channel(mask, omap_dma_filter_fn, &sig);
 		if (!info->dma) {
-			dev_warn(&pdev->dev, "DMA engine request failed\n");
+			dev_err(&pdev->dev, "DMA engine request failed\n");
+			err = -ENXIO;
+			goto out_release_mem_region;
 		} else {
 			struct dma_slave_config cfg;
 			int rc;
@@ -1327,22 +1262,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 			}
 			info->nand.read_buf   = omap_read_buf_dma_pref;
 			info->nand.write_buf  = omap_write_buf_dma_pref;
-			break;
-		}
-		err = omap_request_dma(OMAP24XX_DMA_GPMC, "NAND",
-				omap_nand_dma_cb, &info->comp, &info->dma_ch);
-		if (err < 0) {
-			info->dma_ch = -1;
-			dev_err(&pdev->dev, "DMA request failed!\n");
-			goto out_release_mem_region;
-		} else {
-			omap_set_dma_dest_burst_mode(info->dma_ch,
-					OMAP_DMA_DATA_BURST_16);
-			omap_set_dma_src_burst_mode(info->dma_ch,
-					OMAP_DMA_DATA_BURST_16);
-
-			info->nand.read_buf   = omap_read_buf_dma_pref;
-			info->nand.write_buf  = omap_write_buf_dma_pref;
 		}
 		break;
 
@@ -1460,9 +1379,6 @@ static int omap_nand_remove(struct platform_device *pdev)
 	omap3_free_bch(&info->mtd);
 
 	platform_set_drvdata(pdev, NULL);
-	if (info->dma_ch != -1)
-		omap_free_dma(info->dma_ch);
-
 	if (info->dma)
 		dma_release_channel(info->dma);
 
-- 
1.7.4.4

