From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 1/3] Introducing 'gpmc-nand.c' for GPMC specific NAND init
Date: Wed, 13 Jan 2010 12:20:25 +0530
Message-ID: <ce9ab5791001122250m5daa723y6f084c83ce25fb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47405 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab0AMGur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 01:50:47 -0500
Received: by bwz27 with SMTP id 27so1715669bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 22:50:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Linux MTD <linux-mtd@lists.infradead.org>

>From 89eaa5d55e04f65e76ad49ed8b010cba578d91ca Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Mon, 11 Jan 2010 16:01:29 +0530
Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NAND init

Introducing 'gpmc-nand.c' for GPMC specific NAND init.
For example: GPMC timing parameters and all.
This patch also migrates gpmc related calls from 'nand/omap2.c'
to 'gpmc-nand.c'.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/Makefile           |    3 +
 arch/arm/mach-omap2/gpmc-nand.c        |  139 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/nand.h |    8 ++
 drivers/mtd/nand/omap2.c               |   35 +-------
 4 files changed, 154 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpmc-nand.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b32678b..247438b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -119,5 +119,8 @@ obj-y					+= usb-ehci.o
 onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
 obj-y					+= $(onenand-m) $(onenand-y)

+nand-$(CONFIG_MTD_NAND_OMAP2)		:= gpmc-nand.o
+obj-y					+= $(nand-m) $(nand-y)
+
 smc91x-$(CONFIG_SMC91X)			:= gpmc-smc91x.o
 obj-y					+= $(smc91x-m) $(smc91x-y)
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
new file mode 100644
index 0000000..e3765f2
--- /dev/null
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -0,0 +1,139 @@
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
+static int omap2_nand_gpmc_config(void __iomem *nand_base)
+{
+	struct gpmc_timings t;
+	int err;
+
+	memset(&t, 0, sizeof(t));
+	t.sync_clk = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->sync_clk);
+	t.cs_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_on);
+	t.adv_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->adv_on);
+
+	/* Read */
+	t.adv_rd_off = gpmc_round_ns_to_ticks(
+				gpmc_nand_data->gpmc_t->adv_rd_off);
+	t.oe_on  = t.adv_on;
+	t.access = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->access);
+	t.oe_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->oe_off);
+	t.cs_rd_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_rd_off);
+	t.rd_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->rd_cycle);
+
+	/* Write */
+	t.adv_wr_off = gpmc_round_ns_to_ticks(
+				gpmc_nand_data->gpmc_t->adv_wr_off);
+	t.we_on  = t.oe_on;
+	if (cpu_is_omap34xx()) {
+	    t.wr_data_mux_bus =	gpmc_round_ns_to_ticks(
+				gpmc_nand_data->gpmc_t->wr_data_mux_bus);
+	    t.wr_access = gpmc_round_ns_to_ticks(
+				gpmc_nand_data->gpmc_t->wr_access);
+	}
+	t.we_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->we_off);
+	t.cs_wr_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_wr_off);
+	t.wr_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->wr_cycle);
+
+	/* Configure GPMC */
+	gpmc_cs_write_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG1,
+			GPMC_CONFIG1_DEVICESIZE(gpmc_nand_data->devsize) |
+			GPMC_CONFIG1_DEVICETYPE_NAND);
+
+	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
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
+	if (omap2_nand_gpmc_config(nand_base) < 0) {
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
+	err = gpmc_nand_setup(gpmc_nand_data->gpmc_cs_baseaddr);
+	if (err < 0) {
+		dev_err(dev, "NAND platform setup failed: %d\n", err);
+		return err;
+	}
+
+	err = gpmc_cs_request(gpmc_nand_data->cs, NAND_IO_SIZE,
+				&gpmc_nand_data->phys_base);
+	if (err < 0) {
+		dev_err(dev, "Cannot request GPMC CS\n");
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
+	err = platform_device_register(&gpmc_nand_device);
+	if (err < 0) {
+		dev_err(dev, "Unable to register NAND device\n");
+		goto out_free_cs;
+	}
+
+	return 0;
+
+out_free_cs:
+	gpmc_cs_free(gpmc_nand_data->cs);
+
+	return err;
+}
diff --git a/arch/arm/plat-omap/include/plat/nand.h
b/arch/arm/plat-omap/include/plat/nand.h
index 631a7be..38695ed 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -15,10 +15,18 @@ struct omap_nand_platform_data {
 	int			cs;
 	int			gpio_irq;
 	struct mtd_partition	*parts;
+	struct gpmc_timings	*gpmc_t;
 	int			nr_parts;
 	int			(*nand_setup)(void __iomem *);
 	int			(*dev_ready)(struct omap_nand_platform_data *);
 	int			dma_channel;
+	unsigned long		phys_base;
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
index 7df303a..ad07d39 100644
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
@@ -885,8 +881,6 @@ static int __devinit omap_nand_probe(struct
 	struct omap_nand_info		*info;
 	struct omap_nand_platform_data	*pdata;
 	int				err;
-	unsigned long 			val;
-

 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -908,28 +902,14 @@ static int __devinit omap_nand_probe(struct
 	info->gpmc_cs		= pdata->cs;
 	info->gpmc_baseaddr	= pdata->gpmc_baseaddr;
 	info->gpmc_cs_baseaddr	= pdata->gpmc_cs_baseaddr;
+	info->phys_base		= pdata->phys_base;

 	info->mtd.priv		= &info->nand;
 	info->mtd.name		= dev_name(&pdev->dev);
 	info->mtd.owner		= THIS_MODULE;

-	err = gpmc_cs_request(info->gpmc_cs, NAND_IO_SIZE, &info->phys_base);
-	if (err < 0) {
-		dev_err(&pdev->dev, "Cannot request GPMC CS\n");
-		goto out_free_info;
-	}
-
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
+	info->nand.options	|= pdata->devsize ? NAND_BUSWIDTH_16 : 0;
+	info->nand.options	|= NAND_SKIP_BBTSCAN;

 	/* NAND write protect off */
 	omap_nand_wp(&info->mtd, NAND_WP_OFF);
@@ -937,7 +917,7 @@ static int __devinit omap_nand_probe(struct
 	if (!request_mem_region(info->phys_base, NAND_IO_SIZE,
 				pdev->dev.driver->name)) {
 		err = -EBUSY;
-		goto out_free_cs;
+		goto out_free_info;
 	}

 	info->nand.IO_ADDR_R = ioremap(info->phys_base, NAND_IO_SIZE);
@@ -966,11 +946,6 @@ static int __devinit omap_nand_probe(struct
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
@@ -1046,8 +1021,6 @@ static int __devinit omap_nand_probe(struct

 out_release_mem_region:
 	release_mem_region(info->phys_base, NAND_IO_SIZE);
-out_free_cs:
-	gpmc_cs_free(info->gpmc_cs);
 out_free_info:
 	kfree(info);

-- 
1.5.5
