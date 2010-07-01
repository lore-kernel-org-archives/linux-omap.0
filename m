From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v2 2/4] omap3: nand: configurable fifo threshold to gain the throughput
Date: Thu,  1 Jul 2010 16:12:13 +0530
Message-ID: <1277980935-24070-3-git-send-email-s-ghorai@ti.com>
References: <1277980935-24070-1-git-send-email-s-ghorai@ti.com>
 <1277980935-24070-2-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60345 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab0GAKmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 06:42:25 -0400
In-Reply-To: <1277980935-24070-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

  Configure the FIFO THREASHOLD value different for read and write to keep busy both
  filling and to drain out of FIFO at reading and writing.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   11 +++++++----
 arch/arm/plat-omap/include/plat/gpmc.h |    5 ++++-
 drivers/mtd/nand/omap2.c               |   24 +++++++++++++++---------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 4e12a9f..cb38cff
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -58,7 +58,6 @@
 #define GPMC_CHUNK_SHIFT	24		/* 16 MB */
 #define GPMC_SECTION_SHIFT	28		/* 128 MB */
 
-#define PREFETCH_FIFOTHRESHOLD	(0x40 << 8)
 #define CS_NUM_SHIFT		24
 #define ENABLE_PREFETCH		(0x1 << 7)
 #define DMA_MPU_MODE		2
@@ -538,15 +537,19 @@ EXPORT_SYMBOL(gpmc_hwcontrol);
 /**
  * gpmc_prefetch_enable - configures and starts prefetch transfer
  * @cs: cs (chip select) number
+ * @fifo_th: fifo threshold to be used for read/ write
  * @dma_mode: dma mode enable (1) or disable (0)
  * @u32_count: number of bytes to be transferred
  * @is_write: prefetch read(0) or write post(1) mode
  */
-int gpmc_prefetch_enable(int cs, int dma_mode,
+int gpmc_prefetch_enable(int cs, int fifo_th, int dma_mode,
 				unsigned int u32_count, int is_write)
 {
 
-	if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {
+	if (fifo_th > PREFETCH_FIFOTHRESHOLD_MAX) {
+		printk(KERN_ERR "PREFETCH Fifo Threshold is not supported\n");
+		return -1;
+	} else if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {
 		/* Set the amount of bytes to be prefetched */
 		gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_count);
 
@@ -554,7 +557,7 @@ int gpmc_prefetch_enable(int cs, int dma_mode,
 		 * enable the engine. Set which cs is has requested for.
 		 */
 		gpmc_write_reg(GPMC_PREFETCH_CONFIG1, ((cs << CS_NUM_SHIFT) |
-					PREFETCH_FIFOTHRESHOLD |
+					PREFETCH_FIFOTHRESHOLD(fifo_th) |
 					ENABLE_PREFETCH |
 					(dma_mode << DMA_MPU_MODE) |
 					(0x1 & is_write)));
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 4bdd851..40ce1db
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -79,6 +79,9 @@
 #define GPMC_IRQ_FIFOEVENTENABLE	0x01
 #define GPMC_IRQ_COUNT_EVENT		0x02
 
+#define PREFETCH_FIFOTHRESHOLD_MAX	0x40
+#define PREFETCH_FIFOTHRESHOLD(val)	(val << 8)
+
 /*
  * Note that all values in this struct are in nanoseconds, while
  * the register values are in gpmc_fck cycles.
@@ -129,7 +132,7 @@ extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
 extern int gpmc_cs_set_reserved(int cs, int reserved);
 extern int gpmc_cs_reserved(int cs);
-extern int gpmc_prefetch_enable(int cs, int dma_mode,
+extern int gpmc_prefetch_enable(int cs, int fifo_th, int dma_mode,
 					unsigned int u32_count, int is_write);
 extern int gpmc_prefetch_reset(int cs);
 extern void omap3_gpmc_save_context(void);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 2fbdd66..f136fb5
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -280,7 +280,8 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 	}
 
 	/* configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
+	ret = gpmc_prefetch_enable(info->gpmc_cs,
+			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, len, 0x0);
 	if (ret) {
 		/* PFPW engine is busy, use cpu copy method */
 		if (info->nand.options & NAND_BUSWIDTH_16)
@@ -325,7 +326,8 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 	}
 
 	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x1);
+	ret = gpmc_prefetch_enable(info->gpmc_cs,
+			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, len, 0x1);
 	if (ret) {
 		/* PFPW engine is busy, use cpu copy method */
 		if (info->nand.options & NAND_BUSWIDTH_16)
@@ -381,10 +383,11 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
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
@@ -423,7 +426,8 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 					OMAP24XX_DMA_GPMC, OMAP_DMA_SRC_SYNC);
 	}
 	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x1, len, is_write);
+	ret = gpmc_prefetch_enable(info->gpmc_cs,
+			PREFETCH_FIFOTHRESHOLD_MAX/2, 0x1, len, is_write);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy methode */
 		goto out_copy;
@@ -570,7 +574,8 @@ static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
 	init_completion(&info->comp);
 
 	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
+	ret = gpmc_prefetch_enable(info->gpmc_cs,
+			PREFETCH_FIFOTHRESHOLD_MAX/2, 0x0, len, 0x0);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy methode */
 		goto out_copy;
@@ -615,8 +620,9 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 	info->buf = (u_char *) buf;
 	init_completion(&info->comp);
 
-	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x1);
+	/* configure and start prefetch transfer : size=24 */
+	ret = gpmc_prefetch_enable(info->gpmc_cs,
+			(PREFETCH_FIFOTHRESHOLD_MAX*3)/8, 0x0, len, 0x1);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy methode */
 		goto out_copy;
