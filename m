From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] onenand init: Pass configuration data from board-*.c files
Date: Wed, 29 Apr 2009 14:50:37 -0700
Message-ID: <20090429215037.13138.62993.stgit@localhost>
References: <20090429214900.13138.54584.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52252 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbZD2Vui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 17:50:38 -0400
In-Reply-To: <20090429214900.13138.54584.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org, linux-omap@vger.kernel.org, adrian.hunter@nokia.com

Pass configuration data from board-*.c files.

Also remove support for the OMAP_TAG_PARTITION tag.
If the partition info is passed, it should be passed from
cmdline, and probably should be done in a generic way
in the drivers/mtd.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n800.c             |   49 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/board-rx51-peripherals.c |   46 ++++++++++++++++++++++++
 arch/arm/mach-omap2/board-rx51.c             |    2 -
 arch/arm/mach-omap2/gpmc-onenand.c           |   47 +++++--------------------
 arch/arm/plat-omap/include/mach/board.h      |    8 ----
 arch/arm/plat-omap/include/mach/onenand.h    |   16 +++++++-
 6 files changed, 116 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 3d0a83b..e882e4b 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -41,6 +41,7 @@
 #include <mach/gpio-switch.h>
 #include <mach/omapfb.h>
 #include <mach/blizzard.h>
+#include <mach/onenand.h>
 #include <mach/board-nokia.h>
 
 #include <../drivers/cbus/tahvo.h>
@@ -685,11 +686,55 @@ static struct i2c_board_info __initdata_or_module n810_i2c_board_info_2[] = {
 	},
 };
 
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+
+static struct mtd_partition onenand_partitions[] = {
+	{
+		.name           = "bootloader",
+		.offset         = 0,
+		.size           = 0x20000,
+		.mask_flags     = MTD_WRITEABLE,	/* Force read-only */
+	},
+	{
+		.name           = "config",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x60000,
+	},
+	{
+		.name           = "kernel",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x200000,
+	},
+	{
+		.name           = "initfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x400000,
+	},
+	{
+		.name           = "rootfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data board_onenand_data = {
+	.cs		= 0,
+	.gpio_irq	= 26,
+	.parts		= onenand_partitions,
+	.nr_parts	= ARRAY_SIZE(onenand_partitions),
+};
+
+static void __init board_onenand_init(void)
+{
+	gpmc_onenand_init(&board_onenand_data);
+}
+
+#endif
+
 void __init nokia_n800_common_init(void)
 {
 	platform_add_devices(n800_devices, ARRAY_SIZE(n800_devices));
 
-	gpmc_onenand_init();
 	n800_mmc_init();
 	n800_bt_init();
 	n800_dsp_init();
@@ -717,6 +762,7 @@ void __init nokia_n800_common_init(void)
 		
 	mipid_dev_init();
 	blizzard_dev_init();
+	board_onenand_init();
 }
 
 static void __init nokia_n800_init(void)
@@ -728,6 +774,7 @@ static void __init nokia_n800_init(void)
 	tea5761_dev_init();
 	omap_register_gpio_switches(n800_gpio_switches,
 				    ARRAY_SIZE(n800_gpio_switches));
+	board_onenand_init();
 }
 
 void __init nokia_n800_map_io(void)
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 22183af..7b1ee3d 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -27,6 +27,7 @@
 #include <mach/common.h>
 #include <mach/dma.h>
 #include <mach/gpmc.h>
+#include <mach/onenand.h>
 
 #include "mmc-twl4030.h"
 
