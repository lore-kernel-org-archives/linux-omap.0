From: Nishant Kamat <nskamat@ti.com>
Subject: [PATCH 3/7] ARM: OMAP: Add NAND flash support for OMAP LDP
Date: Fri,  2 May 2008 06:23:57 -0500
Message-ID: <1209727441-4312-4-git-send-email-nskamat@ti.com>
References: <1209727441-4312-1-git-send-email-nskamat@ti.com>
 <1209727441-4312-2-git-send-email-nskamat@ti.com>
 <1209727441-4312-3-git-send-email-nskamat@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:59111 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762827AbYEBLYL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 May 2008 07:24:11 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m42BO56k003841
	for <linux-omap@vger.kernel.org>; Fri, 2 May 2008 06:24:10 -0500
In-Reply-To: <1209727441-4312-3-git-send-email-nskamat@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rohit Choraria <rohitkc@ti.com>, Nishant Kamat <nskamat@ti.com>

From: Rohit Choraria <rohitkc@ti.com>

This patch adds NAND flash support for OMAP LDP platform.

Signed-off-by: Rohit Choraria <rohitkc@ti.com>
Signed-off-by: Nishant Kamat <nskamat@ti.com>
---
 arch/arm/configs/omap_ldp_defconfig   |  101 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/Makefile          |    3 +-
 arch/arm/mach-omap2/board-ldp-flash.c |  115 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-ldp.c       |    1 +
 include/asm-arm/arch-omap/board-ldp.h |    2 +
 5 files changed, 219 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-ldp-flash.c

diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index 20c3e03..1c04221 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.25-omap1
-# Mon Apr 28 18:36:47 2008
+# Mon Apr 28 19:52:04 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -333,7 +333,91 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AFS_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_ARM_INTEGRATOR is not set
+CONFIG_MTD_OMAP_NOR=y
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+CONFIG_MTD_NAND_ECC_SMC=y
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
@@ -823,6 +907,17 @@ CONFIG_TMPFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
@@ -1032,6 +1127,8 @@ CONFIG_CRC_CCITT=y
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f58d341..73406f2 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -42,7 +42,8 @@ obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   usb-musb.o usb-ehci.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
-					   hsmmc.o
+					   hsmmc.o \
+					   board-ldp-flash.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o
diff --git a/arch/arm/mach-omap2/board-ldp-flash.c b/arch/arm/mach-omap2/board-ldp-flash.c
new file mode 100644
index 0000000..c2c1370
--- /dev/null
+++ b/arch/arm/mach-omap2/board-ldp-flash.c
@@ -0,0 +1,115 @@
+/*
+ * linux/arch/arm/mach-omap2/board-ldp-flash.c
+ *
+ * Copyright (C) 2008 Texas Instruments Inc.
+ *
+ * Modified from mach-omap2/board-2430sdp-flash.c
+ * Author: Rohit Choraria <rohitkc@ti.com>
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
+#include <asm/arch/board.h>
+#include <asm/arch/gpmc.h>
+#include <asm/arch/nand.h>
+
+#define GPMC_CS0_BASE	0x60
+#define GPMC_CS_SIZE	0x30
+
+static struct mtd_partition ldp_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader-NAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 4 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "Boot Env-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x100000 */
+		.size		= 2 * (64 * 2048),
+	},
+	{
+		.name		= "Kernel-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x140000 */
+		.size		= 32 * (64 * 2048),
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
+	.platform_data	= &ldp_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &ldp_nand_resource,
+};
+
+void __init ldp_flash_init(void)
+{
+	u8 cs = 0;
+	u8 nandcs = GPMC_CS_NUM + 1;
+	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
+
+	/* find out the chip-select on which NAND exists */
+	while (cs < GPMC_CS_NUM) {
+		u32 ret = 0;
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+		if ((ret & 0xC00) == 0x800) {
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+		}
+		cs++;
+	}
+	if (nandcs > GPMC_CS_NUM) {
+		printk(KERN_INFO "NAND: Unable to find configuration "
+				"in GPMC\n ");
+		return;
+	}
+	if (nandcs < GPMC_CS_NUM) {
+		ldp_nand_data.cs = nandcs;
+		ldp_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
+					GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
+		ldp_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
+
+		if (platform_device_register(&ldp_nand_device) < 0)
+			printk(KERN_ERR "Unable to register NAND device\n");
+	}
+}
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 4994dd8..6a4339a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -229,6 +229,7 @@ static void __init omap_ldp_init(void)
 	spi_register_board_info(ldp_spi_board_info,
 				ARRAY_SIZE(ldp_spi_board_info));
 	ads7846_dev_init();
+	ldp_flash_init();
 	omap_serial_init();
 	hsmmc_init();
 }
diff --git a/include/asm-arm/arch-omap/board-ldp.h b/include/asm-arm/arch-omap/board-ldp.h
index b227561..88b02a8 100644
--- a/include/asm-arm/arch-omap/board-ldp.h
+++ b/include/asm-arm/arch-omap/board-ldp.h
@@ -29,6 +29,8 @@
 #ifndef __ASM_ARCH_OMAP_LDP_H
 #define __ASM_ARCH_OMAP_LDP_H
 
+extern void ldp_flash_init(void);
+
 #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
 
 #endif /* __ASM_ARCH_OMAP_LDP_H */
-- 
1.5.3.2

