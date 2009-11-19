From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH-v6 1/4] OMAP2/3: Add support for flash on SDP boards
Date: Thu, 19 Nov 2009 19:46:38 +0530
Message-ID: <ce9ab5790911190616j666c7687s7b26693cff863b95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:50037 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbZKSOXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 09:23:35 -0500
Received: by fxm21 with SMTP id 21so2453536fxm.21
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 06:23:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>
Cc: Tony Lindgren <tony@atomide.com>, vimal singh <vimalsingh@ti.com>

>From ac109bb5f47577b323673699a94f9b6a4a7e2431 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Thu, 19 Nov 2009 19:01:11 +0530
Subject: [PATCH] OMAP2/3: Add support for flash on SDP boards

Add support for flash on SDP boards. NAND, NOR and OneNAND
are supported.

This patch also implements Tony's comments on:
http://marc.info/?l=linux-omap&m=125787938923028&w=2

This is done by creating 'mach-omap2/gpmc-nand.c' file, to handle
GPMC related setups for the device driver.

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
 arch/arm/mach-omap2/Makefile                |    5 +
 arch/arm/mach-omap2/board-2430sdp.c         |    2 +
 arch/arm/mach-omap2/board-3430sdp.c         |    2 +
 arch/arm/mach-omap2/board-sdp-flash.c       |  315 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc-nand.c             |  128 +++++++++++
 arch/arm/plat-omap/include/plat/board-sdp.h |   15 ++
 arch/arm/plat-omap/include/plat/gpmc.h      |    4 +-
 arch/arm/plat-omap/include/plat/nand.h      |    6 +
 drivers/mtd/nand/omap2.c                    |   33 +--
 9 files changed, 488 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
 create mode 100644 arch/arm/plat-omap/include/plat/board-sdp.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 59b0ccc..b0e5b46 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
+					   board-sdp-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
@@ -69,6 +70,7 @@ obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
+					   board-sdp-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
@@ -105,3 +107,6 @@ obj-y					+= $(onenand-m) $(onenand-y)

 smc91x-$(CONFIG_SMC91X)			:= gpmc-smc91x.o
 obj-y					+= $(smc91x-m) $(smc91x-y)
+
+nand-$(CONFIG_MTD_NAND_OMAP2)		:= gpmc-nand.o
+obj-y					+= $(nand-m) $(nand-y)
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
index 491364e..f2ed1ab 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -41,6 +41,7 @@
 #include <plat/control.h>
 #include <plat/gpmc-smc91x.h>

+#include <plat/board-sdp.h>
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"

@@ -521,6 +522,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	board_smc91x_init();
+	sdp_flash_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
 }
diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
b/arch/arm/mach-omap2/board-sdp-flash.c
new file mode 100644
index 0000000..e5fc309
--- /dev/null
+++ b/arch/arm/mach-omap2/board-sdp-flash.c
@@ -0,0 +1,315 @@
+/*
+ * board-sdp-flash.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2009 Texas Instruments
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
+#include <plat/gpmc.h>
+#include <plat/nand.h>
+#include <plat/board-sdp.h>
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
+	.devsize	= 0,	/* '0' for 8-bit, '1' for 16-bit device */
+};
+
+static void __init board_nand_init(u8 cs)
+{
+	sdp_nand_data.cs = cs;
+	sdp_nand_data.gpmc_cs_baseaddr = (void *)(OMAP34XX_GPMC_VIRT +
+					GPMC_CS0_BASE + cs * GPMC_CS_SIZE);
+	sdp_nand_data.gpmc_baseaddr = (void *) (OMAP34XX_GPMC_VIRT);
+
+	gpmc_nand_init(&sdp_nand_data);
+}
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
+void __init sdp_flash_init(void)
+{
+	u8		cs = 0;
+	u8		nandcs = GPMC_CS_NUM + 1;
+	u8		onenandcs = GPMC_CS_NUM + 1;
+	u8		idx;
+	unsigned char	*config_sel = NULL;
+	int		err;
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
+			/* Configure start address and size of NOR device */
+			if (omap_rev() >= OMAP3430_REV_ES1_0) {
+				err = gpmc_cs_request(cs, FLASH_SIZE_SDPV2 - 1,
+				(unsigned long *)&sdp_nor_resource.start);
+				sdp_nor_resource.end = sdp_nor_resource.start
+							+ FLASH_SIZE_SDPV2 - 1;
+			} else {
+				err = gpmc_cs_request(cs, FLASH_SIZE_SDPV1 - 1,
+				(unsigned long *)&sdp_nor_resource.start);
+				sdp_nor_resource.end = sdp_nor_resource.start
+							+ FLASH_SIZE_SDPV1 - 1;
+			}
+			if (err < 0) {
+				printk(KERN_ERR "NOR: Can't request GPMC CS\n");
+				break;
+			}
+			if (platform_device_register(&sdp_nor_device) < 0)
+				printk(KERN_ERR
+					"Unable to register NOR device\n");
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
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
new file mode 100644
index 0000000..a6bee9c
--- /dev/null
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -0,0 +1,128 @@
+/*
+ * gpmc-nand.c
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Contacts: Vimal Singh <vimalsingh@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <asm/mach/flash.h>
+
+#include <plat/nand.h>
+#include <plat/board.h>
+#include <plat/gpmc.h>
+
+#define WR_RD_PIN_MONITORING	0x00600000
+
+static struct omap_nand_platform_data *gpmc_nand_data;
+
+static struct resource gpmc_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device gpmc_nand_device = {
+	.name		= "omap2-nand",
+	.id		= 0,
+	.num_resources	= 1,
+	.resource	= &gpmc_nand_resource,
+};
+
+static int omap2_nand_gpmc_config(int cs, void __iomem *nand_base)
+{
+	struct gpmc_timings t;
+	int err;
+
+	const int cs_rd_off = 36;
+	const int cs_wr_off = 36;
+	const int adv_on = 6;
+	const int adv_rd_off = 24;
+	const int adv_wr_off = 36;
+	const int oe_off = 48;
+	const int we_off = 30;
+	const int rd_cycle = 72;
+	const int wr_cycle = 72;
+	const int access = 54;
+	const int wr_data_mux_bus = 8;
+	const int wr_access = 30;
+
+	memset(&t, 0, sizeof(t));
+	t.sync_clk = 0;
+	t.cs_on = 0;
+	t.adv_on = gpmc_round_ns_to_ticks(adv_on);
+
+	/* Read */
+	t.adv_rd_off = gpmc_round_ns_to_ticks(adv_rd_off);
+	t.oe_on  = t.adv_on;
+	t.access = gpmc_round_ns_to_ticks(access);
+	t.oe_off = gpmc_round_ns_to_ticks(oe_off);
+	t.cs_rd_off = gpmc_round_ns_to_ticks(cs_rd_off);
+	t.rd_cycle  = gpmc_round_ns_to_ticks(rd_cycle);
+
+	/* Write */
+	t.adv_wr_off = gpmc_round_ns_to_ticks(adv_wr_off);
+	t.we_on  = t.oe_on;
+	if (cpu_is_omap34xx()) {
+		t.wr_data_mux_bus = gpmc_round_ns_to_ticks(wr_data_mux_bus);
+		t.wr_access = gpmc_round_ns_to_ticks(wr_access);
+	}
+	t.we_off = gpmc_round_ns_to_ticks(we_off);
+	t.cs_wr_off = gpmc_round_ns_to_ticks(cs_wr_off);
+	t.wr_cycle  = gpmc_round_ns_to_ticks(wr_cycle);
+
+	/* Configure GPMC */
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
+			GPMC_CONFIG1_DEVICESIZE(gpmc_nand_data->devsize) |
+			GPMC_CONFIG1_DEVICETYPE_NAND);
+
+	err = gpmc_cs_set_timings(cs, &t);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int gpmc_nand_setup(void __iomem *nand_base)
+{
+	struct device *dev = &gpmc_nand_device.dev;
+
+	/* Set timings in GPMC */
+	if (omap2_nand_gpmc_config(gpmc_nand_data->cs, nand_base) < 0) {
+		dev_err(dev, "Unable to set gpmc timings\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
+{
+	unsigned int	val;
+
+	gpmc_nand_data = _nand_data;
+	gpmc_nand_data->nand_setup = gpmc_nand_setup;
+	gpmc_nand_device.dev.platform_data = gpmc_nand_data;
+
+	/* Enable RD PIN Monitoring Reg */
+	if (gpmc_nand_data->dev_ready) {
+		val  = gpmc_cs_read_reg(gpmc_nand_data->cs,
+						 GPMC_CS_CONFIG1);
+		val |= WR_RD_PIN_MONITORING;
+		gpmc_cs_write_reg(gpmc_nand_data->cs,
+						GPMC_CS_CONFIG1, val);
+	}
+
+	val  = gpmc_cs_read_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG7);
+	val &= ~(0xf << 8);
+	val |=  (0xc & 0xf) << 8;
+	gpmc_cs_write_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG7, val);
+
+	if (platform_device_register(&gpmc_nand_device) < 0)
+		printk(KERN_ERR "Unable to register NAND device\n");
+}
diff --git a/arch/arm/plat-omap/include/plat/board-sdp.h
b/arch/arm/plat-omap/include/plat/board-sdp.h
new file mode 100644
index 0000000..a37dc7c
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/board-sdp.h
@@ -0,0 +1,15 @@
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
+
+extern void sdp_flash_init(void);
+
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h
b/arch/arm/plat-omap/include/plat/gpmc.h
index 696e0ca..4090749 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -27,6 +27,8 @@

 #define GPMC_CONFIG		0x50
 #define GPMC_STATUS		0x54
+#define GPMC_CS0_BASE		0x60
+#define GPMC_CS_SIZE		0x30

 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
@@ -45,7 +47,7 @@
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
 #define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
 #define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
-#define GPMC_CONFIG1_DEVICETYPE_NAND    GPMC_CONFIG1_DEVICETYPE(1)
+#define GPMC_CONFIG1_DEVICETYPE_NAND    GPMC_CONFIG1_DEVICETYPE(2)
 #define GPMC_CONFIG1_MUXADDDATA         (1 << 9)
 #define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
 #define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
diff --git a/arch/arm/plat-omap/include/plat/nand.h
b/arch/arm/plat-omap/include/plat/nand.h
index 631a7be..164630b 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -21,4 +21,10 @@ struct omap_nand_platform_data {
 	int			dma_channel;
 	void __iomem		*gpmc_cs_baseaddr;
 	void __iomem		*gpmc_baseaddr;
+	int			devsize;
 };
+
+extern void gpmc_nand_init(struct omap_nand_platform_data *d);
+
+/* size (4 KiB) for IO mapping */
+#define	NAND_IO_SIZE	SZ_4K
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 1bb799f..41ffb19 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -30,12 +30,8 @@

 #define	DRIVER_NAME	"omap2-nand"

-/* size (4 KiB) for IO mapping */
-#define	NAND_IO_SIZE	SZ_4K
-
 #define	NAND_WP_OFF	0
 #define NAND_WP_BIT	0x00000010
-#define WR_RD_PIN_MONITORING	0x00600000

 #define	GPMC_BUF_FULL	0x00000001
 #define	GPMC_BUF_EMPTY	0x00000000
@@ -139,6 +135,7 @@ struct omap_nand_info {
 	struct mtd_partition		*parts;
 	struct nand_chip		nand;
 	struct platform_device		*pdev;
+	int				(*setup)(void __iomem *base);

 	int				gpmc_cs;
 	unsigned long			phys_base;
@@ -882,8 +879,6 @@ static int __devinit omap_nand_probe(struct
platform_device *pdev)
 	struct omap_nand_info		*info;
 	struct omap_nand_platform_data	*pdata;
 	int				err;
-	unsigned long 			val;
-

 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -910,24 +905,25 @@ static int __devinit omap_nand_probe(struct
platform_device *pdev)
 	info->mtd.name		= dev_name(&pdev->dev);
 	info->mtd.owner		= THIS_MODULE;

+	info->nand.options	|= pdata->devsize ? NAND_BUSWIDTH_16 : 0;
+	info->nand.options	|= NAND_SKIP_BBTSCAN;
+
 	err = gpmc_cs_request(info->gpmc_cs, NAND_IO_SIZE, &info->phys_base);
 	if (err < 0) {
 		dev_err(&pdev->dev, "Cannot request GPMC CS\n");
 		goto out_free_info;
 	}

-	/* Enable RD PIN Monitoring Reg */
-	if (pdata->dev_ready) {
-		val  = gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG1);
-		val |= WR_RD_PIN_MONITORING;
-		gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG1, val);
+	if (pdata->nand_setup != NULL) {
+		err = pdata->nand_setup((void __iomem *)info->phys_base);
+		if (err < 0) {
+			dev_err(&pdev->dev, "NAND platform setup failed: "
+				"%d\n", err);
+			goto out_free_cs;
+		}
+		info->setup = pdata->nand_setup;
 	}

-	val  = gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG7);
-	val &= ~(0xf << 8);
-	val |=  (0xc & 0xf) << 8;
-	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG7, val);
-
 	/* NAND write protect off */
 	omap_nand_wp(&info->mtd, NAND_WP_OFF);

@@ -963,11 +959,6 @@ static int __devinit omap_nand_probe(struct
platform_device *pdev)
 		info->nand.chip_delay = 50;
 	}

-	info->nand.options  |= NAND_SKIP_BBTSCAN;
-	if ((gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG1) & 0x3000)
-								== 0x1000)
-		info->nand.options  |= NAND_BUSWIDTH_16;
-
 	if (use_prefetch) {
 		/* copy the virtual address of nand base for fifo access */
 		info->nand_pref_fifo_add = info->nand.IO_ADDR_R;
-- 
1.5.5
