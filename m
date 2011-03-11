From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 4/4] OMAP: DMA: Fix: context restore during off mode
Date: Fri, 11 Mar 2011 19:50:15 +0530
Message-ID: <1299853215-8507-5-git-send-email-manjugk@ti.com>
References: <1299853215-8507-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43832 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab1CKOWT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 09:22:19 -0500
In-Reply-To: <1299853215-8507-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com

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
 arch/arm/plat-omap/dma.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 5cca56b..bb0b7e2 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2059,8 +2059,6 @@ void omap_dma_global_context_save(void)
 	pm_runtime_get_sync(dev);
 	omap_dma_global_context.dma_irqenable_l0 =
 		p->dma_read(IRQENABLE_L0, 0);
-	omap_dma_global_context.dma_ocp_sysconfig =
-		p->dma_read(OCP_SYSCONFIG, 0);
 	omap_dma_global_context.dma_gcr = p->dma_read(GCR, 0);
 	pm_runtime_put_autosuspend(dev);
 }
@@ -2071,17 +2069,12 @@ void omap_dma_global_context_restore(void)
 
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

