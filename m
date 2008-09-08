From: nskamat@ti.com
Subject: [Resend][PATCH - Omapzoom][NAND] Add prefetch and DMA support
Date: Mon,  8 Sep 2008 13:03:35 -0500
Message-ID: <1220897015-14338-1-git-send-email-nskamat@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54487 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724AbYIHSDn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Sep 2008 14:03:43 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m88I3ciR009045
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 13:03:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vimal Singh <vimalsingh@ti.com>, Nishant Kamat <nskamat@ti.com>

From: Vimal Singh <vimalsingh@ti.com>

Following patch taken over the omapzoom.org tree adds
prefetch and DMA support to the OMAP2/3 nand driver.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Nishant Kamat <nskamat@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   95 +++++++++++++++
 arch/arm/plat-omap/include/mach/gpmc.h |    4 
 drivers/mtd/nand/Kconfig               |   30 ++++
 drivers/mtd/nand/omap2.c               |  199 ++++++++++++++++++++++++++++++---
 4 files changed, 310 insertions(+), 18 deletions(-)

Index: omapkernel/arch/arm/mach-omap2/gpmc.c
===================================================================
--- omapkernel.orig/arch/arm/mach-omap2/gpmc.c	2008-09-08 18:23:29.000000000 +0530
+++ omapkernel/arch/arm/mach-omap2/gpmc.c	2008-09-08 18:34:22.000000000 +0530
@@ -54,6 +54,12 @@
 #define GPMC_CHUNK_SHIFT	24		/* 16 MB */
 #define GPMC_SECTION_SHIFT	28		/* 128 MB */
 
+#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
+#define CS_NUM_SHIFT		24
+#define ENABLE_PREFETCH		7
+#define DMA_MPU_MODE		2
+#endif
+
 #ifdef CONFIG_OMAP3_PM
 /*
  * Structure to save/restore gpmc context
@@ -407,6 +413,92 @@
 }
 EXPORT_SYMBOL(gpmc_cs_free);
 
+#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
+/*
+ * gpmc_prefetch_init - configures default configuration for prefetch engine
+ */
+static void gpmc_prefetch_init(void)
+{
+	/* Setting the default threshold to 64 */
+	gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x0);
+	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, 0x40  << 8);
+	gpmc_write_reg(GPMC_PREFETCH_CONFIG2, 0x0);
+}
+
+/*
+ * gpmc_prefetch_start - configures and starts prefetch transfer
+ * @cs - nand cs (chip select) number
+ * @dma_mode: dma mode enable (1) or disable (0)
+ * @u32_count: number of bytes to be transferred
+ * @is_write: prefetch read(0) or write post(1) mode
+ */
+void gpmc_prefetch_start(int cs, int dma_mode,
+				unsigned int u32_count, int is_write)
+{
+	uint32_t prefetch_config1;
+	if (is_write) {
+		/* Set the amount of bytes to be prefetched */
+		gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_count);
+
+		/* Set dma/mpu mode, the post write and enable the engine
+		 * Set which cs is using the post write
+		 */
+		prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
+		prefetch_config1 |= ((cs << CS_NUM_SHIFT) |
+					(dma_mode << DMA_MPU_MODE) |
+					(1 << ENABLE_PREFETCH) | 0x1);
+		gpmc_write_reg(GPMC_PREFETCH_CONFIG1, prefetch_config1);
+	} else {
+		/* Set the amount of bytes to be prefetched */
+		gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_count);
+
+		/* Set dma/mpu mode, the prefech read and enable the engine
+		 * Set which cs is using the prefetch
+		 */
+		prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
+		prefetch_config1 |= (((cs << CS_NUM_SHIFT) |
+					(dma_mode << DMA_MPU_MODE) |
+					(1 << ENABLE_PREFETCH)) & ~0x1);
+		gpmc_write_reg(GPMC_PREFETCH_CONFIG1, prefetch_config1);
+	}
+	/*  Start the prefetch engine */
+	gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x1);
+}
+EXPORT_SYMBOL(gpmc_prefetch_start);
+
+/*
+ * gpmc_prefetch_stop - disables and stops the prefetch engine
+ */
+void gpmc_prefetch_stop(void)
+{
+	uint32_t prefetch_config1;
+	/* stop the PFPW engine */
+	gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x0);
+
+	/* Disable the PFPW engine */
+	prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
+	prefetch_config1 &= ~((0x07 << CS_NUM_SHIFT) |
+				(1 << ENABLE_PREFETCH) |
+					(1 << DMA_MPU_MODE) | 0x1);
+	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, prefetch_config1);
+}
+EXPORT_SYMBOL(gpmc_prefetch_stop);
+
+/*
+ * gpmc_prefetch_status - reads prefetch status of engine
+ */
+int  gpmc_prefetch_status(void)
+{
+	return gpmc_read_reg(GPMC_PREFETCH_STATUS);
+}
+EXPORT_SYMBOL(gpmc_prefetch_status);
+#else
+int  gpmc_prefetch_status(void) {return 0; }
+void gpmc_prefetch_stop(void) {}
+void gpmc_prefetch_start(int cs, int dma_mode, unsigned int u32_count,
+							int is_write) {}
+#endif
+
 static void __init gpmc_mem_init(void)
 {
 	int cs;
@@ -462,6 +554,9 @@
 	gpmc_freq_cfg.freq_cfg = NULL;
 	gpmc_freq_cfg.total_no_of_freq = 0;
 #endif
+#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
+	gpmc_prefetch_init();
+#endif
 	gpmc_mem_init();
 }
 
