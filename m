From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH 3/6] OMAP NAND: configurable fifo threshold to gain the throughput
Date: Fri, 16 Apr 2010 17:05:14 +0530
Message-ID: <1271417714-4408-1-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46736 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757804Ab0DPLfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 07:35:23 -0400
In-Reply-To: <Sukumar Ghorai <s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: sbranden@broadcom.com, leochen@broadcom.com, David.Woodhouse@intel.com, linux-omap@vger.kernel.org, tony@atomide.com, vimal.newwork@gmail.com, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

  Configure the FIFO THREASHOLD value to 50% (32 bytes) to keep busy both
  filling and to drain out of FIFO at reading and writing.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |    9 ++++++---
 arch/arm/plat-omap/include/plat/gpmc.h |    7 +++++--
 drivers/mtd/nand/omap2.c               |   25 +++++++++++++------------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 9c77af0..1380886 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -391,12 +391,15 @@ EXPORT_SYMBOL(gpmc_cs_free);
  * @u32_count: number of bytes to be transferred
  * @is_write: prefetch read(0) or write post(1) mode
  */
-int gpmc_prefetch_enable(int cs, int dma_mode,
+int gpmc_prefetch_enable(int cs, int fifo_th, int dma_mode,
 				unsigned int u32_count, int is_write)
 {
 	uint32_t prefetch_config1;
 
-	if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {
+	if (fifo_th > PREFETCH_FIFOTHRESHOLD_MAX) {
+		printk(KERN_ERR "PREFETCH Fifo Threshold is not supported\n");
+		return -1;
+	} else if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {
 		/* Set the amount of bytes to be prefetched */
 		gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_count);
 
@@ -404,7 +407,7 @@ int gpmc_prefetch_enable(int cs, int dma_mode,
 		 * enable the engine. Set which cs is has requested for.
 		 */
 		prefetch_config1 = ((cs << CS_NUM_SHIFT) |
-					PREFETCH_FIFOTHRESHOLD |
+					PREFETCH_FIFOTHRESHOLD(fifo_th) |
 					ENABLE_PREFETCH |
 					(dma_mode << DMA_MPU_MODE) |
 					(0x1 & is_write));
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 347d212..a36a046 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -55,10 +55,13 @@
 #define GPMC_CHUNK_SHIFT        24              /* 16 MB */
 #define GPMC_SECTION_SHIFT      28              /* 128 MB */
 
-#define PREFETCH_FIFOTHRESHOLD  (0x40 << 8)
+#define PREFETCH_FIFOTHRESHOLD_MAX	0x40
+#define PREFETCH_FIFOTHRESHOLD(val)	(val << 8)
 #define CS_NUM_SHIFT            24
 #define ENABLE_PREFETCH         (0x1 << 7)
 #define DMA_MPU_MODE            2
+#define PREFETCH_FIFOTHRESHOLD_READ	32 /* threashold size for read */
+#define PREFETCH_FIFOTHRESHOLD_WRITE	32 /* threashold size for write */
 
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
@@ -136,7 +139,7 @@ extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
 extern int gpmc_cs_set_reserved(int cs, int reserved);
 extern int gpmc_cs_reserved(int cs);
-extern int gpmc_prefetch_enable(int cs, int dma_mode,
+extern int gpmc_prefetch_enable(int cs, int fifo_th, int dma_mode,
 					unsigned int u32_count, int is_write);
 extern void gpmc_prefetch_reset(void);
 extern int gpmc_prefetch_status(void);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index de9b058..61c0c01
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -310,7 +310,7 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 	}
 
 	/* configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
+	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x40, 0x0, len, 0x0);
 	if (ret) {
 		/* PFPW engine is busy, use cpu copy method */
 		if (info->nand.options & NAND_BUSWIDTH_16)
@@ -354,7 +354,7 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 	}
 
 	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x1);
+	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x40, 0x0, len, 0x1);
 	if (ret) {
 		/* PFPW engine is busy, use cpu copy method */
 		if (info->nand.options & NAND_BUSWIDTH_16)
@@ -405,10 +405,11 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	dma_addr_t dma_addr;
 	int ret;
 
-	/* The fifo depth is 64 bytes. We have a sync at each frame and frame
-	 * length is 64 bytes.
+	/* The fifo depth is 64 bytes max.
+	 * But configure the FIFO-threahold to 32 to get a sync at each frame
+	 * and frame length is 32 bytes.
 	 */
-	int buf_len = len >> 6;
+	int buf_len = len >> 5;
 
 	if (addr >= high_memory) {
 		struct page *p1;
@@ -447,7 +448,7 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 					OMAP24XX_DMA_GPMC, OMAP_DMA_SRC_SYNC);
 	}
 	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x1, len, is_write);
+	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x20, 0x1, len, is_write);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy methode */
 		goto out_copy;
@@ -524,6 +525,7 @@ static void omap_write_buf_dma_pref(struct mtd_info *mtd,
 static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 {
 	struct omap_nand_info *info = (struct omap_nand_info *) dev;
+	u32 *p = (u32 *) info->buf;
 	u32 irq_enb = 0, pref_status = 0, bytes = 0;
 	u32 irq_stats = __raw_readl(info->gpmc_baseaddr + GPMC_IRQSTATUS);
 	u32 pref_config = __raw_readl(info->gpmc_baseaddr +
@@ -533,14 +535,11 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 		if (irq_stats & 0x2)
 			goto done;
 
-		u32 *p = (u32 *) info->buf;
-		pref_status = gpmc_prefetch_status();
-		bytes = ((pref_status >> 24) & 0x7F);
+		bytes = PREFETCH_FIFOTHRESHOLD_WRITE;
 		iowrite32_rep(info->nand_pref_fifo_add, p, bytes >> 2);
 		info->buf = info->buf + bytes;
 
 	} else {
-		u32 *p = (u32 *) info->buf;
 		pref_status = gpmc_prefetch_status();
 		bytes = ((pref_status >> 24) & 0x7F);
 		ioread32_rep(info->nand_pref_fifo_add, p, bytes >> 2);
@@ -586,7 +585,8 @@ static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
 	init_completion(&info->comp);
 
 	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
+	ret = gpmc_prefetch_enable(info->gpmc_cs,
+				PREFETCH_FIFOTHRESHOLD_READ, 0x0, len, 0x0);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy methode */
 		goto out_copy;
@@ -630,7 +630,8 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 	init_completion(&info->comp);
 
 	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x1);
+	ret = gpmc_prefetch_enable(info->gpmc_cs,
+				PREFETCH_FIFOTHRESHOLD_WRITE, 0x0, len, 0x1);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy methode */
 		goto out_copy;
