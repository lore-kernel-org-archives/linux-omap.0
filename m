From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 4/5] omap3: cm-t3517: add support for NAND flash
Date: Tue, 21 Sep 2010 18:03:12 +0200
Message-ID: <1285084993-27683-5-git-send-email-grinberg@compulab.co.il>
References: <1285084993-27683-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:37428 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754981Ab0IUQD2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 12:03:28 -0400
In-Reply-To: <1285084993-27683-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

add support for NAND flash.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t3517.c |   54 ++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 2c7082d..4c26cf5 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -29,6 +29,9 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/rtc-v3020.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -38,6 +41,8 @@
 #include <plat/common.h>
 #include <plat/control.h>
 #include <plat/usb.h>
+#include <plat/nand.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 
@@ -143,6 +148,54 @@ static inline int cm_t3517_init_usbh(void)
 }
 #endif
 
+#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
+#define NAND_BLOCK_SIZE		SZ_128K
+
+static struct mtd_partition cm_t3517_nand_partitions[] = {
+	{
+		.name           = "xloader",
+		.offset         = 0,			/* Offset = 0x00000 */
+		.size           = 4 * NAND_BLOCK_SIZE,
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "uboot",
+		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size           = 15 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "uboot environment",
+		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x260000 */
+		.size           = 2 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "linux",
+		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.size           = 32 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "rootfs",
+		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x680000 */
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_nand_platform_data cm_t3517_nand_data = {
+	.parts			= cm_t3517_nand_partitions,
+	.nr_parts		= ARRAY_SIZE(cm_t3517_nand_partitions),
+	.dma_channel		= -1,	/* disable DMA in OMAP NAND driver */
+	.cs			= 0,
+};
+
+static void __init cm_t3517_init_nand(void)
+{
+	if (gpmc_nand_init(&cm_t3517_nand_data) < 0)
+		pr_err("CM-T3517: NAND initialization failed\n");
+}
+#else
+static inline void cm_t3517_init_nand(void) {}
+#endif
+
 static struct omap_board_config_kernel cm_t3517_config[] __initdata = {
 };
 
@@ -179,6 +232,7 @@ static void __init cm_t3517_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
 	cm_t3517_init_leds();
+	cm_t3517_init_nand();
 	cm_t3517_init_rtc();
 	cm_t3517_init_usbh();
 }
-- 
1.7.1

