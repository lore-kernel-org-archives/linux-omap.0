From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 3/3] mtd: nand: omap2: use gpmc provided irqs
Date: Tue, 15 May 2012 20:08:47 +0530
Message-ID: <588ded576e45a01d538fd6fa83bde6dd111fc6b2.1337090835.git.afzal@ti.com>
References: <cover.1337090835.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49323 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104Ab2EOOzS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 10:55:18 -0400
In-Reply-To: <cover.1337090835.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, artem.bityutskiy@linux.intel.com, dedekind1@gmail.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

GPMC driver provides it's clients with interrupts that can be used
through struct resource. Make use of it for irq mode functionality.

Also now write protect disable is done by GPMC code, hence remove it.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/nand/omap2.c |   70 +++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index f69ecc1..2eac7d9 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -131,7 +131,8 @@ struct omap_nand_info {
 	unsigned long			mem_size;
 	struct completion		comp;
 	int				dma_ch;
-	int				gpmc_irq;
+	int				gpmc_irq_fifo;
+	int				gpmc_irq_count;
 	enum {
 		OMAP_NAND_IO_READ = 0,	/* read */
 		OMAP_NAND_IO_WRITE,	/* write */
@@ -556,14 +557,12 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 {
 	struct omap_nand_info *info = (struct omap_nand_info *) dev;
 	u32 bytes;
-	u32 irq_stat;
 
-	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
 	bytes = readl(info->reg.gpmc_prefetch_status);
 	bytes = GPMC_PREFETCH_STATUS_FIFO_CNT(bytes);
 	bytes = bytes  & 0xFFFC; /* io in multiple of 4 bytes */
 	if (info->iomode == OMAP_NAND_IO_WRITE) { /* checks for write io */
-		if (irq_stat & 0x2)
+		if (this_irq == info->gpmc_irq_count)
 			goto done;
 
 		if (info->buf_len && (info->buf_len < bytes))
@@ -580,20 +579,17 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 						(u32 *)info->buf, bytes >> 2);
 		info->buf = info->buf + bytes;
 
-		if (irq_stat & 0x2)
+		if (this_irq == info->gpmc_irq_count)
 			goto done;
 	}
-	gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, irq_stat);
 
 	return IRQ_HANDLED;
 
 done:
 	complete(&info->comp);
-	/* disable irq */
-	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ, 0);
 
-	/* clear status */
-	gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, irq_stat);
+	disable_irq_nosync(info->gpmc_irq_fifo);
+	disable_irq_nosync(info->gpmc_irq_count);
 
 	return IRQ_HANDLED;
 }
@@ -627,9 +623,9 @@ static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
 		goto out_copy;
 
 	info->buf_len = len;
-	/* enable irq */
-	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ,
-		(GPMC_IRQ_FIFOEVENTENABLE | GPMC_IRQ_COUNT_EVENT));
+
+	enable_irq(info->gpmc_irq_count);
+	enable_irq(info->gpmc_irq_fifo);
 
 	/* waiting for read to complete */
 	wait_for_completion(&info->comp);
@@ -677,12 +673,13 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 		goto out_copy;
 
 	info->buf_len = len;
-	/* enable irq */
-	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ,
-			(GPMC_IRQ_FIFOEVENTENABLE | GPMC_IRQ_COUNT_EVENT));
+
+	enable_irq(info->gpmc_irq_count);
+	enable_irq(info->gpmc_irq_fifo);
 
 	/* waiting for write to complete */
 	wait_for_completion(&info->comp);
+
 	/* wait for data to flushed-out before reset the prefetch */
 	tim = 0;
 	limit = (loops_per_jiffy *  msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
@@ -1079,9 +1076,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->nand.options	= pdata->devsize;
 	info->nand.options	|= NAND_SKIP_BBTSCAN;
 
-	/* NAND write protect off */
-	gpmc_cs_configure(info->gpmc_cs, GPMC_CONFIG_WP, 0);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		err = -EINVAL;
@@ -1104,6 +1098,14 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 
+	info->gpmc_irq_fifo = platform_get_irq_byname(pdev, "fifoevent");
+	if (info->gpmc_irq_fifo == -ENXIO)
+		dev_warn(&pdev->dev, "error getting FIFO IRQ\n");
+
+	info->gpmc_irq_count = platform_get_irq_byname(pdev, "terminalcount");
+	if (info->gpmc_irq_count == -ENXIO)
+		dev_warn(&pdev->dev, "error getting TERMINALCOUNT IRQ\n");
+
 	info->nand.controller = &info->controller;
 
 	info->nand.IO_ADDR_W = info->nand.IO_ADDR_R;
@@ -1159,17 +1161,24 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		break;
 
 	case NAND_OMAP_PREFETCH_IRQ:
-		err = request_irq(pdata->gpmc_irq,
-				omap_nand_irq, IRQF_SHARED, "gpmc-nand", info);
+		err = request_irq(info->gpmc_irq_fifo,	omap_nand_irq,
+					IRQF_SHARED, "gpmc-nand-fifo", info);
 		if (err) {
 			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
-							pdata->gpmc_irq, err);
+						info->gpmc_irq_fifo, err);
 			goto out_release_mem_region;
-		} else {
-			info->gpmc_irq	     = pdata->gpmc_irq;
-			info->nand.read_buf  = omap_read_buf_irq_pref;
-			info->nand.write_buf = omap_write_buf_irq_pref;
 		}
+		err = request_irq(info->gpmc_irq_count,	omap_nand_irq,
+					IRQF_SHARED, "gpmc-nand-count", info);
+		if (err) {
+			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
+						info->gpmc_irq_count, err);
+			goto out_free_irq_gpmc_fifo;
+		}
+
+		info->nand.read_buf  = omap_read_buf_irq_pref;
+		info->nand.write_buf = omap_write_buf_irq_pref;
+
 		break;
 
 	default:
@@ -1239,6 +1248,8 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 
 	return 0;
 
+out_free_irq_gpmc_fifo:
+	free_irq(info->gpmc_irq_fifo, info);
 out_release_mem_region:
 	release_mem_region(info->phys_base, info->mem_size);
 out_free_info:
@@ -1257,8 +1268,11 @@ static int omap_nand_remove(struct platform_device *pdev)
 	if (info->dma_ch != -1)
 		omap_free_dma(info->dma_ch);
 
-	if (info->gpmc_irq)
-		free_irq(info->gpmc_irq, info);
+	if (info->gpmc_irq_fifo > 0)
+		free_irq(info->gpmc_irq_fifo, info);
+
+	if (info->gpmc_irq_count > 0)
+		free_irq(info->gpmc_irq_count, info);
 
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
-- 
1.7.10

