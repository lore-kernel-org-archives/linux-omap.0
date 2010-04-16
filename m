From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH 2/6] omap3: NAND Prefetch in IRQ mode support
Date: Fri, 16 Apr 2010 17:05:01 +0530
Message-ID: <1271417701-4390-1-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41601 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757804Ab0DPLfL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 07:35:11 -0400
In-Reply-To: <Sukumar Ghorai <s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: sbranden@broadcom.com, leochen@broadcom.com, David.Woodhouse@intel.com, linux-omap@vger.kernel.org, tony@atomide.com, vimal.newwork@gmail.com, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

This patch enable prefetch-irq mode for NAND.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-sdp-flash.c  |    1 +
 arch/arm/mach-omap2/board-zoom-flash.c |    1 +
 arch/arm/plat-omap/include/plat/nand.h |    1 +
 drivers/mtd/nand/Kconfig               |   14 +++-
 drivers/mtd/nand/omap2.c               |  180 +++++++++++++++++++++++++++++++-
 5 files changed, 191 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-sdp-flash.c b/arch/arm/mach-omap2/board-sdp-flash.c
index 57116e6..81b83ce
--- a/arch/arm/mach-omap2/board-sdp-flash.c
+++ b/arch/arm/mach-omap2/board-sdp-flash.c
@@ -151,6 +151,7 @@ static struct omap_nand_platform_data sdp_nand_data = {
 	.nand_setup	= NULL,
 	.gpmc_t		= &nand_timings,
 	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.gpmc_irq	= 20,
 	.dev_ready	= NULL,
 	.devsize	= 0,	/* '0' for 8-bit, '1' for 16-bit device */
 };
