From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/7] onenand init: Rename n800_* functions to gpmc_onenand_*
	functions
Date: Mon, 04 May 2009 17:26:17 -0700
Message-ID: <20090505002617.2894.10943.stgit@localhost>
References: <20090505002144.2894.25201.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64752 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227AbZEEA0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2009 20:26:21 -0400
In-Reply-To: <20090505002144.2894.25201.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org, juha.yrjola@solidboot.com, linux-omap@vger.kernel.org, adrian.hunter@nokia.com

Rename n800_* functions to gpmc_onenand_* functions

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile              |    1 -
 arch/arm/mach-omap2/board-n800.c          |    2 +-
 arch/arm/mach-omap2/board-rx51-flash.c    |   21 -------------------
 arch/arm/mach-omap2/board-rx51.c          |    4 ++--
 arch/arm/mach-omap2/gpmc-onenand.c        |   32 +++++++++++++++--------------
 arch/arm/plat-omap/include/mach/onenand.h |   12 +++++++++++
 6 files changed, 31 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-rx51-flash.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9cb2662..d35996d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -62,7 +62,6 @@ obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o \
 					   board-n800-camera.o
 obj-$(CONFIG_MACH_NOKIA_N810)		+= board-n810.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
-					   board-rx51-flash.o \
 					   board-rx51-sdram.o \
 					   board-rx51-video.o \
 					   board-rx51-peripherals.o \
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index f1552f0..3d0a83b 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -689,7 +689,7 @@ void __init nokia_n800_common_init(void)
 {
 	platform_add_devices(n800_devices, ARRAY_SIZE(n800_devices));
 
-	n800_flash_init();
+	gpmc_onenand_init();
 	n800_mmc_init();
 	n800_bt_init();
 	n800_dsp_init();
diff --git a/arch/arm/mach-omap2/board-rx51-flash.c b/arch/arm/mach-omap2/board-rx51-flash.c
deleted file mode 100644
index f3b7eaf..0000000
--- a/arch/arm/mach-omap2/board-rx51-flash.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/board-rx51-flash.c
- *
- * Copyright (C) 2008 Nokia
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <mach/board-rx51.h>
-
-extern void __init n800_flash_init(void);
-
-void __init rx51_flash_init(void)
-{
-	n800_flash_init();
-}
-
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index c800b24..20a2470 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -30,6 +30,7 @@
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 #include <mach/usb.h>
+#include <mach/onenand.h>
 #include <mach/board-rx51.h>
 
 static struct omap_uart_config rx51_uart_config = {
@@ -67,7 +68,6 @@ static void __init rx51_init_irq(void)
 	omap_gpio_init();
 }
 
-extern void __init rx51_flash_init(void);
 extern void __init rx51_peripherals_init(void);
 extern void __init rx51_video_init(void);
 
@@ -77,7 +77,7 @@ static void __init rx51_init(void)
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap_serial_init();
 	usb_musb_init();
-	rx51_flash_init();
+	gpmc_onenand_init();
 	rx51_peripherals_init();
 	rx51_video_init();
 }
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 52aaf76..96f9358 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -19,22 +19,22 @@
 #include <mach/board.h>
 #include <mach/gpmc.h>
 
-struct mtd_partition n800_partitions[ONENAND_MAX_PARTITIONS];
+struct mtd_partition gpmc_onenand_partitions[ONENAND_MAX_PARTITIONS];
 
-int n800_onenand_setup(void __iomem *, int freq);
+int gpmc_onenand_setup(void __iomem *, int freq);
 
-static struct omap_onenand_platform_data n800_onenand_data = {
+static struct omap_onenand_platform_data gpmc_onenand_data = {
 	.cs = 0,
-	.parts = n800_partitions,
+	.parts = gpmc_onenand_partitions,
 	.nr_parts = 0, /* filled later */
-	.onenand_setup = n800_onenand_setup,
+	.onenand_setup = gpmc_onenand_setup,
 };
 
-static struct platform_device n800_onenand_device = {
+static struct platform_device gpmc_onenand_device = {
 	.name		= "omap2-onenand",
 	.id		= -1,
 	.dev = {
-		.platform_data = &n800_onenand_data,
+		.platform_data = &gpmc_onenand_data,
 	},
 };
 
@@ -305,10 +305,10 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	return 0;
 }
 
-int n800_onenand_setup(void __iomem *onenand_base, int freq)
+int gpmc_onenand_setup(void __iomem *onenand_base, int freq)
 {
-	struct omap_onenand_platform_data *datap = &n800_onenand_data;
-	struct device *dev = &n800_onenand_device.dev;
+	struct omap_onenand_platform_data *datap = &gpmc_onenand_data;
+	struct device *dev = &gpmc_onenand_device.dev;
 
 	/* Set sync timings in GPMC */
 	if (omap2_onenand_set_sync_mode(datap->cs, onenand_base, freq) < 0) {
@@ -319,30 +319,30 @@ int n800_onenand_setup(void __iomem *onenand_base, int freq)
 	return 0;
 }
 
-void __init n800_flash_init(void)
+void __init gpmc_flash_init(void)
 {
 	const struct omap_partition_config *part;
 	int i = 0;
 
-	n800_onenand_data.gpio_irq = cpu_is_omap34xx() ? 65 : 26;
+	gpmc_onenand_data.gpio_irq = cpu_is_omap34xx() ? 65 : 26;
 
 	while ((part = omap_get_nr_config(OMAP_TAG_PARTITION,
 				struct omap_partition_config, i)) != NULL) {
 		struct mtd_partition *mpart;
 
-		mpart = n800_partitions + i;
+		mpart = gpmc_onenand_partitions + i;
 		mpart->name = (char *) part->name;
 		mpart->size = part->size;
 		mpart->offset = part->offset;
 		mpart->mask_flags = part->mask_flags;
 		i++;
-		if (i == ARRAY_SIZE(n800_partitions)) {
+		if (i == ARRAY_SIZE(gpmc_onenand_partitions)) {
 			printk(KERN_ERR "Too many partitions supplied\n");
 			return;
 		}
 	}
-	n800_onenand_data.nr_parts = i;
-	if (platform_device_register(&n800_onenand_device) < 0) {
+	gpmc_onenand_data.nr_parts = i;
+	if (platform_device_register(&gpmc_onenand_device) < 0) {
 		printk(KERN_ERR "Unable to register OneNAND device\n");
 		return;
 	}
diff --git a/arch/arm/plat-omap/include/mach/onenand.h b/arch/arm/plat-omap/include/mach/onenand.h
index 4649d30..f97cf55 100644
--- a/arch/arm/plat-omap/include/mach/onenand.h
+++ b/arch/arm/plat-omap/include/mach/onenand.h
@@ -23,3 +23,15 @@ struct omap_onenand_platform_data {
 int omap2_onenand_rephase(void);
 
 #define ONENAND_MAX_PARTITIONS 8
+
+#if defined(CONFIG_MTD_ONENAND) || defined(CONFIG_MTD_ONENAND_MODULE)
+
+extern void gpmc_onenand_init(void);
+
+#else
+
+static inline void gpmc_onenand_init(void)
+{
+}
+
+#endif

