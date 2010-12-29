From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v7 1/7] omap3630: nand: fix device size to work in polled mode
Date: Wed, 29 Dec 2010 19:02:20 +0530
Message-ID: <1293629546-18831-2-git-send-email-s-ghorai@ti.com>
References: <1293629546-18831-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57755 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680Ab0L2Ncj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Dec 2010 08:32:39 -0500
In-Reply-To: <1293629546-18831-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

zoom3 and 3630-sdp having the x16 nand device.
This patch configure gpmc as x16 and select the currect function in driver
for polled mode (without prefetch enable) transfer.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c |    3 ++-
 arch/arm/mach-omap2/board-flash.c   |   10 ++++++----
 arch/arm/mach-omap2/board-flash.h   |    4 ++--
 arch/arm/mach-omap2/board-ldp.c     |    2 +-
 arch/arm/mach-omap2/board-zoom2.c   |    5 +++--
 arch/arm/mach-omap2/board-zoom3.c   |    5 +++--
 arch/arm/mach-omap2/gpmc-nand.c     |    7 +++++--
 drivers/mtd/nand/omap2.c            |    2 +-
 9 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4e3742c..470872e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -809,7 +809,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
-	board_flash_init(sdp_flash_partitions, chip_sel_3430);
+	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index bbcf580..0a74141 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/mtd/nand.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -210,7 +211,7 @@ static void __init omap_sdp_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 	zoom_peripherals_init();
 	board_smc91x_init();
-	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
+	board_flash_init(sdp_flash_partitions, chip_sel_sdp, NAND_BUSWIDTH_16);
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
 }
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index fd38c05..f6b7253 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -139,11 +139,13 @@ static struct omap_nand_platform_data board_nand_data = {
 };
 
 void
-__init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
+__init board_nand_init(struct mtd_partition *nand_parts,
+			u8 nr_parts, u8 cs, int nand_type)
 {
 	board_nand_data.cs		= cs;
 	board_nand_data.parts		= nand_parts;
-	board_nand_data.nr_parts		= nr_parts;
+	board_nand_data.nr_parts	= nr_parts;
+	board_nand_data.devsize		= nand_type;
 
 	gpmc_nand_init(&board_nand_data);
 }
@@ -194,7 +196,7 @@ unmap:
  * @return - void.
  */
 void board_flash_init(struct flash_partitions partition_info[],
-					char chip_sel_board[][GPMC_CS_NUM])
+			char chip_sel_board[][GPMC_CS_NUM], int nand_type)
 {
 	u8		cs = 0;
 	u8		norcs = GPMC_CS_NUM + 1;
@@ -250,5 +252,5 @@ void board_flash_init(struct flash_partitions partition_info[],
 				"in GPMC\n");
 	else
 		board_nand_init(partition_info[2].parts,
-				partition_info[2].nr_parts, nandcs);
+			partition_info[2].nr_parts, nandcs, nand_type);
 }
diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
index 69befe0..c240a3f 100644
--- a/arch/arm/mach-omap2/board-flash.h
+++ b/arch/arm/mach-omap2/board-flash.h
@@ -25,6 +25,6 @@ struct flash_partitions {
 };
 
 extern void board_flash_init(struct flash_partitions [],
-				char chip_sel[][GPMC_CS_NUM]);
+				char chip_sel[][GPMC_CS_NUM], int nand_type);
 extern void board_nand_init(struct mtd_partition *nand_parts,
-					u8 nr_parts, u8 cs);
+					u8 nr_parts, u8 cs, int nand_type);
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 001fd97..b088b1d 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -436,7 +436,7 @@ static void __init omap_ldp_init(void)
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	board_nand_init(ldp_nand_partitions,
-		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS);
+		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS, 0);
 
 	omap2_hsmmc_init(mmc);
 	/* link regulators to MMC adapters */
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 2992a9f..994d286 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -15,6 +15,7 @@
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/i2c/twl.h>
+#include <linux/mtd/nand.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -102,8 +103,8 @@ static void __init omap_zoom2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	zoom_peripherals_init();
-	board_nand_init(zoom_nand_partitions,
-			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
+	board_nand_init(zoom_nand_partitions, ARRAY_SIZE(zoom_nand_partitions),
+						ZOOM_NAND_CS, NAND_BUSWIDTH_16);
 	zoom_debugboard_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 5adde12..0c9c15e 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/mtd/nand.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -115,8 +116,8 @@ static void __init omap_zoom_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 	zoom_peripherals_init();
-	board_nand_init(zoom_nand_partitions,
-			 ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
+	board_nand_init(zoom_nand_partitions, ARRAY_SIZE(zoom_nand_partitions),
+						ZOOM_NAND_CS, NAND_BUSWIDTH_16);
 	zoom_debugboard_init();
 
 	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 7222096..5d58f57 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/mtd/nand.h>
 
 #include <asm/mach/flash.h>
 
@@ -69,8 +70,10 @@ static int omap2_nand_gpmc_retime(void)
 	t.wr_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->wr_cycle);
 
 	/* Configure GPMC */
-	gpmc_cs_configure(gpmc_nand_data->cs,
-				GPMC_CONFIG_DEV_SIZE, gpmc_nand_data->devsize);
+	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
+		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_DEV_SIZE, 1);
+	else
+		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_DEV_SIZE, 0);
 	gpmc_cs_configure(gpmc_nand_data->cs,
 			GPMC_CONFIG_DEV_TYPE, GPMC_DEVICETYPE_NAND);
 	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 15682ec..7c04cd6 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -804,7 +804,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->mtd.name		= dev_name(&pdev->dev);
 	info->mtd.owner		= THIS_MODULE;
 
-	info->nand.options	|= pdata->devsize ? NAND_BUSWIDTH_16 : 0;
+	info->nand.options	= pdata->devsize;
 	info->nand.options	|= NAND_SKIP_BBTSCAN;
 
 	/* NAND write protect off */
-- 
1.7.0.4

