From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix DMA hang after off-idle
Date: Fri, 16 May 2014 14:05:35 -0700
Message-ID: <20140516210535.GC12881@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16640 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbaEPVFk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 17:05:40 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>

Commit 6ddeb6d84459 (dmaengine: omap-dma: move IRQ handling to omap-dma)
added support for handling interrupts in the omap dmaengine driver
instead of the legacy driver. Because of different handling for
interrupts this however caused omap3 to hang eventually after hitting
off-idle.

Any of the virtual 32 DMA channels can be assigned to any of the
four DMA interrupts. So commit 6ddeb6d84459 made the omap dmaengine
driver to use the second DMA interrupt while keeping the legacy code
still using the first DMA interrupt.

This means we need to save and restore both IRQENABLE_L1 in addition
to IRQENABLE_L0. As there is a chance that the DSP might be using
IRQENABLE_L2 or IRQENABLE_L3 lines, let's not touch those until
this has been confirmed. Let's just add a comment to the code for
now.

Fixes: 6ddeb6d84459 (dmaengine: omap-dma: move IRQ handling to omap-dma)
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 5f5b975..b5608b1 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -70,6 +70,7 @@ static u32 errata;
 
 static struct omap_dma_global_context_registers {
 	u32 dma_irqenable_l0;
+	u32 dma_irqenable_l1;
 	u32 dma_ocp_sysconfig;
 	u32 dma_gcr;
 } omap_dma_global_context;
@@ -1973,10 +1974,17 @@ static struct irqaction omap24xx_dma_irq;
 
 /*----------------------------------------------------------------------------*/
 
+/*
+ * Note that we are currently using only IRQENABLE_L0 and L1.
+ * As the DSP may be using IRQENABLE_L2 and L3, let's not
+ * touch those for now.
+ */
 void omap_dma_global_context_save(void)
 {
 	omap_dma_global_context.dma_irqenable_l0 =
 		p->dma_read(IRQENABLE_L0, 0);
+	omap_dma_global_context.dma_irqenable_l1 =
+		p->dma_read(IRQENABLE_L1, 0);
 	omap_dma_global_context.dma_ocp_sysconfig =
 		p->dma_read(OCP_SYSCONFIG, 0);
 	omap_dma_global_context.dma_gcr = p->dma_read(GCR, 0);
@@ -1991,6 +1999,8 @@ void omap_dma_global_context_restore(void)
 		OCP_SYSCONFIG, 0);
 	p->dma_write(omap_dma_global_context.dma_irqenable_l0,
 		IRQENABLE_L0, 0);
+	p->dma_write(omap_dma_global_context.dma_irqenable_l1,
+		IRQENABLE_L1, 0);
 
 	if (IS_DMA_ERRATA(DMA_ROMCODE_BUG))
 		p->dma_write(0x3 , IRQSTATUS_L0, 0);
