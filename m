From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/2] omap3: flash: use pr_err instead of printk
Date: Tue, 15 Feb 2011 16:27:32 +0530
Message-ID: <1297767452-22554-3-git-send-email-premi@ti.com>
References: <1297767452-22554-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55097 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393Ab1BOK5r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 05:57:47 -0500
In-Reply-To: <1297767452-22554-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

Change all occurences of printf() to pr_err().
Includes minor formatting changes as result of
this change.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-flash.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index ce61200..86d1020 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -73,11 +73,11 @@ __init board_nor_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
 					+ FLASH_SIZE_SDPV1 - 1;
 	}
 	if (err < 0) {
-		printk(KERN_ERR "NOR: Can't request GPMC CS\n");
+		pr_err("NOR: Can't request GPMC CS\n");
 		return;
 	}
 	if (platform_device_register(&board_nor_device) < 0)
-		printk(KERN_ERR	"Unable to register NOR device\n");
+		pr_err("Unable to register NOR device\n");
 }
 
 #if defined(CONFIG_MTD_ONENAND_OMAP2) || \
@@ -208,7 +208,7 @@ void board_flash_init(struct flash_partitions partition_info[],
 	 */
 	idx = get_gpmc0_type();
 	if (idx >= MAX_SUPPORTED_GPMC_CONFIG) {
-		printk(KERN_ERR "%s: Invalid chip select: %d\n", __func__, cs);
+		pr_err("%s: Invalid chip select: %d\n", __func__, cs);
 		return;
 	}
 	config_sel = (unsigned char *)(chip_sel_board[idx]);
@@ -232,22 +232,19 @@ void board_flash_init(struct flash_partitions partition_info[],
 	}
 
 	if (norcs > GPMC_CS_NUM)
-		printk(KERN_INFO "NOR: Unable to find configuration "
-				"in GPMC\n");
+		pr_err("NOR: Unable to find configuration in GPMC\n");
 	else
 		board_nor_init(partition_info[0].parts,
 				partition_info[0].nr_parts, norcs);
 
 	if (onenandcs > GPMC_CS_NUM)
-		printk(KERN_INFO "OneNAND: Unable to find configuration "
-				"in GPMC\n");
+		pr_err("OneNAND: Unable to find configuration in GPMC\n");
 	else
 		board_onenand_init(partition_info[1].parts,
 					partition_info[1].nr_parts, onenandcs);
 
 	if (nandcs > GPMC_CS_NUM)
-		printk(KERN_INFO "NAND: Unable to find configuration "
-				"in GPMC\n");
+		pr_err("NAND: Unable to find configuration in GPMC\n");
 	else
 		board_nand_init(partition_info[2].parts,
 				partition_info[2].nr_parts, nandcs);
-- 
1.7.2.2

