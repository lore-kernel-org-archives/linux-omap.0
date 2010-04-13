From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH] omap: NAND: Making ecc layout as compatible with romcode ecc
Date: Tue, 13 Apr 2010 23:07:26 +0530
Message-ID: <1271180246-31779-15-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1271180246-31779-1-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-2-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-3-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-4-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-5-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-6-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-7-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-8-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-9-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-10-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-11-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-12-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-13-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-14-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46825 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab0DMRhf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Apr 2010 13:37:35 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3DHbWL1030513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 12:37:34 -0500
In-Reply-To: <1271180246-31779-14-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

    This patch overrides nand ecc layout and bad block descriptor (for 8-bit
    device) to support hw ecc in romcode layout. So as to have in sync with ecc
    layout throughout; i.e. x-laod, u-boot and kernel.

    This patch also enables to use romcode ecc for spd and zoom, by default.

    This enables to flash x-load, u-boot, kernel, FS images from kernel itself
    and compatiable with other tools.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/board-sdp-flash.c  |    2 +-
 arch/arm/mach-omap2/board-zoom-flash.c |    2 +-
 drivers/mtd/nand/omap2.c               |   42 ++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-sdp-flash.c b/arch/arm/mach-omap2/board-sdp-flash.c
index 29e0768..f1002cf 100644
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
index 1547bdb..53eeaa6 100644
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
index b42d058..1ff5609 100644
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
@@ -1142,6 +1175,15 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
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
-- 
1.5.4.7

