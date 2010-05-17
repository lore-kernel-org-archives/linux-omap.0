From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/6] musb: gadget: fix tx transfer path for mode0 operation
Date: Mon, 17 May 2010 16:38:07 +0530
Message-ID: <1274094488-15925-5-git-send-email-ajay.gupta@ti.com>
References: <1274094488-15925-1-git-send-email-ajay.gupta@ti.com>
 <1274094488-15925-2-git-send-email-ajay.gupta@ti.com>
 <1274094488-15925-3-git-send-email-ajay.gupta@ti.com>
 <1274094488-15925-4-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274094488-15925-4-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Current gadget Tx path always programs DMA in mode-1 if request length
is more than packet size. As system DMA can work only in mode-0 so
updating the DMA mode and transfer length for it.

Also fixed an issue in device Tx completion path where 'is_dma' is
getting set unconditionally. This would fail the io if Tx transfer
is done in mode-0. Fixed it by updating it based on
'request->actual' length.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_gadget.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 6fca870..9ac45e4 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -317,6 +317,22 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			else
 				musb_ep->dma->desired_mode = 1;
 
+			/*
+			 * Use system dma for unaligned buffers on RTL >= 1.8
+			 * for Inventra DMA. As system DMA can work only in
+			 * mode-0 so update the desired_mode and request_size.
+			 */
+			if (is_inventra_dma_enabled() &&
+				((request->dma + request->actual) & 0x3) &&
+				(musb->hwvers >= MUSB_HWVERS_1800)) {
+
+				request_size = min_t(size_t,
+					musb_ep->hw_ep->max_packet_sz_tx,
+					request->length - request->actual);
+
+				musb_ep->dma->desired_mode = 0;
+			}
+
 			use_dma = use_dma && c->channel_program(
 					musb_ep->dma, musb_ep->packet_sz,
 					musb_ep->dma->desired_mode,
@@ -463,7 +479,6 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 		u8	is_dma = 0;
 
 		if (dma && (csr & MUSB_TXCSR_DMAENAB)) {
-			is_dma = 1;
 			csr |= MUSB_TXCSR_P_WZC_BITS;
 			csr &= ~(MUSB_TXCSR_DMAENAB | MUSB_TXCSR_P_UNDERRUN |
 				 MUSB_TXCSR_TXPKTRDY);
@@ -471,6 +486,10 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			/* Ensure writebuffer is empty. */
 			csr = musb_readw(epio, MUSB_TXCSR);
 			request->actual += musb_ep->dma->actual_len;
+
+			if (request->actual == request->length)
+				is_dma = 1;
+
 			DBG(4, "TXCSR%d %04x, DMA off, len %zu, req %p\n",
 				epnum, csr, musb_ep->dma->actual_len, request);
 		}
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
