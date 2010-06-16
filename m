From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v3 1/8] omap3 flash: rename board-sdp-flash.c to be use by other boards
Date: Wed, 16 Jun 2010 17:09:53 +0530
Message-ID: <1276688400-4812-2-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1276688400-4812-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48755 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758867Ab0FPLkF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 07:40:05 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5GBe2qr032121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 06:40:04 -0500
In-Reply-To: <1276688400-4812-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>

rename board-sdp-flash.c(board-flash.c) and board-sdp.h(board-flash.h) to
used by other board e.g. zoom

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/Makefile                   |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c            |   16 ++-
 arch/arm/mach-omap2/board-flash.c              |  253 ++++++++++++++++++++++
 arch/arm/mach-omap2/board-sdp-flash.c          |  267 ------------------------
 arch/arm/mach-omap2/include/mach/board-flash.h |   28 +++
 arch/arm/mach-omap2/include/mach/board-sdp.h   |   21 --
 6 files changed, 296 insertions(+), 291 deletions(-)
 create mode 100755 arch/arm/mach-omap2/board-flash.c
 delete mode 100755 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/include/mach/board-flash.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/board-sdp.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6c6d7c6..0d854f1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -117,7 +117,7 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   hsmmc.o \
-					   board-sdp-flash.o
+					   board-flash.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-sdram.o \
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index f474a80..4b8595b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -41,7 +41,7 @@
 #include <plat/control.h>
 #include <plat/gpmc-smc91x.h>
 
