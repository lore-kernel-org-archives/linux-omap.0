From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCHv2 3/3] OMAP3 NAND: Add NAND support on OMAP_LDP
Date: Fri, 21 Nov 2008 15:51:10 +0800
Message-ID: <1227253870-4407-4-git-send-email-stanley.miao@windriver.com>
References: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51055 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbYKUHo7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 02:44:59 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mAL7iwpY021181
	for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 23:44:58 -0800 (PST)
In-Reply-To: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add NAND support on OMAP_LDP.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/Makefile                |    3 +-
 arch/arm/mach-omap2/board-ldp-flash.c       |  103 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-ldp.c             |    1 +
 arch/arm/plat-omap/include/mach/board-ldp.h |    2 +
 4 files changed, 108 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-ldp-flash.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3897347..bfc9bcf 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -66,7 +66,8 @@ obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   twl4030-generic-scripts.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
 					   mmc-twl4030.o \
-					   usb-musb.o
+					   usb-musb.o \
+					   board-ldp-flash.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o
diff --git a/arch/arm/mach-omap2/board-ldp-flash.c b/arch/arm/mach-omap2/board-ldp-flash.c
new file mode 100644
index 0000000..06e0f2d
--- /dev/null
+++ b/arch/arm/mach-omap2/board-ldp-flash.c
@@ -0,0 +1,103 @@
+/*
+ * linux/arch/arm/mach-omap2/board-ldp-flash.c
+ *
+ * Copyright (C) 2008 Wind River Systems, Inc.
+ *
+ * Author: Stanley Miao <stanley.miao@windriver.com>
+ * Based on mach-omap2/board-3430sdp-flash.c by Rohit Choraria
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#include <asm/mach/flash.h>
+#include <mach/board.h>
+#include <mach/gpmc.h>
+#include <mach/nand.h>
+
+#define GPMC_CS0_BASE		0x60
+#define GPMC_CS_SIZE		0x30
+#define NAND_BLOCK_SIZE		SZ_128K
+
+static struct mtd_partition ldp_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader-NAND",
+		.offset		= 0,
+		.size		= 4 * NAND_BLOCK_SIZE,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 4 * NAND_BLOCK_SIZE,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "Boot Env-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x100000 */
+		.size		= 2 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name		= "Kernel-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x140000 */
+		.size		= 32 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name		= "File System - NAND",
+		.size		= MTDPART_SIZ_FULL,
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x540000 */
+	},
+};
+
+/* NAND chip access: 16 bit */
+static struct omap_nand_platform_data ldp_nand_data = {
+	.parts		= ldp_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(ldp_nand_partitions),
+	.nand_setup	= NULL,
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.dev_ready	= NULL,
+};
+
+static struct resource ldp_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device ldp_nand_device = {
+	.name		= "omap2-nand",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &ldp_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &ldp_nand_resource,
+};
+
+/**
+ * ldp430_flash_init - Identify devices connected to GPMC and register.
+ *
+ * @return - void.
+ */
+void __init ldp_flash_init(void)
+{
+	int nandcs = LDP_NAND_CS;
+	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
+
+	ldp_nand_data.cs = nandcs;
+	ldp_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
+					GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
+	ldp_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
+
+	if (platform_device_register(&ldp_nand_device) < 0)
+		printk(KERN_ERR "Unable to register NAND device\n");
+}
+
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 79f49d3..103ce6d 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -538,6 +538,7 @@ static void __init omap_ldp_init(void)
 				ARRAY_SIZE(ldp_spi_board_info));
 	msecure_init();
 	ads7846_dev_init();
+	ldp_flash_init();
 	omap_serial_init();
 	usb_musb_init();
 	hsmmc_init(mmc);
diff --git a/arch/arm/plat-omap/include/mach/board-ldp.h b/arch/arm/plat-omap/include/mach/board-ldp.h
index f233996..5174537 100644
--- a/arch/arm/plat-omap/include/mach/board-ldp.h
+++ b/arch/arm/plat-omap/include/mach/board-ldp.h
@@ -29,9 +29,11 @@
 #ifndef __ASM_ARCH_OMAP_LDP_H
 #define __ASM_ARCH_OMAP_LDP_H
 
+extern void ldp_flash_init(void);
 extern void twl4030_bci_battery_init(void);
 
 #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
+#define LDP_NAND_CS		0
 #define LDP_SMC911X_CS         1
 #define LDP_SMC911X_GPIO       152
 #define DEBUG_BASE             0x08000000
-- 
1.5.6.3

