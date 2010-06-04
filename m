From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v5 2/3] omap3 nand: cleanup virtual address usages
Date: Fri,  4 Jun 2010 13:10:04 +0530
Message-ID: <1275637205-489-3-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1275637205-489-1-git-send-email-s-ghorai@ti.com>
 <1275637205-489-2-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37628 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767Ab0FDHk2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jun 2010 03:40:28 -0400
In-Reply-To: <1275637205-489-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, tony@atomide.com, mike@compulab.co.il, Sukumar Ghorai <s-ghorai@ti.com>

This patch removes direct reference of gpmc address from generic nand platform code.
Nand platform code now uses wrapper functions which are implemented in gpmc module. 

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c        |   39 ++----
 arch/arm/mach-omap2/gpmc.c             |    9 --
 arch/arm/plat-omap/include/plat/gpmc.h |    5 -
 arch/arm/plat-omap/include/plat/nand.h |    6 +-
 drivers/mtd/nand/omap2.c               |  225 +++++++++-----------------------
 5 files changed, 77 insertions(+), 207 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index e57fb29..80f5d94
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -19,8 +19,6 @@
 #include <plat/board.h>
 #include <plat/gpmc.h>
 
-#define WR_RD_PIN_MONITORING	0x00600000
-
 static struct omap_nand_platform_data *gpmc_nand_data;
 
 static struct resource gpmc_nand_resource = {
@@ -71,10 +69,10 @@ static int omap2_nand_gpmc_retime(void)
 	t.wr_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->wr_cycle);
 
 	/* Configure GPMC */
-	gpmc_cs_write_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG1,
-			GPMC_CONFIG1_DEVICESIZE(gpmc_nand_data->devsize) |
-			GPMC_CONFIG1_DEVICETYPE_NAND);
-
+	gpmc_hwcontrol(gpmc_nand_data->cs,
+			GPMC_CONFIG_DEV_SIZE, 1, gpmc_nand_data->devsize, NULL);
+	gpmc_hwcontrol(gpmc_nand_data->cs,
+			GPMC_CONFIG_DEV_TYPE, 1, GPMC_DEVICETYPE_NAND, NULL);
 	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
 	if (err)
 		return err;
@@ -82,27 +80,13 @@ static int omap2_nand_gpmc_retime(void)
 	return 0;
 }
 
