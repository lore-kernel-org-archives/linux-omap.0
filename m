From: Moiz Sonasath <m-sonasath@ti.com>
Subject: [PATCH v5] usb: musb: Enable DMA mode1 RX for BULK endpoints
Date: Fri, 26 Aug 2011 10:54:22 -0500
Message-ID: <1314374062-27548-1-git-send-email-m-sonasath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49965 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556Ab1HZQAZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 12:00:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, balbi@ti.com
Cc: linux-omap@vger.kernel.org, gregkh@suse.de, Anand Gadiyar <gadiyar@ti.com>, Moiz Sonasath <m-sonasath@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

This patch enables the DMA mode1 RX support for endpoints
that use BULK transactions. This will result in a throughput
increase of around 30-40% for BULK transfers
(mass-storage/mtp/ptp usecases)

Tested: Mass-storage, MTP, PTP, ADB, RNDIS gadgets

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 drivers/usb/musb/musb_gadget.c |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 8c41a2e..6841f91 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -624,6 +624,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 /*
  * Context: controller locked, IRQs blocked, endpoint selected
  */
+
 static void rxstate(struct musb *musb, struct musb_request *req)
 {
 	const u8		epnum = req->epnum;
@@ -634,6 +635,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	u16			len;
 	u16			csr = musb_readw(epio, MUSB_RXCSR);
 	struct musb_hw_ep	*hw_ep = &musb->endpoints[epnum];
+	u8			use_mode_1;
 
 	if (hw_ep->is_shared_fifo)
 		musb_ep = &hw_ep->ep_in;
@@ -683,6 +685,16 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 
 	if (csr & MUSB_RXCSR_RXPKTRDY) {
 		len = musb_readw(epio, MUSB_RXCOUNT);
+
+		/*
+		 * Enable DMA Mode 1 RX transfers only for endpoints using BULK transactions
+		 */
+
+		if (musb_ep->type == USB_ENDPOINT_XFER_BULK && len == musb_ep->packet_sz)
+			use_mode_1 = 1;
+		else
+			use_mode_1 = 0;
+
 		if (request->actual < request->length) {
 #ifdef CONFIG_USB_INVENTRA_DMA
 			if (is_buffer_mapped(req)) {
@@ -714,10 +726,11 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	 * then becomes usable as a runtime "use mode 1" hint...
 	 */
 
-				csr |= MUSB_RXCSR_DMAENAB;
-#ifdef USE_MODE1
+		if (use_mode_1) {
 				csr |= MUSB_RXCSR_AUTOCLEAR;
-				/* csr |= MUSB_RXCSR_DMAMODE; */
+				musb_writew(epio, MUSB_RXCSR, csr);
+				csr |= MUSB_RXCSR_DMAENAB;
+				musb_writew(epio, MUSB_RXCSR, csr);
 
 				/* this special sequence (enabling and then
 				 * disabling MUSB_RXCSR_DMAMODE) is required
@@ -725,26 +738,27 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 				 */
 				musb_writew(epio, MUSB_RXCSR,
 					csr | MUSB_RXCSR_DMAMODE);
-#else
+				musb_writew(epio, MUSB_RXCSR, csr);
+
+		} else {
 				if (!musb_ep->hb_mult &&
 					musb_ep->hw_ep->rx_double_buffered)
 					csr |= MUSB_RXCSR_AUTOCLEAR;
-#endif
+				csr |= MUSB_RXCSR_DMAENAB;
 				musb_writew(epio, MUSB_RXCSR, csr);
+		}
 
 				if (request->actual < request->length) {
 					int transfer_size = 0;
-#ifdef USE_MODE1
+		if (use_mode_1) {
 					transfer_size = min(request->length - request->actual,
 							channel->max_len);
-#else
+					musb_ep->dma->desired_mode = 1;
+		} else {
 					transfer_size = min(request->length - request->actual,
 							(unsigned)len);
-#endif
-					if (transfer_size <= musb_ep->packet_sz)
-						musb_ep->dma->desired_mode = 0;
-					else
-						musb_ep->dma->desired_mode = 1;
+					musb_ep->dma->desired_mode = 0;
+		}
 
 					use_dma = c->channel_program(
 							channel,
-- 
1.6.0.4

