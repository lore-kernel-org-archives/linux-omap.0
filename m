From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 18/23] USB: MUSB: checkpatch.pl fixes to tusb6010_omap.c
Date: Fri, 11 Apr 2008 11:28:31 +0300
Message-ID: <1207902516-6374-19-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-10-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-11-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-12-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-13-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-14-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-15-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-16-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-17-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-18-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40294 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757813AbYDKIaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:14 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TkB4030754
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 03:32:31 -0500
In-Reply-To: <1207902516-6374-18-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/tusb6010_omap.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 618b1e8..66e146e 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -302,9 +302,9 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	channel->status = MUSB_DMA_STATUS_BUSY;
 
 	/* Since we're recycling dma areas, we need to clean or invalidate */
-	if (chdat->tx) {
+	if (chdat->tx)
 		dma_cache_maint(phys_to_virt(dma_addr), len, DMA_TO_DEVICE);
-	} else
+	else
 		dma_cache_maint(phys_to_virt(dma_addr), len, DMA_FROM_DEVICE);
 
 	/* Use 16-bit transfer if dma_addr is not 32-bit aligned */
@@ -336,7 +336,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 		dma_params.dst_amode	= OMAP_DMA_AMODE_DOUBLE_IDX;
 		dma_params.dst_start	= (unsigned long)fifo;
 		dma_params.dst_ei	= 1;
-		dma_params.dst_fi	= -31;		/* Loop 32 byte window */
+		dma_params.dst_fi	= -31;	/* Loop 32 byte window */
 
 		dma_params.trigger	= sync_dev;
 		dma_params.sync_mode	= OMAP_DMA_SYNC_FRAME;
@@ -348,7 +348,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 		dma_params.src_amode	= OMAP_DMA_AMODE_DOUBLE_IDX;
 		dma_params.src_start	= (unsigned long)fifo;
 		dma_params.src_ei	= 1;
-		dma_params.src_fi	= -31;		/* Loop 32 byte window */
+		dma_params.src_fi	= -31;	/* Loop 32 byte window */
 
 		dma_params.dst_amode	= OMAP_DMA_AMODE_POST_INC;
 		dma_params.dst_start	= (unsigned long)dma_addr;
@@ -581,7 +581,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 	DBG(3, "ep%i %s dma: %s dma%i dmareq%i sync%i\n",
 		chdat->epnum,
 		chdat->tx ? "tx" : "rx",
-		chdat->ch >=0 ? "dedicated" : "shared",
+		chdat->ch >= 0 ? "dedicated" : "shared",
 		chdat->ch >= 0 ? chdat->ch : tusb_dma->ch,
 		chdat->dmareq >= 0 ? chdat->dmareq : tusb_dma->dmareq,
 		chdat->sync_dev >= 0 ? chdat->sync_dev : tusb_dma->sync_dev);
@@ -643,8 +643,7 @@ void dma_controller_destroy(struct dma_controller *c)
 	for (i = 0; i < MAX_DMAREQ; i++) {
 		struct dma_channel *ch = dma_channel_pool[i];
 		if (ch) {
-			if (ch->private_data)
-				kfree(ch->private_data);
+			kfree(ch->private_data);
 			kfree(ch);
 		}
 	}
-- 
1.5.5.23.g2a5fe

