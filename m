From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/11] ARM: OMAP: Fix for possible race condition in
	omap_free_dma()
Date: Tue, 14 Apr 2009 14:49:11 -0700
Message-ID: <20090414214911.9878.76642.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61205 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbZDNVtN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 17:49:13 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Fix the possible race condition in omap_free_dma(). Function omap_free_dma()
sets the dev_id = -1 and then accesses the channel afterwards to clear it.
But setting the dev_id=-1 makes the channel available for allocation again.
So it is possible someone else can grab it and results are unpredictable.
To avod this DMA channle is cleared first and then the dev_id = -1 is set.

Thanks to McNeil, Sean <sean.mcneil@ti.com> for ointing out this issue.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 21cc014..7fc8c04 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -760,19 +760,12 @@ void omap_free_dma(int lch)
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
@@ -798,6 +791,12 @@ void omap_free_dma(int lch)
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
 

