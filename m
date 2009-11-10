From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards
Date: Tue, 10 Nov 2009 15:38:13 +0530
Message-ID: <ce9ab5790911100208j33822a11s5b521e69a94a08a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:38556 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbZKJKI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 05:08:29 -0500
Received: by bwz27 with SMTP id 27so4354260bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 02:08:33 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From 42f080e0915bbce1509fc8ab3773569fec0a44f1 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 10 Nov 2009 11:39:39 +0530
Subject: [PATCH] OMAP2/3: Add support for flash on SDP boards

Add support for flash on SDP boards. NAND, NOR and OneNAND
are supported.

Only tested on 3430SDP (ES2 and ES3.1), somebody please test on
2430SDP and check the chips select for 2430SDP.

Also note that:
For OneNAND: in the earlier 2430SDP code the kernel partition
was set to only 1MB instead of 2MB on 3430SDP. If people want
the old partition sizes back on 2430SDP, please provide a patch.

For NAND: 'U-Boot', 'Boot Env' and 'Kernel' partitions sizes increased
by few blocks to provide few spare blocks for NAND bab block management
in u-boot. If people want old partition sizes, please provide a patch.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile                |    2 +
 arch/arm/mach-omap2/board-2430sdp.c         |    2 +
 arch/arm/mach-omap2/board-3430sdp.c         |    2 +
 arch/arm/mach-omap2/board-sdp-flash.c       |  326 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/board-sdp.h |   15 ++
 arch/arm/plat-omap/include/plat/gpmc.h      |    2 +
 6 files changed, 349 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/plat-omap/include/plat/board-sdp.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 03cb4fc..627f500 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
+					   board-sdp-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
@@ -66,6 +67,7 @@ obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
+					   board-sdp-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
diff --git a/arch/arm/mach-omap2/board-2430sdp.c
b/arch/arm/mach-omap2/board-2430sdp.c
index db9374b..5676ab9 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -38,6 +38,7 @@
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>

+#include <plat/board-sdp.h>
 #include "mmc-twl4030.h"

 #define SDP2430_CS0_BASE	0x04000000
@@ -205,6 +206,7 @@ static void __init omap_2430sdp_init(void)
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
 	board_smc91x_init();
+	sdp_flash_init();

 	/* Turn off secondary LCD backlight */
 	ret = gpio_request(SECONDARY_LCD_GPIO, "Secondary LCD backlight");
diff --git a/arch/arm/mach-omap2/board-3430sdp.c
b/arch/arm/mach-omap2/board-3430sdp.c
index a3c1271..4497ded 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -41,6 +41,7 @@
 #include <plat/control.h>
 #include <plat/gpmc-smc91x.h>

+#include <plat/board-sdp.h>
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"

@@ -511,6 +512,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	board_smc91x_init();
+ 	sdp_flash_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
 }
diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
b/arch/arm/mach-omap2/board-sdp-flash.c
new file mode 100644
index 0000000..c881772
--- /dev/null
+++ b/arch/arm/mach-omap2/board-sdp-flash.c
@@ -0,0 +1,326 @@
+/*
+ * arch/arm/mach-omap2/board-sdp-flash.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2007 Texas Instruments
+ *
+ * Modified from mach-omap2/board-3430sdp-flash.c
+ * Author: Vimal Singh <vimalsingh@ti.com>
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
+#include <linux/io.h>
+
+#include <asm/mach/flash.h>
+#include <plat/onenand.h>
+#include <plat/gpmc.h>
+#include <plat/nand.h>
+
+#define REG_FPGA_REV			0x10
+#define REG_FPGA_DIP_SWITCH_INPUT2	0x60
+#define MAX_SUPPORTED_GPMC_CONFIG	3
+
+/* various memory sizes */
+#define FLASH_SIZE_SDPV1	SZ_64M
+#define FLASH_SIZE_SDPV2	SZ_128M
+
+#define FLASH_BASE_SDPV1	0x04000000 /* NOR flash (64 Meg aligned) */
+#define FLASH_BASE_SDPV2	0x10000000 /* NOR flash (256 Meg aligned) */
+
+#define DEBUG_BASE		0x08000000 /* debug board */
+
+#define PDC_NOR		1
+#define PDC_NAND	2
+#define PDC_ONENAND	3
+#define DBG_MPDB	4
+
+/*
+ * SDP3430 V2 Board CS organization
+ * Different from SDP3430 V1. Now 4 switches used to specify CS
+ *
+ * See also the Switch S8 settings in the comments.
+ *
+ * REVISIT: Add support for 2430 SDP
+ */
+static const unsigned char chip_sel_sdp[][GPMC_CS_NUM] = {
+	{PDC_NOR, PDC_NAND, PDC_ONENAND, DBG_MPDB, 0, 0, 0, 0}, /* S8:1111 */
+	{PDC_ONENAND, PDC_NAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1110 */
+	{PDC_NAND, PDC_ONENAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1101 */
+};
+
+static struct mtd_partition sdp_nor_partitions[] = {
+	/* bootloader (U-Boot, etc) in first sector */
+	{
+		.name		= "Bootloader-NOR",
+		.offset		= 0,
+		.size		= SZ_256K,
+		.mask_flags	= MTD_WRITEABLE, /* force read-only */
+	},
+	/* bootloader params in the next sector */
+	{
+		.name		= "Params-NOR",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_256K,
+		.mask_flags	= 0,
+	},
+	/* kernel */
+	{
+		.name		= "Kernel-NOR",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_2M,
+		.mask_flags	= 0
+	},
+	/* file system */
+	{
+		.name		= "Filesystem-NOR",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+		.mask_flags	= 0
+	}
+};
+
+static struct flash_platform_data sdp_nor_data = {
+	.map_name	= "cfi_probe",
+	.width		= 2,
+	.parts		= sdp_nor_partitions,
+	.nr_parts	= ARRAY_SIZE(sdp_nor_partitions),
+};
+
+static struct resource sdp_nor_resource = {
+	.start		= 0,
+	.end		= 0,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device sdp_nor_device = {
+	.name		= "omapflash",
+	.id		= 0,
+	.dev		= {
+			.platform_data = &sdp_nor_data,
+	},
+	.num_resources	= 1,
+	.resource	= &sdp_nor_resource,
+};
+
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+
+static struct mtd_partition board_onenand_partitions[] = {
+	{
+		.name		= "X-Loader-OneNAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE  /* force read-only */
+	},
+	{
+		.name		= "U-Boot-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 2 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE  /* force read-only */
+	},
+	{
+		.name		= "U-Boot Environment-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 1 * (64 * 2048),
+	},
+	{
+		.name		= "Kernel-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 16 * (64 * 2048),
+	},
+	{
+		.name		= "File System-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data board_onenand_data = {
+	.parts		= board_onenand_partitions,
+	.nr_parts	= ARRAY_SIZE(board_onenand_partitions),
+	.dma_channel	= -1,   /* disable DMA in OMAP OneNAND driver */
+};
+
+
+static void __init board_onenand_init(u8 cs)
+{
+	board_onenand_data.cs = cs;
+	gpmc_onenand_init(&board_onenand_data);
+}
+
+#else
+
+static inline void board_onenand_init(u8 cs)
+{
+}
+#endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
+
+static struct mtd_partition sdp_nand_partitions[] = {
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
+		.size		= 10 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "Boot Env-NAND",
+
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x1c0000 */
+		.size		= 6 * (64 * 2048),
+	},
+	{
+		.name		= "Kernel-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.size		= 40 * (64 * 2048),
+	},
+	{
+		.name		= "File System - NAND",
+		.size		= MTDPART_SIZ_FULL,
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x780000 */
+	},
+};
+
+static struct omap_nand_platform_data sdp_nand_data = {
+	.parts		= sdp_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(sdp_nand_partitions),
+	.nand_setup	= NULL,
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.dev_ready	= NULL,
+};
+
+static struct resource sdp_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device sdp_nand_device = {
+	.name			= "omap2-nand",
+	.id			= 0,
+	.dev			= {
+		.platform_data	= &sdp_nand_data,
+	},
+	.num_resources	= 1,
+	.resource		= &sdp_nand_resource,
+};
+
+void board_nand_init(u8 cs)
+{
+	sdp_nand_data.cs = cs;
+	sdp_nand_data.gpmc_cs_baseaddr = (void *)(OMAP34XX_GPMC_VIRT +
+					GPMC_CS0_BASE + cs * GPMC_CS_SIZE);
+	sdp_nand_data.gpmc_baseaddr = (void *) (OMAP34XX_GPMC_VIRT);
+
+	if (platform_device_register(&sdp_nand_device) < 0)
+		printk(KERN_ERR "Unable to register NAND device\n");
+}
+
+/**
+ * get_gpmc0_type - Reads the FPGA DIP_SWITCH_INPUT_REGISTER2 to get
+ * the various cs values.
+ */
+static u8 get_gpmc0_type(void)
+{
+	u8 cs;
+	void __iomem *fpga_map_addr;
+
+	fpga_map_addr = ioremap(DEBUG_BASE, 4096);
+	if (!fpga_map_addr)
+		return -ENOMEM;
+
+	if (!(__raw_readw(fpga_map_addr + REG_FPGA_REV)))
+		/* we dont have an DEBUG FPGA??? */
+		/* Depend on #defines!! default to strata boot return param */
+		return 0x0;
+
+	/* S8-DIP-OFF = 1, S8-DIP-ON = 0 */
+	cs = __raw_readw(fpga_map_addr + REG_FPGA_DIP_SWITCH_INPUT2) & 0xf;
+
+	/* ES2.0 SDP's onwards 4 dip switches are provided for CS */
+	if (omap_rev() >= OMAP3430_REV_ES1_0)
+		/* change (S8-1:4=DS-2:0) to (S8-4:1=DS-2:0) */
+		cs = ((cs & 8) >> 3) | ((cs & 4) >> 1) |
+			((cs & 2) << 1) | ((cs & 1) << 3);
+	else
+		/* change (S8-1:3=DS-2:0) to (S8-3:1=DS-2:0) */
+		cs = ((cs & 4) >> 2) | (cs & 2) | ((cs & 1) << 2);
+
+	iounmap(fpga_map_addr);
+	return cs;
+}
+
+/**
+ * sdp3430_flash_init - Identify devices connected to GPMC and register.
+ *
+ * @return - void.
+ */
+void __init sdp_flash_init(void)
+{
+	u8		cs = 0;
+	u8		nandcs = GPMC_CS_NUM + 1;
+	u8		onenandcs = GPMC_CS_NUM + 1;
+	u8		idx;
+	unsigned char	*config_sel = NULL;
+
+	/* REVISIT: Is this return correct idx for 2430 SDP?
+	 * for which cs configuration matches for 2430 SDP?
+	 */
+	idx = get_gpmc0_type();
+	if (idx >= MAX_SUPPORTED_GPMC_CONFIG) {
+		printk(KERN_ERR "%s: Invalid chip select: %d\n", __func__, cs);
+		return;
+	}
+	config_sel = (unsigned char *)(chip_sel_sdp[idx]);
+
+	/* Configure start address and size of NOR device */
+	if (omap_rev() >= OMAP3430_REV_ES1_0) {
+		sdp_nor_resource.start	= FLASH_BASE_SDPV2;
+		sdp_nor_resource.end	= FLASH_BASE_SDPV2
+						+ FLASH_SIZE_SDPV2 - 1;
+	} else {
+		sdp_nor_resource.start	= FLASH_BASE_SDPV1;
+		sdp_nor_resource.end	= FLASH_BASE_SDPV1
+						+ FLASH_SIZE_SDPV1 - 1;
+	}
+
+	if (platform_device_register(&sdp_nor_device) < 0)
+		printk(KERN_ERR "Unable to register NOR device\n");
+
+	while (cs < GPMC_CS_NUM) {
+		switch (config_sel[cs]) {
+		case PDC_NAND:
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+			break;
+		case PDC_ONENAND:
+			if (onenandcs > GPMC_CS_NUM)
+				onenandcs = cs;
+			break;
+		};
+		cs++;
+	}
+
+	if (onenandcs > GPMC_CS_NUM)
+		printk(KERN_INFO "OneNAND: Unable to find configuration "
+				" in GPMC\n ");
+	else
+		board_onenand_init(onenandcs);
+
+	if (nandcs > GPMC_CS_NUM)
+		printk(KERN_INFO "NAND: Unable to find configuration "
+				" in GPMC\n ");
+	else
+		board_nand_init(nandcs);
+}
diff --git a/arch/arm/plat-omap/include/plat/board-sdp.h
b/arch/arm/plat-omap/include/plat/board-sdp.h
new file mode 100644
index 0000000..632f21a
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/board-sdp.h
@@ -0,0 +1,15 @@
+/*
+ *  arch/arm/plat-omap/include/plat/board-sdp.h
+ *
+ *  Information structures for SDP-specific board config data
+ *
+ *  Copyright (C) 2009 Nokia Corporation
+ *  Copyright (C) 2009 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+extern void sdp_flash_init(void);
+
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h
b/arch/arm/plat-omap/include/plat/gpmc.h
index 9c99cda..c752ab7 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -27,6 +27,8 @@

 #define GPMC_CONFIG		0x50
 #define GPMC_STATUS		0x54
+#define GPMC_CS0_BASE		0x60
+#define GPMC_CS_SIZE		0x30

 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
-- 
1.5.5
