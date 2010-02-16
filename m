From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 03/24] omap4: sdma: Enable the idle modes on omap4
Date: Tue, 16 Feb 2010 21:27:54 +0530
Message-ID: <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54339 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757098Ab0BPP7D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:59:03 -0500
In-Reply-To: <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch enables smart-idle idlemodes and autoidle for sDMA
on OMAP4

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 30ff525..5ec96db 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2138,7 +2138,7 @@ static int __init omap_init_dma(void)
 		setup_irq(irq, &omap24xx_dma_irq);
 	}
 
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		/* Enable smartidle idlemodes and autoidle */
 		u32 v = dma_read(OCP_SYSCONFIG);
 		v &= ~(DMA_SYSCONFIG_MIDLEMODE_MASK |
-- 
1.6.0.4

