From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] USB: musb: allow unaligned memory data transfers
Date: Tue, 12 Jan 2010 09:42:17 -0600
Message-ID: <1263310937-7249-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57998 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab0ALPiP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 10:38:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, Anand Gadiyar <gadiyar@ti.com>, Maulik Mankad <x0082077@ti.com>, Nilkesh Patra <nilkesh.patra@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

On MUSB:IP rev RTL1.8 and above(OMAP3630, OMAP4),
DMA addresses have to be word aligned.

g-ether gadget passes unaligned buffers to the controller
For such buffers, dma fails and a fall back mechanism of interrupt
mode is used

Validated on Zoom3 with g-ether diver

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Maulik Mankad <x0082077@ti.com>
Cc: Nilkesh Patra <nilkesh.patra@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_gadget.c |    9 ++++++++-
 drivers/usb/musb/musbhsdma.c   |   11 +++++++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index cbcf14a..7ad3571 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -681,8 +681,15 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 							transfer_size);
 				}
 
-				if (use_dma)
+				if (use_dma) {
 					return;
+				} else {
+					/* Need to clear DMAENAB for the
+					 * backup PIO mode transfer to work
+					 */
+					csr &= ~MUSB_RXCSR_DMAENAB;
+					musb_writew(epio, MUSB_RXCSR, csr);
+				}
 			}
 #endif	/* Mentor's DMA */
 
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index a237550..f118ae2 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -166,6 +166,8 @@ static int dma_channel_program(struct dma_channel *channel,
 				dma_addr_t dma_addr, u32 len)
 {
 	struct musb_dma_channel *musb_channel = channel->private_data;
+	struct musb_dma_controller *controller = musb_channel->controller;
+	struct musb *musb = controller->private_data;
 
 	DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
 		musb_channel->epnum,
@@ -175,6 +177,15 @@ static int dma_channel_program(struct dma_channel *channel,
 	BUG_ON(channel->status == MUSB_DMA_STATUS_UNKNOWN ||
 		channel->status == MUSB_DMA_STATUS_BUSY);
 
+	/* On MUSB:RTL1.8 and above, DMA has to be word aligned */
+	if ((dma_addr % 4) &&
+		(musb->hwvers >= MUSB_HWVERS_1800)) {
+		/* Fail DMA for unaligned buffers:
+		 * Use PIO for such buffers
+		 */
+		return false;
+	}
+
 	channel->actual_len = 0;
 	musb_channel->start_addr = dma_addr;
 	musb_channel->len = len;
-- 
1.6.6.rc0.66.ge160d

