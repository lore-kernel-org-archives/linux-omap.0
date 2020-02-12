From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 02/14] mtd: rawnand: ams-delta: Use struct gpio_nand_platdata
Date: Wed, 12 Feb 2020 01:39:17 +0100
Message-ID: <20200212003929.6682-3-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33324 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgBLAkQ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so292262lji.0
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:15 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

In order to be able to move the hardcoded Amstrad Delta partition info
from the driver code to the board file, reuse gpio_nand_platdata
structure owned by "gpio-nand" driver and try to obtain information
on device partitions from device platform data.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 2501cfe00f43..fbab7cc14607 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/nand-gpio.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/platform_device.h>
@@ -220,12 +221,20 @@ static const struct nand_controller_ops ams_delta_ops = {
  */
 static int ams_delta_init(struct platform_device *pdev)
 {
+	struct gpio_nand_platdata *pdata = dev_get_platdata(&pdev->dev);
+	const struct mtd_partition *partitions = partition_info;
+	int num_partitions = ARRAY_SIZE(partition_info);
 	struct ams_delta_nand *priv;
 	struct nand_chip *this;
 	struct mtd_info *mtd;
 	struct gpio_descs *data_gpiods;
 	int err = 0;
 
+	if (pdata) {
+		partitions = pdata->parts;
+		num_partitions = pdata->num_parts;
+	}
+
 	/* Allocate memory for MTD device structure and private data */
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct ams_delta_nand),
 			    GFP_KERNEL);
@@ -326,8 +335,7 @@ static int ams_delta_init(struct platform_device *pdev)
 		return err;
 
 	/* Register the partitions */
-	err = mtd_device_register(mtd, partition_info,
-				  ARRAY_SIZE(partition_info));
+	err = mtd_device_register(mtd, partitions, num_partitions);
 	if (err)
 		goto err_nand_cleanup;
 
-- 
2.24.1