@@ -478,6 +479,50 @@ static int __init rx51_i2c_init(void)
 	return 0;
 }
 
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+
+static struct mtd_partition onenand_partitions[] = {
+	{
+		.name           = "bootloader",
+		.offset         = 0,
+		.size           = 0x20000,
+		.mask_flags     = MTD_WRITEABLE,	/* Force read-only */
+	},
+	{
+		.name           = "config",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x60000,
+	},
+	{
+		.name           = "kernel",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x200000,
+	},
+	{
+		.name           = "initfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x200000,
+	},
+	{
+		.name           = "rootfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data board_onenand_data = {
+	.cs		= 0,
+	.gpio_irq	= 65,
+	.parts		= onenand_partitions,
+	.nr_parts	= ARRAY_SIZE(onenand_partitions),
+};
+
+static void __init board_onenand_init(void)
+{
+	gpmc_onenand_init(&board_onenand_data);
+}
+
+#endif
 
 void __init rx51_peripherals_init(void)
 {
@@ -488,5 +533,6 @@ void __init rx51_peripherals_init(void)
 	rx51_i2c_init();
 	rx51_init_smc91x();
 	rx51_init_tsc2005();
+	board_onenand_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 20a2470..5ee62f8 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -30,7 +30,6 @@
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 #include <mach/usb.h>
-#include <mach/onenand.h>
 #include <mach/board-rx51.h>
 
 static struct omap_uart_config rx51_uart_config = {
@@ -77,7 +76,6 @@ static void __init rx51_init(void)
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap_serial_init();
 	usb_musb_init();
-	gpmc_onenand_init();
 	rx51_peripherals_init();
 	rx51_video_init();
 }
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 96f9358..fc79183 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -19,23 +19,11 @@
 #include <mach/board.h>
 #include <mach/gpmc.h>
 
-struct mtd_partition gpmc_onenand_partitions[ONENAND_MAX_PARTITIONS];
-
-int gpmc_onenand_setup(void __iomem *, int freq);
-
-static struct omap_onenand_platform_data gpmc_onenand_data = {
-	.cs = 0,
-	.parts = gpmc_onenand_partitions,
-	.nr_parts = 0, /* filled later */
-	.onenand_setup = gpmc_onenand_setup,
-};
+static struct omap_onenand_platform_data *gpmc_onenand_data;
 
 static struct platform_device gpmc_onenand_device = {
 	.name		= "omap2-onenand",
 	.id		= -1,
-	.dev = {
-		.platform_data = &gpmc_onenand_data,
-	},
 };
 
 static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
@@ -305,13 +293,13 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	return 0;
 }
 
-int gpmc_onenand_setup(void __iomem *onenand_base, int freq)
+static int gpmc_onenand_setup(void __iomem *onenand_base, int freq)
 {
-	struct omap_onenand_platform_data *datap = &gpmc_onenand_data;
 	struct device *dev = &gpmc_onenand_device.dev;
 
 	/* Set sync timings in GPMC */
-	if (omap2_onenand_set_sync_mode(datap->cs, onenand_base, freq) < 0) {
+	if (omap2_onenand_set_sync_mode(gpmc_onenand_data->cs, onenand_base,
+			freq) < 0) {
 		dev_err(dev, "Unable to set synchronous mode\n");
 		return -EINVAL;
 	}
@@ -319,29 +307,12 @@ int gpmc_onenand_setup(void __iomem *onenand_base, int freq)
 	return 0;
 }
 
-void __init gpmc_flash_init(void)
+void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 {
-	const struct omap_partition_config *part;
-	int i = 0;
-
-	gpmc_onenand_data.gpio_irq = cpu_is_omap34xx() ? 65 : 26;
-
-	while ((part = omap_get_nr_config(OMAP_TAG_PARTITION,
-				struct omap_partition_config, i)) != NULL) {
-		struct mtd_partition *mpart;
-
-		mpart = gpmc_onenand_partitions + i;
-		mpart->name = (char *) part->name;
-		mpart->size = part->size;
-		mpart->offset = part->offset;
-		mpart->mask_flags = part->mask_flags;
-		i++;
-		if (i == ARRAY_SIZE(gpmc_onenand_partitions)) {
-			printk(KERN_ERR "Too many partitions supplied\n");
-			return;
-		}
-	}
-	gpmc_onenand_data.nr_parts = i;
+	gpmc_onenand_data = _onenand_data;
+	gpmc_onenand_data->onenand_setup = gpmc_onenand_setup;
+	gpmc_onenand_device.dev.platform_data = gpmc_onenand_data;
+
 	if (platform_device_register(&gpmc_onenand_device) < 0) {
 		printk(KERN_ERR "Unable to register OneNAND device\n");
 		return;
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index ae8c2db..4d8d10a 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -125,14 +125,6 @@ struct omap_tmp105_config {
 	int (* set_power)(int enable);
 };
 
-struct omap_partition_config {
-	char name[16];
-	unsigned int size;
-	unsigned int offset;
-	/* same as in include/linux/mtd/partitions.h */
-	unsigned int mask_flags;
-};
-
 struct omap_flash_part_str_config {
 	char part_table[0];
 };
diff --git a/arch/arm/plat-omap/include/mach/onenand.h b/arch/arm/plat-omap/include/mach/onenand.h
index f97cf55..2a391fa 100644
--- a/arch/arm/plat-omap/include/mach/onenand.h
+++ b/arch/arm/plat-omap/include/mach/onenand.h
@@ -9,8 +9,11 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
+#ifndef __ASM_ARCH_OMAP_ONENAND_H__
+
 struct omap_onenand_platform_data {
 	int			cs;
 	int			gpio_irq;
@@ -24,14 +27,21 @@ int omap2_onenand_rephase(void);
 
 #define ONENAND_MAX_PARTITIONS 8
 
-#if defined(CONFIG_MTD_ONENAND) || defined(CONFIG_MTD_ONENAND_MODULE)
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
 
-extern void gpmc_onenand_init(void);
+extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
 
 #else
 
-static inline void gpmc_onenand_init(void)
+#define board_onenand_data	NULL
+
+static inline void board_onenand_init(void)
+{
+}
+
+static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
 {
 }
 
 #endif
+#endif

