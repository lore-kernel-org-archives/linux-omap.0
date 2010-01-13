From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 2/3] OMAP: SDP: Introducing 'board-sdp-flash.c' for flash init
Date: Wed, 13 Jan 2010 12:23:04 +0530
Message-ID: <ce9ab5791001122253u6b431290o136b2586d90ca92b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43455 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab0AMGx0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 01:53:26 -0500
Received: by bwz27 with SMTP id 27so1716281bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 22:53:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From 994785b066a9bd4fbaf7753cb6ab7317440afd36 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 12 Jan 2010 17:22:42 +0530
Subject: [PATCH] OMAP: SDP: Introducing 'board-sdp-flash.c' for flash init

This patch adds 'board-sdp-flash.c', which could be utilized
by boards similar to 3430SDP. (For ex: 2430sdp, 36030sdp).

This file does initialization for all three flash devices present
in SDP boards (NOR, NAND, OneNAND), by finding there 'cs' number
dynamically using switch setting information (S8: 1-4).
This also expects partition information from core board files (for
ex: board-3430sdp.c). Which allows to choose different default
partitions for different boards.

A new structure is created for this purpose: 'flash_partitions'
in 'mach/board-sdp.h'. This has two members:
1. struct mtd_partition *parts
2. int nr_parts

A board file is expected to fill this structure and pass it to
'sdp-flsash-init'. Partition information should be passed in
structure array of 'flash_partitions'. Partition information should
be passed in below sequence in array:
NOR
OneNAND
NAND

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/board-sdp-flash.c        |  295 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/board-sdp.h |   22 ++
 arch/arm/plat-omap/include/plat/gpmc.h       |    2 +
 3 files changed, 319 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/include/mach/board-sdp.h

diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
b/arch/arm/mach-omap2/board-sdp-flash.c
new file mode 100644
index 0000000..54ef19f
--- /dev/null
+++ b/arch/arm/mach-omap2/board-sdp-flash.c
@@ -0,0 +1,295 @@
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
+#include <mach/board-sdp.h>
+
+#define REG_FPGA_REV			0x10
+#define REG_FPGA_DIP_SWITCH_INPUT2	0x60
+#define MAX_SUPPORTED_GPMC_CONFIG	3
+
+#define DEBUG_BASE		0x08000000 /* debug board */
+
+#define PDC_NOR		1
+#define PDC_NAND	2
+#define PDC_ONENAND	3
+#define DBG_MPDB	4
+
+/* various memory sizes */
+#define FLASH_SIZE_SDPV1	SZ_64M	/* NOR flash (64 Meg aligned) */
+#define FLASH_SIZE_SDPV2	SZ_128M	/* NOR flash (256 Meg aligned) */
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
+static void omap_set_vpp(struct map_info *map, int enable)
+{
+	static int      count;
+	u32 l;
+
+	if (cpu_class_is_omap1()) {
+		if (enable) {
+			if (count++ == 0) {
+				l = omap_readl(EMIFS_CONFIG);
+				l |= OMAP_EMIFS_CONFIG_WP;
+				omap_writel(l, EMIFS_CONFIG);
+			}
+		} else {
+			if (count && (--count == 0)) {
+				l = omap_readl(EMIFS_CONFIG);
+				l &= ~OMAP_EMIFS_CONFIG_WP;
+				omap_writel(l, EMIFS_CONFIG);
+			}
+		}
+	}
+}
+
+static struct physmap_flash_data sdp_nor_data = {
+	.width		= 2,
+	.set_vpp	= omap_set_vpp,
+};
+
+static struct resource sdp_nor_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device sdp_nor_device = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev		= {
+			.platform_data = &sdp_nor_data,
+	},
+	.num_resources	= 1,
+	.resource	= &sdp_nor_resource,
+};
+
+static void
+__init board_nor_init(struct flash_partitions sdp_nor_parts, u8 cs)
+{
+	int err;
+
+	sdp_nor_data.parts	= sdp_nor_parts.parts;
+	sdp_nor_data.nr_parts	= sdp_nor_parts.nr_parts;
+
+	/* Configure start address and size of NOR device */
+	if (omap_rev() >= OMAP3430_REV_ES1_0) {
+		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV2 - 1,
+				(unsigned long *)&sdp_nor_resource.start);
+		sdp_nor_resource.end = sdp_nor_resource.start
+					+ FLASH_SIZE_SDPV2 - 1;
+	} else {
+		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV1 - 1,
+				(unsigned long *)&sdp_nor_resource.start);
+		sdp_nor_resource.end = sdp_nor_resource.start
+					+ FLASH_SIZE_SDPV1 - 1;
+	}
+	if (err < 0) {
+		printk(KERN_ERR "NOR: Can't request GPMC CS\n");
+		return;
+	}
+	if (platform_device_register(&sdp_nor_device) < 0)
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
+__init board_onenand_init(struct flash_partitions sdp_onenand_parts, u8 cs)
+{
+	board_onenand_data.cs		= cs;
+	board_onenand_data.parts	= sdp_onenand_parts.parts;
+	board_onenand_data.nr_parts	= sdp_onenand_parts.nr_parts;
+
+	gpmc_onenand_init(&board_onenand_data);
+}
+#else
+static void
+__init board_onenand_init(struct flash_partitions sdp_onenand_parts, u8 cs)
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
+static struct omap_nand_platform_data sdp_nand_data = {
+	.nand_setup	= NULL,
+	.gpmc_t		= &nand_timings,
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.dev_ready	= NULL,
+	.devsize	= 0,	/* '0' for 8-bit, '1' for 16-bit device */
+};
+
+static void
+__init board_nand_init(struct flash_partitions sdp_nand_parts, u8 cs)
+{
+	sdp_nand_data.cs		= cs;
+	sdp_nand_data.parts		= sdp_nand_parts.parts;
+	sdp_nand_data.nr_parts		= sdp_nand_parts.nr_parts;
+
+	sdp_nand_data.gpmc_cs_baseaddr	= (void *)(OMAP34XX_GPMC_VIRT +
+							GPMC_CS0_BASE +
+							cs * GPMC_CS_SIZE);
+	sdp_nand_data.gpmc_baseaddr	 = (void *) (OMAP34XX_GPMC_VIRT);
+
+	gpmc_nand_init(&sdp_nand_data);
+}
+#else
+static void
+__init board_nand_init(struct flash_partitions sdp_nand_parts, u8 cs)
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
+void __init sdp_flash_init(struct flash_partitions sdp_partition_info[])
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
+	config_sel = (unsigned char *)(chip_sel_sdp[idx]);
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
+		printk(KERN_INFO "OneNAND: Unable to find configuration "
+				" in GPMC\n ");
+	else
+		board_nor_init(sdp_partition_info[0], norcs);
+
+	if (onenandcs > GPMC_CS_NUM)
+		printk(KERN_INFO "OneNAND: Unable to find configuration "
+				" in GPMC\n ");
+	else
+		board_onenand_init(sdp_partition_info[1], onenandcs);
+
+	if (nandcs > GPMC_CS_NUM)
+		printk(KERN_INFO "NAND: Unable to find configuration "
+				" in GPMC\n ");
+	else
+		board_nand_init(sdp_partition_info[2], nandcs);
+}
diff --git a/arch/arm/mach-omap2/include/mach/board-sdp.h
b/arch/arm/mach-omap2/include/mach/board-sdp.h
new file mode 100644
index 0000000..a2f7ba2
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/board-sdp.h
@@ -0,0 +1,22 @@
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
+
+struct flash_partitions {
+	struct mtd_partition *parts;
+	int nr_parts;
+};
+
+extern void sdp_flash_init(struct flash_partitions []);
+
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h
b/arch/arm/plat-omap/include/plat/gpmc.h
index e081338..4090749 100644
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
