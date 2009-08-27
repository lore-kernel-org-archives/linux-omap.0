From: Maxime Petazzoni <mpetazzoni@mvista.com>
Subject: [PATCH] OMAP3: Zoom2: provide default MTD partitions
Date: Thu, 27 Aug 2009 13:59:46 +0200
Message-ID: <1251374386-6733-1-git-send-email-mpetazzoni@mvista.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:62957 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZH0MVr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 08:21:47 -0400
Received: from localhost (unknown [10.254.1.77])
	by hermes.mvista.com (Postfix) with ESMTP id 2B52A1B1B8
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 05:01:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This change introduces default MTD partitions for the Zoom-II board
NAND, inspired by the OMAP3 Beagle partitions and the OMAP3 Zoom2
partitions defined in OmapZoom.org's OMAP kernel.

The size of the U-Boot environment partition was increased to 1MB, as
the previously smaller partition couldn't contain the U-Boot environment
correctly (erasing the next partition would erase the U-Boot env as
well).

Finally, the "system" partition gets an increased size of 256MB to take
advantage of the size of the flash on the Zoom-II board.

Signed-off-by: Maxime Petazzoni <mpetazzoni@mvista.com>
---
 arch/arm/mach-omap2/board-zoom2.c |   86 +++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 4d295d5..ce5a4d8 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -16,16 +16,101 @@
 #include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/regulator/machine.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
+#include <mach/nand.h>
 #include <mach/usb.h>
 #include <mach/keypad.h>
 
 #include "mmc-twl4030.h"
 
+#define LDP3430_NAND_CS	0
+#define GPMC_CS0_BASE	0x60
+#define GPMC_CS_SIZE	0x30
+
+static struct mtd_partition zoom2_nand_partitions[] = {
+	{
+		.name		= "X-Loader-NAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),	/* 512kB */
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 4 * (64 * 2048),	/* 512kB */
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "Boot Env-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x100000 */
+		.size		= 8 * (64 * 2048),	/* 1MB */
+	},
+	{
+		.name		= "Kernel-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x200000 */
+		.size		= 32 * (64 * 2048),	/* 4MB */
+	},
+	{
+		.name		= "system",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x600000 */
+		.size		= 2048 * (64 * 2048),	/* 256MB */
+	},
+	{
+		.name		= "userdata",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x10600000 */
+		.size		= 512 * (64 * 2048),	/* 64MB */
+	},
+	{
+		.name		= "cache",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x14600000 */
+		.size		= 512 * (64 * 2048),	/* 64MB */
+	},
+};
+
+/* NAND chip access: 16 bit */
+static struct omap_nand_platform_data zoom2_nand_data = {
+	.parts		= zoom2_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(zoom2_nand_partitions),
+	.nand_setup	= NULL,
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.dev_ready	= NULL,
+};
+
+static struct resource zoom2_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device zoom2_nand_device = {
+	.name		= "omap2-nand",
+	.id		= 0,
+	.dev		= {
+		.platform_data = &zoom2_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &zoom2_nand_resource,
+};
+
+static void __init zoom2_flash_init(void)
+{
+	u8 nandcs = LDP3430_NAND_CS;
+	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
+
+	zoom2_nand_data.cs = nandcs;
+	zoom2_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
+			GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
+	zoom2_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
+
+	if (platform_device_register(&zoom2_nand_device) < 0)
+		printk(KERN_ERR "Unable to register NAND device!\n");
+}
+
 /* Zoom2 has Qwerty keyboard*/
 static int zoom2_twl4030_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -271,6 +356,7 @@ static void __init omap_zoom2_init(void)
 	omap_serial_init(&zoom2_uart_config);
 	omap_zoom2_debugboard_init();
 	usb_musb_init();
+	zoom2_flash_init();
 }
 
 static void __init omap_zoom2_map_io(void)
-- 
1.6.3.3.210.g29cb3

