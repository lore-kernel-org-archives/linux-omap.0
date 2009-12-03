From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 2/2]: Introducing 'gpmc-nand.c' for GPMC specific NAND init
Date: Thu, 3 Dec 2009 19:36:43 +0530
Message-ID: <ce9ab5790912030606u38ff19bdy536c1931a5fb63f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43094 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbZLCOG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 09:06:57 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so1103965bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 06:07:03 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Linux MTD <linux-mtd@lists.infradead.org>

>From fadc45cca4026d26d00a759efdc681303b0d3097 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Wed, 25 Nov 2009 18:23:15 +0530
Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NAND init

Introducing 'gpmc-nand.c' for GPMC specific NAND init.
For example: GPMC timing parameters and all.
This patch also migrates gpmc related calls from 'nand/omap2.c'
to 'gpmc-nand.c'.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/Makefile           |    3 +
 arch/arm/mach-omap2/gpmc-nand.c        |  141 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/nand.h |    6 ++
 drivers/mtd/nand/omap2.c               |   26 +-----
 4 files changed, 153 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpmc-nand.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 59b0ccc..0dfe27a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -103,5 +103,8 @@ obj-y					+= usb-ehci.o
 onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
 obj-y					+= $(onenand-m) $(onenand-y)

+nand-$(CONFIG_MTD_NAND_OMAP2)		:= gpmc-nand.o
+obj-y					+= $(nand-m) $(nand-y)
+
 smc91x-$(CONFIG_SMC91X)			:= gpmc-smc91x.o
 obj-y					+= $(smc91x-m) $(smc91x-y)
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
new file mode 100644
index 0000000..d92abdf
--- /dev/null
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -0,0 +1,141 @@
+/*
+ * gpmc-nand.c
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Vimal Singh <vimalsingh@ti.com>
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
+int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
+{
+	unsigned int val;
+	int err	= 0;
+	struct device *dev = &gpmc_nand_device.dev;
+
+	gpmc_nand_data = _nand_data;
+	gpmc_nand_data->nand_setup = gpmc_nand_setup;
+	gpmc_nand_device.dev.platform_data = gpmc_nand_data;
+
+	err = gpmc_nand_setup((void __iomem *)&gpmc_nand_data->start);
+	if (err < 0) {
+		dev_err(dev, "NAND platform setup failed: %d\n", err);
+		return err;
+	}
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
+	err = platform_device_register(&gpmc_nand_device);
+	if (err < 0) {
+		dev_err(dev, "Unable to register NAND device\n");
+		return err;
+	}
+
+	return 0;
+}
diff --git a/arch/arm/plat-omap/include/plat/nand.h
b/arch/arm/plat-omap/include/plat/nand.h
index 631a7be..2ba9842 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -21,4 +21,10 @@ struct omap_nand_platform_data {
 	int			dma_channel;
 	void __iomem		*gpmc_cs_baseaddr;
 	void __iomem		*gpmc_baseaddr;
+	int			devsize;
 };
+
+/* size (4 KiB) for IO mapping */
+#define	NAND_IO_SIZE	SZ_4K
+
+extern int gpmc_nand_init(struct omap_nand_platform_data *d);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 1bb799f..aaef170 100644
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
@@ -882,8 +878,6 @@ static int __devinit omap_nand_probe(struct
platform_device *pdev)
 	struct omap_nand_info		*info;
 	struct omap_nand_platform_data	*pdata;
 	int				err;
-	unsigned long 			val;
-

 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -910,24 +904,15 @@ static int __devinit omap_nand_probe(struct
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
-	}
-
-	val  = gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG7);
-	val &= ~(0xf << 8);
-	val |=  (0xc & 0xf) << 8;
-	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG7, val);
-
 	/* NAND write protect off */
 	omap_nand_wp(&info->mtd, NAND_WP_OFF);

@@ -963,11 +948,6 @@ static int __devinit omap_nand_probe(struct
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
