From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/2] USB: MUSB: sparse fixes to musb_hdrc driver
Date: Fri, 11 Apr 2008 13:59:16 +0300
Message-ID: <1207911557-9392-2-git-send-email-felipe.balbi@nokia.com>
References: <1207911557-9392-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22611 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759183AbYDKLAf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 07:00:35 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3BB06hm021799
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 14:00:32 +0300
In-Reply-To: <1207911557-9392-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Get rid of some sparse warnings in musb_hdrc driver.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_host.c |    6 +++---
 drivers/usb/musb/musbhsdma.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index f9e98d0..64673b7 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1541,7 +1541,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		if (dma) {
 			struct dma_controller	*c;
 			u16			rx_count;
-			int			status;
+			int			ret;
 
 			rx_count = musb_readw(epio, MUSB_RXCOUNT);
 
@@ -1600,7 +1600,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			 * transfer_buffer_length needs to be
 			 * adjusted first...
 			 */
-			status = c->channel_program(
+			ret = c->channel_program(
 				dma, qh->maxpacket,
 				dma->desired_mode,
 				urb->transfer_dma
@@ -1609,7 +1609,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 					? rx_count
 					: urb->transfer_buffer_length);
 
-			if (!status) {
+			if (!ret) {
 				c->channel_release(dma);
 				dma = hw_ep->rx_channel = NULL;
 				/* REVISIT reset CSR */
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 75f084f..32bb1e2 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -172,7 +172,7 @@ static void configure_channel(struct dma_channel *pChannel,
 	struct musb_dma_channel *pImplChannel =
 		(struct musb_dma_channel *) pChannel->private_data;
 	struct musb_dma_controller *controller = pImplChannel->controller;
-	u8 *mbase = controller->pCoreBase;
+	void __iomem *mbase = controller->pCoreBase;
 	u8 bChannel = pImplChannel->bIndex;
 	u16 csr = 0;
 
@@ -250,7 +250,7 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 	struct musb_dma_channel *pImplChannel =
 		(struct musb_dma_channel *) pChannel->private_data;
 	u8 bChannel = pImplChannel->bIndex;
-	u8 *mbase = pImplChannel->controller->pCoreBase;
+	void __iomem *mbase = pImplChannel->controller->pCoreBase;
 	u16 csr;
 
 	if (pChannel->status == MUSB_DMA_STATUS_BUSY) {
@@ -296,7 +296,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 		(struct musb_dma_controller *)private_data;
 	struct musb_dma_channel *pImplChannel;
 	struct musb *musb = controller->pDmaPrivate;
-	u8 *mbase = controller->pCoreBase;
+	void __iomem *mbase = controller->pCoreBase;
 	struct dma_channel *pChannel;
 	u8 bChannel;
 	u16 csr;
-- 
1.5.5.23.g2a5fe

