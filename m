From: Kevin Hilman <khilman@mvista.com>
Subject: [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
Date: Tue, 20 Mar 2007 17:40:30 -0700
Message-ID: <20070321004030.424076000@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Adds platform device for use of existing OMAP2 driver.  Also, the
following changes are made to the existing driver:

- add option for not using DMA (by passing dma_channel = -1)
- removes obsoleted pt_regs arg from interrupt handler

RFC: Notice the change to onenand_base.c which comments out the last
     OOB chunk.  Without this, it would not work.  Previous drivers
     for this board such as the 2.6.10-based MV kernel have this
     same change.  Anyone know what is going on here?

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/Makefile              |    3 
 arch/arm/mach-omap2/board-2430sdp-flash.c |  108 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-2430sdp.c       |    4 +
 arch/arm/mach-omap2/gpmc.c                |    1 
 drivers/mtd/onenand/omap2.c               |  103 +++++++++++++++++-----------
 drivers/mtd/onenand/onenand_base.c        |    2 
 include/asm-arm/arch-omap/gpmc.h          |    7 +
 include/asm-arm/arch-omap/onenand.h       |    1 
 8 files changed, 187 insertions(+), 42 deletions(-)

Index: dev/arch/arm/mach-omap2/Makefile
===================================================================
--- dev.orig/arch/arm/mach-omap2/Makefile
+++ dev/arch/arm/mach-omap2/Makefile
@@ -20,7 +20,8 @@ mmu_mach-objs			:= mmu.o
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
-obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o
+obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
+					   board-2430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
 					   board-n800-mmc.o board-n800-bt.o \
Index: dev/arch/arm/mach-omap2/board-2430sdp-flash.c
===================================================================
--- /dev/null
+++ dev/arch/arm/mach-omap2/board-2430sdp-flash.c
@@ -0,0 +1,108 @@
+/*
+ * linux/arch/arm/mach-omap2/board-2430sdp-flash.c
+ *
+ * Copyright (C) 2007 MontaVista Software, Inc. <source@mvista.com>
+ * Author: Kevin Hilman
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <asm/mach/flash.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/onenand_regs.h>
+
+#include <asm/io.h>
+#include <asm/arch/onenand.h>
+#include <asm/arch/board.h>
+#include <asm/arch/gpmc.h>
+
+#define ONENAND_MAP 0x20000000
+
+static struct mtd_partition onenand_partitions[] = {
+	{
+		.name		= "(OneNAND)X-Loader",
+		.offset		= 0,
+		.size		= 4*(64*2048),  /* 0-3 blks reserved.
+						   Mandated by ROM code */
+		.mask_flags	= MTD_WRITEABLE	/* force read-only */
+	},
+	{
+		.name		= "(OneNAND)U-Boot",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		=  2*(64*2048),
+		.mask_flags	= MTD_WRITEABLE	/* force read-only */
+	},
+	{
+		.name		= "(OneNAND)U-Boot Environment",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 1*(64*2048),
+	},
+	{
+		.name		= "(OneNAND)Kernel",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 4*(64*2048),
+	},
+	{
+		.name		= "(OneNAND)File System",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data sdp_onenand_data = {
+	.parts	       = onenand_partitions,
+	.nr_parts      = ARRAY_SIZE(onenand_partitions),
+	.dma_channel   = -1,  /* disable DMA in OMAP OneNAND driver */
+};
+
+static struct platform_device sdp_onenand_device = {
+	.name		= "omap2-onenand",
+	.id		= -1,
+	.dev = {
+		.platform_data = &sdp_onenand_data,
+	},
+};
+
+void __init sdp2430_flash_init(void)
+{
+	unsigned long gpmc_base_add, gpmc_cs_base_add;
+	unsigned char cs=0;
+
+	gpmc_base_add = OMAP243X_GPMC_VIRT;
+	while (cs < GPMC_CS_NUM) {
+		int ret = 0;
+
+		/* Each GPMC set for a single CS is at offset 0x30 */
+		gpmc_cs_base_add = (gpmc_base_add + GPMC_CONFIG1_0 + (cs*0x30));
+
+		/* xloader/Uboot would have programmed the oneNAND
+		 * base address for us This is a ugly hack. The proper
+		 * way of doing this is to pass the setup of u-boot up
+		 * to kernel using kernel params - something on the
+		 * lines of machineID. Check if oneNAND is
+		 * configured */
+		ret = __raw_readl(gpmc_cs_base_add + GPMC_CS_CONFIG7);
+		if ((ret & 0x3F) == (ONENAND_MAP >> 24)) {
+			/* Found it!! */
+			break;
+		}
+		cs++;
+	}
+	if (cs >= GPMC_CS_NUM) {
+		printk("OneNAND: Unable to find oneNAND configuration in GPMC "
+		       " - not registering.\n");
+		return;
+	}
+
+	sdp_onenand_data.cs = cs;
+
+	if (platform_device_register(&sdp_onenand_device) < 0) {
+		printk(KERN_ERR "Unable to register OneNAND device\n");
+		return;
+	}
+}
Index: dev/arch/arm/mach-omap2/board-2430sdp.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/board-2430sdp.c
+++ dev/arch/arm/mach-omap2/board-2430sdp.c
@@ -192,12 +192,16 @@ static struct omap_board_config_kernel s
 	{OMAP_TAG_UART, &sdp2430_uart_config},
 };
 