-static int gpmc_nand_setup(void)
-{
-	struct device *dev = &gpmc_nand_device.dev;
-
-	/* Set timings in GPMC */
-	if (omap2_nand_gpmc_retime() < 0) {
-		dev_err(dev, "Unable to set gpmc timings\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
 {
-	unsigned int val;
 	int err	= 0;
 	struct device *dev = &gpmc_nand_device.dev;
 
 	gpmc_nand_data = _nand_data;
-	gpmc_nand_data->nand_setup = gpmc_nand_setup;
+	gpmc_nand_data->nand_setup = omap2_nand_gpmc_retime;
 	gpmc_nand_device.dev.platform_data = gpmc_nand_data;
 
 	err = gpmc_cs_request(gpmc_nand_data->cs, NAND_IO_SIZE,
@@ -112,19 +96,17 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
 		return err;
 	}
 
-	err = gpmc_nand_setup();
+	 /* Set timings in GPMC */
+	err = omap2_nand_gpmc_retime();
 	if (err < 0) {
-		dev_err(dev, "NAND platform setup failed: %d\n", err);
+		dev_err(dev, "Unable to set gpmc timings: %d\n", err);
 		return err;
 	}
 
 	/* Enable RD PIN Monitoring Reg */
 	if (gpmc_nand_data->dev_ready) {
-		val  = gpmc_cs_read_reg(gpmc_nand_data->cs,
-						 GPMC_CS_CONFIG1);
-		val |= WR_RD_PIN_MONITORING;
-		gpmc_cs_write_reg(gpmc_nand_data->cs,
-						GPMC_CS_CONFIG1, val);
+		gpmc_hwcontrol(gpmc_nand_data->cs,
+					GPMC_CONFIG_RDY_BSY, 1, 1, NULL);
 	}
 
 	err = platform_device_register(&gpmc_nand_device);
@@ -140,3 +122,4 @@ out_free_cs:
 
 	return err;
 }
+
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 48b5af0..91e1526 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -584,15 +584,6 @@ int gpmc_prefetch_reset(int cs)
 }
 EXPORT_SYMBOL(gpmc_prefetch_reset);
 
-/**
- * gpmc_prefetch_status - reads prefetch status of engine
- */
-int  gpmc_prefetch_status(void)
-{
-	return gpmc_read_reg(GPMC_PREFETCH_STATUS);
-}
-EXPORT_SYMBOL(gpmc_prefetch_status);
-
 static void __init gpmc_mem_init(void)
 {
 	int cs;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 8a1e9d9..ccbc530
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -25,9 +25,6 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24
 
-#define GPMC_CONFIG		0x50
-#define GPMC_STATUS		0x54
-
 /* Control Commands */
 #define GPMC_CONFIG_WP		0x00000001
 #define GPMC_CONFIG_RDY_BSY	0x00000002
@@ -63,7 +60,6 @@
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
 #define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
 #define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
-#define GPMC_CONFIG1_DEVICETYPE_NAND    GPMC_CONFIG1_DEVICETYPE(2)
 #define GPMC_CONFIG1_MUXADDDATA         (1 << 9)
 #define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
 #define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
@@ -133,7 +129,6 @@ extern int gpmc_cs_reserved(int cs);
 extern int gpmc_prefetch_enable(int cs, int dma_mode,
 					unsigned int u32_count, int is_write);
 extern int gpmc_prefetch_reset(int cs);
-extern int gpmc_prefetch_status(void);
 extern void omap3_gpmc_save_context(void);
 extern void omap3_gpmc_restore_context(void);
 extern void gpmc_init(void);
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index f8efd54..6562cd0
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -21,13 +21,11 @@ struct omap_nand_platform_data {
 	int			(*dev_ready)(struct omap_nand_platform_data *);
 	int			dma_channel;
 	unsigned long		phys_base;
-	void __iomem		*gpmc_cs_baseaddr;
-	void __iomem		*gpmc_baseaddr;
 	int			devsize;
 };
 
-/* size (4 KiB) for IO mapping */
-#define	NAND_IO_SIZE	SZ_4K
+/* minimum size for IO mapping */
+#define	NAND_IO_SIZE	4
 
 #if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
 extern int gpmc_nand_init(struct omap_nand_platform_data *d);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index ec8eb31..f9fa3cb
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -7,6 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#define CONFIG_MTD_NAND_OMAP_HWECC
 
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -23,20 +24,8 @@
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 
-#define GPMC_IRQ_STATUS		0x18
-#define GPMC_ECC_CONFIG		0x1F4
-#define GPMC_ECC_CONTROL	0x1F8
-#define GPMC_ECC_SIZE_CONFIG	0x1FC
-#define GPMC_ECC1_RESULT	0x200
-
 #define	DRIVER_NAME	"omap2-nand"
 
-#define	NAND_WP_OFF	0
-#define NAND_WP_BIT	0x00000010
-
-#define	GPMC_BUF_FULL	0x00000001
-#define	GPMC_BUF_EMPTY	0x00000000
-
 #define NAND_Ecc_P1e		(1 << 0)
 #define NAND_Ecc_P2e		(1 << 1)
 #define NAND_Ecc_P4e		(1 << 2)
@@ -139,34 +128,11 @@ struct omap_nand_info {
 
 	int				gpmc_cs;
 	unsigned long			phys_base;
-	void __iomem			*gpmc_cs_baseaddr;
-	void __iomem			*gpmc_baseaddr;
-	void __iomem			*nand_pref_fifo_add;
 	struct completion		comp;
 	int				dma_ch;
 };
 
 /**
- * omap_nand_wp - This function enable or disable the Write Protect feature
- * @mtd: MTD device structure
- * @mode: WP ON/OFF
- */
-static void omap_nand_wp(struct mtd_info *mtd, int mode)
-{
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
-
-	unsigned long config = __raw_readl(info->gpmc_baseaddr + GPMC_CONFIG);
-
-	if (mode)
-		config &= ~(NAND_WP_BIT);	/* WP is ON */
-	else
-		config |= (NAND_WP_BIT);	/* WP is OFF */
-
-	__raw_writel(config, (info->gpmc_baseaddr + GPMC_CONFIG));
-}
-
-/**
  * omap_hwcontrol - hardware specific access to control-lines
  * @mtd: MTD device structure
  * @cmd: command to device
@@ -181,31 +147,20 @@ static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct omap_nand_info *info = container_of(mtd,
 					struct omap_nand_info, mtd);
-	switch (ctrl) {
-	case NAND_CTRL_CHANGE | NAND_CTRL_CLE:
-		info->nand.IO_ADDR_W = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_COMMAND;
-		info->nand.IO_ADDR_R = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		break;
-
-	case NAND_CTRL_CHANGE | NAND_CTRL_ALE:
-		info->nand.IO_ADDR_W = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_ADDRESS;
-		info->nand.IO_ADDR_R = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		break;
-
-	case NAND_CTRL_CHANGE | NAND_NCE:
-		info->nand.IO_ADDR_W = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		info->nand.IO_ADDR_R = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		break;
-	}
 
-	if (cmd != NAND_CMD_NONE)
-		__raw_writeb(cmd, info->nand.IO_ADDR_W);
+	if (cmd != NAND_CMD_NONE) {
+		if (ctrl & NAND_CLE)
+			gpmc_hwcontrol(info->gpmc_cs,
+					GPMC_NAND_COMMAND, 1, cmd, NULL);
+
+		else if (ctrl & NAND_ALE)
+			gpmc_hwcontrol(info->gpmc_cs,
+					GPMC_NAND_ADDRESS, 1, cmd, NULL);
+
+		else /* NAND_NCE */
+			gpmc_hwcontrol(info->gpmc_cs,
+					GPMC_NAND_DATA, 1, cmd, NULL);
+	}
 }
 
 /**
@@ -232,11 +187,15 @@ static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
 	struct omap_nand_info *info = container_of(mtd,
 						struct omap_nand_info, mtd);
 	u_char *p = (u_char *)buf;
+	u32	status = 0;
 
 	while (len--) {
 		iowrite8(*p++, info->nand.IO_ADDR_W);
-		while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
-						GPMC_STATUS) & GPMC_BUF_FULL));
+		/* wait until buffer is available for write */
+		do {
+			gpmc_hwcontrol(info->gpmc_cs,
+					GPMC_STATUS_BUFFER, 0, 0, &status);
+		} while (!status);
 	}
 }
 