Index: omapkernel/arch/arm/plat-omap/include/mach/gpmc.h
===================================================================
--- omapkernel.orig/arch/arm/plat-omap/include/mach/gpmc.h	2008-09-08 18:03:43.000000000 +0530
+++ omapkernel/arch/arm/plat-omap/include/mach/gpmc.h	2008-09-08 18:24:11.000000000 +0530
@@ -139,6 +139,10 @@
 extern void gpmc_cs_free(int cs);
 extern int gpmc_cs_set_reserved(int cs, int reserved);
 extern int gpmc_cs_reserved(int cs);
+extern void gpmc_prefetch_start(int cs, int dma_mode,
+					unsigned int u32_count, int is_write);
+extern void gpmc_prefetch_stop(void);
+extern int  gpmc_prefetch_status(void);
 extern void __init gpmc_init(void);
 
 #endif
Index: omapkernel/drivers/mtd/nand/omap2.c
===================================================================
--- omapkernel.orig/drivers/mtd/nand/omap2.c	2008-09-08 18:23:29.000000000 +0530
+++ omapkernel/drivers/mtd/nand/omap2.c	2008-09-08 18:35:10.000000000 +0530
@@ -115,6 +115,27 @@
 #define MTD_NAND_OMAP_HWECC   0
 #endif
 
