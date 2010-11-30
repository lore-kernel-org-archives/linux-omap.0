From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 2/2] OMAP: DMA: clear interrupt status correctly
Date: Tue, 30 Nov 2010 15:23:55 +0200
Message-ID: <20101130132355.13286.77389.sendpatchset@ahunter-work.research.nokia.com>
References: <20101130132341.13286.25157.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:39218 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab0K3NYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 08:24:20 -0500
In-Reply-To: <20101130132341.13286.25157.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <Santosh.shilimkar@ti.com>, Manjunatha GK <manjugk@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

>From 85934ded48552fde84b083575ac2006f1542324b Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Wed, 24 Nov 2010 13:23:21 +0200
Subject: [PATCH 2/2] OMAP: DMA: clear interrupt status correctly

When clearing the DMA channel, clear all status bits.

When handling a DMA interrupt, clear only the interrupt
status bits that have been read and are passed to the
channel's interrupt handler, not every status bit.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/plat-omap/dma.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 6158c99..3300e67 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -49,7 +49,7 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 #endif
 
 #define OMAP_DMA_ACTIVE			0x01
-#define OMAP2_DMA_CSR_CLEAR_MASK	0xffe
+#define OMAP2_DMA_CSR_CLEAR_MASK	0xffffffff
 
 #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
 
@@ -2010,7 +2010,7 @@ static int omap2_dma_handle_ch(int ch)
 		printk(KERN_INFO "DMA misaligned error with device %d\n",
 		       dma_chan[ch].dev_id);
 
-	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));
+	dma_write(status, CSR(ch));
 	dma_write(1 << ch, IRQSTATUS_L0);
 	/* read back the register to flush the write */
 	dma_read(IRQSTATUS_L0);
@@ -2030,10 +2030,9 @@ static int omap2_dma_handle_ch(int ch)
 			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
 
 		status = dma_read(CSR(ch));
+		dma_write(status, CSR(ch));
 	}
 
-	dma_write(status, CSR(ch));
-
 	if (likely(dma_chan[ch].callback != NULL))
 		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
 
-- 
1.7.0.4