-#include <mach/board-sdp.h>
+#include <mach/board-flash.h>
 
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
@@ -667,6 +667,18 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
+/*
+ * SDP3430 V2 Board CS organization
+ * Different from SDP3430 V1. Now 4 switches used to specify CS
+ *
+ * See also the Switch S8 settings in the comments.
+ */
+static char chip_sel_3430[][GPMC_CS_NUM] = {
+	{PDC_NOR, PDC_NAND, PDC_ONENAND, DBG_MPDB, 0, 0, 0, 0}, /* S8:1111 */
+	{PDC_ONENAND, PDC_NAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1110 */
+	{PDC_NAND, PDC_ONENAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1101 */
+};
+
 static struct mtd_partition sdp_nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -797,7 +809,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
-	sdp_flash_init(sdp_flash_partitions);
+	board_flash_init(sdp_flash_partitions, chip_sel_3430);
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
new file mode 100755
index 0000000..ac834aa
--- /dev/null
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -0,0 +1,253 @@
+/*
+ * board-sdp-flash.c
+ * Modified from mach-omap2/board-3430sdp-flash.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * Vimal Singh <vimalsingh@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/io.h>
+
+#include <plat/gpmc.h>
+#include <plat/nand.h>
+#include <plat/onenand.h>
+#include <plat/tc.h>
+#include <mach/board-flash.h>
+
+#define REG_FPGA_REV			0x10
+#define REG_FPGA_DIP_SWITCH_INPUT2	0x60
+#define MAX_SUPPORTED_GPMC_CONFIG	3
+
+#define DEBUG_BASE		0x08000000 /* debug board */
+
+/* various memory sizes */
+#define FLASH_SIZE_SDPV1	SZ_64M	/* NOR flash (64 Meg aligned) */
+#define FLASH_SIZE_SDPV2	SZ_128M	/* NOR flash (256 Meg aligned) */
+
+static struct physmap_flash_data board_nor_data = {
+	.width		= 2,
+};
+
+static struct resource board_nor_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device board_nor_device = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev		= {
+			.platform_data = &board_nor_data,
+	},
+	.num_resources	= 1,
+	.resource	= &board_nor_resource,
+};
+
+static void
+__init board_nor_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
+{
+	int err;
+
+	board_nor_data.parts	= nor_parts;
+	board_nor_data.nr_parts	= nr_parts;
+
+	/* Configure start address and size of NOR device */
+	if (omap_rev() >= OMAP3430_REV_ES1_0) {
+		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV2 - 1,
+				(unsigned long *)&board_nor_resource.start);
+		board_nor_resource.end = board_nor_resource.start
+					+ FLASH_SIZE_SDPV2 - 1;
+	} else {
+		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV1 - 1,
+				(unsigned long *)&board_nor_resource.start);
+		board_nor_resource.end = board_nor_resource.start
+					+ FLASH_SIZE_SDPV1 - 1;
+	}
+	if (err < 0) {
+		printk(KERN_ERR "NOR: Can't request GPMC CS\n");
+		return;
+	}
+	if (platform_device_register(&board_nor_device) < 0)
+		printk(KERN_ERR	"Unable to register NOR device\n");
+}
+
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+static struct omap_onenand_platform_data board_onenand_data = {
+	.dma_channel	= -1,   /* disable DMA in OMAP OneNAND driver */
+};
+
+static void
+__init board_onenand_init(struct mtd_partition *onenand_parts,
+				u8 nr_parts, u8 cs)
+{
+	board_onenand_data.cs		= cs;
+	board_onenand_data.parts	= onenand_parts;
+	board_onenand_data.nr_parts	= nr_parts;
+
+	gpmc_onenand_init(&board_onenand_data);
+}
+#else
+static void
+__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
+{
+}
+#endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
+
+#if defined(CONFIG_MTD_NAND_OMAP2) || \
+		defined(CONFIG_MTD_NAND_OMAP2_MODULE)
+
+/* Note that all values in this struct are in nanoseconds */
+static struct gpmc_timings nand_timings = {
+
+	.sync_clk = 0,
+
+	.cs_on = 0,
+	.cs_rd_off = 36,
+	.cs_wr_off = 36,
+
+	.adv_on = 6,
+	.adv_rd_off = 24,
+	.adv_wr_off = 36,
+
+	.we_off = 30,
+	.oe_off = 48,
+
+	.access = 54,
+	.rd_cycle = 72,
+	.wr_cycle = 72,
+
+	.wr_access = 30,
+	.wr_data_mux_bus = 0,
+};
+
+static struct omap_nand_platform_data board_nand_data = {
+	.nand_setup	= NULL,
+	.gpmc_t		= &nand_timings,
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.dev_ready	= NULL,
+	.devsize	= 0,	/* '0' for 8-bit, '1' for 16-bit device */
+};
+
+void
+__init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
+{
+	board_nand_data.cs		= cs;
+	board_nand_data.parts		= nand_parts;
+	board_nand_data.nr_parts		= nr_parts;
+
+	gpmc_nand_init(&board_nand_data);
+}
+#else
+void
+__init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
+{
+}
+#endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
+
+/**
+ * get_gpmc0_type - Reads the FPGA DIP_SWITCH_INPUT_REGISTER2 to get
+ * the various cs values.
+ */
+static u8 get_gpmc0_type(void)
+{
+	u8 cs = 0;
+	void __iomem *fpga_map_addr;
+
+	fpga_map_addr = ioremap(DEBUG_BASE, 4096);
+	if (!fpga_map_addr)
+		return -ENOMEM;
+
+	if (!(__raw_readw(fpga_map_addr + REG_FPGA_REV)))
+		/* we dont have an DEBUG FPGA??? */
+		/* Depend on #defines!! default to strata boot return param */
+		goto unmap;
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
+unmap:
+	iounmap(fpga_map_addr);
+	return cs;
+}
+
+/**
+ * sdp3430_flash_init - Identify devices connected to GPMC and register.
+ *
+ * @return - void.
+ */
+void board_flash_init(struct flash_partitions partition_info[],
+					char chip_sel_board[][GPMC_CS_NUM])
+{
+	u8		cs = 0;
+	u8		norcs = GPMC_CS_NUM + 1;
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
+	config_sel = (unsigned char *)(chip_sel_board[idx]);
+
+	while (cs < GPMC_CS_NUM) {
+		switch (config_sel[cs]) {
+		case PDC_NOR:
+			if (norcs > GPMC_CS_NUM)
+				norcs = cs;
+			break;
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
+	if (norcs > GPMC_CS_NUM)
+		printk(KERN_INFO "NOR: Unable to find configuration "
+				"in GPMC\n");
+	else
+		board_nor_init(partition_info[0].parts,
+				partition_info[0].nr_parts, norcs);
+
+	if (onenandcs > GPMC_CS_NUM)
+		printk(KERN_INFO "OneNAND: Unable to find configuration "
+				"in GPMC\n");
+	else
+		board_onenand_init(partition_info[1].parts,
+					partition_info[1].nr_parts, onenandcs);
+
+	if (nandcs > GPMC_CS_NUM)
+		printk(KERN_INFO "NAND: Unable to find configuration "
+				"in GPMC\n");
+	else
+		board_nand_init(partition_info[2].parts,
+				partition_info[2].nr_parts, nandcs);
+}
diff --git a/arch/arm/mach-omap2/board-sdp-flash.c b/arch/arm/mach-omap2/board-sdp-flash.c
deleted file mode 100755
index 2638c83..0000000
--- a/arch/arm/mach-omap2/board-sdp-flash.c
+++ /dev/null
@@ -1,267 +0,0 @@
-/*
- * board-sdp-flash.c
- * Modified from mach-omap2/board-3430sdp-flash.c
- *
- * Copyright (C) 2009 Nokia Corporation
- * Copyright (C) 2009 Texas Instruments
- *
- * Vimal Singh <vimalsingh@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-#include <linux/io.h>
-
-#include <plat/gpmc.h>
-#include <plat/nand.h>
-#include <plat/onenand.h>
-#include <plat/tc.h>
-#include <mach/board-sdp.h>
-
-#define REG_FPGA_REV			0x10
-#define REG_FPGA_DIP_SWITCH_INPUT2	0x60
-#define MAX_SUPPORTED_GPMC_CONFIG	3
-
-#define DEBUG_BASE		0x08000000 /* debug board */
-
-#define PDC_NOR		1
-#define PDC_NAND	2
-#define PDC_ONENAND	3
-#define DBG_MPDB	4
-
-/* various memory sizes */
-#define FLASH_SIZE_SDPV1	SZ_64M	/* NOR flash (64 Meg aligned) */
-#define FLASH_SIZE_SDPV2	SZ_128M	/* NOR flash (256 Meg aligned) */
-
-/*
- * SDP3430 V2 Board CS organization
- * Different from SDP3430 V1. Now 4 switches used to specify CS
- *
- * See also the Switch S8 settings in the comments.
- *
- * REVISIT: Add support for 2430 SDP
- */
-static const unsigned char chip_sel_sdp[][GPMC_CS_NUM] = {
-	{PDC_NOR, PDC_NAND, PDC_ONENAND, DBG_MPDB, 0, 0, 0, 0}, /* S8:1111 */
-	{PDC_ONENAND, PDC_NAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1110 */
-	{PDC_NAND, PDC_ONENAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1101 */
-};
-
-static struct physmap_flash_data sdp_nor_data = {
-	.width		= 2,
-};
-
-static struct resource sdp_nor_resource = {
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device sdp_nor_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-			.platform_data = &sdp_nor_data,
-	},
-	.num_resources	= 1,
-	.resource	= &sdp_nor_resource,
-};
-
-static void
-__init board_nor_init(struct flash_partitions sdp_nor_parts, u8 cs)
-{
-	int err;
-
-	sdp_nor_data.parts	= sdp_nor_parts.parts;
-	sdp_nor_data.nr_parts	= sdp_nor_parts.nr_parts;
-
-	/* Configure start address and size of NOR device */
-	if (omap_rev() >= OMAP3430_REV_ES1_0) {
-		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV2 - 1,
-				(unsigned long *)&sdp_nor_resource.start);
-		sdp_nor_resource.end = sdp_nor_resource.start
-					+ FLASH_SIZE_SDPV2 - 1;
-	} else {
-		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV1 - 1,
-				(unsigned long *)&sdp_nor_resource.start);
-		sdp_nor_resource.end = sdp_nor_resource.start
-					+ FLASH_SIZE_SDPV1 - 1;
-	}
-	if (err < 0) {
-		printk(KERN_ERR "NOR: Can't request GPMC CS\n");
-		return;
-	}
-	if (platform_device_register(&sdp_nor_device) < 0)
-		printk(KERN_ERR	"Unable to register NOR device\n");
-}
-
-#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
-		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
-static struct omap_onenand_platform_data board_onenand_data = {
-	.dma_channel	= -1,   /* disable DMA in OMAP OneNAND driver */
-};
-
-static void
-__init board_onenand_init(struct flash_partitions sdp_onenand_parts, u8 cs)
-{
-	board_onenand_data.cs		= cs;
-	board_onenand_data.parts	= sdp_onenand_parts.parts;
-	board_onenand_data.nr_parts	= sdp_onenand_parts.nr_parts;
-
-	gpmc_onenand_init(&board_onenand_data);
-}
-#else
-static void
-__init board_onenand_init(struct flash_partitions sdp_onenand_parts, u8 cs)
-{
-}
-#endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
-
-#if defined(CONFIG_MTD_NAND_OMAP2) || \
-		defined(CONFIG_MTD_NAND_OMAP2_MODULE)
-
-/* Note that all values in this struct are in nanoseconds */
-static struct gpmc_timings nand_timings = {
-
-	.sync_clk = 0,
-
-	.cs_on = 0,
-	.cs_rd_off = 36,
-	.cs_wr_off = 36,
-
-	.adv_on = 6,
-	.adv_rd_off = 24,
-	.adv_wr_off = 36,
-
-	.we_off = 30,
-	.oe_off = 48,
-
-	.access = 54,
-	.rd_cycle = 72,
-	.wr_cycle = 72,
-
-	.wr_access = 30,
-	.wr_data_mux_bus = 0,
-};
-
-static struct omap_nand_platform_data sdp_nand_data = {
-	.nand_setup	= NULL,
-	.gpmc_t		= &nand_timings,
-	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
-	.dev_ready	= NULL,
-	.devsize	= 0,	/* '0' for 8-bit, '1' for 16-bit device */
-};
-
-static void
-__init board_nand_init(struct flash_partitions sdp_nand_parts, u8 cs)
-{
-	sdp_nand_data.cs		= cs;
-	sdp_nand_data.parts		= sdp_nand_parts.parts;
-	sdp_nand_data.nr_parts		= sdp_nand_parts.nr_parts;
-
-	gpmc_nand_init(&sdp_nand_data);
-}
-#else
-static void
-__init board_nand_init(struct flash_partitions sdp_nand_parts, u8 cs)
-{
-}
-#endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
-
-/**
- * get_gpmc0_type - Reads the FPGA DIP_SWITCH_INPUT_REGISTER2 to get
- * the various cs values.
- */
-static u8 get_gpmc0_type(void)
-{
-	u8 cs = 0;
-	void __iomem *fpga_map_addr;
-
-	fpga_map_addr = ioremap(DEBUG_BASE, 4096);
-	if (!fpga_map_addr)
-		return -ENOMEM;
-
-	if (!(__raw_readw(fpga_map_addr + REG_FPGA_REV)))
-		/* we dont have an DEBUG FPGA??? */
-		/* Depend on #defines!! default to strata boot return param */
-		goto unmap;
-
-	/* S8-DIP-OFF = 1, S8-DIP-ON = 0 */
-	cs = __raw_readw(fpga_map_addr + REG_FPGA_DIP_SWITCH_INPUT2) & 0xf;
-
-	/* ES2.0 SDP's onwards 4 dip switches are provided for CS */
-	if (omap_rev() >= OMAP3430_REV_ES1_0)
-		/* change (S8-1:4=DS-2:0) to (S8-4:1=DS-2:0) */
-		cs = ((cs & 8) >> 3) | ((cs & 4) >> 1) |
-			((cs & 2) << 1) | ((cs & 1) << 3);
-	else
-		/* change (S8-1:3=DS-2:0) to (S8-3:1=DS-2:0) */
-		cs = ((cs & 4) >> 2) | (cs & 2) | ((cs & 1) << 2);
-unmap:
-	iounmap(fpga_map_addr);
-	return cs;
-}
-
-/**
- * sdp3430_flash_init - Identify devices connected to GPMC and register.
- *
- * @return - void.
- */
-void __init sdp_flash_init(struct flash_partitions sdp_partition_info[])
-{
-	u8		cs = 0;
-	u8		norcs = GPMC_CS_NUM + 1;
-	u8		nandcs = GPMC_CS_NUM + 1;
-	u8		onenandcs = GPMC_CS_NUM + 1;
-	u8		idx;
-	unsigned char	*config_sel = NULL;
-
-	/* REVISIT: Is this return correct idx for 2430 SDP?
-	 * for which cs configuration matches for 2430 SDP?
-	 */
-	idx = get_gpmc0_type();
-	if (idx >= MAX_SUPPORTED_GPMC_CONFIG) {
-		printk(KERN_ERR "%s: Invalid chip select: %d\n", __func__, cs);
-		return;
-	}
-	config_sel = (unsigned char *)(chip_sel_sdp[idx]);
-
-	while (cs < GPMC_CS_NUM) {
-		switch (config_sel[cs]) {
-		case PDC_NOR:
-			if (norcs > GPMC_CS_NUM)
-				norcs = cs;
-			break;
-		case PDC_NAND:
-			if (nandcs > GPMC_CS_NUM)
-				nandcs = cs;
-			break;
-		case PDC_ONENAND:
-			if (onenandcs > GPMC_CS_NUM)
-				onenandcs = cs;
-			break;
-		};
-		cs++;
-	}
-
-	if (norcs > GPMC_CS_NUM)
-		printk(KERN_INFO "NOR: Unable to find configuration "
-				"in GPMC\n");
-	else
-		board_nor_init(sdp_partition_info[0], norcs);
-
-	if (onenandcs > GPMC_CS_NUM)
-		printk(KERN_INFO "OneNAND: Unable to find configuration "
-				"in GPMC\n");
-	else
-		board_onenand_init(sdp_partition_info[1], onenandcs);
-
-	if (nandcs > GPMC_CS_NUM)
-		printk(KERN_INFO "NAND: Unable to find configuration "
-				"in GPMC\n");
-	else
-		board_nand_init(sdp_partition_info[2], nandcs);
-}
diff --git a/arch/arm/mach-omap2/include/mach/board-flash.h b/arch/arm/mach-omap2/include/mach/board-flash.h
new file mode 100644
index 0000000..b2242ae
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/board-flash.h
@@ -0,0 +1,28 @@
+/*
+ *  board-sdp.h
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
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <plat/gpmc.h>
+
+#define PDC_NOR		1
+#define PDC_NAND	2
+#define PDC_ONENAND	3
+#define DBG_MPDB	4
+
+struct flash_partitions {
+	struct mtd_partition *parts;
+	int nr_parts;
+};
+
+extern void board_flash_init(struct flash_partitions [],
+				char chip_sel[][GPMC_CS_NUM]);
diff --git a/arch/arm/mach-omap2/include/mach/board-sdp.h b/arch/arm/mach-omap2/include/mach/board-sdp.h
deleted file mode 100644
index 465169c..0000000
--- a/arch/arm/mach-omap2/include/mach/board-sdp.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  board-sdp.h
- *
- *  Information structures for SDP-specific board config data
- *
- *  Copyright (C) 2009 Nokia Corporation
- *  Copyright (C) 2009 Texas Instruments
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-
-struct flash_partitions {
-	struct mtd_partition *parts;
-	int nr_parts;
-};
-
-extern void sdp_flash_init(struct flash_partitions []);
-- 
1.5.4.7

