From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 3/3] mtd: nand: omap2: handle nand on gpmc
Date: Fri, 11 May 2012 20:58:26 +0530
Message-ID: <35e883059859ac64596866470e67f847da4222aa.1336748974.git.afzal@ti.com>
References: <cover.1336748974.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55475 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758655Ab2EKPpB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 11:45:01 -0400
In-Reply-To: <cover.1336748974.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dedekind1@gmail.com, ivan.djelic@parrot.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

GPMC driver has been modified to fill NAND platform data with GPMC
NAND register details. As these registers are accessible in NAND
driver itself, configure NAND in GPMC by itself.

Modified prefetch and ecc functions are logically same as the
corresponding exported symbols from GPMC code.

Note: Verfying that other CS have not yet enabled for prefetch & ecc
has to be incorporated. Currently this causes no issues as there are
no boards that use NAND on multiple CS. With ongoing GPMC driver
migration, perhaps it would be better to consider NAND connected on
multiple CS as a single peripheral using multiple CS. This would
make handling multiple CS issues easier.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/nand/omap2.c |  207 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 163 insertions(+), 44 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index c2b0bba..25f930c 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -95,6 +95,16 @@
 #define P4e_s(a)	(TF(a & NAND_Ecc_P4e)		<< 0)
 #define P4o_s(a)	(TF(a & NAND_Ecc_P4o)		<< 1)
 
+#define	PREFETCH_CONFIG1_CS_SHIFT	24
+#define	ECC_CONFIG_CS_SHIFT		1
+#define	CS_MASK				0x7
+#define	ENABLE_PREFETCH			(0x1 << 7)
+#define	DMA_MPU_MODE_SHIFT		2
+#define	ECCSIZE1_SHIFT			22
+#define	ECC1RESULTSIZE			0x1
+#define	ECCCLEAR			0x100
+#define	ECC1				0x1
+
 /* oob info generated runtime depending on ecc algorithm and layout selected */
 static struct nand_ecclayout omap_oobinfo;
 /* Define some generic bad / good block scan pattern which are used
@@ -127,9 +137,70 @@ struct omap_nand_info {
 	} iomode;
 	u_char				*buf;
 	int					buf_len;
+	struct gpmc_nand_regs		reg;
 };
 
 /**
+ * omap_prefetch_enable - configures and starts prefetch transfer
+ * @cs: cs (chip select) number
+ * @fifo_th: fifo threshold to be used for read/ write
+ * @dma_mode: dma mode enable (1) or disable (0)
+ * @u32_count: number of bytes to be transferred
+ * @is_write: prefetch read(0) or write post(1) mode
+ */
+static int omap_prefetch_enable(int cs, int fifo_th, int dma_mode,
+	unsigned int u32_count, int is_write, struct omap_nand_info *info)
+{
+	u32 val;
+
+	if (fifo_th > PREFETCH_FIFOTHRESHOLD_MAX) {
+		pr_err("gpmc: fifo threshold is not supported\n");
+		return -1;
+	} else if (!(readl(info->reg.gpmc_prefetch_control))) {
+		/* Set the amount of bytes to be prefetched */
+		writel(u32_count, info->reg.gpmc_prefetch_config2);
+
+		/* Set dma/mpu mode, the prefetch read / post write and
+		 * enable the engine. Set which cs is has requested for.
+		 */
+		val = ((cs << PREFETCH_CONFIG1_CS_SHIFT) |
+					PREFETCH_FIFOTHRESHOLD(fifo_th) |
+					ENABLE_PREFETCH |
+					(dma_mode << DMA_MPU_MODE_SHIFT) |
+					(0x1 & is_write));
+		writel(val, info->reg.gpmc_prefetch_config1);
+
+		/*  Start the prefetch engine */
+		writel(0x1, info->reg.gpmc_prefetch_control);
+	} else {
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+/**
+ * omap_prefetch_reset - disables and stops the prefetch engine
+ */
+static int omap_prefetch_reset(int cs, struct omap_nand_info *info)
+{
+	u32 config1;
+
+	/* check if the same module/cs is trying to reset */
+	config1 = readl(info->reg.gpmc_prefetch_config1);
+	if (((config1 >> PREFETCH_CONFIG1_CS_SHIFT) & CS_MASK) != cs)
+		return -EINVAL;
+
+	/* Stop the PFPW engine */
+	writel(0x0, info->reg.gpmc_prefetch_control);
+
+	/* Reset/disable the PFPW engine */
+	writel(0x0, info->reg.gpmc_prefetch_config1);
+
+	return 0;
+}
+
+/**
  * omap_hwcontrol - hardware specific access to control-lines
  * @mtd: MTD device structure
  * @cmd: command to device
@@ -147,13 +218,13 @@ static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 	if (cmd != NAND_CMD_NONE) {
 		if (ctrl & NAND_CLE)
-			gpmc_nand_write(info->gpmc_cs, GPMC_NAND_COMMAND, cmd);
+			writeb(cmd, info->reg.gpmc_nand_command);
 
 		else if (ctrl & NAND_ALE)
-			gpmc_nand_write(info->gpmc_cs, GPMC_NAND_ADDRESS, cmd);
+			writeb(cmd, info->reg.gpmc_nand_address);
 
 		else /* NAND_NCE */
-			gpmc_nand_write(info->gpmc_cs, GPMC_NAND_DATA, cmd);
+			writeb(cmd, info->reg.gpmc_nand_data);
 	}
 }
 
