From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 20/28] omap: board-sdp-flash.c: Fix typos in debug output
Date: Fri, 23 Apr 2010 16:11:51 -0700
Message-ID: <20100423231151.31953.84675.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57096 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127Ab0DWXLv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:51 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

From: Thomas Weber <swirl@gmx.li>

Corrected type of flash in output (OneNAND => NOR).
Removed whitespace after newline in output.
Removed double whitespace in output.

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