+#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
+	static int use_prefetch = 1;
+
+	/* "modprobe ... use_prefetch=0" etc */
+	module_param(use_prefetch, bool, 0);
+	MODULE_PARM_DESC(use_prefetch, "enable/disable use of PREFETCH");
+
+#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH_DMA
+	static int use_dma = 1;
+
+	/* "modprobe ... use_dma=0" etc */
+	module_param(use_dma, bool, 0);
+	MODULE_PARM_DESC(use_dma, "enable/disable use of DMA");
+#else
+	static int use_dma;
+#endif
+#else
+	static int use_prefetch;
+	static int use_dma;
+#endif
+
 struct omap_nand_info {
 	struct nand_hw_control		controller;
 	struct omap_nand_platform_data	*pdata;
@@ -127,6 +148,9 @@
 	unsigned long			phys_base;
 	void __iomem			*gpmc_cs_baseaddr;
 	void __iomem			*gpmc_baseaddr;
+	void __iomem			*nand_pref_fifo_add;
+	struct completion		comp;
+	int				dma_ch;
 };
 
 /*
@@ -190,6 +214,85 @@
 		__raw_writeb(cmd, info->nand.IO_ADDR_W);
 }
 
+#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH_DMA
+/*
+ * omap_nand_dma_cb: callback on the completion of dma transfer
+ * @lch: logical channel
+ * @ch_satuts: channel status
+ * @data: pointer to completion data structure
+ */
+static void omap_nand_dma_cb(int lch, u16 ch_status, void *data)
+{
+	complete((struct completion *) data);
+}
+
+/*
+ * omap_nand_dma_transfer: configer and start dma transfer
+ * @mtd: MTD device structure
+ * @addr: virtual address in RAM of source/destination
+ * @count: number of data bytes to be transferred
+ * @is_write: flag for read/write operation
+ */
+static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
+					unsigned int count, int is_write)
+{
+	struct omap_nand_info *info = container_of(mtd,
+					struct omap_nand_info, mtd);
+
+	uint32_t prefetch_status = 0;
+
+	/* The fifo depth is 64 bytes. We have a synch at each frame and frame
+	 * length is 64 bytes.
+	 */
+	int buf_len = count/64;
+
+	if (is_write) {
+	    omap_set_dma_dest_params(info->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
+						info->phys_base, 0, 0);
+	    omap_set_dma_dest_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
+	    omap_set_dma_src_params(info->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
+						virt_to_phys(addr), 0, 0);
+	    omap_set_dma_src_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
+	    omap_set_dma_transfer_params(info->dma_ch, OMAP_DMA_DATA_TYPE_S32,
+					0x10, buf_len, OMAP_DMA_SYNC_FRAME,
+					OMAP24XX_DMA_GPMC, OMAP_DMA_DST_SYNC);
+	} else {
+	    omap_set_dma_src_params(info->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
+						info->phys_base, 0, 0);
+	    omap_set_dma_src_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
+	    omap_set_dma_dest_params(info->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
+						virt_to_phys(addr), 0, 0);
+	    omap_set_dma_dest_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
+	    omap_set_dma_transfer_params(info->dma_ch, OMAP_DMA_DATA_TYPE_S32,
+					0x10, buf_len, OMAP_DMA_SYNC_FRAME,
+					OMAP24XX_DMA_GPMC, OMAP_DMA_SRC_SYNC);
+	}
+
+	/*  configure and start prefetch transfer */
+	gpmc_prefetch_start(info->gpmc_cs, 0x1, count, is_write);
+	init_completion(&info->comp);
+	dma_sync_single_for_cpu(&info->pdev->dev,
+				virt_to_phys(addr), count, DMA_TO_DEVICE);
+	omap_start_dma(info->dma_ch);
+	wait_for_completion(&info->comp);
+	if (!is_write)
+		dma_sync_single_for_cpu(&info->pdev->dev,
+				virt_to_phys(addr), count, DMA_FROM_DEVICE);
+	prefetch_status = gpmc_prefetch_status();
+	while (prefetch_status & 0x3FFF)
+		prefetch_status = gpmc_prefetch_status();
+
+	/* disable and stop the PFPW engine */
+	gpmc_prefetch_stop();
+	return 0;
+}
+#else
+static void omap_nand_dma_cb(int lch, u16 ch_status, void *data) {}
+static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
+					unsigned int count, int is_write)
+{return 0; }
+#endif
+
 /*
  * omap_read_buf - read data from NAND controller into buffer
  * @mtd: MTD device structure
@@ -201,11 +304,33 @@
 	struct omap_nand_info *info = container_of(mtd,
 					struct omap_nand_info, mtd);
 	u16 *p = (u16 *) buf;
-
-	len >>= 1;
-
-	while (len--)
-		*p++ = cpu_to_le16(readw(info->nand.IO_ADDR_R));
+	if (use_prefetch) {
+		uint32_t prefetch_status = 0;
+		int i = 0, bytes_to_read = 0;
+
+		if ((use_dma && len == mtd->oobsize) || (!use_dma)) {
+			/* configure and start prefetch transfer */
+			gpmc_prefetch_start(info->gpmc_cs, 0x0, len, 0x0);
+
+			prefetch_status = gpmc_prefetch_status();
+			while (len) {
+				bytes_to_read  = ((prefetch_status >> 24) & 0x7F) >> 1;
+				for (i = 0; (i < bytes_to_read) && (len); i++, len -= 2)
+					*p++ = cpu_to_le16(*(volatile u16 *)(info->nand_pref_fifo_add));
+				prefetch_status = gpmc_prefetch_status();
+			}
+			/* disable and stop the PFPW engine */
+			gpmc_prefetch_stop();
+		} else if (use_dma) {
+			if (info->dma_ch >= 0)
+				/* start transfer in DMA mode */
+				omap_nand_dma_transfer(mtd, p, len, 0x0);
+		}
+	} else {
+		len >>= 1;
+		while (len--)
+			*p++ = cpu_to_le16(readw(info->nand.IO_ADDR_R));
+	}
 }
 
 /*
@@ -220,13 +345,35 @@
 						struct omap_nand_info, mtd);
 	u16 *p = (u16 *) buf;
 
-	len >>= 1;
-
-	while (len--) {
-		writew(cpu_to_le16(*p++), info->nand.IO_ADDR_W);
-
-		while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
+	if (use_prefetch) {
+		uint32_t prefetch_status = 0;
+		int i = 0, bytes_to_write = 0;
+
+		if ((use_dma && len == mtd->oobsize) || (!use_dma)) {
+			/*  configure and start prefetch transfer */
+			gpmc_prefetch_start(info->gpmc_cs, 0x0, len, 0x1);
+
+			prefetch_status = gpmc_prefetch_status();
+			while (prefetch_status & 0x3FFF) {
+				bytes_to_write = ((prefetch_status >> 24) & 0x7F)>>1;
+				for (i = 0; (i < bytes_to_write) && (len); i++, len -= 2)
+					*(volatile u16 *)(info->nand_pref_fifo_add) = cpu_to_le16(*p++);
+				prefetch_status = gpmc_prefetch_status();
+			}
+			/* disable and stop the PFPW engine */
+			gpmc_prefetch_stop();
+		} else if (use_dma) {
+			if (info->dma_ch >= 0)
+				/* start transfer in DMA mode */
+				omap_nand_dma_transfer(mtd, p, len, 0x1);
+		}
+	} else {
+		len >>= 1;
+		while (len--) {
+			writew(cpu_to_le16(*p++), info->nand.IO_ADDR_W);
+			while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
 						GPMC_STATUS) & GPMC_BUF_FULL));
