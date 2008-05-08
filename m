From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/11] ARM: OMAP: DMA: Fix incorrect channel linking
Date: Thu,  8 May 2008 15:49:28 -0700
Message-ID: <1210286975-29506-5-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
 <1210286975-29506-1-git-send-email-tony@atomide.com>
 <1210286975-29506-2-git-send-email-tony@atomide.com>
 <1210286975-29506-3-git-send-email-tony@atomide.com>
 <1210286975-29506-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:51970 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761332AbYEHWto (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 18:49:44 -0400
In-Reply-To: <1210286975-29506-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>, Tony Lindgren <tony@atomide.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Function enable_lnk does incorrect channel link on non-omap1 builds if chain
is created manually with omap_request_dma and omap_dma_link_lch functions.

Fix this by making sure that next_linked_ch field is initialized to -1 just
in omap_request_dma.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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
1.5.3.6

