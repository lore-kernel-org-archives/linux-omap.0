From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v4 1/4] omap3: nand: prefetch in irq mode support
Date: Mon,  2 Aug 2010 21:19:49 +0530
Message-ID: <1280764192-15053-2-git-send-email-s-ghorai@ti.com>
References: <1280764192-15053-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48568 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab0HBPuH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Aug 2010 11:50:07 -0400
In-Reply-To: <1280764192-15053-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

 This patch enable prefetch-irq mode for NAND.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-flash.c      |    2 +
 arch/arm/mach-omap2/gpmc.c             |    4 +
 arch/arm/plat-omap/include/plat/gpmc.h |    4 +
 arch/arm/plat-omap/include/plat/irqs.h |    1 +
 arch/arm/plat-omap/include/plat/nand.h |    1 +
 drivers/mtd/nand/Kconfig               |   14 ++-
 drivers/mtd/nand/omap2.c               |  196 +++++++++++++++++++++++++++++++-
 7 files changed, 216 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index ac834aa..4871d71 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
 
+#include <plat/irqs.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/onenand.h>
@@ -133,6 +134,7 @@ static struct omap_nand_platform_data board_nand_data = {
 	.nand_setup	= NULL,
 	.gpmc_t		= &nand_timings,
 	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.gpmc_irq	= INT_34XX_GPMC_IRQ,
 	.dev_ready	= NULL,
 	.devsize	= 0,	/* '0' for 8-bit, '1' for 16-bit device */
 };
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f46933b..86a6f78 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -487,6 +487,10 @@ int gpmc_cs_configure(int cs, int cmd, int wval)
 	u32 regval = 0;
 
 	switch (cmd) {
+	case GPMC_ENABLE_IRQ:
+		gpmc_write_reg(GPMC_IRQENABLE, wval);
+		break;
+
 	case GPMC_SET_IRQ_STATUS:
 		gpmc_write_reg(GPMC_IRQSTATUS, wval);
 		break;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 9fd99b9..054e704 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -41,6 +41,8 @@
 #define GPMC_NAND_ADDRESS	0x0000000b
 #define GPMC_NAND_DATA		0x0000000c
 
+#define GPMC_ENABLE_IRQ		0x0000000d
+
 /* ECC commands */
 #define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
 #define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
@@ -78,6 +80,8 @@
 #define WR_RD_PIN_MONITORING		0x00600000
 #define GPMC_PREFETCH_STATUS_FIFO_CNT(val)	((val >> 24) & 0x7F)
 #define GPMC_PREFETCH_STATUS_COUNT(val)	(val & 0x00003fff)
+#define GPMC_IRQ_FIFOEVENTENABLE	0x01
+#define GPMC_IRQ_COUNT_EVENT		0x02
 
 /*
  * Note that all values in this struct are in nanoseconds, while
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index c01d9f0..fd6d677 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -318,6 +318,7 @@
 #define INT_34XX_PRCM_MPU_IRQ	11
 #define INT_34XX_MCBSP1_IRQ	16
 #define INT_34XX_MCBSP2_IRQ	17
+#define INT_34XX_GPMC_IRQ	20
 #define INT_34XX_MCBSP3_IRQ	22
 #define INT_34XX_MCBSP4_IRQ	23
 #define INT_34XX_CAM_IRQ	24
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 6562cd0..5e69463 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -20,6 +20,7 @@ struct omap_nand_platform_data {
 	int			(*nand_setup)(void);
 	int			(*dev_ready)(struct omap_nand_platform_data *);
 	int			dma_channel;
+	int			gpmc_irq;
 	unsigned long		phys_base;
 	int			devsize;
 };
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index ffc3720..46361ef 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -112,6 +112,9 @@ config MTD_NAND_OMAP_PREFETCH
 	help
 	 The NAND device can be accessed for Read/Write using GPMC PREFETCH engine
 	 to improve the performance.
+	 GPMC PREFETCH can be configured eigther in MPU interrupt mode or in DMA
+	 interrupt mode. If not selected any of them prefetch will be used in
+	 polling mode.
 
 config MTD_NAND_OMAP_PREFETCH_DMA
 	depends on MTD_NAND_OMAP_PREFETCH
@@ -120,7 +123,16 @@ config MTD_NAND_OMAP_PREFETCH_DMA
 	help
 	 The GPMC PREFETCH engine can be configured eigther in MPU interrupt mode
 	 or in DMA interrupt mode.
-	 Say y for DMA mode or MPU mode will be used
+	 Say y for DMA mode
+
+config MTD_NAND_OMAP_PREFETCH_IRQ
+	depends on MTD_NAND_OMAP_PREFETCH && !MTD_NAND_OMAP_PREFETCH_DMA
+	bool "IRQ mode"
+	default n
+	help
+	 The GPMC PREFETCH engine can be configured eigther in MPU interrupt mode
+	 or in DMA interrupt mode.
+	 Say y for IRQ mode
 
 config MTD_NAND_IDS
 	tristate
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 133d515..9dc5ff9 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/mtd/mtd.h>
@@ -105,17 +106,27 @@ module_param(use_prefetch, bool, 0);
 MODULE_PARM_DESC(use_prefetch, "enable/disable use of PREFETCH");
 
 #ifdef CONFIG_MTD_NAND_OMAP_PREFETCH_DMA
+const int use_interrupt;
 static int use_dma = 1;
 
 /* "modprobe ... use_dma=0" etc */
 module_param(use_dma, bool, 0);
-MODULE_PARM_DESC(use_dma, "enable/disable use of DMA");
+MODULE_PARM_DESC(use_dma, "enable/disable use of DMA mode");
+#elif defined(CONFIG_MTD_NAND_OMAP_PREFETCH_IRQ)
+const int use_dma;
+static int use_interrupt = 1;
+
+/* "modprobe ... use_dma=0" etc */
+module_param(use_interrupt, bool, 0);
+MODULE_PARM_DESC(use_interrupt, "enable/disable use of IRQ mode");
 #else
 const int use_dma;
+const int use_interrupt;
 #endif
 #else
 const int use_prefetch;
 const int use_dma;
+const int use_interrupt;
 #endif
 
 struct omap_nand_info {
@@ -130,6 +141,13 @@ struct omap_nand_info {
 	unsigned long			phys_base;
 	struct completion		comp;
 	int				dma_ch;
+	int				gpmc_irq;
+	enum {
+		OMAP_NAND_IO_READ = 0,	/* read */
+		OMAP_NAND_IO_WRITE,	/* write */
+	} iomode;
+	u_char				*buf;
+	int					buf_len;
 };
 
 /**
@@ -467,6 +485,152 @@ static void omap_write_buf_dma_pref(struct mtd_info *mtd,
 		omap_nand_dma_transfer(mtd, (u_char *) buf, len, 0x1);
 }
 
+/*
+ * omap_nand_irq - GMPC irq handler
+ * @this_irq: gpmc irq number
+ * @dev: omap_nand_info structure pointer is passed here
+ */
+static irqreturn_t omap_nand_irq(int this_irq, void *dev)
+{
+	struct omap_nand_info *info = (struct omap_nand_info *) dev;
+	u32 bytes;
+	u32 irq_stat;
+
+	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
+	bytes = gpmc_read_status(GPMC_PREFETCH_FIFO_CNT);
+	bytes = bytes  & 0xFFFC; /* io in multiple of 4 bytes */
+	if (info->iomode == OMAP_NAND_IO_WRITE) { /* checks for write io */
+		if (irq_stat & 0x2)
+			goto done;
+
+		if (info->buf_len & (info->buf_len < bytes))
+			bytes = info->buf_len;
+		else if (!info->buf_len)
+			bytes = 0;
+		iowrite32_rep(info->nand.IO_ADDR_W,
+						(u32 *)info->buf, bytes >> 2);
+		info->buf = info->buf + bytes;
+		info->buf_len -= bytes;
+
+	} else {
+		ioread32_rep(info->nand.IO_ADDR_R,
+						(u32 *)info->buf, bytes >> 2);
+		info->buf = info->buf + bytes;
+
+		if (irq_stat & 0x2)
+			goto done;
+	}
+	gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, irq_stat);
+	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
+
+	return IRQ_HANDLED;
+
+done:
+	complete(&info->comp);
+	/* disable irq */
+	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ, 0);
+
+	/* clear status */
+	gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, irq_stat);
+	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * omap_read_buf_irq_pref - read data from NAND controller into buffer
+ * @mtd: MTD device structure
+ * @buf: buffer to store date
+ * @len: number of bytes to read
+ */
+static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
+{
+	struct omap_nand_info *info = container_of(mtd,
+						struct omap_nand_info, mtd);
+	int ret = 0;
+
+	if (len <= mtd->oobsize) {
+		omap_read_buf_pref(mtd, buf, len);
+		return;
+	}
+	info->iomode = OMAP_NAND_IO_READ;
+	info->buf = buf;
+	init_completion(&info->comp);
+
+	/*  configure and start prefetch transfer */
+	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
+	if (ret)
+		/* PFPW engine is busy, use cpu copy methode */
+		goto out_copy;
+
+	info->buf_len = len;
+	/* enable irq */
+	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ,
+			(GPMC_IRQ_FIFOEVENTENABLE | GPMC_IRQ_COUNT_EVENT));
+
+
+	/* waiting for read to complete */
+	wait_for_completion(&info->comp);
+	/* disable and stop the PFPW engine */
+	gpmc_prefetch_reset(info->gpmc_cs);
+	return;
+
+out_copy:
+	if (info->nand.options & NAND_BUSWIDTH_16)
+		omap_read_buf16(mtd, buf, len);
+	else
+		omap_read_buf8(mtd, buf, len);
+}
+
+/*
+ * omap_write_buf_irq_pref - write buffer to NAND controller
+ * @mtd: MTD device structure
+ * @buf: data buffer
+ * @len: number of bytes to write
+ */
+static void omap_write_buf_irq_pref(struct mtd_info *mtd,
+					const u_char *buf, int len)
+{
+	struct omap_nand_info *info = container_of(mtd,
+						struct omap_nand_info, mtd);
+	int ret = 0;
+	if (len <= mtd->oobsize) {
+		omap_write_buf_pref(mtd, buf, len);
+		return;
+	}
+
+	info->iomode = OMAP_NAND_IO_WRITE;
+	info->buf = (u_char *) buf;
+	init_completion(&info->comp);
+
+	/*  configure and start prefetch transfer */
+	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x1);
+	if (ret)
+		/* PFPW engine is busy, use cpu copy methode */
+		goto out_copy;
+
+	info->buf_len = len;
+	/* enable irq */
+	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ,
+			(GPMC_IRQ_FIFOEVENTENABLE | GPMC_IRQ_COUNT_EVENT));
+
+	/* waiting for write to complete */
+	wait_for_completion(&info->comp);
+	/* wait for data to flushed-out before reset the prefetch */
+	do {
+		ret = gpmc_read_status(GPMC_PREFETCH_COUNT);
+	} while (ret);
+	/* disable and stop the PFPW engine */
+	gpmc_prefetch_reset(info->gpmc_cs);
+	return;
+
+out_copy:
+	if (info->nand.options & NAND_BUSWIDTH_16)
+		omap_write_buf16(mtd, buf, len);
+	else
+		omap_write_buf8(mtd, buf, len);
+}
+
 /**
  * omap_verify_buf - Verify chip data against buffer
  * @mtd: MTD device structure
@@ -800,6 +964,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 
 	info->gpmc_cs		= pdata->cs;
 	info->phys_base		= pdata->phys_base;
+	info->gpmc_irq		= pdata->gpmc_irq;
 
 	info->mtd.priv		= &info->nand;
 	info->mtd.name		= dev_name(&pdev->dev);
@@ -863,7 +1028,20 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 				info->nand.read_buf   = omap_read_buf_dma_pref;
 				info->nand.write_buf  = omap_write_buf_dma_pref;
 			}
+		} else if (use_interrupt) {
+			err = request_irq(info->gpmc_irq, omap_nand_irq,
+					IRQF_SHARED, info->mtd.name, info);
+			if (err) {
+				printk(KERN_INFO"failure requesting irq %i."
+						" Prefetch will work in mpu"
+						" poling mode.\n",
+						info->gpmc_irq);
+			} else {
+				info->nand.read_buf   = omap_read_buf_irq_pref;
+				info->nand.write_buf  = omap_write_buf_irq_pref;
+			}
 		}
+
 	} else {
 		if (info->nand.options & NAND_BUSWIDTH_16) {
 			info->nand.read_buf   = omap_read_buf16;
@@ -953,11 +1131,19 @@ static int __init omap_nand_init(void)
 	/* This check is required if driver is being
 	 * loaded run time as a module
 	 */
-	if ((1 == use_dma) && (0 == use_prefetch)) {
-		printk(KERN_INFO"Wrong parameters: 'use_dma' can not be 1 "
-				"without use_prefetch'. Prefetch will not be"
-				" used in either mode (mpu or dma)\n");
+
+	if ((0 == use_prefetch) && (1 == (use_dma | use_interrupt))) {
+		printk(KERN_INFO "Wrong parameters: Neither 'dma' nor 'irq' "
+				"can used without 'use_prefetch' selected.\n");
+		printk(KERN_INFO "Prefetch will not be used in any mode: "
+				"poll, mpu or dma\n");
+	} else if ((1 == use_prefetch) && (1 == (use_interrupt & use_dma))) {
+			printk(KERN_INFO "Wrong parameters: Both DMA and IRQ"
+					" modes can not be used together.\n");
+			printk(KERN_INFO "It has to be selected at compile "
+					"time and same will be used.\n");
 	}
+
 	return platform_driver_register(&omap_nand_driver);
 }
 
