From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 12/23] USB: MUSB: checkpatch.pl fixed to musb_host.c
Date: Fri, 11 Apr 2008 11:28:25 +0300
Message-ID: <1207902516-6374-13-git-send-email-felipe.balbi@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40292 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669AbYDKIaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:13 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8WRRo001264
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 03:32:30 -0500
In-Reply-To: <1207902516-6374-12-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_host.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 82e1265..f9e98d0 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -103,7 +103,7 @@
 
 static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, unsigned int nOut,
-			u8 * buf, u32 len);
+			u8 *buf, u32 len);
 
 /*
  * Clear TX fifo. Needed to avoid BABBLE errors.
@@ -210,7 +210,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 			case USB_ENDPOINT_XFER_BULK:	s = "-bulk"; break;
 			case USB_ENDPOINT_XFER_ISOC:	s = "-iso"; break;
 			default:			s = "-intr"; break;
-			}; s;}),
+			}; s; }),
 			epnum, buf, len);
 
 	/* Configure endpoint */
@@ -244,7 +244,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 		} else {
 			qh->frame = urb->start_frame;
 			/* enable SOF interrupt so we can count down */
-DBG(1,"SOF for %d\n", epnum);
+			DBG(1, "SOF for %d\n", epnum);
 #if 1 /* ifndef	CONFIG_ARCH_DAVINCI */
 			musb_writeb(mbase, MUSB_INTRUSBE, 0xff);
 #endif
@@ -439,10 +439,9 @@ static inline u16 musb_h_flush_rxfifo(struct musb_hw_ep *hw_ep, u16 csr)
 	 * leave toggle alone (may not have been saved yet)
 	 */
 	csr |= MUSB_RXCSR_FLUSHFIFO | MUSB_RXCSR_RXPKTRDY;
-	csr &= ~( MUSB_RXCSR_H_REQPKT
+	csr &= ~(MUSB_RXCSR_H_REQPKT
 		| MUSB_RXCSR_H_AUTOREQ
-		| MUSB_RXCSR_AUTOCLEAR
-		);
+		| MUSB_RXCSR_AUTOCLEAR);
 
 	/* write 2x to allow double buffering */
 	musb_writew(hw_ep->regs, MUSB_RXCSR, csr);
@@ -614,7 +613,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
  */
 static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, unsigned int is_out,
-			u8 * buf, u32 len)
+			u8 *buf, u32 len)
 {
 	struct dma_controller	*dma_controller;
 	struct dma_channel	*dma_channel;
@@ -754,7 +753,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			csr &= ~(MUSB_TXCSR_AUTOSET
 				| MUSB_TXCSR_DMAMODE
 				| MUSB_TXCSR_DMAENAB);
-                        csr |= MUSB_TXCSR_MODE;
+			csr |= MUSB_TXCSR_MODE;
 			musb_writew(epio, MUSB_TXCSR,
 				csr | MUSB_TXCSR_MODE);
 
@@ -1270,8 +1269,8 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 			if (qh->segsize < qh->maxpacket)
 				done = true;
 			else if (qh->offset == urb->transfer_buffer_length
-					&& !(urb-> transfer_flags
-							& URB_ZERO_PACKET))
+					&& !(urb->transfer_flags
+						& URB_ZERO_PACKET))
 				done = true;
 			if (!done) {
 				buf = urb->transfer_buffer
@@ -1945,13 +1944,12 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 	} else {
 		musb_h_tx_flush_fifo(ep);
 		csr = musb_readw(epio, MUSB_TXCSR);
-		csr &= ~( MUSB_TXCSR_AUTOSET
+		csr &= ~(MUSB_TXCSR_AUTOSET
 			| MUSB_TXCSR_DMAENAB
 			| MUSB_TXCSR_H_RXSTALL
 			| MUSB_TXCSR_H_NAKTIMEOUT
 			| MUSB_TXCSR_H_ERROR
-			| MUSB_TXCSR_TXPKTRDY
-			);
+			| MUSB_TXCSR_TXPKTRDY);
 		musb_writew(epio, MUSB_TXCSR, csr);
 		/* REVISIT may need to clear FLUSHFIFO ... */
 		musb_writew(epio, MUSB_TXCSR, csr);
@@ -2139,7 +2137,7 @@ static int musb_bus_resume(struct usb_hcd *hcd)
 const struct hc_driver musb_hc_driver = {
 	.description		= "musb-hcd",
 	.product_desc		= "MUSB HDRC host driver",
-	.hcd_priv_size		= sizeof (struct musb),
+	.hcd_priv_size		= sizeof(struct musb),
 	.flags			= HCD_USB2 | HCD_MEMORY,
 
 	/* not using irq handler or reset hooks from usbcore, since
-- 
1.5.5.23.g2a5fe

