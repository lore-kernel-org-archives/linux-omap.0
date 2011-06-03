From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] omap: pandora: fix NAND support
Date: Fri,  3 Jun 2011 23:24:03 +0300
Message-ID: <1307132643-17432-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38385 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab1FCUYX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 16:24:23 -0400
Received: by fxm17 with SMTP id 17so1510459fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 13:24:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

Commit d5ce2b65 "omap3630: nand: fix device size to work in polled mode"
changed values for .devsize in nand platform data, now we have to pass
NAND_BUSWIDTH_16 instead of '1' to select 16bit NAND.

Update pandora's platform data accordingly, also specify appropriate
transfer type.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 1d10736..a3d655c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -86,7 +86,8 @@ static struct mtd_partition omap3pandora_nand_partitions[] = {
 
 static struct omap_nand_platform_data pandora_nand_data = {
 	.cs		= 0,
-	.devsize	= 1,	/* '0' for 8-bit, '1' for 16-bit device */
+	.devsize	= NAND_BUSWIDTH_16,
+	.xfer_type	= NAND_OMAP_PREFETCH_DMA,
 	.parts		= omap3pandora_nand_partitions,
 	.nr_parts	= ARRAY_SIZE(omap3pandora_nand_partitions),
 };
-- 
1.7.0.4

