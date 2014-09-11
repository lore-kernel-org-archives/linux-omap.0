From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v3 1/3] nand: omap2: Add support for flash-based bad block table
Date: Thu, 11 Sep 2014 12:02:08 -0300
Message-ID: <1410447730-16087-2-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1410447730-16087-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:59751 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaIKPEX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 11:04:23 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so6468037qgf.20
        for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2014 08:04:19 -0700 (PDT)
In-Reply-To: <1410447730-16087-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

This commit adds a new platform-data boolean property that enables use
of a flash-based bad block table. This can also be enabled by setting
the 'nand-on-flash-bbt' devicetree property.

If the flash BBT is not enabled, the driver falls back to use OOB
bad block markers only, as before. If the flash BBT is enabled the
kernel will keep track of bad blocks using a BBT, in addition to
the OOB markers.

As explained by Brian Norris the reasons for using a BBT are:

""
The primary reason would be that NAND datasheets specify it these days.
A better argument is that nobody guarantees that you can write a
bad block marker to a worn out block; you may just get program failures.

This has been acknowledged by several developers over the last several
years.

Additionally, you get a boot-time performance improvement if you only
have to read a few pages, instead of a page or two from every block on
the flash.
""

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 arch/arm/mach-omap2/gpmc.c                   | 2 ++
 drivers/mtd/nand/omap2.c                     | 6 +++++-
 include/linux/platform_data/mtd-nand-omap2.h | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2f97228..b55a225 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1440,6 +1440,8 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 				break;
 			}
 
+	gpmc_nand_data->flash_bbt = of_get_nand_on_flash_bbt(child);
+
 	val = of_get_nand_bus_width(child);
 	if (val == 16)
 		gpmc_nand_data->devsize = NAND_BUSWIDTH_16;
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 5967b38..e1a9b31 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1663,7 +1663,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 	mtd->owner		= THIS_MODULE;
 	nand_chip		= &info->nand;
 	nand_chip->ecc.priv	= NULL;
-	nand_chip->options	|= NAND_SKIP_BBTSCAN;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	nand_chip->IO_ADDR_R = devm_ioremap_resource(&pdev->dev, res);
@@ -1692,6 +1691,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->chip_delay = 50;
 	}
 
+	if (pdata->flash_bbt)
+		nand_chip->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
+	else
+		nand_chip->options |= NAND_SKIP_BBTSCAN;
+
 	/* scan NAND device connected to chip controller */
 	nand_chip->options |= pdata->devsize & NAND_BUSWIDTH_16;
 	if (nand_scan_ident(mtd, 1, NULL)) {
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 16ec262..090bbab 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -71,6 +71,7 @@ struct omap_nand_platform_data {
 	struct mtd_partition	*parts;
 	int			nr_parts;
 	bool			dev_ready;
+	bool			flash_bbt;
 	enum nand_io		xfer_type;
 	int			devsize;
 	enum omap_ecc           ecc_opt;
-- 
2.1.0

