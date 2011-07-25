From: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
Subject: [PATCH] OMAP3: Beagle: NAND: Specifying partition offsets directly.
Date: Mon, 25 Jul 2011 18:37:23 +0530
Message-ID: <1311599243-875-1-git-send-email-hrishikesh.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35664 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab1GYNJX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jul 2011 09:09:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>

In the nand partition table specifying the offset addresses
directly instead of using the macro MTDPART_OFS_APPEND to gain
runtime efficiency while nand initialization.
MTDPART_OFS_APPEND has the value (-1) ,if assigned to offset,
a runtime calculation of actual offset happens each time nand is
initialized [ Refer: drivers/mtd/mtdpart.c: allocate_partition()].
To avoid this , specify actual offset.

Signed-off-by: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7f21d24..09f7571 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -140,23 +140,23 @@ static struct mtd_partition omap3beagle_nand_partitions[] = {
 	},
 	{
 		.name		= "U-Boot",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.offset		= 0x80000
 		.size		= 15 * NAND_BLOCK_SIZE,
 		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
 	},
 	{
 		.name		= "U-Boot Env",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x260000 */
+		.offset		= 0x260000
 		.size		= 1 * NAND_BLOCK_SIZE,
 	},
 	{
 		.name		= "Kernel",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.offset		= 0x280000
 		.size		= 32 * NAND_BLOCK_SIZE,
 	},
 	{
 		.name		= "File System",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x680000 */
+		.offset		= 0x680000
 		.size		= MTDPART_SIZ_FULL,
 	},
 };
-- 
1.6.2.4

