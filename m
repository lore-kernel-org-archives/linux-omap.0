From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v3 4/4] OMAP: DMA: Fix: context restore during off mode
Date: Thu, 24 Mar 2011 07:00:19 +0530
Message-ID: <1300930219-23160-5-git-send-email-manjugk@ti.com>
References: <1300930219-23160-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51572 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab1CXBeU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 21:34:20 -0400
In-Reply-To: <1300930219-23160-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, tony@atomide.com

The current DMA context restore clears all the DMA channel registers
even if the channels are in use. This will result in transfer failures
if repeated DMA transfers are initiated with one time DMA channel
configuration.

Also, remove access to sysconfig register during context save/restore
since it will be handled through hwmod layer.

Tested on OMAP3430 Zoom2 with
 - off mode enabled
 - one time DMA channel configuration
 - repeated DMA transfers

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/plat-omap/dma.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 3c39794..5c4ae7d 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2059,29 +2059,20 @@ void omap_dma_global_context_save(void)
 	pm_runtime_get_sync(dev);
 	omap_dma_global_context.dma_irqenable_l0 =
 		p->dma_read(IRQENABLE_L0, 0);
-	omap_dma_global_context.dma_ocp_sysconfig =
-		p->dma_read(OCP_SYSCONFIG, 0);
 	omap_dma_global_context.dma_gcr = p->dma_read(GCR, 0);
 	pm_runtime_put_autosuspend(dev);
 }
 
 void omap_dma_global_context_restore(void)
 {
-	int ch;
-
 	pm_runtime_get_sync(dev);
 	p->dma_write(omap_dma_global_context.dma_gcr, GCR, 0);
-	p->dma_write(omap_dma_global_context.dma_ocp_sysconfig,
-		OCP_SYSCONFIG, 0);
 	p->dma_write(omap_dma_global_context.dma_irqenable_l0,
 		IRQENABLE_L0, 0);
 
 	if (IS_DMA_ERRATA(DMA_ROMCODE_BUG))
 		p->dma_write(0x3 , IRQSTATUS_L0, 0);
 
-	for (ch = 0; ch < dma_chan_count; ch++)
-		if (dma_chan[ch].dev_id != -1)
-			omap_clear_dma(ch);
 	pm_runtime_put_autosuspend(dev);
 }
 
-- 
1.7.1