+extern void __init sdp2430_flash_init(void);
+
 static void __init omap_2430sdp_init(void)
 {
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_board_config = sdp2430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
 	omap_serial_init();
+
+	sdp2430_flash_init();
 }
 
 static void __init omap_2430sdp_map_io(void)
Index: dev/arch/arm/mach-omap2/gpmc.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/gpmc.c
+++ dev/arch/arm/mach-omap2/gpmc.c
@@ -51,7 +51,6 @@
 #define GPMC_CS0		0x60
 #define GPMC_CS_SIZE		0x30
 
-#define GPMC_CS_NUM		8
 #define GPMC_MEM_START		0x00000000
 #define GPMC_MEM_END		0x3FFFFFFF
 #define BOOT_ROM_SPACE		0x100000	/* 1MB */
Index: dev/drivers/mtd/onenand/omap2.c
===================================================================
--- dev.orig/drivers/mtd/onenand/omap2.c
+++ dev/drivers/mtd/onenand/omap2.c
@@ -80,8 +80,7 @@ static void omap2_onenand_dma_cb(int lch
 	complete(&info->dma_done);
 }
 
-static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id,
-					   struct pt_regs *regs)
+static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)
 {
 	struct omap2_onenand *info = dev_id;
 
@@ -111,11 +110,15 @@ static int omap2_onenand_wait(struct mtd
 		omap2_onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1);
 
 		INIT_COMPLETION(info->irq_done);
-		result = omap_get_gpio_datain(info->gpio_irq);
-		if (result == -1) {
-			ctrl = omap2_onenand_readw(info->onenand.base + ONENAND_REG_CTRL_STATUS);
-			printk(KERN_ERR "onenand_wait: gpio error, state = %d, ctrl = 0x%04x\n", state, ctrl);
-			return -EIO;
+		if (info->gpio_irq) {
+			result = omap_get_gpio_datain(info->gpio_irq);
+			if (result == -1) {
+				ctrl = omap2_onenand_readw(info->onenand.base + ONENAND_REG_CTRL_STATUS);
+				printk(KERN_ERR "onenand_wait: gpio error, state = %d, ctrl = 0x%04x\n", state, ctrl);
+				return -EIO;
+			}
+		} else {
+			result = 0;
 		}
 		if (result == 0) {
 			int retry_cnt = 0;
@@ -317,6 +320,11 @@ static int __devinit omap2_onenand_probe
 	init_completion(&info->dma_done);
 	info->gpmc_cs = pdata->cs;
 	info->gpio_irq = pdata->gpio_irq;
+	info->dma_channel = pdata->dma_channel;
+	if (info->dma_channel < 0) {
+		/* if -1, don't use DMA */
+		info->gpio_irq = 0;
+	}
 
 	r = gpmc_cs_request(info->gpmc_cs, ONENAND_IO_SIZE, &info->phys_base);
 	if (r < 0) {
@@ -345,31 +353,41 @@ static int __devinit omap2_onenand_probe
 		}
         }
 
-	if ((r = omap_request_gpio(info->gpio_irq)) < 0) {
-		dev_err(&pdev->dev,  "Failed to request GPIO%d for OneNAND\n",
-		        info->gpio_irq);
-		goto err_iounmap;
-	}
-	omap_set_gpio_direction(info->gpio_irq, 1);
-
-	if ((r = request_irq(OMAP_GPIO_IRQ(info->gpio_irq),
-			     omap2_onenand_interrupt, SA_TRIGGER_RISING,
-			     pdev->dev.driver->name, info)) < 0)
-		goto err_release_gpio;
-
-	r = omap_request_dma(0, pdev->dev.driver->name,
-			     omap2_onenand_dma_cb, (void *) info,
-			     &info->dma_channel);
-	if (r == 0) {
-		omap_set_dma_write_mode(info->dma_channel, OMAP_DMA_WRITE_NON_POSTED);
-		omap_set_dma_src_data_pack(info->dma_channel, 1);
-		omap_set_dma_src_burst_mode(info->dma_channel, OMAP_DMA_DATA_BURST_8);
-		omap_set_dma_dest_data_pack(info->dma_channel, 1);
-		omap_set_dma_dest_burst_mode(info->dma_channel, OMAP_DMA_DATA_BURST_8);
-	} else {
-		dev_info(&pdev->dev,
-			 "failed to allocate DMA for OneNAND, using PIO instead\n");
-		info->dma_channel = -1;
+	if (info->gpio_irq) {
+		if ((r = omap_request_gpio(info->gpio_irq)) < 0) {
+			dev_err(&pdev->dev,
+				"Failed to request GPIO%d for OneNAND\n",
+				info->gpio_irq);
+			goto err_iounmap;
+		}
+		omap_set_gpio_direction(info->gpio_irq, 1);
+
+		if ((r = request_irq(OMAP_GPIO_IRQ(info->gpio_irq),
+				     omap2_onenand_interrupt,
+				     SA_TRIGGER_RISING,
+				     pdev->dev.driver->name, info)) < 0)
+			goto err_release_gpio;
+	}
+
+	if (info->dma_channel >= 0) {
+		r = omap_request_dma(0, pdev->dev.driver->name,
+				     omap2_onenand_dma_cb, (void *) info,
+				     &info->dma_channel);
+		if (r == 0) {
+			omap_set_dma_write_mode(info->dma_channel,
+						OMAP_DMA_WRITE_NON_POSTED);
+			omap_set_dma_src_data_pack(info->dma_channel, 1);
+			omap_set_dma_src_burst_mode(info->dma_channel,
+						    OMAP_DMA_DATA_BURST_8);
+			omap_set_dma_dest_data_pack(info->dma_channel, 1);
+			omap_set_dma_dest_burst_mode(info->dma_channel,
+						     OMAP_DMA_DATA_BURST_8);
+		} else {
+			dev_info(&pdev->dev,
+				 "failed to allocate DMA for OneNAND, "
+				 "using PIO instead\n");
+			info->dma_channel = -1;
+		}
 	}
 
 	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual base %p\n",
@@ -379,9 +397,12 @@ static int __devinit omap2_onenand_probe
 	info->mtd.name = pdev->dev.bus_id;
 	info->mtd.priv = &info->onenand;
 	info->mtd.owner = THIS_MODULE;
-	info->onenand.wait = omap2_onenand_wait;
-	info->onenand.read_bufferram = omap2_onenand_read_bufferram;
-	info->onenand.write_bufferram = omap2_onenand_write_bufferram;
+
+	if (info->dma_channel >= 0) {
+		info->onenand.wait = omap2_onenand_wait;
+		info->onenand.read_bufferram = omap2_onenand_read_bufferram;
+		info->onenand.write_bufferram = omap2_onenand_write_bufferram;
+	}
 
 	if ((r = onenand_scan(&info->mtd, 1)) < 0)
 		goto err_release_dma;
@@ -404,9 +425,11 @@ err_release_onenand:
 err_release_dma:
 	if (info->dma_channel != -1)
 		omap_free_dma(info->dma_channel);
-	free_irq(OMAP_GPIO_IRQ(info->gpio_irq), info);
+	if (info->gpio_irq)
+		free_irq(OMAP_GPIO_IRQ(info->gpio_irq), info);
 err_release_gpio:
-	omap_free_gpio(info->gpio_irq);
+	if (info->gpio_irq)
+		omap_free_gpio(info->gpio_irq);
 err_iounmap:
 	iounmap(info->onenand.base);
 err_release_mem_region:
@@ -439,8 +462,10 @@ static int __devexit omap2_onenand_remov
 		omap_free_dma(info->dma_channel);
 	omap2_onenand_shutdown(pdev);
 	platform_set_drvdata(pdev, NULL);
-	free_irq(OMAP_GPIO_IRQ(info->gpio_irq), info);
-	omap_free_gpio(info->gpio_irq);
+	if (info->gpio_irq) {
+		free_irq(OMAP_GPIO_IRQ(info->gpio_irq), info);
+		omap_free_gpio(info->gpio_irq);
+	}
 	iounmap(info->onenand.base);
 	release_mem_region(info->phys_base, ONENAND_IO_SIZE);
 	kfree(info);
Index: dev/drivers/mtd/onenand/onenand_base.c
===================================================================
--- dev.orig/drivers/mtd/onenand/onenand_base.c
+++ dev/drivers/mtd/onenand/onenand_base.c
@@ -39,7 +39,7 @@ static struct nand_ecclayout onenand_oob
 		},
 	.oobfree	= {
 		{2, 3}, {14, 2}, {18, 3}, {30, 2},
-		{34, 3}, {46, 2}, {50, 3}, {62, 2}
+		{34, 3}, {46, 2}, {50, 3}, /* {62, 2} */
 	}
 };
 
Index: dev/include/asm-arm/arch-omap/gpmc.h
===================================================================
--- dev.orig/include/asm-arm/arch-omap/gpmc.h
+++ dev/include/asm-arm/arch-omap/gpmc.h
@@ -11,6 +11,9 @@
 #ifndef __OMAP2_GPMC_H
 #define __OMAP2_GPMC_H
 
+/* Maximum Number of Chip Selects */
+#define GPMC_CS_NUM		8
+
 #define GPMC_CS_CONFIG1		0x00
 #define GPMC_CS_CONFIG2		0x04
 #define GPMC_CS_CONFIG3		0x08
@@ -22,6 +25,10 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24
 
+#define GPMC_CONFIG		0x50
+#define GPMC_STATUS		0x54
+#define GPMC_CONFIG1_0		0x60
+
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
 #define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
Index: dev/include/asm-arm/arch-omap/onenand.h
===================================================================
--- dev.orig/include/asm-arm/arch-omap/onenand.h
+++ dev/include/asm-arm/arch-omap/onenand.h
@@ -17,4 +17,5 @@ struct omap_onenand_platform_data {
 	struct mtd_partition	*parts;
 	int			nr_parts;
 	int                     (*onenand_setup)(void __iomem *);
+	int			dma_channel;
 };
--
