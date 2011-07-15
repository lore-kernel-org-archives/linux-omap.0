From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Fri, 15 Jul 2011 16:44:49 -0700
Message-ID: <1310773489-19184-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>

This patch enables the DMA mode1 RX support.
This feature is enabled based on the short_not_ok flag passed from
gadget drivers.

This will result in a thruput performance gain of around
40% for USB mass-storage/mtp use cases.

Based on Original work by
Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org> on 2.6.35 kernel

Tested on OMAP4460 Blaze board.

Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_gadget.c |   42 ++++++++++++++++++++++++++++-----------
 1 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 9412410..e643ec2 100644
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
@@ -683,6 +685,18 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 
 	if (csr & MUSB_RXCSR_RXPKTRDY) {
 		len = musb_readw(epio, MUSB_RXCOUNT);
+
+		/*
+		 * Enable Mode 1 for RX transfers only for mass-storage
+		 * use-case, based on short_not_ok flag which is set only
+		 * from file_storage and f_mass_storage drivers
+		 */
+
+		if (request->short_not_ok && len == musb_ep->packet_sz)
+			use_mode_1 = 1;
+		else
+			use_mode_1 = 0;
+
 		if (request->actual < request->length) {
 #ifdef CONFIG_USB_INVENTRA_DMA
 			if (is_buffer_mapped(req)) {
@@ -714,10 +728,13 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	 * then becomes usable as a runtime "use mode 1" hint...
 	 */
 
-				csr |= MUSB_RXCSR_DMAENAB;
-#ifdef USE_MODE1
+	/* Experimental: Mode1 works with mass storage use cases
+	 */
+		if (use_mode_1) {
 				csr |= MUSB_RXCSR_AUTOCLEAR;
-				/* csr |= MUSB_RXCSR_DMAMODE; */
+				musb_writew(epio, MUSB_RXCSR, csr);
+				csr |= MUSB_RXCSR_DMAENAB;
+				musb_writew(epio, MUSB_RXCSR, csr);
 
 				/* this special sequence (enabling and then
 				 * disabling MUSB_RXCSR_DMAMODE) is required
@@ -725,26 +742,27 @@ static void rxstate(struct musb *musb, struct musb_request *req)
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
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
