From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: sdma: Enable the idle modes on omap4
Date: Tue, 16 Feb 2010 21:11:15 +0530
Message-ID: <1266334896-30686-3-git-send-email-santosh.shilimkar@ti.com>
References: <1266334896-30686-1-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49318 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932765Ab0BPPm2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:42:28 -0500
In-Reply-To: <1266334896-30686-2-git-send-email-santosh.shilimkar@ti.com>
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

