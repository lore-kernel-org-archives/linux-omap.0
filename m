From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] mtd: make onenand/generic.c more generic
Date: Tue, 04 Aug 2009 18:20:46 +0900
Message-ID: <20090804092046.16025.83910.sendpatchset@rx1.opensource.se>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f201.google.com ([209.85.216.201]:44465 "EHLO
	mail-px0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbZHDJY5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 05:24:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org, tony@atomide.com, kyungmin.park@samsung.com, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-omap@vger.kernel.org, dwmw2@infradead.org, akpm@linux-foundation.org

From: Magnus Damm <damm@igel.co.jp>

This patch removes the ARM dependency from the generic "onenand"
platform device driver. This change makes the driver useful for
other architectures as well. Needed for the SuperH kfr2r09 board.

Apart from the obvious Kconfig bits, the most important change
is the move away from ARM specific includes and platform data.
Together with this change the only in-tree board code gets an
update, and the driver name is also changed gracefully break
potential out of tree drivers.

The driver is also updated to allow NULL as platform data together
with a few changes to make use of resource_size() and dev_name().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on the sh7724 kfr2r09 board with a separate platform data patch.

 arch/arm/mach-omap2/board-apollon.c |    4 ++--
 drivers/mtd/onenand/Kconfig         |    1 -
 drivers/mtd/onenand/generic.c       |   24 ++++++++++++++----------
 include/linux/mtd/onenand.h         |    8 ++++++++
 4 files changed, 24 insertions(+), 13 deletions(-)

--- 0001/arch/arm/mach-omap2/board-apollon.c
+++ work/arch/arm/mach-omap2/board-apollon.c	2009-08-04 17:01:18.000000000 +0900
@@ -87,7 +87,7 @@ static struct mtd_partition apollon_part
 	},
 };
 
-static struct flash_platform_data apollon_flash_data = {
+static struct onenand_platform_data apollon_flash_data = {
 	.parts		= apollon_partitions,
 	.nr_parts	= ARRAY_SIZE(apollon_partitions),
 };
@@ -99,7 +99,7 @@ static struct resource apollon_flash_res
 };
 
 static struct platform_device apollon_onenand_device = {
-	.name		= "onenand",
+	.name		= "onenand-flash",
 	.id		= -1,
 	.dev		= {
 		.platform_data	= &apollon_flash_data,
--- 0001/drivers/mtd/onenand/Kconfig
+++ work/drivers/mtd/onenand/Kconfig	2009-08-04 17:01:18.000000000 +0900
@@ -23,7 +23,6 @@ config MTD_ONENAND_VERIFY_WRITE
 
 config MTD_ONENAND_GENERIC
 	tristate "OneNAND Flash device via platform device driver"
-	depends on ARM
 	help
 	  Support for OneNAND flash via platform device driver.
 
--- 0001/drivers/mtd/onenand/generic.c
+++ work/drivers/mtd/onenand/generic.c	2009-08-04 17:12:00.000000000 +0900
@@ -19,12 +19,16 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
-
 #include <asm/io.h>
-#include <asm/mach/flash.h>
-
-#define DRIVER_NAME	"onenand"
 
+/*
+ * Note: Driver name and platform data format have been updated!
+ *
+ * This version of the driver is named "onenand-flash" and takes struct
+ * onenand_platform_data as platform data. The old ARM-specific version
+ * with the name "onenand" used to take struct flash_platform_data.
+ */
+#define DRIVER_NAME	"onenand-flash"
 
 #ifdef CONFIG_MTD_PARTITIONS
 static const char *part_probes[] = { "cmdlinepart", NULL,  };
@@ -39,16 +43,16 @@ struct onenand_info {
 static int __devinit generic_onenand_probe(struct platform_device *pdev)
 {
 	struct onenand_info *info;
-	struct flash_platform_data *pdata = pdev->dev.platform_data;
+	struct onenand_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *res = pdev->resource;
-	unsigned long size = res->end - res->start + 1;
+	unsigned long size = resource_size(res);
 	int err;
 
 	info = kzalloc(sizeof(struct onenand_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	if (!request_mem_region(res->start, size, pdev->dev.driver->name)) {
+	if (!request_mem_region(res->start, size, dev_name(&pdev->dev))) {
 		err = -EBUSY;
 		goto out_free_info;
 	}
@@ -59,7 +63,7 @@ static int __devinit generic_onenand_pro
 		goto out_release_mem_region;
 	}
 
-	info->onenand.mmcontrol = pdata->mmcontrol;
+	info->onenand.mmcontrol = pdata ? pdata->mmcontrol : 0;
 	info->onenand.irq = platform_get_irq(pdev, 0);
 
 	info->mtd.name = dev_name(&pdev->dev);
@@ -75,7 +79,7 @@ static int __devinit generic_onenand_pro
 	err = parse_mtd_partitions(&info->mtd, part_probes, &info->parts, 0);
 	if (err > 0)
 		add_mtd_partitions(&info->mtd, info->parts, err);
-	else if (err <= 0 && pdata->parts)
+	else if (err <= 0 && pdata && pdata->parts)
 		add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
 	else
 #endif
@@ -99,7 +103,7 @@ static int __devexit generic_onenand_rem
 {
 	struct onenand_info *info = platform_get_drvdata(pdev);
 	struct resource *res = pdev->resource;
-	unsigned long size = res->end - res->start + 1;
+	unsigned long size = resource_size(res);
 
 	platform_set_drvdata(pdev, NULL);
 
--- 0001/include/linux/mtd/onenand.h
+++ work/include/linux/mtd/onenand.h	2009-08-04 17:01:18.000000000 +0900
@@ -214,4 +214,12 @@ unsigned onenand_block(struct onenand_ch
 loff_t onenand_addr(struct onenand_chip *this, int block);
 int flexonenand_region(struct mtd_info *mtd, loff_t addr);
 
+struct mtd_partition;
+
+struct onenand_platform_data {
+	void		(*mmcontrol)(struct mtd_info *mtd, int sync_read);
+	struct mtd_partition *parts;
+	unsigned int	nr_parts;
+};
+
 #endif	/* __LINUX_MTD_ONENAND_H */
