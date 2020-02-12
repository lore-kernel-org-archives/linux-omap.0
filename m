From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 04/14 v4] mtd: rawnand: ams-delta: Drop board specific partition info
Date: Wed, 12 Feb 2020 01:39:19 +0100
Message-ID: <20200212003929.6682-5-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38328 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgBLAkU (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so267927ljh.5
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:18 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

Now as we support fetching partition info from device platform data and
the Amstrad Delta board file provides that info, drop it from the
driver code.

v2: rebase on top of gpio_nand_platdata extension

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v4: rebase on top of gpio_nand_platdata driver/board extensions,
  - drop no longer required command line parser related bits,
  - adjust commit description,
  - move OF fix to a separate patch.
v3: add information on the requirement for passing partition info via
    kernel command line to the board Kconfig entry help text.
v2: fix a typo poitned out by Aaro - thanks!,
  - fix device_node not passed to OF parser via mtd_info,
  - commit message reworded and reformatted a bit for better
    readability.

 drivers/mtd/nand/raw/ams-delta.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index fbab7cc14607..25f121adea6f 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -42,31 +42,6 @@ struct ams_delta_nand {
 	bool			data_in;
 };
 
-/*
- * Define partitions for flash devices
- */
-
-static const struct mtd_partition partition_info[] = {
-	{ .name		= "Kernel",
-	  .offset	= 0,
-	  .size		= 3 * SZ_1M + SZ_512K },
-	{ .name		= "u-boot",
-	  .offset	= 3 * SZ_1M + SZ_512K,
-	  .size		= SZ_256K },
-	{ .name		= "u-boot params",
-	  .offset	= 3 * SZ_1M + SZ_512K + SZ_256K,
-	  .size		= SZ_256K },
-	{ .name		= "Amstrad LDR",
-	  .offset	= 4 * SZ_1M,
-	  .size		= SZ_256K },
-	{ .name		= "File system",
-	  .offset	= 4 * SZ_1M + 1 * SZ_256K,
-	  .size		= 27 * SZ_1M },
-	{ .name		= "PBL reserved",
-	  .offset	= 32 * SZ_1M - 3 * SZ_256K,
-	  .size		=  3 * SZ_256K },
-};
-
 static void ams_delta_write_commit(struct ams_delta_nand *priv)
 {
 	gpiod_set_value(priv->gpiod_nwe, 0);
@@ -222,8 +197,8 @@ static const struct nand_controller_ops ams_delta_ops = {
 static int ams_delta_init(struct platform_device *pdev)
 {
 	struct gpio_nand_platdata *pdata = dev_get_platdata(&pdev->dev);
-	const struct mtd_partition *partitions = partition_info;
-	int num_partitions = ARRAY_SIZE(partition_info);
+	const struct mtd_partition *partitions = NULL;
+	int num_partitions = 0;
 	struct ams_delta_nand *priv;
 	struct nand_chip *this;
 	struct mtd_info *mtd;
-- 
2.24.1
