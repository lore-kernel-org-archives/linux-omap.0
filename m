From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 09/11] mtd: omap2: add DMA engine support
Date: Thu, 07 Jun 2012 12:09:16 +0100
Message-ID: <E1Scaaa-0003uB-1l@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54328 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab2FGLJV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 07:09:21 -0400
In-Reply-To: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org

Add DMA engine support to the OMAP2 NAND driver.  This supplements the
private DMA API implementation contained within this driver, and the
driver can be independently switched at build time between using DMA
engine and the private DMA API.

Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mtd/nand/omap2.c |   92 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 91 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index d7f681d..2912d6c 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/module.h>
@@ -18,6 +19,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/omap-dma.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
@@ -123,6 +125,7 @@ struct omap_nand_info {
 	int				gpmc_cs;
 	unsigned long			phys_base;
 	struct completion		comp;
+	struct dma_chan			*dma;
 	int				dma_ch;
 	int				gpmc_irq;
 	enum {
@@ -345,6 +348,10 @@ static void omap_nand_dma_cb(int lch, u16 ch_status, void *data)
 {
 	complete((struct completion *) data);
 }
+static void omap_nand_dma_callback(void *data)
+{
+	complete((struct completion *) data);
+}
 
 /*
  * omap_nand_dma_transfer: configer and start dma transfer
@@ -382,6 +389,56 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 		addr = page_address(p1) + ((size_t)addr & ~PAGE_MASK);
 	}
 
+	if (info->dma) {
+		struct dma_async_tx_descriptor *tx;
+		struct scatterlist sg;
+		unsigned n;
+
+		sg_init_one(&sg, addr, len);
+		n = dma_map_sg(info->dma->device->dev, &sg, 1, dir);
+		if (n == 0) {
+			dev_err(&info->pdev->dev,
+				"Couldn't DMA map a %d byte buffer\n", len);
+			goto out_copy;
+		}
+
+		tx = dmaengine_prep_slave_sg(info->dma, &sg, n,
+			is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!tx) {
+			dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
+			goto out_copy;
+		}
+		tx->callback = omap_nand_dma_callback;
+		tx->callback_param = &info->comp;
+		dmaengine_submit(tx);
+
+		/*  configure and start prefetch transfer */
+		ret = gpmc_prefetch_enable(info->gpmc_cs,
+			PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write);
+		if (ret) {
+			/* PFPW engine is busy, use cpu copy method */
+			dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
+			goto out_copy;
+		}
+
+		init_completion(&info->comp);
+		dma_async_issue_pending(info->dma);
+
+		/* setup and start DMA using dma_addr */
+		wait_for_completion(&info->comp);
+		tim = 0;
+		limit = (loops_per_jiffy * msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
+		while (gpmc_read_status(GPMC_PREFETCH_COUNT) && (tim++ < limit))
+			cpu_relax();
+
+		/* disable and stop the PFPW engine */
+		gpmc_prefetch_reset(info->gpmc_cs);
+
+		dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
+		return 0;
+	}
+
 	dma_addr = dma_map_single(&info->pdev->dev, addr, len, dir);
 	if (dma_mapping_error(&info->pdev->dev, dma_addr)) {
 		dev_err(&info->pdev->dev,
@@ -414,7 +471,6 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 		goto out_copy_unmap;
 
 	init_completion(&info->comp);
-
 	omap_start_dma(info->dma_ch);
 
 	/* setup and start DMA using dma_addr */
@@ -1164,6 +1220,8 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	struct omap_nand_platform_data	*pdata;
 	int				err;
 	int				i, offset;
+	dma_cap_mask_t mask;
+	unsigned sig;
 
 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -1244,6 +1302,33 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		break;
 
 	case NAND_OMAP_PREFETCH_DMA:
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		sig = OMAP24XX_DMA_GPMC;
+		info->dma = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+		if (!info->dma) {
+			dev_warn(&pdev->dev, "DMA engine request failed\n");
+		} else {
+			struct dma_slave_config cfg;
+			int rc;
+
+			memset(&cfg, 0, sizeof(cfg));
+			cfg.src_addr = info->phys_base;
+			cfg.dst_addr = info->phys_base;
+			cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			cfg.src_maxburst = 16;
+			cfg.dst_maxburst = 16;
+			rc = dmaengine_slave_config(info->dma, &cfg);
+			if (rc) {
+				dev_err(&pdev->dev, "DMA engine slave config failed: %d\n",
+					rc);
+				goto out_release_mem_region;
+			}
+			info->nand.read_buf   = omap_read_buf_dma_pref;
+			info->nand.write_buf  = omap_write_buf_dma_pref;
+			break;
+		}
 		err = omap_request_dma(OMAP24XX_DMA_GPMC, "NAND",
 				omap_nand_dma_cb, &info->comp, &info->dma_ch);
 		if (err < 0) {
@@ -1358,6 +1443,8 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	return 0;
 
 out_release_mem_region:
+	if (info->dma)
+		dma_release_channel(info->dma);
 	release_mem_region(info->phys_base, NAND_IO_SIZE);
 out_free_info:
 	kfree(info);
@@ -1376,6 +1463,9 @@ static int omap_nand_remove(struct platform_device *pdev)
 	if (info->dma_ch != -1)
 		omap_free_dma(info->dma_ch);
 
+	if (info->dma)
+		dma_release_channel(info->dma);
+
 	if (info->gpmc_irq)
 		free_irq(info->gpmc_irq, info);
 
-- 
1.7.4.4