@@ -264,16 +223,17 @@ static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 	struct omap_nand_info *info = container_of(mtd,
 						struct omap_nand_info, mtd);
 	u16 *p = (u16 *) buf;
-
+	u32	status = 0;
 	/* FIXME try bursts of writesw() or DMA ... */
 	len >>= 1;
 
 	while (len--) {
 		iowrite16(*p++, info->nand.IO_ADDR_W);
-
-		while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
-						GPMC_STATUS) & GPMC_BUF_FULL))
-			;
+		/* wait until buffer is available for write */
+		do {
+			gpmc_hwcontrol(info->gpmc_cs,
+					GPMC_STATUS_BUFFER, 0, 0, &status);
+		} while (!status);
 	}
 }
 
@@ -287,7 +247,7 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 {
 	struct omap_nand_info *info = container_of(mtd,
 						struct omap_nand_info, mtd);
-	uint32_t pfpw_status = 0, r_count = 0;
+	uint32_t r_count = 0;
 	int ret = 0;
 	u32 *p = (u32 *)buf;
 
@@ -310,14 +270,15 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 		else
 			omap_read_buf8(mtd, buf, len);
 	} else {
+		p = (u32 *) buf;
 		do {
-			pfpw_status = gpmc_prefetch_status();
-			r_count = ((pfpw_status >> 24) & 0x7F) >> 2;
-			ioread32_rep(info->nand_pref_fifo_add, p, r_count);
+			gpmc_hwcontrol(info->gpmc_cs,
+				GPMC_PREFETCH_FIFO_CNT, 0, 0, &r_count);
+			r_count = r_count >> 2;
+			ioread32_rep(info->nand.IO_ADDR_R, p, r_count);
 			p += r_count;
 			len -= r_count << 2;
 		} while (len);
-
 		/* disable and stop the PFPW engine */
 		gpmc_prefetch_reset(info->gpmc_cs);
 	}
