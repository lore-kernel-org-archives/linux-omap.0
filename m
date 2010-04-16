From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH 6/6] omap: NAND: Making ecc layout as compatible with romcode ecc
Date: Fri, 16 Apr 2010 17:05:42 +0530
Message-ID: <1271417742-4469-1-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33800 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757804Ab0DPLfw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 07:35:52 -0400
In-Reply-To: <Sukumar Ghorai <s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: sbranden@broadcom.com, leochen@broadcom.com, David.Woodhouse@intel.com, linux-omap@vger.kernel.org, tony@atomide.com, vimal.newwork@gmail.com, Sukumar Ghorai <s-ghorai@ti.com>

    This patch overrides nand ecc layout and bad block descriptor (for 8-bit
    device) to support hw ecc in romcode layout. So as to have in sync with ecc
    layout throughout; i.e. x-laod, u-boot and kernel.

    This patch also enables to use romcode ecc for spd and zoom, by default.

    This enables to flash x-load, u-boot, kernel, FS images from kernel itself
    and compatiable with other tools.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-sdp-flash.c  |    2 +-
 arch/arm/mach-omap2/board-zoom-flash.c |    2 +-
 drivers/mtd/nand/omap2.c               |   42 ++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-sdp-flash.c b/arch/arm/mach-omap2/board-sdp-flash.c
index 437a1a4..ac891ea
--- a/arch/arm/mach-omap2/board-sdp-flash.c
+++ b/arch/arm/mach-omap2/board-sdp-flash.c
@@ -162,7 +162,7 @@ __init board_nand_init(struct flash_partitions sdp_nand_parts, u8 cs)
 	sdp_nand_data.cs		= cs;
 	sdp_nand_data.parts		= sdp_nand_parts.parts;
 	sdp_nand_data.nr_parts		= sdp_nand_parts.nr_parts;
-	sdp_nand_data.ecc_opt		= 0x1; /* HW ECC in default layout */
+	sdp_nand_data.ecc_opt		= 0x2; /* HW ECC layout as in ROMCODE */
 	if (cpu_is_omap3630())
 		sdp_nand_data.devsize = 1; /* 0: 8-bit, 1: 16-bit device */
 
diff --git a/arch/arm/mach-omap2/board-zoom-flash.c b/arch/arm/mach-omap2/board-zoom-flash.c
index 1547bdb..53eeaa6
--- a/arch/arm/mach-omap2/board-zoom-flash.c
+++ b/arch/arm/mach-omap2/board-zoom-flash.c
@@ -71,7 +71,7 @@ void __init zoom_flash_init(struct flash_partitions zoom_nand_parts[], int cs)
 	zoom_nand_data.cs		= cs;
 	zoom_nand_data.parts		= zoom_nand_parts[0].parts;
 	zoom_nand_data.nr_parts		= zoom_nand_parts[0].nr_parts;
-	zoom_nand_data.ecc_opt		= 0x1; /* HW ECC in default layout */
+	zoom_nand_data.ecc_opt		= 0x2; /* HW ECC in romcode layout */
 	zoom_nand_data.gpmc_baseaddr	= (void *)(gpmc_base_add);
 	zoom_nand_data.gpmc_cs_baseaddr	= (void *)(gpmc_base_add +
 					GPMC_CS0_BASE +	cs * GPMC_CS_SIZE);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 207fb3c..f5d2c53
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -152,6 +152,39 @@ struct omap_nand_info {
 	u_char				*buf;
 };
 
+static struct nand_ecclayout hw_x8_romcode_oob_64 = {
+	.eccbytes = 12,
+	.eccpos = {
+		    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
+		  },
+	.oobfree = {
+			{.offset = 13,
+			 .length = 51}
+		   }
+};
+
+/* Define some generic bad / good block scan pattern which are used
+ * while scanning a device for factory marked good / bad blocks
+ */
+static uint8_t scan_ff_pattern[] = { 0xff };
+static struct nand_bbt_descr bb_descrip_flashbased = {
+	.options = NAND_BBT_SCANEMPTY | NAND_BBT_SCANALLPAGES,
+	.offs = 0,
+	.len = 1,
+	.pattern = scan_ff_pattern,
+};
+
+static struct nand_ecclayout hw_x16_romcode_oob_64 = {
+	.eccbytes = 12,
+	.eccpos = {
+		    2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
+		  },
+	.oobfree = {
+			{.offset = 14,
+			 .length = 50}
+		   }
+};
+
 /**
  * omap_nand_wp - This function enable or disable the Write Protect feature
  * @mtd: MTD device structure
@@ -1136,6 +1169,15 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->nand.verify_buf = omap_verify_buf;
 
 	if (pdata->ecc_opt & 0x3) {
+		if (pdata->ecc_opt == 0x2) {
+			if (info->nand.options & NAND_BUSWIDTH_16) {
+				info->nand.ecc.layout = &hw_x16_romcode_oob_64;
+			} else {
+				info->nand.ecc.layout = &hw_x8_romcode_oob_64;
+				info->nand.badblock_pattern =
+							&bb_descrip_flashbased;
+			}
+		}
 		info->nand.ecc.bytes		= 3;
 		info->nand.ecc.size		= 512;
 		info->nand.ecc.calculate	= omap_calculate_ecc;
