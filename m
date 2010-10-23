From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 1/3] omap3: IGEP v2: Remove onenand_setup no-op function.
Date: Sat, 23 Oct 2010 18:48:58 +0200
Message-ID: <1287852540-4951-2-git-send-email-eballetbo@gmail.com>
References: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55026 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0JWQtL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Oct 2010 12:49:11 -0400
Received: by wyf28 with SMTP id 28so1953714wyf.19
        for <linux-omap@vger.kernel.org>; Sat, 23 Oct 2010 09:49:10 -0700 (PDT)
In-Reply-To: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Set onenand_setup to NULL instead of adding a no-op function.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5e035a5..20b199f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -136,16 +136,9 @@ static struct mtd_partition igep2_onenand_partitions[] = {
 	},
 };
 
-static int igep2_onenand_setup(void __iomem *onenand_base, int freq)
-{
-       /* nothing is required to be setup for onenand as of now */
-       return 0;
-}
-
 static struct omap_onenand_platform_data igep2_onenand_data = {
 	.parts = igep2_onenand_partitions,
 	.nr_parts = ARRAY_SIZE(igep2_onenand_partitions),
-	.onenand_setup = igep2_onenand_setup,
 	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
 };
 
-- 
1.7.1

