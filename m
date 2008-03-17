From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: DMA: Fix incorrect channel linking
Date: Mon, 17 Mar 2008 17:01:10 +0200
Message-ID: <1205766070-16752-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46756 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbYCQPA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 11:00:57 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2HF1tfA008175
	for <linux-omap@vger.kernel.org>; Mon, 17 Mar 2008 10:02:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Function enable_lnk does incorrect channel link on non-omap1 builds if chain
is created manually with omap_request_dma and omap_dma_link_lch functions.

Fix this by making sure that next_linked_ch field is initialized to -1 just
in omap_request_dma.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 7937406..c00eda5 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -604,6 +604,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan->data = data;
 #ifndef CONFIG_ARCH_OMAP1
 	chan->chain_id = -1;
+	chan->next_linked_ch = -1;
 #endif
 	chan->enabled_irqs = OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
 
@@ -1087,7 +1088,6 @@ int omap_request_dma_chain(int dev_id, const char *dev_name,
 			printk(KERN_ERR "omap_dma: Request failed %d\n", err);
 			return err;
 		}
-		dma_chan[channels[i]].next_linked_ch = -1;
 		dma_chan[channels[i]].prev_linked_ch = -1;
 		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
 
-- 
1.5.4.1

