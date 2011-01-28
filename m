From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v9 1/7] omap3630: nand: fix device size to work in polled mode
Date: Fri, 28 Jan 2011 15:42:03 +0530
Message-ID: <1296209529-22696-2-git-send-email-s-ghorai@ti.com>
References: <1296209529-22696-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50553 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab1A1KMT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 05:12:19 -0500
In-Reply-To: <1296209529-22696-1-git-send-email-s-ghorai@ti.com>
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
 arch/arm/mach-omap2/board-zoom.c    |    5 +++--
 arch/arm/mach-omap2/gpmc-nand.c     |    7 +++++--
 drivers/mtd/nand/omap2.c            |    2 +-
 8 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index d4e41ef..8fb5f43 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -813,7 +813,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
-	board_flash_init(sdp_flash_partitions, chip_sel_3430);
+	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 6264564..b4ca7fc 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/mtd/nand.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -209,7 +210,7 @@ static void __init omap_sdp_init(void)
 	zoom_peripherals_init();
 	zoom_display_init();
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
index e5dc748..d986d32 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -434,7 +434,7 @@ static void __init omap_ldp_init(void)
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	board_nand_init(ldp_nand_partitions,
-		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS);
+		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS, 0);
 
 	omap2_hsmmc_init(mmc);
 	/* link regulators to MMC adapters */
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index e26754c..0242611 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -16,6 +16,7 @@
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/i2c/twl.h>
+#include <linux/mtd/nand.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -126,8 +127,8 @@ static void __init omap_zoom_init(void)
 		usb_ehci_init(&ehci_pdata);
 	}
 
-	board_nand_init(zoom_nand_partitions,
-			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
+	board_nand_init(zoom_nand_partitions, ARRAY_SIZE(zoom_nand_partitions),
+						ZOOM_NAND_CS, NAND_BUSWIDTH_16);
 	zoom_debugboard_init();
 	zoom_peripherals_init();
 	zoom_display_init();
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 2bb29c1..c1791d0 100644
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

