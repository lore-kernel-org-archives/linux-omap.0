From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: 2430SDP support for omap2 OneNAND driver
Date: Thu, 26 Apr 2007 14:47:08 -0700
Message-ID: <20070426214708.826206518@mvista.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Adds platform device for use of existing OMAP2 driver.  Also, fixes up
GPMC defines which are different between 2420 and 2430.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/Makefile              |    3 
 arch/arm/mach-omap2/board-2430sdp-flash.c |  110 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-2430sdp.c       |    4 +
 arch/arm/mach-omap2/gpmc.c                |    1 
 include/asm-arm/arch-omap/gpmc.h          |    6 +
 include/asm-arm/arch-omap/onenand.h       |    1 
 6 files changed, 123 insertions(+), 2 deletions(-)

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
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-keys.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
Index: dev/arch/arm/mach-omap2/board-2430sdp-flash.c
===================================================================
--- /dev/null
+++ dev/arch/arm/mach-omap2/board-2430sdp-flash.c
@@ -0,0 +1,110 @@
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
+#define GPMC_OFF_CONFIG1_0 0x60
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
+		gpmc_cs_base_add =
+			(gpmc_base_add + GPMC_OFF_CONFIG1_0 + (cs*0x30));
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
@@ -22,6 +25,9 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24
 
+#define GPMC_CONFIG		0x50
+#define GPMC_STATUS		0x54
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
