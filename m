From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/12] usb: musb: Remove ifdefs for musb_host_rx in musb_host.c part5
Date: Fri,  1 May 2015 12:29:37 -0700
Message-ID: <1430508578-5208-12-git-send-email-tony@atomide.com>
References: <1430508578-5208-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ftx-008-i770.relay.mailchannels.net ([50.61.143.70]:11201 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751504AbbEATaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2015 15:30:10 -0400
In-Reply-To: <1430508578-5208-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Bin Liu <b-liu@ti.com>, George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Remove ifdefs for musb_host_rx to get closer to building in
all the DMA drivers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c | 254 ++++++++++++++++++++++++-------------------
 1 file changed, 140 insertions(+), 114 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index bc671c5..39ebe0b 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1661,6 +1661,122 @@ static int musb_rx_dma_inventra_cppi41(struct dma_controller *dma,
 
 	return done;
 }
+
+/* Disadvantage of using mode 1:
+ *	It's basically usable only for mass storage class; essentially all
+ *	other protocols also terminate transfers on short packets.
+ *
+ * Details:
+ *	An extra IN token is sent at the end of the transfer (due to AUTOREQ)
+ *	If you try to use mode 1 for (transfer_buffer_length - 512), and try
+ *	to use the extra IN token to grab the last packet using mode 0, then
+ *	the problem is that you cannot be sure when the device will send the
+ *	last packet and RxPktRdy set. Sometimes the packet is recd too soon
+ *	such that it gets lost when RxCSR is re-set at the end of the mode 1
+ *	transfer, while sometimes it is recd just a little late so that if you
+ *	try to configure for mode 0 soon after the mode 1 transfer is
+ *	completed, you will find rxcount 0. Okay, so you might think why not
+ *	wait for an interrupt when the pkt is recd. Well, you won't get any!
+ */
+static int musb_rx_dma_in_inventra_cppi41(struct dma_controller *dma,
+					  struct musb_hw_ep *hw_ep,
+					  struct musb_qh *qh,
+					  struct urb *urb,
+					  size_t len,
+					  u8 iso_err)
+{
+	struct musb *musb = hw_ep->musb;
+	void __iomem *epio = hw_ep->regs;
+	struct dma_channel *channel = hw_ep->rx_channel;
+	u16 rx_count, val;
+	int length, pipe, done;
+	dma_addr_t buf;
+
+	rx_count = musb_readw(epio, MUSB_RXCOUNT);
+	pipe = urb->pipe;
+
+	if (usb_pipeisoc(pipe)) {
+		int d_status = 0;
+		struct usb_iso_packet_descriptor *d;
+
+		d = urb->iso_frame_desc + qh->iso_idx;
+
+		if (iso_err) {
+			d_status = -EILSEQ;
+			urb->error_count++;
+		}
+		if (rx_count > d->length) {
+			if (d_status == 0) {
+				d_status = -EOVERFLOW;
+				urb->error_count++;
+			}
+			dev_dbg(musb->controller, "** OVERFLOW %d into %d\n",
+				rx_count, d->length);
+
+			length = d->length;
+		} else
+			length = rx_count;
+		d->status = d_status;
+		buf = urb->transfer_dma + d->offset;
+	} else {
+		length = rx_count;
+		buf = urb->transfer_dma + urb->actual_length;
+	}
+
+	channel->desired_mode = 0;
+#ifdef USE_MODE1
+	/* because of the issue below, mode 1 will
+	 * only rarely behave with correct semantics.
+	 */
+	if ((urb->transfer_flags & URB_SHORT_NOT_OK)
+	    && (urb->transfer_buffer_length - urb->actual_length)
+	    > qh->maxpacket)
+		channel->desired_mode = 1;
+	if (rx_count < hw_ep->max_packet_sz_rx) {
+		length = rx_count;
+		channel->desired_mode = 0;
+	} else {
+		length = urb->transfer_buffer_length;
+	}
+#endif
+
+	/* See comments above on disadvantages of using mode 1 */
+	val = musb_readw(epio, MUSB_RXCSR);
+	val &= ~MUSB_RXCSR_H_REQPKT;
+
+	if (channel->desired_mode == 0)
+		val &= ~MUSB_RXCSR_H_AUTOREQ;
+	else
+		val |= MUSB_RXCSR_H_AUTOREQ;
+	val |= MUSB_RXCSR_DMAENAB;
+
+	/* autoclear shouldn't be set in high bandwidth */
+	if (qh->hb_mult == 1)
+		val |= MUSB_RXCSR_AUTOCLEAR;
+
+	musb_writew(epio, MUSB_RXCSR, MUSB_RXCSR_H_WZC_BITS | val);
+
+	/* REVISIT if when actual_length != 0,
+	 * transfer_buffer_length needs to be
+	 * adjusted first...
+	 */
+	done = dma->channel_program(channel, qh->maxpacket,
+				   channel->desired_mode,
+				   buf, length);
+
+	if (!done) {
+		dma->channel_release(channel);
+		hw_ep->rx_channel = NULL;
+		channel = NULL;
+		val = musb_readw(epio, MUSB_RXCSR);
+		val &= ~(MUSB_RXCSR_DMAENAB
+			 | MUSB_RXCSR_H_AUTOREQ
+			 | MUSB_RXCSR_AUTOCLEAR);
+		musb_writew(epio, MUSB_RXCSR, val);
+	}
+
+	return done;
+}
 #else
 static inline int musb_rx_dma_inventra_cppi41(struct dma_controller *dma,
 					      struct musb_hw_ep *hw_ep,
@@ -1670,6 +1786,16 @@ static inline int musb_rx_dma_inventra_cppi41(struct dma_controller *dma,
 {
 	return false;
 }
+
+static inline int musb_rx_dma_in_inventra_cppi41(struct dma_controller *dma,
+						 struct musb_hw_ep *hw_ep,
+						 struct musb_qh *qh,
+						 struct urb *urb,
+						 size_t len,
+						 u8 iso_err)
+{
+	return false;
+}
 #endif
 
 /*
@@ -1859,121 +1985,21 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		/* we are expecting IN packets */
 		if ((musb_dma_inventra(musb) || musb_dma_ux500(musb) ||
 		    musb_dma_cppi41(musb)) && dma) {
-			struct dma_controller	*c;
-			u16			rx_count;
-			int			ret, length;
-			dma_addr_t		buf;
-
-			rx_count = musb_readw(epio, MUSB_RXCOUNT);
-
-			dev_dbg(musb->controller, "RX%d count %d, buffer 0x%llx len %d/%d\n",
-					epnum, rx_count,
-					(unsigned long long) urb->transfer_dma
-					+ urb->actual_length,
-					qh->offset,
-					urb->transfer_buffer_length);
-
-			c = musb->dma_controller;
-
-			if (usb_pipeisoc(pipe)) {
-				int d_status = 0;
-				struct usb_iso_packet_descriptor *d;
-
-				d = urb->iso_frame_desc + qh->iso_idx;
-
-				if (iso_err) {
-					d_status = -EILSEQ;
-					urb->error_count++;
-				}
-				if (rx_count > d->length) {
-					if (d_status == 0) {
-						d_status = -EOVERFLOW;
-						urb->error_count++;
-					}
-					dev_dbg(musb->controller, "** OVERFLOW %d into %d\n",\
-					    rx_count, d->length);
-
-					length = d->length;
-				} else
-					length = rx_count;
-				d->status = d_status;
-				buf = urb->transfer_dma + d->offset;
-			} else {
-				length = rx_count;
-				buf = urb->transfer_dma +
-						urb->actual_length;
-			}
-
-			dma->desired_mode = 0;
-#ifdef USE_MODE1
-			/* because of the issue below, mode 1 will
-			 * only rarely behave with correct semantics.
-			 */
-			if ((urb->transfer_flags &
-						URB_SHORT_NOT_OK)
-				&& (urb->transfer_buffer_length -
-						urb->actual_length)
-					> qh->maxpacket)
-				dma->desired_mode = 1;
-			if (rx_count < hw_ep->max_packet_sz_rx) {
-				length = rx_count;
-				dma->desired_mode = 0;
-			} else {
-				length = urb->transfer_buffer_length;
-			}
-#endif
-
-/* Disadvantage of using mode 1:
- *	It's basically usable only for mass storage class; essentially all
- *	other protocols also terminate transfers on short packets.
- *
- * Details:
- *	An extra IN token is sent at the end of the transfer (due to AUTOREQ)
- *	If you try to use mode 1 for (transfer_buffer_length - 512), and try
- *	to use the extra IN token to grab the last packet using mode 0, then
- *	the problem is that you cannot be sure when the device will send the
- *	last packet and RxPktRdy set. Sometimes the packet is recd too soon
- *	such that it gets lost when RxCSR is re-set at the end of the mode 1
- *	transfer, while sometimes it is recd just a little late so that if you
- *	try to configure for mode 0 soon after the mode 1 transfer is
- *	completed, you will find rxcount 0. Okay, so you might think why not
- *	wait for an interrupt when the pkt is recd. Well, you won't get any!
- */
-
-			val = musb_readw(epio, MUSB_RXCSR);
-			val &= ~MUSB_RXCSR_H_REQPKT;
-
-			if (dma->desired_mode == 0)
-				val &= ~MUSB_RXCSR_H_AUTOREQ;
+			dev_dbg(hw_ep->musb->controller,
+				"RX%d count %d, buffer 0x%llx len %d/%d\n",
+				epnum, musb_readw(epio, MUSB_RXCOUNT),
+				(unsigned long long) urb->transfer_dma
+				+ urb->actual_length,
+				qh->offset,
+				urb->transfer_buffer_length);
+
+			done = musb_rx_dma_in_inventra_cppi41(c, hw_ep, qh,
+							      urb, xfer_len,
+							      iso_err);
+			if (done)
+				goto finish;
 			else
-				val |= MUSB_RXCSR_H_AUTOREQ;
-			val |= MUSB_RXCSR_DMAENAB;
-
-			/* autoclear shouldn't be set in high bandwidth */
-			if (qh->hb_mult == 1)
-				val |= MUSB_RXCSR_AUTOCLEAR;
-
-			musb_writew(epio, MUSB_RXCSR,
-				MUSB_RXCSR_H_WZC_BITS | val);
-
-			/* REVISIT if when actual_length != 0,
-			 * transfer_buffer_length needs to be
-			 * adjusted first...
-			 */
-			ret = c->channel_program(
-				dma, qh->maxpacket,
-				dma->desired_mode, buf, length);
-
-			if (!ret) {
-				c->channel_release(dma);
-				hw_ep->rx_channel = NULL;
-				dma = NULL;
-				val = musb_readw(epio, MUSB_RXCSR);
-				val &= ~(MUSB_RXCSR_DMAENAB
-					| MUSB_RXCSR_H_AUTOREQ
-					| MUSB_RXCSR_AUTOCLEAR);
-				musb_writew(epio, MUSB_RXCSR, val);
-			}
+				dev_err(musb->controller, "error: rx_dma failed\n");
 		}
 
 		if (!dma) {
-- 
2.1.4