@@ -187,7 +258,8 @@ static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
 		iowrite8(*p++, info->nand.IO_ADDR_W);
 		/* wait until buffer is available for write */
 		do {
-			status = gpmc_read_status(GPMC_STATUS_BUFFER);
+			status = readl(info->reg.gpmc_status) &
+					GPMC_STATUS_BUFF_EMPTY;
 		} while (!status);
 	}
 }
@@ -224,7 +296,8 @@ static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 		iowrite16(*p++, info->nand.IO_ADDR_W);
 		/* wait until buffer is available for write */
 		do {
-			status = gpmc_read_status(GPMC_STATUS_BUFFER);
+			status = readl(info->reg.gpmc_status) &
+					GPMC_STATUS_BUFF_EMPTY;
 		} while (!status);
 	}
 }
@@ -254,8 +327,8 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 	}
 
 	/* configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs,
-			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, len, 0x0);
+	ret = omap_prefetch_enable(info->gpmc_cs,
+			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, len, 0x0, info);
 	if (ret) {
 		/* PFPW engine is busy, use cpu copy method */
 		if (info->nand.options & NAND_BUSWIDTH_16)
@@ -264,14 +337,15 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 			omap_read_buf8(mtd, (u_char *)p, len);
 	} else {
 		do {
-			r_count = gpmc_read_status(GPMC_PREFETCH_FIFO_CNT);
+			r_count = readl(info->reg.gpmc_prefetch_status);
+			r_count = GPMC_PREFETCH_STATUS_FIFO_CNT(r_count);
 			r_count = r_count >> 2;
 			ioread32_rep(info->nand.IO_ADDR_R, p, r_count);
 			p += r_count;
 			len -= r_count << 2;
 		} while (len);
 		/* disable and stop the PFPW engine */
-		gpmc_prefetch_reset(info->gpmc_cs);
+		omap_prefetch_reset(info->gpmc_cs, info);
 	}
 }
 
@@ -290,6 +364,7 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 	int i = 0, ret = 0;
 	u16 *p = (u16 *)buf;
 	unsigned long tim, limit;
+	u32 val;
 
 	/* take care of subpage writes */
 	if (len % 2 != 0) {
@@ -299,8 +374,8 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 	}
 
 	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs,
