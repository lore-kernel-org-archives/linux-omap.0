From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH 1/5] ARM: OMAP3EVM: Add NAND flash definition
Date: Mon, 11 Jun 2012 22:00:12 +0800
Message-ID: <1339423216-1323-2-git-send-email-zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37081 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2FKOAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 10:00:41 -0400
In-Reply-To: <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, zumeng.chen@gmail.com

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Zumeng Chen <zumeng.chen@gmail.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   39 ++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 639bd07..fef911d 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -24,6 +24,10 @@
 #include <linux/leds.h>
 #include <linux/interrupt.h>
 
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl.h>
@@ -43,6 +47,7 @@
 
 #include <plat/board.h>
 #include <plat/usb.h>
+#include <plat/nand.h>
 #include "common.h"
 #include <plat/mcspi.h>
 #include <video/omapdss.h>
@@ -607,6 +612,37 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
 };
 
+static struct mtd_partition omap3evm_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name           = "xloader-nand",
+		.offset         = 0,
+		.size           = 4*(SZ_128K),
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "uboot-nand",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 14*(SZ_128K),
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "params-nand",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 2*(SZ_128K)
+	},
+	{
+		.name           = "linux-nand",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 40*(SZ_128K)
+	},
+	{
+		.name           = "jffs2-nand",
+		.size           = MTDPART_SIZ_FULL,
+		.offset         = MTDPART_OFS_APPEND,
+	},
+};
+
 static void __init omap3_evm_init(void)
 {
 	struct omap_board_mux *obm;
@@ -656,6 +692,9 @@ static void __init omap3_evm_init(void)
 	}
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
+	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitions,
+			     ARRAY_SIZE(omap3evm_nand_partitions));
+
 	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
-- 
1.7.5.4

