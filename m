From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [OMAP][sDMA]Fix for possible race condition in omap_free_dma()
Date: Sun, 29 Mar 2009 17:28:57 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A93B8033@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57012 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbZC2L7I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Mar 2009 07:59:08 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2TBwwC3030452
	for <linux-omap@vger.kernel.org>; Sun, 29 Mar 2009 06:59:04 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2TBww4F027783
	for <linux-omap@vger.kernel.org>; Sun, 29 Mar 2009 17:28:58 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>


From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Fix the possible race condition in omap_free_dma(). Function omap_free_dma() 
sets the dev_id = -1 and then accesses the channel afterwards to clear it.
But setting the dev_id=-1 makes the channel available for allocation again.
So it is possible someone else can grab it and results are unpredictable.
To avod this DMA channle is cleared first and then the dev_id = -1 is set.

Thanks to McNeil, Sean <sean.mcneil@ti.com> for ointing out this issue.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dma.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

Index: omapkernel/arch/arm/plat-omap/dma.c
===================================================================
--- omapkernel.orig/arch/arm/plat-omap/dma.c
+++ omapkernel/arch/arm/plat-omap/dma.c
@@ -785,19 +785,12 @@ void omap_free_dma(int lch)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&dma_chan_lock, flags);
 	if (dma_chan[lch].dev_id == -1) {
 		pr_err("omap_dma: trying to free unallocated DMA channel %d\n",
 		       lch);
-		spin_unlock_irqrestore(&dma_chan_lock, flags);
 		return;
 	}
 
-	dma_chan[lch].dev_id = -1;
-	dma_chan[lch].next_lch = -1;
-	dma_chan[lch].callback = NULL;
-	spin_unlock_irqrestore(&dma_chan_lock, flags);
-
 	if (cpu_class_is_omap1()) {
 		/* Disable all DMA interrupts for the channel. */
 		dma_write(0, CICR(lch));
@@ -823,6 +816,12 @@ void omap_free_dma(int lch)
 		dma_write(0, CCR(lch));
 		omap_clear_dma(lch);
 	}
+
+	spin_lock_irqsave(&dma_chan_lock, flags);
+	dma_chan[lch].dev_id = -1;
+	dma_chan[lch].next_lch = -1;
+	dma_chan[lch].callback = NULL;
+	spin_unlock_irqrestore(&dma_chan_lock, flags);
 }
 EXPORT_SYMBOL(omap_free_dma);
 

Regards,
Santosh
