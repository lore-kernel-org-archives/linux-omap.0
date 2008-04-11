From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 15/23] USB: MUSB: checkpatch.pl fixes to musbhsdma.c
Date: Fri, 11 Apr 2008 11:28:28 +0300
Message-ID: <1207902516-6374-16-git-send-email-felipe.balbi@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26607 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757654AbYDKIaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:13 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TpFA021901
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:10 +0300
In-Reply-To: <1207902516-6374-15-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musbhsdma.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 97fd146..f0ac65d 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -216,7 +216,7 @@ static void configure_channel(struct dma_channel *pChannel,
 		csr);
 }
 
-static int dma_channel_program(struct dma_channel * pChannel,
+static int dma_channel_program(struct dma_channel *pChannel,
 				u16 packet_sz, u8 mode,
 				dma_addr_t dma_addr, u32 len)
 {
@@ -257,22 +257,21 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 		if (pImplChannel->transmit) {
 
 			csr = musb_readw(mbase,
-				MUSB_EP_OFFSET(pImplChannel->epnum,MUSB_TXCSR));
+				MUSB_EP_OFFSET(pImplChannel->epnum, MUSB_TXCSR));
 			csr &= ~(MUSB_TXCSR_AUTOSET |
 				 MUSB_TXCSR_DMAENAB |
 				 MUSB_TXCSR_DMAMODE);
 			musb_writew(mbase,
-				MUSB_EP_OFFSET(pImplChannel->epnum,MUSB_TXCSR),
+				MUSB_EP_OFFSET(pImplChannel->epnum, MUSB_TXCSR),
 				csr);
-		}
-		else {
+		} else {
 			csr = musb_readw(mbase,
-				MUSB_EP_OFFSET(pImplChannel->epnum,MUSB_RXCSR));
+				MUSB_EP_OFFSET(pImplChannel->epnum, MUSB_RXCSR));
 			csr &= ~(MUSB_RXCSR_AUTOCLEAR |
 				 MUSB_RXCSR_DMAENAB |
 				 MUSB_RXCSR_DMAMODE);
 			musb_writew(mbase,
-				MUSB_EP_OFFSET(pImplChannel->epnum,MUSB_RXCSR),
+				MUSB_EP_OFFSET(pImplChannel->epnum, MUSB_RXCSR),
 				csr);
 		}
 
@@ -402,8 +401,8 @@ dma_controller_create(struct musb *musb, void __iomem *pCoreBase)
 		return NULL;
 	}
 
-	if (!(controller = kzalloc(sizeof(struct musb_dma_controller),
-				GFP_KERNEL)))
+	controller = kzalloc(sizeof(struct musb_dma_controller), GPF_KERNEL);
+	if (!controller)
 		return NULL;
 
 	controller->bChannelCount = MUSB_HSDMA_CHANNELS;
-- 
1.5.5.23.g2a5fe

