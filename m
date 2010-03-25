From: swirl@gmx.li
Subject: [PATCH] OMAP: board-sdp-flash.c: Fix typos in debug output
Date: Thu, 25 Mar 2010 21:21:54 +0100
Message-ID: <1269548514-32588-1-git-send-email-swirl@gmx.li>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58209 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754656Ab0CYUUv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Mar 2010 16:20:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: Thomas Weber <swirl@gmx.li>, vimalsingh@ti.com, linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>

From: Thomas Weber <swirl@gmx.li>

Corrected type of flash in output (OneNAND => NOR).
Removed whitespace after newline in output.
Removed double whitespace in output.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-sdp-flash.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-sdp-flash.c b/arch/arm/mach-omap2/board-sdp-flash.c
index b1b88de..2d02632 100644
--- a/arch/arm/mach-omap2/board-sdp-flash.c
+++ b/arch/arm/mach-omap2/board-sdp-flash.c
@@ -253,20 +253,20 @@ void __init sdp_flash_init(struct flash_partitions sdp_partition_info[])
 	}
 
 	if (norcs > GPMC_CS_NUM)
-		printk(KERN_INFO "OneNAND: Unable to find configuration "
-				" in GPMC\n ");
+		printk(KERN_INFO "NOR: Unable to find configuration "
+				"in GPMC\n");
 	else
 		board_nor_init(sdp_partition_info[0], norcs);
 
 	if (onenandcs > GPMC_CS_NUM)
 		printk(KERN_INFO "OneNAND: Unable to find configuration "
-				" in GPMC\n ");
+				"in GPMC\n");
 	else
 		board_onenand_init(sdp_partition_info[1], onenandcs);
 
 	if (nandcs > GPMC_CS_NUM)
 		printk(KERN_INFO "NAND: Unable to find configuration "
-				" in GPMC\n ");
+				"in GPMC\n");
 	else
 		board_nand_init(sdp_partition_info[2], nandcs);
 }
-- 
1.6.4.4