-			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, len, 0x1);
+	ret = omap_prefetch_enable(info->gpmc_cs,
+			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, len, 0x1, info);
 	if (ret) {
 		/* PFPW engine is busy, use cpu copy method */
 		if (info->nand.options & NAND_BUSWIDTH_16)
@@ -309,7 +384,8 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 			omap_write_buf8(mtd, (u_char *)p, len);
 	} else {
 		while (len) {
-			w_count = gpmc_read_status(GPMC_PREFETCH_FIFO_CNT);
+			w_count = readl(info->reg.gpmc_prefetch_status);
+			w_count = GPMC_PREFETCH_STATUS_FIFO_CNT(w_count);
 			w_count = w_count >> 1;
 			for (i = 0; (i < w_count) && len; i++, len -= 2)
 				iowrite16(*p++, info->nand.IO_ADDR_W);
@@ -318,11 +394,14 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 		tim = 0;
 		limit = (loops_per_jiffy *
 					msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
-		while (gpmc_read_status(GPMC_PREFETCH_COUNT) && (tim++ < limit))
+		do {
 			cpu_relax();
+			val = readl(info->reg.gpmc_prefetch_status);
+			val = GPMC_PREFETCH_STATUS_COUNT(val);
+		} while (val && (tim++ < limit));
 
 		/* disable and stop the PFPW engine */
-		gpmc_prefetch_reset(info->gpmc_cs);
+		omap_prefetch_reset(info->gpmc_cs, info);
 	}
 }
 
@@ -354,6 +433,7 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	dma_addr_t dma_addr;
 	int ret;
 	unsigned long tim, limit;
+	u32 val;
 
 	/* The fifo depth is 64 bytes max.
 	 * But configure the FIFO-threahold to 32 to get a sync at each frame
@@ -398,8 +478,8 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 					OMAP24XX_DMA_GPMC, OMAP_DMA_SRC_SYNC);
 	}
 	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs,
-			PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write);
+	ret = omap_prefetch_enable(info->gpmc_cs,
+			PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write, info);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy method */
 		goto out_copy;
@@ -412,11 +492,15 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	wait_for_completion(&info->comp);
 	tim = 0;
 	limit = (loops_per_jiffy * msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
-	while (gpmc_read_status(GPMC_PREFETCH_COUNT) && (tim++ < limit))
+
+	do {
 		cpu_relax();
+		val = readl(info->reg.gpmc_prefetch_status);
+		val = GPMC_PREFETCH_STATUS_COUNT(val);
+	} while (val && (tim++ < limit));
 
 	/* disable and stop the PFPW engine */
-	gpmc_prefetch_reset(info->gpmc_cs);
+	omap_prefetch_reset(info->gpmc_cs, info);
 
 	dma_unmap_single(&info->pdev->dev, dma_addr, len, dir);
 	return 0;
@@ -474,7 +558,8 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 	u32 irq_stat;
 
 	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
-	bytes = gpmc_read_status(GPMC_PREFETCH_FIFO_CNT);
+	bytes = readl(info->reg.gpmc_prefetch_status);
+	bytes = GPMC_PREFETCH_STATUS_FIFO_CNT(bytes);
 	bytes = bytes  & 0xFFFC; /* io in multiple of 4 bytes */
 	if (info->iomode == OMAP_NAND_IO_WRITE) { /* checks for write io */
 		if (irq_stat & 0x2)
@@ -534,8 +619,8 @@ static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
 	init_completion(&info->comp);
 
 	/*  configure and start prefetch transfer */
-	ret = gpmc_prefetch_enable(info->gpmc_cs,
-			PREFETCH_FIFOTHRESHOLD_MAX/2, 0x0, len, 0x0);
+	ret = omap_prefetch_enable(info->gpmc_cs,
+			PREFETCH_FIFOTHRESHOLD_MAX/2, 0x0, len, 0x0, info);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy method */
 		goto out_copy;
@@ -549,7 +634,7 @@ static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
 	wait_for_completion(&info->comp);
 
 	/* disable and stop the PFPW engine */
-	gpmc_prefetch_reset(info->gpmc_cs);
+	omap_prefetch_reset(info->gpmc_cs, info);
 	return;
 
 out_copy:
@@ -572,6 +657,7 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 						struct omap_nand_info, mtd);
 	int ret = 0;
 	unsigned long tim, limit;
+	u32 val;
 
 	if (len <= mtd->oobsize) {
 		omap_write_buf_pref(mtd, buf, len);
@@ -583,8 +669,8 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 	init_completion(&info->comp);
 
 	/* configure and start prefetch transfer : size=24 */
-	ret = gpmc_prefetch_enable(info->gpmc_cs,
-			(PREFETCH_FIFOTHRESHOLD_MAX * 3) / 8, 0x0, len, 0x1);
+	ret = omap_prefetch_enable(info->gpmc_cs,
+		(PREFETCH_FIFOTHRESHOLD_MAX * 3) / 8, 0x0, len, 0x1, info);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy method */
 		goto out_copy;
@@ -599,11 +685,14 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 	/* wait for data to flushed-out before reset the prefetch */
 	tim = 0;
 	limit = (loops_per_jiffy *  msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
-	while (gpmc_read_status(GPMC_PREFETCH_COUNT) && (tim++ < limit))
+	do {
+		val = readl(info->reg.gpmc_prefetch_status);
+		val = GPMC_PREFETCH_STATUS_COUNT(val);
 		cpu_relax();
+	} while (val && (tim++ < limit));
 
 	/* disable and stop the PFPW engine */
-	gpmc_prefetch_reset(info->gpmc_cs);
+	omap_prefetch_reset(info->gpmc_cs, info);
 	return;
 
 out_copy:
@@ -843,7 +932,20 @@ static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	return gpmc_calculate_ecc(info->gpmc_cs, dat, ecc_code);
+	u32 val;
+
+	val = readl(info->reg.gpmc_ecc_config);
+	if (((val >> ECC_CONFIG_CS_SHIFT)  & ~CS_MASK) != info->gpmc_cs)
+		return -EINVAL;
+
+	/* read ecc result */
+	val = readl(info->reg.gpmc_ecc1_result);
+	*ecc_code++ = val;          /* P128e, ..., P1e */
+	*ecc_code++ = val >> 16;    /* P128o, ..., P1o */
+	/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
+	*ecc_code++ = ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
+
+	return 0;
 }
 
 /**
@@ -857,8 +959,34 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 							mtd);
 	struct nand_chip *chip = mtd->priv;
 	unsigned int dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
+	u32 val;
+
+	/* clear ecc and enable bits */
+	val = ECCCLEAR | ECC1;
+	writel(val, info->reg.gpmc_ecc_control);
+
+	/* program ecc and result sizes */
+	val = ((((info->nand.ecc.size >> 1) - 1) << ECCSIZE1_SHIFT) |
+			 ECC1RESULTSIZE);
+	writel(val, info->reg.gpmc_ecc_size_config);
+
+	switch (mode) {
+	case NAND_ECC_READ:
+	case NAND_ECC_WRITE:
+		writel(ECCCLEAR | ECC1, info->reg.gpmc_ecc_control);
+		break;
+	case NAND_ECC_READSYN:
+		writel(ECCCLEAR, info->reg.gpmc_ecc_control);
+		break;
+	default:
+		dev_info(&info->pdev->dev,
+			"error: unrecognized Mode[%d]!\n", mode);
+		break;
+	}
 
-	gpmc_enable_hwecc(info->gpmc_cs, mode, dev_width, info->nand.ecc.size);
+	/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
+	val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
+	writel(val, info->reg.gpmc_ecc_config);
 }
 
 /**
@@ -886,10 +1014,9 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 	else
 		timeo += (HZ * 20) / 1000;
 
-	gpmc_nand_write(info->gpmc_cs,
-			GPMC_NAND_COMMAND, (NAND_CMD_STATUS & 0xFF));
+	writeb(NAND_CMD_STATUS & 0xFF, info->reg.gpmc_nand_command);
 	while (time_before(jiffies, timeo)) {
-		status = gpmc_nand_read(info->gpmc_cs, GPMC_NAND_DATA);
+		status = readb(info->reg.gpmc_nand_data);
 		if (status & NAND_STATUS_READY)
 			break;
 		cond_resched();
@@ -907,22 +1034,13 @@ static int omap_dev_ready(struct mtd_info *mtd)
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
 
-	val = gpmc_read_status(GPMC_GET_IRQ_STATUS);
+	val = readl(info->reg.gpmc_status);
+
 	if ((val & 0x100) == 0x100) {
-		/* Clear IRQ Interrupt */
-		val |= 0x100;
-		val &= ~(0x0);
-		gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, val);
+		return 1;
 	} else {
-		unsigned int cnt = 0;
-		while (cnt++ < 0x1FF) {
-			if  ((val & 0x100) == 0x100)
-				return 0;
-			val = gpmc_read_status(GPMC_GET_IRQ_STATUS);
-		}
+		return 0;
 	}
-
-	return 1;
 }
 
 static int __devinit omap_nand_probe(struct platform_device *pdev)
@@ -951,6 +1069,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 
 	info->gpmc_cs		= pdata->cs;
 	info->phys_base		= pdata->phys_base;
+	info->reg		= pdata->reg;
 
 	info->mtd.priv		= &info->nand;
 	info->mtd.name		= dev_name(&pdev->dev);
-- 
1.7.10

