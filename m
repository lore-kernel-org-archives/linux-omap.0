From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/12] usb: musb: Remove ifdefs for musb_host_rx in musb_host.c part3
Date: Fri,  1 May 2015 12:29:35 -0700
Message-ID: <1430508578-5208-10-git-send-email-tony@atomide.com>
References: <1430508578-5208-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nov-007-i589.relay.mailchannels.net ([46.232.183.143]:60712
	"EHLO relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751418AbbEATgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2015 15:36:06 -0400
In-Reply-To: <1430508578-5208-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Bin Liu <b-liu@ti.com>, George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Remove ifdefs for musb_host_rx to get closer to building in
all the DMA drivers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c | 124 ++++++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 739da2a..e2e7393 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1572,8 +1572,8 @@ static inline int musb_rx_dma_iso_cppi41(struct dma_controller *dma,
 }
 #endif
 
-#ifdef CONFIG_USB_INVENTRA_DMA
-
+#if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_UX500_DMA) || \
+	defined(CONFIG_USB_TI_CPPI41_DMA)
 /* Host side RX (IN) using Mentor DMA works as follows:
 	submit_urb ->
 		- if queue was empty, ProgramEndpoint
@@ -1608,7 +1608,68 @@ static inline int musb_rx_dma_iso_cppi41(struct dma_controller *dma,
  *	thus be a great candidate for using mode 1 ... for all but the
  *	last packet of one URB's transfer.
  */
+static int musb_rx_dma_inventra_cppi41(struct dma_controller *dma,
+				       struct musb_hw_ep *hw_ep,
+				       struct musb_qh *qh,
+				       struct urb *urb,
+				       size_t len)
+{
+	struct dma_channel *channel = hw_ep->rx_channel;
+	void __iomem *epio = hw_ep->regs;
+	u16 val;
+	int pipe;
+	bool done;
+
+	pipe = urb->pipe;
+
+	if (usb_pipeisoc(pipe)) {
+		struct usb_iso_packet_descriptor *d;
+
+		d = urb->iso_frame_desc + qh->iso_idx;
+		d->actual_length = len;
+
+		/* even if there was an error, we did the dma
+		 * for iso_frame_desc->length
+		 */
+		if (d->status != -EILSEQ && d->status != -EOVERFLOW)
+			d->status = 0;
+
+		if (++qh->iso_idx >= urb->number_of_packets) {
+			done = true;
+		} else {
+			/* REVISIT: Why ignore return value here? */
+			if (musb_dma_cppi41(hw_ep->musb))
+				done = musb_rx_dma_iso_cppi41(dma, hw_ep, qh,
+							      urb, len);
+			done = false;
+		}
+
+	} else  {
+		/* done if urb buffer is full or short packet is recd */
+		done = (urb->actual_length + len >=
+			urb->transfer_buffer_length
+			|| channel->actual_len < qh->maxpacket
+			|| channel->rx_packet_done);
+	}
+
+	/* send IN token for next packet, without AUTOREQ */
+	if (!done) {
+		val = musb_readw(epio, MUSB_RXCSR);
+		val |= MUSB_RXCSR_H_REQPKT;
+		musb_writew(epio, MUSB_RXCSR, MUSB_RXCSR_H_WZC_BITS | val);
+	}
 
+	return done;
+}
+#else
+static inline int musb_rx_dma_inventra_cppi41(struct dma_controller *dma,
+					      struct musb_hw_ep *hw_ep,
+					      struct musb_qh *qh,
+					      struct urb *urb,
+					      size_t len)
+{
+	return false;
+}
 #endif
 
 /*
@@ -1619,6 +1680,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 {
 	struct urb		*urb;
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
+	struct dma_controller	*c = musb->dma_controller;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
 	size_t			xfer_len;
@@ -1766,56 +1828,18 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			| MUSB_RXCSR_RXPKTRDY);
 		musb_writew(hw_ep->regs, MUSB_RXCSR, val);
 
-#if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_UX500_DMA) || \
-	defined(CONFIG_USB_TI_CPPI41_DMA)
-		if (usb_pipeisoc(pipe)) {
-			struct usb_iso_packet_descriptor *d;
-
-			d = urb->iso_frame_desc + qh->iso_idx;
-			d->actual_length = xfer_len;
-
-			/* even if there was an error, we did the dma
-			 * for iso_frame_desc->length
-			 */
-			if (d->status != -EILSEQ && d->status != -EOVERFLOW)
-				d->status = 0;
-
-			if (++qh->iso_idx >= urb->number_of_packets) {
-				done = true;
-			} else {
-				struct dma_controller *c = musb->dma_controller;
-
-				/* REVISIT: Why ignore return value here? */
-				if (musb_dma_cppi41(musb))
-					done = musb_rx_dma_iso_cppi41(c, hw_ep,
-								      qh, urb,
-								      xfer_len);
-
-				done = false;
-			}
-
-		} else  {
-			/* done if urb buffer is full or short packet is recd */
-			done = (urb->actual_length + xfer_len >=
-					urb->transfer_buffer_length
-				|| dma->actual_len < qh->maxpacket
-				|| dma->rx_packet_done);
-		}
-
-		/* send IN token for next packet, without AUTOREQ */
-		if (!done) {
-			val |= MUSB_RXCSR_H_REQPKT;
-			musb_writew(epio, MUSB_RXCSR,
-				MUSB_RXCSR_H_WZC_BITS | val);
+		if (musb_dma_inventra(musb) || musb_dma_ux500(musb) ||
+		    musb_dma_cppi41(musb)) {
+			    done = musb_rx_dma_inventra_cppi41(c, hw_ep, qh, urb, xfer_len);
+			    dev_dbg(hw_ep->musb->controller,
+				    "ep %d dma %s, rxcsr %04x, rxcount %d\n",
+				    epnum, done ? "off" : "reset",
+				    musb_readw(epio, MUSB_RXCSR),
+				    musb_readw(epio, MUSB_RXCOUNT));
+		} else {
+			done = true;
 		}
 
-		dev_dbg(musb->controller, "ep %d dma %s, rxcsr %04x, rxcount %d\n", epnum,
-			done ? "off" : "reset",
-			musb_readw(epio, MUSB_RXCSR),
-			musb_readw(epio, MUSB_RXCOUNT));
-#else
-		done = true;
-#endif
 	} else if (urb->status == -EINPROGRESS) {
 		/* if no errors, be sure a packet is ready for unloading */
 		if (unlikely(!(rx_csr & MUSB_RXCSR_RXPKTRDY))) {
-- 
2.1.4

