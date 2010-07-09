From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v4 1/5] omap3 flash: rename board-sdp-flash.c to be use by other boards
Date: Fri,  9 Jul 2010 19:57:47 +0530
Message-ID: <1278685671-12036-2-git-send-email-s-ghorai@ti.com>
References: <1278685671-12036-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50126 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756874Ab0GIO2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 10:28:03 -0400
In-Reply-To: <1278685671-12036-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

rename board-sdp-flash.c(board-flash.c) and board-sdp.h(board-flash.h) to
used by other board e.g. zoom

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |   16 +++-
 .../{board-sdp-flash.c => board-flash.c}           |   88 ++++++++-----------
 .../include/mach/{board-sdp.h => board-flash.h}    |    9 ++-
 4 files changed, 60 insertions(+), 55 deletions(-)
 rename arch/arm/mach-omap2/{board-sdp-flash.c => board-flash.c} (68%)
 rename arch/arm/mach-omap2/include/mach/{board-sdp.h => board-flash.h} (71%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f5b4ff4..7820b6e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -119,7 +119,7 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   hsmmc.o \
-					   board-sdp-flash.o
+					   board-flash.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-sdram.o \
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index e51f8e3..61b5632 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -41,7 +41,7 @@
 #include <plat/control.h>
 #include <plat/gpmc-smc91x.h>
 
-#include <mach/board-sdp.h>
+#include <mach/board-flash.h>
 
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
@@ -667,6 +667,18 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
+/*
+ * SDP3430 V2 Board CS organization
+ * Different from SDP3430 V1. Now 4 switches used to specify CS
+ *
+ * See also the Switch S8 settings in the comments.
+ */
+static char chip_sel_3430[][GPMC_CS_NUM] = {
+	{PDC_NOR, PDC_NAND, PDC_ONENAND, DBG_MPDB, 0, 0, 0, 0}, /* S8:1111 */
+	{PDC_ONENAND, PDC_NAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1110 */
+	{PDC_NAND, PDC_ONENAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1101 */
+};
+
 static struct mtd_partition sdp_nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -797,7 +809,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
-	sdp_flash_init(sdp_flash_partitions);
+	board_flash_init(sdp_flash_partitions, chip_sel_3430);
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
diff --git a/arch/arm/mach-omap2/board-sdp-flash.c b/arch/arm/mach-omap2/board-flash.c
similarity index 68%
rename from arch/arm/mach-omap2/board-sdp-flash.c
rename to arch/arm/mach-omap2/board-flash.c
index 2638c83..ac834aa 100644
--- a/arch/arm/mach-omap2/board-sdp-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -21,7 +21,7 @@
 #include <plat/nand.h>
 #include <plat/onenand.h>
 #include <plat/tc.h>
-#include <mach/board-sdp.h>
+#include <mach/board-flash.h>
 
 #define REG_FPGA_REV			0x10
 #define REG_FPGA_DIP_SWITCH_INPUT2	0x60
@@ -29,72 +29,53 @@
 
 #define DEBUG_BASE		0x08000000 /* debug board */
 
-#define PDC_NOR		1
-#define PDC_NAND	2
-#define PDC_ONENAND	3
-#define DBG_MPDB	4
-
 /* various memory sizes */
 #define FLASH_SIZE_SDPV1	SZ_64M	/* NOR flash (64 Meg aligned) */
 #define FLASH_SIZE_SDPV2	SZ_128M	/* NOR flash (256 Meg aligned) */
 
-/*
- * SDP3430 V2 Board CS organization
- * Different from SDP3430 V1. Now 4 switches used to specify CS
- *
- * See also the Switch S8 settings in the comments.
- *
- * REVISIT: Add support for 2430 SDP
- */
-static const unsigned char chip_sel_sdp[][GPMC_CS_NUM] = {
-	{PDC_NOR, PDC_NAND, PDC_ONENAND, DBG_MPDB, 0, 0, 0, 0}, /* S8:1111 */
-	{PDC_ONENAND, PDC_NAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1110 */
-	{PDC_NAND, PDC_ONENAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1101 */
-};
-
-static struct physmap_flash_data sdp_nor_data = {
+static struct physmap_flash_data board_nor_data = {
 	.width		= 2,
 };
 
-static struct resource sdp_nor_resource = {
+static struct resource board_nor_resource = {
 	.flags		= IORESOURCE_MEM,
 };
 
-static struct platform_device sdp_nor_device = {
+static struct platform_device board_nor_device = {
 	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
-			.platform_data = &sdp_nor_data,
+			.platform_data = &board_nor_data,
 	},
 	.num_resources	= 1,
-	.resource	= &sdp_nor_resource,
+	.resource	= &board_nor_resource,
 };
 
 static void
-__init board_nor_init(struct flash_partitions sdp_nor_parts, u8 cs)
+__init board_nor_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
 {
 	int err;
 
-	sdp_nor_data.parts	= sdp_nor_parts.parts;
-	sdp_nor_data.nr_parts	= sdp_nor_parts.nr_parts;
+	board_nor_data.parts	= nor_parts;
+	board_nor_data.nr_parts	= nr_parts;
 
 	/* Configure start address and size of NOR device */
 	if (omap_rev() >= OMAP3430_REV_ES1_0) {
 		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV2 - 1,
-				(unsigned long *)&sdp_nor_resource.start);
-		sdp_nor_resource.end = sdp_nor_resource.start
+				(unsigned long *)&board_nor_resource.start);
+		board_nor_resource.end = board_nor_resource.start
 					+ FLASH_SIZE_SDPV2 - 1;
 	} else {
 		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV1 - 1,
-				(unsigned long *)&sdp_nor_resource.start);
-		sdp_nor_resource.end = sdp_nor_resource.start
+				(unsigned long *)&board_nor_resource.start);
+		board_nor_resource.end = board_nor_resource.start
 					+ FLASH_SIZE_SDPV1 - 1;
 	}
 	if (err < 0) {
 		printk(KERN_ERR "NOR: Can't request GPMC CS\n");
 		return;
 	}
-	if (platform_device_register(&sdp_nor_device) < 0)
+	if (platform_device_register(&board_nor_device) < 0)
 		printk(KERN_ERR	"Unable to register NOR device\n");
 }
 
@@ -105,17 +86,18 @@ static struct omap_onenand_platform_data board_onenand_data = {
 };
 
 static void
-__init board_onenand_init(struct flash_partitions sdp_onenand_parts, u8 cs)
+__init board_onenand_init(struct mtd_partition *onenand_parts,
+				u8 nr_parts, u8 cs)
 {
 	board_onenand_data.cs		= cs;
-	board_onenand_data.parts	= sdp_onenand_parts.parts;
-	board_onenand_data.nr_parts	= sdp_onenand_parts.nr_parts;
+	board_onenand_data.parts	= onenand_parts;
+	board_onenand_data.nr_parts	= nr_parts;
 
 	gpmc_onenand_init(&board_onenand_data);
 }
 #else
 static void
-__init board_onenand_init(struct flash_partitions sdp_onenand_parts, u8 cs)
+__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
 {
 }
 #endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
@@ -147,7 +129,7 @@ static struct gpmc_timings nand_timings = {
 	.wr_data_mux_bus = 0,
 };
 
-static struct omap_nand_platform_data sdp_nand_data = {
+static struct omap_nand_platform_data board_nand_data = {
 	.nand_setup	= NULL,
 	.gpmc_t		= &nand_timings,
 	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
@@ -155,18 +137,18 @@ static struct omap_nand_platform_data sdp_nand_data = {
 	.devsize	= 0,	/* '0' for 8-bit, '1' for 16-bit device */
 };
 
-static void
-__init board_nand_init(struct flash_partitions sdp_nand_parts, u8 cs)
+void
+__init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
 {
-	sdp_nand_data.cs		= cs;
-	sdp_nand_data.parts		= sdp_nand_parts.parts;
-	sdp_nand_data.nr_parts		= sdp_nand_parts.nr_parts;
+	board_nand_data.cs		= cs;
+	board_nand_data.parts		= nand_parts;
+	board_nand_data.nr_parts		= nr_parts;
 
-	gpmc_nand_init(&sdp_nand_data);
+	gpmc_nand_init(&board_nand_data);
 }
 #else
-static void
-__init board_nand_init(struct flash_partitions sdp_nand_parts, u8 cs)
+void
+__init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
 {
 }
 #endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
@@ -210,7 +192,8 @@ unmap:
  *
  * @return - void.
  */
-void __init sdp_flash_init(struct flash_partitions sdp_partition_info[])
+void board_flash_init(struct flash_partitions partition_info[],
+					char chip_sel_board[][GPMC_CS_NUM])
 {
 	u8		cs = 0;
 	u8		norcs = GPMC_CS_NUM + 1;
@@ -227,7 +210,7 @@ void __init sdp_flash_init(struct flash_partitions sdp_partition_info[])
 		printk(KERN_ERR "%s: Invalid chip select: %d\n", __func__, cs);
 		return;
 	}
-	config_sel = (unsigned char *)(chip_sel_sdp[idx]);
+	config_sel = (unsigned char *)(chip_sel_board[idx]);
 
 	while (cs < GPMC_CS_NUM) {
 		switch (config_sel[cs]) {
@@ -251,17 +234,20 @@ void __init sdp_flash_init(struct flash_partitions sdp_partition_info[])
 		printk(KERN_INFO "NOR: Unable to find configuration "
 				"in GPMC\n");
 	else
-		board_nor_init(sdp_partition_info[0], norcs);
+		board_nor_init(partition_info[0].parts,
+				partition_info[0].nr_parts, norcs);
 
 	if (onenandcs > GPMC_CS_NUM)
 		printk(KERN_INFO "OneNAND: Unable to find configuration "
 				"in GPMC\n");
 	else
-		board_onenand_init(sdp_partition_info[1], onenandcs);
+		board_onenand_init(partition_info[1].parts,
+					partition_info[1].nr_parts, onenandcs);
 
 	if (nandcs > GPMC_CS_NUM)
 		printk(KERN_INFO "NAND: Unable to find configuration "
 				"in GPMC\n");
 	else
-		board_nand_init(sdp_partition_info[2], nandcs);
+		board_nand_init(partition_info[2].parts,
+				partition_info[2].nr_parts, nandcs);
 }
diff --git a/arch/arm/mach-omap2/include/mach/board-sdp.h b/arch/arm/mach-omap2/include/mach/board-flash.h
similarity index 71%
rename from arch/arm/mach-omap2/include/mach/board-sdp.h
rename to arch/arm/mach-omap2/include/mach/board-flash.h
index 465169c..b2242ae 100644
--- a/arch/arm/mach-omap2/include/mach/board-sdp.h
+++ b/arch/arm/mach-omap2/include/mach/board-flash.h
@@ -12,10 +12,17 @@
  */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <plat/gpmc.h>
+
+#define PDC_NOR		1
+#define PDC_NAND	2
+#define PDC_ONENAND	3
+#define DBG_MPDB	4
 
 struct flash_partitions {
 	struct mtd_partition *parts;
 	int nr_parts;
 };
 
-extern void sdp_flash_init(struct flash_partitions []);
+extern void board_flash_init(struct flash_partitions [],
+				char chip_sel[][GPMC_CS_NUM]);
-- 
1.5.4.7

