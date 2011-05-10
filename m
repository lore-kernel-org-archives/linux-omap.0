From: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
Subject: [PATCH] omap3evm: add support for nand
Date: Tue, 10 May 2011 13:41:58 +0200
Message-ID: <1305027718-18998-1-git-send-email-bdefaria@adeneo-embedded.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38061 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab1EJLmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 May 2011 07:42:45 -0400
Received: by wwa36 with SMTP id 36so6773950wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 04:42:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Bryan DE FARIA <bdefaria@adeneo-embedded.com>, tony@atomide.com, jjhiblot@adetelgroup.com

This patch adds a basic nand support for the omap3evm.

Signed-off-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   38 ++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5066b0b..6b5b5e1 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -30,6 +30,8 @@
 #include <linux/usb/otg.h>
 #include <linux/smsc911x.h>
 
+#include <linux/mtd/nand.h>
+
 #include <linux/wl12xx.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -46,6 +48,7 @@
 #include <plat/mcspi.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
+#include <plat/nand.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -69,6 +72,8 @@
 #define OMAP3EVM_GEN1_ETHR_GPIO_RST	64
 #define OMAP3EVM_GEN2_ETHR_GPIO_RST	7
 
+#define NAND_BLOCK_SIZE                SZ_128K
+
 static u8 omap3_evm_version;
 
 u8 get_omap3_evm_rev(void)
@@ -315,6 +320,37 @@ static struct omap_dss_board_info omap3_evm_dss_data = {
 	.default_device	= &omap3_evm_lcd_device,
 };
 
+static struct mtd_partition omap3evm_nand_partitions[] = {
+       /* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name           = "X-Loader",
+		.offset         = 0,
+		.size           = 4 * NAND_BLOCK_SIZE,
+		.mask_flags     = MTD_WRITEABLE,        /* force read-only */
+	},
+	{
+		.name           = "U-Boot",
+		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x80000 */
+		.size           = 15 * NAND_BLOCK_SIZE,
+		.mask_flags     = MTD_WRITEABLE,        /* force read-only */
+	},
+	{
+		.name           = "U-Boot Env",
+		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x260000 */
+		.size           = 1 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "Kernel",
+		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x280000 */
+		.size           = 32 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "File System",
+		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x680000 */
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
 static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -766,6 +802,8 @@ static void __init omap3_evm_init(void)
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
 	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
+	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitions,
+			     ARRAY_SIZE(omap3evm_nand_partitions));
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
 
-- 
1.7.4.1

