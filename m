From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Tue, 19 Jul 2011 01:52:14 -0700
Message-ID: <1311065534-8300-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

This patch enables the DMA mode1 RX support.
This feature is enabled based on the short_not_ok flag passed from
gadget drivers.

This will result in a thruput performance gain of around
40% for USB mass-storage/mtp use cases.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Tested-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
---
v1 - initial push
v2 - fixed whitespace issues as per Sergei Shtylyov<sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> comments
v3 - restor authorship to Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

 drivers/usb/musb/musb_gadget.c |   68 ++++++++++++++++++++++++---------------
 1 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 6aeb363..4a1432e 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -634,6 +634,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	u16			len;
 	u16			csr = musb_readw(epio, MUSB_RXCSR);
 	struct musb_hw_ep	*hw_ep = &musb->endpoints[epnum];
+	u8			use_mode_1;
 
 	if (hw_ep->is_shared_fifo)
 		musb_ep = &hw_ep->ep_in;
@@ -683,6 +684,18 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 
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
@@ -714,37 +727,40 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	 * then becomes usable as a runtime "use mode 1" hint...
 	 */
 
-				csr |= MUSB_RXCSR_DMAENAB;
-#ifdef USE_MODE1
-				csr |= MUSB_RXCSR_AUTOCLEAR;
-				/* csr |= MUSB_RXCSR_DMAMODE; */
-
-				/* this special sequence (enabling and then
-				 * disabling MUSB_RXCSR_DMAMODE) is required
-				 * to get DMAReq to activate
-				 */
-				musb_writew(epio, MUSB_RXCSR,
-					csr | MUSB_RXCSR_DMAMODE);
-#else
-				if (!musb_ep->hb_mult &&
-					musb_ep->hw_ep->rx_double_buffered)
+				/* Experimental: Mode1 works with mass storage use cases */
+				if (use_mode_1) {
 					csr |= MUSB_RXCSR_AUTOCLEAR;
-#endif
-				musb_writew(epio, MUSB_RXCSR, csr);
+					musb_writew(epio, MUSB_RXCSR, csr);
+					csr |= MUSB_RXCSR_DMAENAB;
+					musb_writew(epio, MUSB_RXCSR, csr);
+
+					/* this special sequence (enabling and then
+					* disabling MUSB_RXCSR_DMAMODE) is required
+					* to get DMAReq to activate
+					*/
+					musb_writew(epio, MUSB_RXCSR,
+						csr | MUSB_RXCSR_DMAMODE);
+					musb_writew(epio, MUSB_RXCSR, csr);
+
+				} else {
+					if (!musb_ep->hb_mult &&
+						musb_ep->hw_ep->rx_double_buffered)
+						csr |= MUSB_RXCSR_AUTOCLEAR;
+					csr |= MUSB_RXCSR_DMAENAB;
+					musb_writew(epio, MUSB_RXCSR, csr);
+				}
 
 				if (request->actual < request->length) {
 					int transfer_size = 0;
-#ifdef USE_MODE1
-					transfer_size = min(request->length - request->actual,
-							channel->max_len);
-#else
-					transfer_size = min(request->length - request->actual,
-							(unsigned)len);
-#endif
-					if (transfer_size <= musb_ep->packet_sz)
-						musb_ep->dma->desired_mode = 0;
-					else
+					if (use_mode_1) {
+						transfer_size = min(request->length - request->actual,
+								channel->max_len);
 						musb_ep->dma->desired_mode = 1;
+					} else {
+						transfer_size = min(request->length - request->actual,
+								(unsigned)len);
+						musb_ep->dma->desired_mode = 0;
+					}
 
 					use_dma = c->channel_program(
 							channel,
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
