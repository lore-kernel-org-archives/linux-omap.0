From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 1/3] arm: omap3: cm-t35: minor comments fixes
Date: Wed, 15 Jun 2011 00:16:12 +0300
Message-ID: <1308086174-3080-1-git-send-email-grinberg@compulab.co.il>
References: <20110614073648.GI3352@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:38855
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752218Ab1FNVQS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jun 2011 17:16:18 -0400
In-Reply-To: <20110614073648.GI3352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>

Update authors and copyright, remove Free S/W Foundation postal address,
fix offsets of NAND partitions in comments.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 77456de..6c5881b 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -1,8 +1,9 @@
 /*
  * board-cm-t35.c (CompuLab CM-T35 module)
  *
- * Copyright (C) 2009 CompuLab, Ltd.
- * Author: Mike Rapoport <mike@compulab.co.il>
+ * Copyright (C) 2009-2011 CompuLab, Ltd.
+ * Authors: Mike Rapoport <mike@compulab.co.il>
+ *	    Igor Grinberg <grinberg@compulab.co.il>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -13,11 +14,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
  */
 
 #include <linux/kernel.h>
@@ -149,12 +145,12 @@ static struct mtd_partition cm_t35_nand_partitions[] = {
 	},
 	{
 		.name           = "linux",
-		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x2A0000 */
 		.size           = 32 * NAND_BLOCK_SIZE,
 	},
 	{
 		.name           = "rootfs",
-		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x680000 */
+		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x6A0000 */
 		.size           = MTDPART_SIZ_FULL,
 	},
 };
-- 
1.7.3.4