@@ -334,13 +295,13 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 {
 	struct omap_nand_info *info = container_of(mtd,
 						struct omap_nand_info, mtd);
-	uint32_t pfpw_status = 0, w_count = 0;
+	uint32_t pref_count = 0, w_count = 0;
 	int i = 0, ret = 0;
-	u16 *p = (u16 *) buf;
+	u16 *p;
 
 	/* take care of subpage writes */
 	if (len % 2 != 0) {
-		writeb(*buf, info->nand.IO_ADDR_R);
+		writeb(*buf, info->nand.IO_ADDR_W);
 		p = (u16 *)(buf + 1);
 		len--;
 	}
@@ -354,14 +315,19 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 		else
 			omap_write_buf8(mtd, buf, len);
 	} else {
-		pfpw_status = gpmc_prefetch_status();
-		while (pfpw_status & 0x3FFF) {
-			w_count = ((pfpw_status >> 24) & 0x7F) >> 1;
+		p = (u16 *) buf;
+		while (len) {
+			gpmc_hwcontrol(info->gpmc_cs,
+					GPMC_PREFETCH_FIFO_CNT, 0, 0, &w_count);
+			w_count = w_count >> 1;
 			for (i = 0; (i < w_count) && len; i++, len -= 2)
-				iowrite16(*p++, info->nand_pref_fifo_add);
-			pfpw_status = gpmc_prefetch_status();
+				iowrite16(*p++, info->nand.IO_ADDR_W);
 		}
-
+		/* wait for data to flushed-out before reset the prefetch */
+		do {
+			gpmc_hwcontrol(info->gpmc_cs,
+				GPMC_PREFETCH_COUNT, 0, 0, &pref_count);
+		} while (pref_count);
 		/* disable and stop the PFPW engine */
 		gpmc_prefetch_reset(info->gpmc_cs);
 	}
@@ -451,8 +417,10 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	/* setup and start DMA using dma_addr */
 	wait_for_completion(&info->comp);
 
-	while (0x3fff & (prefetch_status = gpmc_prefetch_status()))
-		;
+	do {
+		gpmc_hwcontrol(info->gpmc_cs,
+				GPMC_PREFETCH_COUNT, 0, 0, &prefetch_status);
+	} while (prefetch_status);
 	/* disable and stop the PFPW engine */
 	gpmc_prefetch_reset();
 
@@ -530,29 +498,6 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
 }
 
 #ifdef CONFIG_MTD_NAND_OMAP_HWECC
