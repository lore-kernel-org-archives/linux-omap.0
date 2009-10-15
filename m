From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2] ARM: OMAP: SDMA: Fix omap_stop_dma() API for channel linking
Date: Thu, 15 Oct 2009 12:36:56 +0530
Message-ID: <1255590416-11550-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47215 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbZJOHHo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2009 03:07:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Venkatraman S <svenkatr@ti.com>, Hari n <hari.zoom@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>

OMAP sDMA driver API omap_stop_dma() doesn't really stop the dma when used
in linking scenario. This patch fixes the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Reviewed-By: Tony Lindgren <tony@atomide.com>
CC: Hari n <hari.zoom@gmail.com>
CC: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/dma.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index fd3154a..1c933b4 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -987,6 +987,11 @@ void omap_stop_dma(int lch)
 			/* Mark the current channel */
 			dma_chan_link_map[cur_lch] = 1;
 
+			/* Disable the DMA channel */
+			l = dma_read(CCR(lch));
+			l &= ~OMAP_DMA_CCR_EN;
+			dma_write(l, CCR(lch));
+
 			disable_lnk(cur_lch);
 
 			next_lch = dma_chan[cur_lch].next_lch;
-- 
1.5.4.7