diff --git a/arch/arm/mach-omap2/board-zoom-flash.c b/arch/arm/mach-omap2/board-zoom-flash.c
index 55e173b..6a5dcf4 100644
--- a/arch/arm/mach-omap2/board-zoom-flash.c
+++ b/arch/arm/mach-omap2/board-zoom-flash.c
@@ -54,6 +54,7 @@ static struct omap_nand_platform_data zoom_nand_data = {
 	.nand_setup	= NULL,
 	.gpmc_t		= &nand_timings,
 	.dma_channel	= -1,	/* disable DMA in OMAP NAND driver */
+	.gpmc_irq	= 20,
 	.dev_ready	= NULL,
 	.devsize	= 1,	/* '0' for 8-bit, '1' for 16-bit device */
 };
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 6ba88d2..8ba2e3e 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -20,6 +20,7 @@ struct omap_nand_platform_data {
 	int			(*nand_setup)(void);
 	int			(*dev_ready)(struct omap_nand_platform_data *);
 	int			dma_channel;
+	int			gpmc_irq;
 	unsigned long		phys_base;
 	void __iomem		*gpmc_cs_baseaddr;
 	void __iomem		*gpmc_baseaddr;
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index b712aed..ee9abbd
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -94,6 +94,9 @@ config MTD_NAND_OMAP_PREFETCH
 	help
 	 The NAND device can be accessed for Read/Write using GPMC PREFETCH engine
 	 to improve the performance.
+	 GPMC PREFETCH can be configured eigther in MPU interrupt mode or in DMA
+	 interrupt mode. If not selected any of them prefetch will be used in
+	 polling mode.
 
 config MTD_NAND_OMAP_PREFETCH_DMA
 	depends on MTD_NAND_OMAP_PREFETCH
@@ -102,7 +105,16 @@ config MTD_NAND_OMAP_PREFETCH_DMA
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
index 09a89f9..de9b058 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/mtd/mtd.h>
@@ -111,17 +112,27 @@ module_param(use_prefetch, bool, 0);
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
@@ -139,6 +150,8 @@ struct omap_nand_info {
 	void __iomem			*nand_pref_fifo_add;
 	struct completion		comp;
 	int				dma_ch;
+	int				gpmc_irq;
+	u_char				*buf;
 };
 
 /**
@@ -503,6 +516,141 @@ static void omap_write_buf_dma_pref(struct mtd_info *mtd,
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
+	u32 irq_enb = 0, pref_status = 0, bytes = 0;
+	u32 irq_stats = __raw_readl(info->gpmc_baseaddr + GPMC_IRQSTATUS);
+	u32 pref_config = __raw_readl(info->gpmc_baseaddr +
+					GPMC_PREFETCH_CONFIG1);
+
+	if (pref_config & 0x1) { /* checks for write operaiton */
+		if (irq_stats & 0x2)
+			goto done;
+
+		u32 *p = (u32 *) info->buf;
+		pref_status = gpmc_prefetch_status();
+		bytes = ((pref_status >> 24) & 0x7F);
+		iowrite32_rep(info->nand_pref_fifo_add, p, bytes >> 2);
+		info->buf = info->buf + bytes;
+
+	} else {
+		u32 *p = (u32 *) info->buf;
+		pref_status = gpmc_prefetch_status();
+		bytes = ((pref_status >> 24) & 0x7F);
+		ioread32_rep(info->nand_pref_fifo_add, p, bytes >> 2);
+		info->buf = info->buf + bytes;
+
+		if (irq_stats & 0x2)
+			goto done;
+	}
+	__raw_writel(irq_stats, info->gpmc_baseaddr + GPMC_IRQSTATUS);
+	irq_stats = __raw_readl(info->gpmc_baseaddr + GPMC_IRQSTATUS);
+
+	return IRQ_HANDLED;
+
+done:
+	complete(&info->comp);
+	irq_enb = __raw_readl(info->gpmc_baseaddr + GPMC_IRQENABLE);
+	__raw_writel((irq_enb & ~0x3), info->gpmc_baseaddr + GPMC_IRQENABLE);
+	__raw_writel(irq_stats, info->gpmc_baseaddr + GPMC_IRQSTATUS);
+	irq_stats = __raw_readl(info->gpmc_baseaddr + GPMC_IRQSTATUS);
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
+	u32 irq_enb = __raw_readl(info->gpmc_baseaddr + GPMC_IRQENABLE);
+	int ret = 0;
+
+	if (len <= mtd->oobsize) {
+		omap_read_buf_pref(mtd, buf, len);
+		return;
+	}
+
+	info->buf = buf;
+	init_completion(&info->comp);
+
+	/*  configure and start prefetch transfer */
+	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
+	if (ret)
+		/* PFPW engine is busy, use cpu copy methode */
+		goto out_copy;
+
+	__raw_writel((irq_enb | 0x3), info->gpmc_baseaddr + GPMC_IRQENABLE);
+
+	/* setup and start DMA using dma_addr */
+	wait_for_completion(&info->comp);
+
+	/* disable and stop the PFPW engine */
+	gpmc_prefetch_reset();
+
+	return;
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
+	u32 irq_enb = __raw_readl(info->gpmc_baseaddr + GPMC_IRQENABLE);
+	int ret = 0;
+
+	if (len <= mtd->oobsize) {
+		omap_write_buf_pref(mtd, buf, len);
+		return;
+	}
+
+	info->buf = (u_char *) buf;
+	init_completion(&info->comp);
+
+	/*  configure and start prefetch transfer */
+	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x1);
+	if (ret)
+		/* PFPW engine is busy, use cpu copy methode */
+		goto out_copy;
+
+	__raw_writel((irq_enb | 0x3), info->gpmc_baseaddr + GPMC_IRQENABLE);
+
+	/* setup and start DMA using dma_addr */
+	wait_for_completion(&info->comp);
+
+	/* disable and stop the PFPW engine */
+	gpmc_prefetch_reset();
+
+	return;
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
@@ -898,6 +1046,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->gpmc_cs		= pdata->cs;
 	info->gpmc_baseaddr	= pdata->gpmc_baseaddr;
 	info->gpmc_cs_baseaddr	= pdata->gpmc_cs_baseaddr;
+	info->gpmc_irq		= pdata->gpmc_irq;
 	info->phys_base		= pdata->phys_base;
 
 	info->mtd.priv		= &info->nand;
@@ -964,7 +1113,20 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
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
@@ -1056,11 +1218,19 @@ static int __init omap_nand_init(void)
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
 