+		}
 	}
 }
 /*
@@ -471,7 +618,6 @@
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	register struct nand_chip *chip = mtd->priv;
 	unsigned long val = 0x0;
 	unsigned long reg;
 
@@ -612,6 +758,7 @@
 	info->mtd.name		= pdev->dev.bus_id;
 	info->mtd.owner		= THIS_MODULE;
 
+
 	err = gpmc_cs_request(info->gpmc_cs, NAND_IO_SIZE, &info->phys_base);
 	if (err < 0) {
 		dev_err(&pdev->dev, "Cannot request GPMC CS\n");
@@ -624,12 +771,6 @@
 		val |= WR_RD_PIN_MONITORING;
 		gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG1, val);
 	}
-
-	val  = gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG7);
-	val &= ~(0xf << 8);
-	val |=  (0xc & 0xf) << 8;
-	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG7, val);
-
 	/* NAND write protect off */
 	omap_nand_wp(&info->mtd, NAND_WP_OFF);
 
@@ -644,6 +785,20 @@
 		err = -ENOMEM;
 		goto out_release_mem_region;
 	}
+	if (use_prefetch) {
+		/* copy the virtual address of nand base for fifo access */
+		info->nand_pref_fifo_add = info->nand.IO_ADDR_R;
+		if (use_dma) {
+			err = omap_request_dma(OMAP24XX_DMA_GPMC, "NAND",
+				omap_nand_dma_cb, &info->comp, &info->dma_ch);
+			if (err < 0) {
+				info->dma_ch = -1;
+				printk(KERN_WARNING "DMA request failed."
+					" Non-dma data transfer mode\n");
+			}
+		}
+	}
+
 	info->nand.controller = &info->controller;
 
 	info->nand.IO_ADDR_W = info->nand.IO_ADDR_R;
@@ -728,6 +883,8 @@
 	struct omap_nand_info *info = mtd->priv;
 
 	platform_set_drvdata(pdev, NULL);
+	if (use_dma)
+		omap_free_dma(info->dma_ch);
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
 	iounmap(info->nand.IO_ADDR_R);
@@ -748,6 +905,12 @@
 static int __init omap_nand_init(void)
 {
 	printk(KERN_INFO "%s driver initializing\n", DRIVER_NAME);
+	if ((1 == use_dma) && (0 == use_prefetch)) {
+		printk(KERN_INFO"Wrong parameters: 'use_dma' can not be 1 "
+				"without use_prefetch'. 'use_dma' will be "
+				"set to 0\n");
+		use_dma = 0;
+	}
 	return platform_driver_register(&omap_nand_driver);
 }
 
Index: omapkernel/drivers/mtd/nand/Kconfig
===================================================================
--- omapkernel.orig/drivers/mtd/nand/Kconfig	2008-09-08 18:03:43.000000000 +0530
+++ omapkernel/drivers/mtd/nand/Kconfig	2008-09-08 18:24:11.000000000 +0530
@@ -84,6 +84,36 @@
            MTD_NAND_OMAP_HWECC = 1 which enables the hw ecc
            MTD_NAND_OMAP_HWECC = 0, enables software ecc
 
+config MTD_NAND_OMAP_PREFETCH
+	bool "GPMC prefetch support for NAND Flash device"
+	depends on MTD_NAND && MTD_NAND_OMAP2
+	default n
+	help
+	 The NAND device can be accessed for Read/Write using GPMC PREFETCH engine
+	 to improve the performance.
+
+choice
+	prompt "Prefetch engine support for GPMC"
+	depends on MTD_NAND_OMAP_PREFETCH
+	help
+	 The GPMC PREFETCH engine can be configured eigther in MPU interrupt mode
+	 or in DMA interrupt mode.
+
+config MTD_NAND_OMAP_PREFETCH_MPU
+	depends on MTD_NAND_OMAP_PREFETCH
+	bool "MPU mode always for spare area + MPU mode for main area"
+	help
+	 Say y if... you want MPU interrupt mode for both spare area and main area accesses.
+
+config MTD_NAND_OMAP_PREFETCH_DMA
+	depends on MTD_NAND_OMAP_PREFETCH
+	bool "MPU mode always for spare area + DMA mode for main area"
+	help
+	 Say y if... you want MPU interrupt mode for spare area and DMA mode for main
+	 area access.
+
+endchoice
+
 config MTD_NAND_OMAP
 	tristate "NAND Flash device on OMAP H3/H2/P2 boards"
 	depends on ARM && ARCH_OMAP1 && MTD_NAND && (MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_PERSEUS2)