-/**
- * omap_hwecc_init - Initialize the HW ECC for NAND flash in GPMC controller
- * @mtd: MTD device structure
- */
-static void omap_hwecc_init(struct mtd_info *mtd)
-{
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
-	struct nand_chip *chip = mtd->priv;
-	unsigned long val = 0x0;
-
-	/* Read from ECC Control Register */
-	val = __raw_readl(info->gpmc_baseaddr + GPMC_ECC_CONTROL);
-	/* Clear all ECC | Enable Reg1 */
-	val = ((0x00000001<<8) | 0x00000001);
-	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
-
-	/* Read from ECC Size Config Register */
-	val = __raw_readl(info->gpmc_baseaddr + GPMC_ECC_SIZE_CONFIG);
-	/* ECCSIZE1=512 | Select eccResultsize[0-3] */
-	val = ((((chip->ecc.size >> 1) - 1) << 22) | (0x0000000F));
-	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_SIZE_CONFIG);
-}
 
 /**
  * gen_true_ecc - This function will generate true ECC value
@@ -755,19 +700,7 @@ static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	unsigned long val = 0x0;
-	unsigned long reg;
-
-	/* Start Reading from HW ECC1_Result = 0x200 */
-	reg = (unsigned long)(info->gpmc_baseaddr + GPMC_ECC1_RESULT);
-	val = __raw_readl(reg);
-	*ecc_code++ = val;          /* P128e, ..., P1e */
-	*ecc_code++ = val >> 16;    /* P128o, ..., P1o */
-	/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
-	*ecc_code++ = ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
-	reg += 4;
-
-	return 0;
+	return gpmc_calculate_ecc(info->gpmc_cs, dat, ecc_code);
 }
 
 /**
@@ -781,32 +714,10 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 							mtd);
 	struct nand_chip *chip = mtd->priv;
 	unsigned int dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
-	unsigned long val = __raw_readl(info->gpmc_baseaddr + GPMC_ECC_CONFIG);
-
-	switch (mode) {
-	case NAND_ECC_READ:
-		__raw_writel(0x101, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
-		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
-		val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
-		break;
-	case NAND_ECC_READSYN:
-		 __raw_writel(0x100, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
-		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
-		val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
-		break;
-	case NAND_ECC_WRITE:
-		__raw_writel(0x101, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
-		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
-		val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
-		break;
-	default:
-		DEBUG(MTD_DEBUG_LEVEL0, "Error: Unrecognized Mode[%d]!\n",
-					mode);
-		break;
-	}
 
-	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONFIG);
+	gpmc_enable_hwecc(info->gpmc_cs, mode, dev_width, info->nand.ecc.size);
 }
+
 #endif
 
 /**
@@ -834,14 +745,10 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 	else
 		timeo += (HZ * 20) / 1000;
 
-	this->IO_ADDR_W = (void *) info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_COMMAND;
-	this->IO_ADDR_R = (void *) info->gpmc_cs_baseaddr + GPMC_CS_NAND_DATA;
-
-	__raw_writeb(NAND_CMD_STATUS & 0xFF, this->IO_ADDR_W);
-
+	gpmc_hwcontrol(info->gpmc_cs,
+			GPMC_NAND_COMMAND, 1,  (NAND_CMD_STATUS & 0xFF), NULL);
 	while (time_before(jiffies, timeo)) {
-		status = __raw_readb(this->IO_ADDR_R);
+		gpmc_hwcontrol(info->gpmc_cs, GPMC_NAND_DATA, 0,  0, &status);
 		if (status & NAND_STATUS_READY)
 			break;
 		cond_resched();
@@ -855,22 +762,24 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
  */
 static int omap_dev_ready(struct mtd_info *mtd)
 {
+	unsigned int val = 0;
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	unsigned int val = __raw_readl(info->gpmc_baseaddr + GPMC_IRQ_STATUS);
 
+	gpmc_hwcontrol(info->gpmc_cs, GPMC_GET_SET_IRQ_STATUS, 0, 0, &val);
 	if ((val & 0x100) == 0x100) {
 		/* Clear IRQ Interrupt */
 		val |= 0x100;
 		val &= ~(0x0);
-		__raw_writel(val, info->gpmc_baseaddr + GPMC_IRQ_STATUS);
+		gpmc_hwcontrol(info->gpmc_cs,
+			GPMC_GET_SET_IRQ_STATUS, 1, val, NULL);
 	} else {
 		unsigned int cnt = 0;
 		while (cnt++ < 0x1FF) {
 			if  ((val & 0x100) == 0x100)
 				return 0;
-			val = __raw_readl(info->gpmc_baseaddr +
-							GPMC_IRQ_STATUS);
+			gpmc_hwcontrol(info->gpmc_cs,
+				GPMC_GET_SET_IRQ_STATUS, 0, 0, &val);
 		}
 	}
 
@@ -901,8 +810,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->pdev = pdev;
 
 	info->gpmc_cs		= pdata->cs;
-	info->gpmc_baseaddr	= pdata->gpmc_baseaddr;
-	info->gpmc_cs_baseaddr	= pdata->gpmc_cs_baseaddr;
 	info->phys_base		= pdata->phys_base;
 
 	info->mtd.priv		= &info->nand;
@@ -913,7 +820,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->nand.options	|= NAND_SKIP_BBTSCAN;
 
 	/* NAND write protect off */
-	omap_nand_wp(&info->mtd, NAND_WP_OFF);
+	gpmc_hwcontrol(info->gpmc_cs, GPMC_CONFIG_WP, 1, 0, NULL);
 
 	if (!request_mem_region(info->phys_base, NAND_IO_SIZE,
 				pdev->dev.driver->name)) {
@@ -948,8 +855,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	}
 
 	if (use_prefetch) {
-		/* copy the virtual address of nand base for fifo access */
-		info->nand_pref_fifo_add = info->nand.IO_ADDR_R;
 
 		info->nand.read_buf   = omap_read_buf_pref;
 		info->nand.write_buf  = omap_write_buf_pref;
@@ -989,8 +894,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->nand.ecc.correct		= omap_correct_data;
 	info->nand.ecc.mode		= NAND_ECC_HW;
 
-	/* init HW ECC */
-	omap_hwecc_init(&info->mtd);
 #else
 	info->nand.ecc.mode = NAND_ECC_SOFT;
 #endif
@@ -1040,7 +943,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
-	iounmap(info->nand_pref_fifo_add);
+	iounmap(info->nand.IO_ADDR_R);
 	kfree(&info->mtd);
 	return 0;
 }
