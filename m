From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2] OMAP2/3: DMA errata correction
Date: Wed, 12 Aug 2009 21:01:20 -0500
Message-ID: <1250128880-1517-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54783 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbZHMCCP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 22:02:15 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7D22BnT018632
	for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 21:02:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

This errata is valid for:
OMAP2420 Errata 1.85 Impacts all 2420 ES rev
OMAP2430 Errata 1.10 Impacts only ES1.0
Description: DMA may hang when several channels are used in parallel

OMAP3430: Not impacted, so remove the errata fix for omap3

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Reviewed-by: Kamat, Nishant <nskamat@ti.com>
---
[Note: Respin of - 
http://patchwork.kernel.org/patch/32513/
Incorporated Nishant's review comment]
 arch/arm/plat-omap/dma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 34939bf..bf08634 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -946,7 +946,9 @@ void omap_start_dma(int lch)
 
 			cur_lch = next_lch;
 		} while (next_lch != -1);
-	} else if (cpu_class_is_omap2()) {
+	} else if (cpu_is_omap242x() ||
+		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0)) {
+
 		/* Errata: Need to write lch even if not using chaining */
 		dma_write(lch, CLNK_CTRL(lch));
 	}
-- 
1.6.3.3.334.g916e1

