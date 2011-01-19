From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] OMAP: DMA: clear interrupt status correctly
Date: Wed, 19 Jan 2011 12:24:08 +0200
Message-ID: <4D36BBC8.2000305@nokia.com>
References: <20101130132341.13286.25157.sendpatchset@ahunter-work.research.nokia.com>	<20101130132355.13286.77389.sendpatchset@ahunter-work.research.nokia.com>	<541b3a50479779f3e814aa93d506cbdd@mail.gmail.com>	<20101221202914.GK5829@atomide.com> <4D2440E0.7040008@nokia.com> <87mxnfz2f4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:53031 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab1ASKYi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 05:24:38 -0500
In-Reply-To: <87mxnfz2f4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Manjunath Kondaiah G <manjugk@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


 From fffa19df17d73c1ed2e8c65c0b6604ee1dddff84 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Wed, 24 Nov 2010 13:23:21 +0200
Subject: [PATCH] OMAP: DMA: clear interrupt status correctly

When clearing the DMA channel, clear all status bits.

When handling a DMA interrupt, clear only the interrupt
status bits that have been read and are passed to the
channel's interrupt handler, not every status bit.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
  arch/arm/plat-omap/dma.c |    7 +++----
  1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c4b2b47..8536308 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -53,7 +53,7 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
  #endif
  
  #define OMAP_DMA_ACTIVE			0x01
-#define OMAP2_DMA_CSR_CLEAR_MASK	0xffe
+#define OMAP2_DMA_CSR_CLEAR_MASK	0xffffffff
  
  #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
  
@@ -1873,7 +1873,7 @@ static int omap2_dma_handle_ch(int ch)
  		printk(KERN_INFO "DMA misaligned error with device %d\n",
  		       dma_chan[ch].dev_id);
  
-	p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, ch);
+	p->dma_write(status, CSR, ch);
  	p->dma_write(1 << ch, IRQSTATUS_L0, ch);
  	/* read back the register to flush the write */
  	p->dma_read(IRQSTATUS_L0, ch);
@@ -1893,10 +1893,9 @@ static int omap2_dma_handle_ch(int ch)
  			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
  
  		status = p->dma_read(CSR, ch);
+		p->dma_write(status, CSR, ch);
  	}
  
-	p->dma_write(status, CSR, ch);
-
  	if (likely(dma_chan[ch].callback != NULL))
  		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
  
-- 
1.7.0.4

