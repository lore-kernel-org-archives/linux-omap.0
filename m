From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: OMAP: SDMA: Fix omap_stop_dma() API for channel linking
Date: Wed, 14 Oct 2009 11:44:20 +0530
Message-ID: <1255500862-29847-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55278 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbZJNGPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 02:15:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Venkatraman S <svenkatr@ti.com>, Hari n <hari.zoom@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>

OMAP sDMA driver API omap_stop_dma() doesn't really stop the dma when used
in linking scenario. This patch fixes the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
CC: Hari n <hari.zoom@gmail.com>
CC: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/dma.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index fd3154a..633c123 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -975,6 +975,11 @@ void omap_stop_dma(int lch)
 {
 	u32 l;
 
+	/* Disable the DMA channel */
+	l = dma_read(CCR(lch));
+	l &= ~OMAP_DMA_CCR_EN;
+	dma_write(l, CCR(lch));
+
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
@@ -1000,10 +1005,6 @@ void omap_stop_dma(int lch)
 	if (cpu_class_is_omap1())
 		dma_write(0, CICR(lch));
 
-	l = dma_read(CCR(lch));
-	l &= ~OMAP_DMA_CCR_EN;
-	dma_write(l, CCR(lch));
-
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
 EXPORT_SYMBOL(omap_stop_dma);
-- 
1.5.4.7

