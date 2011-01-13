From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 2/2] arm: omap3: cm-t3517: minor comment fix
Date: Thu, 13 Jan 2011 18:24:50 +0200
Message-ID: <1294935890-31160-3-git-send-email-grinberg@compulab.co.il>
References: <1294935890-31160-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:41721 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933085Ab1AMQYz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 11:24:55 -0500
In-Reply-To: <1294935890-31160-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

offsets in the comment were wrong - fix this.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t3517.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 1706df0..8f9a64d 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -225,12 +225,12 @@ static struct mtd_partition cm_t3517_nand_partitions[] = {
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
1.7.2.5

