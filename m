From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/6] ARM: OMAP: Fix DMA CLINK mask, clear spurious interrupt
Date: Thu, 13 Mar 2008 17:45:18 +0200
Message-ID: <1205423119-22292-6-git-send-email-tony@atomide.com>
References: omap-fixes-2008-03-13
 <1205423119-22292-1-git-send-email-tony@atomide.com>
 <1205423119-22292-2-git-send-email-tony@atomide.com>
 <1205423119-22292-3-git-send-email-tony@atomide.com>
 <1205423119-22292-4-git-send-email-tony@atomide.com>
 <1205423119-22292-5-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60751 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbYCMPpu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 11:45:50 -0400
In-Reply-To: <1205423119-22292-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, "Gadiyar, Anand" <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>

From: Gadiyar, Anand <gadiyar@ti.com>

Fix CLINK mask, clear spurious interrupt.

Signed-off-by: Gadiyar, Anand <gadiyar@ti.com>
Signed-off-by: Kevin Hilman <khilman@mvista.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 06293bf..7937406 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1020,12 +1020,12 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
 	}
 
 	w = OMAP_DMA_CLNK_CTRL_REG(lch_head);
-	w &= ~(0x0f);
+	w &= ~(0x1f);
 	w |= lch_queue;
 	OMAP_DMA_CLNK_CTRL_REG(lch_head) = w;
 
 	w = OMAP_DMA_CLNK_CTRL_REG(lch_queue);
-	w &= ~(0x0f);
+	w &= ~(0x1f);
 	w |= (dma_chan[lch_queue].next_linked_ch);
 	OMAP_DMA_CLNK_CTRL_REG(lch_queue) = w;
 }
@@ -1663,6 +1663,7 @@ static int omap2_dma_handle_ch(int ch)
 	if (!status) {
 		if (printk_ratelimit())
 			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n", ch);
+		omap_writel(1 << ch, OMAP_DMA4_IRQSTATUS_L0);
 		return 0;
 	}
 	if (unlikely(dma_chan[ch].dev_id == -1)) {
-- 
1.5.3.6

