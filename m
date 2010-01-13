From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 1/3] OMAP: ZOOM: Introducing 'board-zoom-flash.c'
Date: Wed, 13 Jan 2010 12:32:03 +0530
Message-ID: <ce9ab5791001122302o31cec7dcj9b61278b776e27b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:49803 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab0AMHCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 02:02:24 -0500
Received: by bwz27 with SMTP id 27so1718594bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 23:02:23 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From c97a9126f713fa7577ea555a555dc9f22513c154 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 12 Jan 2010 17:26:07 +0530
Subject: [PATCH] OMAP: ZOOM: Introducing 'board-zoom-flash.c'

This patch adds 'board-zoom-flash.c', which could be utilized
by boards similar to ZOOM2. (For ex: LDP, ZOOM2, ZOOM3).

This does initialization for NAND device based on the 'cs' number
and partition information passed from board file (ex: board-zoom2.c).

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/board-zoom-flash.c        |   85 +++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/board-zoom.h |   11 +++
 2 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c

diff --git a/arch/arm/mach-omap2/board-zoom-flash.c
b/arch/arm/mach-omap2/board-zoom-flash.c
new file mode 100644
index 0000000..f2328a4
--- /dev/null
+++ b/arch/arm/mach-omap2/board-zoom-flash.c
@@ -0,0 +1,85 @@
+/*
+ * board-zoom-flash.c
+ *
+ * Copyright (C) 2009 Texas Instruments Inc.
+ * Vimal Singh <vimalsingh@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/nand.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#include <asm/mach/flash.h>
+#include <plat/board.h>
+#include <plat/gpmc.h>
+#include <plat/nand.h>
+
+#include <mach/board-zoom.h>
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
+/* NAND chip access: 16 bit */
+static struct omap_nand_platform_data zoom_nand_data = {
+	.nand_setup	= NULL,
+	.gpmc_t		= &nand_timings,
+	.dma_channel	= -1,	/* disable DMA in OMAP NAND driver */
+	.dev_ready	= NULL,
+	.devsize	= 1,	/* '0' for 8-bit, '1' for 16-bit device */
+};
+
+/**
+ * zoom_flash_init - Identify devices connected to GPMC and register.
+ *
+ * @return - void.
+ */
+void __init zoom_flash_init(struct flash_partitions zoom_nand_parts[], int cs)
+{
+	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
+
+	zoom_nand_data.cs		= cs;
+	zoom_nand_data.parts		= zoom_nand_parts[0].parts;
+	zoom_nand_data.nr_parts		= zoom_nand_parts[0].nr_parts;
+	zoom_nand_data.gpmc_baseaddr	= (void *)(gpmc_base_add);
+	zoom_nand_data.gpmc_cs_baseaddr	= (void *)(gpmc_base_add +
+						GPMC_CS0_BASE +
+						cs * GPMC_CS_SIZE);
+	gpmc_nand_init(&zoom_nand_data);
+}
+#else
+void __init zoom_flash_init(struct flash_partitions zoom_nand_parts[], int cs)
+{
+}
+#endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
+
diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h
b/arch/arm/mach-omap2/include/mach/board-zoom.h
index c93b29e..f4469d3 100644
--- a/arch/arm/mach-omap2/include/mach/board-zoom.h
+++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
@@ -1,5 +1,16 @@
 /*
  * Defines for zoom boards
  */
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+struct flash_partitions {
+	struct mtd_partition *parts;
+	int nr_parts;
+};
+
+#define ZOOM_NAND_CS	0
+
+extern void __init zoom_flash_init(struct flash_partitions [], int);
 extern int __init zoom_debugboard_init(void);
 extern void __init zoom_peripherals_init(void);
-- 
1.5.5
