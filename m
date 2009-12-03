From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 2/2]: OMAP3: Add support for flash on 3430SDP board
Date: Thu, 3 Dec 2009 19:41:32 +0530
Message-ID: <ce9ab5790912030611ofb0d7d1g8be17374aa18bb91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55118 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756035AbZLCOLr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 09:11:47 -0500
Received: by bwz27 with SMTP id 27so1108470bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 06:11:53 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From f48199dc44e1bf5f56aa981d20f35dc8ce1113bf Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 1 Dec 2009 11:24:46 +0530
Subject: [PATCH] OMAP3: Add support for flash on 3430SDP board

This patch adds support for flashes on 3430SDP boards. All three
NAND, NOR and OneNAND are supported. I have tested it on
3430SDP (ES2 and ES3.1).

This patch can be treated as an example to "how to utilize":
'gpmc-nand.c' and 'board-sdp-flash.c'.

Similar patches can be created for 2430sdp and 3630sdp or any other
similar board.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/Makefile        |    1 +
 arch/arm/mach-omap2/board-3430sdp.c |  111 +++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0dfe27a..f1d8544 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
+					   board-sdp-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
diff --git a/arch/arm/mach-omap2/board-3430sdp.c
b/arch/arm/mach-omap2/board-3430sdp.c
index 5bda9fd..b921f44 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -42,6 +42,8 @@
 #include <plat/control.h>
 #include <plat/gpmc-smc91x.h>

+#include <mach/board-sdp.h>
+
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"

@@ -640,6 +642,114 @@ static struct ehci_hcd_omap_platform_data
ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };

+static struct mtd_partition sdp_nor_partitions[] = {
+	/* bootloader (U-Boot, etc) in first sector */
+	{
+		.name		= "Bootloader-NOR",
+		.offset		= 0,
+		.size		= SZ_256K,
+		.mask_flags	= MTD_WRITEABLE, /* force read-only */
+	},
+	/* bootloader params in the next sector */
+	{
+		.name		= "Params-NOR",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_256K,
+		.mask_flags	= 0,
+	},
+	/* kernel */
+	{
+		.name		= "Kernel-NOR",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_2M,
+		.mask_flags	= 0
+	},
+	/* file system */
+	{
+		.name		= "Filesystem-NOR",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+		.mask_flags	= 0
+	}
+};
+
+static struct mtd_partition sdp_onenand_partitions[] = {
+	{
+		.name		= "X-Loader-OneNAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE  /* force read-only */
+	},
+	{
+		.name		= "U-Boot-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 2 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE  /* force read-only */
+	},
+	{
+		.name		= "U-Boot Environment-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 1 * (64 * 2048),
+	},
+	{
+		.name		= "Kernel-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 16 * (64 * 2048),
+	},
+	{
+		.name		= "File System-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct mtd_partition sdp_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader-NAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 10 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "Boot Env-NAND",
+
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x1c0000 */
+		.size		= 6 * (64 * 2048),
+	},
+	{
+		.name		= "Kernel-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.size		= 40 * (64 * 2048),
+	},
+	{
+		.name		= "File System - NAND",
+		.size		= MTDPART_SIZ_FULL,
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x780000 */
+	},
+};
+
+static struct flash_partitions sdp_flash_partitions[] = {
+	{
+		.parts = sdp_nor_partitions,
+		.nr_parts = ARRAY_SIZE(sdp_nor_partitions),
+	},
+	{
+		.parts = sdp_onenand_partitions,
+		.nr_parts = ARRAY_SIZE(sdp_onenand_partitions),
+	},
+	{
+		.parts = sdp_nand_partitions,
+		.nr_parts = ARRAY_SIZE(sdp_nand_partitions),
+	},
+};
+
 static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
@@ -655,6 +765,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	board_smc91x_init();
+	sdp_flash_init(sdp_flash_partitions);
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
-- 
1.5.5
