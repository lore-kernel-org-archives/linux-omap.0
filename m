From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [RESEND PATCH 3/3] ARM: OMAP2+: Remove legacy board-flash.c
Date: Wed, 19 Mar 2014 07:08:15 +0100
Message-ID: <1395209295-24399-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1395209295-24399-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:58621 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbaCSGIt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 02:08:49 -0400
In-Reply-To: <1395209295-24399-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Legacy board files in mach-omap2 used the helper functions
board_{nor,nand,onenand}_init() to initialize the flash
devices attached to the GPMC.

With Device Tree booting the initialization is handled by
the GPMC driver gpmc_probe_*_child() functions so this
code is not needed anymore now that OMAP2+ is DT-only.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile      |   4 -
 arch/arm/mach-omap2/board-flash.c | 245 --------------------------------------
 arch/arm/mach-omap2/board-flash.h |  62 ----------
 3 files changed, 311 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-flash.c
 delete mode 100644 arch/arm/mach-omap2/board-flash.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 103f1e8..aa75e9b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -264,10 +264,6 @@ obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8168evm.o
 
 # Platform specific device init code
 
-omap-flash-$(CONFIG_MTD_NAND_OMAP2)	:= board-flash.o
-omap-flash-$(CONFIG_MTD_ONENAND_OMAP2)	:= board-flash.o
-obj-y					+= $(omap-flash-y) $(omap-flash-m)
-
 omap-hsmmc-$(CONFIG_MMC_OMAP_HS)	:= hsmmc.o
 obj-y					+= $(omap-hsmmc-m) $(omap-hsmmc-y)
 
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
deleted file mode 100644
index ac82512..0000000
--- a/arch/arm/mach-omap2/board-flash.c
+++ /dev/null
@@ -1,245 +0,0 @@
-/*
- * board-flash.c
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
-#include <linux/platform_data/mtd-nand-omap2.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
-
-#include "soc.h"
-#include "common.h"
-#include "board-flash.h"
-#include "gpmc-onenand.h"
-#include "gpmc-nand.h"
-
-#define REG_FPGA_REV			0x10
-#define REG_FPGA_DIP_SWITCH_INPUT2	0x60
-#define MAX_SUPPORTED_GPMC_CONFIG	3
-
-#define DEBUG_BASE		0x08000000 /* debug board */
-
-/* various memory sizes */
-#define FLASH_SIZE_SDPV1	SZ_64M	/* NOR flash (64 Meg aligned) */
-#define FLASH_SIZE_SDPV2	SZ_128M	/* NOR flash (256 Meg aligned) */
-
-static struct physmap_flash_data board_nor_data = {
-	.width		= 2,
-};
-
-static struct resource board_nor_resource = {
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device board_nor_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-			.platform_data = &board_nor_data,
-	},
-	.num_resources	= 1,
-	.resource	= &board_nor_resource,
-};
-
-static void
-__init board_nor_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
-{
-	int err;
-
-	board_nor_data.parts	= nor_parts;
-	board_nor_data.nr_parts	= nr_parts;
-
-	/* Configure start address and size of NOR device */
-	if (omap_rev() >= OMAP3430_REV_ES1_0) {
-		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV2 - 1,
-				(unsigned long *)&board_nor_resource.start);
-		board_nor_resource.end = board_nor_resource.start
-					+ FLASH_SIZE_SDPV2 - 1;
-	} else {
-		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV1 - 1,
-				(unsigned long *)&board_nor_resource.start);
-		board_nor_resource.end = board_nor_resource.start
-					+ FLASH_SIZE_SDPV1 - 1;
-	}
-	if (err < 0) {
-		pr_err("NOR: Can't request GPMC CS\n");
-		return;
-	}
-	if (platform_device_register(&board_nor_device) < 0)
-		pr_err("Unable to register NOR device\n");
-}
-
-#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
-		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
-static struct omap_onenand_platform_data board_onenand_data = {
-	.dma_channel	= -1,   /* disable DMA in OMAP OneNAND driver */
-};
-
-void
-__init board_onenand_init(struct mtd_partition *onenand_parts,
-				u8 nr_parts, u8 cs)
-{
-	board_onenand_data.cs		= cs;
-	board_onenand_data.parts	= onenand_parts;
-	board_onenand_data.nr_parts	= nr_parts;
-
-	gpmc_onenand_init(&board_onenand_data);
-}
-#endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
-
-#if defined(CONFIG_MTD_NAND_OMAP2) || \
-		defined(CONFIG_MTD_NAND_OMAP2_MODULE)
-
-/* Note that all values in this struct are in nanoseconds */
-struct gpmc_timings nand_default_timings[1] = {
-	{
-		.sync_clk = 0,
-
-		.cs_on = 0,
-		.cs_rd_off = 36,
-		.cs_wr_off = 36,
-
-		.we_on = 6,
-		.oe_on = 6,
-
-		.adv_on = 6,
-		.adv_rd_off = 24,
-		.adv_wr_off = 36,
-
-		.we_off = 30,
-		.oe_off = 48,
-
-		.access = 54,
-		.rd_cycle = 72,
-		.wr_cycle = 72,
-
-		.wr_access = 30,
-		.wr_data_mux_bus = 0,
-	},
-};
-
-static struct omap_nand_platform_data board_nand_data;
-
-void
-__init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs,
-				int nand_type, struct gpmc_timings *gpmc_t)
-{
-	board_nand_data.cs		= cs;
-	board_nand_data.parts		= nand_parts;
-	board_nand_data.nr_parts	= nr_parts;
-	board_nand_data.devsize		= nand_type;
-
-	board_nand_data.ecc_opt = OMAP_ECC_BCH8_CODE_HW;
-	gpmc_nand_init(&board_nand_data, gpmc_t);
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
- * board_flash_init - Identify devices connected to GPMC and register.
- *
- * @return - void.
- */
-void __init board_flash_init(struct flash_partitions partition_info[],
-			char chip_sel_board[][GPMC_CS_NUM], int nand_type)
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
-		pr_err("%s: Invalid chip select: %d\n", __func__, cs);
-		return;
-	}
-	config_sel = (unsigned char *)(chip_sel_board[idx]);
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
-		}
-		cs++;
-	}
-
-	if (norcs > GPMC_CS_NUM)
-		pr_err("NOR: Unable to find configuration in GPMC\n");
-	else
-		board_nor_init(partition_info[0].parts,
-				partition_info[0].nr_parts, norcs);
-
-	if (onenandcs > GPMC_CS_NUM)
-		pr_err("OneNAND: Unable to find configuration in GPMC\n");
-	else
-		board_onenand_init(partition_info[1].parts,
-					partition_info[1].nr_parts, onenandcs);
-
-	if (nandcs > GPMC_CS_NUM)
-		pr_err("NAND: Unable to find configuration in GPMC\n");
-	else
-		board_nand_init(partition_info[2].parts,
-			partition_info[2].nr_parts, nandcs,
-			nand_type, nand_default_timings);
-}
diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
deleted file mode 100644
index 2fb5d41..0000000
--- a/arch/arm/mach-omap2/board-flash.h
+++ /dev/null
@@ -1,62 +0,0 @@
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
-#include "gpmc.h"
-
-#define PDC_NOR		1
-#define PDC_NAND	2
-#define PDC_ONENAND	3
-#define DBG_MPDB	4
-
-struct flash_partitions {
-	struct mtd_partition *parts;
-	int nr_parts;
-};
-
-#if defined(CONFIG_MTD_NAND_OMAP2) || \
-		defined(CONFIG_MTD_NAND_OMAP2_MODULE) || \
-		defined(CONFIG_MTD_ONENAND_OMAP2) || \
-		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
-extern void board_flash_init(struct flash_partitions [],
-				char chip_sel[][GPMC_CS_NUM], int nand_type);
-#else
-static inline void board_flash_init(struct flash_partitions part[],
-				char chip_sel[][GPMC_CS_NUM], int nand_type)
-{
-}
-#endif
-
-#if defined(CONFIG_MTD_NAND_OMAP2) || \
-		defined(CONFIG_MTD_NAND_OMAP2_MODULE)
-extern void board_nand_init(struct mtd_partition *nand_parts,
-		u8 nr_parts, u8 cs, int nand_type, struct gpmc_timings *gpmc_t);
-extern struct gpmc_timings nand_default_timings[];
-#else
-static inline void board_nand_init(struct mtd_partition *nand_parts,
-		u8 nr_parts, u8 cs, int nand_type, struct gpmc_timings *gpmc_t)
-{
-}
-#define	nand_default_timings	NULL
-#endif
-
-#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
-		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
-extern void board_onenand_init(struct mtd_partition *nand_parts,
-					u8 nr_parts, u8 cs);
-#else
-static inline void board_onenand_init(struct mtd_partition *nand_parts,
-					u8 nr_parts, u8 cs)
-{
-}
-#endif
-- 
1.9.0

