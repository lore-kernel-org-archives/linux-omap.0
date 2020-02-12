From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 03/14] ARM: OMAP1: ams-delta: Provide board specific partition info
Date: Wed, 12 Feb 2020 01:39:18 +0100
Message-ID: <20200212003929.6682-4-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33819 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgBLAkS (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so285899ljc.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:17 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

Now as the Amstrad Delta NAND driver supports fetching information on
MTD partitions from device platform data, add partition info to the
NAND device configuration.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index a2aa7a12b374..f4d2ef97099e 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -17,6 +17,8 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/leds.h>
+#include <linux/mtd/nand-gpio.h>
+#include <linux/mtd/partitions.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/fixed.h>
@@ -294,9 +296,42 @@ struct modem_private_data {
 
 static struct modem_private_data modem_priv;
 
+/*
+ * Define partitions for flash device
+ */
+
+static struct mtd_partition partition_info[] = {
+	{ .name		= "Kernel",
+	  .offset	= 0,
+	  .size		= 3 * SZ_1M + SZ_512K },
+	{ .name		= "u-boot",
+	  .offset	= 3 * SZ_1M + SZ_512K,
+	  .size		= SZ_256K },
+	{ .name		= "u-boot params",
+	  .offset	= 3 * SZ_1M + SZ_512K + SZ_256K,
+	  .size		= SZ_256K },
+	{ .name		= "Amstrad LDR",
+	  .offset	= 4 * SZ_1M,
+	  .size		= SZ_256K },
+	{ .name		= "File system",
+	  .offset	= 4 * SZ_1M + 1 * SZ_256K,
+	  .size		= 27 * SZ_1M },
+	{ .name		= "PBL reserved",
+	  .offset	= 32 * SZ_1M - 3 * SZ_256K,
+	  .size		=  3 * SZ_256K },
+};
+
+static struct gpio_nand_platdata nand_platdata = {
+	.parts		= partition_info,
+	.num_parts	= ARRAY_SIZE(partition_info),
+};
+
 static struct platform_device ams_delta_nand_device = {
 	.name	= "ams-delta-nand",
 	.id	= -1,
+	.dev	= {
+		.platform_data = &nand_platdata,
+	},
 };
 
 #define OMAP_GPIO_LABEL		"gpio-0-15"
-- 
2.24.1
